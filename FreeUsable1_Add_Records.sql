USE FreeUsable1;

# Filling State Table
INSERT INTO state (state_name) VALUES
('Gujarat'),
('Maharastra'),
('Madhya Pradesh'),
('Rajasthan'),
('Uttar Pradesh');

# Filling City Table
INSERT INTO city (city_name, city_state_id) VALUES
('Ahmedabad', 1),
('Amreli', 1),
('Gandhinagar', 1),
('Vadodara', 1),
('Rajkot', 1),

('Mumbai', 2),
('Pune', 2),
('Solapur', 2),
('Nagpur', 2),
('Indore', 3),
('Bhopal', 3),
('Rewa', 3),
('Ujjain', 3),

('Bhilwara', 4),
('Bikaner', 4),
('Jodhpur', 4),
('Jaipur', 4),
('Udaipur', 4),

('Prayagraj', 5),
('Varanasi', 5),
('Gorakhpur', 5),
('Mathura', 5),
('Kanpur', 5),
('Lucknow', 5)
;


# Filling 'user', 'user_email', 'user_contact' tables
# Call Procedure 'add_user_FreeUsable1' to add records into above tables
CALL add_user_FreeUsable1('Krishna', 'Yadav', '1991-08-08', 'M', 22, 'krishna.yadav@universe.com', '7890123456');
CALL add_user_FreeUsable1('Riya', 'Joshi', '2001-03-12', 'F', 1, 'riyajoshi312@gmail.com', '8790123456');
CALL add_user_FreeUsable1('Pankaj', 'Shaw', '1993-02-10', 'M', 16, 'pankajshaw@gmail.com', '7887567890');
CALL add_user_FreeUsable1('Mahesh', 'Joshi', '1964-02-09', 'M', 1, 'mjjoshi1@gmail.com', '8790341256');
CALL add_user_FreeUsable1('Paresh', 'Bhattacharya', '2002-04-05', 'M', 6, 'pbhattacharya01@gmail.com', '8912034576');
CALL add_user_FreeUsable1('Ranna', 'Bhatia', '1978-01-17', 'F', 2, 'rbhatia@gmail.com', '9812034521');

-- As it is today's date, the record won't get inserted
CALL add_user_FreeUsable1('Rujuta', 'Shah', '2022-02-10', 'F', 5, 'rujuta01@gmail.com', '7878787878');


# Filling 'product_category' table
CALL add_product_category_FreeUsable1('Book');
CALL add_product_category_FreeUsable1('Stationary');
CALL add_product_category_FreeUsable1('Furniture');
CALL add_product_category_FreeUsable1('Clothing');
CALL add_product_category_FreeUsable1('Electronics');
CALL add_product_category_FreeUsable1('Vehicle');
CALL add_product_category_FreeUsable1('Travel Goods');
CALL add_product_category_FreeUsable1('Footwear');
CALL add_product_category_FreeUsable1('Cosmetics');
CALL add_product_category_FreeUsable1('Utensils');


# Filling 'product_status' table
INSERT INTO FreeUsable1.product_status (ps_status) VALUES 
('Available'), ('Booked');


# Filling 'product' table with 'p_name VARCHAR(40), p_category_id INT, p_age INT, p_description VARCHAR(255)'
CALL add_product_FreeUsable1('CPP Reference Book', 1, 2, 'CPP Reference Book by E. Balaguruswamy - Edition 2020');
CALL add_product_FreeUsable1('Asus Laptop', 5, 3, 'Fully Working Asus Laptop with  4GB - 1TB, Intel i3 Processor and Windows 10 OS.');
CALL add_product_FreeUsable1('Logitech Mouse', 5, 0, 'Fully Working USB Mouse from Logitech to work with Laptop/ PC.');

CALL add_product_FreeUsable1('Maths 3 Book', 1, 2, 'BE Maths 3 Book GTU');
CALL add_product_FreeUsable1('Maths 1 Book', 1, 3, 'BE Maths 1 Book GTU');
CALL add_product_FreeUsable1('Physics 1 Book', 1, 3, 'BE Physics 1 Book GTU');

CALL add_product_FreeUsable1('Wooden Study Table', 3, 6, 'Wooden Study Table with Shelves and Drawers');

CALL add_product_FreeUsable1('Bata Shoes for Ladies', 8, 2, 'Good condition Bata Shoes for ladies size-9');
CALL add_product_FreeUsable1('TV Cabinet', 3, 10, 'Wooden TV Cabinet with Drawers');



# Buying Products 
-- Filling 'buyer' table and updating 'p_status_id' = 2(Booked) in 'product' table
CALL buy_product_FreeUsable1(5); -- p_id = 1 i.e. Buying CPP Ref. Book
CALL buy_product_FreeUsable1(8); -- 8 i.e. Bata Shoes

CALL buy_product_FreeUsable1(1);
CALL buy_product_FreeUsable1(6);