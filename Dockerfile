FROM python:3.10-slim

WORKDIR /app
COPY . /app

RUN apt-get update && apt-get install -y sqlite3
RUN pip install --no-cache-dir -r requirements.txt
RUN test -f quiz.db || sqlite3 quiz.db < quiz.sql
RUN python adduser.py

EXPOSE 8080

ENV FLASK_APP=softdes.py

CMD ["flask", "run", "--host=0.0.0.0", "--port=8080"]

VOLUME ["/app/quiz.db"]
