
CREATE DATABASE RetailBankDWH;
GO

USE RetailBankDWH;
GO

CREATE SCHEMA Bronze;
GO

CREATE SCHEMA Silver;
GO

CREATE SCHEMA Gold;
GO


USE RetailBankDWH;
GO

SELECT COUNT(*) AS CustomerCount
FROM Bronze.Customers_Raw;
SELECT COUNT(*) AS MerchantsCount
FROM Bronze.Merchants;
SELECT COUNT(*) AS TransactionsCount
FROM Bronze.Transactions;

SELECT TOP (5) *
FROM Bronze.Customers_Raw;
SELECT TOP (5) *
FROM Bronze.Merchants;
SELECT TOP (5) *
FROM Bronze.Transactions;

SELECT *
FROM Bronze.Customers_Raw
WHERE customer_id IS NULL;
SELECT *
FROM Bronze.Merchants
WHERE Merchant_id IS NULL;
SELECT *
FROM Bronze.Transactions 
WHERE transaction_id IS NULL;

SELECT
COUNT(*) AS TotalRows,

SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS Null_CustomerID,

SUM(CASE WHEN first_name IS NULL THEN 1 ELSE 0 END) AS Null_FirstName,

SUM(CASE WHEN last_name IS NULL THEN 1 ELSE 0 END) AS Null_LastName,

SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS Null_Gender,

SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS Null_City,

SUM(CASE WHEN state IS NULL THEN 1 ELSE 0 END) AS Null_State,

SUM(CASE WHEN job IS NULL THEN 1 ELSE 0 END) AS Null_Job,

SUM(CASE WHEN dob IS NULL THEN 1 ELSE 0 END) AS Null_DOB

FROM Bronze.Customers_Raw;


SELECT
COUNT(*) AS TotalRows,

SUM(CASE WHEN merchant_id IS NULL THEN 1 ELSE 0 END) AS Null_MerchantID,

SUM(CASE WHEN merchant_name IS NULL THEN 1 ELSE 0 END) AS Null_MerchantName,

SUM(CASE WHEN dominant_category IS NULL THEN 1 ELSE 0 END) AS Null_Category,

SUM(CASE WHEN merchant_city IS NULL THEN 1 ELSE 0 END) AS Null_City,

SUM(CASE WHEN merchant_state IS NULL THEN 1 ELSE 0 END) AS Null_State,

SUM(CASE WHEN merchant_since IS NULL THEN 1 ELSE 0 END) AS Null_Since,

SUM(CASE WHEN is_active IS NULL THEN 1 ELSE 0 END) AS Null_IsActive

FROM Bronze.Merchants;

SELECT
COUNT(*) AS TotalRows,

SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS Null_TransactionID,

SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS Null_CustomerID,

SUM(CASE WHEN merchant_id IS NULL THEN 1 ELSE 0 END) AS Null_MerchantID,

SUM(CASE WHEN trans_date_trans_time IS NULL THEN 1 ELSE 0 END) AS Null_TransactionDate,

SUM(CASE WHEN amt IS NULL THEN 1 ELSE 0 END) AS Null_Amount,

SUM(CASE WHEN currency IS NULL THEN 1 ELSE 0 END) AS Null_Currency,

SUM(CASE WHEN payment_method IS NULL THEN 1 ELSE 0 END) AS Null_PaymentMethod,

SUM(CASE WHEN channel IS NULL THEN 1 ELSE 0 END) AS Null_Channel,

SUM(CASE WHEN entry_mode IS NULL THEN 1 ELSE 0 END) AS Null_EntryMode

FROM Bronze.Transactions;

SELECT
    customer_id,
    COUNT(*) AS DuplicateCount
FROM Bronze.Customers_Raw
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT
    merchant_id,
    COUNT(*) AS DuplicateCount
FROM Bronze.Merchants
GROUP BY merchant_id
HAVING COUNT(*) > 1;

SELECT
    transaction_id,
    COUNT(*) AS DuplicateCount
