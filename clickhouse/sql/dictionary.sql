CREATE OR REPLACE DICTIONARY default.http_test
(
    `app_id`  UInt64,
    `user_id` UInt64,
    `result`  UInt64
)
PRIMARY KEY app_id, user_id
SOURCE(
	HTTP(
		NAME testdict
	)
)
LAYOUT(COMPLEX_KEY_DIRECT)

-- SELECT dictGet('default.http_test', 'result', (number, number * 2)) AS id FROM numbers(1000)
