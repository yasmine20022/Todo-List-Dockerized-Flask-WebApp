FROM python:3.9-slim-bullseye

LABEL Maintainer_Name="Ahmed Ayman" Maintainer_Email="a.ayman6000@gmail.com" 

WORKDIR /

ENV FLASK_APP app.py
ENV FLASK_ENV development

COPY ./requirements.txt /requirements.txt

RUN apt-get update && apt-get install -y --no-install-recommends build-essential && rm -rf /var/lib/apt/lists/*
RUN pip3 install --no-cache-dir -r requirements.txt

RUN mkdir app
WORKDIR /app

COPY . .

RUN groupadd -r appuser && useradd -r -g appuser -G appuser -m -d /app -s /sbin/nologin -c "Docker appuser" appuser
USER appuser

CMD python3 app.py