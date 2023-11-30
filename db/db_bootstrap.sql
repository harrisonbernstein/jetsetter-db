-- create the database

CREATE DATABASE IF NOT EXISTS JetsetterDB;
USE JetsetterDB;

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

CREATE TABLE IF NOT EXISTS Manager (
    managerID int,
    firstName text,
    lastName text,
    PRIMARY KEY (managerID)
);

CREATE TABLE IF NOT EXISTS Flight (
    flightId int,
    status text,
    duration time,
    destinationGate varchar(5),
    destinationAirport char(3),
    originGate varchar(5),
    originAirport char(3),
    takeOffTime dateTime,
    landingTime dateTime,
    aircraft int,
    managerID int,
    PRIMARY KEY (flightId),
    FOREIGN KEY (destinationGate) references AirportGate(gateNumber) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (destinationAirport) references Airport(IATAcode) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (originGate) references AirportGate(gateNumber) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (originAirport) references Airport(IATAcode) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (aircraft) references Aircraft(aircraftID) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (managerID) references Manager(managerID) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Passenger (
    passengerId int,
    firstName text,
    lastName text,
    dateOfBirth date,
    gender char(1),
    nationality text,
    PRIMARY KEY (passengerId)
);

CREATE TABLE IF NOT EXISTS PassengerPhoneNumber(
  passengerId int,
  phoneNumber bigint(11),
  PRIMARY KEY (passengerId, phoneNumber),
  FOREIGN KEY (passengerId) references Passenger(passengerID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS PassengerEmail(
  passengerId int,
  email varchar(100),
  PRIMARY KEY (passengerId, email),
  FOREIGN KEY (passengerId) references Passenger(passengerID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Booking (
    bookingId int,
    numberBags int,
    preferences text,
    boardingGroup int,
    seat varchar(3),
    flightId int,
    passengerId int,
    PRIMARY KEY (bookingId),
    FOREIGN KEY (flightId) references Flight(flightId) ON UPDATE cascade ON DELETE restrict,
    FOREIGN KEY (passengerId) references Passenger(passengerId) ON UPDATE cascade ON DELETE cascade
);

CREATE TABLE IF NOT EXISTS Billing (
    billingId int,
    totalAmount decimal(10, 2),
    paymentStatus text,
    paymentMethod text,
    bookingId int,
    PRIMARY KEY (billingId),
    FOREIGN KEY (bookingId) REFERENCES Booking(bookingId) ON UPDATE CASCADE ON DELETE CASCADE
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

-- create all the sample data

insert into Airport (IATAcode, name, city, state, country) values ('GSS', 'Sabi Sabi Airport', 'Hanjia', null, 'ZA');
insert into Airport (IATAcode, name, city, state, country) values ('HET', 'Baita International Airport', 'Luleå', 'BD', 'CN');
insert into Airport (IATAcode, name, city, state, country) values ('LIH', 'Lihue Airport', 'Nueva Guadalupe', null, 'US');
insert into Airport (IATAcode, name, city, state, country) values ('GLW', 'Glasgow Municipal Airport', 'Changxing', null, 'US');
insert into Airport (IATAcode, name, city, state, country) values ('PEI', 'Matecaña International Airport', 'Samothráki', null, 'CO');
insert into Airport (IATAcode, name, city, state, country) values ('DEX', 'Nop Goliat Airport', 'Nuevo Emperador', null, 'ID');
insert into Airport (IATAcode, name, city, state, country) values ('XNG', 'Quảng Ngãi Airfield', 'Cipaku', null, 'VN');
insert into Airport (IATAcode, name, city, state, country) values ('TMB', 'Kendall-Tamiami Executive Airport', 'Jieshi', null, 'US');
insert into Airport (IATAcode, name, city, state, country) values ('GNF', 'Gansner Field', 'Hancheng', null, 'US');
insert into Airport (IATAcode, name, city, state, country) values ('HCC', 'Columbia County Airport', 'Pukhavichy', null, 'US');
insert into Airport (IATAcode, name, city, state, country) values ('ITR', 'Francisco Vilela do Amaral Airport', 'Stapleford', 'ENG', 'BR');
insert into Airport (IATAcode, name, city, state, country) values ('STC', 'St Cloud Regional Airport', 'Okocim', null, 'US');
insert into Airport (IATAcode, name, city, state, country) values ('RVS', 'Richard Lloyd Jones Jr Airport', 'Mwene-Ditu', null, 'US');
insert into Airport (IATAcode, name, city, state, country) values ('DRD', 'Dorunda Airport', 'Veracruz', null, 'AU');
insert into Airport (IATAcode, name, city, state, country) values ('VJI', 'Virginia Highlands Airport', 'Caxito', null, 'US');
insert into Airport (IATAcode, name, city, state, country) values ('UPL', 'Upala Airport', 'Jenggawah', null, 'CR');
insert into Airport (IATAcode, name, city, state, country) values ('ION', 'Impfondo Airport', 'Essen', 'NW', 'CG');
insert into Airport (IATAcode, name, city, state, country) values ('TEK', 'Tatitlek Airport', 'Manabo', null, 'US');
insert into Airport (IATAcode, name, city, state, country) values ('ROS', 'Islas Malvinas Airport', 'Fortaleza', null, 'AR');
insert into Airport (IATAcode, name, city, state, country) values ('JON', 'Johnston Atoll Airport', 'Teroual', null, 'UM');
insert into Airport (IATAcode, name, city, state, country) values ('RCR', 'Fulton County Airport', 'Boac', null, 'US');
insert into Airport (IATAcode, name, city, state, country) values ('PUK', 'Pukarua Airport', 'Baitu', null, 'PF');
insert into Airport (IATAcode, name, city, state, country) values ('KWN', 'Quinhagak Airport', 'Dasha', null, 'US');
insert into Airport (IATAcode, name, city, state, country) values ('SUD', 'Stroud Municipal Airport', 'Oinófyta', null, 'US');
insert into Airport (IATAcode, name, city, state, country) values ('BBQ', 'Codrington Airport', 'Xiaoweizhai', null, 'AG');
insert into Airport (IATAcode, name, city, state, country) values ('STM', 'Maestro Wilson Fonseca Airport', 'Lok', null, 'BR');
insert into Airport (IATAcode, name, city, state, country) values ('ZUD', 'Pupelde Airport', 'Taocun', null, 'CL');
insert into Airport (IATAcode, name, city, state, country) values ('SKT', 'Sialkot Airport', 'Qalyūb', null, 'PK');
insert into Airport (IATAcode, name, city, state, country) values ('YLB', 'Lac La Biche Airport', 'Yanping', null, 'CA');
insert into Airport (IATAcode, name, city, state, country) values ('PEZ', 'Penza Airport', 'Marechal Cândido Rondon', null, 'RU');
insert into Airport (IATAcode, name, city, state, country) values ('GLT', 'Gladstone Airport', 'Lavras', null, 'AU');
insert into Airport (IATAcode, name, city, state, country) values ('SYF', 'Silva Bay Seaplane Base', 'Lanta Timur', null, 'CA');
insert into Airport (IATAcode, name, city, state, country) values ('BLL', 'Billund Airport', 'Chenqiao', null, 'DK');
insert into Airport (IATAcode, name, city, state, country) values ('OHI', 'Oshakati Airport', 'Temorlorong', null, 'NA');
insert into Airport (IATAcode, name, city, state, country) values ('BTV', 'Burlington International Airport', 'Guaíba', null, 'US');
insert into Airport (IATAcode, name, city, state, country) values ('OGA', 'Searle Field', 'Caoping', null, 'US');
insert into Airport (IATAcode, name, city, state, country) values ('RES', 'Resistencia International Airport', 'Blagnac', 'B3', 'AR');
insert into Airport (IATAcode, name, city, state, country) values ('CYM', 'Chatham Seaplane Base', 'Rouyuan', null, 'US');
insert into Airport (IATAcode, name, city, state, country) values ('CHY', 'Choiseul Bay Airport', 'Kohila', null, 'SB');
insert into Airport (IATAcode, name, city, state, country) values ('DJU', 'Djúpivogur Airport', 'Knysna', null, 'IS');
insert into Airport (IATAcode, name, city, state, country) values ('CEW', 'Bob Sikes Airport', 'Montaigu', 'B5', 'US');
insert into Airport (IATAcode, name, city, state, country) values ('ARS', 'Aragarças Airport', 'Camacupa', null, 'BR');
insert into Airport (IATAcode, name, city, state, country) values ('NDI', 'Namudi Airport', 'Pawłowiczki', null, 'PG');
insert into Airport (IATAcode, name, city, state, country) values ('CZF', 'Cape Romanzof LRRS Airport', 'Valdosta', 'GA', 'US');
insert into Airport (IATAcode, name, city, state, country) values ('QGP', 'Garanhuns Airport', 'Ruteng', null, 'BR');
insert into Airport (IATAcode, name, city, state, country) values ('WUV', 'Wuvulu Island Airport', 'Marseille', 'B8', 'PG');
insert into Airport (IATAcode, name, city, state, country) values ('ATL', 'Hartsfield Jackson Atlanta International Airport', 'Inđija', null, 'US');
insert into Airport (IATAcode, name, city, state, country) values ('HTR', 'Hateruma Airport', 'Candelaria', null, 'JP');
insert into Airport (IATAcode, name, city, state, country) values ('RYN', 'Royan-Médis Airport', 'HanHuang', null, 'FR');
insert into Airport (IATAcode, name, city, state, country) values ('HNN', 'Honinabi Airport', 'Tugu', null, 'PG');


insert into AirportGate (gateNumber, IATAcode) values ('E5', 'OKJ');
insert into AirportGate (gateNumber, IATAcode) values ('A1', 'LZU');
insert into AirportGate (gateNumber, IATAcode) values ('H8', 'IEJ');
insert into AirportGate (gateNumber, IATAcode) values ('E5', 'BBR');
insert into AirportGate (gateNumber, IATAcode) values ('B2', 'BYL');
insert into AirportGate (gateNumber, IATAcode) values ('A1', 'DPB');
insert into AirportGate (gateNumber, IATAcode) values ('I9', 'ZRZ');
insert into AirportGate (gateNumber, IATAcode) values ('B2', 'NOK');
insert into AirportGate (gateNumber, IATAcode) values ('G7', 'BGW');
insert into AirportGate (gateNumber, IATAcode) values ('H8', 'URE');
insert into AirportGate (gateNumber, IATAcode) values ('J10', 'NKS');
insert into AirportGate (gateNumber, IATAcode) values ('B2', 'AEO');
insert into AirportGate (gateNumber, IATAcode) values ('H8', 'YSP');
insert into AirportGate (gateNumber, IATAcode) values ('H8', 'RVE');
insert into AirportGate (gateNumber, IATAcode) values ('C3', 'CEI');
insert into AirportGate (gateNumber, IATAcode) values ('E5', 'PSL');
insert into AirportGate (gateNumber, IATAcode) values ('E5', 'NKL');
insert into AirportGate (gateNumber, IATAcode) values ('C3', 'EYR');
insert into AirportGate (gateNumber, IATAcode) values ('H8', 'JUI');
insert into AirportGate (gateNumber, IATAcode) values ('D4', 'BZV');
insert into AirportGate (gateNumber, IATAcode) values ('C3', 'CVG');
insert into AirportGate (gateNumber, IATAcode) values ('F6', 'VNA');
insert into AirportGate (gateNumber, IATAcode) values ('J10', 'NOK');
insert into AirportGate (gateNumber, IATAcode) values ('C3', 'NBC');
insert into AirportGate (gateNumber, IATAcode) values ('E5', 'YXT');
insert into AirportGate (gateNumber, IATAcode) values ('H8', 'TOO');
insert into AirportGate (gateNumber, IATAcode) values ('E5', 'NZL');
insert into AirportGate (gateNumber, IATAcode) values ('A1', 'TOD');
insert into AirportGate (gateNumber, IATAcode) values ('B2', 'AIK');
insert into AirportGate (gateNumber, IATAcode) values ('H8', 'MQP');
insert into AirportGate (gateNumber, IATAcode) values ('J10', 'LIC');
insert into AirportGate (gateNumber, IATAcode) values ('J10', 'ZAJ');
insert into AirportGate (gateNumber, IATAcode) values ('C3', 'LTX');
insert into AirportGate (gateNumber, IATAcode) values ('G7', 'FAM');
insert into AirportGate (gateNumber, IATAcode) values ('C3', 'LSX');
insert into AirportGate (gateNumber, IATAcode) values ('H8', 'OOM');
insert into AirportGate (gateNumber, IATAcode) values ('D4', 'RVY');
insert into AirportGate (gateNumber, IATAcode) values ('C3', 'MSH');
insert into AirportGate (gateNumber, IATAcode) values ('E5', 'FPY');
insert into AirportGate (gateNumber, IATAcode) values ('B2', 'CLN');
insert into AirportGate (gateNumber, IATAcode) values ('F6', 'EKN');
insert into AirportGate (gateNumber, IATAcode) values ('C3', 'CGM');
insert into AirportGate (gateNumber, IATAcode) values ('I9', 'ACV');
insert into AirportGate (gateNumber, IATAcode) values ('F6', 'QUN');
insert into AirportGate (gateNumber, IATAcode) values ('D4', 'YYC');
insert into AirportGate (gateNumber, IATAcode) values ('A1', 'MOA');
insert into AirportGate (gateNumber, IATAcode) values ('C3', 'SXZ');
insert into AirportGate (gateNumber, IATAcode) values ('J10', 'FWH');
insert into AirportGate (gateNumber, IATAcode) values ('A1', 'ONK');
insert into AirportGate (gateNumber, IATAcode) values ('E5', 'DWO');

insert into Aircraft (aircraftID, model, capacity) values (1, 'Airbus A320', 58);
insert into Aircraft (aircraftID, model, capacity) values (2, 'Airbus A320', 83);
insert into Aircraft (aircraftID, model, capacity) values (3, 'Embraer E190', 412);
insert into Aircraft (aircraftID, model, capacity) values (4, 'Cessna 172', 115);
insert into Aircraft (aircraftID, model, capacity) values (5, 'Cessna 172', 64);
insert into Aircraft (aircraftID, model, capacity) values (6, 'Cessna 172', 442);
insert into Aircraft (aircraftID, model, capacity) values (7, 'Cessna 172', 366);
insert into Aircraft (aircraftID, model, capacity) values (8, 'Cessna 172', 458);
insert into Aircraft (aircraftID, model, capacity) values (9, 'Embraer E190', 347);
insert into Aircraft (aircraftID, model, capacity) values (10, 'Cessna 172', 465);
insert into Aircraft (aircraftID, model, capacity) values (11, 'Airbus A320', 66);
insert into Aircraft (aircraftID, model, capacity) values (12, 'Embraer E190', 415);
insert into Aircraft (aircraftID, model, capacity) values (13, 'Embraer E190', 117);
insert into Aircraft (aircraftID, model, capacity) values (14, 'Bombardier Challenger 300', 419);
insert into Aircraft (aircraftID, model, capacity) values (15, 'Embraer E190', 151);
insert into Aircraft (aircraftID, model, capacity) values (16, 'Airbus A320', 49);
insert into Aircraft (aircraftID, model, capacity) values (17, 'Boeing 747', 423);
insert into Aircraft (aircraftID, model, capacity) values (18, 'Bombardier Challenger 300', 11);
insert into Aircraft (aircraftID, model, capacity) values (19, 'Airbus A320', 254);
insert into Aircraft (aircraftID, model, capacity) values (20, 'Embraer E190', 493);
insert into Aircraft (aircraftID, model, capacity) values (21, 'Boeing 747', 120);
insert into Aircraft (aircraftID, model, capacity) values (22, 'Cessna 172', 475);
insert into Aircraft (aircraftID, model, capacity) values (23, 'Airbus A320', 377);
insert into Aircraft (aircraftID, model, capacity) values (24, 'Airbus A320', 498);
insert into Aircraft (aircraftID, model, capacity) values (25, 'Embraer E190', 329);
insert into Aircraft (aircraftID, model, capacity) values (26, 'Boeing 747', 27);
insert into Aircraft (aircraftID, model, capacity) values (27, 'Bombardier Challenger 300', 415);
insert into Aircraft (aircraftID, model, capacity) values (28, 'Bombardier Challenger 300', 19);
insert into Aircraft (aircraftID, model, capacity) values (29, 'Cessna 172', 60);
insert into Aircraft (aircraftID, model, capacity) values (30, 'Boeing 747', 214);
insert into Aircraft (aircraftID, model, capacity) values (31, 'Airbus A320', 471);
insert into Aircraft (aircraftID, model, capacity) values (32, 'Cessna 172', 308);
insert into Aircraft (aircraftID, model, capacity) values (33, 'Boeing 747', 119);
insert into Aircraft (aircraftID, model, capacity) values (34, 'Boeing 747', 259);
insert into Aircraft (aircraftID, model, capacity) values (35, 'Cessna 172', 201);
insert into Aircraft (aircraftID, model, capacity) values (36, 'Bombardier Challenger 300', 239);
insert into Aircraft (aircraftID, model, capacity) values (37, 'Cessna 172', 15);
insert into Aircraft (aircraftID, model, capacity) values (38, 'Airbus A320', 286);
insert into Aircraft (aircraftID, model, capacity) values (39, 'Bombardier Challenger 300', 242);
insert into Aircraft (aircraftID, model, capacity) values (40, 'Bombardier Challenger 300', 253);
insert into Aircraft (aircraftID, model, capacity) values (41, 'Airbus A320', 234);
insert into Aircraft (aircraftID, model, capacity) values (42, 'Cessna 172', 80);
insert into Aircraft (aircraftID, model, capacity) values (43, 'Embraer E190', 46);
insert into Aircraft (aircraftID, model, capacity) values (44, 'Embraer E190', 5);
insert into Aircraft (aircraftID, model, capacity) values (45, 'Bombardier Challenger 300', 460);
insert into Aircraft (aircraftID, model, capacity) values (46, 'Airbus A320', 326);
insert into Aircraft (aircraftID, model, capacity) values (47, 'Bombardier Challenger 300', 56);
insert into Aircraft (aircraftID, model, capacity) values (48, 'Bombardier Challenger 300', 244);
insert into Aircraft (aircraftID, model, capacity) values (49, 'Boeing 747', 371);
insert into Aircraft (aircraftID, model, capacity) values (50, 'Embraer E190', 155);

insert into Manager (managerID, firstName, lastName) values (1, 'Iorgos', 'Doyley');
insert into Manager (managerID, firstName, lastName) values (2, 'Pia', 'Pencot');
insert into Manager (managerID, firstName, lastName) values (3, 'Albrecht', 'Kevis');
insert into Manager (managerID, firstName, lastName) values (4, 'Adolpho', 'Lannin');
insert into Manager (managerID, firstName, lastName) values (5, 'Northrop', 'Errowe');
insert into Manager (managerID, firstName, lastName) values (6, 'Adore', 'Tompsett');
insert into Manager (managerID, firstName, lastName) values (7, 'Freedman', 'Hollingsbee');
insert into Manager (managerID, firstName, lastName) values (8, 'Basile', 'McMonies');
insert into Manager (managerID, firstName, lastName) values (9, 'Alameda', 'Cuvley');
insert into Manager (managerID, firstName, lastName) values (10, 'Gilberto', 'Maylin');
insert into Manager (managerID, firstName, lastName) values (11, 'Hendrika', 'Wickstead');
insert into Manager (managerID, firstName, lastName) values (12, 'Shena', 'Schindler');
insert into Manager (managerID, firstName, lastName) values (13, 'Sibeal', 'Gutridge');
insert into Manager (managerID, firstName, lastName) values (14, 'Abagael', 'Spiers');
insert into Manager (managerID, firstName, lastName) values (15, 'Howard', 'Corner');
insert into Manager (managerID, firstName, lastName) values (16, 'Lek', 'Giddons');
insert into Manager (managerID, firstName, lastName) values (17, 'Quint', 'Ternott');
insert into Manager (managerID, firstName, lastName) values (18, 'Ginnie', 'Keat');
insert into Manager (managerID, firstName, lastName) values (19, 'Batsheva', 'Charley');
insert into Manager (managerID, firstName, lastName) values (20, 'Lenna', 'Kleinplatz');
insert into Manager (managerID, firstName, lastName) values (21, 'Yetta', 'Klesel');
insert into Manager (managerID, firstName, lastName) values (22, 'Moore', 'Chalker');
insert into Manager (managerID, firstName, lastName) values (23, 'Christel', 'Lawes');
insert into Manager (managerID, firstName, lastName) values (24, 'Jilleen', 'Ostrich');
insert into Manager (managerID, firstName, lastName) values (25, 'Des', 'Grigson');
insert into Manager (managerID, firstName, lastName) values (26, 'Baryram', 'McNirlin');
insert into Manager (managerID, firstName, lastName) values (27, 'Devora', 'Gigg');
insert into Manager (managerID, firstName, lastName) values (28, 'Dick', 'Halms');
insert into Manager (managerID, firstName, lastName) values (29, 'Radcliffe', 'Peyro');
insert into Manager (managerID, firstName, lastName) values (30, 'Shandie', 'Catchpole');
insert into Manager (managerID, firstName, lastName) values (31, 'Helen-elizabeth', 'Gravenell');
insert into Manager (managerID, firstName, lastName) values (32, 'Donny', 'Zambon');
insert into Manager (managerID, firstName, lastName) values (33, 'Barbabas', 'Thompsett');
insert into Manager (managerID, firstName, lastName) values (34, 'Osborn', 'Briddle');
insert into Manager (managerID, firstName, lastName) values (35, 'Barri', 'Lawrence');
insert into Manager (managerID, firstName, lastName) values (36, 'Araldo', 'Feaveer');
insert into Manager (managerID, firstName, lastName) values (37, 'Keelby', 'Leyzell');
insert into Manager (managerID, firstName, lastName) values (38, 'Arnoldo', 'Isakson');
insert into Manager (managerID, firstName, lastName) values (39, 'Bartlett', 'Herculeson');
insert into Manager (managerID, firstName, lastName) values (40, 'Isabeau', 'Jean');
insert into Manager (managerID, firstName, lastName) values (41, 'Deloris', 'Ribbens');
insert into Manager (managerID, firstName, lastName) values (42, 'Courtnay', 'Nuccii');
insert into Manager (managerID, firstName, lastName) values (43, 'Bryanty', 'Mecco');
insert into Manager (managerID, firstName, lastName) values (44, 'Joni', 'Davidov');
insert into Manager (managerID, firstName, lastName) values (45, 'Elladine', 'Beddin');
insert into Manager (managerID, firstName, lastName) values (46, 'Judy', 'Chaldecott');
insert into Manager (managerID, firstName, lastName) values (47, 'Starla', 'Ciementini');
insert into Manager (managerID, firstName, lastName) values (48, 'Lilia', 'Clapson');
insert into Manager (managerID, firstName, lastName) values (49, 'Pris', 'Belly');
insert into Manager (managerID, firstName, lastName) values (50, 'Linnet', 'Lipscomb');

insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (1, 'delayed', '1:42:32', 'E5', 'TED', 'F6', 'EMA', '8:24 AM', '11:21 PM', 1, 1);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (2, 'diverted', '13:17:38', 'C3', 'BUG', 'H8', 'CRF', '7:41 PM', '12:02 AM', 2, 2);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (3, 'delayed', '23:44:37', 'G7', 'IKT', 'D4', 'GAD', '7:49 PM', '4:26 AM', 3, 3);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (4, 'diverted', '21:19:53', 'F6', 'ADA', 'E5', 'JCY', '3:02 AM', '1:56 PM', 4, 4);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (5, 'cancelled', '22:47:18', 'H8', 'BWW', 'I9', 'QQT', '12:36 AM', '10:52 PM', 5, 5);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (6, 'on time', '1:25:03', 'C3', 'FFT', 'J10', 'LWL', '11:49 AM', '2:48 PM', 6, 6);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (7, 'cancelled', '00:56:11', 'H8', 'BUW', 'I9', 'MHA', '5:25 PM', '4:30 AM', 7, 7);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (8, 'delayed', '4:49:41', 'J10', 'BRV', 'H8', 'BOF', '2:25 PM', '11:31 PM', 8, 8);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (9, 'on time', '20:07:45', 'G7', 'TRF', 'B2', 'RMQ', '1:52 AM', '1:31 AM', 9, 9);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (10, 'cancelled', '22:36:08', 'D4', 'CBQ', 'F6', 'GGG', '11:04 AM', '4:24 PM', 10, 10);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (11, 'cancelled', '20:03:40', 'D4', 'OBI', 'A1', 'ACH', '10:59 PM', '10:11 AM', 11, 11);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (12, 'diverted', '22:53:27', 'J10', 'BRO', 'I9', 'AIH', '10:34 PM', '5:48 PM', 12, 12);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (13, 'cancelled', '14:41:30', 'D4', 'YIW', 'A1', 'VDI', '5:05 PM', '5:03 PM', 13, 13);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (14, 'cancelled', '4:50:04', 'J10', 'ORN', 'I9', 'WEH', '7:22 AM', '11:31 PM', 14, 14);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (15, 'on time', '20:52:29', 'I9', 'YXS', 'B2', 'CQS', '4:44 AM', '10:26 PM', 15, 15);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (16, 'diverted', '00:56:46', 'J10', 'CSS', 'F6', 'MOA', '2:25 AM', '7:14 AM', 16, 16);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (17, 'diverted', '23:37:34', 'E5', 'ESG', 'F6', 'AKY', '11:16 PM', '1:17 PM', 17, 17);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (18, 'diverted', '23:38:28', 'B2', 'BPL', 'A1', 'OZH', '1:29 PM', '12:11 PM', 18, 18);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (19, 'delayed', '22:24:00', 'J10', 'CAQ', 'J10', 'BUC', '10:51 PM', '9:42 AM', 19, 19);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (20, 'cancelled', '23:36:20', 'C3', 'PLM', 'H8', 'ISA', '2:13 AM', '5:41 AM', 20, 20);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (21, 'diverted', '20:54:38', 'G7', 'BCJ', 'A1', 'HBK', '12:39 PM', '9:31 PM', 21, 21);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (22, 'cancelled', '8:49:49', 'C3', 'APP', 'E5', 'MAN', '10:51 AM', '5:10 AM', 22, 22);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (23, 'delayed', '23:21:05', 'C3', 'YSM', 'F6', 'NUW', '9:05 AM', '8:16 AM', 23, 23);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (24, 'diverted', '22:05:00', 'B2', 'SOD', 'I9', 'KIN', '10:47 AM', '4:12 PM', 24, 24);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (25, 'cancelled', '20:23:53', 'G7', 'YDN', 'G7', 'MHW', '4:48 PM', '10:04 AM', 25, 25);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (26, 'diverted', '03:55:53', 'G7', 'YDW', 'H8', 'SFA', '6:18 PM', '9:21 AM', 26, 26);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (27, 'cancelled', '20:44:19', 'J10', 'GON', 'J10', 'ADH', '5:32 PM', '8:50 AM', 27, 27);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (28, 'on time', '1:08:09', 'G7', 'JKH', 'I9', 'SQY', '7:14 PM', '1:11 PM', 28, 28);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (29, 'diverted', '8:48:41', 'G7', 'AKN', 'F6', 'KSW', '10:39 PM', '7:45 PM', 29, 29);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (30, 'diverted', '7:24:02', 'J10', 'EBN', 'E5', 'KPL', '3:37 PM', '11:50 AM', 30, 30);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (31, 'on time', '14:06:56', 'B2', 'ESG', 'A1', 'UUS', '7:05 PM', '7:01 PM', 31, 31);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (32, 'on time', '17:20:35', 'E5', 'DSN', 'E5', 'KMQ', '12:11 AM', '4:31 AM', 32, 32);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (33, 'on time', '14:06:17', 'F6', 'MHC', 'F6', 'BML', '1:22 PM', '11:06 AM', 33, 33);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (34, 'cancelled', '13:31:00', 'F6', 'YNH', 'G7', 'MMI', '2:44 AM', '3:43 PM', 34, 34);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (35, 'cancelled', '12:14:33', 'C3', 'TQD', 'E5', 'YGW', '6:16 PM', '8:02 AM', 35, 35);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (36, 'diverted', '23:19:32', 'I9', 'LTA', 'E5', 'SHO', '3:17 AM', '12:19 PM', 36, 36);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (37, 'on time', '22:09:36', 'J10', 'YDN', 'J10', 'XNT', '1:23 AM', '9:38 PM', 37, 37);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (38, 'diverted', '20:28:25', 'A1', 'MFH', 'F6', 'QNV', '6:27 AM', '5:28 AM', 38, 38);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (39, 'delayed', '23:19:54', 'F6', 'CBV', 'G7', 'BUG', '12:15 AM', '5:18 PM', 39, 39);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (40, 'delayed', '10:04:44', 'E5', 'NHA', 'F6', 'UCN', '6:54 PM', '8:24 AM', 40, 40);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (41, 'on time', '18:06:18', 'E5', 'NDL', 'C3', 'LWN', '4:25 AM', '2:38 AM', 41, 41);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (42, 'on time', '04:57:30', 'B2', 'FLZ', 'J10', 'ASP', '9:58 AM', '11:22 AM', 42, 42);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (43, 'diverted', '23:11:27', 'C3', 'ONS', 'E5', 'CXR', '1:54 AM', '7:22 AM', 43, 43);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (44, 'diverted', '7:07:52', 'H8', 'KJI', 'I9', 'MFM', '2:28 AM', '8:51 PM', 44, 44);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (45, 'cancelled', '23:32:20', 'H8', 'JAC', 'J10', 'EVX', '8:55 AM', '1:25 PM', 45, 45);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (46, 'diverted', '20:45:56', 'J10', 'LYG', 'J10', 'AKM', '11:37 AM', '7:10 AM', 46, 46);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (47, 'cancelled', '02:47:35', 'G7', 'CES', 'H8', 'MDV', '4:02 PM', '4:30 PM', 47, 47);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (48, 'diverted', '23:06:23', 'B2', 'VIR', 'I9', 'UES', '7:36 PM', '1:57 PM', 48, 48);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (49, 'diverted', '9:38:17', 'H8', 'PMG', 'J10', 'SHK', '4:00 AM', '10:51 AM', 49, 49);
insert into Flight (flightId, status, duration, destinationGate, destinationAirport, originGate, originAirport, takeOffTime, landingTime, aircraft, managerID) values (50, 'delayed', '21:59:36', 'I9', 'OHA', 'A1', 'HNL', '3:19 AM', '3:01 PM', 50, 50);

insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (1, 'Claire', 'Kirtley', '1893-15-90', 'M', 'Russian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (2, 'Tove', 'Showalter', '9475-20-14', 'F', 'Canadian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (3, 'Melisse', 'Egdell', '0692-78-77', 'F', 'Spanish');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (4, 'Sonnnie', 'Domelow', '3180-64-17', 'F', 'Indian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (5, 'Kinna', 'Bramsen', '7811-11-41', 'F', 'Indian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (6, 'Fayette', 'MacFarlan', '8473-15-22', 'F', 'Japanese');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (7, 'Hedwig', 'Faivre', '4158-61-84', 'F', 'Mexican');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (8, 'Debbi', 'Guinan', '9315-34-49', 'F', 'French');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (9, 'Kalinda', 'Slimm', '6571-38-80', 'F', 'French');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (10, 'Freida', 'Fewings', '3865-90-08', 'F', 'Mexican');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (11, 'Kimbell', 'Tanman', '3046-70-59', 'M', 'Canadian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (12, 'Ole', 'Trahmel', '0198-66-73', 'M', 'German');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (13, 'Lee', 'Spraggon', '2475-79-97', 'M', 'Russian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (14, 'Garvey', 'Ollet', '8390-18-43', 'M', 'Canadian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (15, 'Hamlen', 'Astley', '0661-13-52', 'M', 'Mexican');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (16, 'Rhodia', 'Fosberry', '9753-58-11', 'F', 'Mexican');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (17, 'Larissa', 'Alessandretti', '2921-03-54', 'F', 'Spanish');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (18, 'Chris', 'Sleite', '2659-71-32', 'M', 'French');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (19, 'Parrnell', 'Manuele', '4625-94-41', 'M', 'Chinese');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (20, 'Ricard', 'Cadden', '2054-54-01', 'M', 'Chinese');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (21, 'Rod', 'Sturrock', '7939-03-13', 'M', 'Chinese');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (22, 'Florrie', 'Jouanet', '6421-98-61', 'F', 'Russian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (23, 'Kane', 'Chung', '5161-21-41', 'M', 'Japanese');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (24, 'Garrot', 'Topping', '3349-72-67', 'M', 'Indian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (25, 'Maire', 'Franzotto', '6480-70-72', 'F', 'Russian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (26, 'Breena', 'Adderson', '2725-75-28', 'F', 'Italian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (27, 'Crawford', 'Whitley', '3575-12-85', 'M', 'Russian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (28, 'Tandy', 'MacCaffery', '4904-12-95', 'F', 'French');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (29, 'Nickolai', 'Cargen', '4138-18-90', 'M', 'Spanish');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (30, 'Kalle', 'Killgus', '1370-31-17', 'M', 'British');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (31, 'Tiphanie', 'Daniellot', '9275-39-75', 'F', 'Chinese');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (32, 'Lotty', 'Naire', '0066-60-25', 'F', 'Spanish');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (33, 'Bevvy', 'Beresford', '3403-53-42', 'F', 'Russian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (34, 'Munmro', 'Robilart', '4605-87-43', 'M', 'Russian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (35, 'Maximo', 'Jessopp', '3897-72-75', 'M', 'Mexican');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (36, 'Isidore', 'Novakovic', '4986-34-61', 'M', 'Russian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (37, 'Blinny', 'Albin', '2670-46-86', 'F', 'Spanish');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (38, 'Erick', 'Budgen', '8950-68-25', 'M', 'German');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (39, 'Emeline', 'Rubinfeld', '1211-92-06', 'F', 'Canadian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (40, 'Steffane', 'Kalinsky', '5056-48-81', 'F', 'Japanese');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (41, 'Giacobo', 'MacCracken', '1840-01-02', 'M', 'Russian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (42, 'Winny', 'Anker', '7312-92-74', 'F', 'French');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (43, 'Harp', 'Murtimer', '0075-46-78', 'M', 'Japanese');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (44, 'Stephani', 'Nobriga', '1457-60-90', 'F', 'Italian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (45, 'Harley', 'Hearne', '6742-56-07', 'F', 'Indian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (46, 'Jemimah', 'Paget', '9174-94-17', 'F', 'Italian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (47, 'Edvard', 'Camus', '7377-40-45', 'M', 'German');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (48, 'Burty', 'Shevlin', '7071-44-11', 'M', 'Indian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (49, 'Ida', 'Helix', '9961-38-55', 'F', 'Canadian');
insert into Passenger (passengerId, firstName, lastname, dateOfBirth, gender, nationality) values (50, 'Florry', 'Kuhnel', '0251-77-35', 'F', 'Spanish');

insert into PassengerEmail (passengerId, email) values (1, 'fbenson0@yellowpages.com');
insert into PassengerEmail (passengerId, email) values (2, 'ojewis1@hibu.com');
insert into PassengerEmail (passengerId, email) values (3, 'amordey2@dagondesign.com');
insert into PassengerEmail (passengerId, email) values (4, 'aconrath3@nymag.com');
insert into PassengerEmail (passengerId, email) values (5, 'trobelet4@hc360.com');
insert into PassengerEmail (passengerId, email) values (6, 'agyse5@springer.com');
insert into PassengerEmail (passengerId, email) values (7, 'vzywicki6@goo.gl');
insert into PassengerEmail (passengerId, email) values (8, 'bcrinage7@tamu.edu');
insert into PassengerEmail (passengerId, email) values (9, 'lcollete8@ning.com');
insert into PassengerEmail (passengerId, email) values (10, 'dwelden9@discuz.net');
insert into PassengerEmail (passengerId, email) values (11, 'fdukelowa@smugmug.com');
insert into PassengerEmail (passengerId, email) values (12, 'mmccurtb@miitbeian.gov.cn');
insert into PassengerEmail (passengerId, email) values (13, 'cbosselc@sourceforge.net');
insert into PassengerEmail (passengerId, email) values (14, 'deberzd@washingtonpost.com');
insert into PassengerEmail (passengerId, email) values (15, 'ndockete@guardian.co.uk');
insert into PassengerEmail (passengerId, email) values (16, 'cnewburnf@earthlink.net');
insert into PassengerEmail (passengerId, email) values (17, 'gcreminsg@house.gov');
insert into PassengerEmail (passengerId, email) values (18, 'vshavelh@livejournal.com');
insert into PassengerEmail (passengerId, email) values (19, 'mplumbridgei@nifty.com');
insert into PassengerEmail (passengerId, email) values (20, 'aflitcroftj@goodreads.com');
insert into PassengerEmail (passengerId, email) values (21, 'vmcphersonk@barnesandnoble.com');
insert into PassengerEmail (passengerId, email) values (22, 'fdavydzenkol@boston.com');
insert into PassengerEmail (passengerId, email) values (23, 'sfontesm@jalbum.net');
insert into PassengerEmail (passengerId, email) values (24, 'ssesonsn@geocities.jp');
insert into PassengerEmail (passengerId, email) values (25, 'sverzeyo@godaddy.com');
insert into PassengerEmail (passengerId, email) values (26, 'rpanichellip@surveymonkey.com');
insert into PassengerEmail (passengerId, email) values (27, 'lalessandoneq@nps.gov');
insert into PassengerEmail (passengerId, email) values (28, 'cnuschker@techcrunch.com');
insert into PassengerEmail (passengerId, email) values (29, 'smeadowcrafts@printfriendly.com');
insert into PassengerEmail (passengerId, email) values (30, 'gmajort@nbcnews.com');
insert into PassengerEmail (passengerId, email) values (31, 'sgarawayu@admin.ch');
insert into PassengerEmail (passengerId, email) values (32, 'kmackillv@unicef.org');
insert into PassengerEmail (passengerId, email) values (33, 'ffarhertyw@surveymonkey.com');
insert into PassengerEmail (passengerId, email) values (34, 'loxleyx@amazonaws.com');
insert into PassengerEmail (passengerId, email) values (35, 'dbampfieldy@cdbaby.com');
insert into PassengerEmail (passengerId, email) values (36, 'srogerotz@baidu.com');
insert into PassengerEmail (passengerId, email) values (37, 'snaton10@shinystat.com');
insert into PassengerEmail (passengerId, email) values (38, 'dspeir11@marketwatch.com');
insert into PassengerEmail (passengerId, email) values (39, 'jrosenbush12@stanford.edu');
insert into PassengerEmail (passengerId, email) values (40, 'krolston13@cbsnews.com');
insert into PassengerEmail (passengerId, email) values (41, 'vdevon14@xing.com');
insert into PassengerEmail (passengerId, email) values (42, 'ehinks15@mediafire.com');
insert into PassengerEmail (passengerId, email) values (43, 'ebaldacchino16@google.ca');
insert into PassengerEmail (passengerId, email) values (44, 'fboult17@statcounter.com');
insert into PassengerEmail (passengerId, email) values (45, 'cfrostdicke18@microsoft.com');
insert into PassengerEmail (passengerId, email) values (46, 'ocastille19@creativecommons.org');
insert into PassengerEmail (passengerId, email) values (47, 'dharbord1a@altervista.org');
insert into PassengerEmail (passengerId, email) values (48, 'kbarrowcliff1b@stanford.edu');
insert into PassengerEmail (passengerId, email) values (49, 'lfeighney1c@pbs.org');
insert into PassengerEmail (passengerId, email) values (50, 'lbradane1d@forbes.com');

insert into PassengerPhoneNumber (passengerId, phoneNumber) values (1, 'kannwyl0@webeden.co.uk');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (2, 'edominick1@auda.org.au');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (3, 'dparrin2@jiathis.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (4, 'cmaplestone3@woothemes.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (5, 'toscollee4@huffingtonpost.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (6, 'rcockshott5@google.co.jp');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (7, 'rrowson6@google.de');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (8, 'wmacpike7@house.gov');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (9, 'sgarci8@amazon.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (10, 'dguillard9@qq.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (11, 'mmackeiga@prnewswire.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (12, 'kevelingb@topsy.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (13, 'bfierroc@barnesandnoble.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (14, 'fdaymontd@google.co.jp');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (15, 'ebrissone@ow.ly');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (16, 'ibriggdalef@slate.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (17, 'zgaudong@weather.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (18, 'kjaukovich@angelfire.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (19, 'csmallpeacei@yellowbook.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (20, 'cnowaczykj@ovh.net');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (21, 'qlayzellk@so-net.ne.jp');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (22, 'hkirimaal@harvard.edu');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (23, 'kclaigem@altervista.org');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (24, 'kpeaken@abc.net.au');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (25, 'lfeitosao@wufoo.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (26, 'mlinggoodp@delicious.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (27, 'mhaldinq@go.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (28, 'halibertir@amazonaws.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (29, 'sagnews@mapy.cz');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (30, 'lrabatt@rambler.ru');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (31, 'cdurandu@globo.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (32, 'gfeatleyv@theatlantic.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (33, 'fsiggersw@reverbnation.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (34, 'eshreenanx@pen.io');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (35, 'aglazyery@hatena.ne.jp');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (36, 'avanderkruysz@scribd.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (37, 'sbrislane10@dropbox.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (38, 'hstewart11@shinystat.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (39, 'atattam12@blogger.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (40, 'csames13@yahoo.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (41, 'sdelisle14@usgs.gov');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (42, 'bholberry15@soundcloud.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (43, 'imuir16@cbc.ca');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (44, 'ecoltan17@bizjournals.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (45, 'chacquel18@linkedin.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (46, 'agubbins19@devhub.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (47, 'bfern1a@netscape.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (48, 'aahrens1b@theglobeandmail.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (49, 'bstannah1c@youku.com');
insert into PassengerPhoneNumber (passengerId, phoneNumber) values (50, 'mfawdry1d@printfriendly.com');

insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (1, 3.31, 'vegetarian', '2', 'J10', 1, 1);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (2, 3.17, 'vegetarian', 'A', 'C3', 2, 2);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (3, 5.59, 'vegetarian', 'D', 'F6', 3, 3);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (4, 0.38, 'vegan', 'E', 'J10', 4, 4);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (5, 3.51, 'vegan', 'E', 'D4', 5, 5);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (6, 2.55, 'vegetarian', '4', 'A1', 6, 6);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (7, 4.21, 'aisle seat', '5', 'B2', 7, 7);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (8, 6.98, 'window seat', 'C', 'E5', 8, 8);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (9, 1.34, 'vegetarian', 'B', 'C3', 9, 9);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (10, 8.94, 'window seat', '5', 'I9', 10, 10);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (11, 3.8, 'window seat', '4', 'C3', 11, 11);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (12, 5.02, 'gluten-free', 'D', 'B2', 12, 12);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (13, 7.63, 'window seat', 'E', 'G7', 13, 13);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (14, 6.11, 'window seat', 'D', 'E5', 14, 14);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (15, 6.73, 'aisle seat', '4', 'D4', 15, 15);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (16, 1.18, 'vegetarian', '2', 'A1', 16, 16);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (17, 2.04, 'aisle seat', '4', 'J10', 17, 17);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (18, 7.16, 'vegetarian', 'D', 'G7', 18, 18);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (19, 9.07, 'vegan', 'A', 'C3', 19, 19);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (20, 9.98, 'window seat', '4', 'A1', 20, 20);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (21, 0.74, 'vegetarian', '5', 'D4', 21, 21);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (22, 9.18, 'vegan', '1', 'J10', 22, 22);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (23, 3.32, 'aisle seat', '5', 'H8', 23, 23);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (24, 3.08, 'window seat', '3', 'I9', 24, 24);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (25, 1.8, 'gluten-free', 'D', 'I9', 25, 25);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (26, 4.16, 'vegetarian', 'D', 'I9', 26, 26);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (27, 5.76, 'gluten-free', '1', 'F6', 27, 27);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (28, 7.1, 'vegetarian', 'D', 'G7', 28, 28);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (29, 5.19, 'aisle seat', '4', 'D4', 29, 29);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (30, 5.01, 'vegan', 'C', 'J10', 30, 30);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (31, 5.68, 'gluten-free', '5', 'E5', 31, 31);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (32, 7.73, 'gluten-free', 'B', 'G7', 32, 32);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (33, 6.29, 'vegan', 'E', 'B2', 33, 33);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (34, 5.88, 'gluten-free', '3', 'G7', 34, 34);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (35, 4.8, 'vegetarian', 'D', 'J10', 35, 35);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (36, 7.99, 'aisle seat', '3', 'D4', 36, 36);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (37, 5.04, 'vegan', 'C', 'B2', 37, 37);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (38, 2.7, 'vegan', '2', 'G7', 38, 38);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (39, 5.2, 'vegetarian', '3', 'C3', 39, 39);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (40, 5.61, 'gluten-free', 'D', 'B2', 40, 40);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (41, 7.29, 'vegan', 'A', 'J10', 41, 41);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (42, 3.05, 'gluten-free', 'A', 'F6', 42, 42);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (43, 9.4, 'vegan', '5', 'D4', 43, 43);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (44, 6.14, 'gluten-free', 'D', 'F6', 44, 44);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (45, 0.95, 'window seat', 'B', 'F6', 45, 45);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (46, 1.11, 'window seat', '3', 'D4', 46, 46);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (47, 2.27, 'window seat', '3', 'E5', 47, 47);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (48, 8.98, 'vegetarian', 'C', 'E5', 48, 48);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (49, 5.42, 'vegetarian', 'B', 'E5', 49, 49);
insert into Booking (bookingId, numberBags, preferences, boardingGroup, seat, flightId, passengerId) values (50, 9.9, 'vegetarian', '3', 'H8', 50, 50);

insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (1, 743.24, 'unpaid', 'credit card', 1);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (2, 616.89, 'cancelled', 'credit card', 2);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (3, 632.85, 'cancelled', 'PayPal', 3);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (4, 30.99, 'paid', 'Apple Pay', 4);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (5, 263.97, 'paid', 'Apple Pay', 5);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (6, 922.97, 'cancelled', 'debit card', 6);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (7, 122.61, 'paid', 'credit card', 7);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (8, 705.04, 'paid', 'Apple Pay', 8);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (9, 955.47, 'cancelled', 'Google Pay', 9);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (10, 466.17, 'cancelled', 'Google Pay', 10);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (11, 920.04, 'unpaid', 'debit card', 11);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (12, 578.76, 'cancelled', 'debit card', 12);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (13, 426.8, 'unpaid', 'PayPal', 13);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (14, 308.32, 'unpaid', 'Apple Pay', 14);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (15, 239.73, 'pending', 'debit card', 15);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (16, 738.53, 'unpaid', 'credit card', 16);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (17, 934.19, 'pending', 'Apple Pay', 17);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (18, 770.54, 'unpaid', 'Apple Pay', 18);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (19, 159.91, 'pending', 'debit card', 19);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (20, 826.61, 'paid', 'Apple Pay', 20);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (21, 187.01, 'pending', 'debit card', 21);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (22, 861.34, 'paid', 'credit card', 22);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (23, 511.21, 'pending', 'debit card', 23);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (24, 20.24, 'cancelled', 'Apple Pay', 24);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (25, 882.08, 'unpaid', 'debit card', 25);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (26, 612.25, 'paid', 'Apple Pay', 26);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (27, 838.06, 'pending', 'debit card', 27);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (28, 773.24, 'paid', 'credit card', 28);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (29, 28.96, 'unpaid', 'debit card', 29);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (30, 316.94, 'pending', 'Apple Pay', 30);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (31, 605.72, 'unpaid', 'PayPal', 31);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (32, 410.14, 'unpaid', 'PayPal', 32);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (33, 493.08, 'cancelled', 'Apple Pay', 33);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (34, 661.34, 'unpaid', 'debit card', 34);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (35, 872.88, 'pending', 'PayPal', 35);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (36, 733.1, 'pending', 'credit card', 36);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (37, 309.85, 'pending', 'Apple Pay', 37);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (38, 106.73, 'cancelled', 'credit card', 38);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (39, 797.96, 'cancelled', 'PayPal', 39);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (40, 545.95, 'pending', 'credit card', 40);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (41, 865.73, 'cancelled', 'credit card', 41);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (42, 843.39, 'unpaid', 'credit card', 42);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (43, 518.84, 'paid', 'Apple Pay', 43);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (44, 412.3, 'pending', 'Apple Pay', 44);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (45, 989.54, 'unpaid', 'PayPal', 45);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (46, 245.18, 'cancelled', 'debit card', 46);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (47, 658.5, 'cancelled', 'Google Pay', 47);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (48, 54.66, 'pending', 'PayPal', 48);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (49, 675.75, 'unpaid', 'debit card', 49);
insert into Billing (billingId, totalAmount, paymentStatus, paymentMethod, bookingId) values (50, 463.55, 'cancelled', 'credit card', 50);

insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (1, 'Idaline', 'Antonacci', 25, 30);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (2, 'Vernon', 'Iglesia', 26, 10);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (3, 'Hermy', 'Pavlenko', 18, 20);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (4, 'Bria', 'Willans', 32, 39);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (5, 'Loy', 'Band', 37, 1);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (6, 'Sheela', 'Guillet', 33, 7);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (7, 'Ethelind', 'Hobbing', 13, 0);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (8, 'Yank', 'Kirley', 3, 30);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (9, 'Gill', 'Faircloth', 30, 39);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (10, 'Marylee', 'Rigeby', 33, 0);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (11, 'Kathie', 'Snel', 15, 33);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (12, 'Athena', 'Frodsham', 12, 26);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (13, 'Elihu', 'Hammonds', 2, 8);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (14, 'Velvet', 'Bodicum', 35, 14);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (15, 'Baily', 'Von Der Empten', 16, 23);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (16, 'Junina', 'Leftridge', 15, 23);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (17, 'Nora', 'Mellsop', 8, 9);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (18, 'Ailis', 'Pohl', 34, 10);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (19, 'Joelie', 'Ewles', 24, 3);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (20, 'Vinson', 'Siehard', 2, 30);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (21, 'Celie', 'Snowding', 17, 14);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (22, 'Maxi', 'Sherry', 17, 14);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (23, 'Shay', 'Spelman', 37, 14);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (24, 'Maje', 'Oultram', 7, 38);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (25, 'Romonda', 'Lukianovich', 30, 12);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (26, 'Lance', 'Iacabucci', 9, 3);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (27, 'Bar', 'Matyatin', 17, 3);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (28, 'Ebonee', 'Martt', 22, 19);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (29, 'Gusty', 'Pinniger', 23, 22);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (30, 'Dugald', 'Guidoni', 11, 17);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (31, 'Pamella', 'Fetherby', 31, 6);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (32, 'Rayner', 'Dalliwatr', 2, 12);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (33, 'Beau', 'Fleischmann', 11, 3);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (34, 'Jinny', 'Venditti', 9, 1);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (35, 'Codie', 'Lucian', 22, 33);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (36, 'Dorothy', 'Shillitoe', 31, 0);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (37, 'Fiann', 'Almey', 7, 27);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (38, 'Giulietta', 'Bradick', 32, 15);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (39, 'Patrice', 'Dederick', 39, 23);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (40, 'Brennan', 'Portugal', 38, 10);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (41, 'Vasily', 'Severy', 34, 5);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (42, 'Caty', 'Brandom', 34, 11);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (43, 'Theodoric', 'Rey', 25, 34);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (44, 'Tildie', 'Winn', 39, 27);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (45, 'Kippar', 'Slott', 35, 23);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (46, 'Daren', 'Plews', 3, 25);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (47, 'Lorant', 'Bennedick', 31, 40);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (48, 'Lesya', 'Simounet', 36, 15);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (49, 'Dan', 'Gulk', 18, 17);
insert into CrewMember (crewID, firstName, lastName, weeklyHoursWorked, timeTakenOff) values (50, 'Orelle', 'Legrice', 12, 34);

insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (1, 1, 'cabin crew', 1);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (2, 2, 'flight attendant', 2);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (3, 3, 'cabin crew', 3);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (4, 4, 'pilot', 4);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (5, 5, 'flight attendant', 5);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (6, 6, 'first officer', 6);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (7, 7, 'first officer', 7);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (8, 8, 'flight attendant', 8);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (9, 9, 'pilot', 9);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (10, 10, 'flight attendant', 10);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (11, 11, 'first officer', 11);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (12, 12, 'pilot', 12);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (13, 13, 'flight attendant', 13);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (14, 14, 'co-pilot', 14);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (15, 15, 'cabin crew', 15);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (16, 16, 'flight attendant', 16);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (17, 17, 'cabin crew', 17);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (18, 18, 'captain', 18);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (19, 19, 'flight attendant', 19);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (20, 20, 'first officer', 20);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (21, 21, 'flight attendant', 21);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (22, 22, 'co-pilot', 22);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (23, 23, 'first officer', 23);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (24, 24, 'pilot', 24);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (25, 25, 'captain', 25);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (26, 26, 'first officer', 26);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (27, 27, 'flight attendant', 27);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (28, 28, 'flight attendant', 28);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (29, 29, 'first officer', 29);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (30, 30, 'co-pilot', 30);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (31, 31, 'first officer', 31);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (32, 32, 'cabin crew', 32);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (33, 33, 'cabin crew', 33);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (34, 34, 'cabin crew', 34);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (35, 35, 'co-pilot', 35);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (36, 36, 'flight attendant', 36);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (37, 37, 'co-pilot', 37);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (38, 38, 'first officer', 38);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (39, 39, 'co-pilot', 39);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (40, 40, 'captain', 40);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (41, 41, 'captain', 41);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (42, 42, 'co-pilot', 42);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (43, 43, 'pilot', 43);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (44, 44, 'first officer', 44);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (45, 45, 'flight attendant', 45);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (46, 46, 'pilot', 46);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (47, 47, 'first officer', 47);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (48, 48, 'co-pilot', 48);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (49, 49, 'captain', 49);
insert into CrewMemberAssignment (assignmentID, flightId, role, crewID) values (50, 50, 'flight attendant', 50);
