package com.myapp.BO;

import java.io.Serializable;
import javax.persistence.*;

import com.myapp.myobject.MyObject;

import java.sql.Timestamp;
import java.lang.reflect.Field;
import java.math.BigDecimal;


/**
 * The persistent class for the GSYNC_OUTGOING_BATCH database table.
 * 
 */
@Entity
@Table(name="GSYNC_OUTGOING_BATCH")
@NamedQueries({
    @NamedQuery(name = "GsyncOutgoingBatch.findByBatchId", query = "SELECT o FROM GsyncOutgoingBatch o where o.batchId = :batchId")
    })
public class GsyncOutgoingBatch implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BATCH_ID", unique=true, nullable=false, precision=38)
	private long batchId;

	@Id
	@Column(name="NODE_ID", unique=true, nullable=false, length=50)
	private String nodeId;

	@Column(name="BYTE_COUNT", nullable=false, precision=38)
	private BigDecimal byteCount;

	@Column(name="CHANNEL_ID", length=20)
	private String channelId;

	@Column(name="COMMON_FLAG", precision=3)
	private BigDecimal commonFlag;

	@Column(name="CREATE_BY", length=255)
	private String createBy;

	@Column(name="CREATE_TIME")
	private Timestamp createTime;

	@Column(name="DATA_EVENT_COUNT", nullable=false, precision=38)
	private BigDecimal dataEventCount;

	@Column(name="DELETE_EVENT_COUNT", nullable=false, precision=38)
	private BigDecimal deleteEventCount;

	@Column(name="ERROR_FLAG", precision=3)
	private BigDecimal errorFlag;

	@Column(name="EXTRACT_COUNT", nullable=false, precision=38)
	private BigDecimal extractCount;

	@Column(name="EXTRACT_JOB_FLAG", precision=3)
	private BigDecimal extractJobFlag;

	@Column(name="EXTRACT_MILLIS", nullable=false, precision=38)
	private BigDecimal extractMillis;

	@Column(name="FAILED_DATA_ID", nullable=false, precision=38)
	private BigDecimal failedDataId;

	@Column(name="FAILED_LINE_NUMBER", nullable=false, precision=38)
	private BigDecimal failedLineNumber;

	@Column(name="FILTER_MILLIS", nullable=false, precision=38)
	private BigDecimal filterMillis;

	@Column(name="IGNORE_COUNT", nullable=false, precision=38)
	private BigDecimal ignoreCount;

	@Column(name="INSERT_EVENT_COUNT", nullable=false, precision=38)
	private BigDecimal insertEventCount;

	@Column(name="LAST_UPDATE_HOSTNAME", length=255)
	private String lastUpdateHostname;

	@Column(name="LAST_UPDATE_TIME")
	private Timestamp lastUpdateTime;

	@Column(name="LOAD_COUNT", nullable=false, precision=38)
	private BigDecimal loadCount;

	@Column(name="LOAD_FLAG", precision=3)
	private BigDecimal loadFlag;

	@Column(name="LOAD_ID", precision=38)
	private BigDecimal loadId;

	@Column(name="LOAD_MILLIS", nullable=false, precision=38)
	private BigDecimal loadMillis;

	@Column(name="NETWORK_MILLIS", nullable=false, precision=38)
	private BigDecimal networkMillis;

	@Column(name="OTHER_EVENT_COUNT", nullable=false, precision=38)
	private BigDecimal otherEventCount;

	@Column(name="RELOAD_EVENT_COUNT", nullable=false, precision=38)
	private BigDecimal reloadEventCount;

	@Column(name="ROUTER_MILLIS", nullable=false, precision=38)
	private BigDecimal routerMillis;

	@Column(name="SENT_COUNT", nullable=false, precision=38)
	private BigDecimal sentCount;

	@Column(name="SQL_CODE", nullable=false, precision=22)
	private BigDecimal sqlCode;

	@Lob
	@Column(name="SQL_MESSAGE")
	private String sqlMessage;

	@Column(name="SQL_STATE", length=10)
	private String sqlState;

	@Column(length=2)
	private String status;

	@Column(name="UPDATE_EVENT_COUNT", nullable=false, precision=38)
	private BigDecimal updateEventCount;

	public GsyncOutgoingBatch() {
	}

	public BigDecimal getByteCount() {
		return this.byteCount;
	}

	public void setByteCount(BigDecimal byteCount) {
		this.byteCount = byteCount;
	}

	public String getChannelId() {
		return this.channelId;
	}

	public void setChannelId(String channelId) {
		this.channelId = channelId;
	}

	public BigDecimal getCommonFlag() {
		return this.commonFlag;
	}

	public void setCommonFlag(BigDecimal commonFlag) {
		this.commonFlag = commonFlag;
	}

	public String getCreateBy() {
		return this.createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public BigDecimal getDataEventCount() {
		return this.dataEventCount;
	}

	public void setDataEventCount(BigDecimal dataEventCount) {
		this.dataEventCount = dataEventCount;
	}

	public BigDecimal getDeleteEventCount() {
		return this.deleteEventCount;
	}

	public void setDeleteEventCount(BigDecimal deleteEventCount) {
		this.deleteEventCount = deleteEventCount;
	}

	public BigDecimal getErrorFlag() {
		return this.errorFlag;
	}

	public void setErrorFlag(BigDecimal errorFlag) {
		this.errorFlag = errorFlag;
	}

	public BigDecimal getExtractCount() {
		return this.extractCount;
	}

	public void setExtractCount(BigDecimal extractCount) {
		this.extractCount = extractCount;
	}

	public BigDecimal getExtractJobFlag() {
		return this.extractJobFlag;
	}

	public void setExtractJobFlag(BigDecimal extractJobFlag) {
		this.extractJobFlag = extractJobFlag;
	}

	public BigDecimal getExtractMillis() {
		return this.extractMillis;
	}

	public void setExtractMillis(BigDecimal extractMillis) {
		this.extractMillis = extractMillis;
	}

	public BigDecimal getFailedDataId() {
		return this.failedDataId;
	}

	public void setFailedDataId(BigDecimal failedDataId) {
		this.failedDataId = failedDataId;
	}

	public BigDecimal getFailedLineNumber() {
		return this.failedLineNumber;
	}

	public void setFailedLineNumber(BigDecimal failedLineNumber) {
		this.failedLineNumber = failedLineNumber;
	}

	public BigDecimal getFilterMillis() {
		return this.filterMillis;
	}

	public void setFilterMillis(BigDecimal filterMillis) {
		this.filterMillis = filterMillis;
	}

	public BigDecimal getIgnoreCount() {
		return this.ignoreCount;
	}

	public void setIgnoreCount(BigDecimal ignoreCount) {
		this.ignoreCount = ignoreCount;
	}

	public BigDecimal getInsertEventCount() {
		return this.insertEventCount;
	}

	public void setInsertEventCount(BigDecimal insertEventCount) {
		this.insertEventCount = insertEventCount;
	}

	public String getLastUpdateHostname() {
		return this.lastUpdateHostname;
	}

	public void setLastUpdateHostname(String lastUpdateHostname) {
		this.lastUpdateHostname = lastUpdateHostname;
	}

	public Timestamp getLastUpdateTime() {
		return this.lastUpdateTime;
	}

	public void setLastUpdateTime(Timestamp lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}

	public BigDecimal getLoadCount() {
		return this.loadCount;
	}

	public void setLoadCount(BigDecimal loadCount) {
		this.loadCount = loadCount;
	}

	public BigDecimal getLoadFlag() {
		return this.loadFlag;
	}

	public void setLoadFlag(BigDecimal loadFlag) {
		this.loadFlag = loadFlag;
	}

	public BigDecimal getLoadId() {
		return this.loadId;
	}

	public void setLoadId(BigDecimal loadId) {
		this.loadId = loadId;
	}

	public BigDecimal getLoadMillis() {
		return this.loadMillis;
	}

	public void setLoadMillis(BigDecimal loadMillis) {
		this.loadMillis = loadMillis;
	}

	public BigDecimal getNetworkMillis() {
		return this.networkMillis;
	}

	public void setNetworkMillis(BigDecimal networkMillis) {
		this.networkMillis = networkMillis;
	}

	public BigDecimal getOtherEventCount() {
		return this.otherEventCount;
	}

	public void setOtherEventCount(BigDecimal otherEventCount) {
		this.otherEventCount = otherEventCount;
	}

	public BigDecimal getReloadEventCount() {
		return this.reloadEventCount;
	}

	public void setReloadEventCount(BigDecimal reloadEventCount) {
		this.reloadEventCount = reloadEventCount;
	}

	public BigDecimal getRouterMillis() {
		return this.routerMillis;
	}

	public void setRouterMillis(BigDecimal routerMillis) {
		this.routerMillis = routerMillis;
	}

	public BigDecimal getSentCount() {
		return this.sentCount;
	}

	public void setSentCount(BigDecimal sentCount) {
		this.sentCount = sentCount;
	}

	public BigDecimal getSqlCode() {
		return this.sqlCode;
	}

	public void setSqlCode(BigDecimal sqlCode) {
		this.sqlCode = sqlCode;
	}

	public String getSqlMessage() {
		return this.sqlMessage;
	}

	public void setSqlMessage(String sqlMessage) {
		this.sqlMessage = sqlMessage;
	}

	public String getSqlState() {
		return this.sqlState;
	}

	public void setSqlState(String sqlState) {
		this.sqlState = sqlState;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public BigDecimal getUpdateEventCount() {
		return this.updateEventCount;
	}

	public void setUpdateEventCount(BigDecimal updateEventCount) {
		this.updateEventCount = updateEventCount;
	}
	
	public long getBatchId() {
		return this.batchId;
	}
	public void setBatchId(long batchId) {
		this.batchId = batchId;
	}
	public String getNodeId() {
		return this.nodeId;
	}
	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof GsyncOutgoingBatch)) {
			return false;
		}
		GsyncOutgoingBatch castOther = (GsyncOutgoingBatch)other;
		return 
			(this.batchId == castOther.batchId)
			&& this.nodeId.equals(castOther.nodeId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + ((int) (this.batchId ^ (this.batchId >>> 32)));
		hash = hash * prime + this.nodeId.hashCode();
		
		return hash;
	}
	
//	public Object[] toArray(){
//		return new Object[] {this.batchId, this.byteCount, this.channelId, this.channelId, this.commonFlag,
//				this.createBy, this.createTime, this.dataEventCount, this.deleteEventCount, this.errorFlag,
//				this.extractCount, this.extractJobFlag, this.extractMillis, this.failedDataId, this.failedLineNumber,
//				this.filterMillis, this.ignoreCount, this.insertEventCount, this.lastUpdateHostname, this.lastUpdateTime,
//				this.loadCount, this.loadFlag, this.loadId, this.loadMillis, this.networkMillis, this.nodeId,
//				this.otherEventCount, this.reloadEventCount, this.routerMillis, this.sentCount, this.sqlCode,
//				this.sqlMessage, this.sqlState, this.status, this.updateEventCount};
//	}
	
}