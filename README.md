# 개발 워크스테이션 세팅 미션

## 미션 목표
> 본 미션은 개발자로서 갖춰야 할 가장 기본적인 기반인 **터미널, Docker, Git**을 직접 세팅하며, "내 컴퓨터에서만 돌아가는" 문제를 해결하고 팀원 모두가 동일한 환경에서 실행·배포·디버깅할 수 있는 **재현 가능한 개발 환경** 구성을 목표로 합니다.

---

## 1. 실행 환경
![macOS](https://img.shields.io/badge/macOS_15.7.4-000000?style=flat-square&logo=apple&logoColor=white)
![Zsh](https://img.shields.io/badge/Shell-zsh-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white)
![Docker](https://img.shields.io/badge/Docker_28.5.2-2496ED?style=flat-square&logo=docker&logoColor=white)
![Git](https://img.shields.io/badge/Git_2.53.0-F05032?style=flat-square&logo=git&logoColor=white)

---

## ✅ 2. 수행 체크리스트
- [x] 터미널 기본 조작 및 폴더 구성
- [x] 권한 변경 실습
- [x] Docker 설치/점검
- [x] `hello-world` 실행
- [x] Dockerfile 빌드/실행
- [x] 포트 매핑 접속 (2회)
- [x] 바인드 마운트 반영
- [x] 볼륨 영속성
- [x] Git 설정 + VSCode GitHub 연동

---

## 🖥️ 3. 터미널 기본 조작
```bash
# 현재 작업 디렉토리 절대경로 확인
waz64326348@c4r7s3 ~ % pwd
/Users/waz64326348

# 'Developer' 폴더 생성
waz64326348@c4r7s3 ~ % mkdir Developer

# 'Developer' 폴더로 이동
waz64326348@c4r7s3 ~ % cd Developer
waz64326348@c4r7s3 Developer %

# 파일 생성 및 첫 번째 줄 작성 (> 기호는 덮어쓰기 또는 새 파일 생성)
waz64326348@c4r7s3 Developer % echo "리눅스 명령어 연습 중입니다." > memo.txt

# 'test' 폴더 생성
waz64326348@c4r7s3 ~ % mkdir test

# 'test' 파일 이동
waz64326348@c4r7s3 ~ % mv memo.txt ./test

# 'test' 파일 삭제
waz64326348@c4r7s3 ~ % rm -r test

# 현재 폴더 내부의 파일 및 폴더 목록 간단히 확인
waz64326348@c4r7s3 Developer % ls
memo.txt

# 특정 폴더의 상세 정보 확인 (내부 내용이 아닌 폴더 자체의 정보 및 상태 변경 시간 표시)
waz64326348@c4r7s3 Developer % ls -al memo.txt
-rw-r--r--  1 waz64326348  waz64326348  48 Mar 31 19:39 memo.txt

# 기존 파일에 새로운 줄 추가 (>> 기호는 기존 내용 아래에 추가)
waz64326348@c4r7s3 Developer % echo "이 텍스트는 cat 명령어를 통해 터미널에 출력됩니다." >> memo.txt

# 특정 파일의 내용 전체 출력
waz64326348@c4r7s3 Developer % cat memo.txt
리눅스 명령어 연습 중입니다.
이 텍스트는 cat 명령어를 통해 터미널에 출력됩니다.

# 터미널 화면 지우기 (실행 시 이전 출력 내용이 모두 지워지고 아래처럼 프롬프트만 상단에 나타남)
waz64326348@c4r7s3 Developer % clear
waz64326348@c4r7s3 Developer %
```

---

## ⚙️ 4. Git 설치 및 설정
```bash
# git 버전 확인
waz64326348@c4r7s3 ~ % git --version
git version 2.53.0

# git 이메일 및 이름 설정
waz64326348@c4r7s3 ~ % git config --global user.name "why-not-available" 
waz64326348@c4r7s3 ~ % git config --global user.email "waz6432@naver.com" 

# git 브랜치 설정 (main)
waz64326348@c4r7s3 ~ % git config --global init.defaultBranch main

# git 설정 확인
waz64326348@c4r7s3 ~ % git config --global --list
user.name=why-not-available
user.email=waz6432@naver.com
init.defaultbranch=main
```

---

## 🐳 5. Docker 설치 및 웹 서버 구성
### 5-1. Docker hello-world 로그
```bash
docker run hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

### 5-2. Docker 구동 및 검증
```bash
# Docker 버전 확인
waz64326348@c4r7s3 ~ % docker --version
Docker version 28.5.2, build ecc6942

# Docker 구동 확인
waz64326348@c4r7s3 ~ % docker info
Client:
 Version:    28.5.2
 Context:    orbstack
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.29.1
    Path:     /Users/waz64326348/.docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.40.3
    Path:     /Users/waz64326348/.docker/cli-plugins/docker-compose

Server:
 Containers: 2
  Running: 0
  Paused: 0
  Stopped: 2
 Images: 1
 Server Version: 28.5.2
 Storage Driver: overlay2
  Backing Filesystem: btrfs
  Supports d_type: true
  Using metacopy: false
  Native Overlay Diff: true
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
 CDI spec directories:
  /etc/cdi
  /var/run/cdi
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 1c4457e00facac03ce1d75f7b6777a7a851e5c41
 runc version: d842d7719497cc3b774fd71620278ac9e17710e0
 init version: de40ad0
 Security Options:
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 6.17.8-orbstack-00308-g8f9c941121b1
 Operating System: OrbStack
 OSType: linux
 Architecture: x86_64
 CPUs: 6
 Total Memory: 15.67GiB
 Name: orbstack
 ID: b3307094-d30c-43c3-b9c7-0164cbdcf0e8
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  ::1/128
  127.0.0.0/8
 Live Restore Enabled: false
 Product License: Community Engine
 Default Address Pools:
   Base: 192.168.97.0/24, Size: 24
   Base: 192.168.107.0/24, Size: 24
   Base: 192.168.117.0/24, Size: 24
   Base: 192.168.147.0/24, Size: 24
   Base: 192.168.148.0/24, Size: 24
   Base: 192.168.155.0/24, Size: 24
   Base: 192.168.156.0/24, Size: 24
   Base: 192.168.158.0/24, Size: 24
   Base: 192.168.163.0/24, Size: 24
   Base: 192.168.164.0/24, Size: 24
   Base: 192.168.165.0/24, Size: 24
   Base: 192.168.166.0/24, Size: 24
   Base: 192.168.167.0/24, Size: 24
   Base: 192.168.171.0/24, Size: 24
   Base: 192.168.172.0/24, Size: 24
   Base: 192.168.181.0/24, Size: 24
   Base: 192.168.183.0/24, Size: 24
   Base: 192.168.186.0/24, Size: 24
   Base: 192.168.207.0/24, Size: 24
   Base: 192.168.214.0/24, Size: 24
   Base: 192.168.215.0/24, Size: 24
   Base: 192.168.216.0/24, Size: 24
   Base: 192.168.223.0/24, Size: 24
   Base: 192.168.227.0/24, Size: 24
   Base: 192.168.228.0/24, Size: 24
   Base: 192.168.229.0/24, Size: 24
   Base: 192.168.237.0/24, Size: 24
   Base: 192.168.239.0/24, Size: 24
   Base: 192.168.242.0/24, Size: 24
   Base: 192.168.247.0/24, Size: 24
   Base: fd07:b51a:cc66:d000::/56, Size: 64

WARNING: DOCKER_INSECURE_NO_IPTABLES_RAW is set
waz64326348@c4r4s7 ~ % 
```

### 5-3. 디렉토리 구성 및 권한 검증
```bash
# app 폴더 생성 및 html 파일 작성
waz64326348@c4r7s3 Developer % mkdir app
waz64326348@c4r7s3 Developer % echo "<h1>Hello OrbStack! This is my Web Server.</h1>" > app/index.html

# 절대 경로 및 파일 권한 확인
waz64326348@c4r7s3 Developer % pwd
waz64326348@c4r7s3 Developer % ls -al app/index.html 
-rw-r--r--  1 waz64326348  waz64326348  48 Mar 31 19:39 app/index.html
```

### 5-4. Dockerfile 작성 및 빌드

**📄 `Dockerfile`**
```dockerfile
# 베이스 이미지로 가벼운 웹 서버인 nginx:alpine 사용
FROM nginx:alpine

# app 폴더의 index.html을 Nginx의 기본 서빙 폴더로 복사
COPY ./app/index.html /usr/share/nginx/html/index.html

# 80번 포트 노출
EXPOSE 80
```

**💻 `빌드 및 로그`**
```bash
# 커스텀 이미지 빌드 (이름: my-web-app)
waz64326348@c4r7s3 Developer % docker build -t my-web-app .

# 빌드된 이미지 목록 확인
waz64326348@c4r7s3 Developer % docker images
REPOSITORY    TAG       IMAGE ID       CREATED         SIZE
my-web-app    latest    ea8fb85c7b08   5 seconds ago   62.2MB
hello-world   latest    e2ac70e7319a   10 days ago     10.1kB

# 컨테이너 확인
docker ps -a
ONTAINER ID   IMAGE         COMMAND    CREATED         STATUS                     PORTS     NAMES
5cd063362c91   hello-world   "/hello"   8 minutes ago   Exited (0) 8 minutes ago             hungry_merkle
ce36c75036ec   hello-world   "/hello"   9 minutes ago   Exited (0) 9 minutes ago             laughing_fermi

# hello-world 컨테이너 삭제
waz64326348@c4r4s7 CodysseyE1-1 % docker rm 5cd 
5cd
waz64326348@c4r4s7 CodysseyE1-1 % docker rm ce3
ce3

# 컨테이너 확인
waz64326348@c4r4s7 CodysseyE1-1 % docker ps -a 
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

# hello-world 이미지 삭제
docker rmi hello-world 
Untagged: hello-world:latest
Untagged: hello-world@sha256:452a468a4bf985040037cb6d5392410206e47db9bf5b7278d281f94d1c2d0931
Deleted: sha256:e2ac70e7319a02c5a477f5825259bd118b94e8b02c279c67afa63adab6d8685b
Deleted: sha256:897b3f2a7c1bc2f3d02432f7892fe31c6272c521ad4d70257df624504a3238b4

# 빌드된 이미지 목록 확인
docker images         
REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
my-web-app   latest    ea8fb85c7b08   5 minutes ago   62.2MB

```

### 5-5. Docker 컨테이너 설정

**💻 `포트 매핑 및 로그`**
```bash
# 포트 매핑(8080:80)
docker run -d --name my-web-container -p 8080:80 my-web-app

# 접속 로그
curl localhost:8080
<h1>Hello OrbStack! This is my Web Server.</h1>

# 기존 컨테이너 삭제
docker rm -f my-web-container
my-web-container

# 포트 매핑(8081:80)
docker run -d --name my-web-container -p 8081:80 my-web-app

# 접속 로그
curl localhost:8081
<h1>Hello OrbStack! This is my Web Server.</h1>

# 실행 중인 컨테이너 상태 확인
docker ps
```S

**💻 `바인드마운트 설정 및 로그`**
```bash
# 기존 컨테이너 삭제
docker rm -f my-web-container
my-web-container

# 포트 매핑(8080:80)과 바인드 마운트(-v 호스트절대경로:컨테이너경로) 적용
docker run -d --name my-web-container -p 8080:80 -v $(pwd)/app:/usr/share/nginx/html my-web-app

# 호스트(내 PC)의 파일 내용을 변경하여 바인드 마운트가 잘 작동하는지 테스트
echo "<h1>Hello OrbStack! (Bind Mount Test)</h1>" > app/index.html

# 접속 로그
curl localhost:8080
<h1>Hello OrbStack! (Bind Mount Test)</h1>

# 로그 확인
docker inspect my-web-container --format '{{ json .Mounts }}' | python3 -m json.tool
```

**💻 `볼륨 설정 및 영속성 확인 로그`**
```bash
# 기존 컨테이너 삭제
docker rm -f my-web-container
my-web-container

# 새 볼륨 생성
docker volume create my-web-vol
my-web-vol

# 포트 매핑(8080:80)과 볼륨 적용
docker run -d --name my-web-container -p 8080:80 -v my-web-vol:/usr/share/nginx/html my-web-app
07657d7f7e16db0f56359e25f729c8970b02a8fba13c56834d80b974e339185c

# 볼륨이 연결된 폴더에 테스트 파일 생성
docker exec -it my-web-container sh -c "echo 'Volume Data is Safe!' > /usr/share/nginx/html/check.txt"
Volume Data is Safe!

# 파일 확인
curl http://localhost:8080/check.txt
Volume Data is Safe!

# 컨테이너 삭제
docker rm -f my-web-container
my-web-container

# 컨테이너 삭제 확인
docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

# 볼륨 확인
docker volume ls                                       
DRIVER    VOLUME NAME
local     my-web-vol

# 새 컨테이너 생성
docker run -d --name new-web-container -p 8080:80 -v my-web-vol:/usr/share/nginx/html my-web-app 
c3b30db9476fc34d3286679d13b50f3b8611b61fcf5487864cc8b3bc98faee95

# 데이터 복구 확인
waz64326348@c4r4s7 CodysseyE1-1 % docker exec -it new-web-container cat /usr/share/nginx/html/check.txt
Volume Data is Safe!
waz64326348@c4r4s7 CodysseyE1-1 % curl localhost:8080/check.txt
Volume Data is Safe!

```

---

## 🔐 6. 파일 권한 변경 실습
```bash
# 변경 전 권한 확인
# 구분 - 타입 / 소유자 / 그룹 / 나머지
ls -al app
drwxr-xr-x  3 waz64326348  waz64326348   96 Apr  3 19:06 .
drwxr-xr-x  6 waz64326348  waz64326348  192 Apr  3 19:14 ..
-rwxr-xr-x  1 waz64326348  waz64326348   47 Apr  3 19:06 index.html

# 권한 변경 777 (모든 사용자에게 읽기/쓰기/실행 권한 부여)
# 읽기(4), 쓰기(2), 실행(1)
chmod -R 777 app
drwxrwxrwx  3 waz64326348  waz64326348   96 Apr  3 19:06 .
drwxr-xr-x  6 waz64326348  waz64326348  192 Apr  3 19:14 ..
-rwxrwxrwx  1 waz64326348  waz64326348   47 Apr  3 19:06 index.html

# 파일 권한 확인
ls -l index.html     
-rwxrwxrwx  1 waz64326348  waz64326348  47 Apr  3 19:06 index.html

# 변경 후 권한 확인
chmod 644 index.html
waz64326348@c4r4s7 app % ls -l index.html    
-rw-r--r--  1 waz64326348  waz64326348  47 Apr  3 19:06 index.html
```

---

## 🚨 7. 트러블 슈팅

### ⚠️ 1. Issue: 디렉토리 부재로 인한 파일 생성 오류

- **증상 및 원인**
  현재 폴더 기준 하위에 대상 폴더(`app`)가 없는 상태에서 `echo` 명령어와 리다이렉션(`>`)을 통해 파일을 생성하려고 시도하여 발생한 오류입니다.

- **오류 로그**
  ```bash
  waz64326348@c4r7s3 app % echo "<h1>Hello OrbStack! This is my Web Server.</h1>" > app/index.html
  # 해당 경로를 찾을 수 없다는 에러 발생
  ```

- **해결 방안 ✅**
  파일을 생성하기 전 `mkdir app` 명령어를 통해 상위 폴더를 먼저 생성하여 정상적으로 해결 완료했습니다.


### ⚠️ 2. Issue: 바인드 마운트 시 403 권한 에러 및 파일 누락 현상

- **증상 및 원인**
  docker run으로 포트 8081과 바인드 마운트를 설정하여 컨테이너를 실행했으나, 브라우저 접속 시 403 Permission 에러가 발생하고 파일을 찾을 수 없었다.
  바인드 마운트 시 사용한 `$(pwd)/app` 경로가 문제일 것이다. 터미널의 현재 위치가 프로젝트 루트가 아닌 다른 곳에 있어서, Nginx 컨테이너에 잘못된(비어있는) 폴더가 마운트되었을 것이다.

- **오류 로그**
  ```bash
  curl localhost:8081
  <html>
  <head><title>403 Forbidden</title></head>
  <body>
  <center><h1>403 Forbidden</h1></center>
  <hr><center>nginx/1.29.7</center>
  </body>
  </html>
  ```

- **해결 방안 ✅**
  터미널에서 `pwd`와 `ls` 명령어로 현재 위치를 확인해 본 결과, 경로가 엇갈려 있음을 확인했다. `cd` 명령어를 통해 Dockerfile과 app 디렉토리가 있는 프로젝트 최상단으로 이동한 뒤, 다시 컨테이너를 실행(`docker run ...`)하여 정상 접속을 확인했다.