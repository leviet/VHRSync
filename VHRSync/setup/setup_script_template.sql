-----------------------------------------------
-- Clean-up sym configurations

delete from ${prefix}_conflict;
delete from ${prefix}_transform_column;
delete from ${prefix}_transform_table;
delete from ${prefix}_trigger_router;
delete from ${prefix}_router;
delete from ${prefix}_trigger;
delete from ${prefix}_channel;
delete from ${prefix}_node_group_link;
delete from ${prefix}_node_group;
delete from ${prefix}_node_identity;
delete from ${prefix}_node_security;
delete from ${prefix}_node;

-----------------------------------------------
-- Setup node groups and node group links

-- Node Group: VHR_TD
insert into ${prefix}_node_group (node_group_id, description, create_time, last_update_by, last_update_time)
	values ('vhr_td', 'VHR Tap doan node group', current_timestamp, '${admin_name}', current_timestamp);
insert into ${prefix}_node(node_id, node_group_id, external_id, sync_enabled)
    values ('vhr_td', 'vhr_td', 'vhr_td', 1);
insert into ${prefix}_node_security (node_id, node_password, registration_enabled, registration_time, initial_load_enabled, initial_load_time, initial_load_id, initial_load_create_by, rev_initial_load_enabled, rev_initial_load_time, rev_initial_load_id, rev_initial_load_create_by, created_at_node_id) 
	values ('vhr_td', '123456a@', 0, current_timestamp, 0, current_timestamp, null, null, 0, null, null, null, 'vhr_td');
insert into ${prefix}_node_identity (node_id)
	values ('vhr_td');

-- Node Group: VHR VTC
insert into ${prefix}_node_group (node_group_id, description, create_time, last_update_by, last_update_time)
	values ('vhr_vtc', 'VHR VTC node group', current_timestamp, '${admin_name}', current_timestamp);
insert into ${prefix}_node(node_id, node_group_id, external_id, sync_enabled)
    values ('vhr_vtc', 'vhr_vtc', 'vhr_vtc', 1);


-- Node Group Links: VHR VTC => VHR TD
insert into ${prefix}_node_group_link(source_node_group_id, target_node_group_id, data_event_action, create_time, last_update_by, last_update_time)
    values ('vhr_vtc', 'vhr_td', 'W', current_timestamp, '${admin_name}', current_timestamp);

-- Node Group Links: VHR TD => VHR VTC
insert into ${prefix}_node_group_link(source_node_group_id, target_node_group_id, data_event_action, create_time, last_update_by, last_update_time)
    values ('vhr_td', 'vhr_vtc', 'P', current_timestamp, '${admin_name}', current_timestamp);

-------------------------------------------

-- Setup channels

-- VHR Tap doan's VHR data channel
insert into ${prefix}_channel(channel_id, processing_order, max_batch_size, max_batch_to_send, enabled, contains_big_lob, batch_algorithm, data_loader_type, description, create_time, last_update_by, last_update_time)
    values ('vhr_td_vhrdata', 20, 10000, 60, 1, 0, 'default', 'vhrdata', 'Transfers VHR data changes from VHR Tap doan to VHR-VTC', current_timestamp, '${admin_name}', current_timestamp);


--------------------------------------------

-- Setup triggers

-- VHR Tap doan: Triggers for VHR data
insert into ${prefix}_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', null, null, 'SYS_CAT_TYPE', 'vhr_td_vhrdata', current_timestamp, '${admin_name}', current_timestamp);


----------------------------------------------

-- Setup routers

-- VHR Tap doan => VHR VTC: Router & TriggerRouters for VHR data
insert into ${prefix}_router(router_id, target_catalog_name, target_schema_name, source_node_group_id, target_node_group_id, router_type, router_expression, create_time, last_update_by, last_update_time)
    values ('vhr_td_vhrdata_2_vhr_vtc', null, null, 'vhr_td', 'vhr_vtc', 'default', null, current_timestamp, '${admin_name}', current_timestamp);

insert into ${prefix}_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'vhr_td_vhrdata_2_vhr_vtc', 1, 50, current_timestamp, '${admin_name}', current_timestamp);

