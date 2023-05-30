------ admin table ------
CREATE TABLE admins (
    admin_id INT,
    admin_username VARCHAR(20),
    admin_password VARCHAR(20),
    CONSTRAINT admin_id_pk PRIMARY KEY (admin_id)
);


------ categories table ------
CREATE TABLE categories (
    cat_id INT,
    cat_name VARCHAR(20),
    CONSTRAINT cat_id_pk PRIMARY KEY (cat_id)
);


------ menu table ------
CREATE TABLE menu (
    item_id INT,
    item_name VARCHAR(100),
    item_price NUMBER(7,2),
    category INT,
    CONSTRAINT item_id_pk PRIMARY KEY (item_id)
    CONSTRAINT category_fk_id FOREIGN KEY (category) REFERENCES categories(cat_id)
);


------ reservation table ------
CREATE TABLE reservation (
    c_id INT,
    token_no VARCHAR2(20),
    c_name VARCHAR2(20),
    c_address VARCHAR2(20),
    contact_no VARCHAR2(20),
    res_date DATE,
    res_time VARCHAR2(20) DEFAULT TO_CHAR(SYSDATE, 'HH:MI:SS'),
    res_day VARCHAR2(20),
    CONSTRAINT c_id_pk PRIMARY KEY (c_id)
);


-- Trigger to update day on reservation table
CREATE OR REPLACE TRIGGER update_day_reservation
    BEFORE INSERT ON reservation
    FOR EACH ROW
BEGIN
    :NEW.res_day := TO_CHAR(:NEW.res_date, 'Day');
END;

-- Trigger to update time on reservation table
CREATE OR REPLACE TRIGGER update_time_reservation
    BEFORE INSERT ON reservation
    FOR EACH ROW
BEGIN
    :NEW.res_time := TO_CHAR(:NEW.res_date, 'HH:MI:SS');
END;


------ employee table ------
CREATE TABLE employee (
    emp_id INT,
    emp_name VARCHAR2(30),
    emp_username VARCHAR2(20),
    emp_password VARCHAR2(20),
    emp_salary VARCHAR2(10),
    emp_gender VARCHAR2(10),
    emp_contact VARCHAR2(15),
    emp_address VARCHAR2(40),
    CONSTRAINT emp_id_pk PRIMARY KEY (emp_id)
);

------ billing history table ------
CREATE TABLE billinghistory (
    s_no INT,
    ref VARCHAR(20),
    item VARCHAR(20),
    category INT,
    quantity VARCHAR(20),
    rates NUMBER(7, 2),
    amount NUMBER(7, 2),
    CONSTRAINT s_no_pk PRIMARY KEY (s_no)
);

-- ALTER TABLE adding foreign key from category table
ALTER TABLE billinghistory
ADD CONSTRAINT billinghistory_category_fk_id
FOREIGN KEY (category)
REFERENCES categories(cat_id);