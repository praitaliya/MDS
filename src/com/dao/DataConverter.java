package com.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import com.Model.DrugModel;
import com.Model.PatientModel;
import com.Preaid.Diagnosis.Model.HealthDiagnosis;
import com.Preaid.Diagnosis.Model.HealthItem;
import com.Preaid.Diagnosis.Model.HealthSymptomSelector;

public class DataConverter { // class with functions to convert list data to html forms
	public String getBlankTable() {
		String sB = "";
		sB += "<thead><tr class=\"headings\" align=\"center\">";
		sB += "<th class=\"column-title\"></th>";
		sB += "</tr></thead>";
		sB += "<tbody>";
		sB += "<tr class=\"even pointer\" align=\"center\">";
		sB += "<td>No Data To Display</td></tr></tbody>";
		return sB;
	}

	public String getPatientTable(ArrayList<PatientModel> itemData) {
		String sB = "";
		if (itemData.size() == 0) {
			sB = "";
			sB += "<thead><tr class=\"headings\" align=\"center\">";
			sB += "<th class=\"column-title\"></th>";
			sB += "</tr></thead>";
			sB += "<tbody>";
			sB += "<tr class=\"even pointer\" align=\"center\">";
			sB += "<td>No Data To Display</td></tr></tbody>";
		} else {
			sB = "";
			sB += "<thead>";
			sB += "<tr class=\"headings\" align=\"center\">";
			if (itemData != null) {
				String hData[] = { "Patient ID", "Patient Name", "Email", "Phone", "Date of Birth", "Gender", "Age",
						"Weight" };
				for (int i = 0; i < hData.length; i++) {
					sB += "<th class=\"column-title\" align=\"center\">" + hData[i].toUpperCase() + "</th>";
				}
				sB += "</tr></thead>";
				sB += "<tbody>";
				for (PatientModel i : itemData) {
					String name = i.getId() + "," + i.getFname() + " " + i.getLname();
					sB += "<tr class=\"even pointer\" align=\"center\" style=\"font-weight: bold\">";
					sB += "<td align=\"left\">" + i.getId() + "</td>";
					sB += "<td align=\"left\"><a style=\"color:red\" id=\"patient\" href=\"javascript:void(0);\" value=\""
							+ i.getId() + "\" name=\"" + name + "\"  onclick=\"openPatientWindow(this);\">"
							+ i.getFname() + " " + i.getLname() + "</td>";
					sB += "<td align=\"left\">" + i.getEmail() + "</td>";
					sB += "<td align=\"left\">" + i.getContactno() + "</td>";
					sB += "<td align=\"left\">" + i.getDob() + "</td>";
					sB += "<td align=\"left\">" + i.getGender() + "</td>";
					sB += "<td align=\"left\">" + i.getAge() + "</td>";
					sB += "<td align=\"left\">" + i.getWeight() + "</td>";
					sB += "</tr>";
				}
				sB += "</tbody>";
			}
		}
		return sB;
	}

	public String getStringOptions(List<HealthItem> bodyLocation) {
		String sB = "";
		if (bodyLocation.size() == 0 || bodyLocation == null) {
			sB += "<option value=\"0\">--------- Select --------- </option>";
		} else {
			sB += "<option value=\"0\">--------- Select --------- </option>";
			for (HealthItem data : bodyLocation) {
				sB += "<option value=\"" + data.ID + "\">" + data.Name + "</option>";
			}
		}
		return sB;
	}

	public String getSymptoms(List<HealthSymptomSelector> diagnosis) {
		String sB = "";
		if (diagnosis.size() == 0 || diagnosis == null) {
		} else {
			for (HealthSymptomSelector data : diagnosis) {
				sB += "<option key=\"" + data.ID + "\" value=\"" + data.Name + "\">" + data.Name + "</option>";
			}
		}
		return sB;
	}

