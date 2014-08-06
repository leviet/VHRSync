package com.myapp.BO;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The primary key class for the GSYNC_TABLE_RELOAD_REQUEST database table.
 * 
 */
@Embeddable
public class GsyncTableReloadRequestPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="TARGET_NODE_ID")
	private String targetNodeId;

	@Column(name="SOURCE_NODE_ID")
	private String sourceNodeId;

	@Column(name="TRIGGER_ID")
	private String triggerId;

	@Column(name="ROUTER_ID")
	private String routerId;

	public GsyncTableReloadRequestPK() {
	}
	public String getTargetNodeId() {
		return this.targetNodeId;
	}
	public void setTargetNodeId(String targetNodeId) {
		this.targetNodeId = targetNodeId;
	}
	public String getSourceNodeId() {
		return this.sourceNodeId;
	}
	public void setSourceNodeId(String sourceNodeId) {
		this.sourceNodeId = sourceNodeId;
	}
	public String getTriggerId() {
		return this.triggerId;
	}
	public void setTriggerId(String triggerId) {
		this.triggerId = triggerId;
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
		if (!(other instanceof GsyncTableReloadRequestPK)) {
			return false;
		}
		GsyncTableReloadRequestPK castOther = (GsyncTableReloadRequestPK)other;
		return 
			this.targetNodeId.equals(castOther.targetNodeId)
			&& this.sourceNodeId.equals(castOther.sourceNodeId)
			&& this.triggerId.equals(castOther.triggerId)
			&& this.routerId.equals(castOther.routerId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.targetNodeId.hashCode();
		hash = hash * prime + this.sourceNodeId.hashCode();
		hash = hash * prime + this.triggerId.hashCode();
		hash = hash * prime + this.routerId.hashCode();
		
		return hash;
	}
}