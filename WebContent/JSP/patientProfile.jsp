<%@page import="com.dao.DAOController"%>
<%@page import="com.Model.PatientModel"%>
<%@page import="com.dao.DataValidation"%>
<%@page import="com.xml.EncryptUtils"%>
<%@page import="com.Model.serverInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.xml.XMLParser"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<%
	//String str = DataValidation.escapeStringForHTML(request.getParameter("data"));
	int patientID = Integer.parseInt(request.getParameter("submit"));
	String titleString = "";
	PatientModel pm = null;
	int admin = 0;
	if (session.getAttribute("isAuthenticated") == null) {
		response.sendRedirect(request.getContextPath() + "/sessionExpired");
		return;
	} else {
		admin = Integer.parseInt(session.getAttribute("admin").toString());
		pm = new PatientModel();
		DAOController dao = new DAOController();
		pm = dao.getPatientByID(patientID);
	}
	if (patientID == 0) {
		response.sendError(404);
	}
%>

<title><%=titleString%></title>
<link href="${pageContext.request.contextPath}/CSS/load.css"
	rel="stylesheet"></link>
<link
	href="${pageContext.request.contextPath}/Extra/vendors/jquery/dist/jquery-ui.css"
	rel="stylesheet"></link>
<!-- Datatables -->
<link
	href="${pageContext.request.contextPath}/Extra/vendors/datatables.net-bs/css/dataTables.bootstrap.min.css"
	rel="stylesheet">
<!-- Bootstrap -->
<link
	href="${pageContext.request.contextPath}/Extra/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link
	href="${pageContext.request.contextPath}/Extra/vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link
	href="${pageContext.request.contextPath}/Extra/vendors/nprogress/nprogress.css"
	rel="stylesheet">
<!-- Custom Theme Style -->
<link
	href="${pageContext.request.contextPath}/Extra/build/css/custom.min.css"
	rel="stylesheet">
</head>
<style>
.modal-dialog {
	width: 75%;
	overflow: auto;
}
</style>
<body>

	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_content">
					<div class="row">
						<div class="col-md-3 col-sm-3 col-xs-12 profile_left">
							<div class="profile_img">
								<div id="crop-avatar">
									<!-- Current avatar -->
									<img class="img-responsive avatar-view"
										src="${pageContext.request.contextPath}/Extra/images/picture.jpg"
										alt="Avatar" title="Change the avatar">
								</div>
							</div>
						</div>
						<div class="col-md-3 col-sm-3 col-xs-12">
							<h3><%=pm.getFname() + " " + pm.getLname()%></h3>
							<ul class="list-unstyled user_data">
								<li><i class="fa fa-map-marker user-profile-icon"></i>
									Windsor, ON, Canada</li>

								<li><i class="fa fa-envelope user-profile-icon"></i> <%=pm.getEmail()%></li>
								<li><i class="fa fa-phone user-profile-icon"></i> <%=pm.getContactno()%></li>
							</ul>
						</div>
						<div class="col-md-6 col-sm-6 col-xs-12">
							<div class="profile_title">
								<div class="col-md-6">
									<h2>User Demographics</h2>
								</div>
							</div>
							<div class="col-md-9 col-sm-9 col-xs-12">
								<ul class="list-unstyled user_data">
									<input type="hidden" id="patientID" value=<%=pm.getId()%>>
									<li>Name: <%=pm.getFname() + " " + pm.getLname()%></li>
									<li>Gender: <%=pm.getGender()%></li>
									<li>Date of Birth: <%=pm.getDob()%></li>
									<li>Age: <%=pm.getAge()%></li>
									<li>Weight: <%=pm.getWeight()%></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="profile_title">
								<div class="col-md-6">
									<h2>Medical Reports</h2>
								</div>
								<div class="col-md-6" align="right">
									<button class="btn btn-primary" target="mainFrame"
										value="createPatientNote"
										onclick="document.location.href='/MDS/JSP/createMedicalNote.jsp?submit=<%=pm.getId()%>'">Add
										Patient Note</button>
								</div>
							</div>

							<div id="notesTable" class="table-responsive">
								<table id="noteData"
									class="table table-striped table-bordered"
									style="font-size: 14px"></table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="divLoading"></div>
	</div>

	<!-- jQuery -->
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/jquery/dist/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/jquery/dist/jquery-ui.js"></script>
	<!-- Bootstrap -->
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/nprogress/nprogress.js"></script>
	<!-- Chart.js -->
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/datatables.net/js/jquery.dataTables.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/jszip/dist/jszip.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/pdfmake/build/pdfmake.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/pdfmake/build/vfs_fonts.js"></script>
	<!-- Custom Theme Scripts -->
	<script src="${pageContext.request.contextPath}/js/loadTable.js"></script>
	<script src="${pageContext.request.contextPath}/js/util.js"></script>
	<%-- <script
		src="${pageContext.request.contextPath}/Extra/vendors/moment/min/moment.min.js"></script> --%>
</body>
</html>