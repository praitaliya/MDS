<%@page import="com.Model.DrugModel"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.Preaid.Diagnosis.Model.HealthDiagnosis"%>
<%@page import="com.Preaid.Diagnosis.Model.HealthSymptomSelector"%>
<%@page import="com.Preaid.Diagnosis.Client.DiagnosisClient"%>
<%@page import="com.Preaid.Diagnosis.Client.DiagnosisObject"%>
<%@page import="com.Preaid.Diagnosis.Model.HealthItem"%>
<%@page import="com.Model.PatientModel"%>
<%@page import="com.dao.TrolleyLogs"%>
<%@page import="java.util.Base64"%>
<%@page import="com.xml.EncryptUtils"%>
<%@page import="com.dao.DataConverter"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.DAOController"%>
<%@page import="java.util.Map"%>
<%@page import="com.Model.serverInfo"%>
<%@page import="com.xml.XMLParser"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	DAOController dao = new DAOController();
	DataConverter dc = new DataConverter();
	int admin = 0;
	String str = request.getParameter("submit");
	if (str == null) {
		response.sendError(404);
	}
	if (session.getAttribute("isAuthenticated") == null) {
		//response.sendRedirect(request.getContextPath() + "/sessionExpired");
		//return;
	} else {
		try {
			admin = Integer.parseInt(session.getAttribute("admin").toString());
		} catch (Exception e) {
			TrolleyLogs.AppendToLog(e);
		}
	}
	/* if(!(session.getAttribute("ability").toString().equalsIgnoreCase("All")) && !(session.getAttribute("ability").toString().equalsIgnoreCase(request.getParameter("server")))){
		System.out.println("Server : " + request.getParameter("server"));
		System.out.println("Invalid Access");
		response.sendError(403);
	} */
	if (str.equalsIgnoreCase("getPatientData")) {

		ArrayList<PatientModel> patientData = dao.getPatientData();
		String tableData = dc.getPatientTable(patientData);
		response.setContentType("text/html");
		response.getWriter().write(EncryptUtils.base64encode(tableData));
	} else if (str.equalsIgnoreCase("getBodyLocation")) {
		List<HealthItem> bodyLocation = dao.loadBodyLocation();
		String selectData = dc.getStringOptions(bodyLocation);
		response.setContentType("text/html");
		response.getWriter().write(EncryptUtils.base64encode(selectData));
	} else if (str.equalsIgnoreCase("getBodySubLocation")) {
		int bodyLocationID = Integer.parseInt(request.getParameter("bodyLocation"));
		List<HealthItem> bodySubLocation = dao.loadBodySubLocation(bodyLocationID);
		String selectData = dc.getStringOptions(bodySubLocation);
		response.setContentType("text/html");
		response.getWriter().write(EncryptUtils.base64encode(selectData));
	} else if (str.equalsIgnoreCase("getSymptoms")) {
		int bodyLocationID = Integer.parseInt(request.getParameter("bodySubLocation"));
		String gender = request.getParameter("gender");
		List<HealthSymptomSelector> diagnosis = dao.loadSymptoms(bodyLocationID, gender);
		String selectData = dc.getSymptoms(diagnosis);
		response.setContentType("text/html");
		response.getWriter().write(EncryptUtils.base64encode(selectData));
	} else if(str.equalsIgnoreCase("getDiagnosis")){
		String tableData = "";
		try{
		String gender = request.getParameter("gender");
		int dobYear = Integer.parseInt(request.getParameter("dob"));
		String symptoms = request.getParameter("symptoms");
		List<HealthDiagnosis> diagnosis = dao.getDiagnosis(symptoms, gender, dobYear);
		tableData = dc.getDiagnosisTable(diagnosis);
		}catch(Exception e){
			e.printStackTrace();
		}
		response.setContentType("text/html");
		response.getWriter().write(EncryptUtils.base64encode(tableData));
	}else if(str.equalsIgnoreCase("loadDrugs")){
		String disease = request.getParameter("disease");
		HashSet<DrugModel> data = dao.getDrugData(disease);
		String drugTable = dc.getDrugTable(data);
		response.setContentType("text/html");
		response.getWriter().write(EncryptUtils.base64encode(drugTable));
	}else if(str.equalsIgnoreCase("notesData")){
		int patientID = Integer.parseInt(request.getParameter("patientID"));
		ArrayList<String> data = dao.getNotes(patientID);
		String tableData = dc.getNotesTable(data);
		response.setContentType("text/html");
		response.getWriter().write(EncryptUtils.base64encode(tableData));
	}
	else {
		response.sendError(403);
	}
%>