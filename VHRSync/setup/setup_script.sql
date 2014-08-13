-----------------------------------------------
-- Clean-up sym configurations

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

-----------------------------------------------
-- Setup node groups and node group links

-- Node Group: VHR_TD
insert into gsync_node_group (node_group_id, description, create_time, last_update_by, last_update_time)
	values ('vhr_td', 'VHR Tap doan node group', current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_node_security (node_id, node_password, registration_enabled, registration_time, initial_load_enabled, initial_load_time, initial_load_id, initial_load_create_by, rev_initial_load_enabled, rev_initial_load_time, rev_initial_load_id, rev_initial_load_create_by, created_at_node_id) 
	values ('vhr_td', '123456a@', 0, current_timestamp, 0, current_timestamp, null, null, 0, null, null, null, 'vhr_td');
insert into gsync_node_identity (node_id)
	values ('vhr_td');

-- Node Group: VHR VTC
insert into gsync_node_group (node_group_id, description, create_time, last_update_by, last_update_time)
	values ('vhr_vtc', 'VHR VTC node group', current_timestamp, 'gsync_admin', current_timestamp);
--insert into gsync_node(node_id, node_group_id, external_id, sync_enabled)
--    values ('vhr_vtc', 'vhr_vtc', 'vhr_vtc', 1);


-- Node Group Links: VHR VTC => VHR TD
insert into gsync_node_group_link(source_node_group_id, target_node_group_id, data_event_action, create_time, last_update_by, last_update_time)
    values ('vhr_vtc', 'vhr_td', 'P', current_timestamp, 'gsync_admin', current_timestamp);

-- Node Group Links: VHR TD => VHR VTC
insert into gsync_node_group_link(source_node_group_id, target_node_group_id, data_event_action, create_time, last_update_by, last_update_time)
    values ('vhr_td', 'vhr_vtc', 'P', current_timestamp, 'gsync_admin', current_timestamp);

-------------------------------------------

-- Setup channels

-- VHR Tap doan's VHR data channel
insert into gsync_channel(channel_id, processing_order, max_batch_size, max_batch_to_send, enabled, contains_big_lob, batch_algorithm, data_loader_type, description, create_time, last_update_by, last_update_time)
    values ('vhr_td_vhrdata', 20, 10000, 60, 1, 0, 'default', 'default', 'Transfers VHR data changes from VHR Tap doan to VHR-VTC', current_timestamp, 'gsync_admin', current_timestamp);


-- VHR-VTC to VHR-TD data channel
--insert into gsync_channel(channel_id, processing_order, max_batch_size, max_batch_to_send, enabled, contains_big_lob, batch_algorithm, data_loader_type, description, create_time, last_update_by, last_update_time)
--    values ('vhr_vtc_2_vhr_td', 20, 10000, 60, 1, 0, 'default', 'default', 'Transfers VHR data changes from VHR-VTC to VHR Tap doan', current_timestamp, 'gsync_admin', current_timestamp);

--------------------------------------------

-- Setup triggers

-- VHR Tap doan: Triggers for VHR data
-- SYS_CAT_TYPE
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', null, null, 'SYS_CAT_TYPE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- VietLV2
--  EMP_TYPE
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', null, null, 'EMP_TYPE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- LANGUAGE
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_language', null, null, 'LANGUAGE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- NATION
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', null, null, 'NATION', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- WORKDAY_TYPE
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', null, null, 'WORKDAY_TYPE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- SYS_CAT
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', null, null, 'SYS_CAT', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- ALLOWANCE
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', null, null, 'ALLOWANCE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- DIAGNOSE_PLACE
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_diagnose_place', null, null, 'DIAGNOSE_PLACE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- DOCUMENT_REASON
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_reson', null, null, 'DOCUMENT_REASON', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- DOCUMENT_TYPE
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', null, null, 'DOCUMENT_TYPE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- LABOUR_CONTRACT_TYPE 
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_type', null, null, 'LABOUR_CONTRACT_TYPE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- LABOUR_CONTRACT_DETAIL
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_detail', null, null, 'LABOUR_CONTRACT_DETAIL', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- LANGUAGE_DEGREE 
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_language_degree', null, null, 'LANGUAGE_DEGREE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- LONG_LEAVE_REASON 
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_long_leave_reson', null, null, 'LONG_LEAVE_REASON', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- POSITION 
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', null, null, 'POSITION', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- POSITION_GROUP 
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', null, null, 'POSITION_GROUP', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- POSITION_POSITION_GROUP
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_position_group', null, null, 'POSITION_POSITION_GROUP', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- PROVINCE 
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', null, null, 'PROVINCE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- SALARY_TABLE
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', null, null, 'SALARY_TABLE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- SALARY_GRADE
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', null, null, 'SALARY_GRADE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- POSITION_WAGE
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_wage', null, null, 'POSITION_WAGE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- ORGANIZATION
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, sync_on_incoming_batch, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', null, null, 'ORGANIZATION', 'vhr_td_vhrdata', 1, current_timestamp, 'gsync_admin', current_timestamp);
-- ORG_RELATION
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_org_relation', null, null, 'ORG_RELATION', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- SALARY_ORGANIZATION
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', null, null, 'SALARY_ORGANIZATION', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- EMPLOYEE
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', null, null, 'EMPLOYEE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- BANK_ACCOUNT
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_bank_account', null, null, 'BANK_ACCOUNT', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- OTHER_PARTY
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_orther_party', null, null, 'OTHER_PARTY', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- EDUCATION_PROCESS
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_education_process', null, null, 'EDUCATION_PROCESS', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- EMP_LANGUAGE_DEGREE
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_language_degree', null, null, 'EMP_LANGUAGE_DEGREE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- EMP_POLITICAL_DEGREE
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_political_degree', null, null, 'EMP_POLITICAL_DEGREE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- EMP_TYPE_PROCESS
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type_process', null, null, 'EMP_TYPE_PROCESS', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- WORK_PROCESS
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_work_process', null, null, 'WORK_PROCESS', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
--TRANSFER_PROCESS
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_transfer_process', null, null, 'TRANSFER_PROCESS', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- REWARD
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward', null, null, 'REWARD', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- PUNISHMENT
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_punishment', null, null, 'PUNISHMENT', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- LONG_LEAVE
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_long_leave', null, null, 'LONG_LEAVE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- FAMILY_RELATIONSHIP
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_family_relationship', null, null, 'FAMILY_RELATIONSHIP', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- HEAlTH_INFO
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_health_info', null, null, 'HEAlTH_INFO', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- SALARY_PROCESS
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_process', null, null, 'SALARY_PROCESS', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- POSITION_SALARY
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_salary', null, null, 'POSITION_SALARY', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- SALARY_INCREASE
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_increase', null, null, 'SALARY_INCREASE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- INSURANCE_SALARY_PROCESS
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_insurance_salary_process', null, null, 'INSURANCE_SALARY_PROCESS', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- EMP_FILE
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_file', null, null, 'EMP_FILE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- EMP_ALLOWANCE_PROCESS
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_allowance_process', null, null, 'EMP_ALLOWANCE_PROCESS', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- INFO_CHANGE
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_info_change', null, null, 'INFO_CHANGE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- EMP_TIMEKEEPING
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, sync_on_update, sync_on_insert, sync_on_delete, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_timekeeping', null, null, 'EMP_TIMEKEEPING', 'vhr_td_vhrdata', 0, 0, 0, current_timestamp, 'gsync_admin', current_timestamp);    
--  ORG_COMPLEMENT_LOCK
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_org_complement_lock', null, null, 'ORG_COMPLEMENT_LOCK', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- ORG_OPEN_CLOSE_TIMEKEEPING
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_org_open_close_timekeeping', null, null, 'ORG_OPEN_CLOSE_TIMEKEEPING', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
----------------------------------------------

-- Setup routers

-- VHR Tap doan => VHR VTC: Router & TriggerRouters for VHR data
insert into gsync_router(router_id, target_catalog_name, target_schema_name, source_node_group_id, target_node_group_id, router_type, router_expression, create_time, last_update_by, last_update_time)
    values ('vhr_td_vhrdata_2_vhr_vtc', null, null, 'vhr_td', 'vhr_vtc', 'default', null, current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_router(router_id, target_catalog_name, target_schema_name, source_node_group_id, target_node_group_id, router_type, router_expression, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization_2_vhr_vtc', null, null, 'vhr_td', 'vhr_vtc', 'bsh', '!ORG_CODE_PATH.startsWith("/KH/");', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_router(router_id, target_catalog_name, target_schema_name, source_node_group_id, target_node_group_id, router_type, router_expression, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization_2_vhr_td', null, null, 'vhr_vtc', 'vhr_td', 'bsh', 'engine.getExtensionBean("syncOrganization",com.viettel.ghr.ghrcenter.vtgroup.service.IOrganizationService.class).checkOrganizationSyncToTD(ORG_CODE_PATH,CODE);', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_router(router_id, target_catalog_name, target_schema_name, source_node_group_id, target_node_group_id, router_type, router_expression, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee_2_vhr_vtc', null, null, 'vhr_td', 'vhr_vtc', 'bsh', 'engine.getExtensionBean("vhrTdEmployeeService",com.viettel.ghr.ghrcenter.vtgroup.service.IEmployeeService.class).checkEmployeeForSyncing(EMPLOYEE_ID);', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_router(router_id, target_catalog_name, target_schema_name, source_node_group_id, target_node_group_id, router_type, router_expression, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_employee_2_vhr_td', null, null, 'vhr_vtc', 'vhr_td', 'bsh', 'engine.getExtensionBean("vhrTdEmployeeService",com.viettel.ghr.ghrcenter.vtgroup.service.IEmployeeService.class).checkEmployeeSyncFromVTC(EMPLOYEE_ID);', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_router(router_id, target_catalog_name, target_schema_name, source_node_group_id, target_node_group_id, router_type, router_expression, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_2_vhr_td_vhrdata', null, null, 'vhr_vtc', 'vhr_td', 'bsh', 'engine.getExtensionBean("syncTimekeepingService",com.viettel.ghr.ghrcenter.vtgroup.service.IEmployeeTimekeepingService.class).checkEmployeeSyncTimekeeping(EMPLOYEE_ID);', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_router(router_id, target_catalog_name, target_schema_name, source_node_group_id, target_node_group_id, router_type, router_expression, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_vhrdata_2_vhr_td', null, null, 'vhr_vtc', 'vhr_td', 'default', null, current_timestamp, 'gsync_admin', current_timestamp);


insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'vhr_td_vhrdata_2_vhr_vtc', 1, 50, current_timestamp, 'gsync_admin', current_timestamp);
-- VietLV2
--  EMP_TYPE    
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', 'vhr_td_vhrdata_2_vhr_vtc', 1, 50, current_timestamp, 'gsync_admin', current_timestamp);
-- LANGUAGE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_language', 'vhr_td_vhrdata_2_vhr_vtc', 1, 50, current_timestamp, 'gsync_admin', current_timestamp);
-- NATION
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', 'vhr_td_vhrdata_2_vhr_vtc', 1, 50, current_timestamp, 'gsync_admin', current_timestamp);
-- WORKDAY_TYPE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'vhr_td_vhrdata_2_vhr_vtc', 1, 50, current_timestamp, 'gsync_admin', current_timestamp);
-- SYS_CAT
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'vhr_td_vhrdata_2_vhr_vtc', 1, 50, current_timestamp, 'gsync_admin', current_timestamp);
-- ALLOWANCE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'vhr_td_vhrdata_2_vhr_vtc', 1, 51, current_timestamp, 'gsync_admin', current_timestamp);
-- DIAGNOSE_PLACE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_diagnose_place', 'vhr_td_vhrdata_2_vhr_vtc', 1, 51, current_timestamp, 'gsync_admin', current_timestamp);
-- DOCUMENT_REASON
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_reson', 'vhr_td_vhrdata_2_vhr_vtc', 1, 52, current_timestamp, 'gsync_admin', current_timestamp);
-- DOCUMENT_TYPE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'vhr_td_vhrdata_2_vhr_vtc', 1, 51, current_timestamp, 'gsync_admin', current_timestamp);
-- LABOUR_CONTRACT_TYPE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_type', 'vhr_td_vhrdata_2_vhr_vtc', 1, 51, current_timestamp, 'gsync_admin', current_timestamp);
-- LABOUR_CONTRACT_DETAIL
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_detail', 'vhr_td_vhrdata_2_vhr_vtc', 1, 52, current_timestamp, 'gsync_admin', current_timestamp);
-- LANGUAGE_DEGREE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_language_degree', 'vhr_td_vhrdata_2_vhr_vtc', 1, 52, current_timestamp, 'gsync_admin', current_timestamp);
-- LONG_LEAVE_REASON
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_long_leave_reson', 'vhr_td_vhrdata_2_vhr_vtc', 1, 51, current_timestamp, 'gsync_admin', current_timestamp);
-- POSITION
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'vhr_td_vhrdata_2_vhr_vtc', 1, 52, current_timestamp, 'gsync_admin', current_timestamp);
-- POSITION_GROUP
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'vhr_td_vhrdata_2_vhr_vtc', 1, 51, current_timestamp, 'gsync_admin', current_timestamp);
-- POSITION_POSITION_GROUP
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_position_group', 'vhr_td_vhrdata_2_vhr_vtc', 1, 52, current_timestamp, 'gsync_admin', current_timestamp);
-- SALARY_TABLE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'vhr_td_vhrdata_2_vhr_vtc', 1, 51,'1 = 1 start with parent_id is NULL connect by parent_id = PRIOR salary_table_id', current_timestamp, 'gsync_admin', current_timestamp);
-- SALARY_GRADE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'vhr_td_vhrdata_2_vhr_vtc', 1, 52, current_timestamp, 'gsync_admin', current_timestamp);
-- POSITION_WAGE;
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_wage', 'vhr_td_vhrdata_2_vhr_vtc', 1, 53, current_timestamp, 'gsync_admin', current_timestamp);
-- PROVINCE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', 'vhr_td_vhrdata_2_vhr_vtc', 1, 52, current_timestamp, 'gsync_admin', current_timestamp);
-- ORGANIZATION
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'vhr_td_vhrdata_2_vhr_vtc', 1, 52,'1=1 start with ORG_PARENT_ID is NULL connect by ORG_PARENT_ID = PRIOR ORGANIZATION_ID', current_timestamp, 'gsync_admin', current_timestamp);
-- ORG_RELATION
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_org_relation', 'vhr_td_vhrdata_2_vhr_vtc', 1, 53, null, current_timestamp, 'gsync_admin', current_timestamp);
-- SALARY_ORGANIZATION
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'vhr_td_vhrdata_2_vhr_vtc', 1, 51,'1 = 1 start with PARENT_ID is NULL connect by PARENT_ID = PRIOR SALARY_ORGANIZATION_ID', current_timestamp, 'gsync_admin', current_timestamp);
-- EMPLOYEE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'vhr_td_employee_2_vhr_vtc', 1, 51,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- BANK_ACCOUNT
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_bank_account', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- OTHER_PARTY
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_orther_party', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- EDUCATION_PROCESS
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_education_process', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- EMP_LANGUAGE_DEGREE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_language_degree', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- EMP_POLITICAL_DEGREE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_political_degree', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- EMP_TYPE_PROCESS
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type_process', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- WORK_PROCESS
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_work_process', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- TRANSFER_PROCESS
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_transfer_process', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- REWARD
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward', 'vhr_td_employee_2_vhr_vtc', 1, 55,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- PUNISHMENT
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_punishment', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- LONG_LEAVE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_long_leave', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- FAMILY_RELATIONSHIP
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_family_relationship', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- HEAlTH_INFO
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_health_info', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- SALARY_PROCESS
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_process', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- POSITION_SALARY
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_salary', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- SALARY_INCREASE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_increase', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- INSURANCE_SALARY_PROCESS
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_insurance_salary_process', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- EMP_FILE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_file', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- EMP_ALLOWANCE_PROCESS
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_allowance_process', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- INFO_CHANGE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_info_change', 'vhr_td_employee_2_vhr_vtc', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE_ONSITE_VTC_LOG)', current_timestamp, 'gsync_admin', current_timestamp);
-- ORG_COMPLEMENT_LOCK
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_org_complement_lock', 'vhr_td_vhrdata_2_vhr_vtc', 1, 55, current_timestamp, 'gsync_admin', current_timestamp);
-- ORG_OPEN_CLOSE_TIMEKEEPING
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_org_open_close_timekeeping', 'vhr_td_vhrdata_2_vhr_vtc', 1, 55, current_timestamp, 'gsync_admin', current_timestamp);
-- Chieu VTC->TD
    
