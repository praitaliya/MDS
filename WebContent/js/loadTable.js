$(document).ready(function() {
	loadTable($("#patientID").val());
});
function loadTable(patientID){
	$.ajax({
		url : "/MDS/JSP/getTableData.jsp",
		type : "POST",
		data : {
			submit : "notesData",
			patientID : patientID
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
			if ($.fn.dataTable.isDataTable("#noteData")) {
				$("#noteData").DataTable().destroy();
			}
			$("#noteData").html(Base64.decode(data));
			var table = $("#noteData").DataTable({
				"destroy" : true,
			});
		},
		error : function() {
			alert("Something went wrong! Please try again.");
			res = "500";
		}
	});
}