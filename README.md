# Liberty Mock API Server

Liberty Mock API를 Swagger 문서로 작성하면 Validation하고 Swagger UI와 Mock API Server에 배포하도록 한다.

## Architecture

![](https://i.imgur.com/oEsFRSZ.png)

## Setup

### OS

ubuntu 18.04

### Install Docker CE


```bash
$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

$ sudo apt-key fingerprint 0EBFCD88

$ sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose

$ docker --version
```

### Run

**Start**

```
mock-server.sh start
```

**Stop**

```
mock-server.sh stop
```

**Restart**

```
mock-server.sh restart
```

### Github Secrets

Github Action을 통해서 배포하기 위해서는 반드시 다음 Secrets을 설정해야한다.

| KEY | Explain | Example |
| --- | ------- | ------- |
| AWS_ACCESS_KEY_ID     | S3에 업로드 가능한 AWS Access Key    |   |
| AWS_SECRET_ACCESS_KEY | S3에 업로드 가능한 AWS Secret Key    | |
| AWS_BUCKET.           | 업로드할 S3 Bucket 이름             | libery-artifacts |
| MOCK_SERVER_HOST      | Mock Server 주소                  | ec2-13-209-70-243.ap-northeast-2.compute.amazonaws.com |
| MOCK_SERVER_USERNAME  | Mock Server Username             | ubuntu |
| MOCK_SERVER_KEY       | Mock Server SSH KEY              | |
| MOCK_SERVER_PORT      | Mock Server SSH Port             | 22 |
| MOCK_SWAGGER_DIR      | Mock Server에 저장될 Swagger 디렉토리 | /tmp/swagger |

## Usage

### API

* auth


### Swagger UI

```
http://<Server_ADDR>/auth/
```

**example**

```
curl http://ec2-13-209-70-243.ap-northeast-2.compute.amazonaws.com/auth/
```

### Mock API

```
http://<Server_ADDR>/api/v1/auth/<endpoint>
```

**example**

```
curl http://ec2-13-209-70-243.ap-northeast-2.compute.amazonaws.com/api/v1/auth/devices
```