-- EMP_TIMEKEEPING
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_timekeeping', 'vhr_vtc_2_vhr_td_vhrdata', 1, 54,'EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEE WHERE EMPLOYEE_CODE NOT LIKE ''VTC%'')', current_timestamp, 'gsync_admin', current_timestamp);

-- ORGANIZATION 
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
values ('vhr_td_organization', 'vhr_vtc_vhrdata_2_vhr_td', 1, 52,'1=1 AND ORG_CODE_PATH like ''/TCT/VIG/50C/GIV/VCA/%'' start with ORG_PARENT_ID is NULL connect by ORG_PARENT_ID = PRIOR ORGANIZATION_ID', current_timestamp, 'gsync_admin', current_timestamp);
-- ORG_RELATION
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_org_relation', 'vhr_vtc_vhrdata_2_vhr_td', 1, 53, '1=1 AND ORGANIZATION_ID IN (SELECT ORGANIZATION_ID FROM ORGANIZATION WHERE ORG_CODE_PATH like ''/TCT/VIG/50C/GIV/VCA/%'') AND RELATIVE_ORGANIZATION_ID IN (SELECT ORGANIZATION_ID FROM ORGANIZATION WHERE ORG_CODE_PATH like ''/TCT/VIG/50C/GIV/VCA/%'')', current_timestamp, 'gsync_admin', current_timestamp);
-- SALARY_ORGANIZATION
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'vhr_vtc_vhrdata_2_vhr_td', 1, 53,null, current_timestamp, 'gsync_admin', current_timestamp);
-- WORK_PROCESS
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_work_process', 'vhr_vtc_employee_2_vhr_td', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE WHERE LENGTH(EMPLOYEE_CODE) = 6)', current_timestamp, 'gsync_admin', current_timestamp);
-- TRANSFER_PROCESS
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_transfer_process', 'vhr_vtc_employee_2_vhr_td', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE WHERE LENGTH(EMPLOYEE_CODE) = 6)', current_timestamp, 'gsync_admin', current_timestamp);
-- INFO_CHANGE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_info_change', 'vhr_vtc_employee_2_vhr_td', 1, 54,'EMPLOYEE_ID in (SELECT EMPLOYEE_ID FROM EMPLOYEE WHERE LENGTH(EMPLOYEE_CODE) = 6)', current_timestamp, 'gsync_admin', current_timestamp);
-- POSITION
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'vhr_vtc_vhrdata_2_vhr_td', 1, 52, current_timestamp, 'gsync_admin', current_timestamp);
-- POSITION_GROUP
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'vhr_vtc_vhrdata_2_vhr_td', 1, 51, current_timestamp, 'gsync_admin', current_timestamp);
-- POSITION_POSITION_GROUP
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_position_group', 'vhr_vtc_vhrdata_2_vhr_td', 1, 52, current_timestamp, 'gsync_admin', current_timestamp);

----------------------------------------------

