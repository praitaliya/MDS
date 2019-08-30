package com.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.Preaid.Diagnosis.Client.DiagnosisClient;
import com.Preaid.Diagnosis.Client.DiagnosisObject;
import com.Preaid.Diagnosis.Model.Gender;
import com.Preaid.Diagnosis.Model.HealthDiagnosis;

public class Demo{
	public static void main(String[] args) throws Exception {
		DiagnosisObject d = new DiagnosisObject();
		DiagnosisClient dc = d.getClient();
		DAOController dao = new DAOController();
		List<Integer> l = new ArrayList<Integer>();
		String arr[] = {"44"};
		l.add(44);
		//ArrayList<HashMap<String, String>> ds = dao.getDrugData("Headache,cough");
		}
}