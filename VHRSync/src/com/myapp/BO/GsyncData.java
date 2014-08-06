package com.myapp.BO;

import java.io.Serializable;
import javax.persistence.*;

import com.myapp.myobject.MyObject;

import java.sql.Timestamp;
import java.math.BigDecimal;


/**
 * The persistent class for the GSYNC_DATA database table.
 * 
 */
@Entity
@Table(name="GSYNC_DATA")
@NamedQueries({
    @NamedQuery(name = "GsyncData.findByBatchId", query = "SELECT d FROM GsyncData d, GsyncDataEvent v where d.dataId = v.dataId and v.batchId = :batchId"),
    @NamedQuery(name = "GsyncData.countChanelByTime", query = "SELECT count(d) FROM GsyncData d WHERE d.tableName IN :tableName AND d.createTime BETWEEN :fromTime AND :toTime")
    })
public class GsyncData implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="DATA_ID", unique=true, nullable=false, precision=38)
	private long dataId;

	@Column(name="CHANNEL_ID", length=20)
	private String channelId;

	@Column(name="CREATE_TIME")
	private Timestamp createTime;

	@Column(name="EVENT_TYPE", nullable=false, length=1)
	private String eventType;

	@Column(name="EXTERNAL_DATA", length=50)
	private String externalData;

	@Column(name="NODE_LIST", length=255)
	private String nodeList;

	@Lob
	@Column(name="OLD_DATA")
	private String oldData;

	@Lob
	@Column(name="PK_DATA")
	private String pkData;

	@Lob
	@Column(name="ROW_DATA")
	private String rowData;

	@Column(name="ROW_ID", precision=38)
	private BigDecimal rowId;

	@Column(name="SOURCE_NODE_ID", length=50)
	private String sourceNodeId;

	@Column(name="TABLE_NAME", nullable=false, length=255)
	private String tableName;

	@Column(name="TRANSACTION_ID", length=255)
	private String transactionId;

	@Column(name="TRIGGER_HIST_ID", nullable=false, precision=22)
	private BigDecimal triggerHistId;

	public GsyncData() {
	}

	public long getDataId() {
		return this.dataId;
	}

	public void setDataId(long dataId) {
		this.dataId = dataId;
	}

	public String getChannelId() {
		return this.channelId;
	}

	public void setChannelId(String channelId) {
		this.channelId = channelId;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getEventType() {
		return this.eventType;
	}

	public void setEventType(String eventType) {
		this.eventType = eventType;
	}

	public String getExternalData() {
		return this.externalData;
	}

	public void setExternalData(String externalData) {
		this.externalData = externalData;
	}

	public String getNodeList() {
		return this.nodeList;
	}

	public void setNodeList(String nodeList) {
		this.nodeList = nodeList;
	}

	public String getOldData() {
		return this.oldData;
	}

	public void setOldData(String oldData) {
		this.oldData = oldData;
	}

	public String getPkData() {
		return this.pkData;
	}

	public void setPkData(String pkData) {
		this.pkData = pkData;
	}

	public String getRowData() {
		return this.rowData;
	}

	public void setRowData(String rowData) {
		this.rowData = rowData;
	}

	public BigDecimal getRowId() {
		return this.rowId;
	}

	public void setRowId(BigDecimal rowId) {
		this.rowId = rowId;
	}

	public String getSourceNodeId() {
		return this.sourceNodeId;
	}

	public void setSourceNodeId(String sourceNodeId) {
		this.sourceNodeId = sourceNodeId;
	}

	public String getTableName() {
		return this.tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getTransactionId() {
		return this.transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	public BigDecimal getTriggerHistId() {
		return this.triggerHistId;
	}

	public void setTriggerHistId(BigDecimal triggerHistId) {
		this.triggerHistId = triggerHistId;
	}
	

}