FROM python:3.8

MAINTAINER smoke

RUN useradd --create-home userapi
WORKDIR /films_api

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY ./ .

RUN chown -R userapi:userapi ./
USER userapi

EXPOSE 5001
CMD gunicorn --bind 0.0.0.0:5001 wsgi:app