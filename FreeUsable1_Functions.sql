USE FreeUsable1;

-- show_dashboard()

-- #Total_users, #Male_users, #Female_users,
-- #Total_donors, #Total_buyers, 
-- #Total_states, #Total_cities,
-- #Total_categories, #Total_Available_Products


#Total_users
-- DROP FUNCTION total_users;

DELIMITER $$
CREATE FUNCTION total_users ()
RETURNS INT DETERMINISTIC

BEGIN
   DECLARE total_users INT;
   SET total_users = ( SELECT count(u_id) FROM FreeUsable1.user );
   
   RETURN total_users;
   
END$$
DELIMITER ;

#Male_users
-- DROP FUNCTION male_users;

DELIMITER $$
CREATE FUNCTION male_users ()
RETURNS INT DETERMINISTIC

BEGIN
   DECLARE male_users INT;
   SET male_users = ( SELECT count(u_id) FROM FreeUsable1.user WHERE user.u_sex = 'M');
   
   RETURN male_users;
   
END$$
DELIMITER ;

#Female_users
-- DROP FUNCTION female_users;

DELIMITER $$
CREATE FUNCTION female_users ()
RETURNS INT DETERMINISTIC

BEGIN
   DECLARE female_users INT;
   SET female_users = ( SELECT count(u_id) FROM FreeUsable1.user WHERE user.u_sex = 'F');
   
   RETURN female_users;
   
END$$
DELIMITER ;

#Total_donors
-- DROP FUNCTION total_donors;

DELIMITER $$
CREATE FUNCTION total_donors ()
RETURNS INT DETERMINISTIC

BEGIN
   DECLARE total_donors INT;
   SET total_donors = ( SELECT count(DISTINCT d_user_id) FROM FreeUsable1.donor);
   
   RETURN total_donors;
   
END$$
DELIMITER ;

#Total_buyers
-- DROP FUNCTION total_buyers;

DELIMITER $$
CREATE FUNCTION total_buyers ()
RETURNS INT DETERMINISTIC

BEGIN
   DECLARE total_buyers INT;
   SET total_buyers = ( SELECT count(DISTINCT b_user_id) FROM FreeUsable1.buyer);
   
   RETURN total_buyers;
   
END$$
DELIMITER ;

#Total_states
-- DROP FUNCTION total_states;

DELIMITER $$
CREATE FUNCTION total_states ()
RETURNS INT DETERMINISTIC

BEGIN
   DECLARE total_states INT;
   SET total_states = ( SELECT count(state_id) FROM FreeUsable1.state);
   
   RETURN total_states;
   
END$$
DELIMITER ;

#Total_cities
-- DROP FUNCTION total_cities;

DELIMITER $$
CREATE FUNCTION total_cities ()
RETURNS INT DETERMINISTIC

BEGIN
   DECLARE total_cities INT;
   SET total_cities = ( SELECT count(city_id) FROM FreeUsable1.city);
   
   RETURN total_cities;
   
END$$
DELIMITER ;

#Total_categories
-- DROP FUNCTION total_categories;

DELIMITER $$
CREATE FUNCTION total_categories ()
RETURNS INT DETERMINISTIC

BEGIN
   DECLARE total_categories INT;
   SET total_categories = ( SELECT count(pc_id) FROM FreeUsable1.product_category);
   
   RETURN total_categories;
   
END$$
DELIMITER ;


#Total_products
-- DROP FUNCTION total_products;

DELIMITER $$
CREATE FUNCTION total_products ()
RETURNS INT DETERMINISTIC

BEGIN
   DECLARE total_products INT;
   SET total_products = ( SELECT count(p_id) FROM FreeUsable1.product );
   
   RETURN total_products;
   
END$$
DELIMITER ;


#Total_available_products
-- DROP FUNCTION total_available_products;

DELIMITER $$
CREATE FUNCTION total_available_products ()
RETURNS INT DETERMINISTIC

BEGIN
   DECLARE total_available_products INT;
   SET total_available_products = ( 
			SELECT count(p_id) FROM FreeUsable1.product
				WHERE p_status_id = 1
			);
   
   RETURN total_available_products;
   
END$$
DELIMITER ;

#Total_donated_products
-- DROP FUNCTION total_donated_products;

DELIMITER $$
CREATE FUNCTION total_donated_products ()
RETURNS INT DETERMINISTIC

BEGIN
   DECLARE total_donated_products INT;
   SET total_donated_products = ( 
			SELECT count(p_id) FROM FreeUsable1.product
				WHERE p_status_id = 2
			);
   
   RETURN total_donated_products;
   
END$$
DELIMITER ;