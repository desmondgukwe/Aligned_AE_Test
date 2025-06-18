--Creatings tables for csvs - in my opnion its not the greated way to do it but to use python to generate it , simply because if the csvs have more than 200 columns then it's a problem
CREATE TABLE public.clients (
    id SERIAL PRIMARY KEY,
    gender TEXT,
    age INTEGER,
    province TEXT,
    income FLOAT,
    bank TEXT,
    num_products INTEGER,
    client_duration INTEGER,
    payment TEXT,
    distrn TEXT
);

CREATE TABLE public.health_lapses (
    id SERIAL PRIMARY KEY,
    option TEXT,
    family TEXT,
    lapse_indicator BOOLEAN
);


CREATE TABLE public.health_products (
    option TEXT PRIMARY KEY,
    single_premium FLOAT,
    couple_premium FLOAT,
    family_premium FLOAT
);

SELECT id, gender, age, province, income, bank, num_products, client_duration, payment, distrn
FROM public.clients;

SELECT "option", single_premium, couple_premium, family_premium
FROM public.health_products;

SELECT id, "option", "family", lapse_indicator
FROM public.health_lapses;






-- INIT database
CREATE TABLE Insturctions (
InstructionID INT AUTO_INCREMENT KEY,
Name VARCHAR(100),
Description VARCHAR(255),
Active BOOLEAN
);