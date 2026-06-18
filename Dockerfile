FROM python:3.9-slim-bullseye

LABEL Maintainer_Name="Ahmed Ayman" Maintainer_Email="a.ayman6000@gmail.com" 

WORKDIR /

ENV FLASK_APP app.py
ENV FLASK_ENV development

COPY ./requirements.txt /requirements.txt

RUN apt-get update && apt-get install -y --no-install-recommends build-essential && rm -rf /var/lib/apt/lists/*
RUN pip3 install -r requirements.txt

RUN mkdir app
WORKDIR /app

COPY . .

RUN groupadd -r app && useradd -r -g app -G app -m -d /app -s /sbin/nologin -c "app user" app
USER app

CMD python3 app.py