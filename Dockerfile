FROM python:3.7-slim-stretch

RUN apt-get update && apt-get install -y git python3-dev gcc \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN apt-get update && apt-get install -y \
	wget \
	unzip \
	git
RUN pip install opencv-python
RUN apt update && apt install -y libsm6 libxext6
RUN apt-get install -y libxrender-dev

RUN pip install --upgrade -r requirements.txt

COPY app app/

RUN python app/server.py

EXPOSE 5000

CMD ["python", "app/server.py", "serve"]
