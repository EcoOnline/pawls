FROM python:3.7.2

ARG GITHUB_ACCESS_TOKEN

# Install Python dependencies
RUN pip install --upgrade pip setuptools wheel
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy over the source code
COPY app app/
COPY config config/
COPY main.py main.py

RUN apt-get update -y && \
    apt-get install -y build-essential libfuse-dev fuse
RUN apt-get install lsb-release -y

## Install S3 Fuse
RUN rm -rf /usr/src/s3fs-fuse
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse/ /usr/src/s3fs-fuse
WORKDIR /usr/src/s3fs-fuse 
RUN ./autogen.sh && ./configure && make && make install

## Create annotations folder
WORKDIR /skiff_files/apps/pawls/s3-annotations

## Set Your AWS Access credentials
ENV AWS_ACCESS_KEY=<key_id>
ENV AWS_SECRET_ACCESS_KEY=<access_key>

## Set the directory where you want to mount your s3 bucket
ENV S3_MOUNT_DIRECTORY=/skiff_files/apps/pawls/s3-annotations

## Replace with your s3 bucket name
ENV S3_BUCKET_NAME=eco-ml-annotations

## S3fs-fuse credential config
RUN echo $AWS_ACCESS_KEY:$AWS_SECRET_ACCESS_KEY > /root/.passwd-s3fs && \
    chmod 600 /root/.passwd-s3fs

# Setup a spot for the api code
WORKDIR /usr/local/src/skiff/app/api

# Kick things off
ADD start.sh /start.sh
RUN chmod 755 /start.sh 
CMD ["/start.sh"]
