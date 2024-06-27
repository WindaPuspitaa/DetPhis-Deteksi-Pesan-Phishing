from flask import Flask, request, jsonify
import re
import nltk
from nltk.corpus import stopwords
from nltk.stem import PorterStemmer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import MultinomialNB
from sklearn.pipeline import make_pipeline
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
import pandas as pd

nltk.download('stopwords')

app = Flask(__name__)

# Baca dataset dari CSV
df = pd.read_csv('dataset/phishing_dataset_3.csv')
texts = df['Teks'].tolist()
labels = df['Label'].tolist()

# Preprocessing
stemmer = PorterStemmer()
stop_words = set(stopwords.words('indonesian'))

def preprocess_text(text):
    text = re.sub(r'[^\w\s]', '', text)
    text = text.lower()
    words = text.split()
    words = [stemmer.stem(word) for word in words if word not in stop_words]
    text = ' '.join(words)
    return text

# Membuat model Naive Bayes
X_train, X_test, y_train, y_test = train_test_split(texts, labels, test_size=0.3, random_state=42)
model = make_pipeline(TfidfVectorizer(), MultinomialNB())
model.fit([preprocess_text(text) for text in X_train], y_train)

# Evaluasi model
y_pred = model.predict([preprocess_text(text) for text in X_test])
accuracy = accuracy_score(y_test, y_pred)
precision = precision_score(y_test, y_pred, pos_label='phishing')
recall = recall_score(y_test, y_pred, pos_label='phishing')
f1 = f1_score(y_test, y_pred, pos_label='phishing')

@app.route('/api', methods=['GET'])
def classify_text():
    try:
        text = request.args['query']
    except KeyError:
        return jsonify({'error': 'Parameter "query" tidak ditemukan'}), 400

    text = preprocess_text(text)
    prediction = model.predict([text])[0]
    probabilities = model.predict_proba([text])[0]

    phishing_prob = probabilities[1]  
    non_phishing_prob = probabilities[0]  

    label = "Phishing" if prediction == "phishing" else "Non-phishing"
    return jsonify({
        'output': label,
        'phishing_probability': phishing_prob,
        'non_phishing_probability': non_phishing_prob
    })

@app.route('/api/accuracy', methods=['GET'])
def get_accuracy():
    return jsonify({'accuracy': accuracy})

@app.route('/api/evaluate', methods=['GET'])
def evaluate_model():
    return jsonify({
        'accuracy': accuracy,
        'precision': precision,
        'recall': recall,
        'f1_score': f1
    })

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)
