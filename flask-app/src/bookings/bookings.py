from flask import Blueprint, request, jsonify, make_response
import json
from src import db

bookings = Blueprint('bookings', __name__)

# Get all customers from the DB
@bookings.route('/bookings', methods=['GET'])
def get_bookings():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Booking')
    json_data = []
    column_headers = [x[0] for x in cursor.description]
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))   
    return jsonify(json_data)