--normal select statement
SELECT VendorID FROM `direct-branch-410717.uber_dataset.fact_table` GROUP BY VendorID;

--join example
select b.payment_type_name, avg(a.tip_amount) from `direct-branch-410717.uber_dataset.fact_table`
a
join `direct-branch-410717.uber_dataset.payment_type_dim` b
on a.payment_type_id = b.payment_type_id
group by payment_type_name;

--create table via joining all the tables in the database
create or replace table `direct-branch-410717.uber_dataset.uber_analytics` as(
  select
  f.VendorID,
  d.tpep_pickup_datetime,
  d.tpep_dropoff_datetime,
  p.passenger_count,
  td.trip_distance,
  rc.rate_code_name,
  f.store_and_fwd_flag,
  f.PULocationID,
  f.DOLocationID,
  pt.payment_type_name,
  f.fare_amount,
  f.extra,
  f.mta_tax,
  f.tip_amount,
  f.tolls_amount,
  f.improvement_surcharge,
  f.total_amount

  from
    `direct-branch-410717.uber_dataset.fact_table` f
    join `direct-branch-410717.uber_dataset.datetime_dim` d on f.datetime_id = d.datetime_id
    join `direct-branch-410717.uber_dataset.passenger_count_dim` p on f.passenger_count_id = p.passenger_count_id
    join `direct-branch-410717.uber_dataset.trip_distance_dim` td on f.trip_distance_id = td.trip_distance_id
    join `direct-branch-410717.uber_dataset.rate_code_dim` rc on f.rate_code_id = rc.rate_code_id
    join `direct-branch-410717.uber_dataset.payment_type_dim` pt on f.payment_type_id = pt.payment_type_id);

select * from `direct-branch-410717.uber_dataset.uber_analytics` limit 100;