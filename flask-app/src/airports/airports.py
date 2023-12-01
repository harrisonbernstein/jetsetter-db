from flask import Blueprint, request, jsonify, make_response
import json
from src import db

airports = Blueprint('airports', __name__)

# Get all bookings from the DB
@airports.route('/airports', methods=['GET'])
def get_airports():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Airport')
    json_data = []
    column_headers = [x[0] for x in cursor.description]
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))   
    return jsonify(json_data)

@airports.route('/airports/<id>', methods=['GET'])
def get_airports_by_id(id):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Airport WHERE IATAcode = %s', (id,))
    json_data = []
    column_headers = [x[0] for x in cursor.description]
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))   
    return jsonify(json_data)