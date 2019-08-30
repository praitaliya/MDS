package com.Preaid.Diagnosis.Client;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import com.dao.TrolleyLogs;

public class DiagnosisObject {
	static DiagnosisClient diagnosisObject = null;

	public DiagnosisClient getClient() {
		if (diagnosisObject == null) {
			diagnosisObject = getClientObject();
			System.out.println("Object Created");
		}
		return diagnosisObject;
	}

	private DiagnosisClient getClientObject() {
		DiagnosisClient dc = null;

		String authUrl = "";
		String userName = "";
		String password = "";
		String language = "";
		String healthUrl = "";

		Properties prop = new Properties();
		InputStream input = null;
		try {
			input = new FileInputStream("C:\\Users\\Prashant\\Desktop\\Study\\Project\\MDS\\src\\config.properties");
			prop.load(input);

			userName = prop.getProperty("username");
			password = prop.getProperty("password");
			authUrl = prop.getProperty("priaid_authservice_url");
			healthUrl = prop.getProperty("priaid_healthservice_url");
			language = prop.getProperty("language");

		} catch (FileNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			TrolleyLogs.AppendToLog(e1);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			TrolleyLogs.AppendToLog(e);
		}

		CheckRequiredArgs(userName, password, authUrl, healthUrl, language);

		try {
			dc = new DiagnosisClient(userName, password, authUrl, language, healthUrl);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			TrolleyLogs.AppendToLog(e);
		}
		return dc;
	}

	static void CheckRequiredArgs(String userName, String password, String authUrl, String healthUrl, String language) {
		if (userName == null || userName.isEmpty())
			throw new IllegalArgumentException("username in config.properties is required");

		if (password == null || password.isEmpty())
			throw new IllegalArgumentException("password in config.properties is required");

		if (authUrl == null || authUrl.isEmpty())
			throw new IllegalArgumentException("priaid_authservice_url in config.properties is required");

		if (healthUrl == null || healthUrl.isEmpty())
			throw new IllegalArgumentException("priaid_healthservice_url in config.properties is required");

		if (language == null || language.isEmpty())
			throw new IllegalArgumentException("language in config.properties is required");
	}

}
