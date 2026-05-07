from fastapi import FastAPI
import pandas as pd
import joblib

from pydantic import BaseModel
from ai_service import generate_recommendation
from firebase_service import save_to_firebase
from fastapi.middleware.cors import CORSMiddleware
from ai_service import generate_recommendation

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

model = joblib.load("notebooks/carbon_model.pkl")


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


@app.get("/")
def home():
    return {"message": "API çalışıyor"}


@app.post("/predict")
def predict(data: CarbonInput):

    try:
        input_df = pd.DataFrame([data.model_dump()])

        prediction = model.predict(input_df)[0]

        LOW = 1538
        HIGH = 2768

        if prediction < LOW:
            level = "Düşük"
        elif prediction < HIGH:
            level = "Orta"
        else:
            level = "Yüksek"

        try:
            ai_recommendation = generate_recommendation(data, prediction)
        except:
            ai_recommendation = "AI unavailable"

        # Firebase'e kaydet
        save_to_firebase(data, prediction, ai_recommendation)


        return {
            "carbon_emission": float(prediction),
            "level": level,
            "ai_recommendation": ai_recommendation
        }

    except Exception as e:
        return {"error": str(e)}
 