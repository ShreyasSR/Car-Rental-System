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


DROP TABLE person;
DROP TABLE modelType;
DROP TABLE waitlist;
DROP TABLE person;
DROP TABLE person;
DROP TABLE person;

CREATE TABLE IF NOT EXISTS address(
    addressID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    street VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    zip INT UNSIGNED NOT NULL,
    CONSTRAINT pk_a PRIMARY KEY(addressID)
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
    CONSTRAINT fk_p_a FOREIGN KEY(addressID) REFERENCES address(addressID)
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
        on delete set ,
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
INSERT INTO carrentalsystem.address (street, city, state, country, zip) VALUES ('22B-Bakers Street', 'London', 'London', 'England', 0);
INSERT INTO carrentalsystem.address (street, city, state, country, zip) VALUES ('5/a, Modi Chawl, Station Rd, Santacruz (west)', 'Mumbai', 'Maharashtra', 'India', 400054);
INSERT INTO carrentalsystem.address (street, city, state, country, zip) VALUES ('13, Karaneeswarar Pagoda St, Mylapore', 'Chennai', 'Tamil Nadu', 'India', 600004);
INSERT INTO carrentalsystem.address (street, city, state, country, zip) VALUES ('7, B2-grd Floor, Rizvi Nagar, S.v Rd, Santacruz (west)', 'Mumbai', 'Maharashtra', 'India', 400054);
INSERT INTO carrentalsystem.address (street, city, state, country, zip) VALUES ('A 102, Amargian Complex, L B S Marg, Opp S T Workshop, Thane (west)', 'Mumbai', 'Maharashtra', 'India', 400601);
INSERT INTO carrentalsystem.address (street, city, state, country, zip) VALUES ('3683 Union Street', 'Seattle', 'Washington', 'United States', 98101);
INSERT INTO carrentalsystem.address (street, city, state, country, zip) VALUES ('2119 Shinn Avenue', 'Pittsburgh', 'Pennsylvania', 'United States', 15222);

INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Ford Mustang','The current Mustang arrived in 2015, and brought with it a new range of engine choices. The 3.7L V6 became the base engine; it’s good for a not-at-all-shabby 300 horsepower. Next up is a 2.3L, turbocharged four-cylinder that makes 310 horsepower. Yes, only four cylinders, but it sprints from zero to 60 in less than six seconds! Topping the range is a 5.0L V8 good for over 400 horsepower. Transmission choices include a six-speed manual or an automatic with paddle shifters.', 600,10 );
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Chevrolet Camaro', 'The Camaro is available both as a rear-wheel-drive coupe and a convertible, and while both have a backseat, it probably works best as a shelf for your groceries. Before the 2016 refresh, the LS and LT trims got a 3.6L V6 rated at 312 horsepower, while the SS was powered by a mighty 426-horsepower,  6.2L V8. And if that wasn’t enough, for 2014, Chevy unveiled a Z/28 Camaro that packs a huge 7.0L V8 from the Corvette.',1200,20);
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Dodge Challenger','The Challenger is Dodge’s flagship enthusiast vehicle. But is it a muscle car or is it a sports car? It has certainly got the brawn to launch it in a straight line (zero to 60 mph in a hair over six seconds, thanks to its big Hemi® engine), using its six-speed manual stickshift; the newer models’ independent suspension means the Challenger is a sportier handler than ever before. Some of the more tricked-out Challengers are factory-built hot rods; the Scat Pack option gives drivers nearly 500 horsepower.',500,9);
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Chevrolet Corvette', 'For a certain set of enthusiasts, the Corvette is more than a sports car — it’s American heritage on wheels. The Corvette has been in production since 1953 and the car is currently in its seventh (C7) generation, which hit showrooms in 2014. At an average price of close to $40,000 on our website, a used Corvette is the priciest sports car on this list; but then, you do get a lot for your money.',800,11);
INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ('Nissan 370Z', 'Launched in 2010, the 370Z replaced the visually similar 350Z and traces its lineage back to the 240Z of the early 1970s. Available as both a coupe or a roadster, this compact two-seater checks all the sports car boxes. Power comes from a 3.7L V6 that puts 330 horsepower to the rear wheels through a six-speed manual or a seven-speed automatic transmission (the auto gearbox version comes with paddle shifters). From standing still, this Nissan zooms to 60 mph in around five seconds. If that’s not fast enough you, seek out the NISMO models, which are sportier and make an extra heap of horsepower.',900,15);
-- INSERT INTO carrentalsystem.modelType (name, description, rate_by_hour, rate_by_km) VALUES ();

-- INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES ();
-- INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES ();
-- INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES ();
-- INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES ();
-- INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES ();
-- INSERT INTO carrentalsystem.car (modelID, ownerID, carimg) VALUES ();