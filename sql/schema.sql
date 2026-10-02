CREATE TABLE customer (
    customer_id UUID PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    status VARCHAR(50) NOT NULL
);

CREATE TABLE brokerage_application (
    application_id UUID PRIMARY KEY,
    customer_id UUID NOT NULL REFERENCES customer(customer_id),
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE consent (
    consent_id UUID PRIMARY KEY,
    application_id UUID NOT NULL REFERENCES brokerage_application(application_id),
    type VARCHAR(100) NOT NULL,
    document_version VARCHAR(50) NOT NULL,
    accepted_at TIMESTAMP NOT NULL
);

CREATE TABLE brokerage_account (
    account_id UUID PRIMARY KEY,
    application_id UUID UNIQUE NOT NULL REFERENCES brokerage_application(application_id),
    customer_id UUID NOT NULL REFERENCES customer(customer_id),
    opened_at TIMESTAMP NOT NULL
);

CREATE TABLE status_history (
    history_id UUID PRIMARY KEY,
    application_id UUID NOT NULL REFERENCES brokerage_application(application_id),
    old_status VARCHAR(50),
    new_status VARCHAR(50) NOT NULL,
    changed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_brokerage_application_customer
    ON brokerage_application(customer_id);

CREATE INDEX idx_brokerage_application_status
    ON brokerage_application(status);
