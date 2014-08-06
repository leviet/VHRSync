package com.myapp.BO;

import java.io.Serializable;
import javax.persistence.*;
import javax.validation.constraints.NotNull;

import java.sql.Timestamp;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the SYNC_RELOAD_REQUEST_LOG database table.
 * 
 */
@Entity
@Table(name="SYNC_RELOAD_REQUEST_LOG")
@NamedQueries({
    @NamedQuery(name = "SyncReloadRequestLog.findByRequestHistoryId", query = "SELECT r FROM SyncReloadRequestLog r WHERE r.requestHistoryId = :requestHistoryId"),
    @NamedQuery(name = "SyncReloadRequestLog.findByCustom", query = "SELECT r FROM SyncReloadRequestLog r WHERE " +
    		"(r.fromDate >= :fromDate OR :fromDate IS NULL) AND (r.toDate <= :toDate OR :toDate IS NULL) " +
    		"AND ((:sourceNodeId LIKE '%'||r.sourceNodeId||'%') OR :sourceNodeId IS NULL) AND ((:userName LIKE '%'||r.userName||'%') OR :userName IS NULL)"),
    @NamedQuery(name = "SyncReloadRequestLog.findAllUserName", query = "SELECT DISTINCT r.userName FROM SyncReloadRequestLog r"),
    @NamedQuery(name = "SyncReloadRequestLog.findAllSourceNodeId", query = "SELECT DISTINCT r.sourceNodeId FROM SyncReloadRequestLog r")
    })
public class SyncReloadRequestLog implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
    @GeneratedValue(generator = "sequence", strategy = GenerationType.AUTO)
    @SequenceGenerator(name = "sequence", sequenceName = "SYNC_RELOAD_REQUEST_LOG_SEQ")
    @Basic(optional = false)
    @NotNull
	@Column(name="REQUEST_HISTORY_ID", unique=true, nullable=false, precision=20)
	private long requestHistoryId;

	@Column(name="CREATE_TIME")
	private Timestamp createTime;

	@Temporal(TemporalType.DATE)
	@Column(name="FROM_DATE")
	private Date fromDate;

	@Column(name="LAST_UPDATE_BY", length=50)
	private String lastUpdateBy;

	@Column(name="LAST_UPDATE_TIME", nullable=false)
	private Timestamp lastUpdateTime;

	@Lob
	@Column(name="RELOAD_DELETE_STMT")
	private String reloadDeleteStmt;

	@Column(name="RELOAD_ENABLED", precision=3)
	private BigDecimal reloadEnabled;

	@Lob
	@Column(name="RELOAD_SELECT")
	private String reloadSelect;

	@Column(name="RELOAD_TIME")
	private Timestamp reloadTime;

	@Column(name="REQUEST_CREATE_TIME")
	private Timestamp requestCreateTime;

	@Column(name="ROUTER_ID", length=50)
	private String routerId;

	@Column(name="SOURCE_NODE_ID", length=50)
	private String sourceNodeId;

	@Column(length=2)
	private String status;

	@Column(name="TARGET_NODE_ID", length=50)
	private String targetNodeId;

	@Temporal(TemporalType.DATE)
	@Column(name="TO_DATE")
	private Date toDate;

	@Column(name="TRIGGER_ID", length=50)
	private String triggerId;

	@Column(name="USER_NAME", length=50)
	private String userName;

	public SyncReloadRequestLog() {
	}

	public long getRequestHistoryId() {
		return this.requestHistoryId;
	}

	public void setRequestHistoryId(long requestHistoryId) {
		this.requestHistoryId = requestHistoryId;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public Date getFromDate() {
		return this.fromDate;
	}

	public void setFromDate(Date fromDate) {
		this.fromDate = fromDate;
	}

	public String getLastUpdateBy() {
		return this.lastUpdateBy;
	}

	public void setLastUpdateBy(String lastUpdateBy) {
		this.lastUpdateBy = lastUpdateBy;
	}

	public Timestamp getLastUpdateTime() {
		return this.lastUpdateTime;
	}

	public void setLastUpdateTime(Timestamp lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}

	public String getReloadDeleteStmt() {
		return this.reloadDeleteStmt;
	}

	public void setReloadDeleteStmt(String reloadDeleteStmt) {
		this.reloadDeleteStmt = reloadDeleteStmt;
	}

	public BigDecimal getReloadEnabled() {
		return this.reloadEnabled;
	}

	public void setReloadEnabled(BigDecimal reloadEnabled) {
		this.reloadEnabled = reloadEnabled;
	}

	public String getReloadSelect() {
		return this.reloadSelect;
	}

	public void setReloadSelect(String reloadSelect) {
		this.reloadSelect = reloadSelect;
	}

	public Timestamp getReloadTime() {
		return this.reloadTime;
	}

	public void setReloadTime(Timestamp reloadTime) {
		this.reloadTime = reloadTime;
	}

	public Timestamp getRequestCreateTime() {
		return this.requestCreateTime;
	}

	public void setRequestCreateTime(Timestamp requestCreateTime) {
		this.requestCreateTime = requestCreateTime;
	}

	public String getRouterId() {
		return this.routerId;
	}

	public void setRouterId(String routerId) {
		this.routerId = routerId;
	}

	public String getSourceNodeId() {
		return this.sourceNodeId;
	}

	public void setSourceNodeId(String sourceNodeId) {
		this.sourceNodeId = sourceNodeId;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTargetNodeId() {
		return this.targetNodeId;
	}

	public void setTargetNodeId(String targetNodeId) {
		this.targetNodeId = targetNodeId;
	}

	public Date getToDate() {
		return this.toDate;
	}

	public void setToDate(Date toDate) {
		this.toDate = toDate;
	}

	public String getTriggerId() {
		return this.triggerId;
	}

	public void setTriggerId(String triggerId) {
		this.triggerId = triggerId;
	}

	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

}