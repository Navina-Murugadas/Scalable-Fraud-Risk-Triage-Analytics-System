# ai_fraud_insights_generation.py

from google import genai
import pandas as pd
import os

client = genai.Client(api_key=os.getenv("GEMINI_API_KEY"))

# -----------------------------
# Load Dataset
# -----------------------------
df = pd.read_csv("../data/raw/synthetic_financial_transactions.csv")

# -----------------------------
# Compute Key Fraud Metrics
# -----------------------------

total_transactions = len(df)

fraud_transactions = df[df["is_fraud"] == 1].shape[0]

fraud_rate = fraud_transactions / total_transactions

high_risk_transactions = df[df["risk_score"] >= 90].shape[0]

fraud_exposure = df[df["is_fraud"] == 1]["amount"].sum()

# -----------------------------
# Fraud Rate by Payment Method
# -----------------------------

payment_method_summary = (
    df.groupby("payment_method")
    .apply(lambda x: (x["is_fraud"].sum() / len(x)) * 100)
    .round(2)
    .sort_values(ascending=False)
)

payment_method_summary = payment_method_summary.to_string()

# -----------------------------
# Merchant Category Risk
# -----------------------------

merchant_category_summary = (
    df.groupby("merchant_category")
    .apply(lambda x: (x["is_fraud"].sum() / len(x)) * 100)
    .round(2)
    .sort_values(ascending=False)
)

merchant_category_summary = merchant_category_summary.to_string()

# -----------------------------
# Device Distribution
# -----------------------------

device_summary = df["device_type"].value_counts().to_string()

# -----------------------------
# Fraud Attack Patterns
# -----------------------------

attack_pattern_summary = (
    df["Fraud_Attack_Pattern"]
    .value_counts()
    .to_string()
)

# -----------------------------
# Velocity Risk
# -----------------------------

velocity_summary = df["velocity_category"].value_counts().to_string()

# -----------------------------
# Monthly Fraud Trend
# -----------------------------

df["transaction_time"] = pd.to_datetime(df["transaction_time"])

df["month"] = df["transaction_time"].dt.month_name()

monthly_trend = (
    df.groupby("month")
    .apply(lambda x: (x["is_fraud"].sum() / len(x)) * 100)
)

monthly_trend_summary = monthly_trend.to_string()

# -----------------------------
# Gemini Prompt
# -----------------------------

prompt = f"""
You are a senior fraud risk analyst reviewing financial transaction monitoring dashboards.

DATA SUMMARY

Transactions
Total Transactions: {total_transactions}
Fraud Transactions: {fraud_transactions}
Fraud Rate: {fraud_rate:.2%}
High Risk Transactions: {high_risk_transactions}
Estimated Fraud Exposure: {fraud_exposure}

Fraud Rate by Payment Method
{payment_method_summary}

Fraud Risk by Merchant Category
{merchant_category_summary}

Fraud Distribution by Device
{device_summary}

Fraud Attack Pattern Distribution
{attack_pattern_summary}

Transaction Velocity Risk Levels
{velocity_summary}

Monthly Fraud Rate Trend
{monthly_trend_summary}

TASK
Analyze the metrics and identify key fraud patterns, operational risks, and recommended mitigation actions.

OUTPUT FORMAT

KEY FRAUD INSIGHTS
──────────────────
• Insight
• Insight
• Insight

RISK DRIVERS
────────────
• Driver
• Driver
• Driver

RECOMMENDATIONS
───────────────
• Action
• Action
• Action

Rules
• Maximum 120 words
• One sentence per bullet
• Focus only on analytical insights derived from the metrics
"""

# -----------------------------
# Gemini API
# -----------------------------

client = genai.Client(api_key="YOUR_API_KEY")

response = client.models.generate_content(
    model="gemini-2.5-flash",
    contents=prompt
)

ai_text = response.text

# -----------------------------
# Output for Power BI
# -----------------------------

result = pd.DataFrame({
    "AI_Fraud_Insights": [ai_text]
})

print(result)