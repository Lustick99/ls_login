FROM python:3.12
WORKDIR /app
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1
RUN apt-get update && apt-get install -y \
    make \
    build-essential \
    && rm -rf /var/lib/apt/lists*

RUN useradd -m myuser && chown -R myuser:myuser /app
USER myuser

RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
EXPOSE 8000
CMD [ "python","manage.py","runserver", "0.0.0.0:8000" ]