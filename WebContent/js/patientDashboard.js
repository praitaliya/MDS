$(document).ready(function() {
	loadTableData();
});
function loadTableData() {
	$.ajax({
		url : "/MDS/JSP/getTableData.jsp",
		type : "POST",
		data : {
			submit : "getPatientData",
		},
		dataType : "text",
		cache : false,
		beforeSend : function() {
			$("div#divLoading").addClass('show');
			NProgress.start();
		},
		complete : function() {
			$("div#divLoading").removeClass('show');
			NProgress.done();
		},
		success : function(data) {
			if ($.fn.dataTable.isDataTable("#patientData")) {
				$("#patientData").DataTable().destroy();
			}
			$("#patientData").html(Base64.decode(data));
			var table = $("#patientData").DataTable({
				"destroy" : false,
				dom : 'Bfrtip',
				buttons : [ 'copy', 'csv', 'excel', 'pdf', 'print' ]
			});

		},
		error : function() {
			alert("Something went wrong! Please try again.");
			res = "500";
		}
	});
}
function addPatient(){
	var str = "";
	/* var url = "/MSG-DB/JSP/getStatusCountTableData.jsp?data=" + data */;
	str += "<form id=\"\" method=\"post\" class=\"form-horizontal\">";
	str += "<div class=\"form-group\">";
	str += "<label class=\"control-label col-md-2 col-sm-2 col-xs-12\">First Name <span class=\"required\">*</span></label>";
	str += "<div class=\"col-md-4 col-sm-4 col-xs-12\"><input id=\"firstname\" class=\"form-control col-md-7 col-xs-12\" placeholder=\"e.g Tonny\" type=\"text\"></div>";
	str += "<label class=\"control-label col-md-2 col-sm-2 col-xs-12\">Last Name <span class=\"required\">*</span></label>";
	str += "<div class=\"col-md-4 col-sm-4 col-xs-12\"><input id=\"lastname\" class=\"form-control col-md-7 col-xs-12\" placeholder=\"e.g Stark\" type=\"text\"></div></div>";
	str += "<div class=\"form-group\">";
	str += "<label class=\"control-label col-md-2 col-sm-2 col-xs-12\">Email <span class=\"required\">*</span></label>";
	str += "<div class=\"col-md-10 col-sm-10 col-xs-12\"><input type=\"text\" id=\"email\" class=\"form-control col-md-10 col-xs-12\"  placeholder=\"e.g tonny.stark@eclinicalworks.com\"></div></div>";
	str += "<div class=\"form-group\">";
	str += "<label class=\"control-label col-md-2 col-sm-2 col-xs-12\">Phone <span class=\"required\">*</span></label>";
	str += "<div class=\"col-md-4 col-sm-4 col-xs-12\"><input type=\"text\" id=\"phone\" class=\"form-control col-md-10 col-xs-12\"  placeholder=\"e.g 123-456-7890\"></div>";
	str += "<label class=\"control-label col-md-2 col-sm-2 col-xs-12\">Gender * </label>";
	str += "<div class=\"col-md-4 col-sm-4 col-xs-12\">";
	str += "<select id=\"gender\" class=\"form-control col-md-4 col-xs-12\">";
	str += "<option value=\"0\">- - - - - Select - - - - -</option>";
	str += "<option value=\"M\">Male</option>";
	str += "<option value=\"F\">Female</option>";
	str += "<option value=\"U\">Unknown</option>";
	str += "</select></div></div>";
	str += "<div class=\"form-group\">";
	str += "<label class=\"control-label col-md-2 col-sm-2 col-xs-12\">DOB <span class=\"required\">*</span></label>";
	str += "<div class=\"col-md-4 col-sm-4 col-xs-12\"><input type=\"date\" id=\"dob\" class=\"form-control col-md-10 col-xs-12\"  placeholder=\"e.g mm/dd/yyyy\"></div>";
	str += "<label class=\"control-label col-md-2 col-sm-2 col-xs-12\">Weight (KG) <span class=\"required\">*</span></label>";
	str += "<div class=\"col-md-4 col-sm-4 col-xs-12\"><input type=\"text\" id=\"weight\" class=\"form-control col-md-10 col-xs-12\"  placeholder=\"e.g 50 Kg.\"></div></div>";
	str += "</div><div class=\"col-md-12 col-sm-12 col-xs-12\">";
    str += "<label class=\"col-xs-12 control-label\" id=\"newpasstab\" readonly=\"readonly\" style=\"text-align: center;\"></label>";
    str += "</div></form>";

	BootstrapDialog.show({
		title: 'Add Patient',
		message: $('<div></div>').html(str),
        buttons: [{
            icon: 'glyphicon glyphicon-send',
            label: 'Submit',
            cssClass: 'btn-primary',
            action: function(dialogRef){
            	var fname = $("#firstname").val();
            	var lname = $("#lastname").val();
            	var email = $("#email").val();
            	var phone = $("#phone").val();
            	var gender = $("#gender").val();
            	var dob = $("#dob").val();
            	var weight = $("#weight").val();
            	if(fname == ""){
            		$("#firstname").css('border', '1px solid red');
            		$("#firstname").css('background-color', 'pink');
            		return false;
            	}
            	else{
            		$("#firstname").css('background-color', 'white');
            		$("#firstname").css('border', '1px solid green');
            	}
            	if(lname == ""){
            		$("#lastname").css('border', '1px solid red');
            		$("#lastname").css('background-color', 'pink');
            		return false;
            	}
            	else{
            		$("#lastname").css('background-color', 'white');
            		$("#lastname").css('border', '1px solid green');
            	}
            	if(email == ""){
            		$("#email").css('border', '1px solid red');
            		$("#email").css('background-color', 'pink');
            		return false;
            	}
            	else{
            		$("#email").css('background-color', 'white');
            		$("#email").css('border', '1px solid green');
            	}
            	if(phone == ""){
            		$("#phone").css('border', '1px solid red');
            		$("#phone").css('background-color', 'pink');
            		return false;
            	}
            	else{
            		$("#phone").css('background-color', 'white');
            		$("#phone").css('border', '1px solid green');
            	}
            	if(gender == "0"){
            		$("#gender").css('border', '1px solid red');
            		$("#gender").css('background-color', 'pink');
            		return false;
            	}
            	else{
            		$("#gender").css('background-color', 'white');
            		$("#gender").css('border', '1px solid green');
            	}
            	if(dob == ""){
            		$("#dob").css('border', '1px solid red');
            		$("#dob").css('background-color', 'pink');
            		return false;
            	}
            	else{
            		$("#dob").css('background-color', 'white');
            		$("#dob").css('border', '1px solid green');
            	}
            	if(weight == ""){
            		$("#weight").css('border', '1px solid red');
            		$("#weight").css('background-color', 'pink');
            		return false;
            	}
            	else{
            		$("#weight").css('background-color', 'white');
            		$("#weight").css('border', '1px solid green');
            	}
            	dialogRef.enableButtons(false);
                dialogRef.setClosable(false);
                var data = fname + "," + lname + "," + email + "," + phone + "," + dob + "," + gender + "," + weight;
                $.post( "/MDS/JSP/Controller.jsp", { submit:"createPatient" , data:Base64.encode(data) })
                .done(function( data ) {
                	if(Base64.decode(data) == "0"){
                		$("#newpasstab").text("Something went wrong please try againg later.");
                		$("#newpass").text("This Dialog will close in 2 seconds.");
                        setTimeout(function(){
                            dialogRef.close();
                        }, 2000);
                	}else if(Base64.decode(data) == "Error"){
                		$("#newpasstab").text("Username or Email already Exist.");
                		$("#newpass").text("This Dialog will close in 2 seconds.");
                        setTimeout(function(){
                            dialogRef.close();
                        }, 2000);
                	}
                	else{
                        $("#newpasstab").text("Success! This Dialog will close in 3 seconds.");
                        setTimeout(function(){
                            dialogRef.close();
                            loadTableData();
                        }, 3000);
                	}
                });
            }
        }, {
            label: 'Close',
            action: function(dialogRef){
                dialogRef.close();
            }
        }]
    });
}
function openPatientWindow(e){
	var name = e.name;
	name = name.split(',');
	var url = "/MDS/JSP/patientProfile.jsp?submit=" + name[0];
	BootstrapDialog.show({
        title: name[1],
        cssClass: 'login-dialog',
        message: $('<div></div>').load(url),
        closable: true,
        closeByBackdrop: false,
        closeByKeyboard: false,
    });
}
function format(row, tr) {
	var d = row.data();
	var tData = d.toString().split(',');
	$
			.ajax({
				url : '/Smart-Trolley/JSP/Controller.jsp',
				type : 'POST',
				data : jQuery.param({
					submit : "billingMaster",
					trID : tData[2]
				}),
				contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
				success : function(response) {
					var sOut = '<table class="table table-striped table-bordered">';
					sOut += '<tr><th>Trolley ID</th><th>RFID</th><th>Item Name</th><th>Item Price</th><th>Discount</th><th>Tax</th><th>Final Amount</th></tr>';
					var data = response.toString().split(",");
					console.log(data[0]);
					for (i = 0; i < data.length; i++) {
						var trData = data[i].split("/");
						sOut += '<tr><td>' + trData[1] + '</td><td>'
								+ trData[0] + '</td><td>' + trData[2]
								+ '</td><td>' + trData[3] + '</td><td>'
								+ trData[4] + '</td><td>' + trData[5]
								+ '</td><td>' + trData[6] + '</td></tr>';
					}
					sOut += '</table>';
					row.child(sOut).show();
					tr.addClass('shown');
				},
				error : function() {
					alert("error");
				}
			});
}