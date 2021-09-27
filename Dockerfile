# local name tensor_gpu_image:dev
# Run the following command to build the image:
# docker build --rm --tag tensor_gpu_image:dev .
FROM tensorflow/tensorflow:latest-gpu-jupyter

WORKDIR /tf/notebooks

COPY "./requirements.txt" "."

RUN cd /tf/notebooks

RUN pip install -r requirements.txt

EXPOSE 8888