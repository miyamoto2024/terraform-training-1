FROM ubuntu:22.04

LABEL maintainer="miyamoto2024"

ARG GITHUB_USER_NAME
ARG GITHUB_USER_EMAIL
ARG GITHUB_USER_TOKEN

# install package
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git python3 python3-pip golang-go vim zip less curl unzip sudo apt-transport-https ca-certificates software-properties-common lsb-release gnupg wget
RUN apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /usr/local/src/*

# install gcloud cli
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt-get update && apt-get install google-cloud-cli

# install terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

# not working
# RUN gpg --no-default-keyring \
#    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
#    --fingerprint

RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/hashicorp.list
RUN apt-get update && apt-get install terraform

# clone training repository
WORKDIR /work
RUN git config --global user.name ${GITHUB_USER_NAME}
RUN git config --global user.email ${GITHUB_USER_EMAIL}
RUN git clone https://${GITHUB_USER_NAME}:${GITHUB_USER_TOKEN}@github.com/a-mymt/terraform-training-1.git
# optional
RUN git clone https://${GITHUB_USER_NAME}:${GITHUB_USER_TOKEN}@github.com/a-mymt/golang-training-2.git
