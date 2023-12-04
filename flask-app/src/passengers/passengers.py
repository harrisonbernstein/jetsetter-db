from flask import Blueprint, request, jsonify, make_response
import json
from src import db

passengers = Blueprint('passengers', __name__)

@passengers.route('/passengers', methods=['GET'])
def get_passengers():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Passenger')
    passengers = cursor.fetchall()
    return jsonify(passengers)

@passengers.route('/passengers/<passengerID>', methods=['GET'])
def get_passenger(passengerID):
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