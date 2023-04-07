create database green_lane;

show databases;

use green_lane;

create table Bikes (
    maintenanceStatus boolean,
    rideStatus boolean,
    type varchar(50),
    location varchar(50),
    bikeID int,
    DS_stationID int not null,
    primary key (bikeID),
    FOREIGN KEY (DS_stationID) REFERENCES DockingStation(stationID)

);

create table City (
    cityID int,
    location varchar(50),
    numStations int,
    numBikes int,
    B_bikeID int,
    primary key (cityID),
    FOREIGN KEY (B_bikeID) REFERENCES Bikes(bikeID)


);

create table Users (
    userID int,
    lName varchar(50) not null,
    fName varchar(50) not null,
    dob date,
    address varchar(50),
    email varchar(100) unique not null,
    CR_rideID int,
    primary key (userID),
    FOREIGN KEY (CR_rideID) references CurrentRide(rideID)
);

create table DockingStation (
    stationID int,
    docks int,
    location varchar(50),
    numBikes int,
    B_bikeID int,
    primary key (stationID),
    FOREIGN KEY (B_bikeID) REFERENCES Bikes(bikeID)
);

create table WorkOrders (
    reportID int,
    location varchar(50),
    timeResolved datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    timeReported datetime default CURRENT_TIMESTAMP,
    reportType varchar(50),
    B_bikeID int,
    E_employeeID int,
    primary key (reportID),
    foreign key (B_bikeID) references Bikes(bikeID),
    foreign key (E_employeeID) references RepairCrew(employeeID)

);

create table RepairCrew (
    employeeID int,
    location varchar(50),
    lName varchar(50),
    fName varchar(50),
    R_reportID int,
    primary key (employeeID),
    foreign key (R_reportID) references WorkOrders(reportID)
);

create table CurrentRide (
    B_bikeID int,
    U_userID int,
    rideID int,
    startTime datetime default CURRENT_TIMESTAMP,
    PRIMARY KEY (U_userID, B_bikeID),
    FOREIGN KEY (U_userID) REFERENCES Users(userID),
    FOREIGN KEY (B_bikeID) REFERENCES Bikes(bikeID)

);

create table RideHistory (
    historyID int,
    startTime datetime default CURRENT_TIMESTAMP,
    endTime datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    startLoc varchar(50),
    endLoc varchar(50),
    rating int CHECK (rating >= 1 AND rating <= 5),
    CR_rideID int,
    primary key (historyID, CR_rideID),
    foreign key (CR_rideID) references CurrentRide(rideID)



)


