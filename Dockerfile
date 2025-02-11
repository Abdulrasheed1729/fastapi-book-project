FROM nginx:1.13-alpine

# Disable nginx welcome page
# RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.disabled

# Copy nginx conf from Render secret named `nginx.conf`
COPY nginx.conf /etc/nginx/sites-available/default

# Test config
CMD service nginx start

FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

EXPOSE 80

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload", "--proxy-headers"]