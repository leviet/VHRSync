---- DROP ROLE "symmetric";
--CREATE ROLE "symmetric" LOGIN PASSWORD '123456a@' SUPERUSER INHERIT CREATEDB CREATEROLE REPLICATION;

---- DROP DATABASE ghr_center;
--CREATE DATABASE ghr_center WITH OWNER = "symmetric"
--       ENCODING = 'UTF8'
--       TABLESPACE = pg_default
--       LC_COLLATE = 'en_US.UTF-8'
--       LC_CTYPE = 'en_US.UTF-8'
--       CONNECTION LIMIT = -1;

---- DROP SCHEMA vhr_td;
--CREATE SCHEMA gsync_stagedb_vhr_td AUTHORIZATION "symmetric";

-----------------------------------------------
-- Clean-up gsym configurations

delete from gsync_conflict;
delete from gsync_transform_column;
delete from gsync_transform_table;
delete from gsync_trigger_router;
delete from gsync_router;
delete from gsync_trigger;
delete from gsync_channel;
delete from gsync_node_group_link;
delete from gsync_node_group;
delete from gsync_node_identity;
delete from gsync_node_security;
delete from gsync_node;

-----------------------------------------------
-- Setup node groups and node group links

-- Node Group: GHR Center
insert into gsync_node_group (node_group_id, description, create_time, last_update_by, last_update_time)
	values ('ghr_center', 'GHR Center node group', current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_node(node_id, node_group_id, external_id, sync_enabled)
    values ('ghr_center', 'ghr_center', 'ghr_center', 1);
insert into gsync_node_security (node_id, node_password, registration_enabled, registration_time, initial_load_enabled, initial_load_time, initial_load_id, initial_load_create_by, rev_initial_load_enabled, rev_initial_load_time, rev_initial_load_id, rev_initial_load_create_by, created_at_node_id) 
	values ('ghr_center', '123456a@', 0, current_timestamp, 0, current_timestamp, null, null, 0, null, null, null, 'ghr_center');
insert into gsync_node_identity
	values ('ghr_center');

-- Node Group: VHR Tap doan
insert into gsync_node_group (node_group_id, description, create_time, last_update_by, last_update_time)
	values ('vhr_td', 'VHR Tap doan node group', current_timestamp, 'gsync_admin', current_timestamp);
--insert into gsync_node(node_id, node_group_id, external_id, sync_enabled)
--    values ('vhr_td', 'vhr_td', 'vhr_001', 1);

-- Node Group: VHR TT A
--insert into gsync_node_group (node_group_id, description, create_time, last_update_by, last_update_time)
--	values ('vhr_tt_a', 'VHR TT A node group', current_timestamp, 'gsync_admin', current_timestamp);
--insert into gsync_node(node_id, node_group_id, external_id, sync_enabled)
--    values ('vhr_tt_a', 'vhr_tt_a', 'vhr_002', 1);

-- Node Group: VHR TT B
--insert into gsync_node_group (node_group_id, description, create_time, last_update_by, last_update_time)
--	values ('vhr_tt_b', 'VHR TT A node group', current_timestamp, 'gsync_admin', current_timestamp);
--insert into gsync_node(node_id, node_group_id, external_id, sync_enabled)
--    values ('vhr_tt_b', 'vhr_tt_b', 'vhr_003', 1);

-- Node Group Links: VHR nodes => GHR Center
insert into gsync_node_group_link(source_node_group_id, target_node_group_id, data_event_action, create_time, last_update_by, last_update_time)
    values ('vhr_td', 'ghr_center', 'W', current_timestamp, 'gsync_admin', current_timestamp);
--insert into gsync_node_group_link(source_node_group_id, target_node_group_id, data_event_action, create_time, last_update_by, last_update_time)
--    values ('vhr_tt_a', 'ghr_center', 'W', current_timestamp, 'gsync_admin', current_timestamp);
--insert into gsync_node_group_link(source_node_group_id, target_node_group_id, data_event_action, create_time, last_update_by, last_update_time)
--    values ('vhr_tt_b', 'ghr_center', 'W', current_timestamp, 'gsync_admin', current_timestamp);

-- Node Group Links: GHR Center => VHR nodes
insert into gsync_node_group_link(source_node_group_id, target_node_group_id, data_event_action, create_time, last_update_by, last_update_time)
    values ('ghr_center', 'vhr_td', 'P', current_timestamp, 'gsync_admin', current_timestamp);
--insert into gsync_node_group_link(source_node_group_id, target_node_group_id, data_event_action, create_time, last_update_by, last_update_time)
--    values ('ghr_center', 'vhr_tt_a', 'P', current_timestamp, 'gsync_admin', current_timestamp);
--insert into gsync_node_group_link(source_node_group_id, target_node_group_id, data_event_action, create_time, last_update_by, last_update_time)
--    values ('ghr_center', 'vhr_tt_b', 'P', current_timestamp, 'gsync_admin', current_timestamp);

-------------------------------------------
-- Setup channels

-- Global Sync data channel
insert into gsync_channel(channel_id, processing_order, max_batch_size, max_batch_to_send, enabled, contains_big_lob, batch_algorithm, data_loader_type, description, create_time, last_update_by, last_update_time)
    values ('gsyncdata', 5, 10000, 60, 1, 0, 'default', 'default', 'Transfers global sync data between GHR-Center node and VHR nodes', current_timestamp, 'gsync_admin', current_timestamp);

-- VHR Tap doan's VHR data channel
insert into gsync_channel(channel_id, processing_order, max_batch_size, max_batch_to_send, enabled, contains_big_lob, batch_algorithm, data_loader_type, description, create_time, last_update_by, last_update_time)
    values ('vhr_td_vhrdata', 20, 10000, 60, 1, 0, 'default', 'vhrdata', 'Transfers VHR data changes from VHR Tap doan to GHR-Center', current_timestamp, 'gsync_admin', current_timestamp);

-- Service channel
--insert into gsync_channel(channel_id, processing_order, max_batch_size, max_batch_to_send, enabled, contains_big_lob, batch_algorithm, data_loader_type, description, create_time, last_update_by, last_update_time)
--    values ('ghr_center_servicedata', 10, 10000, 60, 1, 0, 'default', 'ghrcenterServiceDataLoader', 'Transfers GHR service data from GHR-Center node to VHR nodes', current_timestamp, 'gsync_admin', current_timestamp);

--insert into gsync_channel(channel_id, processing_order, max_batch_size, max_batch_to_send, enabled, contains_big_lob, batch_algorithm, data_loader_type, description, create_time, last_update_by, last_update_time)
--    values ('vhr_tt_a_vhrdata', 20, 10000, 60, 1, 0, 'default', 'vhrdata', 'Transfers VHR data changes from VHR TT A to GHR-Center', current_timestamp, 'gsync_admin', current_timestamp);


--------------------------------------------
-- Setup triggers

-- GHR Center: Triggers for Sync data
--insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
--    values ('ghr_center_ghr_resource', null, null, 'ghr_resource', 'gsyncdata', current_timestamp, 'gsync_admin', current_timestamp);

-- VHR Tap doan: Triggers for VHR data
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, row_id_expression, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', null, null, 'organization', 'vhr_td_vhrdata', '$(old).organization_id', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, row_id_expression, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', null, null, 'province', 'vhr_td_vhrdata', '$(old).province_id', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, sync_on_insert, sync_on_update, sync_on_delete, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', null, null, 'nation', 'vhr_td_vhrdata', 0, 0, 0, current_timestamp, 'gsync_admin', current_timestamp); -- dead trigger for 'nation' table

insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, row_id_expression,  create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', null, null, 'sys_cat', 'vhr_td_vhrdata', '$(old).sys_cat_id', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, row_id_expression,  create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', null, null, 'sys_cat_type', 'vhr_td_vhrdata', '$(old).sys_cat_type_id', current_timestamp, 'gsync_admin', current_timestamp);

