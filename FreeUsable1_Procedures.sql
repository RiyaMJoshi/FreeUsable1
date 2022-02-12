-- All the Required Procedures for 'FreeUsable1' Database are written here.
USE FreeUsable1;

-- 1. Procedure to Add Records to 'user', 'user_email' and 'user_contact' Simultaneously

-- DROP PROCEDURE IF EXISTS add_user_FreeUsable1;
DELIMITER $$
CREATE PROCEDURE add_user_FreeUsable1 (
	IN u_first_name varchar(40),
    IN u_last_name varchar(40),
    IN u_birth_date DATE,
    IN u_sex VARCHAR(1),
    IN u_city_id INT,
    IN ue_email VARCHAR(40),
    IN uc_phone VARCHAR(10)
    )
BEGIN
	DECLARE user_id INT; 
	DECLARE curr_date DATE;
        
    SELECT curdate() INTO curr_date FROM dual;
        
	-- Add user only if his birth_date > today
	IF u_birth_date < curr_date
    THEN
		-- INSERT INTO rough1 VALUES(NEW.u_birth_date);
		
        -- Insert into User table
		INSERT INTO FreeUsable1.user (u_first_name,u_last_name,u_birth_date, u_sex, u_city_id) 
		VALUES (u_first_name,u_last_name,u_birth_date, u_sex, u_city_id);
    
				--  Insert into user_email and user_contact table via Trigger 'add_FreeUsable1_user_date_check'
				-- Now not implementing the above trigger
        
		-- Select u_id of the user just added from 'user' table for further insertions
		SET user_id = (SELECT u_id FROM FreeUsable1.user ORDER BY u_id DESC LIMIT 1);
			
		-- Insert into User_email table
		INSERT INTO FreeUsable1.user_email (ue_user_id, ue_email)
		VALUES (user_id, ue_email);
			
		-- Insert into User_contact table
		INSERT INTO FreeUsable1.user_contact (uc_user_id, uc_phone)
		VALUES (user_id, uc_phone);
	END IF;
END$$
DELIMITER ;


-- 2. Procedure to Add Records to 'product_category' table

-- DROP PROCEDURE IF EXISTS add_product_category_FreeUsable1;
DELIMITER $$
CREATE PROCEDURE add_product_category_FreeUsable1 (
	pc_name VARCHAR(40)
	)
BEGIN
	INSERT INTO FreeUsable1.product_category (pc_name)
    VALUES (pc_name);
END$$
DELIMITER ;


-- 3. Procedure to Add Records to 'product' as well as 'donor' table

-- DROP PROCEDURE IF EXISTS add_product_FreeUsable1;
DELIMITER $$
CREATE PROCEDURE add_product_FreeUsable1 (
	p_name VARCHAR(40),
    p_category_id INT,
    p_age INT,
    p_description VARCHAR(255)
	)
BEGIN
	-- p_upload_date => curr_date 
    -- p_status_id => DEFAULT 1 (Available)
    
    DECLARE session_user_id INT; -- Current user_id 'u_id' from user table.. For adding to 'Donor' table
    DECLARE pr_id INT; -- to store 'p_id' (product_id) from 'product' table after adding record.. For adding to Donor table
	DECLARE curr_date TIMESTAMP;  -- For storing current date-time when user adds any product
    SELECT now() INTO curr_date FROM dual;
	SET session_user_id = 1;  -- Only for testing
    
    -- Add record to product table
	INSERT INTO FreeUsable1.product (
		p_name, p_category_id, p_age, p_description, p_upload_date
    )
    VALUES (
		p_name, p_category_id, p_age, p_description, curr_date
    );
    
    SET pr_id = (SELECT p_id FROM FreeUsable1.product ORDER BY p_id DESC LIMIT 1);
    
    
    -- Add record to donor table
    INSERT INTO FreeUsable1.donor (
		d_user_id, d_product_id, d_p_upload_date
    )
    VALUES (
		session_user_id, pr_id, curr_date
    );
    
END$$
DELIMITER ;


-- 4. Procedure to Add Records to 'buyer' table if particular product is 'available' (p_status_id = 1)

-- DROP PROCEDURE IF EXISTS buy_product_FreeUsable1;
DELIMITER $$
CREATE PROCEDURE buy_product_FreeUsable1 (
		pr_id INT
	)
