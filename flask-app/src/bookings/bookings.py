from flask import Blueprint, request, jsonify, make_response
import json
from src import db

bookings = Blueprint('bookings', __name__)

# Get all customers from the DB
@bookings.route('/bookings', methods=['GET'])
def get_bookings():
    cursor = db.get_db().cursor()
    cursor.execute('select * from bookings')
    bookings = cursor.fetchall()
    return jsonify(bookings)