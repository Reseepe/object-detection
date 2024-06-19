FROM tiangolo/uvicorn-gunicorn:python3.9-slim

ENV WORKERS_PER_CORE=4 
ENV MAX_WORKERS=24
ENV LOG_LEVEL="warning"
ENV TIMEOUT="200"

# RUN mkdir /resepee-yoloV5-FastAPI

WORKDIR /resepee-yoloV5-FastAPI

COPY requirements.txt /resepee-yoloV5-FastAPI

COPY . /resepee-yoloV5-FastAPI

RUN apt-get update && apt-get install -y libglib2.0-0 libsm6 libxrender1 libxext6

RUN apt-get update && apt-get install -y libgl1-mesa-glx

RUN pip install torch==2.3.1 torchvision==0.18.1 -f https://download.pytorch.org/whl/torch_stable.html

RUN pip install -r requirements.txt

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]