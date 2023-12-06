from flask import Blueprint, request, jsonify, make_response
import json
from src import db
from datetime import datetime

flights = Blueprint('flights', __name__)

@flights.route('/flights', methods=['GET', 'POST'])
def get_flights():
    if request.method == 'POST':
        data = request.json
        aircraft = data['aircraft']
        destinationAirport = data['destinationAirport']
        destinationGate = data['destinationGate']
        duration = datetime.strptime(data['duration'], '%H:%M:%S').time()
        landingTime = datetime.strptime(data['landingTime'], '%Y-%m-%d %H:%M:%S')
        managerID = data['managerID']
        originAirport = data['originAirport']
        originGate = data['originGate']
        status = data['status']
        takeOffTime = datetime.strptime(data['takeOffTime'], '%Y-%m-%d %H:%M:%S')
        cursor = db.get_db().cursor()
        cursor.execute('insert into Flight (aircraft, destinationAirport, destinationGate, duration, landingTime, managerID, originAirport, originGate, status, takeOffTime) values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)', 
                        (aircraft, destinationAirport, destinationGate, duration, landingTime, managerID, originAirport, originGate, status, takeOffTime))
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
    aircraft = data['aircraft']
    destinationAirport = data['destinationAirport']
    destinationGate = data['destinationGate']
    duration = datetime.strptime(data['duration'], '%H:%M:%S').time()
    flightId = data['flightId']
    landingTime = datetime.strptime(data['landingTime'], '%Y-%m-%d %H:%M:%S')
    managerID = data['managerID']
    originAirport = data['originAirport']
    originGate = data['originGate']
    status = data['status']
    takeOffTime = datetime.strptime(data['takeOffTime'], '%Y-%m-%d %H:%M:%S')
    cursor = db.get_db().cursor()
    cursor.execute('UPDATE Flight SET aircraft = %s, destinationAirport = %s, destinationGate = %s, duration = %s, landingTime = %s, managerID = %s, originAirport = %s, originGate = %s, status = %s, takeOffTime = %s WHERE flightId = %s', 
                    (aircraft, destinationAirport, destinationGate, duration, landingTime, managerID, originAirport, originGate, status, takeOffTime, flightId))
    db.get_db().commit()
    return 'Success!'
  if request.method == 'DELETE':
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM Flight WHERE flightID = %s', flightID)
    db.get_db().commit()
    return 'Success!'

@flights.route('/flights/<flightID>/aircraft', methods=['GET', 'PUT'])
def get_flight_aircraft(flightID):
  if request.method == 'GET':
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
  if request.method == 'PUT':
    data = request.json
    aircraftID = data['aircraftID']
    capacity = data['capacity']
    model = data['model']
    cursor = db.get_db().cursor()
    cursor.execute('UPDATE Aircraft SET capacity = %s, model = %s WHERE aircraftID = %s', (capacity, model, aircraftID))
    db.get_db().commit()
    return 'Success!'