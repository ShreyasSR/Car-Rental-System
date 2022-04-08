-- CREATE DATABASE carrentalsystem;
-- Reservation, Car, Address --> Swastik
-- Person, Waitlist, Model type --> Shreyas

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
    CONSTRAINT fk3 FOREIGN KEY(modelID) REFERENCES ModelTYpe,);

