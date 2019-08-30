package com.util;

import java.sql.Connection;
import java.sql.DriverManager;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import com.Model.serverInfo;
import com.dao.TrolleyLogs;
import com.xml.EncryptUtils;

/**
 * database connection class for hibernate and jdbc connection
 * 
 * @author Prashant Italiya
 *
 */
public class DBConnection {

	static SessionFactory sf = openConnection();
	Session session = null;
	Connection conn = null;


	public static SessionFactory openConnection() { // hibernate session menthod
		try {
			if (sf == null) {
				sf = new Configuration().addAnnotatedClass(com.Model.PatientModel.class).configure()
						.buildSessionFactory();
				System.out.println("Session Factory Created");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return sf;
	}

	public Session getHiberConnection() { // hibernate get connection
		try {
			if (sf == null) {
				sf = openConnection();
			}
			this.session = sf.openSession();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return this.session;
	}

	public Connection getConnection(serverInfo sInfo) { // jdbc connection
		Connection conn = null;
		serverInfo data = sInfo; // variables of serverInfo model are encrypted using base64
		System.out.println("Conn String : " + data);
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String connURL = "jdbc:mysql://" + EncryptUtils.base64decode(sInfo.getIp()) + ":" + sInfo.getPort() + "/"
					+ sInfo.getDatabase();
			conn = DriverManager.getConnection(connURL, EncryptUtils.base64decode(sInfo.getUname()),
					EncryptUtils.base64decode(sInfo.getPass()));
		} catch (Exception e) {
			TrolleyLogs.AppendToLog(e);
			e.printStackTrace();
		}
		return conn;
	}
}