-- Setup transformation
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'SYS_CAT_TYPE', null, null, 'SYS_CAT_TYPE', 'NONE', 1, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);
    
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', '*', 'SYS_CAT_TYPE_ID', 'SYS_CAT_TYPE_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'I', 'HAS_CODE', 'HAS_CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'I', 'HAS_EXPIRY_DATE', 'HAS_EXPIRY_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'I', 'HAS_IS_DEFAULT', 'HAS_IS_DEFAULT', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'I', 'HAS_DESCRIPTION', 'HAS_DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'I', 'TABLE_NAME', 'TABLE_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'I', 'SELECT_CLAUSE', 'SELECT_CLAUSE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'I', 'DELETE_CHILD_TABLES', 'DELETE_CHILD_TABLES', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'I', 'HAS_NAME', 'HAS_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'I', 'NAME_VI', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'U', 'HAS_CODE', 'HAS_CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'U', 'HAS_EXPIRY_DATE', 'HAS_EXPIRY_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'U', 'HAS_IS_DEFAULT', 'HAS_IS_DEFAULT', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'U', 'HAS_DESCRIPTION', 'HAS_DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'U', 'TABLE_NAME', 'TABLE_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'U', 'SELECT_CLAUSE', 'SELECT_CLAUSE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'U', 'DELETE_CHILD_TABLES', 'DELETE_CHILD_TABLES', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'U', 'HAS_NAME', 'HAS_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);  
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat_type', 'U', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);

