CREATE TABLE locations (
    location_name TEXT NOT NULL,
    iso_code      TEXT NOT NULL,
    PRIMARY KEY (
        iso_code
    )
);

CREATE TABLE date (
    date  DATE NOT NULL,
    month INT,
    year  INT,
    PRIMARY KEY (
        date
    )
);


CREATE TABLE VaccineByAge (
    iso_code                            TEXT NOT NULL,
    date                                DATE NOT NULL,
    age_group                           TEXT NOT NULL,
    people_vaccinated_per_hundred       TEXT,
    people_fully_vaccinated_per_hundred TEXT,
    people_with_booster_per_hundred     TEXT,
    FOREIGN KEY (
        iso_code
    )
    REFERENCES locations (iso_code),
    FOREIGN KEY (
        date
    )
    REFERENCES date (date),
    PRIMARY KEY (
        iso_code,
        date,
        age_group
    )
);


CREATE TABLE source (
    source_name VARCHAR,
    source_url  VARCHAR,
    PRIMARY KEY (
        source_name
    )
);

CREATE TABLE country_vaccine (
    iso_code VARCHAR,
    vaccine  VARCHAR,
    PRIMARY KEY (
        iso_code,
        vaccine
    ),
    FOREIGN KEY (
        iso_code
    )
    REFERENCES locations (iso_code) 
);

CREATE TABLE country_vaccinations (
    iso_code                VARCHAR NOT NULL,
    date                    DATE    NOT NULL,
    vaccine                 VARCHAR NOT NULL,
    source_name             VARCHAR,
    people_vaccinated       INT,
    people_fully_vaccinated INT,
    total_boosters          INT,
    PRIMARY KEY (
        iso_code,
        date,
        vaccine
    ),
    FOREIGN KEY (
        iso_code,
        vaccine
    )
    REFERENCES country_vaccine (iso_code,
    vaccine),
    FOREIGN KEY (
        date
    )
    REFERENCES date (date),
    FOREIGN KEY (
        source_name
    )
    REFERENCES source (source_name) 
);

CREATE TABLE vaccination (
    iso_code                            VARCHAR NOT NULL,
    date                                DATE    NOT NULL,
    people_vaccinated                   INT,
    people_fully_vaccinated             INT,
    total_boosters                      INT,
    daily_vaccinations                  INT,
    people_vaccinated_per_hundred       INT,
    people_fully_vaccinated_per_hundred INT,
    total_boosters_per_hundred          INT,
    daily_vaccinations_per_million      INT,
    daily_people_vaccinated             INT,
    daily_people_vaccinated_per_hundred INT,
    source_name                         VARCHAR,
    PRIMARY KEY (
        iso_code,
        date
    ),
    FOREIGN KEY (
        iso_code
    )
    REFERENCES locations (iso_code),
    FOREIGN KEY (
        date
    )
    REFERENCES date (date),
    FOREIGN KEY (
        source_name
    )
    REFERENCES source (source_name) 
);


CREATE TABLE us_state_name (
    iso_code   VARCHAR,
    state_name VARCHAR,
    PRIMARY KEY (
        iso_code,
        state_name
    ),
    FOREIGN KEY (
        iso_code
    )
    REFERENCES locations (iso_code) 
);

CREATE TABLE us_state_vaccines (
    iso_code                            VARCHAR NOT NULL,
    state_name                          VARCHAR NOT NULL,
    date                                DATE    NOT NULL,
    total_distributed                   INT,
    people_vaccinated                   INT,
    people_fully_vaccinated_per_hundred INT,
    people_fully_vaccinated             INT,
    people_vaccinated_per_hundred       INT,
    distributed_per_hundred             INT,
    daily_vaccinations                  INT,
    daily_vaccinations_per_million      INT,
    share_doses_used                    INT,
    total_boosters                      INT,
    total_boosters_per_hundred          INT,
    PRIMARY KEY (
        iso_code,
        state_name,
        date
    ),
    FOREIGN KEY (
        iso_code,
        state_name
    )
    REFERENCES us_state_name (iso_code,
    state_name),
    FOREIGN KEY (
        date
    )
    REFERENCES date (date) 
);


