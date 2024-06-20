FROM tiangolo/uvicorn-gunicorn:python3.9-slim

ENV WORKERS_PER_CORE=4 
ENV MAX_WORKERS=24
ENV LOG_LEVEL="warning"
ENV TIMEOUT="200"

# RUN mkdir /resepee-yoloV5-FastAPI

WORKDIR /resepee-yoloV5-FastAPI

COPY requirements.txt /resepee-yoloV5-FastAPI

COPY . /resepee-yoloV5-FastAPI

# https://stackoverflow.com/questions/55313610/importerror-libgl-so-1-cannot-open-shared-object-file-no-such-file-or-directo
RUN apt-get update && apt-get install -y libglib2.0-0 libsm6 libxrender1 libxext6
RUN apt-get update && apt-get install -y libgl1-mesa-glx

# CPU-ONLY
RUN pip install torch==2.3.1+cpu torchvision==0.18.1+cpu -f https://download.pytorch.org/whl/torch_stable.html

# GPU
# RUN pip install torch==2.3.1 torchvision==0.18.1 -f https://download.pytorch.org/whl/torch_stable.html

RUN pip install -r requirements.txt

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