FROM Bronze.Transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;

SELECT
    SUM(CASE WHEN LTRIM(RTRIM(first_name)) = '' THEN 1 ELSE 0 END) AS Blank_FirstName,
    SUM(CASE WHEN LTRIM(RTRIM(last_name)) = '' THEN 1 ELSE 0 END) AS Blank_LastName,
    SUM(CASE WHEN LTRIM(RTRIM(city)) = '' THEN 1 ELSE 0 END) AS Blank_City,
    SUM(CASE WHEN LTRIM(RTRIM(job)) = '' THEN 1 ELSE 0 END) AS Blank_Job
FROM Bronze.Customers_Raw;

SELECT
    SUM(CASE WHEN LTRIM(RTRIM(merchant_name)) = '' THEN 1 ELSE 0 END) AS Blank_MerchantName,
    SUM(CASE WHEN LTRIM(RTRIM(dominant_category)) = '' THEN 1 ELSE 0 END) AS Blank_Category,
    SUM(CASE WHEN LTRIM(RTRIM(merchant_city)) = '' THEN 1 ELSE 0 END) AS Blank_City,
    SUM(CASE WHEN LTRIM(RTRIM(merchant_state)) = '' THEN 1 ELSE 0 END) AS Blank_State
FROM Bronze.Merchants;

SELECT
    SUM(CASE WHEN LTRIM(RTRIM(category)) = '' THEN 1 ELSE 0 END) AS Blank_Category,
    SUM(CASE WHEN LTRIM(RTRIM(currency)) = '' THEN 1 ELSE 0 END) AS Blank_Currency,
    SUM(CASE WHEN LTRIM(RTRIM(payment_method)) = '' THEN 1 ELSE 0 END) AS Blank_PaymentMethod,
    SUM(CASE WHEN LTRIM(RTRIM(channel)) = '' THEN 1 ELSE 0 END) AS Blank_Channel,
    SUM(CASE WHEN LTRIM(RTRIM(entry_mode)) = '' THEN 1 ELSE 0 END) AS Blank_EntryMode
FROM Bronze.Transactions;

SELECT
    COUNT(*) AS InvalidTransactionDate
FROM Bronze.Transactions_Raw
WHERE TRY_CAST(trans_date_trans_time AS DATETIME) IS NULL;


SELECT
    COUNT(*) AS InvalidAmount
FROM Bronze.Transactions_Raw
WHERE TRY_CAST(amt AS DECIMAL(18,2)) IS NULL;

SELECT DISTINCT gender
FROM Bronze.Customers_Raw;

SELECT DISTINCT dominant_category
FROM Bronze.Merchants_Raw
ORDER BY dominant_category;

SELECT DISTINCT currency
FROM Bronze.Transactions_Raw;
SELECT DISTINCT payment_method
FROM Bronze.Transactions_Raw;
SELECT DISTINCT channel
FROM Bronze.Transactions_Raw;
SELECT DISTINCT entry_mode
FROM Bronze.Transactions_Raw;


SELECT COUNT(*) AS OrphanCustomers
FROM Bronze.Transactions_Raw t
LEFT JOIN Bronze.Customers_Raw c
ON t.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT COUNT(*) AS OrphanMerchants
FROM Bronze.Transactions_Raw t
LEFT JOIN Bronze.Merchants_Raw m
ON t.merchant_id = m.merchant_id
WHERE m.merchant_id IS NULL;



USE RetailBankDWH;
GO

