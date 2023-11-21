import mysql.connector
import traceback
import sys
import pandas as pd
import getpass
import matplotlib.pyplot as plt
from tabulate import tabulate
from datetime import datetime, timedelta
import warnings

warnings.filterwarnings("ignore")

# Connect to MySQL database
def create_connection():
    db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="rootmysql",
    database="icu_idmp"
)
    return db


def login():
    db = create_connection()
    cursor = db.cursor(buffered=True)
    while True:
        username = input("Enter your username: ")
        password = getpass.getpass("Enter your password: ")

        query = "SELECT * FROM user WHERE username = %s AND password = %s"
        cursor.execute(query, (username, password))
        user = cursor.fetchone()

        if user:
            print("Login successful!")
            db.close()
            return user  # Return the user details (including user_type)
        else:
            print("Invalid username or password. Please try again.")
        
    

def logout():
    print("Logging out...")

# Function to handle user logout and options after logout
def handle_logout():
    logout()
    while True:
        choice = input("Do you want to login again? (y/n): ")
        if choice.lower() == 'y':
            return True
        elif choice.lower() == 'n':
            print("Exiting the application. Goodbye!")
            return False
        else:
            print("Invalid choice. Please enter 'y' or 'n'.")


def view_patient_details():
    db = create_connection()
    query = 'call view_all_patients'
    df = pd.read_sql_query(query, db)
    print(tabulate(df, headers=df.columns, tablefmt='psql'))
    db.close()
    
def view_doctor_details():
    db = create_connection()
    query = 'call view_all_doctors'
    df = pd.read_sql_query(query, db)
    print(tabulate(df, headers=df.columns, tablefmt='psql'))
    db.close()

def view_user_details():
    db = create_connection()
    query = 'call view_all_users'
    df = pd.read_sql_query(query, db)
    print(tabulate(df, headers=df.columns, tablefmt='psql'))
    db.close()


def view_caregivers():
    print('get all caregivers')

def insert():
    db = create_connection()    
    table_name = input('Enter the type of data:')
    csv_file_path = input('Enter the csv file path:')
    df = pd.read_csv(csv_file_path)
    cursor = db.cursor()
    
    # Prepare SQL INSERT statement
    insert_query = f"INSERT INTO {table_name} ({', '.join(df.columns)}) VALUES ({', '.join(['%s']*len(df.columns))})"
    values = [tuple(row) for row in df.values]
    cursor.executemany(insert_query, values)

    # Commit changes to the database
    db.commit()
    db.close()
    print(f"Inserted {len(df)} records in {table_name} table")


def update():
    db = create_connection()
    table_name = input('Enter the type of data:')
    csv_file_path = input('Enter the csv file path:')
    df = pd.read_csv(csv_file_path)
    
    cursor = db.cursor()
    primary_key = df.columns[0]
    
    for index, row in df.iterrows():
        set_values = ', '.join([f"{col} = {repr(row[col])}" for col in df.columns[1:]])
        update_query = f"UPDATE {table_name} SET {set_values} WHERE {primary_key} = {repr(row[primary_key])}"
        print(update_query)
        cursor.execute(update_query)

    db.commit()
    db.close()
    
    print(f"Upated {len(df)} records in {table_name} table")


def delete():
    db = create_connection()
    table_name = input('Enter the type of data:')
    csv_file_path = input('Enter the csv file path:')
    df = pd.read_csv(csv_file_path)

    cursor = db.cursor()
    primary_key = df.columns[0]
    to_be_deleted = ', '.join([str(x) for x in df[primary_key]])
    delete_query = f"DELETE FROM {table_name} where {primary_key} in ({to_be_deleted})"
    cursor.execute(delete_query)
    
    db.commit()
    db.close()
    print(f"Deleted {len(df)} records in {table_name} table")

def get_doctor(user):
    user_id = user[0]
    db = create_connection()
    query = f"SELECT doctor_id from Doctors where user_id={user_id}"
    cursor = db.cursor()
    cursor.execute(query)
    doctor = cursor.fetchone()
    db.close()
    return doctor

