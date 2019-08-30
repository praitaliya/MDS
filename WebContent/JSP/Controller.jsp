<%@page import="com.dao.Utils"%>
<%@page import="com.Model.PatientModel"%>
<%@page import="com.dao.TrolleyLogs"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.xml.EncryptUtils"%>
<%@page import="com.dao.DAOController"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.Model.transactionMaster"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.Model.transactionModel"%>
<%
	DAOController dao = null;
	String str = request.getParameter("submit");
	if (str == null) {
		response.sendError(404);
	} else if (str.equalsIgnoreCase("createPatient")) {
		try {
			PatientModel patient = new PatientModel();
			String status = "";
			String requestData[] = EncryptUtils.base64decode(request.getParameter("data")).split(",");
			String fname = requestData[0];
			String lname = requestData[1];
			String email = requestData[2];
			String phone = requestData[3];
			String dob = requestData[4];
			String gender = requestData[5];
			int weight = Integer.parseInt(requestData[6]);
			patient.setFname(fname);
			patient.setLname(lname);
			patient.setEmail(email);
			patient.setContactno(phone);
			patient.setDob(dob);
			patient.setGender(gender);
			patient.setWeight(weight);
			patient.setAge(Utils.getAge(dob));
			String createdBy = session.getAttribute("Name").toString();
			dao = new DAOController();
			int validateUser = dao.validatePatient(patient);
			System.out.println("User : " + validateUser);
			if(validateUser == 0){
				status = dao.createPatient(patient);
			}else{
				status = EncryptUtils.base64encode("Error");
			}
			Gson g = new Gson();
			response.setContentType("application/json");
			response.getWriter().write(g.toJson(status));
		} catch (Exception e) {
			TrolleyLogs.AppendToLog(e);
		}
	}else if(str.equalsIgnoreCase("submitData")){
		try{
		String data = request.getParameter("data");
		System.out.print("Data : "  + data);
		String param[] = data.split(" @ ");
		String patientID = param[0];
		String noteID = param[1];
		String bodyLocation = param[2];
		String subLocation = param[3];
		String disease = param[4];
		String diagnosis = param[5];
		String drug = param[6];
		
		dao = new DAOController();
		int status = dao.saveNote(patientID, noteID, bodyLocation, subLocation, disease, diagnosis, drug);
		String res = "";
		if(status == 1){
			res = "Ok";
		}
		response.setContentType("text/html");
		response.getWriter().write(res);
		}catch(Exception e){
			e.printStackTrace();
			TrolleyLogs.AppendToLog(e);
		}
	}
	/*{
		dao = new DAOController();
		HashMap<Integer, String> status = new HashMap<Integer, String>();
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String tr_ID = request.getParameter("trolleyID");
		int isValidTrolley = dao.validateTrolley(tr_ID);
		if (isValidTrolley == 0) {
			int i = dao.updateTrolley(tr_ID);
			if (i == 1) {
				CustomerModel cm = new CustomerModel();
				cm.setFname(fname);
				cm.setLname(lname);
				cm.setTrolley_id(tr_ID);
				cm.setTimeStamp(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date()));
				int j = dao.insertCustomer(cm);
				if (j > 0) {
					status.put(1, "Success");
				}
			} else {
				status.put(0, "Something Went Wrong");
			}
		} else if (isValidTrolley == 1) {
			status.put(2, "Trolley is already in use, Please enter valid trolley id.");
		} else {
			status.put(0, "Something Went Wrong");
		}
		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());
	}else if(str.equalsIgnoreCase("generateBill")){
		dao = new DAOController();
		HashMap<Integer,String> status = new HashMap<Integer,String>();
		String trolleyID =  request.getParameter("trolleyID");
		int i = dao.billGenerate(trolleyID);
		if(i==1){
			status.put(i, "Success");
			System.out.println("Success");
		}else if(i==505){
			status.put(i, "Wrong Trolley ID");
		}
		else{
			status.put(i, "Something went wrong");
		}
		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());
	}else if(str.equalsIgnoreCase("getItemListFromTrolley")){
		dao = new DAOController();
		String trolleyID = request.getParameter("trolleyID");
		long tr_id = dao.getTransactionID(trolleyID);
		ArrayList<itemModel> data = dao.getitemDetailsByTrolley(tr_id);
		HashMap<Integer,HashMap<String,String>> res = new HashMap<Integer,HashMap<String,String>>();
		for(itemModel i : data){
			HashMap<String,String> itemData = new HashMap<String,String>();
			itemData.put("itemName", i.getItemDetailsModel().getItemCategory().getItemName());
			itemData.put("price", Double.toString(i.getItemDetailsModel().getItemCategory().getPrice()));
			res.put(i.getItem_ID(), itemData);
		} 
		response.setContentType("application/json");
		new Gson().toJson(res, response.getWriter());
		
	}
	else if (str.equalsIgnoreCase("fromRFIDReader")) {
		dao = new DAOController();
		System.out.println("new Request");
		transactionModel tm = new transactionModel();
		String trolleyID = request.getParameter("trolleyID");
		String rfid = request.getParameter("rfid");
		String status = dao.newRFIDRequest(trolleyID, rfid);
		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());
	} else if (str.equalsIgnoreCase("billingMaster")) {
		System.out.println("AJAX success");
		dao = new DAOController();
		int id = Integer.parseInt(request.getParameter("trID"));
		System.out.println(id);
		ArrayList<String> data = dao.getTransactionData(id);
		response.setContentType("application/json");
		new Gson().toJson(data, response.getWriter());
	} else if (str.equalsIgnoreCase("editDiscountData")) {
		dao = new DAOController();
		String data[] = EncryptUtils.base64decode(request.getParameter("data")).split(",");
		discountModel dm = new discountModel();
		dm.setDiscountID(Integer.parseInt(data[0]));
		dm.setDiscontDescription(data[1]);
		dm.setDiscount(Double.parseDouble(data[2]));
		int i = dao.updateDiscountDetails(dm);
		response.setContentType("application/json");
		new Gson().toJson(i, response.getWriter());
	} else if (str.equalsIgnoreCase("editTaxData")) {
		dao = new DAOController();
		String data[] = EncryptUtils.base64decode(request.getParameter("data")).split(",");
		itemTaxPlanModel tm = new itemTaxPlanModel();
		tm.settaxPlanId(Integer.parseInt(data[0]));
		tm.settaxPlanName(data[1]);
		tm.settaxPercentage(Double.parseDouble(data[2]));
		int i = dao.updateTaxDetails(tm);
		response.setContentType("application/json");
		new Gson().toJson(i, response.getWriter());
	} else if (str.equalsIgnoreCase("editCatData")) {
		dao = new DAOController();
		String data[] = EncryptUtils.base64decode(request.getParameter("data")).split(",");
		itemCategoryModel icm = new itemCategoryModel();
		icm.setCatID(Integer.parseInt(data[0]));
		icm.setItemName(data[1]);
		icm.setItemDesc(data[2]);
		icm.setPrice(Double.parseDouble(data[3]));
		int i = dao.updateCatDetails(icm);
		response.setContentType("application/json");
		new Gson().toJson(i, response.getWriter());
	} */ 

	else {
		response.sendError(404);
	}
%>