SELECT
    TRY_CAST(customer_id AS INT) AS customer_id,
    TRY_CAST(cc_num AS BIGINT) AS cc_num,

    LTRIM(RTRIM(first_name)) AS first_name,
    LTRIM(RTRIM(last_name)) AS last_name,
    LTRIM(RTRIM(gender)) AS gender,
    LTRIM(RTRIM(street)) AS street,
    LTRIM(RTRIM(city)) AS city,
    LTRIM(RTRIM(state)) AS state,

    TRY_CAST(zip AS INT) AS zip,
    TRY_CAST(lat AS DECIMAL(10,6)) AS lat,
    TRY_CAST(long AS DECIMAL(10,6)) AS [long],
    TRY_CAST(city_pop AS INT) AS city_pop,

    ISNULL(LTRIM(RTRIM(job)), 'Unknown') AS job,

    TRY_CAST(dob AS DATE) AS dob,

    LTRIM(RTRIM(loyalty_tier)) AS loyalty_tier,
    LTRIM(RTRIM(email_domain)) AS email_domain,

    TRY_CAST(signup_date AS DATE) AS signup_date

INTO Silver.Customers

FROM Bronze.Customers_Raw;

SELECT TOP (5) *
FROM Silver.Customers;

SELECT
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN job IS NULL THEN 1 ELSE 0 END) AS NullJob,
    SUM(CASE WHEN job = 'Unknown' THEN 1 ELSE 0 END) AS UnknownJob
FROM Silver.Customers;

ALTER TABLE Silver.Customers
ALTER COLUMN customer_id INT NOT NULL;

ALTER TABLE Silver.Customers
ADD CONSTRAINT PK_Silver_Customers
PRIMARY KEY (customer_id);


SELECT
    TRY_CAST(merchant_id AS INT) AS merchant_id,

    LTRIM(RTRIM(merchant_name)) AS merchant_name,

    LTRIM(RTRIM(dominant_category)) AS dominant_category,

    ISNULL(LTRIM(RTRIM(merchant_city)), 'Unknown') AS merchant_city,

    LTRIM(RTRIM(merchant_state)) AS merchant_state,

    TRY_CAST(merchant_lat AS DECIMAL(10,6)) AS merchant_lat,

    TRY_CAST(merchant_long AS DECIMAL(10,6)) AS merchant_long,

    TRY_CAST(merchant_since AS DATE) AS merchant_since,

    TRY_CAST(is_active AS INT) AS is_active

INTO Silver.Merchants

FROM Bronze.Merchants_Raw;

 SELECT
    COUNT(*) AS TotalMerchants,
    SUM(CASE WHEN merchant_city IS NULL THEN 1 ELSE 0 END) AS NullCity,
    SUM(CASE WHEN merchant_city = 'Unknown' THEN 1 ELSE 0 END) AS UnknownCity
FROM Silver.Merchants;

ALTER TABLE Silver.Merchants
ALTER COLUMN merchant_id INT NOT NULL;

ALTER TABLE Silver.Merchants
ADD CONSTRAINT PK_Silver_Merchants
PRIMARY KEY (merchant_id);

SELECT
    TRY_CAST(transaction_id AS INT) AS transaction_id,
    TRY_CAST(customer_id AS INT) AS customer_id,
    TRY_CAST(merchant_id AS INT) AS merchant_id,

    TRY_CAST(trans_date_trans_time AS DATETIME) AS trans_date_trans_time,

    LTRIM(RTRIM(category)) AS category,

    TRY_CAST(amt AS DECIMAL(18,2)) AS amt,
    TRY_CAST(tax_amt AS DECIMAL(18,2)) AS tax_amt,
    TRY_CAST(discount_amt AS DECIMAL(18,2)) AS discount_amt,

    LTRIM(RTRIM(currency)) AS currency,
    LTRIM(RTRIM(payment_method)) AS payment_method,
    LTRIM(RTRIM(channel)) AS channel,
    LTRIM(RTRIM(entry_mode)) AS entry_mode

INTO Silver.Transactions

FROM Bronze.Transactions_Raw;

SELECT
    COUNT(*) AS TotalTransactions,

    SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS NullTransactionID,

    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS NullCustomerID,

    SUM(CASE WHEN merchant_id IS NULL THEN 1 ELSE 0 END) AS NullMerchantID,

    SUM(CASE WHEN trans_date_trans_time IS NULL THEN 1 ELSE 0 END) AS NullTransactionDate,

    SUM(CASE WHEN amt IS NULL THEN 1 ELSE 0 END) AS NullAmount

