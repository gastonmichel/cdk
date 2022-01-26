FROM docker:latest as build

WORKDIR /opt/app

RUN apk -v --no-cache --update add \
        nodejs \
        npm \
        ca-certificates \
        groff \
        less \
        bash \
        make \
        curl \
        wget \
        zip \
        git \
        && \
    update-ca-certificates
    
RUN npm install -g aws-cdk
# ARG AWS_CDK_VERSION=2.0.0
# RUN npm install -g aws-cdk@${AWS_CDK_VERSION}

ENTRYPOINT [ "cdk" ]

FROM build as python

RUN apk -v --no-cache --update add \
        python3 \
        py3-pip 

RUN python3 -m pip install --upgrade pip
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

