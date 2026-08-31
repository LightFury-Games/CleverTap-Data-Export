CREATE EXTERNAL TABLE clevertap.session_start (
    commPrefs MAP<
        STRING,
        STRUCT<
            member0: BOOLEAN,
            member1: INTEGER,
            member2: BIGINT,
            member3: FLOAT,
            member4: DOUBLE,
            member5: STRING,
            member6: MAP<
                STRING,
                STRUCT<
                    member0: BOOLEAN,
                    member1: INTEGER,
                    member2: BIGINT,
                    member3: FLOAT,
                    member4: DOUBLE,
                    member5: STRING
                >
            >
        >
    >,

    deviceInfo MAP<
        STRING,
        STRUCT<
            member0: STRING,
            member1: INTEGER,
            member2: MAP<
                STRING,
                STRUCT<
                    member0: STRING,
                    member1: INTEGER
                >
            >
        >
    >,

    eventName STRING,

    eventProps MAP<
        STRING,
        STRUCT<
            member0: BOOLEAN,
            member1: INTEGER,
            member2: BIGINT,
            member3: FLOAT,
            member4: DOUBLE,
            member5: STRING,
            member6: ARRAY<
                STRUCT<
                    member0: BOOLEAN,
                    member1: INTEGER,
                    member2: BIGINT,
                    member3: FLOAT,
                    member4: DOUBLE,
                    member5: STRING,
                    member6: MAP<
                        STRING,
                        STRUCT<
                            member0: BOOLEAN,
                            member1: INTEGER,
                            member2: BIGINT,
                            member3: FLOAT,
                            member4: DOUBLE,
                            member5: STRING
                        >
                    >
                >
            >
        >
    >,

    eventTime STRING,

    identity MAP<
        STRING,
        STRUCT<
            member0: STRING,
            member1: ARRAY<
                STRUCT<
                    member0: STRING,
                    member1: INTEGER,
                    member2: BIGINT,
                    member3: FLOAT,
                    member4: DOUBLE
                >
            >,
            member2: INTEGER,
            member3: BIGINT,
            member4: FLOAT,
            member5: DOUBLE
        >
    >,

    profile MAP<
        STRING,
        STRUCT<
            member0: STRING,
            member1: ARRAY<STRING>,
            member2: INTEGER,
            member3: BIGINT,
            member4: FLOAT,
            member5: DOUBLE
        >
    >
)
STORED AS PARQUET
LOCATION 's3://clevertap-prod-export/session_start';