-- All the Required Views for 'FreeUsable1' Database are written here.
USE FreeUsable1;


-- Full User Details including 'user, contact, email, city, state, donations, buys'

-- DROP VIEW user_details;
CREATE OR REPLACE VIEW user_details
AS 
	SELECT u.u_id AS 'User ID',
		u.u_first_name AS 'First Name', 
		u.u_last_name AS 'Last Name', 
        u.u_birth_date AS 'DOB',
        u.u_sex AS 'Sex',
        uc.uc_phone AS 'Contact',
        ue.ue_email AS 'Email',
        c.city_name AS 'City',
        s.state_name AS 'State',
        --
		udb.`Total Donations`,
        udb.`Total Buys`
        
        FROM FreeUsable1.user u
        JOIN FreeUsable1.user_contact uc 
			ON u.u_id = uc.uc_user_id 
        JOIN FreeUsable1.user_email ue
            ON u.u_id = ue.ue_user_id
		JOIN FreeUsable1.city c
			ON u.u_city_id = c.city_id
		JOIN FreeUsable1.state s
			ON c.city_state_id = s.state_id
		--
        JOIN user_deals udb
        ON u.u_id = udb.`User id`
		;
	
    
    
-- For user wise Total no. of donations

-- DROP VIEW user_donors;
CREATE OR REPLACE VIEW user_donors
AS
	SELECT u_id AS `User id`, 
		u_first_name AS `First Name`,
		u_last_name AS `Last Name`,
		COUNT(d_id) AS `Total Donations`
		FROM FreeUsable1.user 
		LEFT OUTER JOIN donor ON u_id = d_user_id
		GROUP BY u_id
		;
        
		-- SELECT * FROM user_donors;


-- For User wise total no. of Baught items

-- DROP VIEW user_buyers;
CREATE OR REPLACE VIEW user_buyers
AS
	SELECT u_id AS `User id`, 
		u_first_name AS `First Name`,
		u_last_name AS `Last Name`,
		COUNT(b_id) AS `Total Buys` 
		FROM FreeUsable1.user 
		LEFT OUTER JOIN buyer ON u_id = b_user_id
		GROUP BY u_id
		;
        
		-- SELECT * FROM user_buyers;
        

-- Final View 'user_deals' consisting of user_donors and user_buyers

-- DROP VIEW user_deals;
CREATE OR REPLACE VIEW user_deals
AS
	SELECT ud.`User id`,
		ud.`First Name`,
        ud.`Last Name`,
        ud.`Total Donations`,
        ub.`Total Buys`
        FROM user_donors ud
        JOIN user_buyers ub
        ON ud.`User id` = ub.`User id`
        ;
    