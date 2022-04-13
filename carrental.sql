
-- Reservation, Car, Address --> Swastik
-- Person, Waitlist, Model type --> Shreyas

-- CREATE DATABASE AND USE IT

-- CREATE DATABASE carrentalsystem;
USE carrentalsystem;

-- DROP TABLES
-- Don't change this order, it accounts for foreign key dependencies

DROP TABLE IF EXISTS reservation;
DROP TABLE IF EXISTS waitlist;
DROP TABLE IF EXISTS car;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS modelType;
DROP TABLE IF EXISTS address;   

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
    -- amount numeric(10,2) not null, --removed as it's redundant
    timein TIMESTAMP not null,
    timeout timestamp not null,
    CONSTRAINT pk_r PRIMARY KEY(rID),
    CONSTRAINT fk_r_p FOREIGN KEY(userID) REFERENCES person(userID)
        on delete cascade on update cascade,
    CONSTRAINT fk_r_c FOREIGN KEY(carID) REFERENCES car(carID)
        on delete cascade on update cascade
);

 

-- Address entries
INSERT INTO carrentalsystem.address (street, city, state, country) 
    VALUES ('22B-Bakers Street', 'London', 'London', 'England');
INSERT INTO carrentalsystem.address (street, city, state, country) 
    VALUES ('5/a, Modi Chawl, Station Rd, Santacruz (west)', 'Mumbai', 'Maharashtra', 'India');
INSERT INTO carrentalsystem.address (street, city, state, country) 
    VALUES ('13, Karaneeswarar Pagoda St, Mylapore', 'Chennai', 'Tamil Nadu', 'India');
INSERT INTO carrentalsystem.address (street, city, state, country) 
    VALUES ('7, B2-grd Floor, Rizvi Nagar, S.v Rd, Santacruz (west)', 'Mumbai', 'Maharashtra', 'India');
INSERT INTO carrentalsystem.address (street, city, state, country) 
    VALUES ('A 102, Amargian Complex, L B S Marg, Opp S T Workshop, Thane (west)', 'Mumbai', 'Maharashtra', 'India');
INSERT INTO carrentalsystem.address (street, city, state, country) 
    VALUES ('3683 Union Street', 'Seattle', 'Washington', 'United States');
INSERT INTO carrentalsystem.address (street, city, state, country) 
    VALUES ('2119 Shinn Avenue', 'Hanau', 'Hesse', 'Germany');


-- Person Entries
INSERT INTO carrentalsystem.person(firstName, lastName, email, phone, userName, pwd, gender, addressID)
	VALUES ('Sherlock','Holmes','sherholmes@gmail.com','+447911123456','sherh','drWatson1','M',1);
INSERT INTO carrentalsystem.person(firstName, lastName, email, phone, userName, pwd, gender, addressID)
	VALUES ('Snow','White','whitesnow@yahoo.com','+4930901820','snwh','AGermanFairy0','F',7);
INSERT INTO carrentalsystem.person(firstName, lastName, email, phone, userName, pwd, gender, addressID)
	VALUES ('Rohit','Sharma','rohit200@rediffmail.com','+919999900000','Ro','Hitman200','M',2);
INSERT INTO carrentalsystem.person(firstName, lastName, email, phone, userName, pwd, gender, addressID)
	VALUES ('Dinesh','Karthik','dineshk@outlook.com','+918888822222','DK23','DineK1','F',3);
    

-- Car Model entries
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Maruti Swift Dzire','4-seater Available in White, Gray & Blue Colours',120,11);
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Maruti Ertiga','7-seater, Available in White, Silver, Red, Gray & Blue Colours',170,17);
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Tesla Model 3', '5-seater Available in Black, White, Silver, Red, Gray & Blue Colours',150,15);
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Ford Mustang','The current Mustang arrived in 2015, and brought with it a new range of engine choices. The 3.7L V6 became the base engine; it’s good for a not-at-all-shabby 300 horsepower. Next up is a 2.3L, turbocharged four-cylinder that makes 310 horsepower. Yes, only four cylinders, but it sprints from zero to 60 in less than six seconds! Topping the range is a 5.0L V8 good for over 400 horsepower. Transmission choices include a six-speed manual or an automatic with paddle shifters.', 600,10 );
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Chevrolet Camaro', 'The Camaro is available both as a rear-wheel-drive coupe and a convertible, and while both have a backseat, it probably works best as a shelf for your groceries. Before the 2016 refresh, the LS and LT trims got a 3.6L V6 rated at 312 horsepower, while the SS was powered by a mighty 426-horsepower,  6.2L V8. And if that wasn’t enough, for 2014, Chevy unveiled a Z/28 Camaro that packs a huge 7.0L V8 from the Corvette.',1200,20);
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Dodge Challenger','The Challenger is Dodge’s flagship enthusiast vehicle. But is it a muscle car or is it a sports car? It has certainly got the brawn to launch it in a straight line (zero to 60 mph in a hair over six seconds, thanks to its big Hemi® engine), using its six-speed manual stickshift; the newer models’ independent suspension means the Challenger is a sportier handler than ever before. Some of the more tricked-out Challengers are factory-built hot rods; the Scat Pack option gives drivers nearly 500 horsepower.',500,9);
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Chevrolet Corvette', 'For a certain set of enthusiasts, the Corvette is more than a sports car — it’s American heritage on wheels. The Corvette has been in production since 1953 and the car is currently in its seventh (C7) generation, which hit showrooms in 2014. At an average price of close to $40,000 on our website, a used Corvette is the priciest sports car on this list; but then, you do get a lot for your money.',800,11);
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Nissan 370Z', 'Launched in 2010, the 370Z replaced the visually similar 350Z and traces its lineage back to the 240Z of the early 1970s. Available as both a coupe or a roadster, this compact two-seater checks all the sports car boxes. Power comes from a 3.7L V6 that puts 330 horsepower to the rear wheels through a six-speed manual or a seven-speed automatic transmission (the auto gearbox version comes with paddle shifters). From standing still, this Nissan zooms to 60 mph in around five seconds. If that’s not fast enough you, seek out the NISMO models, which are sportier and make an extra heap of horsepower.',900,15);

