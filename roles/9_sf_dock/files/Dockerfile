FROM python:3.8-alpine3.13
WORKDIR /srv/app/
RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev && pip install --upgrade pip && pip install --no-cache-dir flask psycopg2 configparser
COPY ./DEVOPS-praktikum_Docker/web.py ./
COPY ./DEVOPS-praktikum_Docker/web.conf  ./conf/
CMD [ "python", "./web.py" ]
