USE FreeUsable1;

-- Search / Get City Wise Products
CALL get_city_wise_product('Ahmedabad'); -- No product added by Ahmedabad users
CALL get_city_wise_product('Amreli'); -- 8 records from Ranna (user 6) 
CALL get_city_wise_product('Mathura'); -- By Krishna Yadav (user 1)


-- Search / Get State Wise Products
CALL get_state_wise_product('Maharashta'); -- No product added by Maharashtra users
CALL get_state_wise_product('Gujarat'); -- All the Products added by Gujarat users


-- Search Entire User Details by User_id
CALL get_user_by_user_id(1); 
CALL get_user_by_user_id(2);
CALL get_user_by_user_id(6);

-- Fetch User details of each user
CALL get_all_user_details();

-- Fetch #Donations and #buys For each user
CALL get_user_deals(); 

-- Fetch #Donations and #buys For particular user by id 
CALL user_deals_by_user_id(1);
CALL user_deals_by_user_id(6);

-- Fetch Dashboard Details
CALL show_dashboard();

/*
	-- SELECT c.city_id FROM FreeUsable1.city c WHERE c.city_name = 'Kanpur';
	-- EXPLAIN SELECT c.city_id FROM FreeUsable1.city c WHERE c.city_name = 'Kanpur';
*/