-- Car entries
INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES (1,2,"../images/Swift Dzire Gray.jpeg");
INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES (1,1,"../images/Swift Dzire White.jpeg");
INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES (2,1,"../images/Ertiga Black.jpg");
INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES (2,2,"../images/Ertiga Black.jpg");
INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES (3,3,"../images/Tesla Model 3 White.jpg");
INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES (3,4,"../images/Tesla Model 3 Red.jpg");

-- Procedures and Functions

-- numCarsAvailable
DROP PROCEDURE IF EXISTS numCarsAvailable;

DELIMITER $$
create definer=`root`@`localhost` PROCEDURE numCarsAvailable(IN model_ID INT, IN time_in TIMESTAMP, IN time_out TIMESTAMP, OUT num_cars INT)
COMMENT 'Procedure to find the number of cars available for a particular model'
BEGIN
    SET AUTOCOMMIT = 0;
    START TRANSACTION;

	DROP TEMPORARY TABLE IF EXISTS tmp_availCars;
    CREATE TEMPORARY TABLE tmp_availCars
    SELECT carID FROM (SELECT * FROM car where car.modelID = model_ID) AS selectedCars 
    WHERE carID NOT IN 
    (SELECT carID FROM reservation where ( 
    ((`reservation`.`timein` > `time_in`) AND (`reservation`.`timein` < `time_out`) AND (`reservation`.`timeout` > `time_out`)) OR
    ((`reservation`.`timein` < `time_in`) AND (`reservation`.`timeout` < `time_out`) AND (`reservation`.`timeout` > `time_in`)) OR 
    ((`reservation`.`timein` < `time_in`) AND (`reservation`.`timeout` > `time_out`)) 
    ));
    SELECT count(carID) INTO num_cars FROM tmp_availCars;

    COMMIT;
    SET AUTOCOMMIT = 1;
END $$
DELIMITER ;

-- Testing if it returns cars (no reservations yet_
-- CALL numCarsAvailable(3,'2012-12-23 8:00:00','2012-12-23 9:00:00',@n);
-- SELECT @n;
-- SELECT * FROM tmp_availCars;

-- request_reservation | TRANSACTION
DROP PROCEDURE IF EXISTS request_reservation;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE 
`request_reservation`(IN user_ID INT, 
					IN model_ID INT UNSIGNED, 
                    IN rateMode ENUM('Hour','KM'), 
                    IN val NUMERIC(2) UNSIGNED, 
                    IN time_IN TIMESTAMP, 
                    IN time_out TIMESTAMP)
 MODIFIES SQL DATA
 DETERMINISTIC
 SQL SECURITY INVOKER
 COMMENT 'Procedure for user to request a reservation based on the car model'
BEGIN
    SET AUTOCOMMIT = 0;
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
    SET AUTOCOMMIT = 1;
END $$
DELIMITER ;

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

    SET AUTOCOMMIT = 0;
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
    SET AUTOCOMMIT = 1;
END$$
DELIMITER ;

-- amount | FUNCTION
DROP FUNCTION IF EXISTS `amount`;

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

-- Testing reservation
-- request_reservation(IN user_ID INT, IN model_ID INT UNSIGNED, IN rateMode NUMERIC(2) UNSIGNED, IN val NUMERIC(2) UNSIGNED, IN time_IN TIMESTAMP, IN time_out TIMESTAMP)
CALL request_reservation(1, 1, 1, 10, '2012-12-23 18:00:00','2012-12-23 19:00:00');
-- Testing if it returns cars (after 
CALL numCarsAvailable(1,'2012-12-23 18:10:00','2012-12-23 18:50:00',@n);
SELECT @n;
SELECT * FROM tmp_availCars;

SELECT * FROM reservation;
SELECT * FROM car;

CALL request_reservation(2, 1, 1, 10, '2012-12-23 18:00:00','2012-12-23 19:00:00');
CALL request_reservation(1, 4, 1, 10, '2012-12-23 18:00:00','2012-12-23 19:00:00');

CALL request_reservation(1, 1, 1, 10, date("2022-04-12 17:24:01"),date("2022-04-12 18:24:01"));
SELECT @time1 = date("2022-04-12 17:24:01");

SELECT * from reservation;
SELECT * from waitlist;
SELECT * from tmp_availCars;
SELECT @n;

-- Deletes all rows
DELETE FROM reservation;
DELETE FROM waitlist;

SELECT carID FROM reservation where 
    (reservation.timein> date("2022-04-12 17:24:01") AND reservation.timeout > date("2022-04-12 18:24:01")) OR
    (reservation.timein< date("2022-04-12 17:24:01") AND reservation.timeout < date("2022  -04-12 18:24:01")) OR 
    (reservation.timein< date("2022-04-12 17:24:01") AND reservation.timeout > date("2022-04-12 18:24:01"));