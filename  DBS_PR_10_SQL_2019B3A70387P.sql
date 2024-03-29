-- The sequence of SQL queries must be as follows.
-- a. Create database.
-- b. Use database.
-- c. Create tables and views.
-- d. Insert data in tables.
-- e. DML operations like select, update, and delete.
-- f. In the end, drop tables and database statements (commented form)
-- g. All queries should be submitted in a single SQL file.

-- a. Create database.
CREATE DATABASE IF NOT EXISTS carrentalsystem;
-- b. Use database.
USE carrentalsystem;


-- c. Create tables and views.

-- Table creations
CREATE TABLE IF NOT EXISTS address(
    addressID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    street VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    CONSTRAINT pk_a PRIMARY KEY(addressID),
    -- To prevent duplicate addresses
    CONSTRAINT unique_add UNIQUE(street,city,state,country) 
);

CREATE TABLE IF NOT EXISTS person(
    userID  INT UNSIGNED NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(50) NOT NULL DEFAULT '',
    lastName VARCHAR(50) NOT NULL DEFAULT '',
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    userName VARCHAR(30) NOT NULL,  
    pwd VARCHAR(225) NOT NULL,
    gender ENUM('M','F','Other') NOT NULL,
    addressID INT UNSIGNED NOT NULL,
    CONSTRAINT pk_p PRIMARY KEY(userID),
    CONSTRAINT fk_p_a FOREIGN KEY(addressID) REFERENCES address(addressID) on delete restrict on update cascade,
    CONSTRAINT unique_per UNIQUE(firstName, lastName, email, phone, userName, pwd, gender, addressID)
    );
    
    
CREATE TABLE IF NOT EXISTS modelType(
    modelID INT UNSIGNED NOT NULL AUTO_INCREMENT,
     name VARCHAR(50) NOT NULL DEFAULT '',
    description VARCHAR(1000) DEFAULT '',
    rate_by_hour INT UNSIGNED NOT NULL,
    rate_by_km INT UNSIGNED NOT NULL,
    CONSTRAINT pk_m PRIMARY KEY(modelID)
);


CREATE TABLE IF NOT EXISTS waitlist(
    waitID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    userID INT UNSIGNED NOT NULL,
    modelID INT UNSIGNED NOT NULL,
    timein timestamp NOT NULL,
    timeout timestamp NOT NULL,
    rateMode ENUM('Hour','KM') NOT NULL ,
    val numeric(6,2) NOT NULL,
    CONSTRAINT pk_w PRIMARY KEY(waitID),
    CONSTRAINT fk_w_p FOREIGN KEY(userID) REFERENCES person(userID)
        on delete cascade on update cascade,
    CONSTRAINT fk_w_m FOREIGN KEY(modelID) REFERENCES modelType(modelID)
        on delete cascade on update cascade
);


CREATE TABLE IF NOT EXISTS car(
    carID int UNSIGNED NOT NULL AUTO_INCREMENT,
    modelID int UNSIGNED NOT NULL,
    ownerID int UNSIGNED NOT NULL,
    carimg VARCHAR(200),
    CONSTRAINT pk_c PRIMARY KEY(carID),
    CONSTRAINT fk_c_m FOREIGN KEY(modelID) REFERENCES modelType(modelID)
        on delete cascade on update cascade, -- check once more | Mention in the doc ( Calling back models )
    CONSTRAINT fk_c_p FOREIGN KEY(ownerID) REFERENCES person(userID)
        on delete cascade on update cascade
);

CREATE TABLE IF NOT EXISTS reservation(
    rID int UNSIGNED NOT NULL AUTO_INCREMENT,
    userID int UNSIGNED NOT NULL,
    carID int UNSIGNED NOT NULL,
    rateMode ENUM('Hour','KM') NOT NULL,
    val numeric(6,2) not null,
    timein TIMESTAMP not null,
    timeout timestamp not null,
    CONSTRAINT pk_r PRIMARY KEY(rID),
    CONSTRAINT fk_r_p FOREIGN KEY(userID) REFERENCES person(userID)
        on delete cascade on update cascade,
    CONSTRAINT fk_r_c FOREIGN KEY(carID) REFERENCES car(carID)
        on delete cascade on update cascade
);

 
-- d. Insert data in tables.

