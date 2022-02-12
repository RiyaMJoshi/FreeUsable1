-- All the Required Triggers for 'FreeUsable1' Database are written here.
USE FreeUsable1;

-- 1. Only insert into 'user_email' and 'user_contact' when birthdate > today

-- DROP TRIGGER IF EXISTS add_FreeUsable1_user_date_check;

/* 

DELIMITER $$

CREATE TRIGGER add_FreeUsable1_user_date_check BEFORE INSERT
	ON FreeUsable1.user 
    FOR EACH ROW	
    BEGIN
		DECLARE user_id INT;
        DECLARE curr_date DATE;
        
        SELECT curdate() INTO curr_date FROM dual;
        
		IF NEW.u_birth_date < curr_date
        THEN
			-- INSERT INTO rough1 VALUES(NEW.u_birth_date);
            
			-- Select u_id from user table for further insertions
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

*/


-- 2. Trigger to update 'p_status_id' = 2 (booked) in 'product' table on buying a product

-- DROP TRIGGER IF EXISTS update_FreeUsable1_p_status_id_on_buy;

DELIMITER $$
CREATE TRIGGER update_FreeUsable1_p_status_id_on_buy AFTER INSERT
	ON FreeUsable1.buyer 
    FOR EACH ROW	
    BEGIN
		DECLARE pr_id INT;
        -- SET pr_status_id = (SELECT p_status_id FROM FreeUsable1.product WHERE p_id = pr_id);
        SET pr_id = (SELECT b_product_id FROM FreeUsable1.buyer ORDER BY b_id DESC LIMIT 1);
		
        -- update p_status_id to '2' (Booked)
        UPDATE FreeUsable1.product SET product.p_status_id = 2
        WHERE product.p_id = pr_id;
			      
	END$$
DELIMITER ;