FROM Silver.Transactions;

ALTER TABLE Silver.Transactions
ALTER COLUMN transaction_id INT NOT NULL;

ALTER TABLE Silver.Transactions
ADD CONSTRAINT PK_Silver_Transactions
PRIMARY KEY (transaction_id);


SELECT
    SCHEMA_NAME(schema_id) AS SchemaName
FROM sys.schemas
WHERE name = 'Gold';


SELECT
    IDENTITY(INT, 1, 1) AS customer_key,
    customer_id,
    first_name,
    last_name,
    gender,
    street,
    city,
    state,
    zip,
    lat,
    [long],
    city_pop,
    job,
    dob,
    loyalty_tier,
    email_domain,
    signup_date
INTO Gold.DimCustomer
FROM Silver.Customers;

SELECT
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN customer_key IS NULL THEN 1 ELSE 0 END) AS NullCustomerKey,
    COUNT(DISTINCT customer_key) AS DistinctCustomerKeys
FROM Gold.DimCustomer;

ALTER TABLE Gold.DimCustomer
ALTER COLUMN customer_key INT NOT NULL;

ALTER TABLE Gold.DimCustomer
ADD CONSTRAINT PK_DimCustomer
PRIMARY KEY (customer_key);


SELECT
    IDENTITY(INT, 1, 1) AS merchant_key,
    merchant_id,
    merchant_name,
    dominant_category,
    merchant_city,
    merchant_state,
    merchant_lat,
    merchant_long,
    merchant_since,
    is_active
INTO Gold.DimMerchant
FROM Silver.Merchants;


SELECT
    MIN(CAST(trans_date_trans_time AS DATE)) AS StartDate,
    MAX(CAST(trans_date_trans_time AS DATE)) AS EndDate
FROM Silver.Transactions;

CREATE TABLE Gold.DimDate
(
    date_key INT NOT NULL,
    full_date DATE NOT NULL,
    [year] INT NOT NULL,
    [quarter] INT NOT NULL,
    [month] INT NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    [day] INT NOT NULL,
    day_name VARCHAR(20) NOT NULL,
    is_weekend BIT NOT NULL,

    CONSTRAINT PK_DimDate
        PRIMARY KEY (date_key)
);
GO

DECLARE @CurrentDate DATE = '2024-01-01';
DECLARE @EndDate DATE = '2024-06-29';

WHILE @CurrentDate <= @EndDate
BEGIN

    INSERT INTO Gold.DimDate
    (
        date_key,
        full_date,
        [year],
        [quarter],
        [month],
        month_name,
        [day],
        day_name,
        is_weekend
    )
    VALUES
    (
        CAST(CONVERT(CHAR(8), @CurrentDate, 112) AS INT),
        @CurrentDate,
        YEAR(@CurrentDate),
        DATEPART(QUARTER, @CurrentDate),
        MONTH(@CurrentDate),
        DATENAME(MONTH, @CurrentDate),
        DAY(@CurrentDate),
        DATENAME(WEEKDAY, @CurrentDate),

        CASE
            WHEN DATEPART(WEEKDAY, @CurrentDate) IN (1, 7)
                THEN 1
            ELSE 0
        END
    );

    SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);

END;
GO

SELECT
    COUNT(*) AS TotalDates,
    MIN(full_date) AS FirstDate,
    MAX(full_date) AS LastDate
FROM Gold.DimDate;

SELECT
    t.transaction_id,

    d.date_key,

    c.customer_key,

    m.merchant_key,

    t.category,
    t.amt,
    t.tax_amt,
    t.discount_amt,
    t.currency,
    t.payment_method,
    t.channel,
    t.entry_mode

INTO Gold.FactTransactions

FROM Silver.Transactions AS t

INNER JOIN Gold.DimCustomer AS c
    ON t.customer_id = c.customer_id

