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
	href="${pageContext.request.contextPath}/Extra/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/Extra/vendors/datatables.net-bs/css/dataTables.bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/Extra/vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/Extra/vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/Extra/vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/Extra/vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css"
	rel="stylesheet">


<link
	href="${pageContext.request.contextPath}/Extra/vendors/jQuery-Smart-Wizard/dist/css/smart_wizard.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/Extra/vendors/jQuery-Smart-Wizard/dist/css/smart_wizard_theme_dots.css"
	rel="stylesheet" type="text/css" />
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
							<input type="hidden" id="patientID" value=<%=pm.getId()%>>
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
									<li>Name: <%=pm.getFname() + " " + pm.getLname()%></li>
									<li id="gender" value=<%=pm.getGender()%>>Gender: <%=pm.getGender()%></li>
									<li id="dob" value=<%=pm.getDob()%>>Date of Birth: <%=pm.getDob()%></li>
									<li id="age">Age: <%=pm.getAge()%></li>
									<li>Weight: <%=pm.getWeight()%></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="profile_title">
								<div class="col-md-6">
									<h2>
										Report ID : #<span id="reportID"><%=DAOController.generateReportID(pm.getLname())%></span>
									</h2>
								</div>
							</div>
						</div>
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>Diagnostic Wizards</h2>
									<ul class="nav navbar-right panel_toolbox">
										<li><a class="collapse-link"><i
												class="fa fa-chevron-up"></i></a></li>
										<li><a class="close-link"><i class="fa fa-close"></i></a>
										</li>
									</ul>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<!-- Smart Wizard -->
									<p>This is a basic diagnostic wizard.</p>
									<div id="smartwizard">
										<ul>
											<li><a href="#step-1">Step 1<br /> <small>Symptoms
														Selector</small></a></li>
											<li><a href="#step-2">Step 2<br /> <small>Symptoms</small></a></li>
											<li><a href="#step-3">Step 3<br /> <small>Diagnosis</small></a></li>
											<li><a href="#step-4">Step 4<br /> <small>Prescription</small></a></li>
										</ul>

										<div>
											<div id="step-1" class="">
												<h2 class="border-bottom border-gray pb-2">Symptoms
													Selector</h2>
												<form class="form-horizontal form-label-left">
													<div class="form-group">
														<label class="control-label col-md-3 col-sm-3 col-xs-12"
															for="bodylocation">Body Location <span
															class="required">*</span>
														</label>
														<div class="col-md-6 col-sm-6 col-xs-12">
															<select required="required" id="bodylocation"
																name="bodylocation"
																class="form-control col-md-7 col-xs-12">
															</select>
														</div>
													</div>
													<div class="form-group">
														<label class="control-label col-md-3 col-sm-3 col-xs-12"
															for="subbodylocation">Sub Location <span
															class="required">*</span>
														</label>
														<div class="col-md-6 col-sm-6 col-xs-12">
															<select required="required" id="subbodylocation"
																name="subbodylocation"
																class="form-control col-md-7 col-xs-12">
															</select>
														</div>
													</div>
													<div class="form-group">
														<label class="control-label col-md-3 col-sm-3 col-xs-12"
															for="bodylocation">Symptoms <span
															class="required">*</span>
														</label>
														<div class="col-md-6 col-sm-6 col-xs-12">
															<select multiple required="required" id="symptoms"
																name="symptoms" class="form-control col-md-7 col-xs-12">
															</select>
														</div>
													</div>
												</form>
											</div>
											<div id="step-2" class="">
												<h2 class="border-bottom border-graypb-2">Symptoms</h2>
												<div align="center" class="col-md-12 col-sm-12 col-xs-12">
													<ul id="symptomList" class="list-unstyled user_data">

													</ul>
												</div>
											</div>
											<div id="step-3" class="">
												<div id="patientTable" class="table-responsive">
													<table id="diagnosisData"
														class="table table-striped table-bordered" style="font-size: 14px"></table>
												</div>
											</div>
											<div id="step-4" class="">
												<h2 class="border-bottom border-gray pb-2">Prescription</h2>
												<div id="drugTable" class="table-responsive">
													<table id="drugData"
														class="table table-striped table-bordered" style="font-size: 12px"></table>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="divLoading"></div>

	<!-- jQuery -->
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/jquery/dist/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/jquery/dist/jquery-ui.js"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/bootstrap/dist/js/bootstrap.min.js"
		type="text/javascript"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/datatables.net/js/jquery.dataTables.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>

	<script
		src="${pageContext.request.contextPath}/Extra/vendors/fastclick/lib/fastclick.js"
		type="text/javascript"></script>
	<!-- Bootstrap -->
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/nprogress/nprogress.js"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/jQuery-Smart-Wizard/dist/js/jquery.smartWizard.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/pdfmake/build/vfs_fonts.js"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/vendors/moment/min/moment.min.js"
		type="text/javascript"></script>
	<script
		src="${pageContext.request.contextPath}/Extra/build/js/custom.min.js"
		type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/js/MedicalNotes.js"></script>
	<script src="${pageContext.request.contextPath}/js/util.js"></script>
	<script
		src="https://ajax.cloudflare.com/cdn-cgi/scripts/95c75768/cloudflare-static/rocket-loader.min.js"
		data-cf-settings="737b93b989ec0a3f0975ee67-|49" defer=""></script>
</body>
</html>