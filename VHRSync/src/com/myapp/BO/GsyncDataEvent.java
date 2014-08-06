package com.myapp.BO;

import java.io.Serializable;
import javax.persistence.*;

import java.sql.Timestamp;

/**
 * The persistent class for the GSYNC_DATA_EVENT database table.
 * 
 */
@Entity
@Table(name = "GSYNC_DATA_EVENT")
public class GsyncDataEvent implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "DATA_ID", unique = true, nullable = false, precision = 38)
	private long dataId;
	
	@Id
	@Column(name = "BATCH_ID", unique = true, nullable = false, precision = 38)
	private long batchId;
	
	@Id
	@Column(name = "ROUTER_ID", unique = true, nullable = false, length = 50)
	private String routerId;

	@Column(name = "CREATE_TIME")
	private Timestamp createTime;

	public GsyncDataEvent() {
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public long getDataId() {
		return this.dataId;
	}

	public void setDataId(long dataId) {
		this.dataId = dataId;
	}

	public long getBatchId() {
		return this.batchId;
	}

	public void setBatchId(long batchId) {
		this.batchId = batchId;
	}

	public String getRouterId() {
		return this.routerId;
	}

	public void setRouterId(String routerId) {
		this.routerId = routerId;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof GsyncDataEvent)) {
			return false;
		}
		GsyncDataEvent castOther = (GsyncDataEvent) other;
		return (this.dataId == castOther.dataId)
				&& (this.batchId == castOther.batchId)
				&& this.routerId.equals(castOther.routerId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + ((int) (this.dataId ^ (this.dataId >>> 32)));
		hash = hash * prime + ((int) (this.batchId ^ (this.batchId >>> 32)));
		hash = hash * prime + this.routerId.hashCode();

		return hash;
	}

}