-- VietLV2
--  EMP_TYPE
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'EMP_TYPE', null, null, 'EMP_TYPE', 'NONE', 1, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', 'I', 'USED', 'USED', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', 'I', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', '*', 'EMP_TYPE_ID', 'EMP_TYPE_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', 'I', 'HAS_LABOUR_CONTRACT_INFO', 'HAS_LABOUR_CONTRACT_INFO', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', 'I', 'HAS_SOLDIER_INFO', 'HAS_SOLDIER_INFO', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', 'I', 'EMP_TYPE_ORDER', 'EMP_TYPE_ORDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', 'I', 'NAME_VI', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', 'I', 'IS_DISPLAY', 0, 'const', '1', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', 'U', 'USED', 'USED', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', 'U', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', 'U', 'HAS_LABOUR_CONTRACT_INFO', 'HAS_LABOUR_CONTRACT_INFO', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', 'U', 'HAS_SOLDIER_INFO', 'HAS_SOLDIER_INFO', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_type', 'U', 'EMP_TYPE_ORDER', 'EMP_TYPE_ORDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
-- LANGUAGE
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_language', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'LANGUAGE', null, null, 'LANGUAGE', 'NONE', 1, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);   

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_language', '*', 'LANGUAGE_ID', 'LANGUAGE_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_language', 'I', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_language', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_language', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_language', 'I', 'NAME_VI', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_language', 'U', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_language', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);   
-- NATION
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'NATION', null, null, 'NATION', 'NONE', 1, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', 'I', 'REQUIRE_PERSONAL_ID', 'REQUIRE_PERSONAL_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', 'I', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', 'I', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', 'I', 'IS_DEFAULT', 'IS_DEFAULT', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', '*', 'NATION_ID', 'NATION_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);                                                                                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', 'I', 'NAME_VI', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', 'I', 'DESCRIPTION_EN', 'DESCRIPTION', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', 'I', 'DESCRIPTION_VI', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', 'U', 'REQUIRE_PERSONAL_ID', 'REQUIRE_PERSONAL_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', 'U', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', 'U', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', 'U', 'IS_DEFAULT', 'IS_DEFAULT', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_nation', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
-- WORKDAY_TYPE
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'WORKDAY_TYPE', null, null, 'WORKDAY_TYPE', 'NONE', 1, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);
    
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'I', 'IS_RETURN', 'IS_RETURN', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'I', 'OVERTIME_MODE', 'OVERTIME_MODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'I', 'SHIFT_MODE', 'SHIFT_MODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'I', 'AFFAIR_MODE', 'AFFAIR_MODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'I', 'INSURANCE_TYPE_ID', 'INSURANCE_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'I', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'I', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'I', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', '*', 'WORKDAY_TYPE_ID', 'WORKDAY_TYPE_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'I', 'NAME_VI', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'I', 'DESCRIPTION_EN', 'DESCRIPTION', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp); 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'I', 'DESCRIPTION_VI', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'I', 'DOMAIN', 0, 'const', 'VHR_VIETTELGROUP', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'I', 'IS_DISPLAY', 0, 'const', '1', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'U', 'IS_RETURN', 'IS_RETURN', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'U', 'OVERTIME_MODE', 'OVERTIME_MODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'U', 'SHIFT_MODE', 'SHIFT_MODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'U', 'AFFAIR_MODE', 'AFFAIR_MODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'U', 'INSURANCE_TYPE_ID', 'INSURANCE_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'U', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'U', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_workday_type', 'U', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);    
-- SYS_CAT
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'SYS_CAT', null, null, 'SYS_CAT', 'NONE', 1, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'I', 'SORT_ORDER', 'SORT_ORDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'I', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'I', 'EXPIRY_DATE', 'EXPIRY_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'I', 'SYS_CAT_TYPE_ID', 'SYS_CAT_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'I', 'IS_DEFAULT', 'IS_DEFAULT', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'I', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'I', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', '*', 'SYS_CAT_ID', 'SYS_CAT_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'I', 'MODIFIED_TIME', 'MODIFIED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'I', 'MODIFIED_BY', 'MODIFIED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'I', 'CREATED_TIME', 'CREATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'I', 'CREATED_BY', 'CREATED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                                                              
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'I', 'NAME_VI', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'I', 'DESCRIPTION_EN', 'DESCRIPTION', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);  
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'I', 'DESCRIPTION_VI', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'I', 'DOMAIN', 0, 'const', 'VHR_VIETTELGROUP', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'I', 'IS_DISPLAY', 0, 'const', '1', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'U', 'SORT_ORDER', 'SORT_ORDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'U', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'U', 'EXPIRY_DATE', 'EXPIRY_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'U', 'SYS_CAT_TYPE_ID', 'SYS_CAT_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'U', 'IS_DEFAULT', 'IS_DEFAULT', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'U', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'U', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'U', 'DOMAIN', 'DOMAIN', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'U', 'MODIFIED_TIME', 'MODIFIED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'U', 'MODIFIED_BY', 'MODIFIED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'U', 'CREATED_TIME', 'CREATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_sys_cat', 'U', 'CREATED_BY', 'CREATED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
-- ALLOWANCE
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'ALLOWANCE', null, null, 'ALLOWANCE', 'NONE', 1, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'I', 'TYPE_ID', 'TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'I', 'ALLOWANCE_TYPE_ID', 'ALLOWANCE_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'I', 'IS_ALLOWANCE_POS', 'IS_ALLOWANCE_POS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'I', 'AMOUNT_MONEY', 'AMOUNT_MONEY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'I', 'FACTOR', 'FACTOR', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'I', 'CALCULATED_BY', 'CALCULATED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'I', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', '*', 'ALLOWANCE_ID', 'ALLOWANCE_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);    
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'U', 'TYPE_ID', 'TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'U', 'ALLOWANCE_TYPE_ID', 'ALLOWANCE_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'U', 'IS_ALLOWANCE_POS', 'IS_ALLOWANCE_POS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'U', 'AMOUNT_MONEY', 'AMOUNT_MONEY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'U', 'FACTOR', 'FACTOR', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'U', 'CALCULATED_BY', 'CALCULATED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_allowance', 'U', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
-- DIAGNOSE_PLACE
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_diagnose_place', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'DIAGNOSE_PLACE', null, null, 'DIAGNOSE_PLACE', 'NONE', 1, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);
 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_diagnose_place', 'I', 'ADDRESS', 'ADDRESS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_diagnose_place', 'I', 'PROVINCE_ID', 'PROVINCE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_diagnose_place', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_diagnose_place', 'I', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_diagnose_place', '*', 'DIAGNOSE_PLACE_ID', 'DIAGNOSE_PLACE_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);    
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_diagnose_place', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_diagnose_place', 'I', 'ADDRESS_EN', 'ADDRESS', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_diagnose_place', 'U', 'ADDRESS', 'ADDRESS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_diagnose_place', 'U', 'PROVINCE_ID', 'PROVINCE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_diagnose_place', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_diagnose_place', 'U', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);   
-- DOCUMENT_REASON
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_reson', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'DOCUMENT_REASON', null, null, 'DOCUMENT_REASON', 'NONE', 2, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_reson', 'I', 'DOCUMENT_TYPE_ID', 'DOCUMENT_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_reson', 'I', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_reson', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_reson', '*', 'DOCUMENT_REASON_ID', 'DOCUMENT_REASON_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);                                                                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_reson', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_reson', 'I', 'NAME_VI', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_reson', 'I', 'DOMAIN', 0, 'const', 'VHR_VIETTELGROUP', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_reson', 'I', 'IS_DISPLAY', 0, 'const', '1', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_reson', 'U', 'DOCUMENT_TYPE_ID', 'DOCUMENT_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_reson', 'U', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_reson', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
-- DOCUMENT_TYPE
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'DOCUMENT_TYPE', null, null, 'DOCUMENT_TYPE', 'NONE', 1, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'I', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'I', 'INOUT_FLAG', 'INOUT_FLAG', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'I', 'IS_ORG_TYPE_CHANGE', 'IS_ORG_TYPE_CHANGE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'I', 'IS_PROCESS_END', 'IS_PROCESS_END', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'I', 'IS_PROCESS_START', 'IS_PROCESS_START', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'I', 'IS_ORG_STRUCTURE_CHANGE', 'IS_ORG_STRUCTURE_CHANGE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'I', 'USED', 'USED', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', '*', 'DOCUMENT_TYPE_ID', 'DOCUMENT_TYPE_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'I', 'NAME_VI', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'I', 'DOMAIN', 0, 'const', 'VHR_VIETTELGROUP', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'I', 'IS_DISPLAY', 0, 'const', '1', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'U', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'U', 'INOUT_FLAG', 'INOUT_FLAG', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'U', 'IS_ORG_TYPE_CHANGE', 'IS_ORG_TYPE_CHANGE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'U', 'IS_PROCESS_END', 'IS_PROCESS_END', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'U', 'IS_PROCESS_START', 'IS_PROCESS_START', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'U', 'IS_ORG_STRUCTURE_CHANGE', 'IS_ORG_STRUCTURE_CHANGE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'U', 'USED', 'USED', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_document_type', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
-- LABOUR_CONTRACT_TYPE
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_type', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'LABOUR_CONTRACT_TYPE', null, null, 'LABOUR_CONTRACT_TYPE', 'NONE', 1, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_type', 'I', 'EFFECTIVE_DURATION', 'EFFECTIVE_DURATION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_type', 'I', 'USED', 'USED', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_type', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_type', 'I', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_type', '*', 'LABOUR_CONTRACT_TYPE_ID', 'LABOUR_CONTRACT_TYPE_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_type', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_type', 'I', 'NAME_VI', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_type', 'I', 'DOMAIN', 0, 'const', 'VHR_VIETTELGROUP', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_type', 'I', 'IS_DISPLAY', 0, 'const', '1', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_type', 'U', 'EFFECTIVE_DURATION', 'EFFECTIVE_DURATION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_type', 'U', 'USED', 'USED', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_type', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_type', 'U', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_type', 'U', 'LABOUR_CONTRACT_TYPE_ID', 'LABOUR_CONTRACT_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);               
-- LABOUR_CONTRACT_DETAIL
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_detail', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'LABOUR_CONTRACT_DETAIL', null, null, 'LABOUR_CONTRACT_DETAIL', 'NONE', 2, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_detail', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_detail', 'I', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_detail', '*', 'LABOUR_CONTRACT_DETAIL_ID', 'LABOUR_CONTRACT_DETAIL_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_detail', 'I', 'EFFECTIVE_DURATION', 'EFFECTIVE_DURATION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_detail', 'I', 'LABOUR_CONTRACT_TYPE_ID', 'LABOUR_CONTRACT_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_detail', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_detail', 'I', 'NAME_VI', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_detail', 'I', 'DOMAIN', 0, 'const', 'VHR_VIETTELGROUP', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_detail', 'I', 'IS_DISPLAY', 0, 'const', '1', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_detail', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_detail', 'U', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_detail', 'U', 'EFFECTIVE_DURATION', 'EFFECTIVE_DURATION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_labour_contract_detail', 'U', 'LABOUR_CONTRACT_TYPE_ID', 'LABOUR_CONTRACT_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);               
-- LANGUAGE_DEGREE
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_language_degree', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'LANGUAGE_DEGREE', null, null, 'LANGUAGE_DEGREE', 'NONE', 2, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_language_degree', 'I', 'LANGUAGE_ID', 'LANGUAGE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_language_degree', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_language_degree', '*', 'LANGUAGE_DEGREE_ID', 'LANGUAGE_DEGREE_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_language_degree', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_language_degree', 'I', 'NAME_VI', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_language_degree', 'I', 'DOMAIN', 0, 'const', 'VHR_VIETTELGROUP', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_language_degree', 'I', 'IS_DISPLAY', 0, 'const', '1', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_language_degree', 'U', 'LANGUAGE_ID', 'LANGUAGE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_language_degree', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
-- LONG_LEAVE_REASON
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_long_leave_reson', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'LONG_LEAVE_REASON', null, null, 'LONG_LEAVE_REASON', 'NONE', 1, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_long_leave_reson', 'I', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_long_leave_reson', 'I', 'WORKDAY_TYPE_ID', 'WORKDAY_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_long_leave_reson', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_long_leave_reson', '*', 'LONG_LEAVE_REASON_ID', 'LONG_LEAVE_REASON_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_long_leave_reson', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_long_leave_reson', 'I', 'NAME_VI', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_long_leave_reson', 'I', 'DOMAIN', 0, 'const', 'VHR_VIETTELGROUP', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_long_leave_reson', 'I', 'IS_DISPLAY', 0, 'const', '1', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_long_leave_reson', 'U', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_long_leave_reson', 'U', 'WORKDAY_TYPE_ID', 'WORKDAY_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_long_leave_reson', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
-- POSITION
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'POSITION', null, null, 'POSITION', 'NONE', 2, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'POS_ORDER', 'POS_ORDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'EFFECTIVE_DATE', 'EFFECTIVE_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'EXPIRY_DATE', 'EXPIRY_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'POSITION_GROUP_ID', 'POSITION_GROUP_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'LABOUR_TYPE_ID', 'LABOUR_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'GENDER', 'GENDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'EXPERIENCE', 'EXPERIENCE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'NORM', 'NORM', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'POSITION_NAME', 'POSITION_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'POSITION_CODE', 'POSITION_CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', '*', 'POSITION_ID', 'POSITION_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'LANGUAGE_ID', 'LANGUAGE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'CREATED_BY', 'CREATED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'MODIFIED_BY', 'MODIFIED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'MODIFIED_TIME', 'MODIFIED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'CREATED_TIME', 'CREATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'POSITION_NAME_EN', 'POSITION_NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'POSITION_NAME_VI', 'POSITION_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'DESCRIPTION_EN', 'DESCRIPTION', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp); 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'DESCRIPTION_VI', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'DOMAIN', 0, 'const', 'VHR_VIETTELGROUP', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'I', 'IS_DISPLAY', 0, 'const', '1', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'U', 'POS_ORDER', 'POS_ORDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'U', 'EFFECTIVE_DATE', 'EFFECTIVE_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'U', 'EXPIRY_DATE', 'EXPIRY_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'U', 'POSITION_GROUP_ID', 'POSITION_GROUP_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'U', 'LABOUR_TYPE_ID', 'LABOUR_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'U', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'U', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'U', 'GENDER', 'GENDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'U', 'EXPERIENCE', 'EXPERIENCE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'U', 'NORM', 'NORM', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'U', 'POSITION_NAME', 'POSITION_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'U', 'POSITION_CODE', 'POSITION_CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'U', 'LANGUAGE_ID', 'LANGUAGE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'U', 'CREATED_BY', 'CREATED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'U', 'MODIFIED_BY', 'MODIFIED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'U', 'MODIFIED_TIME', 'MODIFIED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position', 'U', 'CREATED_TIME', 'CREATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);   
-- POSITION_GROUP
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'POSITION_GROUP', null, null, 'POSITION_GROUP', 'NONE', 1, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);
    
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'I', 'EXPIRY_DATE', 'EXPIRY_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'I', 'EFFECTIVE_DATE', 'EFFECTIVE_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'I', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'I', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'I', 'IS_MANAGEMENT', 'IS_MANAGEMENT', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', '*', 'POSITION_GROUP_ID', 'POSITION_GROUP_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'I', 'MODIFIED_TIME', 'MODIFIED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'I', 'MODIFIED_BY', 'MODIFIED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'I', 'CREATED_TIME', 'CREATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'I', 'CREATED_BY', 'CREATED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'I', 'NAME_VI', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'I', 'DESCRIPTION_EN', 'DESCRIPTION', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'I', 'DESCRIPTION_VI', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'I', 'DOMAIN', 0, 'const', 'VHR_VIETTELGROUP', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'I', 'IS_DISPLAY', 0, 'const', '1', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'U', 'EXPIRY_DATE', 'EXPIRY_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'U', 'EFFECTIVE_DATE', 'EFFECTIVE_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'U', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'U', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'U', 'IS_MANAGEMENT', 'IS_MANAGEMENT', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'U', 'MODIFIED_TIME', 'MODIFIED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'U', 'MODIFIED_BY', 'MODIFIED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'U', 'CREATED_TIME', 'CREATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_group', 'U', 'CREATED_BY', 'CREATED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
-- PROVINCE
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'PROVINCE', null, null, 'PROVINCE', 'NONE', 2, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', 'I', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', 'I', 'NATION_ID', 'NATION_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', 'I', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', 'I', 'IS_DEFAULT', 'IS_DEFAULT', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', '*', 'PROVINCE_ID', 'PROVINCE_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', 'I', 'NAME_VI', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', 'I', 'DESCRIPTION_EN', 'DESCRIPTION', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp); 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', 'I', 'DESCRIPTION_VI', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', 'U', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', 'U', 'NATION_ID', 'NATION_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', 'U', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', 'U', 'IS_DEFAULT', 'IS_DEFAULT', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_province', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
-- SALARY_TABLE
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'SALARY_TABLE', null, null, 'SALARY_TABLE', 'NONE', 1, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'I', 'PARENT_ID', 'PARENT_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'I', 'TABLE_TYPE', 'TABLE_TYPE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'I', 'TYPE', 'TYPE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'I', 'PATH', 'PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'I', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'I', 'EFFECTIVE_END_DATE', 'EFFECTIVE_END_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'I', 'EFFECTIVE_START_DATE', 'EFFECTIVE_START_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'I', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', '*', 'SALARY_TABLE_ID', 'SALARY_TABLE_ID', 1, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'I', 'DESCRIPTION_EN', 'DESCRIPTION', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp); 
-- UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'U', 'PARENT_ID', 'PARENT_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'U', 'TABLE_TYPE', 'TABLE_TYPE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'U', 'TYPE', 'TYPE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'U', 'PATH', 'PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'U', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'U', 'EFFECTIVE_END_DATE', 'EFFECTIVE_END_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'U', 'EFFECTIVE_START_DATE', 'EFFECTIVE_START_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_table', 'U', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
-- SALARY_GRADE
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'SALARY_GRADE', null, null, 'SALARY_GRADE', 'NONE', 2, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'I', 'SALARY_TABLE_ID', 'SALARY_TABLE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'I', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'I', 'EFFECTIVE_END_DATE', 'EFFECTIVE_END_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'I', 'EFFECTIVE_START_DATE', 'EFFECTIVE_START_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'I', 'DURATION', 'DURATION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'I', 'MONEY', 'MONEY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'I', 'FACTOR', 'FACTOR', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', '*', 'SALARY_GRADE_ID', 'SALARY_GRADE_ID', 1, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'I', 'DESCRIPTION_EN', 'DESCRIPTION', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp); 
-- UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'U', 'SALARY_TABLE_ID', 'SALARY_TABLE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'U', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'U', 'EFFECTIVE_END_DATE', 'EFFECTIVE_END_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'U', 'EFFECTIVE_START_DATE', 'EFFECTIVE_START_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'U', 'DURATION', 'DURATION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'U', 'MONEY', 'MONEY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'U', 'FACTOR', 'FACTOR', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_grade', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
-- POSITION_WAGE
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_wage', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'POSITION_WAGE', null, null, 'POSITION_WAGE', 'NONE', 3, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_wage', 'I', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_wage', 'I', 'POSITION_TYPE_ID', 'POSITION_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_wage', 'I', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_wage', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_wage', '*', 'POSITION_WAGE_ID', 'POSITION_WAGE_ID', 1, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_wage', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_wage', 'U', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_wage', 'U', 'POSITION_TYPE_ID', 'POSITION_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_wage', 'U', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_wage', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);

