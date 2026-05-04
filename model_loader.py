import joblib

MODEL_PATH = "notebooks/carbon_model.pkl"

def load_model():
    model = joblib.load(MODEL_PATH)
    return model