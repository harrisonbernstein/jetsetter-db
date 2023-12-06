from flask import Blueprint, request, jsonify, make_response
import json
from src import db

crewAssignment = Blueprint('crewassignment', __name__)

@crewAssignment.route('/crewassignment/<id>', methods=['GET', 'PUT', 'DELETE'])
def get_crew_assignment(id):
  if request.method == 'GET':
    cursor = db.get_db().cursor()
    cursor.execute('select * from CrewMemberAssignment where crewID = %s', (id,))
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
    assignmentID = data['assignmentID']
    crewID = data['crewID']
    flightId = data['flightId']
    role = data['role']
    cursor = db.get_db().cursor()
    cursor.execute('UPDATE CrewMemberAssignment SET crewID = %s, flightId = %s, role = %s WHERE assignmentID = %s', (crewID, flightId, role, assignmentID,))
    db.get_db().commit()
    return 'Success!'
  if request.method == 'DELETE':
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM CrewMemberAssignment WHERE assignmentID = %s', (id,))
    db.get_db().commit()
    return 'Success!'