/**
 * 
 */

$(document).ready(
		function() {
			$("#smartwizard").on(
					"showStep",
					function(e, anchorObject, stepNumber, stepDirection,
							stepPosition) {
						// alert("You are on step " + stepNumber + " now");
						if (stepNumber == 0) {
							loadBodyLocations();
						} else if (stepNumber == 1) {
							loadSecondStep($("#symptoms").val());
						} else if (stepNumber == 2) {
							var types = $('#symptoms > option:selected').map(
									function() {
										return this.getAttribute('key');
									}).get();
							loadDiagnosis(types, $("#gender").attr("value"), $(
									"#dob").val());
						} else if (stepNumber == 3) {
							var checkedValues = $("input:checkbox:checked",
									"#diagnosisData").map(function() {
								return $(this).val();
							}).get();
							loadDrugs(checkedValues.join(','));
						}
					});

			// Toolbar extra buttons
			var btnFinish = $('<button></button>').text('Finish').addClass(
					'btn btn-info').on(
					'click',
					function() {
						var bodyLocation = $("#bodylocation option:selected").text();
						var subLocation = $("#subbodylocation option:selected").text();
						var symptoms = $("#symptoms").val();
						var data = [];
						var checkedDisease = "";
						$("input:checkbox:checked", "#diagnosisData").each(
								function() {
									data = [];
									$(this).closest('tr').find('td').each(function (){
										data.push($(this).text());
									});
									checkedDisease += data + " # ";
								});
						
						var checkedDrug = "";
						$("input:checkbox:checked", "#drugData").each(
								function() {
									data = [];
									$(this).closest('tr').find('td').each(function (){
										data.push($(this).text());
									});
									checkedDrug += data + " # ";
								});
						var data = $("#patientID").val() + " @ " + document.getElementById("reportID").innerText + " @ " + bodyLocation + " @ " + subLocation + " @ "
								+ symptoms + " @ " + checkedDisease + " @ "
								+ checkedDrug;
						submitData(data);
					});
			var btnCancel = $('<button></button>').text('Cancel').addClass(
					'btn btn-danger').on('click', function() {
				$('#smartwizard').smartWizard("reset");
			});

			// Smart Wizard
			$('#smartwizard').smartWizard({
				selected : 0,
				theme : 'dots',
				transitionEffect : 'fade',
				contentCache : false,
				showStepURLhash : true,
				toolbarSettings : {
					toolbarPosition : 'bottom',
					toolbarExtraButtons : [ btnFinish, btnCancel ]
				}
			});
		});
$("#bodylocation").on("change", function() {
	var selected = $(this).val(); // get the selected value
	loadBodySubLocation(selected);
});

$("#subbodylocation").on("change", function() {
	var selected = $(this).val(); // get the selected value
	var gender = $("#gender").attr("value");
	var type = "";
	loadSymptoms(selected, gender);
});

function loadDrugs(disease) {
	$.ajax({
		url : "/MDS/JSP/getTableData.jsp",
		type : "POST",
		data : {
			submit : "loadDrugs",
			disease : disease
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
			if ($.fn.dataTable.isDataTable("#drugData")) {
				$("#drugData").DataTable().destroy();
			}
			$("#drugData").html(Base64.decode(data));
			var table = $("#drugData").DataTable({
				"destroy" : true,
			});
		},
		error : function() {
			alert("Something went wrong! Please try again.");
			res = "500";
		}
	});
}

function submitData(data) {
	$.ajax({
		url : "/MDS/JSP/Controller.jsp",
		type : "POST",
		data : {
			submit : "submitData",
			data : data
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
			alert(data)
			if(data.trim()==="Ok"){
				alert("Success");
				window.location.href = "/MDS/JSP/patientDashboard.jsp";
			}
		},
		error : function() {
			alert("Something went wrong! Please try again.");
			res = "500";
		}
	});
}

function loadBodyLocations() {
	$.ajax({
		url : "/MDS/JSP/getTableData.jsp",
		type : "POST",
		data : {
			submit : "getBodyLocation",
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
			$("#bodylocation").html(Base64.decode(data));
		},
		error : function() {
			alert("Something went wrong! Please try again.");
			res = "500";
		}
	});
}

function loadSecondStep(symptoms) {
	var html = "";
	$.each(symptoms, function(i, v) {
		html += "<li>" + v + "</li>";
	})
	$("#symptomList").html(html);
}

function loadBodySubLocation(selected) {
	$.ajax({
		url : "/MDS/JSP/getTableData.jsp",
		type : "POST",
		data : {
			submit : "getBodySubLocation",
			bodyLocation : selected
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
			$("#subbodylocation").html(Base64.decode(data));
		},
		error : function() {
			alert("Something went wrong! Please try again.");
			res = "500";
		}
	});
}

function loadDiagnosis(types, gender, dob) {
	var data = types.toString();
	$.ajax({
		url : "/MDS/JSP/getTableData.jsp",
		type : "POST",
		data : {
			submit : "getDiagnosis",
			symptoms : data,
			gender : gender,
			dob : dob
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
			if ($.fn.dataTable.isDataTable("#diagnosisData")) {
				$("#diagnosisData").DataTable().destroy();
			}
			$("#diagnosisData").html(Base64.decode(data));
			var table = $("#diagnosisData").DataTable({
				"destroy" : true,
			});
		},
		error : function() {
			alert("Something went wrong! Please try again.");
			res = "500";
		}
	});
}
function loadSymptoms(selected, gender) {
	$.ajax({
		url : "/MDS/JSP/getTableData.jsp",
		type : "POST",
		data : {
			submit : "getSymptoms",
			bodySubLocation : selected,
			gender : gender
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
			if (Base64.decode(data) === "") {
				$("#symptoms").prop("disabled", true);
			} else {
				$("#symptoms").html(Base64.decode(data));
			}
		},
		error : function() {
			alert("Something went wrong! Please try again.");
			res = "500";
		}
	});
}