-- ORGANIZATION
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'ORGANIZATION', null, null, 'ORGANIZATION', 'NONE', 2, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'MODIFIED_BY', 0, 'const','9', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'CREATED_BY', 0, 'const', '9', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'PATH', 'PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'STATUS', 'STATUS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'IS_LOCKED', 'IS_LOCKED', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'EXPIRY_DESCRIPTION', 'EXPIRY_DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'EXPIRY_DECIDE_NUM', 'EXPIRY_DECIDE_NUM', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'MODIFIED_TIME', 'MODIFIED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'CREATED_TIME', 'CREATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'ESTABLISHMENT_REASON', 'ESTABLISHMENT_REASON', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'PHONE_NUMBER', 'PHONE_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'BANK_AGENCY', 'BANK_AGENCY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'BANK_ID', 'BANK_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'BANK_ACCOUNT', 'BANK_ACCOUNT', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'TAX_CODE', 'TAX_CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'BUSINESS_CODE', 'BUSINESS_CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'PROVINCE_ID', 'PROVINCE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'NATION_ID', 'NATION_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'ADDRESS', 'ADDRESS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'DIRECT_MANAGER', 'DIRECT_MANAGER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'ORG_PARENT_ID', 'ORG_PARENT_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'ORG_MANAGER_ID', 0, 'const', '', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'ESTABLISHED_DATE', 'ESTABLISHED_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'EFFECTIVE_END_DATE', 'EFFECTIVE_END_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'EFFECTIVE_START_DATE', 'EFFECTIVE_START_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'ORG_TYPE_ID', 'ORG_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'DECISION_LEVEL', 'DECISION_LEVEL', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'ESTABLISH_DECIDE_NUM', 'ESTABLISH_DECIDE_NUM', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'ABBREVIATION', 'ABBREVIATION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'ENGLISH_NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'NAME', 'ENGLISH_NAME', 0, 'bsh', 'currentValue == null ? "_untranslated_ " + NAME : currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'ENTERPRISE_TYPE_ID', 'ENTERPRISE_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'ORG_ORDER', 'ORG_ORDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'ORG_LEVEL', 'ORG_LEVEL', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'HAS_EMPLOYEE', 'HAS_EMPLOYEE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', '*', 'ORGANIZATION_ID', 'ORGANIZATION_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'FULL_PATH', 'FULL_PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'REWARD_ORGANIZATION_ID', 0, 'const', '', 11, current_timestamp, 'gsync_admin', current_timestamp);                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'EXPIRY_RELATION_TYPE_ID', 'EXPIRY_RELATION_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'POSITION_BOUNDARY_NUMBER', 'POSITION_BOUNDARY_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'IS_INSURANCE_ORG', 'IS_INSURANCE_ORG', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'ORG_CODE_PATH', 'ORG_CODE_PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'I', 'ORG_LEVEL_MANAGE', 'ORG_LEVEL_MANAGE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
-- UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'MODIFIED_BY', 0, 'const','9', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'CREATED_BY', 0, 'const', '9', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'PATH', 'PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'STATUS', 'STATUS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'IS_LOCKED', 'IS_LOCKED', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'EXPIRY_DESCRIPTION', 'EXPIRY_DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'EXPIRY_DECIDE_NUM', 'EXPIRY_DECIDE_NUM', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'MODIFIED_TIME', 'MODIFIED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'CREATED_TIME', 'CREATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'ESTABLISHMENT_REASON', 'ESTABLISHMENT_REASON', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'PHONE_NUMBER', 'PHONE_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'BANK_AGENCY', 'BANK_AGENCY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'BANK_ID', 'BANK_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'BANK_ACCOUNT', 'BANK_ACCOUNT', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'TAX_CODE', 'TAX_CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'BUSINESS_CODE', 'BUSINESS_CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'PROVINCE_ID', 'PROVINCE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'NATION_ID', 'NATION_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'ADDRESS', 'ADDRESS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'DIRECT_MANAGER', 'DIRECT_MANAGER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'ORG_PARENT_ID', 'ORG_PARENT_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'ORG_MANAGER_ID', 0, 'const', '', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'ESTABLISHED_DATE', 'ESTABLISHED_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'EFFECTIVE_END_DATE', 'EFFECTIVE_END_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'EFFECTIVE_START_DATE', 'EFFECTIVE_START_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'ORG_TYPE_ID', 'ORG_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'DECISION_LEVEL', 'DECISION_LEVEL', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'ESTABLISH_DECIDE_NUM', 'ESTABLISH_DECIDE_NUM', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'ABBREVIATION', 'ABBREVIATION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'NAME', 'ENGLISH_NAME', 0, 'bsh', 'currentValue == null ? "_untranslated_ " + NAME : currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'ENGLISH_NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'ENTERPRISE_TYPE_ID', 'ENTERPRISE_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'ORG_ORDER', 'ORG_ORDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'ORG_LEVEL', 'ORG_LEVEL', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'HAS_EMPLOYEE', 'HAS_EMPLOYEE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'FULL_PATH', 'FULL_PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'REWARD_ORGANIZATION_ID', 0, 'const', '', 11, current_timestamp, 'gsync_admin', current_timestamp);                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'EXPIRY_RELATION_TYPE_ID', 'EXPIRY_RELATION_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'POSITION_BOUNDARY_NUMBER', 'POSITION_BOUNDARY_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'IS_INSURANCE_ORG', 'IS_INSURANCE_ORG', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'ORG_CODE_PATH', 'ORG_CODE_PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization', 'U', 'ORG_LEVEL_MANAGE', 'ORG_LEVEL_MANAGE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
-- POSITION_POSITION_GROUP
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_position_group', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'POSITION_POSITION_GROUP', null, null, 'POSITION_POSITION_GROUP', 'NONE', 3, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_position_group', '*', 'POSITION_POSITION_GROUP_ID', 0, 'identity', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_position_group', 'I', 'POSITION_ID', 'POSITION_ID', 1, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_position_position_group', 'I', 'POSITION_GROUP_ID', 'POSITION_GROUP_ID', 1, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
--SALARY_ORGANIZATION
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'SALARY_ORGANIZATION', null, null, 'SALARY_ORGANIZATION', 'NONE', 1, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'ORDER_NUMBER', 'ORDER_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'ORG_TYPE_ID', 'ORG_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'IS_MASTER', 'IS_MASTER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'SALARY_TYPE', 'SALARY_TYPE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'HAVE_EMPLOYEE', 'HAVE_EMPLOYEE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'ORG_FACTOR', 'ORG_FACTOR', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'END_DATE', 'END_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'START_DATE', 'START_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'PATH', 'PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'PARENT_ID', 'PARENT_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', '*', 'SALARY_ORGANIZATION_ID', 'SALARY_ORGANIZATION_ID', 1, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'PARENT_CODE', 'PARENT_CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'MARKET_FACTOR', 'MARKET_FACTOR', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'ORG_LEVEL', 'ORG_LEVEL', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'ORG_CODE_PATH', 'ORG_CODE_PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'MODIFIED_BY', 'MODIFIED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'CREATED_BY', 'CREATED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'MODIFIED_TIME', 'MODIFIED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'CREATED_TIME', 'CREATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'PAYROLL_CLUE_ID', 'PAYROLL_CLUE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'I', 'CALCULATE_FORMULA', 'CALCULATE_FORMULA', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
-- UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'ORDER_NUMBER', 'ORDER_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'ORG_TYPE_ID', 'ORG_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'IS_MASTER', 'IS_MASTER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'SALARY_TYPE', 'SALARY_TYPE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'HAVE_EMPLOYEE', 'HAVE_EMPLOYEE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'ORG_FACTOR', 'ORG_FACTOR', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'END_DATE', 'END_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'START_DATE', 'START_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'PATH', 'PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'PARENT_ID', 'PARENT_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'PARENT_CODE', 'PARENT_CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'MARKET_FACTOR', 'MARKET_FACTOR', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'ORG_LEVEL', 'ORG_LEVEL', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'ORG_CODE_PATH', 'ORG_CODE_PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'MODIFIED_BY', 'MODIFIED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'CREATED_BY', 'CREATED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'MODIFIED_TIME', 'MODIFIED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'CREATED_TIME', 'CREATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'PAYROLL_CLUE_ID', 'PAYROLL_CLUE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_salary_organization', 'U', 'CALCULATE_FORMULA', 'CALCULATE_FORMULA', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);

