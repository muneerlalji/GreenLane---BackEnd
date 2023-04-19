SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `green_lane` ;
CREATE SCHEMA IF NOT EXISTS `green_lane` DEFAULT CHARACTER SET latin1 ;

show databases;

use green_lane;

create table Bikes (
    bikeID int not null AUTO_INCREMENT,
    maintenanceStatus boolean,
    rideStatus boolean,
    type varchar(50),
    DS_stationID int not null,
    C_cityID int not null,
    primary key (bikeID),
    Constraint fk_1 FOREIGN KEY (DS_stationID) REFERENCES DockingStation(stationID),
    Constraint fk_2 FOREIGN KEY (C_cityID) REFERENCES City(cityID)

);

create table City (
    cityID int not null AUTO_INCREMENT,
    location varchar(50),
    numStations int,
    numBikes int,
    B_bikeID int,
    primary key (cityID),
    Constraint fk_3 FOREIGN KEY (B_bikeID) REFERENCES Bikes(bikeID)


);

create table Users (
    userID int not null AUTO_INCREMENT,
    lName varchar(50) not null,
    fName varchar(50) not null,
    dob date,
    address varchar(50),
    email varchar(100) unique not null,
    CR_rideID int,
    primary key (userID),
    Constraint fk_4 FOREIGN KEY (CR_rideID) references CurrentRide(rideID)
);

create table DockingStation (
    stationID int not null AUTO_INCREMENT,
    docks int,
    location varchar(50),
    numBikes int,
    C_cityID int not null,
    primary key (stationID),
    Constraint fk_5 FOREIGN KEY (C_cityID) REFERENCES City(cityID)
);

create table WorkOrders (
    reportID int not null AUTO_INCREMENT,
    location varchar(50),
    timeResolved datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    timeReported datetime default CURRENT_TIMESTAMP,
    reportType varchar(50),
    B_bikeID int,
    E_employeeID int,
    primary key (reportID),
    Constraint fk_6 foreign key (B_bikeID) references Bikes(bikeID),
    Constraint fk_7 foreign key (E_employeeID) references RepairCrew(employeeID)

);

create table RepairCrew (
    employeeID int not null AUTO_INCREMENT,
    location varchar(50),
    lName varchar(50),
    fName varchar(50),
    R_reportID int,
    primary key (employeeID),
    Constraint fk_8 foreign key (R_reportID) references WorkOrders(reportID)
);

create table CurrentRide (
    rideID int not null AUTO_INCREMENT,
    B_bikeID int,
    U_userID int,
    startTime datetime default CURRENT_TIMESTAMP,
    PRIMARY KEY (rideID),
    Constraint fk_9 FOREIGN KEY (U_userID) REFERENCES Users(userID),
    Constraint fk_10 FOREIGN KEY (B_bikeID) REFERENCES Bikes(bikeID)

);

create table RideHistory (
    historyID int not null AUTO_INCREMENT,
    startTime datetime default CURRENT_TIMESTAMP,
    endTime datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    startLoc varchar(50),
    endLoc varchar(50),
    rating int CHECK (rating >= 1 AND rating <= 5),
    CR_rideID int,
    primary key (historyID),
    Constraint fk_11 foreign key (CR_rideID) references CurrentRide(rideID)



);

create table lookupReport (
    typeOfReport varchar(50),
    reportTypeID int not null
);

insert into lookupReport
values ('electrical', '1');
insert into lookupReport
values ('physical', '2');
insert into lookupReport
values ('systems', '3');
insert into lookupReport
values ('gps', '4');
insert into lookupReport
values ('software', '5');

create table lookupBikeType (
    bikeType varchar(50),
    bikeTypeID int not null
);

insert into lookupBikeType
values ('pedal bike', '1');
insert into lookupBikeType
values ('electric motor', '2');