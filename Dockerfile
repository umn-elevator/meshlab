FROM ubuntu:24.04

# install pymeshlab dependencies
# noninteractive frontend required to install tzdata w/out input
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install --yes \
    software-properties-common \
    libgl1-mesa-dev \
    tzdata \
    libglib2.0-0 \
    libjpeg-dev 

RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt update && apt install --yes \
    python3.10 \
    python3.10-dev \
    python3.10-distutils \
    python3.10-venv
# install pymeshlab
# RUN pip3 install pymeshlab==2023.12 --break-system-packages
COPY pymeshlab-2022.2.post2-cp310-cp310-manylinux1_x86_64.whl /root/
RUN python3.10 -m ensurepip
RUN pip3 install /root/pymeshlab-2022.2.post2-cp310-cp310-manylinux1_x86_64.whl
COPY mesh_convert.py /root/
COPY dummy.png /root
# install IDTFConverter
# dependencies
# RUN apt update && apt install --yes \
#     build-essential \
#     git \
#     libpng-dev \
#     libjpeg-dev \
#     locales
# # set local to en_US.UTF-8 (IDTFConverter expects this)
# RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
# # clone u3d repo
# RUN git clone https://github.com/ningfei/u3d.git /tmp/u3d
# # build
# WORKDIR /tmp/u3d
# RUN ./configure && make && make install

WORKDIR /scratch/
ENTRYPOINT [ "python3.10", "/root/mesh_convert.py" ]