--EMP_TIMEKEEPING
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_timekeeping', 'vhr_vtc', 'vhr_td', 'LOAD', null, null, 'EMP_TIMEKEEPING', null, null, 'EMP_TIMEKEEPING', 'DEL_ROW', 1, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_timekeeping', '*', 'READJUST_WORKDAY_TYPE_ID', 'READJUST_WORKDAY_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_timekeeping', '*', 'TYPE_SHIFT_ID', 'TYPE_SHIFT_ID', 1, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_timekeeping', '*', 'HOURS_WORK', 'HOURS_WORK', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_timekeeping', '*', 'WORKDAY_TYPE_ID', 'WORKDAY_TYPE_ID', 1, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_timekeeping', '*', 'EMPLOYEE_ID', 'EMPLOYEE_ID', 1, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_timekeeping', '*', 'IS_LOCK', 'IS_LOCK', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_timekeeping', '*', 'DATE_TIMEKEEPING', 'DATE_TIMEKEEPING', 1, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_timekeeping', '*', 'EMP_TIMEKEEPING_ID', 'EMP_TIMEKEEPING_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_emp_timekeeping', '*', 'READJUST_HOURS_WORK', 'READJUST_HOURS_WORK', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
-- File profile of EMPLOYEE
INSERT INTO gsync_file_trigger 
VALUES('sync_employee_file','C:/filesync/server/all',1,'*.txt',NULL,1,1,1,'targetBaseDir = "C:/filesync/clients/" + engine.getParameterService().getExternalId();',NULL,current_timestamp,'gsync_admin',current_timestamp);
insert into gsync_router(router_id, target_catalog_name, target_schema_name, source_node_group_id, target_node_group_id, router_type, router_expression, create_time, last_update_by, last_update_time)
    values ('sync_file_server_2_client', null, null, 'vhr_td', 'vhr_vtc', 'bsh', 'engine.getExtensionBean("vhrTdEmployeeService",com.viettel.ghr.ghrcenter.vtgroup.service.IEmployeeService.class).checkFileNameForSyncing(FILE_NAME);', current_timestamp, 'gsync_admin', current_timestamp);
INSERT INTO gsync_file_trigger_router 
VALUES('sync_employee_file','sync_file_server_2_client',1,1,NULL,'SOURCE_WINS',current_timestamp,'gsync_admin',current_timestamp);

-- ORGANIZATION
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'vhr_vtc', 'vhr_td', 'LOAD', null, null, 'ORGANIZATION', null, null, 'ORGANIZATION', 'NONE', 2, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'MODIFIED_BY', 0, 'const','9', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'CREATED_BY', 0, 'const', '9', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'PATH', 'PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'STATUS', 'STATUS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'IS_LOCKED', 'IS_LOCKED', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'EXPIRY_DESCRIPTION', 'EXPIRY_DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'EXPIRY_DECIDE_NUM', 'EXPIRY_DECIDE_NUM', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'MODIFIED_TIME', 'MODIFIED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'CREATED_TIME', 'CREATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'ESTABLISHMENT_REASON', 'ESTABLISHMENT_REASON', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'PHONE_NUMBER', 'PHONE_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'BANK_AGENCY', 'BANK_AGENCY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'BANK_ID', 'BANK_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'BANK_ACCOUNT', 'BANK_ACCOUNT', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'TAX_CODE', 'TAX_CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'BUSINESS_CODE', 'BUSINESS_CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'PROVINCE_ID', 'PROVINCE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'NATION_ID', 'NATION_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'ADDRESS', 'ADDRESS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'DIRECT_MANAGER', 'DIRECT_MANAGER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'ORG_PARENT_ID', 'ORG_PARENT_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'ORG_MANAGER_ID', 0, 'const', '', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'ESTABLISHED_DATE', 'ESTABLISHED_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'EFFECTIVE_END_DATE', 'EFFECTIVE_END_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'EFFECTIVE_START_DATE', 'EFFECTIVE_START_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'ORG_TYPE_ID', 'ORG_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'DECISION_LEVEL', 'DECISION_LEVEL', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'ESTABLISH_DECIDE_NUM', 'ESTABLISH_DECIDE_NUM', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'ABBREVIATION', 'ABBREVIATION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'NAME', 'ENGLISH_NAME', 0, 'bsh', 'currentValue == null ? "_untranslated_ " + NAME : currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'ENGLISH_NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'ENTERPRISE_TYPE_ID', 'ENTERPRISE_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'ORG_ORDER', 'ORG_ORDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'ORG_LEVEL', 'ORG_LEVEL', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'HAS_EMPLOYEE', 'HAS_EMPLOYEE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', '*', 'ORGANIZATION_ID', 'ORGANIZATION_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'FULL_PATH', 'FULL_PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'REWARD_ORGANIZATION_ID', 0, 'const', '', 11, current_timestamp, 'gsync_admin', current_timestamp);                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'EXPIRY_RELATION_TYPE_ID', 'EXPIRY_RELATION_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'POSITION_BOUNDARY_NUMBER', 'POSITION_BOUNDARY_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'IS_INSURANCE_ORG', 'IS_INSURANCE_ORG', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'ORG_CODE_PATH', 'ORG_CODE_PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'I', 'ORG_LEVEL_MANAGE', 'ORG_LEVEL_MANAGE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
-- UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'MODIFIED_BY', 0, 'const','9', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'CREATED_BY', 0, 'const', '9', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'PATH', 'PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'STATUS', 'STATUS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'IS_LOCKED', 'IS_LOCKED', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'EXPIRY_DESCRIPTION', 'EXPIRY_DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'EXPIRY_DECIDE_NUM', 'EXPIRY_DECIDE_NUM', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'MODIFIED_TIME', 'MODIFIED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'CREATED_TIME', 'CREATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'ESTABLISHMENT_REASON', 'ESTABLISHMENT_REASON', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'PHONE_NUMBER', 'PHONE_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'BANK_AGENCY', 'BANK_AGENCY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'BANK_ID', 'BANK_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'BANK_ACCOUNT', 'BANK_ACCOUNT', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'TAX_CODE', 'TAX_CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'BUSINESS_CODE', 'BUSINESS_CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'PROVINCE_ID', 'PROVINCE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'NATION_ID', 'NATION_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'ADDRESS', 'ADDRESS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'DIRECT_MANAGER', 'DIRECT_MANAGER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'ORG_PARENT_ID', 'ORG_PARENT_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'ORG_MANAGER_ID', 0, 'const', '', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'ESTABLISHED_DATE', 'ESTABLISHED_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'EFFECTIVE_END_DATE', 'EFFECTIVE_END_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'EFFECTIVE_START_DATE', 'EFFECTIVE_START_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'ORG_TYPE_ID', 'ORG_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'DECISION_LEVEL', 'DECISION_LEVEL', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'ESTABLISH_DECIDE_NUM', 'ESTABLISH_DECIDE_NUM', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'ABBREVIATION', 'ABBREVIATION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'NAME', 'ENGLISH_NAME', 0, 'bsh', 'currentValue == null ? "_untranslated_ " + NAME : currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'ENGLISH_NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'ENTERPRISE_TYPE_ID', 'ENTERPRISE_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'ORG_ORDER', 'ORG_ORDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'ORG_LEVEL', 'ORG_LEVEL', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'HAS_EMPLOYEE', 'HAS_EMPLOYEE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'FULL_PATH', 'FULL_PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'REWARD_ORGANIZATION_ID', 0, 'const', '', 11, current_timestamp, 'gsync_admin', current_timestamp);                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'EXPIRY_RELATION_TYPE_ID', 'EXPIRY_RELATION_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'POSITION_BOUNDARY_NUMBER', 'POSITION_BOUNDARY_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'IS_INSURANCE_ORG', 'IS_INSURANCE_ORG', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'ORG_CODE_PATH', 'ORG_CODE_PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_organization', 'U', 'ORG_LEVEL_MANAGE', 'ORG_LEVEL_MANAGE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_work_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'WORK_PROCESS', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), WORK_PROCESS_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_transfer_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'TRANSFER_PROCESS', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), TRANSFER_PROCESS_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);
insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_employee', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'EMPLOYEE', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), EMPLOYEE_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_bank_account', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'BANK_ACCOUNT', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), BANK_ACCOUNT_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);
insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_emp_file', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'EMP_FILE', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), EMP_FILE_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_orther_party', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'OTHER_PARTY', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), OTHER_PARTY_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);
insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_emp_type_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'EMP_TYPE_PROCESS', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), EMP_TYPE_PROCESS_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_education_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'EDUCATION_PROCESS', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), EDUCATION_PROCESS_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_emp_language_degree', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'EMP_LANGUAGE_DEGREE', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), EMP_LANGUAGE_DEGREE_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_emp_political_degree', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'EMP_POLITICAL_DEGREE', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), EMP_POLITICAL_DEGREE_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);
insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_reward', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'REWARD', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), REWARD_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_punishment', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'PUNISHMENT', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), PUNISHMENT_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);
insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_long_leave', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'LONG_LEAVE', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), LONG_LEAVE_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_family_relationship', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'FAMILY_RELATIONSHIP', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), FAMILY_RELATIONSHIP_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);
insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_health_info', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'HEALTH_INFO', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), HEALTH_INFO_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_salary_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'SALARY_PROCESS', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), SALARY_PROCESS_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);
    
insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_position_salary', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'POSITION_SALARY', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), POSITION_SALARY_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);
insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_salary_increase', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'SALARY_INCREASE', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), SALARY_INCREASE_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_insurance_salary_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'INSURANCE_SALARY_PROCESS', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), INSURANCE_SALARY_PROCESS_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);
insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_education_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'EDUCATION_PROCESS', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), EDUCATION_PROCESS_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_emp_allowance_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'EMP_ALLOWANCE_PROCESS', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), EMP_ALLOWANCE_PROCESS_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);

-- INFO_CHANGE
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_info_change', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'INFO_CHANGE', null, null, 'INFO_CHANGE', 'NONE', 4, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_info_change', '*', 'SYS_USER_ID', 'SYS_USER_ID', 0, 'const', '9', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_info_change', '*', 'CHANGE_TIME', 'CHANGE_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_info_change', '*', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_info_change', '*', 'EMPLOYEE_ID', 'EMPLOYEE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_info_change', '*', 'CHANGE_TYPE', 'CHANGE_TYPE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_info_change', '*', 'DATA_AFTER_CHANGE', 'DATA_AFTER_CHANGE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_info_change', '*', 'DATA_BEFORE_CHANGE', 'DATA_BEFORE_CHANGE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_info_change', '*', 'CHANGED_FIELDS', 'CHANGED_FIELDS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_info_change', '*', 'INFO_CHANGE_ID', 'INFO_CHANGE_ID', 1, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);  

