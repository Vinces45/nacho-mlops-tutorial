FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /code

# Copiar e instalar dependencias desde tu archivo
COPY requirements.txt /code/
RUN python -m pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copiar tu carpeta de código real
COPY ./src ./src

# Ejecutar tu script
CMD ["python", "src/main.py"]