	public String getDiagnosisTable(List<HealthDiagnosis> diagnosis) {
		String sB = "";
		if (diagnosis.size() == 0) {
			sB = "";
			sB += "<thead><tr class=\"headings\" align=\"center\">";
			sB += "<th class=\"column-title\"></th>";
			sB += "</tr></thead>";
			sB += "<tbody>";
			sB += "<tr class=\"even pointer\" align=\"center\">";
			sB += "<td>No Data To Display</td></tr></tbody>";
		} else {
			sB = "";
			sB += "<thead>";
			sB += "<tr class=\"headings\" align=\"center\">";
			if (diagnosis != null) {
				String hData[] = { "ID", "Name", "Chances", "ICD", "ICD Name", "Prof Name", "Ranking" };
				for (int i = 0; i < hData.length; i++) {
					sB += "<th class=\"column-title\" align=\"center\">" + hData[i].toUpperCase() + "</th>";
				}
				sB += "</tr></thead>";
				sB += "<tbody>";
				for (HealthDiagnosis i : diagnosis) {
					sB += "<tr class=\"even pointer\" align=\"center\" style=\"font-weight: bold\">";
					sB += "<td align=\"left\"><input type=\"checkbox\" name=\"issue\" value=\"" + i.Issue.ProfName
							+ "\"</td>";
					sB += "<td align=\"left\">" + i.Issue.Name + "</td>";
					sB += "<td align=\"left\">" + i.Issue.Accuracy + "</td>";
					sB += "<td align=\"left\">" + i.Issue.Icd + "</td>";
					sB += "<td align=\"left\">" + i.Issue.IcdName + "</td>";
					sB += "<td align=\"left\">" + i.Issue.ProfName + "</td>";
					sB += "<td align=\"left\">" + i.Issue.Ranking + "</td>";
					sB += "</tr>";
				} // https://api.fda.gov/drug/event.json?search=patient.drug.drugindication:headache+patient.drug.drugindication:cough&limit=10
				sB += "</tbody>";
			}
		}
		return sB;
	}

	public String getDrugTable(HashSet<DrugModel> data) {
		String sB = "";
		if (data == null || data.size() == 0) {
			sB = "";
			sB += "<thead><tr class=\"headings\" align=\"center\">";
			sB += "<th class=\"column-title\"></th>";
			sB += "</tr></thead>";
			sB += "<tbody>";
			sB += "<tr class=\"even pointer\" align=\"center\">";
			sB += "<td>No Data To Display</td></tr></tbody>";
		} else {
			sB = "";
			sB += "<thead>";
			sB += "<tr class=\"headings\" align=\"center\">";
			String hData[] = { "ID", "NDC ID", "PACKAGE NDC ID", "DRUG INDICATION", "GENERIC NAME", "ROUTE",
					"BRAND NAME", "MANUFACTURER NAME", "DRUG TYPE" };
			for (int i = 0; i < hData.length; i++) {
				sB += "<th class=\"column-title\" align=\"center\">" + hData[i].toUpperCase() + "</th>";
			}
			sB += "</tr></thead>";
			sB += "<tbody>";
			for (DrugModel d : data) {
				sB += "<tr class=\"even pointer\" align=\"center\" style=\"font-weight: bold\">";
				sB += "<td align=\"left\"><input type=\"checkbox\" name=\"issue\" value=\"" + d.getNdc_id() + "\"</td>";
				sB += "<td align=\"left\">" + d.getNdc_id() + "</td>";
				sB += "<td align=\"left\">" + d.getPackage_ndc_id() + "</td>";
				sB += "<td align=\"left\">" + d.getDrug_indication() + "</td>";
				sB += "<td align=\"left\">" + d.getGeneric_name() + "</td>";
				sB += "<td align=\"left\">" + d.getRoute() + "</td>";
				sB += "<td align=\"left\">" + d.getBrand_name() + "</td>";
				sB += "<td align=\"left\">" + d.getManufacurer_name() + "</td>";
				sB += "<td align=\"left\">" + d.getProduct_type() + "</td>";
				sB += "</tr>";
			} // https://api.fda.gov/drug/event.json?search=patient.drug.drugindication:headache+patient.drug.drugindication:cough&limit=10
			sB += "</tbody>";
		}
		return sB;
	}

	public String getNotesTable(ArrayList<String> data) {
		String sB = "";
		if (data == null || data.size() == 0) {
			sB = "";
			sB += "<thead><tr class=\"headings\" align=\"center\">";
			sB += "<th class=\"column-title\"></th>";
			sB += "</tr></thead>";
			sB += "<tbody>";
			sB += "<tr class=\"even pointer\" align=\"center\">";
			sB += "<td>No Data To Display</td></tr></tbody>";
		} else {
			sB = "";
			sB += "<thead>";
			sB += "<tr class=\"headings\" align=\"center\">";
			String hData[] = { "NOTE ID", "BODY Location", "Sub Location", "Symptoms" };
			for (int i = 0; i < hData.length; i++) {
				sB += "<th class=\"column-title\" align=\"center\">" + hData[i].toUpperCase() + "</th>";
			}
			sB += "</tr></thead>";
			sB += "<tbody>";
			for (String d : data) {
				String[] s = d.split(";");
				sB += "<tr class=\"even pointer\" align=\"center\" style=\"font-weight: bold\">";
				sB += "<td align=\"left\">" + s[0] + "</td>";
				sB += "<td align=\"left\">" + s[1] + "</td>";
				sB += "<td align=\"left\">" + s[2] + "</td>";
				sB += "<td align=\"left\">" + s[3] + "</td>";
				sB += "</tr>";
			} // https://api.fda.gov/drug/event.json?search=patient.drug.drugindication:headache+patient.drug.drugindication:cough&limit=10
			sB += "</tbody>";
		}
		return sB;
	}
}
