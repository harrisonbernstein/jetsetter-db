from flask import Blueprint, request, jsonify, make_response
import json
from src import db

flights = Blueprint('flights', __name__)

@flights.route('/flights', methods=['GET', 'POST'])
def get_flights():
    if request.method == 'POST':
        data = request.json
        flightID = data['flightID']
        departure = data['departure']
        arrival = data['arrival']
        departureTime = data['departureTime']
        arrivalTime = data['arrivalTime']
        aircraftID = data['aircraftID']
        cursor = db.get_db().cursor()
        cursor.execute('insert into Flight (flightID, departure, arrival, departureTime, arrivalTime, aircraftID) values (%s, %s, %s, %s, %s, %s)', 
                    (flightID, departure, arrival, departureTime, arrivalTime, aircraftID))
        db.get_db().commit()
        return 'Success!'
    if request.method == 'GET':
      cursor = db.get_db().cursor()
      cursor.execute('SELECT * FROM Flight')
      row_headers = [x[0] for x in cursor.description]
      theData = cursor.fetchall()
      json_data = []
      for row in theData:
        json_data.append(dict(zip(row_headers, row)))
      the_response = make_response(json.dumps(json_data, default=str, indent=4, sort_keys=True))
      the_response.status_code = 200
      the_response.mimetype = 'application/json'
      return the_response

@flights.route('/flights/<flightID>', methods=['GET', 'PUT', 'DELETE'])
def get_flight(flightID):
  if request.method == 'GET':
    cursor = db.get_db().cursor()
    cursor.execute('select * from Flight where flightId = %s', (flightID,))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(json.dumps(json_data, default=str, indent=4, sort_keys=True))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
  if request.method == 'PUT':
    data = request.json
    flightID = data['flightID']
    departure = data['departure']
    arrival = data['arrival']
    departureTime = data['departureTime']
    arrivalTime = data['arrivalTime']
    aircraftID = data['aircraftID']
    cursor = db.get_db().cursor()
    cursor.execute('UPDATE Flight SET departure = %s, arrival = %s, departureTime = %s, arrivalTime = %s, aircraftID = %s WHERE flightID = %s', 
                    (departure, arrival, departureTime, arrivalTime, aircraftID, flightID))
    db.get_db().commit()
    return 'Success!'
  if request.method == 'DELETE':
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM Flight WHERE flightID = %s', flightID)
    db.get_db().commit()
    return 'Success!'

@flights.route('/flights/<flightID>/aircraft', methods=['GET'])
def get_flight_aircraft(flightID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Aircraft WHERE aircraftId = (SELECT aircraft from Flight WHERE flightId = %s)', flightID) 
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response