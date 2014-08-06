select 'insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values (''vhr_td_province'', ''U'', ''' || column_name || ''', ''' || column_name || ''', 0, ''copy'', 11, current_timestamp, ''gsync_admin'', current_timestamp);'
from all_tab_cols
where table_name='PROVINCE' and owner='VHR_DEV'
union all
select 'insert into gsync_transform_column(transform_id, include_on, target_column_name, source_column_name, pk, transform_type, transform_order, create_time, last_update_by, last_update_time)
    values (''vhr_td_province'', ''I'', ''' || column_name || ''', ''' || column_name || ''', 0, ''copy'', 11, current_timestamp, ''gsync_admin'', current_timestamp);'
from all_tab_cols
where table_name='PROVINCE' and owner='VHR_DEV';