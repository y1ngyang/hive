set hive.explain.user=false;
SET hive.vectorized.execution.enabled=true;
set hive.fetch.task.conversion=none;

create table vectortab2k(
            t tinyint,
            si smallint,
            i int,
            b bigint,
            f float,
            d double,
            dc decimal(38,18),
            bo boolean,
            s string,
            s2 string,
            ts timestamp,
            ts2 timestamp,
            dt date)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH '../../data/files/vectortab2k' OVERWRITE INTO TABLE vectortab2k;

create table vectortab2korc(
            t tinyint,
            si smallint,
            i int,
            b bigint,
            f float,
            d double,
            dc decimal(38,18),
            bo boolean,
            s string,
            s2 string,
            ts timestamp,
            ts2 timestamp,
            dt date)
STORED AS ORC;

INSERT INTO TABLE vectortab2korc SELECT * FROM vectortab2k;

-- SORT_QUERY_RESULTS

explain vectorization detail
select min(dc), max(dc), sum(dc), avg(dc) from vectortab2korc;

select min(dc), max(dc), sum(dc), avg(dc) from vectortab2korc;

explain vectorization detail
select min(d), max(d), sum(d), avg(d) from vectortab2korc;

select min(d), max(d), sum(d), avg(d) from vectortab2korc;

explain vectorization detail
select min(ts), max(ts), sum(ts), avg(ts) from vectortab2korc;

select min(ts), max(ts), sum(ts), avg(ts) from vectortab2korc;