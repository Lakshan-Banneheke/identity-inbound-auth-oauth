CREATE TABLE IF NOT EXISTS IDN_BASE_TABLE (
            PRODUCT_NAME VARCHAR (20),
            PRIMARY KEY (PRODUCT_NAME)
);

CREATE TABLE IF NOT EXISTS IDN_OAUTH_CONSUMER_APPS (
    ID INTEGER NOT NULL AUTO_INCREMENT,
    CONSUMER_KEY VARCHAR (255),
    CONSUMER_SECRET VARCHAR (2048),
    USERNAME VARCHAR (255),
    TENANT_ID INTEGER DEFAULT 0,
    USER_DOMAIN VARCHAR(50),
    APP_NAME VARCHAR (255),
    OAUTH_VERSION VARCHAR (128),
    CALLBACK_URL VARCHAR (2048),
    GRANT_TYPES VARCHAR (1024),
    PKCE_MANDATORY CHAR(1) DEFAULT '0',
    PKCE_SUPPORT_PLAIN CHAR(1) DEFAULT '0',
    APP_STATE VARCHAR (25) DEFAULT 'ACTIVE',
    USER_ACCESS_TOKEN_EXPIRE_TIME BIGINT DEFAULT 3600,
    APP_ACCESS_TOKEN_EXPIRE_TIME BIGINT DEFAULT 3600,
    REFRESH_TOKEN_EXPIRE_TIME BIGINT DEFAULT 84600,
    ID_TOKEN_EXPIRE_TIME BIGINT DEFAULT 3600,
    CONSTRAINT CONSUMER_KEY_CONSTRAINT UNIQUE (TENANT_ID, CONSUMER_KEY),
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS IDN_OAUTH2_SCOPE_VALIDATORS (
	APP_ID INTEGER NOT NULL,
	SCOPE_VALIDATOR VARCHAR (128) NOT NULL,
	PRIMARY KEY (APP_ID,SCOPE_VALIDATOR),
	FOREIGN KEY (APP_ID) REFERENCES IDN_OAUTH_CONSUMER_APPS(ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS IDN_OPENID_USER_RPS (
			USER_NAME VARCHAR(255) NOT NULL,
			TENANT_ID INTEGER DEFAULT 0,
			RP_URL VARCHAR(255) NOT NULL,
			TRUSTED_ALWAYS VARCHAR(128) DEFAULT 'FALSE',
			LAST_VISIT DATE NOT NULL,
			VISIT_COUNT INTEGER DEFAULT 0,
			DEFAULT_PROFILE_NAME VARCHAR(255) DEFAULT 'DEFAULT',
			PRIMARY KEY (USER_NAME, TENANT_ID, RP_URL)
);

CREATE TABLE IF NOT EXISTS IDN_OIDC_PROPERTY (
    ID INTEGER NOT NULL AUTO_INCREMENT,
    TENANT_ID  INTEGER,
    CONSUMER_KEY  VARCHAR(255) ,
    PROPERTY_KEY  VARCHAR(255) NOT NULL,
    PROPERTY_VALUE  VARCHAR(2047) ,
    PRIMARY KEY (ID),
    FOREIGN KEY (TENANT_ID, CONSUMER_KEY) REFERENCES IDN_OAUTH_CONSUMER_APPS(TENANT_ID, CONSUMER_KEY) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS IDN_OAUTH2_TOKEN_CLAIMS (
    ID INTEGER NOT NULL AUTO_INCREMENT,
    APP_ID INTEGER NOT NULL,
    CLAIM_URI VARCHAR(255) NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT TOKEN_CLAIMS_CONSTRAINT UNIQUE (APP_ID, CLAIM_URI),
    FOREIGN KEY (APP_ID) REFERENCES IDN_OAUTH_CONSUMER_APPS(ID) ON DELETE CASCADE
);
