FROM python:3.7-slim-stretch

RUN apt-get update && apt-get install -y git python3-dev gcc \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN apt-get update && apt-get install -y \
	wget \
	unzip \
	git
	
RUN apt-get install libsm6 libxrender1 libfontconfig1
RUN python3 -m pip install opencv-contrib-python
RUN pip install --upgrade -r requirements.txt

COPY app app/

RUN python app/server.py

EXPOSE 5000

CMD ["python", "app/server.py", "serve"]