-- -- Address entries
INSERT INTO carrentalsystem.address (street, city, state, country) VALUES ('22B-Bakers Street', 'London', 'London', 'England');
INSERT INTO carrentalsystem.address (street, city, state, country) VALUES ('5/a, Modi Chawl, Station Rd, Santacruz (west)', 'Mumbai', 'Maharashtra', 'India');
INSERT INTO carrentalsystem.address (street, city, state, country) VALUES ('13, Karaneeswarar Pagoda St, Mylapore', 'Chennai', 'Tamil Nadu', 'India');
INSERT INTO carrentalsystem.address (street, city, state, country) VALUES ('7, B2-grd Floor, Rizvi Nagar, S.v Rd, Santacruz (west)', 'Mumbai', 'Maharashtra', 'India');
INSERT INTO carrentalsystem.address (street, city, state, country) VALUES ('A 102, Amargian Complex, L B S Marg, Opp S T Workshop, Thane (west)', 'Mumbai', 'Maharashtra', 'India');
INSERT INTO carrentalsystem.address (street, city, state, country) VALUES ('3683 Union Street', 'Seattle', 'Washington', 'United States');
INSERT INTO carrentalsystem.address (street, city, state, country) VALUES ('2119 Shinn Avenue', 'Hanau', 'Hesse', 'Germany');

-- -- Person Entries
INSERT INTO carrentalsystem.person(firstName, lastName, email, phone, userName, pwd, gender, addressID)
	VALUES ('Sherlock','Holmes','sherholmes@gmail.com','+447911123456','sherh','drWatson1','M',1);
INSERT INTO carrentalsystem.person(firstName, lastName, email, phone, userName, pwd, gender, addressID)
	VALUES ('Snow','White','whitesnow@yahoo.com','+4930901820','snwh','AGermanFairy0','F',7);
INSERT INTO carrentalsystem.person(firstName, lastName, email, phone, userName, pwd, gender, addressID)
	VALUES ('Rohit','Sharma','rohit200@rediffmail.com','+919999900000','Ro','Hitman200','M',2);
INSERT INTO carrentalsystem.person(firstName, lastName, email, phone, userName, pwd, gender, addressID)
	VALUES ('Dinesh','Karthik','dineshk@outlook.com','+918888822222','DK23','DineK1','F',3);
    
-- -- Car Model entries
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Maruti Swift Dzire','4-seater Available in White, Gray & Blue Colours',120,11);
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Maruti Ertiga','7-seater, Available in White, Silver, Red, Gray & Blue Colours',170,17);
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Tesla Model 3', '5-seater Available in Black, White, Silver, Red, Gray & Blue Colours',150,15);
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Ford Mustang','The current Mustang arrived in 2015, and brought with it a new range of engine choices. The 3.7L V6 became the base engine; it’s good for a not-at-all-shabby 300 horsepower. Next up is a 2.3L, turbocharged four-cylinder that makes 310 horsepower. Yes, only four cylinders, but it sprints from zero to 60 in less than six seconds! Topping the range is a 5.0L V8 good for over 400 horsepower. Transmission choices include a six-speed manual or an automatic with paddle shifters.', 600,10 );
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Chevrolet Camaro', 'The Camaro is available both as a rear-wheel-drive coupe and a convertible, and while both have a backseat, it probably works best as a shelf for your groceries. Before the 2016 refresh, the LS and LT trims got a 3.6L V6 rated at 312 horsepower, while the SS was powered by a mighty 426-horsepower,  6.2L V8. And if that wasn’t enough, for 2014, Chevy unveiled a Z/28 Camaro that packs a huge 7.0L V8 from the Corvette.',1200,20);
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Dodge Challenger','The Challenger is Dodge’s flagship enthusiast vehicle. But is it a muscle car or is it a sports car? It has certainly got the brawn to launch it in a straight line (zero to 60 mph in a hair over six seconds, thanks to its big Hemi® engine), using its six-speed manual stickshift; the newer models’ independent suspension means the Challenger is a sportier handler than ever before. Some of the more tricked-out Challengers are factory-built hot rods; the Scat Pack option gives drivers nearly 500 horsepower.',500,9);
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Chevrolet Corvette', 'For a certain set of enthusiasts, the Corvette is more than a sports car — it’s American heritage on wheels. The Corvette has been in production since 1953 and the car is currently in its seventh (C7) generation, which hit showrooms in 2014. At an average price of close to $40,000 on our website, a used Corvette is the priciest sports car on this list; but then, you do get a lot for your money.',800,11);
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Nissan 370Z', 'Launched in 2010, the 370Z replaced the visually similar 350Z and traces its lineage back to the 240Z of the early 1970s. Available as both a coupe or a roadster, this compact two-seater checks all the sports car boxes. Power comes from a 3.7L V6 that puts 330 horsepower to the rear wheels through a six-speed manual or a seven-speed automatic transmission (the auto gearbox version comes with paddle shifters). From standing still, this Nissan zooms to 60 mph in around five seconds. If that’s not fast enough you, seek out the NISMO models, which are sportier and make an extra heap of horsepower.',900,15);

