FROM python:3.8.0

ENV PYTHONPATH=.

WORKDIR /usr/src/app

ADD requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["pytest", "tests/unit"]
