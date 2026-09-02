CREATE EXTERNAL TABLE clevertap.user_profiles (
    identity STRING,
    
    profileIdentities MAP<
        STRING,
        STRUCT<
            member0: STRING,
            member1: ARRAY<STRING>
        >
    >,
    
    device MAP<
        STRING,
        STRUCT<
            member0: BOOLEAN,
            member1: INTEGER,
            member2: BIGINT,
            member3: FLOAT,
            member4: DOUBLE,
            member5: STRING
        >
    >,
    
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
    
    profileProps MAP<
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
)
STORED AS PARQUET
LOCATION 's3://clevertap-prod-export/Profile';