def get_doctors_patients(user):
    db = create_connection()
    doctor = get_doctor(user)
    query = f"call get_doctors_patients({doctor[0]})"
    df = pd.read_sql_query(query, db)
    print(tabulate(df, headers=df.columns, tablefmt='psql'))
    db.close()

def update_prescription(user):
    get_doctors_patients(user)
    db = create_connection()
    icu_stay_id = input('Enter the icu_stay_id of the patient:')
    query = f"select patient_condition from Prescription where icu_stay_id={icu_stay_id}"

    cursor = db.cursor()
    cursor.execute(query)
    patient_condition = cursor.fetchone()
    print(f"Patient condition - {patient_condition}")
    
    update_req = input('Want to update patient condition (y/n):')
    if update_req=='y':
        updated_prescription = input('Enter updated patient condition:')
        query = "UPDATE Prescription SET patient_condition=%s where icu_stay_id=%s"
        cursor.execute(query, (updated_prescription, icu_stay_id))
        print(f"Updated patient condition!")
    db.commit()
    db.close()


def get_available_tests():
    db = create_connection()
    query = 'select * from get_all_tests'
    df = pd.read_sql_query(query, db)
    print(tabulate(df, headers=df.columns, tablefmt='psql'))
    db.close()

def get_available_medicines():
    db = create_connection()
    query = 'select * from get_all_medicines'
    df = pd.read_sql_query(query, db)
    print(tabulate(df, headers=df.columns, tablefmt='psql'))
    db.close()

def add_or_view_lab_test(user):
    get_doctors_patients(user)
    icu_stay_id = input('Enter the icu_stay_id of the patient:')
    
    db = create_connection()
    query = f'call get_patients_labtests({icu_stay_id})'
    df = pd.read_sql_query(query, db)
    print(tabulate(df, headers=df.columns, tablefmt='psql'))
    db.close()
    
    update_req = input('Add new lab test (y/n):')
    if update_req=='y':
        db = create_connection()
        cursor = db.cursor()
        get_available_tests()
        req_test = input('Enter the test id:')
        
        current_date = datetime.now().date()
        new_date = current_date + timedelta(days=10)
        earliest_test_date = int(new_date.strftime('%Y%m%d'))
        
        prescription_query = "SELECT prescription_id from prescription where icu_stay_id=%s"
        cursor.execute(prescription_query, (icu_stay_id,))
        prescription_id = cursor.fetchone()[0]
        
        query = "INSERT prescribes (prescription_id, lab_test_id, earliest_test_by_date) values(%s, %s, %s)"
        cursor.execute(query, (prescription_id, req_test, earliest_test_date))
        db.commit()
        db.close()
        print(f"Added new test!")
    else:
        return

def view_or_prescribe_medicine(user):
    get_doctors_patients(user)
    icu_stay_id = input('Enter the icu_stay_id of the patient:')
    
    db = create_connection()
    query = f'call get_patients_medicines({icu_stay_id})'
    df = pd.read_sql_query(query, db)
    print(tabulate(df, headers=df.columns, tablefmt='psql'))
    db.close()
    
    update_req = input('Prescribe new medicine (y/n):')
    if update_req=='y':
        db = create_connection()
        cursor = db.cursor()
        get_available_medicines()
        req_med = input('Enter the medicine id:')
        
        prescription_query = "SELECT prescription_id from prescription where icu_stay_id=%s"
        cursor.execute(prescription_query, (icu_stay_id,))
        prescription_id = cursor.fetchone()[0]
        
        query = "INSERT prescription_has_medicine (prescription_id, medicine_id, dosage) values(%s, %s, %s)"
        cursor.execute(query, (prescription_id, req_med, 50))
        db.commit()
        db.close()
        print(f"Prescribed new medicine!")
    else:
        return

def find_patient_id(user_id):
    db = create_connection()
    query = "SELECT patient_id FROM Patients where user_id=%s"
    cursor = db.cursor()
    cursor.execute(query, (user_id[0],))
    result = cursor.fetchone()
    db.close()
    return result[0]


