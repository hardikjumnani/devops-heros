FROM python:3.11-slim

WORKDIR /app

# python:3.11-slim already ships Python and pip - installing them again via apt
# (as the original Dockerfile did) is unnecessary and inflates the image.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

EXPOSE 5000
CMD ["python", "app.py"]