-- VHR Tap doan: Triggers for Sync data (note: sync on update only and exclude other columns than pk and resource_pk <= using conflict resolver)
--insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, sync_on_insert, sync_on_update, sync_on_delete, create_time, last_update_by, last_update_time)
--    values ('vhr_td_ghr_resource', null, null, 'ghr_resource', 'gsyncdata', 0, 1, 0, current_timestamp, 'gsync_admin', current_timestamp);

----------------------------------------------
-- Setup routers

-- GHR Center => VHR Tap doan: Router & Triggers for Sync data (note: filter data corresponding to target node)
insert into gsync_router(router_id, target_catalog_name, target_schema_name, source_node_group_id, target_node_group_id, router_type, router_expression, create_time, last_update_by, last_update_time)
    values ('ghr_center_gsyncdata_2_vhr_td', null, '$(none)', 'ghr_center', 'vhr_td', 'default', null, current_timestamp, 'gsync_admin', current_timestamp);

--insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
--    values ('ghr_center_ghr_resource', 'ghr_center_gsyncdata_2_vhr_td', 1, 10, current_timestamp, 'gsync_admin', current_timestamp);

-- GHR Center => VHR TT A: Router & Triggers for Sync data (note: filter data corresponding to target node)
-- insert into gsync_router(router_id, target_catalog_name, target_schema_name, source_node_group_id, target_node_group_id, router_type, router_expression, create_time, last_update_by, last_update_time)
--     values ('ghr_center_gsyncdata_2_vhr_tt_a', null, '$(none)', 'ghr_center', 'vhr_tt_a', 'column', 'sym_node_id=:NODE_ID', current_timestamp, 'gsync_admin', current_timestamp);

-- insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
--     values ('ghr_center_ghr_resource', 'ghr_center_gsyncdata_2_vhr_tt_a', 1, 10, current_timestamp, 'gsync_admin', current_timestamp);

-- VHR Tap doan => GHR Center: Routers & TriggerRouters for Sync data (note: filter for target node)
insert into gsync_router(router_id, target_catalog_name, target_schema_name, source_node_group_id, target_node_group_id, router_type, router_expression, create_time, last_update_by, last_update_time)
    values ('vhr_td_gsyncdata_2_ghr_center', null, '$(none)', 'vhr_td', 'ghr_center', 'default', null, current_timestamp, 'gsync_admin', current_timestamp);

--insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order,  create_time, last_update_by, last_update_time)
--   values ('vhr_td_ghr_resource', 'vhr_td_gsyncdata_2_ghr_center', 1, 10, current_timestamp, 'gsync_admin', current_timestamp);

-- VHR Tap doan => GHR Center: Router & TriggerRouters for VHR data
insert into gsync_router(router_id, target_catalog_name, target_schema_name, source_node_group_id, target_node_group_id, router_type, router_expression, create_time, last_update_by, last_update_time)
    values ('vhr_td_vhrdata_2_ghr_center', null, 'gsync_stagedb_vhr_td', 'vhr_td', 'ghr_center', 'default', null, current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order,  create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', 'vhr_td_vhrdata_2_ghr_center', 1, 50, current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', 'vhr_td_vhrdata_2_ghr_center', 1, 51, current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'vhr_td_vhrdata_2_ghr_center', 1, 52, current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'vhr_td_vhrdata_2_ghr_center', 1, 53, current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'vhr_td_vhrdata_2_ghr_center', 1, 54, current_timestamp, 'gsync_admin', current_timestamp);


----------------------------------------------
-- Setup conflict resolver for sync data

--insert into gsync_conflict(conflict_id, source_node_group_id, target_node_group_id, target_channel_id, target_catalog_name, target_schema_name, target_table_name, detect_type, detect_expression, resolve_type, ping_back, resolve_changes_only, resolve_row_only, create_time, last_update_by, last_update_time)
--    values ('gsyncdata_ghr_resource', 'vhr_td', 'ghr_center', 'gsyncdata', null, null, 'ghr_resource', 'USE_PK_DATA', null, 'IGNORE', 'OFF', 0, 0, current_timestamp, 'gsync_admin', current_timestamp);