-- INFO_CHANGE Chieu VTC - ve TD
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_info_change', 'vhr_vtc', 'vhr_td', 'LOAD', null, null, 'INFO_CHANGE', null, null, 'INFO_CHANGE', 'NONE', 4, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_info_change', '*', 'SYS_USER_ID', 'SYS_USER_ID', 0, 'const', '9', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_info_change', '*', 'CHANGE_TIME', 'CHANGE_TIME', 1, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_info_change', '*', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_info_change', '*', 'EMPLOYEE_ID', 'EMPLOYEE_ID', 1, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_info_change', '*', 'CHANGE_TYPE', 'CHANGE_TYPE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_info_change', '*', 'DATA_AFTER_CHANGE', 'DATA_AFTER_CHANGE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_info_change', '*', 'DATA_BEFORE_CHANGE', 'DATA_BEFORE_CHANGE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_info_change', '*', 'CHANGED_FIELDS', 'CHANGED_FIELDS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_info_change', '*', 'INFO_CHANGE_ID', 'INFO_CHANGE_ID', 1, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);

--EMPLOYEE
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'EMPLOYEE', null, null, 'EMPLOYEE', 'NONE', 4, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'MARITAL_STATUS', 'MARITAL_STATUS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'ORIGIN', 'ORIGIN', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'GENDER', 'GENDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'PLACE_OF_BIRTH', 'PLACE_OF_BIRTH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'DATE_OF_BIRTH', 'DATE_OF_BIRTH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'IMAGE_PATH', 'IMAGE_PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'FULL_NAME', 'FULL_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'MIDDLE_NAME', 'MIDDLE_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'FIRST_NAME', 'FIRST_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'LAST_NAME', 'LAST_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'ALIAS_NAME', 'ALIAS_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'EMAIL', 'EMAIL', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'CREATED_BY', 0, 'const', '9', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'MODIFIED_TIME', 'MODIFIED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'CREATED_TIME', 'CREATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'CULTURE_LEVEL_ID', 'CULTURE_LEVEL_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'SICK_SOLDIER_LEVEL_ID', 'SICK_SOLDIER_LEVEL_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'INVALIDED_SOLDIER_LEVEL_ID', 'INVALIDED_SOLDIER_LEVEL_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'ORGANIZATION_ID', 'ORGANIZATION_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'RELIGION_ID', 'RELIGION_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'ETHNIC_ID', 'ETHNIC_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'PROVINCE_OF_ORIGIN_ID', 'PROVINCE_OF_ORIGIN_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'PROVINCE_OF_BIRTH_ID', 'PROVINCE_OF_BIRTH_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'CURRENT_PROVINCE_ID', 'CURRENT_PROVINCE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'PERMANENT_PROVINCE_ID', 'PERMANENT_PROVINCE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'POLITICAL_FAMILY_TYPE_ID', 'POLITICAL_FAMILY_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'FAMILY_TYPE_ID', 'FAMILY_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'NATION_ID', 'NATION_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'OTHER_INFO', 'OTHER_INFO', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'CHILD_GRADE', 'CHILD_GRADE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'TAX_NUMBER', 'TAX_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'REASON_OF_DEMOBILIZATION', 'REASON_OF_DEMOBILIZATION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'DEMOBILIZATION_DATE', 'DEMOBILIZATION_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'IS_SICK_SOLDIER', 'IS_SICK_SOLDIER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'IS_INVALIDED_SOLDIER', 'IS_INVALIDED_SOLDIER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'ENLISTED_DATE', 'ENLISTED_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'SOLDIER_NUMBER', 'SOLDIER_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'UNION_ADMISSION_PLACE', 'UNION_ADMISSION_PLACE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'UNION_ADMISSION_DATE', 'UNION_ADMISSION_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'UNION_NUMBER', 'UNION_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'PARTY_ADMISSION_PLACE', 'PARTY_ADMISSION_PLACE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'PARTY_OFFICIAL_ADMISSION_DATE', 'PARTY_OFFICIAL_ADMISSION_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'PARTY_ADMISSION_DATE', 'PARTY_ADMISSION_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'PARTY_NUMBER', 'PARTY_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'FAX', 'FAX', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'MOBILE_NUMBER', 'MOBILE_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'PHONE_NUMBER', 'PHONE_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'CURRENT_ADDRESS', 'CURRENT_ADDRESS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'PERMANENT_ADDRESS', 'PERMANENT_ADDRESS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'PASSPORT_NUMBER', 'PASSPORT_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'PASSPORT_ISSUE_DATE', 'PASSPORT_ISSUE_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'PERSONAL_ID_ISSUED_PLACE', 'PERSONAL_ID_ISSUED_PLACE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'PERSONAL_ID_ISSUED_DATE', 'PERSONAL_ID_ISSUED_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'PERSONAL_ID_NUMBER', 'PERSONAL_ID_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'MODIFIED_BY', 0, 'const', '9', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'OLD_ID', 'OLD_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'TAX_NUMBER_UPDATED_TIME', 'TAX_NUMBER_UPDATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'PLACE_OF_ISSUE_ID', 'PLACE_OF_ISSUE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'YEAR_OF_ISSUE', 'YEAR_OF_ISSUE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'GRADUATED_RANK_ID', 'GRADUATED_RANK_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'EDUCATION_TYPE_ID', 'EDUCATION_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'EDUCATION_SUBJECT_ID', 'EDUCATION_SUBJECT_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'EDUCATION_GRADE_ID', 'EDUCATION_GRADE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'INSURANCE_NUMBER', 'INSURANCE_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'OTHER_ORG_ID', 'OTHER_ORG_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'STATUS', 'STATUS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'SOLDIER_LEVEL_ID', 'SOLDIER_LEVEL_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'POSITION_ID', 'POSITION_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'EMP_TYPE_ID', 'EMP_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'EMPLOYEE_CODE', 'EMPLOYEE_CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', '*', 'EMPLOYEE_ID', 'EMPLOYEE_ID', 1, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'REFERENCE_RELATIONSHIP', 'REFERENCE_RELATIONSHIP', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'REFERENCE_DEPARTMENT', 'REFERENCE_DEPARTMENT', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'REFERENCE_RANK', 'REFERENCE_RANK', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'REFERENCE_PEOPLE', 'REFERENCE_PEOPLE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'IS_POLICY', 'IS_POLICY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'TAX_MANAGE_ORG', 'TAX_MANAGE_ORG', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'TAX_MANAGE_ORG_ID', 'TAX_MANAGE_ORG_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'TAX_CODE_DATE', 'TAX_CODE_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'RECRUIT_TYPE_ID', 'RECRUIT_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'I', 'VIETTEL_START_DATE', 'VIETTEL_START_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'MARITAL_STATUS', 'MARITAL_STATUS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'ORIGIN', 'ORIGIN', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'GENDER', 'GENDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'PLACE_OF_BIRTH', 'PLACE_OF_BIRTH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'DATE_OF_BIRTH', 'DATE_OF_BIRTH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'IMAGE_PATH', 'IMAGE_PATH', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'FULL_NAME', 'FULL_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'MIDDLE_NAME', 'MIDDLE_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'FIRST_NAME', 'FIRST_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'LAST_NAME', 'LAST_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'ALIAS_NAME', 'ALIAS_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'EMAIL', 'EMAIL', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'CREATED_BY', 0, 'const', '9', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'MODIFIED_TIME', 'MODIFIED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'CREATED_TIME', 'CREATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'CULTURE_LEVEL_ID', 'CULTURE_LEVEL_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'SICK_SOLDIER_LEVEL_ID', 'SICK_SOLDIER_LEVEL_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'INVALIDED_SOLDIER_LEVEL_ID', 'INVALIDED_SOLDIER_LEVEL_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'ORGANIZATION_ID', 'ORGANIZATION_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'RELIGION_ID', 'RELIGION_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'ETHNIC_ID', 'ETHNIC_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'PROVINCE_OF_ORIGIN_ID', 'PROVINCE_OF_ORIGIN_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'PROVINCE_OF_BIRTH_ID', 'PROVINCE_OF_BIRTH_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'CURRENT_PROVINCE_ID', 'CURRENT_PROVINCE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'PERMANENT_PROVINCE_ID', 'PERMANENT_PROVINCE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'POLITICAL_FAMILY_TYPE_ID', 'POLITICAL_FAMILY_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'FAMILY_TYPE_ID', 'FAMILY_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'NATION_ID', 'NATION_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'OTHER_INFO', 'OTHER_INFO', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'CHILD_GRADE', 'CHILD_GRADE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'TAX_NUMBER', 'TAX_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'REASON_OF_DEMOBILIZATION', 'REASON_OF_DEMOBILIZATION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'DEMOBILIZATION_DATE', 'DEMOBILIZATION_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'IS_SICK_SOLDIER', 'IS_SICK_SOLDIER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'IS_INVALIDED_SOLDIER', 'IS_INVALIDED_SOLDIER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'ENLISTED_DATE', 'ENLISTED_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'SOLDIER_NUMBER', 'SOLDIER_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'UNION_ADMISSION_PLACE', 'UNION_ADMISSION_PLACE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'UNION_ADMISSION_DATE', 'UNION_ADMISSION_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'UNION_NUMBER', 'UNION_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'PARTY_ADMISSION_PLACE', 'PARTY_ADMISSION_PLACE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'PARTY_OFFICIAL_ADMISSION_DATE', 'PARTY_OFFICIAL_ADMISSION_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'PARTY_ADMISSION_DATE', 'PARTY_ADMISSION_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'PARTY_NUMBER', 'PARTY_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'FAX', 'FAX', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'MOBILE_NUMBER', 'MOBILE_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'PHONE_NUMBER', 'PHONE_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'CURRENT_ADDRESS', 'CURRENT_ADDRESS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'PERMANENT_ADDRESS', 'PERMANENT_ADDRESS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'PASSPORT_NUMBER', 'PASSPORT_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'PASSPORT_ISSUE_DATE', 'PASSPORT_ISSUE_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'PERSONAL_ID_ISSUED_PLACE', 'PERSONAL_ID_ISSUED_PLACE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'PERSONAL_ID_ISSUED_DATE', 'PERSONAL_ID_ISSUED_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'PERSONAL_ID_NUMBER', 'PERSONAL_ID_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'MODIFIED_BY', 0, 'const', '9', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'OLD_ID', 'OLD_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'TAX_NUMBER_UPDATED_TIME', 'TAX_NUMBER_UPDATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'PLACE_OF_ISSUE_ID', 'PLACE_OF_ISSUE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'YEAR_OF_ISSUE', 'YEAR_OF_ISSUE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'GRADUATED_RANK_ID', 'GRADUATED_RANK_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'EDUCATION_TYPE_ID', 'EDUCATION_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'EDUCATION_SUBJECT_ID', 'EDUCATION_SUBJECT_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'EDUCATION_GRADE_ID', 'EDUCATION_GRADE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'INSURANCE_NUMBER', 'INSURANCE_NUMBER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'OTHER_ORG_ID', 'OTHER_ORG_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'STATUS', 'STATUS', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'SOLDIER_LEVEL_ID', 'SOLDIER_LEVEL_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'POSITION_ID', 'POSITION_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'EMP_TYPE_ID', 'EMP_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'EMPLOYEE_CODE', 'EMPLOYEE_CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'REFERENCE_RELATIONSHIP', 'REFERENCE_RELATIONSHIP', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'REFERENCE_DEPARTMENT', 'REFERENCE_DEPARTMENT', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'REFERENCE_RANK', 'REFERENCE_RANK', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'REFERENCE_PEOPLE', 'REFERENCE_PEOPLE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                             
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'IS_POLICY', 'IS_POLICY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'TAX_MANAGE_ORG', 'TAX_MANAGE_ORG', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'TAX_MANAGE_ORG_ID', 'TAX_MANAGE_ORG_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'TAX_CODE_DATE', 'TAX_CODE_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'RECRUIT_TYPE_ID', 'RECRUIT_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                               
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_employee', 'U', 'VIETTEL_START_DATE', 'VIETTEL_START_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);

