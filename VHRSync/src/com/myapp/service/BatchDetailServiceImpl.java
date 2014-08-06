package com.myapp.service;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.myapp.BO.GsyncData;
import com.myapp.BO.GsyncIncomingError;
import com.myapp.BO.GsyncOutgoingBatch;
import com.myapp.common.util.DataProvider;
import com.myapp.myobject.BatchDetail;
import com.myapp.myobject.MyJsonObject;
import com.myapp.presentation.IBatchDetailService;

public class BatchDetailServiceImpl implements IBatchDetailService {

	@Override
	public String getOutgoingBatch(String batchId) {
		Session sesion = DataProvider.getSessionFactory().openSession();
		Query query = sesion.getNamedQuery("GsyncOutgoingBatch.findByBatchId");
		query.setParameter("batchId", Long.parseLong(batchId));
		MyJsonObject obj = new MyJsonObject(GsyncOutgoingBatch.class);
		obj.setTable(query.list());
		Gson gson = new Gson();
		return gson.toJson(obj);
	}

	@Override
	public String getIncomingError(String batchId) {
		Session sesion = DataProvider.getSessionFactory().openSession();
		Query query = sesion.getNamedQuery("GsyncIncomingError.findByBatchId");
		query.setParameter("batchId", Long.parseLong(batchId));
		MyJsonObject obj = new MyJsonObject(GsyncIncomingError.class);
		obj.setTable(query.list());
		Gson gson = new Gson();
		return gson.toJson(obj);
	}

	@Override
	public String getDataFromBatch(String batchId) {
		Session sesion = DataProvider.getSessionFactory().openSession();
		Query query = sesion.getNamedQuery("GsyncData.findByBatchId");
		query.setParameter("batchId", Long.parseLong(batchId));
		MyJsonObject obj = new MyJsonObject(GsyncData.class);
		obj.setTable(query.list());
		Gson gson = new Gson();
		return gson.toJson(obj);
	}

	@Override
	public String getBatchDetail(String batchId) {
		BatchDetail batchDetail = new BatchDetail();
		Session sesion = DataProvider.getSessionFactory().openSession();
		Query query = sesion.getNamedQuery("GsyncOutgoingBatch.findByBatchId");
		query.setParameter("batchId", Long.parseLong(batchId));
		MyJsonObject obj = new MyJsonObject(GsyncOutgoingBatch.class);
		obj.setTable(query.list());
		batchDetail.setOutgoing_batch(obj);
		
		query = sesion.getNamedQuery("GsyncData.findByBatchId");
		query.setParameter("batchId", Long.parseLong(batchId));
		obj = new MyJsonObject(GsyncData.class);
		obj.setTable(query.list());
		batchDetail.setData(obj);
		
		query = sesion.getNamedQuery("GsyncIncomingError.findByBatchId");
		query.setParameter("batchId", Long.parseLong(batchId));
		obj = new MyJsonObject(GsyncIncomingError.class);
		obj.setTable(query.list());
		batchDetail.setIncoming_error(obj);
		
		Gson gson = new Gson();
		return gson.toJson(batchDetail);
	}
	
	

}
