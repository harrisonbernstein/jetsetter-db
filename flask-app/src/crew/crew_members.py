from flask import Blueprint, request, jsonify, make_response
import json
from src import db

crew_members = Blueprint('crew_members', __name__)

# get all crew members
@crew_members.route('/crew-members', methods=['GET'])
def get_crew_members():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM CrewMember')
    json_data = []
    column_headers = [x[0] for x in cursor.description]
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))   
    return jsonify(json_data)

# get crew member info from given ID
@crew_members.route('/crew-members/<id>', methods=['GET'])
def get_crew_member_by_id(id):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM CrewMember WHERE crewId = %s', (id,))
    json_data = []
    column_headers = [x[0] for x in cursor.description]
    theData = cursor.fetchall()
    for row in theData:
        json_data = (dict(zip(column_headers, row)))   
    return jsonify(json_data)

# Add new crew member to the database
@crew_members.route('/crew-members', methods=['POST'])
def add_new_crew_member():
    data = request.json
    first_name = data['firstName']
    last_name = data['lastName']
    weekly_hours_worked = data['weeklyHoursWorked']
    time_taken_off = data['timeTakenOff']
    cursor = db.get_db().cursor()
    cursor.execute('insert into CrewMember (firstName, lastName, weeklyHoursWorked, timeTakenOff) values (%s, %s, %s, %s)', 
                   (first_name, last_name, weekly_hours_worked, time_taken_off))
    db.get_db().commit()
    return 'Success!'

# Update info about the given crew member
@crew_members.route('/crew-members/<id>', methods=['PUT'])
def update_crew_member(id):
    data = request.json
    first_name = data['crew_member_first_name']
    last_name = data['crew_member_last_name']
    weekly_hours_worked = data['crew_member_weekly_hours_worked']
    time_taken_off = data['crew_member_time_taken_off']
    if not first_name and not last_name and not weekly_hours_worked and not time_taken_off:
        return 'No fields provided for update', 400
    query = 'UPDATE CrewMember SET'
    params = []
    if first_name:
        query += ' firstName = %s,'
        params.append(first_name)
    if last_name:
        query += ' lastName = %s,'
        params.append(last_name)
    if weekly_hours_worked:
        query += ' weeklyHoursWorked = %s,'
        params.append(weekly_hours_worked)
    if time_taken_off:
        query += ' timeTakenOff = %s,'
        params.append(time_taken_off)
    query = query.rstrip(',') + ' WHERE crewId = %s'
    params.append(id)
    cursor = db.get_db().cursor()
    cursor.execute(query, tuple(params))
    db.get_db().commit()
    return 'Success!'

# Delete the given crew member
@crew_members.route('/crew-members/<id>', methods=['DELETE'])
def delete_crew_memnber(id):
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM CrewMember WHERE crewId = %s', (id,))
    db.get_db().commit()
    return 'Success!'