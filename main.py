from fastapi import FastAPI
import pandas as pd
import joblib

from pydantic import BaseModel
from ai_service import generate_recommendation
from firebase_service import save_to_firebase
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ML model yükleme
model = joblib.load("notebooks/carbon_model.pkl")


# INPUT Şema
class CarbonInput(BaseModel):
    Body_Type: str
    Sex: str
    Diet: str
    How_Often_Shower: str
    Heating_Energy_Source: str
    Transport: str
    Social_Activity: str
    Frequency_of_Traveling_by_Air: str
    Waste_Bag_Size: str
    Energy_efficiency: str
    Monthly_Grocery_Bill: float
    Vehicle_Monthly_Distance_Km: float
    Waste_Bag_Weekly_Count: float
    How_Long_TV_PC_Daily_Hour: float
    How_Long_Internet_Daily_Hour: float
    How_Many_New_Clothes_Monthly: float


# TEST ENDPOINT
@app.get("/")
def home():
    return {"message": "API çalışıyor"}


# PREDICT ENDPOINT
@app.post("/predict")
def predict(data: CarbonInput):

    try:
        # Gelen veriyi DataFrame yap
        input_df = pd.DataFrame([data.model_dump()])

        # Tahmin yap
        prediction = model.predict(input_df)[0]

        # Karbon seviyesi
        LOW = 1538
        HIGH = 2768

        if prediction < LOW:
            level = "Düşük"

        elif prediction < HIGH:
            level = "Orta"

        else:
            level = "Yüksek"

        # AI önerileri
        try:
            ai_recommendation = generate_recommendation(
                data,
                prediction
            )

        except Exception as ai_error:
            print("AI ERROR:", ai_error)
            ai_recommendation = [
                "AI önerisi oluşturulamadı"
            ]

        # Firebase kayıt
        try:
            save_to_firebase(
                data,
                prediction,
                ai_recommendation
            )

        except Exception as firebase_error:
            print("FIREBASE ERROR:", firebase_error)

        return {
            "carbon_emission": float(prediction),
            "level": level,
            "ai_recommendation": ai_recommendation
        }

    except Exception as e:
        return {
            "error": str(e)
        }
