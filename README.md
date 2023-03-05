# clickhouse_url_dict
Example of using ClickHouse's URL dictionaries

Simple Ruby HTTP server that reads and returns CSV

### How to test
```shell
docker compose up -d # start ClickHouse and Ruby server

docker compose exec clickhouse clickhouse-client
```

```sql
SELECT
    dictGet('default.http_test', 'result', (number, number * 2)) AS response,
    (number * number) * 2 AS assert
FROM numbers(10)

┌─response─┬─assert─┐
│        0 │      0 │
│        2 │      2 │
│        8 │      8 │
│       18 │     18 │
│       32 │     32 │
│       50 │     50 │
│       72 │     72 │
│       98 │     98 │
│      128 │    128 │
│      162 │    162 │
└──────────┴────────┘

10 rows in set. Elapsed: 0.015 sec.
```

Reading 10 Mln rows from HTTP dict takes less than 4 seconds
```sql
SELECT dictGet('default.http_test', 'result', (number, number * 2)) AS id
FROM numbers(10000000)
FORMAT `Null`

Ok.

0 rows in set. Elapsed: 3.770 sec. Processed 10.01 million rows, 80.06 MB (2.65 million rows/s., 21.24 MB/s.)
```

### Bonus
Connection details defined using named collection and API KEY is loaded through env variables, so it is not available in dictionary DDL
