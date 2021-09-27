# GPU TensorFlow

[Nvidia docker 2 installation guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)

check the nvidia-container-toolkit is installed correctly.

```sh
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
```

install image

```sh
docker pull tensorflow/tensorflow:latest-gpu-jupyter
```

list image

```sh
docker image ls -a
```

run image with jupyter notebook

```sh
docker run -it -p 8888:8888 tensorflow/tensorflow:latest-gpu-jupyter
```

See containers status

```sh
sudo docker container ls
```

Restart docker container

```sh
docker restart container
```

Mount in current folder

```sh
docker run --rm -it -p 8888:8888 -v $(pwd):/usr/src/project tensorflow/tensorflow:latest-gpu-jupyter
```

## Troubleshooting

[Tensor flow doesnt detect my gpu problem](https://stackoverflow.com/questions/63122486/the-tensorflow-docker-gpu-image-doesnt-detect-my-gpu)

[Docker GPU tensorflow](https://www.tensorflow.org/install/docker)

## Cleaning up the command

`-it` interactive console

`--rm` remove the file system where the container exists

Entorno que usa gpus

```sh
docker run -it --rm -u $(id -u):$(id -g) --name tensor_gpu --gpus all -p 8888:8888 tensorflow/tensorflow:latest-gpu-jupyter jupyter notebook --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.allow_origin='https://colab.research.google.com'
```

conectarme por consola al entorno

```sh
docker exec -it tensor_gpu bash
```

tensorflow message

```sh
________                               _______________                
___  __/__________________________________  ____/__  /________      __
__  /  _  _ \_  __ \_  ___/  __ \_  ___/_  /_   __  /_  __ \_ | /| / /
_  /   /  __/  / / /(__  )/ /_/ /  /   _  __/   _  / / /_/ /_ |/ |/ / 
/_/    \___//_/ /_//____/ \____//_/    /_/      /_/  \____/____/|__/


WARNING: You are running this container as root, which can cause new files in
mounted volumes to be created as the root user on your host machine.

To avoid this, run the container by specifying your user's userid:

$ docker run -u $(id -u):$(id -g) args...
```

Container main folder `/tf`

local path `/home/luis/Documents/personal_projects/tensor_flow_gpu/docker_mount`

Comando final con volumenes

```sh
docker run -it --rm -u $(id -u):$(id -g) --name tensor_gpu --gpus all -p 8888:8888 -v /home/luis/Documents/personal_projects/tensor_flow_gpu/docker_mount:/tf/notebooks tensorflow/tensorflow:latest-gpu-jupyter jupyter notebook --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.allow_origin='https://colab.research.google.com'
```

sin rm

```sh
docker run -it -u $(id -u):$(id -g) --name tensor_gpu --gpus all -p 8888:8888 -v /home/luis/Documents/personal_projects/tensor_flow_gpu/docker_mount:/tf/notebooks tensorflow/tensorflow:latest-gpu-jupyter jupyter notebook --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.allow_origin='https://colab.research.google.com'
```

running as root for vscode attach

```sh
docker run -it --rm --name tensor_gpu --gpus all -p 8888:8888 -v /home/luis/Documents/personal_projects/tensor_flow_gpu/docker_mount:/tf/notebooks tensorflow/tensorflow:latest-gpu-jupyter jupyter notebook --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.allow_origin='https://colab.research.google.com'
```

conect bash to container

```sh
docker exec -it tensor_gpu bash
```

Jupyter notebook command

```sh
jupyter notebook --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.allow_origin='https://colab.research.google.com'
```

Reusable container

```sh
docker run -it --name tensor_gpu --gpus all -p 8888:8888 -v /home/luis/Documents/personal_projects/tensor_flow_gpu/docker_mount:/tf/notebooks tensorflow/tensorflow:latest-gpu-jupyter bash
```

## Workflow

Creating container

```sh
docker run -it --name tensor_gpu --gpus all -p 8888:8888 -v /home/luis/Documents/personal_projects/tensor_flow_gpu/docker_mount:/tf/notebooks tensorflow/tensorflow:latest-gpu-jupyter bash
```

Running Jupypter in the container

```sh
jupyter notebook --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.allow_origin='https://colab.research.google.com'
```

Stopping container

```sh
docker stop tensor_gpu
```

Removing container

```sh
docker rm tensor_gpu
```

Restarting container in bash

```sh
docker restart tensor_gpu
```

Connecting to restarted container

```sh
docker exec -it tensor_gpu bash
```

## Docker Compose

[Helper that turns docker command into docker file](https://www.composerize.com/)

### Building docker image

```sh
docker build --rm --tag tensor_gpu_image:dev .
```

Remove dangling images after build

```sh
docker image prune
```

Do NOT run unless SURE!!!

```sh
$docker image prune -a # this will remove even base images used as reference to local images
```

### Running docker compose

**Creating** the service

```sh
docker-compose up
```

#### For user ids

To run as a normal user not root (some libraries might have trouble installing)

```sh
UID=$(id -u) GID=$(id -g) docker-compose up
```

#### Compose use

**Starting** the service

```sh
docker-compose start tensorflow
```

**Stoping** the service

```sh
docker-compose stop tensorflow
```

**restarting** the service to keep environment changes

```sh
docker-compose restart tensorflow
```

**Connecting** to the service in any scenario

```sh
docker exec -it tensor_gpu bash
```

Running to turn up **jupyter**

```sh
jupyter notebook --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.allow_origin='https://colab.research.google.com'
```

## Maintenance

Check actual space of docker images in local

```sh
docker system df
```
