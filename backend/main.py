from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
from sklearn.datasets import load_diabetes
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error, r2_score
import joblib
import numpy as np
import os

app = FastAPI()

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Load data and train model
print("Training model...")
diabetes = load_diabetes()
X, y = diabetes.data, diabetes.target
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

model = LinearRegression()
model.fit(X_train, y_train)

# Evaluate
y_pred = model.predict(X_test)
mse = mean_squared_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)
print(f"Model trained. MSE: {mse:.2f}, R2: {r2:.2f}")

# Save model (optional, but good practice)
joblib.dump(model, "diabetes_model.pkl")

class PredictionRequest(BaseModel):
    age: float
    sex: float
    bmi: float
    bp: float
    s1: float
    s2: float
    s3: float
    s4: float
    s5: float
    s6: float

@app.get("/")
def read_root():
    return {"message": "Diabetes Prediction API is running", "model_metrics": {"mse": mse, "r2": r2}}

@app.post("/predict")
def predict(request: PredictionRequest):
    # Prepare features
    # Note: The sklearn dataset features are already scaled/normalized. 
    # For a REAL user input app, we would need to scale the raw inputs similarly to how the dataset was scaled.
    # HOWEVER, the sklearn load_diabetes return scaled data by default.
    # To make this usable with 'real' numbers (e.g. BMI 25, Age 50), we should probably train on the UN-SCALED version if possible, 
    # or implement a scaler. 
    # load_diabetes(scaled=False) is safer for real inputs.
    
    features = np.array([[
        request.age, request.sex, request.bmi, request.bp, 
        request.s1, request.s2, request.s3, request.s4, request.s5, request.s6
    ]])
    
    prediction = model.predict(features)
    return {"prediction": prediction[0]}

# Re-train with scaled=False to be more user-friendly with inputs ?
# Yes, let's do that for the 'Real' feeling.
print("Re-training with unscaled data for clearer user inputs...")
diabetes_unscaled = load_diabetes(scaled=False)
X_u, y_u = diabetes_unscaled.data, diabetes_unscaled.target
X_train_u, X_test_u, y_train_u, y_test_u = train_test_split(X_u, y_u, test_size=0.2, random_state=42)

model = LinearRegression()
model.fit(X_train_u, y_train_u)

y_pred_u = model.predict(X_test_u)
mse_u = mean_squared_error(y_test_u, y_pred_u)
r2_u = r2_score(y_test_u, y_pred_u)
print(f"Unscaled Model trained. MSE: {mse_u:.2f}, R2: {r2_u:.2f}")
joblib.dump(model, "diabetes_model_unscaled.pkl")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