BEGIN
	
    DECLARE pr_status_id INT; -- to store p-status-id to check if particular product is 'available'(= 1)
    DECLARE session_user_id INT; -- Current user_id 'u_id' from user table.. For adding to 'Buyer' table
    
    DECLARE curr_date TIMESTAMP;  -- For storing current date-time when user adds any product
    SELECT now() INTO curr_date FROM dual;
	SET session_user_id = 3;  -- Only for testing
    
	SET pr_status_id = (SELECT p_status_id FROM FreeUsable1.product WHERE p_id = pr_id);
    
			-- Inserting 'p_status_id' into rough1.r_status_id to check if it's working or not.
			-- INSERT INTO FreeUsable1.rough1 (r_status_id) VALUES (pr_status_id);
    
    
    IF pr_status_id = 1
    THEN 
          -- Add record to buyer table
 		INSERT INTO FreeUsable1.buyer (
 			b_user_id, b_product_id, b_p_request_date
 		)
 		VALUES (
 			session_user_id, pr_id, curr_date
 		);
      END IF;
END$$
DELIMITER ;


-- 5. Procedure to Search / Get City Wise Products

-- DROP PROCEDURE IF EXISTS get_city_wise_product;

DELIMITER $$
CREATE PROCEDURE get_city_wise_product(
	IN city_name VARCHAR(40)
	)
BEGIN
	SELECT * FROM FreeUsable1.product p WHERE p.p_id IN (
		SELECT d.d_product_id FROM FreeUsable1.donor d WHERE d.d_user_id IN (
			SELECT u.u_id FROM FreeUsable1.user u WHERE u.u_city_id IN (
				SELECT c.city_id FROM FreeUsable1.city c WHERE c.city_name = city_name
			)
		)
    );

END$$
DELIMITER ;


-- 6. Procedure to Search / Get State Wise Products

-- DROP PROCEDURE IF EXISTS get_state_wise_product;

DELIMITER $$
CREATE PROCEDURE get_state_wise_product (
	IN state_name VARCHAR(40)
	)
BEGIN
	SELECT * FROM FreeUsable1.product p WHERE p.p_id IN (
		SELECT d.d_product_id FROM FreeUsable1.donor d WHERE d.d_user_id IN (
			SELECT u.u_id FROM FreeUsable1.user u WHERE u.u_city_id IN (
				SELECT c.city_id FROM FreeUsable1.city c WHERE c.city_state_id IN (
					SELECT s.state_id FROM FreeUsable1.state s WHERE s.state_name = state_name
                )
			)
		)
    );
END$$
DELIMITER ;


-- 7. Procedure to get details of all users: get_all_user_details()

-- DROP PROCEDURE IF EXISTS get_all_user_details;

DELIMITER $$
CREATE PROCEDURE get_all_user_details ()
BEGIN
	SELECT * FROM FreeUsable1.user_details;
END$$
DELIMITER ;

-- 8. Procedure to Search / Get User Details by user_id

-- DROP PROCEDURE IF EXISTS get_user_by_user_id;

DELIMITER $$ 
CREATE PROCEDURE get_user_by_user_id (
		IN user_id INT
	)
BEGIN
	-- Fetch data from 'user', 'user_contact', 'user_email' and 'city'
	SELECT * FROM FreeUsable1.user_details
		WHERE user_details.`User ID` = user_id
    ;
END$$
DELIMITER ; 

-- 9. Procedure to Fetch Details of User_Deals 

-- DROP PROCEDURE IF EXISTS user_deals;

DELIMITER $$ 
CREATE PROCEDURE get_user_deals ( )
BEGIN
	-- Fetch data from 'user', 'user_contact', 'user_email' and 'city'
	SELECT * FROM FreeUsable1.user_deals
		-- WHERE user_details.`User ID` = user_id
    ;
END$$
DELIMITER ; 


-- 10. Procedure to Fetch Details of User_Deals by user_id

-- DROP PROCEDURE IF EXISTS user_deals_by_user_id;

DELIMITER $$ 
CREATE PROCEDURE user_deals_by_user_id ( 
	IN user_id INT
)
BEGIN
	-- Fetch data from 'user', 'donor' and 'buyer'
	SELECT * FROM FreeUsable1.user_deals
		 WHERE user_deals.`User ID` = user_id
    ;
END$$
DELIMITER ; 


-- 11. Procedure to display 'Dashboard' consisting  of-
		-- #Total_users, #Male_users, #Female_users,
		-- #Total_donors, #Total_buyers, 
		-- #Total_states, #Total_cities,
		-- #Total_categories, #Total_Available_Products


-- DROP PROCEDURE IF EXISTS show_dashboard;

DELIMITER $$
CREATE PROCEDURE show_dashboard()
BEGIN
	SELECT total_users() AS `Total Users`,
		male_users() AS `Male`,
        female_users() AS `Female`,
        total_donors() AS `Donors`,
        total_buyers() AS `Buyers`,
        total_cities() AS `Cities`,
        total_states() AS `States`,
        total_categories() AS `Categories`,
        total_products() AS `Total Products`,
        total_available_products() AS `Available Products`,
        total_donated_products() AS `Donated Products`
        ;
END$$
DELIMITER ;

