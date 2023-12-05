from flask import Blueprint, request, jsonify, make_response
import json
from src import db

passengers = Blueprint('passengers', __name__)

@passengers.route('/passengers', methods=['GET', 'POST'])
def get_passengers():
  if request.method == 'GET':
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Passenger')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
  if request.method == 'POST':
    data = request.json
    firstName = data['firstName']
    lastName = data['lastName']
    dateOfBirth = data['dateOfBirth']
    gender = data['gender']
    nationality = data['nationality']
    passengerId = data['passengerId']
    cursor = db.get_db().cursor()
    cursor.execute('insert into Passenger (firstName, lastName, dateOfBirth, gender, nationality, passengerId) values (%s, %s, %s, %s,%s,%s)', 
                    (firstName, lastName, dateOfBirth, gender, nationality, passengerId,))
    db.get_db().commit()
    return 'Success!'

@passengers.route('/passengers/<passengerID>', methods=['GET', 'PUT', 'DELETE'])
def get_passenger(passengerID):
  if request.method == 'GET':
    cursor = db.get_db().cursor()
    cursor.execute('select * from Passenger where passengerId = %s', (passengerID,))
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
    firstName = data['firstName']
    lastName = data['lastName']
    dateOfBirth = data['dateOfBirth']
    gender = data['gender']
    nationality = data['nationality']
    passengerId = data['passengerId']
    cursor = db.get_db().cursor()
    cursor.execute('UPDATE Passenger SET firstName = %s, lastName = %s, dateOfBirth= %s, gender= %s, nationality = %s  WHERE passengerId = %s', (firstName, lastName, dateOfBirth, gender, nationality, passengerId,))
    db.get_db().commit()
    return 'Success!'
  if request.method == 'DELETE':
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM Passenger WHERE passengerId = %s', (passengerID,))
    db.get_db().commit()
    return 'Success!'