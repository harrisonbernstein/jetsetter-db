# Jetsetter DB

## This project is an interactive app to handle airline flights, passengers, bookings, and operations. 

## Link to demo video: https://drive.google.com/file/d/1s7ktBN6Cd2O4a5GExeSr6Y2oGWUho_ZK/view?usp=share_link

## This repo sets up 3 Docker containers: 
1. A MySQL 8 container for managing a database (populated with sameple data generated via Mockaroo)
1. A Python Flask container to implement a REST API (more details below)
1. A Local AppSmith Server

## 8 blueprints were created in the Flash backend:
1. Airports
1. Billings
1. Bookings
1. Crew members
1. Crew member assignments
1. Flights
1. Passengers
1. Gates

Each blueprint has a set of routes to handle GET, POST, PUT, and DELETE requests.

## How to setup and start the containers

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 




