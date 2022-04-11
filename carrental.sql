-- CREATE DATABASE carrentalsystem;
-- Reservation, Car, Address --> Swastik
-- Person, Waitlist, Model type --> Shreyas
-- CREATE DATABASE carrentalsystem;

USE carrentalsystem;

-- CREATE TABLE IF NOT EXISTS address(
--     addressID VARCHAR(50),
--     street VARCHAR(100),
--     city VARCHAR(30),
--     state VARCHAR(30),
--     country VARCHAR(30),
-- );

-- Don't change this order, it accounts for foreign key dependencies in the required order
DROP TABLE waitlist;
DROP TABLE car;
DROP TABLE reservation;
DROP TABLE person;
DROP TABLE address;
DROP TABLE modelType;




CREATE TABLE IF NOT EXISTS address(
    addressID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    street VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    zip INT UNSIGNED NOT NULL,
    CONSTRAINT pk_a PRIMARY KEY(addressID),
    -- To prevent duplicate addresses
    CONSTRAINT unique_add UNIQUE(street,city,state,country,zip) 
);

CREATE TABLE IF NOT EXISTS person(
    userID  INT UNSIGNED NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(50) NOT NULL DEFAULT '',
    lastName VARCHAR(50) NOT NULL DEFAULT '',
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    userName VARCHAR(30) NOT NULL,  
    pwd VARCHAR(225) NOT NULL,
    gender ENUM('M','F','Other'),
    addressID INT UNSIGNED NOT NULL,
    CONSTRAINT pk_p PRIMARY KEY(userID),
    CONSTRAINT fk_p_a FOREIGN KEY(addressID) REFERENCES address(addressID) ON DELETE cascade,
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
    
    CONSTRAINT pk_w PRIMARY KEY(waitID),
    CONSTRAINT fk_w_p FOREIGN KEY(userID) REFERENCES person(userID),
    CONSTRAINT fk_w_m FOREIGN KEY(modelID) REFERENCES modelType(modelID)
);


CREATE TABLE IF NOT EXISTS car(
    carID int UNSIGNED NOT NULL AUTO_INCREMENT,
    modelID int UNSIGNED NOT NULL,
    ownerID int UNSIGNED NOT NULL,
    carimg VARCHAR(200),
    CONSTRAINT pk_c PRIMARY KEY(carID),
    CONSTRAINT fk_c_m FOREIGN KEY(modelID) REFERENCES modelType(modelID)
        on delete cascade , -- check once more
    CONSTRAINT fk_c_p FOREIGN KEY(ownerID) REFERENCES person(userID)
        on delete cascade
);

CREATE TABLE IF NOT EXISTS reservation(
    rID int UNSIGNED NOT NULL AUTO_INCREMENT,
    userID int UNSIGNED NOT NULL,
    carID int UNSIGNED NOT NULL,
    ratemode NUMERIC(2) UNSIGNED NOT NULL,
    value numeric(6,2) not null,
    timein TIMESTAMP not null,
    timeout timestamp not null,
    CONSTRAINT pk_r PRIMARY KEY(rID),
    CONSTRAINT fk_r_p FOREIGN KEY(userID) REFERENCES person(userID)
        on delete cascade,
    CONSTRAINT fk_r_c FOREIGN KEY(carID) REFERENCES car(carID)
        on delete cascade
);

 

-- Address entries
INSERT INTO carrentalsystem.address (street, city, state, country, zip) VALUES ('22B-Bakers Street', 'London', 'London', 'England', 0);
INSERT INTO carrentalsystem.address (street, city, state, country, zip) VALUES ('5/a, Modi Chawl, Station Rd, Santacruz (west)', 'Mumbai', 'Maharashtra', 'India', 400054);
INSERT INTO carrentalsystem.address (street, city, state, country, zip) VALUES ('13, Karaneeswarar Pagoda St, Mylapore', 'Chennai', 'Tamil Nadu', 'India', 600004);
INSERT INTO carrentalsystem.address (street, city, state, country, zip) VALUES ('7, B2-grd Floor, Rizvi Nagar, S.v Rd, Santacruz (west)', 'Mumbai', 'Maharashtra', 'India', 400054);
INSERT INTO carrentalsystem.address (street, city, state, country, zip) VALUES ('A 102, Amargian Complex, L B S Marg, Opp S T Workshop, Thane (west)', 'Mumbai', 'Maharashtra', 'India', 400601);
INSERT INTO carrentalsystem.address (street, city, state, country, zip) VALUES ('3683 Union Street', 'Seattle', 'Washington', 'United States', 98101);
INSERT INTO carrentalsystem.address (street, city, state, country, zip) VALUES ('2119 Shinn Avenue', 'Hanau', 'Hesse', 'Germany', 63450);


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

-- Car entries
INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES (1,2,"../images/Swift Dzire Gray.jpeg");
INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES (1,1,"../images/Swift Dzire White.jpeg");
INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES (2,1,"../images/Ertiga Black.jpg");
INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES (2,2,"../images/Ertiga Black.jpg");
INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES (3,3,"../images/Tesla Model 3 White.jpg");
INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES (3,4,"../images/Tesla Model 3 Red.jpg");

SELECT * from car;
SELECT * from person;
SELECT * from modelType;
select * from address order by addressID;