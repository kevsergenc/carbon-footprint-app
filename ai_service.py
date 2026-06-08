from groq import Groq
import os
from dotenv import load_dotenv

load_dotenv()

client = Groq(api_key=os.getenv("GROQ_API_KEY"))



# SAFETY FILTER

def is_valid(text):
    text = text.lower()

    bad_words = [
    "random",
    "uydurma",
    "error"
    ]

    if any(word in text for word in bad_words):
        return False

    valid_keywords = [
        "toplu", "bisiklet", "yürüyüş",
        "enerji", "led", "geri dönüşüm",
        "et", "uçak", "tüketim"
    ]

    return any(k in text for k in valid_keywords)



# CLEAN FUNCTION

def clean_line(line):
    line = line.strip()

    if ":" in line:
        line = line.split(":", 1)[1].strip()

    return line.lstrip("- ").strip()



# MAIN FUNCTION

def generate_recommendation(data, carbon_score):

    prompt = f"""
Sen bir çevre bilimleri uzmanısın.

KURALLAR:
- SADECE karbonu azaltan gerçek öneriler yaz
- ASLA açıklama yazma
- Türkçe yaz
- 5 öneri üret
- Her öneri farklı kategoriye ait olmalı
- yaptığın önerileri 'yapabilirsin' gibi bir dil ile söyle
- azaltması ya da arttırması gereken alışkanlıkların yerine ne önerdiğini de söyle
- Karbon skoru yüksekse daha güçlü azaltım önerileri ver
- Karbon skoru düşükse mevcut alışkanlıkları korumaya yönelik öneriler ver

KARBON SKORU:
{carbon_score}


KULLANICI VERİSİ:
- Ulaşım: {data.Transport}
- Aylık km: {data.Vehicle_Monthly_Distance_Km}
- Enerji: {data.Heating_Energy_Source}
- Diyet: {data.Diet}
- Uçuş: {data.Frequency_of_Traveling_by_Air}
- Atık: {data.Waste_Bag_Weekly_Count}
- Dijital: {data.How_Long_Internet_Daily_Hour}

FORMAT:
- Ulaşım
-Aylık araç kilometresi
- Enerji
- Beslenme
-Uçağa binme sıklığı
- Atık
- Dijital

Şimdi yaz:
"""

    try:
        response = client.chat.completions.create(
            model="llama-3.1-8b-instant",
            messages=[
                {"role": "user", "content": prompt}
            ],
            temperature=0.2  #daha temiz sonuç
        )

        text = response.choices[0].message.content

        recommendations = []

        for line in text.split("\n"):
            if not line.strip():
                continue

            clean = clean_line(line)

            # çok uzun cümleleri at
            if len(clean.split()) > 12:
                continue

            if len(clean) < 10:
                continue

            if not is_valid(clean):
                continue

            recommendations.append(clean)

        # yeterli sonuç varsa
        if len(recommendations) >= 5:
            return recommendations[:5]

        # fallback (garanti güvenli)
        fallback = [
            "Toplu taşıma kullanımını artırabilirsin",
            "LED ampullerle enerji tasarrufu yapabilirsin",
            "Et tüketimini azaltabilirsin",
            "Geri dönüşümü düzenli yapabilirsin",
            "Kısa mesafelerde yürüyüş veya bisiklet kullanabilirsin"
        ]

        return (recommendations + fallback)[:5]

    except Exception as e:
        print("GROQ ERROR:", e)

        return [
            "Enerji tasarrufu yap",
            "Toplu taşıma kullan",
            "Et tüketimini azalt",
            "Geri dönüşüm yap",
            "Dijital tüketimi azalt"
        ]
