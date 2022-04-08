-- CREATE DATABASE carrentalsystem;
-- Reservation, Car, Address --> Swastik
-- Person, Waitlist, Model type --> Shreyas


DROP TABLE person;
DROP TABLE modelType;
DROP TABLE waitlist;
DROP TABLE person;
DROP TABLE person;
DROP TABLE person;


CREATE TABLE IF NOT EXISTS person(
    userID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(50) NOT NULL DEFAULT '',
    lastName VARCHAR(50) NOT NULL DEFAULT '',
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    userName VARCHAR(30) NOT NULL,
    pwd VARCHAR(225) NOT NULL,
    gender ENUM('M','F','Other'),
    addressID VARCHAR(11) NOT NULL,
    CONSTRAINT pID PRIMARY KEY(userID),
    CONSTRAINT fk1 FOREIGN KEY(addressID) REFERENCES ADDRESS,
    );

CREATE TABLE IF NOT EXISTS modelType(
    modelID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL DEFAULT '',
    description VARCHAR(100) NOT NULL DEFAULT '',
    INT rate_by_hour NOT NuLL,
    INT rate_by_km NOT NuLL,
    CONSTRAINT modelID PRIMARY KEY(modelID),
    
    );

    CREATE TABLE IF NOT EXISTS waitlist(
    waitID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    modelID INT UNSIGNED NOT NULL
    
    CONSTRAINT wID PRIMARY KEY(waitID),
    CONSTRAINT fk2 FOREIGN KEY(userID) REFERENCES PERSON,
    CONSTRAINT fk3 FOREIGN KEY(modelID) REFERENCES ModelTYpe);

CREATE TABLE IF NOT EXISTS address(
    addressID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    street VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    zip INT UNSIGNED NOT NULL
);
CREATE TABLE IF NOT EXISTS car(
    carID int UNSIGNED NOT NULL AUTO_INCREMENT,
    modelID int UNSIGNED NOT NULL,
    ownerID int UNSIGNED NOT NULL,
    carimg VARCHAR(200),
    PRIMARY KEY(carID),
    FOREIGN KEY(modelID) REFERENCES modelType(modelID)
        on delete set NULL,
    FOREIGN KEY(ownerID) REFERENCES person(userID)
        on delete cascade,
);
CREATE TABLE IF NOT EXISTS reservation(
    rID int UNSIGNED NOT NULL AUTO_INCREMENT,
    userID int UNSIGNED NOT NULL,
    carID int UNSIGNED NOT NULL,
    ratemode NUMERIC(2) UNSIGNED NOT NULL,
    timein TIMESTAMP not null,
    timeout timestamp not null
);