select month,
case when data_type='max' then max(data_value)
when data_type='min' then min(data_value)
when data_type='avg' then ceil(avg(data_value)) 
end
from (select substr(record_date, 6, 2) as month, data_type, data_value 
from temperature_records) as temp_table
group by month, data_type;

