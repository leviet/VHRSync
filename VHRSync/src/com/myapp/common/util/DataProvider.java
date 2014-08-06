package com.myapp.common.util;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.cfg.Configuration;

public class DataProvider {
	
	private static final SessionFactory sessionFactory = buildSessionFactory();
	
	public DataProvider(){
		
	}

	private static SessionFactory buildSessionFactory() {
		try {
			//For XML mapping
			//return new Configuration().configure().buildSessionFactory();
			
			//For Annotation
			return new Configuration().configure().buildSessionFactory();
			
		} catch (Throwable ex) {
			ex.printStackTrace();
			throw new ExceptionInInitializerError(ex);
		}
	}

	public static SessionFactory getSessionFactory() {
		return sessionFactory;
	}
	
	public boolean insert(Object insObj) {
		Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        try {
            session.save(insObj);
            tx.commit();
            return true;
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            return false;
        }
    }
}