-- POSITION
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'vhr_vtc', 'vhr_td', 'LOAD', null, null, 'POSITION', null, null, 'POSITION', 'NONE', 2, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'POS_ORDER', 'POS_ORDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'EFFECTIVE_DATE', 'EFFECTIVE_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'EXPIRY_DATE', 'EXPIRY_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'POSITION_GROUP_ID', 'POSITION_GROUP_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'LABOUR_TYPE_ID', 'LABOUR_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'GENDER', 'GENDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'EXPERIENCE', 'EXPERIENCE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'NORM', 'NORM', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'POSITION_NAME', 'POSITION_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'POSITION_CODE', 'POSITION_CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', '*', 'POSITION_ID', 'POSITION_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'LANGUAGE_ID', 'LANGUAGE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'CREATED_BY', 'CREATED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'MODIFIED_BY', 'MODIFIED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'MODIFIED_TIME', 'MODIFIED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'CREATED_TIME', 'CREATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'POSITION_NAME_EN', 'POSITION_NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'POSITION_NAME_VI', 'POSITION_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'DESCRIPTION_EN', 'DESCRIPTION', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp); 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'DESCRIPTION_VI', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'DOMAIN', 0, 'const', 'VHR_VIETTELGROUP', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'I', 'IS_DISPLAY', 0, 'const', '1', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'U', 'POS_ORDER', 'POS_ORDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'U', 'EFFECTIVE_DATE', 'EFFECTIVE_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'U', 'EXPIRY_DATE', 'EXPIRY_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'U', 'POSITION_GROUP_ID', 'POSITION_GROUP_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'U', 'LABOUR_TYPE_ID', 'LABOUR_TYPE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'U', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'U', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'U', 'GENDER', 'GENDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'U', 'EXPERIENCE', 'EXPERIENCE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'U', 'NORM', 'NORM', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'U', 'POSITION_NAME', 'POSITION_NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'U', 'POSITION_CODE', 'POSITION_CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'U', 'LANGUAGE_ID', 'LANGUAGE_ID', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'U', 'CREATED_BY', 'CREATED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'U', 'MODIFIED_BY', 'MODIFIED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'U', 'MODIFIED_TIME', 'MODIFIED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position', 'U', 'CREATED_TIME', 'CREATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);   
-- POSITION_GROUP
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'vhr_vtc', 'vhr_td', 'LOAD', null, null, 'POSITION_GROUP', null, null, 'POSITION_GROUP', 'NONE', 1, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);
    
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'I', 'EXPIRY_DATE', 'EXPIRY_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'I', 'EFFECTIVE_DATE', 'EFFECTIVE_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'I', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'I', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'I', 'IS_MANAGEMENT', 'IS_MANAGEMENT', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', '*', 'POSITION_GROUP_ID', 'POSITION_GROUP_ID', 1, 'copy', 1, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'I', 'MODIFIED_TIME', 'MODIFIED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'I', 'MODIFIED_BY', 'MODIFIED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'I', 'CREATED_TIME', 'CREATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'I', 'CREATED_BY', 'CREATED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'I', 'NAME_EN', 'NAME', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'I', 'NAME_VI', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'I', 'DESCRIPTION_EN', 'DESCRIPTION', 0, 'bsh', 'currentValue == null ? null : "_untranslated_ " + currentValue;', 11, current_timestamp, 'gsync_admin', current_timestamp);   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'I', 'DESCRIPTION_VI', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'I', 'DOMAIN', 0, 'const', 'VHR_VIETTELGROUP', 11, current_timestamp, 'gsync_admin', current_timestamp);
insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_expression, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'I', 'IS_DISPLAY', 0, 'const', '1', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'U', 'EXPIRY_DATE', 'EXPIRY_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'U', 'EFFECTIVE_DATE', 'EFFECTIVE_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                 
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'U', 'IS_ACTIVE', 'IS_ACTIVE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'U', 'DESCRIPTION', 'DESCRIPTION', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'U', 'IS_MANAGEMENT', 'IS_MANAGEMENT', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'U', 'MODIFIED_TIME', 'MODIFIED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                   
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'U', 'MODIFIED_BY', 'MODIFIED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'U', 'CREATED_TIME', 'CREATED_TIME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_group', 'U', 'CREATED_BY', 'CREATED_BY', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
-- POSITION_POSITION_GROUP
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_position_group', 'vhr_vtc', 'vhr_td', 'LOAD', null, null, 'POSITION_POSITION_GROUP', null, null, 'POSITION_POSITION_GROUP', 'NONE', 3, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_position_group', '*', 'POSITION_POSITION_GROUP_ID', 0, 'identity', 11, current_timestamp, 'gsync_admin', current_timestamp);                           
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_position_group', 'I', 'POSITION_ID', 'POSITION_ID', 1, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                       
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_position_position_group', 'I', 'POSITION_GROUP_ID', 'POSITION_GROUP_ID', 1, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);


-- TRIGGER Toa tren ca 2 bang
CREATE OR REPLACE TRIGGER trg_position_position_group_id
 BEFORE
  INSERT
 ON position_position_group
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN (new."POSITION_POSITION_GROUP_ID" IS NULL)
BEGIN 
  SELECT "POSITION_POSITION_GROUP_SEQ".nextval INTO :new."POSITION_POSITION_GROUP_ID" FROM dual; 
END;

-- Add column tren bang EMPLOYEE DB VTC
alter table
   EMPLOYEE
add
   (
   INJURY_PERCENT Number(5,2),  
   INJURY_DECIDE_NUMBER NVARCHAR2(200),
   POLICY_TYPE Number(10),
   POLICY_YEAR Number(7),  
   POLICY_LEVEL_ID Number(10),
   POLICY_PLACE NVARCHAR2(300)
   );
COMMENT ON COLUMN EMPLOYEE.INJURY_PERCENT 
   IS 'Ty le thuong tat';
COMMENT ON COLUMN EMPLOYEE.INJURY_DECIDE_NUMBER 
   IS 'So quyet dinh thuong tat';
COMMENT ON COLUMN EMPLOYEE.POLICY_TYPE 
   IS 'Loai quan nhan 1:thuong binh, 2:benh binh, 3:nhiem chat dioxin';
COMMENT ON COLUMN EMPLOYEE.POLICY_YEAR
   IS 'Nam bi thuong';
COMMENT ON COLUMN EMPLOYEE.POLICY_LEVEL_ID 
   IS 'Hang thuong benh binh';
COMMENT ON COLUMN EMPLOYEE.POLICY_PLACE 
   IS 'Noi, chien truong bi thuong, nhiem chat dioxin';

-- ADD table ghi nhan log request dongbo cong tren CSDL tap doan
CREATE TABLE sync_reload_request_log
    (
    request_history_id             NUMBER(20) NOT NULL,
    target_node_id                 VARCHAR2(50 BYTE),
    source_node_id                 VARCHAR2(50 BYTE),
    trigger_id                     VARCHAR2(50 BYTE),
    router_id                      VARCHAR2(50 BYTE),
    user_name                      VARCHAR2(50 BYTE),
    request_create_time            TIMESTAMP (6),
    from_date                      DATE,
    to_date                        DATE,
    status                         CHAR(2 BYTE),
    reload_select                  CLOB,
    reload_delete_stmt             CLOB,
    reload_enabled                 NUMBER(3,0) DEFAULT 0,
    reload_time                    TIMESTAMP (6),
    create_time                    TIMESTAMP (6),
    last_update_by                 VARCHAR2(50 BYTE),
    last_update_time               TIMESTAMP (6) NOT NULL);
ALTER TABLE sync_reload_request_log
ADD PRIMARY KEY (request_history_id);
CREATE SEQUENCE sync_reload_request_log_seq
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20;