INNER JOIN Gold.DimMerchant AS m
    ON t.merchant_id = m.merchant_id

INNER JOIN Gold.DimDate AS d
    ON CAST(t.trans_date_trans_time AS DATE) = d.full_date;

SELECT
   COUNT(*) AS TotalRows
FROM Gold.FactTransactions;


SELECT TOP (5) *
FROM Gold.FactTransactions;

SELECT
    COUNT(*) AS TotalTransactions,

    SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS NullTransactionID,

    SUM(CASE WHEN date_key IS NULL THEN 1 ELSE 0 END) AS NullDateKey,

    SUM(CASE WHEN customer_key IS NULL THEN 1 ELSE 0 END) AS NullCustomerKey,

    SUM(CASE WHEN merchant_key IS NULL THEN 1 ELSE 0 END) AS NullMerchantKey

FROM Gold.FactTransactions;

ALTER TABLE Gold.FactTransactions
ALTER COLUMN transaction_id INT NOT NULL;

ALTER TABLE Gold.FactTransactions
ADD CONSTRAINT PK_FactTransactions
PRIMARY KEY (transaction_id);

ALTER TABLE Gold.FactTransactions
ADD CONSTRAINT FK_FactTransactions_DimCustomer
FOREIGN KEY (customer_key)
REFERENCES Gold.DimCustomer(customer_key);


ALTER TABLE Gold.DimMerchant
ALTER COLUMN merchant_key INT NOT NULL;

ALTER TABLE Gold.DimMerchant
ADD CONSTRAINT PK_DimMerchant
PRIMARY KEY (merchant_key);

ALTER TABLE Gold.FactTransactions
ADD CONSTRAINT FK_FactTransactions_DimMerchant
FOREIGN KEY (merchant_key)
REFERENCES Gold.DimMerchant(merchant_key);

ALTER TABLE Gold.FactTransactions
ADD CONSTRAINT FK_FactTransactions_DimDate
FOREIGN KEY (date_key)
REFERENCES Gold.DimDate(date_key);

SELECT
    COUNT(*) AS TotalTransactions,

    COUNT(c.customer_key) AS ValidCustomers,

    COUNT(m.merchant_key) AS ValidMerchants,

    COUNT(d.date_key) AS ValidDates

FROM Gold.FactTransactions AS f

LEFT JOIN Gold.DimCustomer AS c
    ON f.customer_key = c.customer_key

LEFT JOIN Gold.DimMerchant AS m
    ON f.merchant_key = m.merchant_key

LEFT JOIN Gold.DimDate AS d
    ON f.date_key = d.date_key;

CREATE INDEX IX_FactTransactions_DateKey
ON Gold.FactTransactions (date_key);

CREATE INDEX IX_FactTransactions_CustomerKey
ON Gold.FactTransactions (customer_key);

CREATE INDEX IX_FactTransactions_MerchantKey
ON Gold.FactTransactions (merchant_key);


SELECT 'DimCustomer' AS TableName, COUNT(*) AS TotalRows
FROM Gold.DimCustomer

UNION ALL

SELECT 'DimMerchant', COUNT(*)
FROM Gold.DimMerchant

UNION ALL

SELECT 'DimDate', COUNT(*)
FROM Gold.DimDate

UNION ALL

SELECT 'FactTransactions', COUNT(*)
FROM Gold.FactTransactions;


SELECT
    'Primary Keys' AS ConstraintType,
    COUNT(*) AS TotalConstraints
FROM sys.key_constraints
WHERE parent_object_id IN
(
    OBJECT_ID('Gold.DimCustomer'),
    OBJECT_ID('Gold.DimMerchant'),
    OBJECT_ID('Gold.DimDate'),
    OBJECT_ID('Gold.FactTransactions')
)

UNION ALL

SELECT
    'Foreign Keys',
    COUNT(*)
FROM sys.foreign_keys
WHERE parent_object_id = OBJECT_ID('Gold.FactTransactions');