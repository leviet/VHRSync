package com.myapp.BO;

import java.io.Serializable;
import javax.persistence.*;

import java.sql.Timestamp;
import java.math.BigDecimal;


/**
 * The persistent class for the GSYNC_INCOMING_ERROR database table.
 * 
 */
@Entity
@Table(name="GSYNC_INCOMING_ERROR")
@NamedQueries({
    @NamedQuery(name = "GsyncIncomingError.findByBatchId", query = "SELECT i FROM GsyncIncomingError i where i.batchId = :batchId")
    })
public class GsyncIncomingError implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BATCH_ID", unique=true, nullable=false, precision=38)
	private long batchId;

	@Id
	@Column(name="NODE_ID", unique=true, nullable=false, length=50)
	private String nodeId;

	@Column(name="FAILED_ROW_NUMBER", unique=true, nullable=false, precision=38)
	private long failedRowNumber;

	@Column(name="BINARY_ENCODING", nullable=false, length=10)
	private String binaryEncoding;

	@Lob
	@Column(name="COLUMN_NAMES", nullable=false)
	private String columnNames;

	@Column(name="CONFLICT_ID", length=50)
	private String conflictId;

	@Column(name="CREATE_TIME")
	private Timestamp createTime;

	@Lob
	@Column(name="CUR_DATA")
	private String curData;

	@Column(name="EVENT_TYPE", nullable=false, length=1)
	private String eventType;

	@Column(name="FAILED_LINE_NUMBER", nullable=false, precision=38)
	private BigDecimal failedLineNumber;

	@Column(name="LAST_UPDATE_BY", length=50)
	private String lastUpdateBy;

	@Column(name="LAST_UPDATE_TIME", nullable=false)
	private Timestamp lastUpdateTime;

	@Lob
	@Column(name="OLD_DATA")
	private String oldData;

	@Lob
	@Column(name="PK_COLUMN_NAMES", nullable=false)
	private String pkColumnNames;

	@Lob
	@Column(name="RESOLVE_DATA")
	private String resolveData;

	@Column(name="RESOLVE_IGNORE", precision=3)
	private BigDecimal resolveIgnore;

	@Lob
	@Column(name="ROW_DATA")
	private String rowData;

	@Column(name="TARGET_CATALOG_NAME", length=255)
	private String targetCatalogName;

	@Column(name="TARGET_SCHEMA_NAME", length=255)
	private String targetSchemaName;

	@Column(name="TARGET_TABLE_NAME", nullable=false, length=255)
	private String targetTableName;

	public GsyncIncomingError() {
	}

	public String getBinaryEncoding() {
		return this.binaryEncoding;
	}

	public void setBinaryEncoding(String binaryEncoding) {
		this.binaryEncoding = binaryEncoding;
	}

	public String getColumnNames() {
		return this.columnNames;
	}

	public void setColumnNames(String columnNames) {
		this.columnNames = columnNames;
	}

	public String getConflictId() {
		return this.conflictId;
	}

	public void setConflictId(String conflictId) {
		this.conflictId = conflictId;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getCurData() {
		return this.curData;
	}

	public void setCurData(String curData) {
		this.curData = curData;
	}

	public String getEventType() {
		return this.eventType;
	}

	public void setEventType(String eventType) {
		this.eventType = eventType;
	}

	public BigDecimal getFailedLineNumber() {
		return this.failedLineNumber;
	}

	public void setFailedLineNumber(BigDecimal failedLineNumber) {
		this.failedLineNumber = failedLineNumber;
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

	public String getOldData() {
		return this.oldData;
	}

	public void setOldData(String oldData) {
		this.oldData = oldData;
	}

	public String getPkColumnNames() {
		return this.pkColumnNames;
	}

	public void setPkColumnNames(String pkColumnNames) {
		this.pkColumnNames = pkColumnNames;
	}

	public String getResolveData() {
		return this.resolveData;
	}

	public void setResolveData(String resolveData) {
		this.resolveData = resolveData;
	}

	public BigDecimal getResolveIgnore() {
		return this.resolveIgnore;
	}

	public void setResolveIgnore(BigDecimal resolveIgnore) {
		this.resolveIgnore = resolveIgnore;
	}

	public String getRowData() {
		return this.rowData;
	}

	public void setRowData(String rowData) {
		this.rowData = rowData;
	}

	public String getTargetCatalogName() {
		return this.targetCatalogName;
	}

	public void setTargetCatalogName(String targetCatalogName) {
		this.targetCatalogName = targetCatalogName;
	}

	public String getTargetSchemaName() {
		return this.targetSchemaName;
	}

	public void setTargetSchemaName(String targetSchemaName) {
		this.targetSchemaName = targetSchemaName;
	}

	public String getTargetTableName() {
		return this.targetTableName;
	}

	public void setTargetTableName(String targetTableName) {
		this.targetTableName = targetTableName;
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
	public long getFailedRowNumber() {
		return this.failedRowNumber;
	}
	public void setFailedRowNumber(long failedRowNumber) {
		this.failedRowNumber = failedRowNumber;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof GsyncIncomingError)) {
			return false;
		}
		GsyncIncomingError castOther = (GsyncIncomingError)other;
		return 
			(this.batchId == castOther.batchId)
			&& this.nodeId.equals(castOther.nodeId)
			&& (this.failedRowNumber == castOther.failedRowNumber);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + ((int) (this.batchId ^ (this.batchId >>> 32)));
		hash = hash * prime + this.nodeId.hashCode();
		hash = hash * prime + ((int) (this.failedRowNumber ^ (this.failedRowNumber >>> 32)));
		
		return hash;
	}
}