-- -- Car entries
INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES (1,2,"../images/Swift Dzire Gray.jpeg");
INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES (1,1,"../images/Swift Dzire White.jpeg");
INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES (2,1,"../images/Ertiga Black.jpg");
INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES (2,2,"../images/Ertiga Black.jpg");
INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES (3,3,"../images/Tesla Model 3 White.jpg");
INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES (3,4,"../images/Tesla Model 3 Red.jpg");

-- e. DML operations like select, update, and delete.

-- Procedures (which have transactions enclosed in them for concurrency purposes)

-- numCarsAvailable returns number of cars available for a particular model given the timein and time out
-- i.e, the start and end times of the reservation, and also creates a temporary table to list all the cars
-- Temp. table was created for ease of access to extend to select cars based on location, priority,etc 

DROP PROCEDURE IF EXISTS numCarsAvailable;
DELIMITER $$
create definer=`root`@`localhost` PROCEDURE numCarsAvailable(IN model_ID INT, IN time_in TIMESTAMP, IN time_out TIMESTAMP, OUT num_cars INT)
COMMENT 'Procedure to find the number of cars available for a particular model'
BEGIN
    -- SET AUTOCOMMIT = 0;
    START TRANSACTION;

	DROP TEMPORARY TABLE IF EXISTS tmp_availCars;
    CREATE TEMPORARY TABLE tmp_availCars
    SELECT carID FROM (SELECT * FROM car where car.modelID = model_ID) AS selectedCars 
    WHERE carID NOT IN 
    (SELECT carID FROM reservation where ( 
    ((`reservation`.`timein` > `time_in`) AND (`reservation`.`timein` < `time_out`) AND (`reservation`.`timeout` > `time_out`)) OR
    ((`reservation`.`timein` < `time_in`) AND (`reservation`.`timeout` < `time_out`) AND (`reservation`.`timeout` > `time_in`)) OR 
    ((`reservation`.`timein` <= `time_in`) AND (`reservation`.`timeout` >= `time_out`)) 
    ));
    SELECT count(carID) INTO num_cars FROM tmp_availCars;

    COMMIT;
    -- SET AUTOCOMMIT = 1;
END $$
DELIMITER ;

-- Testing if the procedure returns cars (no reservations yet)
-- These are the cars available
-- SELECT * FROM car;
CALL numCarsAvailable(1,'2022-3-29 8:00:00','2022-3-29 9:00:00',@n);
SELECT @n; -- number of cars available
SELECT * FROM tmp_availCars; -- car IDs of the available cars

-- request_reservation will take as input userID, modelID, rateMode (type: hours/kms), val (number of hours/kms)
-- and calls numCarsAvailable to check if cars are available. If yes, a car (lowest car ID implicitly) is alloted
-- and an entry is made in the reservation relation. Else, the details are passed on and a waitlist entry is made

DROP PROCEDURE IF EXISTS request_reservation;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE 
`request_reservation`(IN user_ID INT, 
					IN model_ID INT UNSIGNED, 
                    IN rateMode ENUM('Hour','KM'), 
                    IN val NUMERIC(2) UNSIGNED, 
                    IN time_in TIMESTAMP, 
                    IN time_out TIMESTAMP)
 MODIFIES SQL DATA
 DETERMINISTIC
 SQL SECURITY INVOKER
 COMMENT 'Procedure for user to request a reservation based on the car model'
BEGIN
    -- SET AUTOCOMMIT = 0;
    START TRANSACTION;

    CALL numCarsAvailable(model_ID,time_in,time_out,@n);
    SELECT carID INTO @selCarID from tmp_availCars LIMIT 1;
    IF(@n>0)
    THEN
        INSERT INTO carrentalsystem.reservation(userID,carID,rateMode,val,timein,timeout)
            VALUES (user_ID,@selCarID,rateMode,val,time_in,time_out);
    ELSE
    INSERT INTO waitlist (userID, modelID, timein, timeout,rateMode,val) VALUES (user_ID,model_ID,time_in,time_out,rateMode,val);
    END IF;

    COMMIT;
    -- SET AUTOCOMMIT = 1;
