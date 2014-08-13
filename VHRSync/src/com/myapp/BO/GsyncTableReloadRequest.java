package com.myapp.BO;

import java.io.Serializable;
import javax.persistence.*;

import java.sql.Timestamp;
import java.math.BigDecimal;


/**
 * The persistent class for the GSYNC_TABLE_RELOAD_REQUEST database table.
 * 
 */
@Entity
@Table(name="GSYNC_TABLE_RELOAD_REQUEST")
@NamedQueries({
    @NamedQuery(name = "GsyncTableReloadRequest.findById", query = "SELECT r FROM GsyncTableReloadRequest r WHERE " +
    		"r.id.targetNodeId = :targetNodeId AND r.id.sourceNodeId = :sourceNodeId AND r.id.triggerId = :triggerId AND " +
    		"r.id.routerId = :routerId")
    })
public class GsyncTableReloadRequest implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private GsyncTableReloadRequestPK id;

	@Column(name="ROWID", insertable = false, updatable=false)
	private String rowId;

	@Column(name="CREATE_TIME")
	private Timestamp createTime;

	@Column(name="LAST_UPDATE_BY")
	private String lastUpdateBy;

	@Column(name="LAST_UPDATE_TIME")
	private Timestamp lastUpdateTime;

	@Lob
	@Column(name="RELOAD_DELETE_STMT")
	private String reloadDeleteStmt;

	@Column(name="RELOAD_ENABLED")
	private BigDecimal reloadEnabled;

	@Lob
	@Column(name="RELOAD_SELECT")
	private String reloadSelect;

	@Column(name="RELOAD_TIME")
	private Timestamp reloadTime;

	public GsyncTableReloadRequest() {
	}
	
	
	public String getRowId() {
		return rowId;
	}

	public void setRowId(String rowId) {
		this.rowId = rowId;
	}

	public GsyncTableReloadRequestPK getId() {
		return this.id;
	}

	public void setId(GsyncTableReloadRequestPK id) {
		this.id = id;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
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

}