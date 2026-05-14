from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "service": "Talium Care API",
        "status": "running",
        "version": os.environ.get("APP_VERSION", "1.0.0")
    })

@app.route("/health")
def health():
    return jsonify({"status": "healthy"})

@app.route("/patients")
def patients():
    return jsonify([
        {"id": 1, "name": "John Adeyemi", "condition": "Diabetes"},
        {"id": 2, "name": "Mary Okafor", "condition": "Hypertension"},
        {"id": 3, "name": "Tovia Rapheal", "condition": "Asthma"},
    ])

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