def find_the_latest_icu_stay_id(patient_id):
    db = create_connection()
    query = """ SELECT i.icu_stay_id
                FROM Admissions as a
                INNER JOIN icu_stays as i
                ON a.admission_id = i.admission_id
                WHERE a.patient_id = %s
                ORDER BY i.icu_stay_id desc
            """
    cursor = db.cursor()
    cursor.execute(query, (patient_id,))
    result = cursor.fetchone()
    db.close()
    return result[0]

def create_patient_report(user):
    if user[1]=='doctor':
        get_doctors_patients(user)
        icu_stay_id = input('Enter the ICU Stay Id of the patient:')
    if user[1]=='patient':
        patient_id = find_patient_id(user)
        icu_stay_id = find_the_latest_icu_stay_id(patient_id)
    if user[1]=='admin':
        view_all_icu_stays()
        icu_stay_id = input('Enter the ICU Stay Id of the patient:')    
    
    db = create_connection()
    cursor = db.cursor()
    args = (icu_stay_id,'','' ,'' ,'' ,'' ,'')
    results = cursor.callproc('get_patient_report', args)
    format_patient_report(results)
    
    db.close()

def format_patient_report(results):
    print("="*50)
    print(f'Doctor            : {results[1]}')
    print(f'Caregiver         : {results[2]}')
    print(f'Medicines         : {results[3]}')
    print(f'Lab Tests         : {results[4]}')
    print(f'Patient Condition : {results[5]}')
    print(f'Procedures        : {results[6]}')
    print("="*50)

def view_all_icu_stays():
    db = create_connection()
    query = """
            SELECT p.patient_id as 'Patient ID', i.icu_stay_id as 'ICU Stay ID', p.patient_name as 'Patient Name'
            FROM icu_stays as i
            INNER JOIN Admissions as a
            ON a.admission_id = i.admission_id
            INNER JOIN Patients as p
            ON p.patient_id = a.patient_id
            """
    df = pd.read_sql_query(query, db)
    print(tabulate(df, headers=df.columns, tablefmt='psql'))
    db.close()     


def view_statistics():
    print("="*50)
    db = create_connection()
    query = "SELECT get_stats();"
    cursor = db.cursor()
    cursor.execute(query)
    result = cursor.fetchone()[0]
    print(result)
    
    query_2 = "SELECT get_row_counts();"
    cursor.execute(query_2)
    result_2 = cursor.fetchone()[0]
    print(result_2)
    print("="*50)
    db.close()

def view_graph(user):
    db = create_connection()
    if user[1]=='doctor':
        get_doctors_patients(user)
        icu_stay_id = input('Enter the ICU Stay Id of the patient:')
    if user[1]=='patient':
        patient_id = find_patient_id(user)
        icu_stay_id = find_the_latest_icu_stay_id(patient_id)
    if user[1]=='admin':
        view_all_icu_stays()
        icu_stay_id = input('Enter the ICU Stay Id of the patient:')   
    
    cursor = db.cursor()
    query = "SELECT measure_value, recording_time FROM Chartevents WHERE icu_stay_id = %s ORDER BY recording_time"
    cursor.execute(query, (icu_stay_id,))
    
    result = cursor.fetchall()

    if result is None:
        print('The measurements are not recorded.')
        return
    
    # Extract measure values and recording times
    measure_values = [float(row[0]) for row in result]
    recording_times = [row[1] for row in result]

    # Convert recording_times from string to datetime objects
    recording_times = [datetime.strptime(str(time), "%Y-%m-%d %H:%M:%S") for time in recording_times]

    # Plotting the graph
    plt.figure(figsize=(10, 6))
    plt.plot(recording_times, measure_values, marker='o', linestyle='-')
    plt.title(f'Heart Rate Measurements for ICU Stay ID: {icu_stay_id}')
    plt.ylim(25, 120)
    plt.xlabel('Recording Time')
    plt.ylabel('Heart Rate')
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.show()
    
    db.close()
    

def summary():
    print('Summary Statistics')        
    
