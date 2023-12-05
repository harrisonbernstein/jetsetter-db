from flask import Blueprint, request, jsonify, make_response
import json
from src import db

billings = Blueprint('billings', __name__)

# get all billings
@billings.route('/billings', methods=['GET'])
def get_billings():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Billing')
    json_data = []
    column_headers = [x[0] for x in cursor.description]
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))   
    return jsonify(json_data)

# get billing info from given ID
@billings.route('/billings/<id>', methods=['GET'])
def get_billing_by_id(id):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Billing WHERE billingId = %s', (id,))
    json_data = []
    column_headers = [x[0] for x in cursor.description]
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))   
    return jsonify(json_data)

# Add new billing to the database
@billings.route('/billings', methods=['POST'])
def add_new_billing():
    data = request.json
    total_amount = data['billing_total_amount']
    payment_status = data['billing_payment_status']
    payment_method = data['billing_payment_method']
    booking_id = data['billing_booking_id']
    cursor = db.get_db().cursor()
    cursor.execute('insert into Billing (totalAmount, paymentStatus, paymentMethod, bookingId) values (%s, %s, %s, %s)', 
                   (total_amount, payment_status, payment_method, booking_id))
    db.get_db().commit()
    return 'Success!'

# Update info about the given billing
@billings.route('/billings/<id>', methods=['PUT'])
def update_billing(id):
    data = request.json
    total_amount = data['billing_total_amount']
    payment_status = data['billing_payment_status']
    payment_method = data['billing_payment_method']
    booking_id = data['billing_booking_id']
    if not total_amount and not payment_status and not payment_method and not booking_id:
        return 'No fields provided for update', 400
    query = 'UPDATE Billing SET'
    params = []
    if total_amount:
        query += ' totalAmount = %s,'
        params.append(total_amount)
    if payment_status:
        query += ' paymentStatus = %s,'
        params.append(payment_status)
    if payment_method:
        query += ' paymentMethod = %s,'
        params.append(payment_method)
    if booking_id:
        query += ' bookingId = %s,'
        params.append(booking_id)
    query = query.rstrip(',') + ' WHERE billingId = %s'
    params.append(id)
    cursor = db.get_db().cursor()
    cursor.execute(query, tuple(params))
    db.get_db().commit()
    return 'Success!'