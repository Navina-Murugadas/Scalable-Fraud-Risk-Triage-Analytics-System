# Scalable Fraud Risk Triage & Analytics System

An end-to-end fraud analytics project that simulates how modern fintech and payment platforms detect suspicious transactions, prioritize high-risk cases, and generate fraud intelligence using analytics dashboards and AI insights.

---

## Project Overview

Financial fraud is a persistent challenge for digital payment platforms and e-commerce ecosystems. As transaction volumes increase, organizations require scalable analytics systems capable of identifying suspicious behavior, prioritizing high-risk transactions, and supporting fraud investigation workflows.

This project builds a **Scalable Fraud Risk Triage & Analytics System** that analyzes transaction data, evaluates fraud indicators, and visualizes fraud patterns through interactive dashboards.

The system integrates:

- SQL-based fraud analytics
- Python data processing
- Power BI monitoring dashboards
- Generative AI fraud intelligence

Together these components simulate how modern fraud monitoring systems operate within financial platforms.

---

## System Architecture


The analytics pipeline processes financial transaction data through multiple stages including data modeling, fraud risk scoring, dashboard visualization, and AI-driven insights.

<img width="1024" height="1536" alt="fraud_risk_analytics_architecture" src="https://github.com/user-attachments/assets/fcdac11a-8d67-467e-aa86-417866e739f8" />

Pipeline Flow:
Synthetic Transaction Data --> SQL Fraud Analytics --> Fraud Risk Feature Engineering --> Power BI Monitoring Dashboards --> Python + Gemini AI Fraud Intelligence

---

## Data Model

The project uses a relational data model linking users, transactions, and chargebacks to simulate fraud monitoring datasets.

<img width="1182" height="728" alt="fraud_data_model" src="https://github.com/user-attachments/assets/b2f3ac03-daca-4c5b-8866-30fb3934af05" />


Core datasets include:

| Table | Description |
|------|-------------|
| **Users** | Customer profiles and behavioral attributes |
| **Transactions** | Financial transaction records |
| **Chargebacks** | Confirmed fraud or dispute events |
| **Fraud Risk Scores (View)** | Derived fraud indicators and risk scoring |

---

## Fraud Analytics Workflow

The analytics pipeline processes financial transactions through several stages.

### 1. Data Processing (SQL)

SQL transformations generate fraud indicators including:

- Transaction velocity
- Prior chargeback behavior
- Geographic risk exposure
- Merchant category risk
- Device-based fraud indicators

These features are aggregated into fraud risk scores.

---

### 2. Fraud Monitoring Dashboards

Power BI dashboards simulate operational fraud monitoring systems used by payment platforms.

Key dashboards include:

**Fraud Risk Overview**

- Total transactions
- Fraud rate trends
- Geographic fraud distribution
- Payment method risk analysis
- Risk score distribution

**Fraud Investigation Dashboard**

- High-risk transaction investigation queue
- Fraud attack pattern detection
- Device risk distribution
- Transaction velocity analysis

**AI Fraud Intelligence Dashboard**

- Fraud exposure analysis
- Risk concentration indicators
- AI-generated fraud insights
- Recommended mitigation strategies

---

## Fraud Detection Logic

The system identifies suspicious activity using several fraud indicators.

| Indicator | Description |
|----------|-------------|
| **Transaction Velocity** | High number of transactions within short time intervals |
| **Prior Chargebacks** | Users with historical fraud activity |
| **High-Risk Payment Methods** | Payment channels with elevated fraud exposure |
| **Merchant Category Risk** | Merchant segments vulnerable to fraud |
| **Geographic Risk** | Cross-border or high-risk regions |

Transactions exceeding risk thresholds are prioritized in the investigation queue.

---

## Key Insights

Analysis of the transaction dataset reveals several notable fraud patterns.

- Cryptocurrency payments demonstrate the highest fraud exposure among payment methods.
- Fraud activity shows noticeable spikes during specific periods, suggesting coordinated attack behavior.
- Luxury goods merchants exhibit the highest fraud risk among merchant categories.
- Mobile devices account for the majority of suspicious transaction activity.

These insights highlight areas where fraud monitoring controls should be strengthened.

---

## AI-Powered Fraud Intelligence

To enhance analytical capabilities, the system integrates **Generative AI using the Gemini API**.

The AI component analyzes fraud metrics and produces structured outputs including:

- Key fraud insights
- Risk drivers
- Fraud mitigation recommendations

Example output:<br>
<img width="650" height="360" alt="image" src="https://github.com/user-attachments/assets/1873c020-e530-4f73-9365-fe1843aeaf15" />


This demonstrates how generative AI can assist fraud analysts by automatically summarizing complex fraud datasets.

---

## Technology Stack

| Technology | Purpose |
|------------|--------|
| **SQL Server** | Data modeling and fraud analytics |
| **Python** | Data analysis and AI integration |
| **Jupyter Notebook** | Exploratory analysis |
| **Power BI** | Fraud monitoring dashboards |
| **Gemini API** | AI-generated fraud insights |

---

## Repository Structure

<img width="688" height="893" alt="image" src="https://github.com/user-attachments/assets/0644032c-9bd4-4742-927b-6912c2b2deb7" />

---

## Project Report

A detailed case study describing the fraud analytics workflow and insights is available below.

📄 **[Download the Project Report](fraud-risk-triage-analytics-system/reports/fraud_risk_analytics_case_study.pdf)**

---

## Conclusion

The **Scalable Fraud Risk Triage & Analytics System** demonstrates how modern analytics workflows can support fraud detection and investigation processes.

By integrating SQL-based fraud analytics, interactive dashboards, and AI-driven intelligence, the system enables organizations to:

- Detect fraud patterns
- Prioritize high-risk transactions
- Accelerate fraud investigation workflows

This project illustrates how **data analytics, business intelligence, and generative AI** can be combined to build scalable fraud risk intelligence systems used by modern fintech platforms.

---

## Author

**Navina M**  
Risk & Data Analytics Professional  
Fraud Analytics | Trust & Safety | Business Intelligence

LinkedIn: [Navina M](https://www.linkedin.com/in/navina-m/) 

