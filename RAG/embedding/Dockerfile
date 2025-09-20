FROM python:3.9-slim

WORKDIR /app

COPY app.py .
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt 

ENV PORT=5000

EXPOSE $PORT

CMD ["sh", "-c", "uvicorn app:app --host 0.0.0.0 --port $PORT"]