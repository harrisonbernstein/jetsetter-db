-- This file is to bootstrap a database for the CS3200 project. 

-- Create a new database.  You can change the name later.  You'll
-- need this name in the FLASK API file(s),  the AppSmith 
-- data source creation.
create database if not exists jetsetter_db;

-- Via the Docker Compose file, a special user called webapp will 
-- be created in MySQL. We are going to grant that user 
-- all privilages to the new database we just created. 
-- TODO: If you changed the name of the database above, you need 
-- to change it here too.
grant all privileges on jetsetter_db.* to 'webapp'@'%';
flush privileges;

-- Move into the database we just created.
-- TODO: If you changed the name of the database above, you need to
-- change it here too. 
use jetsetter_db;

-- Put your DDL 
-- create the database
-- create all the tables
CREATE TABLE IF NOT EXISTS Airport (
    IATAcode char(3),
    name text,
    city text,
    state text,
    country text,
    PRIMARY KEY (IATAcode)
);

CREATE TABLE IF NOT EXISTS AirportGate (
    gateNumber varchar(5),
    IATAcode char(3),
    PRIMARY KEY (gateNumber),
    FOREIGN KEY (IATAcode) references Airport(IATAcode) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Aircraft (
    aircraftID int,
    model text,
    capacity int,
    PRIMARY KEY (aircraftID)
);

CREATE TABLE IF NOT EXISTS Flight (
    flightId int,
    status text,
    duration time,
    destinationGate varchar(5),
    destinationAirport text,
    originGate varchar(5),
    originAirport text,
    takeOffTime dateTime,
    landingTime dateTime,
    aircraft int,
    PRIMARY KEY (flightId),
    FOREIGN KEY (destinationGate) references AirportGate(gateNumber) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (originGate) references AirportGate(gateNumber) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (aircraft) references Aircraft(aircraftID) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Manager (
    managerID int,
    firstName text,
    lastName text,
    PRIMARY KEY (managerID)
);

CREATE TABLE IF NOT EXISTS ScheduledFlight (
    scheduleID int,
    flightId int,
    managerID int,
    PRIMARY KEY (scheduleID),
    FOREIGN KEY (flightId) REFERENCES Flight(flightId) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (managerID) REFERENCES Manager(managerID) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Passenger (
    passengerId int,
    firstName text,
    lastName text,
    email text,
    phoneNumber bigint(11),
    PRIMARY KEY (passengerId)
);

CREATE TABLE IF NOT EXISTS Booking (
    bookingId int,
    numberBags int,
    preferences text,
    boardingGroup int,
    seat varchar(5),
    flightId int,
    passengerId int,
    PRIMARY KEY (bookingId),
    FOREIGN KEY (flightId) references Flight(flightId) ON UPDATE cascade ON DELETE restrict,
    FOREIGN KEY (passengerId) references Passenger(passengerId) ON UPDATE cascade ON DELETE cascade
);

CREATE TABLE IF NOT EXISTS CrewMember (
  crewID int,
  firstName text,
  lastName text,
  weeklyHoursWorked int,
  timeTakenOff int,
  PRIMARY KEY (crewID)
);

CREATE TABLE IF NOT EXISTS CrewMemberAssignment (
    assignmentID int,
    flightId int,
    role text,
    crewID int,
    PRIMARY KEY (assignmentID),
    FOREIGN KEY (flightId) references Flight(flightId) ON UPDATE cascade ON DELETE restrict,
    FOREIGN KEY (crewID) references CrewMember(crewID) ON UPDATE cascade ON DELETE cascade
);

-- Add sample data. 
-- put mockaroo data here --