def action_1():
    print("Performing Action 1...")

def action_2():
    print("Performing Action 2...")

def action_3():
    print("Performing Action 3...")


# Function to perform actions based on user type
def perform_action(user, user_type, action_number):
    # Dictionary mapping user types to their respective actions
    user_actions = {
        'admin': {
            '1': view_patient_details,
            '2': view_doctor_details,
            '3': view_caregivers,
            '4': view_user_details,
            '5': insert,
            '6': update,
            '7': delete,
            '8': view_all_icu_stays,
            '9': create_patient_report,
            '10': view_statistics,
            '11': view_graph
        },
        'doctor': {
            '1': get_doctors_patients,
            '2': update_prescription,
            '3': add_or_view_lab_test,
            '4': view_or_prescribe_medicine,
            '5': create_patient_report,
            '6': view_graph
            # Doctor doesn't have Action 3 in this example
        },
        'patient': {
            '1': create_patient_report,
            '2': view_graph
            # Patient doesn't have Action 2 or Action 3 in this example
        }
    }

    if user_type == 'doctor' and action_number == '1':
        get_doctors_patients(user)
        return
    if user_type == 'doctor' and action_number == '2':
        update_prescription(user)
        return
    if user_type == 'doctor' and action_number == '3':
        add_or_view_lab_test(user)
        return
    if user_type == 'doctor' and action_number == '4':
        view_or_prescribe_medicine(user)
        return
    if user_type == 'doctor' and action_number == '5':
        create_patient_report(user)
        return
    if user_type == 'admin' and action_number == '9':
        create_patient_report(user)
        return
    if user_type == 'patient' and action_number == '1':
        create_patient_report(user)
        return
    if user_type == 'doctor' and action_number == '6':
        view_graph(user)
        return
    if user_type == 'admin' and action_number == '11':
        view_graph(user)
        return
    if user_type == 'patient' and action_number == '2':
        view_graph(user)
        return
    elif user_type in user_actions and action_number in user_actions[user_type]:
        user_actions[user_type][action_number]()
    else:
        print("Invalid choice for this user type.")

try:
    # Main program execution after successful login
    while True:
        user = login()
        if user:
            break
    # Extracting user type from the fetched user details
    user_type = user[1]
    
    # Main program execution after successful login
    while True:
        print("\nWelcome! Please select an option:")

        # Generate the menu based on the user type
        if user_type in ['admin', 'doctor', 'patient', 'caregiver']:
            
            user_menu_details = {
                'admin':    {'1':'View all patients', 
                            '2':'View all doctors', 
                            '3':'View all caregivers',
                            '4':'View all users',
                            '5':'Insert data',
                            '6':'Update data',
                            '7':'Delete data',
                            '8':'View icu stays',
                            '9':'View patient"s health report',
                            '10':'View summary statistics',
                            '11':'View vital sign graphs',
                            'x':'Logout'},
                'doctor':   {'1':'View my patients',
                            '2':'View and update patient condition',
                            '3':'View or add lab test',
                            '4': 'View or prescribe medicine',
                            '5':'View a patient"s health report',
                            '6':'View vital sign graphs',
                            'x':'Logout'},
                'patient': {'1':'View health report', 
                            '2':'View vital sign graphs',
                            'x':'Logout'}
            }

            for option in zip(user_menu_details[user_type].keys(), user_menu_details[user_type].values()):
                print(f"{option[0]}. {option[1]}")

            choice = input("Enter your choice: ")

            if choice == 'x':
                logout_choice = input("Are you sure you want to log out? (y/n): ")
                if logout_choice.lower() == 'y':
                    login_again = handle_logout()
                    if not login_again:
                        break
                else:
                    print("Returning to the main menu.")
            elif choice in user_menu_details[user_type].keys():
                perform_action(user, user_type, choice)
            else:
                print("Invalid choice. Please select a valid option.")
        else:
            print("Invalid user type.")
            break
except Exception as e:
    print(f'An exception has occured - {e}')
except KeyboardInterrupt as k:
    print(f'Exiting the application!')