from flask import Blueprint, request, jsonify, make_response
import json
from src import db

gates = Blueprint('gates', __name__)

# get gate from given IATA code
@gates.route('/gates/<code>', methods=['GET'])
def get_gate_by_code(code):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM AirportGate WHERE IATAcode = %s', (code,))
    json_data = []
    column_headers = [x[0] for x in cursor.description]
    theData = cursor.fetchall()
    for row in theData:
        json_data = (dict(zip(column_headers, row)))   
    return jsonify(json_data)