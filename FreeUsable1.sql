-- DROP DATABASE IF EXISTS FreeUsable1;
-- CREATE DATABASE FreeUsable1;

USE FreeUsable1;
-- DROP TABLE user;

# Create table User
CREATE TABLE user (
	u_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    u_first_name VARCHAR(40),
    u_last_name VARCHAR(40),
    u_birth_date DATE,
    u_sex VARCHAR(1),
    u_city_id INT
);

# Create table User-Email
CREATE TABLE user_email (
	ue_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ue_user_id INT,
    ue_email VARCHAR(40),
    FOREIGN KEY(ue_user_id) REFERENCES user(u_id) ON DELETE CASCADE
);

# Create table User-Contact Numbers
CREATE TABLE user_contact (
	uc_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    uc_user_id INT,
    uc_phone VARCHAR(10),
	FOREIGN KEY(uc_user_id) REFERENCES user(u_id) ON DELETE CASCADE
);

# Create table Country
-- CREATE TABLE country (
-- 	country_id INT PRIMARY KEY,
--     country_name VARCHAR(40)
-- );

# Create table State
CREATE TABLE state (
	state_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    state_name VARCHAR(40)
);

# Create table City
CREATE TABLE city (
	city_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(40),
    city_state_id INT,
	FOREIGN KEY(city_state_id) REFERENCES state(state_id) ON DELETE CASCADE
);

-- Create Index on city.city_name column
CREATE INDEX cityName ON city(city_name);
-- DROP INDEX cityName ON city;

# Create table Product-Status
CREATE TABLE product_status (
	ps_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ps_status VARCHAR(20)
);

# Create table Product- Category
CREATE TABLE product_category(
	pc_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    pc_name VARCHAR(40)
);

# Create table Product
-- Add Column 'p_image' for Product Image (BLOB)
CREATE TABLE product (
	p_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    p_name VARCHAR(40) NOT NULL,
    p_category_id INT,
    p_age INT,
    p_description VARCHAR(255),
    p_upload_date TIMESTAMP,
    p_status_id INT
--     FOREIGN KEY(p_status_id) REFERENCES product_status(ps_id) ON DELETE SET NULL
);

ALTER TABLE product
ALTER p_status_id SET DEFAULT 1; -- Product = Available (id=1)

# Create table Donor
CREATE TABLE donor(
	d_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    d_user_id INT,
    d_product_id INT,
    d_p_upload_date TIMESTAMP
);

# Create table Buyer
CREATE TABLE buyer(
	b_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    b_user_id INT,
    b_product_id INT,
    b_p_request_date TIMESTAMP
);

# -- Adding Foreign Key Constratints 

# add 'city_id' from 'city' to 'user' table
ALTER TABLE user
ADD CONSTRAINT FK_UserCity
FOREIGN KEY (u_city_id) REFERENCES city(city_id);

# add 'u_id, product_id' to 'donor' table -- previously 'uploaded_date' was supposed to be added from product
ALTER TABLE donor
ADD CONSTRAINT FK_DonorId
FOREIGN KEY (d_user_id) REFERENCES user(u_id) ON DELETE CASCADE,
ADD CONSTRAINT FK_DonorProductId
FOREIGN KEY (d_product_id) REFERENCES product(p_id) ON DELETE CASCADE
-- ADD CONSTRAINT FK_ProductUploadDate
-- FOREIGN KEY (d_p_upload_date) REFERENCES product(p_upload_date)
;

# add 'u_id, product_id' to 'buyer' table 
ALTER TABLE buyer
ADD CONSTRAINT FK_BuyerId
FOREIGN KEY (b_user_id) REFERENCES user(u_id) ON DELETE SET NULL,
ADD CONSTRAINT FK_BuyerProductId
FOREIGN KEY (b_product_id) REFERENCES product(p_id) ON DELETE SET NULL
;

# add 'p_status_id' to 'product' table 
ALTER TABLE product
ADD CONSTRAINT FK_ProductStatusId
FOREIGN KEY (p_status_id) REFERENCES product_status(ps_id) ON DELETE SET NULL
;

# add 'p_category_id' to 'product' table 
ALTER TABLE product
ADD CONSTRAINT FK_ProductCategoryId
FOREIGN KEY (p_category_id) REFERENCES product_category(pc_id) ON DELETE SET NULL
;

# Adding a rough table for checking trigger operation
-- DROP TABLE rough1;
CREATE TABLE rough1(my_date DATE);

-- Altering 'rough1' schema for checking p_status_id

	ALTER TABLE FreeUsable1.rough1
	ADD COLUMN r_status_id INT;


