from flask import Flask, render_template, request, redirect
from pymongo import MongoClient

app = Flask(__name__)

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")
db = client["survey_db"]
collection = db["user_data"]


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/submit", methods=["POST"])
def submit():
    if request.method == "POST":
        first_name = request.form["first_name"]
        last_name = request.form["last_name"]
        age = int(request.form["age"])
        gender = request.form["gender"]
        race = request.form["race"]
        income = int(request.form["income"])

        # Initialize expenses dictionary
        expenses = {}

        # Check which expenses are selected and add them to the expenses dictionary
        if "utilities_checkbox" in request.form:
            expenses["utilities"] = (
                int(request.form["utilities_amount"])
                if request.form["utilities_amount"]
                else 0
            )

        if "entertainment_checkbox" in request.form:
            expenses["entertainment"] = (
                int(request.form["entertainment_amount"])
                if request.form["entertainment_amount"]
                else 0
            )

        if "school_fees_checkbox" in request.form:
            expenses["school_fees"] = (
                int(request.form["school_fees_amount"])
                if request.form["school_fees_amount"]
                else 0
            )

        if "shopping_checkbox" in request.form:
            expenses["shopping"] = (
                int(request.form["shopping_amount"])
                if request.form["shopping_amount"]
                else 0
            )

        if "healthcare_checkbox" in request.form:
            expenses["healthcare"] = (
                int(request.form["healthcare_amount"])
                if request.form["healthcare_amount"]
                else 0
            )

        # Insert into MongoDB
        collection.insert_one(
            {
                "first_name": first_name,
                "last_name": last_name,
                "age": age,
                "gender": gender,
                "race": race,
                "income": income,
                "expenses": expenses,
            }
        )

        return redirect("/")


if __name__ == "__main__":
    app.run(debug=True)
