package com.myapp.myobject;
/*
 * @author VietLv2
 * @createDate 31/07/2014
 */
public class BatchDetail {
	public MyJsonObject data;
	public MyJsonObject outgoing_batch;
	public MyJsonObject incoming_error;
	
	public MyJsonObject getData() {
		return data;
	}
	public void setData(MyJsonObject data) {
		this.data = data;
	}
	public MyJsonObject getOutgoing_batch() {
		return outgoing_batch;
	}
	public void setOutgoing_batch(MyJsonObject outgoing_batch) {
		this.outgoing_batch = outgoing_batch;
	}
	public MyJsonObject getIncoming_error() {
		return incoming_error;
	}
	public void setIncoming_error(MyJsonObject incoming_error) {
		this.incoming_error = incoming_error;
	}
	
	
}
