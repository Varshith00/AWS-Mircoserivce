FROM python:3.11-slim

RUN mkdir -p /app
COPY main.py /app/
WORKDIR /app
# 1️⃣ Copy requirements first
COPY requirements.txt .

# 2️⃣ Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 3️⃣ Copy application code
COPY . .
RUN python -m textblob.download_corpora

EXPOSE 8080

CMD ["main.py"]
ENTRYPOINT ["python"]
