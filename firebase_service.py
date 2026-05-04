import firebase_admin
from firebase_admin import credentials, firestore

cred = credentials.Certificate("firebase_key.json")
firebase_admin.initialize_app(cred)

db = firestore.client()


def save_to_firebase(data, prediction, ai_result):

    doc = {
        "body_type": data.Body_Type,
        "sex": data.Sex,
        "diet": data.Diet,
        "transport": data.Transport,
        "carbon_emission": float(prediction),
        "ai_recommendation": str(ai_result)
    }

    db.collection("carbon_results").add(doc)