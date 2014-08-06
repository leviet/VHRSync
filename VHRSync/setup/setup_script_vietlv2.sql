-- VHR-VTC to VHR-TD data channel
insert into gsync_channel(channel_id, processing_order, max_batch_size, max_batch_to_send, enabled, contains_big_lob, batch_algorithm, data_loader_type, description, create_time, last_update_by, last_update_time)
    values ('vhr_vtc_2_vhr_td', 20, 10000, 60, 1, 0, 'default', 'default', 'Transfers VHR data changes from VHR-VTC to VHR Tap doan', current_timestamp, 'gsync_admin', current_timestamp);

-- REWARD_DETAIL
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_detail', null, null, 'REWARD_DETAIL', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- REWARD_EMPLOYEE_KI
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_employee_ki', null, null, 'REWARD_EMPLOYEE_KI', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- REWARD_TIMEKEEPING
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_timekeeping', null, null, 'REWARD_TIMEKEEPING', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- REWARD_ORGANIZATION
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_organization', null, null, 'REWARD_ORGANIZATION', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);

-- DF_FORMULA
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_df_formula', null, null, 'DF_FORMULA', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- REWARD_PERIOD
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_period', null, null, 'REWARD_PERIOD', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- REWARD_EMP_TYPE
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_emp_type', null, null, 'REWARD_EMP_TYPE', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- REWARD_ORGANIZATION
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_organization', null, null, 'REWARD_ORGANIZATION', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);
-- ORGANIZATION_PERIOD
insert into gsync_trigger(trigger_id, source_catalog_name, source_schema_name, source_table_name, channel_id, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization_period', null, null, 'ORGANIZATION_PERIOD', 'vhr_td_vhrdata', current_timestamp, 'gsync_admin', current_timestamp);

-- DF_FORMULA
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_df_formula', 'vhr_td_vhrdata_2_vhr_vtc', 1, 51, current_timestamp, 'gsync_admin', current_timestamp);
-- REWARD_PERIOD
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_period', 'vhr_td_vhrdata_2_vhr_vtc', 1, 52, current_timestamp, 'gsync_admin', current_timestamp);
-- REWARD_EMP_TYPE
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_emp_type', 'vhr_td_vhrdata_2_vhr_vtc', 1, 53, current_timestamp, 'gsync_admin', current_timestamp);
-- REWARD_ORGANIZATION;
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_organization', 'vhr_td_vhrdata_2_vhr_vtc', 1, 54, current_timestamp, 'gsync_admin', current_timestamp);
-- ORGANIZATION_PERIOD
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_organization_period', 'vhr_td_vhrdata_2_vhr_vtc', 1, 55, current_timestamp, 'gsync_admin', current_timestamp);
-- REWARD_ORGANIZATION
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_organization', 'vhr_td_vhrdata_2_vhr_vtc', 1, 51,'1=1 order by sort_order', current_timestamp, 'gsync_admin', current_timestamp);
-- REWARD_DETAIL
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_detail', 'vhr_td_vhrdata_2_vhr_vtc', 1, 53,'EMPLOYEE_ID in ((select distinct wp.EMPLOYEE_ID
from WORK_PROCESS wp INNER JOIN ORGANIZATION org ON wp.ORGANIZATION_ID = org.ORGANIZATION_ID
where org.org_code_path like ''/TCT/VIG/50C/GIV/VCA/%'' AND
    wp.EFFECTIVE_START_DATE <= SYSDATE AND (wp.EFFECTIVE_END_DATE IS NULL OR wp.EFFECTIVE_END_DATE > SYSDATE))  
union
(select distinct tp.EMPLOYEE_ID
from TRANSFER_PROCESS tp INNER JOIN ORGANIZATION org ON tp.transfered_organization_id = org.ORGANIZATION_ID
where org.org_code_path like ''/TCT/VIG/50C/GIV/VCA/%'' AND
    tp.EFFECTIVE_START_DATE <= SYSDATE AND (tp.EFFECTIVE_END_DATE IS NULL OR tp.EFFECTIVE_END_DATE > SYSDATE) AND
    tp.is_support_process = 1 AND tp.status in (3,4)))', current_timestamp, 'gsync_admin', current_timestamp);
-- REWARD_EMPLOYEE_KI
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_employee_ki', 'vhr_td_vhrdata_2_vhr_vtc', 1, 53,'EMPLOYEE_ID in ((select distinct wp.EMPLOYEE_ID
from WORK_PROCESS wp INNER JOIN ORGANIZATION org ON wp.ORGANIZATION_ID = org.ORGANIZATION_ID
where org.org_code_path like ''/TCT/VIG/50C/GIV/VCA/%'' AND
    wp.EFFECTIVE_START_DATE <= SYSDATE AND (wp.EFFECTIVE_END_DATE IS NULL OR wp.EFFECTIVE_END_DATE > SYSDATE))  
union
(select distinct tp.EMPLOYEE_ID
from TRANSFER_PROCESS tp INNER JOIN ORGANIZATION org ON tp.transfered_organization_id = org.ORGANIZATION_ID
where org.org_code_path like ''/TCT/VIG/50C/GIV/VCA/%'' AND
    tp.EFFECTIVE_START_DATE <= SYSDATE AND (tp.EFFECTIVE_END_DATE IS NULL OR tp.EFFECTIVE_END_DATE > SYSDATE) AND
    tp.is_support_process = 1 AND tp.status in (3,4)))', current_timestamp, 'gsync_admin', current_timestamp);
-- REWARD_TIMEKEEPING
insert into gsync_trigger_router(trigger_id, router_id, enabled, initial_load_order, initial_load_select, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_timekeeping', 'vhr_td_vhrdata_2_vhr_vtc', 1, 53,'EMPLOYEE_ID in ((select distinct wp.EMPLOYEE_ID
from WORK_PROCESS wp INNER JOIN ORGANIZATION org ON wp.ORGANIZATION_ID = org.ORGANIZATION_ID
where org.org_code_path like ''/TCT/VIG/50C/GIV/VCA/%'' AND
    wp.EFFECTIVE_START_DATE <= SYSDATE AND (wp.EFFECTIVE_END_DATE IS NULL OR wp.EFFECTIVE_END_DATE > SYSDATE))  
union
(select distinct tp.EMPLOYEE_ID
from TRANSFER_PROCESS tp INNER JOIN ORGANIZATION org ON tp.transfered_organization_id = org.ORGANIZATION_ID
where org.org_code_path like ''/TCT/VIG/50C/GIV/VCA/%'' AND
    tp.EFFECTIVE_START_DATE <= SYSDATE AND (tp.EFFECTIVE_END_DATE IS NULL OR tp.EFFECTIVE_END_DATE > SYSDATE) AND
    tp.is_support_process = 1 AND tp.status in (3,4)))', current_timestamp, 'gsync_admin', current_timestamp);

-- REWARD_ORGANIZATION
insert into gsync_transform_table (transform_id, source_node_group_id, target_node_group_id, transform_point, source_catalog_name, source_schema_name, source_table_name, target_catalog_name, target_schema_name, target_table_name, delete_action, transform_order, column_policy, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_organization', 'vhr_td', 'vhr_vtc', 'LOAD', null, null, 'REWARD_ORGANIZATION', null, null, 'REWARD_ORGANIZATION', 'NONE', 1, 'SPECIFIED', current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_organization', 'I', 'SORT_ORDER', 'SORT_ORDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_organization', 'I', 'EFFECTIVE_END_DATE', 'EFFECTIVE_END_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_organization', 'I', 'EFFECTIVE_START_DATE', 'EFFECTIVE_START_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_organization', 'I', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_organization', 'I', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_organization', '*', 'REWARD_ORGANIZATION_ID', 'REWARD_ORGANIZATION_ID', 1, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);
--UPDATE
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_organization', 'U', 'SORT_ORDER', 'SORT_ORDER', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_organization', 'U', 'EFFECTIVE_END_DATE', 'EFFECTIVE_END_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                         
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_organization', 'U', 'EFFECTIVE_START_DATE', 'EFFECTIVE_START_DATE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_organization', 'U', 'NAME', 'NAME', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);                                                     
insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values ('vhr_td_reward_organization', 'U', 'CODE', 'CODE', 0, 'copy', 11, current_timestamp, 'gsync_admin', current_timestamp);

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_work_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'WORK_PROCESS', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), WORK_PROCESS_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_transfer_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'TRANSFER_PROCESS', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), TRANSFER_PROCESS_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);
insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_work_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'EMPLOYEE', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), EMPLOYEE_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_transfer_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'BANK_ACCOUNT', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), BANK_ACCOUNT_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);
insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_work_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'EMP_FILE', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), EMP_FILE_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_transfer_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'OTHER_PARTY', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), OTHER_PARTY_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);
insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_work_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'EMP_TYPE_PROCESS', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), EMP_TYPE_PROCESS_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_transfer_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'EDUCATION_PROCESS', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), EDUCATION_PROCESS_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_work_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'EMP_LANGUAGE_DEGREE', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), EMP_LANGUAGE_DEGREE_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_transfer_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'EMP_POLITICAL_DEGREE', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), EMP_POLITICAL_DEGREE_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);
insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_work_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'REWARD', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), REWARD_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_transfer_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'PUNISHMENT', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), PUNISHMENT_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);
insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_work_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'LONG_LEAVE', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), LONG_LEAVE_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_transfer_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'FAMILY_RELATIONSHIP', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), FAMILY_RELATIONSHIP_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);
insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_work_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'HEALTH_INFO', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), HEALTH_INFO_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_transfer_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'SALARY_PROCESS', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), SALARY_PROCESS_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);
    
insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_transfer_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'POSITION_SALARY', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), POSITION_SALARY_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);
insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_work_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'SALARY_INCREASE', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), SALARY_INCREASE_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_transfer_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'INSURANCE_SALARY_PROCESS', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), INSURANCE_SALARY_PROCESS_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);
insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_work_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'EDUCATION_PROCESS', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), EDUCATION_PROCESS_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1); 

insert into gsync_load_filter (load_filter_id, load_filter_type, source_node_group_id,target_node_group_id, target_catalog_name, target_schema_name, target_table_name, filter_on_update, filter_on_insert, filter_on_delete, before_write_script, after_write_script, batch_complete_script, batch_commit_script, batch_rollback_script, handle_error_script, create_time, last_update_by, last_update_time, load_filter_order, fail_on_error) 
    values ('vhr_td_transfer_process', 'bsh', 'vhr_vtc', 'vhr_td', null, null, 'EMP_ALLOWANCE_PROCESS', 1, 1, 1, null, 'engine.getExtensionBean("syncWorkProcess",com.viettel.ghr.ghrcenter.vtgroup.service.IRecordLogService.class).writeRecordLog(context, table, context.getData(), EMP_ALLOWANCE_PROCESS_ID);' , null, null, null, null, current_timestamp, 'gsync_admin', current_timestamp, 1, 1);