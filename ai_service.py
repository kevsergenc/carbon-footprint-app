import requests
import os
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv("HF_API_KEY")

API_URL = "https://api-inference.huggingface.co/models/google/flan-t5-large"

headers = {
    "Authorization": f"Bearer {API_KEY}"
}


def generate_recommendation(data, carbon_score):

    prompt = f"""
You are a sustainability expert.

User data:
Transport: {data.Transport}
Diet: {data.Diet}
Energy: {data.Heating_Energy_Source}

Carbon score: {carbon_score}

Give 5 short Turkish recommendations.
"""

    try:
        response = requests.post(
            API_URL,
            headers=headers,
            json={"inputs": prompt}
        )

        result = response.json()

        text = result[0]["generated_text"] if isinstance(result, list) else str(result)

        return text.split("\n")[:5]

    except Exception as e:
        print("AI ERROR:", e)

        # fallback 
        return [
            "Enerji tasarrufu yap",
            "Toplu taşıma kullan",
            "Et tüketimini azalt",
            "Geri dönüşüm yap",
            "Dijital tüketimi azalt"
        ]