END $$
DELIMITER ;

-- Testing reservation (assuming there are 2 cars if model ID 1, which have no prior reservations from 18 to 19 hrs on 23rd December 2012)
-- request_reservation(IN user_ID INT, IN model_ID INT UNSIGNED, IN rateMode NUMERIC(2) UNSIGNED, IN val NUMERIC(2) UNSIGNED, IN time_IN TIMESTAMP, IN time_out TIMESTAMP)

CALL request_reservation(1, 1, 1, 10, '2022-4-10 18:00:00','2022-4-10 19:00:00');
CALL request_reservation(1, 1, 1, 10, '2022-4-10 18:00:00','2022-4-10 19:00:00');
-- We made two requests for request_reservation for model ID 1 from user 1
-- There were a total of 2 cars available, verify if 2 reservations were made for separate car IDs
SELECT * FROM reservation;
-- Now, repeat the previous request. Since no more cars are available, an entry should be made into waitlist
CALL request_reservation(1, 1, 1, 10, '2022-4-10 18:00:00','2022-4-10 19:00:00');
SELECT * FROM reservation;
SELECT * FROM waitlist;

-- amount is procedure to calculate amount from the model ID, rate mode (type: hours / kms) 
-- , and number of hours / kms
DROP FUNCTION IF EXISTS amount;
DELIMITER $$
CREATE 
    DEFINER=`root`@`localhost`
    FUNCTION `amount` (model_ID INT UNSIGNED, rateMode ENUM('Hour','KM'), val NUMERIC(6,2))
    RETURNS NUMERIC(17,2)
    COMMENT 'Calculates the cost of renting a car'
    LANGUAGE SQL
    DETERMINISTIC
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
    DECLARE return_amount NUMERIC(17,2);
    SET @rateHour = (SELECT rate_by_hour from modelType WHERE modelID=model_ID); 
    SET @rateKm = (SELECT rate_by_km from modelType WHERE modelID=model_ID); 
    IF rateMode='Hour' THEN SET return_amount=val*@rateHour;
    ELSE SET return_amount = val*@rateKm;
    END IF;
    RETURN return_amount;
END $$
DELIMITER ;

-- Testing amount
SELECT * from modelType;
-- Testing for model ID 2, which has rate_by_hour 120, rate_by_km 11
select amount(1,'Hour',10) as 'amt1';
select amount(1,'KM',10) as 'amt2';

-- check_waitlist` | TRANSACTION
DROP PROCEDURE IF EXISTS `check_waitlist`;

    DELIMITER $$
    CREATE DEFINER=`root`@`localhost` PROCEDURE 
    `check_waitlist`()
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
    COMMENT 'Procedure to check waitlist and add to reservation'
    BEGIN
        DECLARE n INT DEFAULT 0;    
        DECLARE i INT DEFAULT 0;
        Select count(*)  from waitlist into n;
        set i = 0;

        -- SET AUTOCOMMIT = 0;
        START TRANSACTION;

        while i<n do
            CALL numCarsAvailable(modelID,timein,timeout,@n);
            if(n>0)
            then
                select waitID into @wID from carrentalsystem.waitlist LIMIT i,1;
                select carID into @selCarID from tmp_availCars LIMIT 1;
                INSERT into carrentalsystem.reservation(userID,carID,rateMode,val,timein,timeout)
                    Select (userID,@selCarID,rateMode,val,timein, timeout) from carrentalsystem.waitlist LIMIT i,1;
                DELETE from waitlist where waitID=@wID;
            end if;
        set i = i + 1;
        end while;

        COMMIT;
        -- SET AUTOCOMMIT = 1;
    END$$
    DELIMITER ;

-- TRIGGER add_car
DROP TRIGGER IF EXISTS add_car;

DELIMITER $$
CREATE TRIGGER add_car
AFTER INSERT ON car
for each row
BEGIN
    CALL check_waitlist;
END$$
DELIMITER ;

-- f. In the end, drop tables and database statements (commented form)

-- DROP TABLE IF EXISTS reservation;
-- DROP TABLE IF EXISTS waitlist;
-- DROP TABLE IF EXISTS car;
-- DROP TABLE IF EXISTS person;
-- DROP TABLE IF EXISTS modelType;
-- DROP TABLE IF EXISTS address;

-- DROP DATABASE IF EXISTS carrentalsystem;