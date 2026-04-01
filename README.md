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
- [ ] 바인드 마운트 반영
- [ ] 볼륨 영속성
- [x] Git 설정 + VSCode GitHub 연동

---

## 🖥️ 3. 터미널 기본 조작
리눅스 터미널 기본조작

### 💻 수행 로그
```bash
pwd 
ls -al
cd [폴더명]
cat [파일명]
clear
```

## ⚙️ 4. Git 설치 및 설정
Git 버전을 확인하고, 전역 사용자 정보 및 기본 브랜치를 설정했습니다.

### 💻 수행 로그
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

### 5-1. Docker 구동 및 검증
```bash
# Docker 버전 확인
waz64326348@c4r7s3 ~ % docker --version
Docker version 28.5.2, build ecc6942

# Docker 상세 정보 확인
waz64326348@c4r7s3 ~ % docker info
```

### 5-2. 디렉토리 구성 및 권한 검증
```bash
# app 폴더 생성 및 html 파일 작성
waz64326348@c4r7s3 Developer % mkdir app
waz64326348@c4r7s3 Developer % echo "<h1>Hello OrbStack! This is my Web Server.</h1>" > app/index.html

# 절대 경로 및 파일 권한 확인
waz64326348@c4r7s3 Developer % pwd
waz64326348@c4r7s3 Developer % ls -al app/index.html 
-rw-r--r--  1 waz64326348  waz64326348  48 Mar 31 19:39 app/index.html
```

### 5-3. Dockerfile 작성 및 빌드

**📄 `Dockerfile`**
```dockerfile
# 베이스 이미지로 가벼운 웹 서버인 nginx:alpine 사용
FROM nginx:alpine

# app 폴더의 index.html을 Nginx의 기본 서빙 폴더로 복사
COPY ./app/index.html /usr/share/nginx/html/index.html

# 80번 포트 노출
EXPOSE 80
```

**💻 `빌드 및 로그 확인`**
```bash
# 커스텀 이미지 빌드 (이름: my-web-app)
waz64326348@c4r7s3 Developer % docker build -t my-web-app .

# 빌드된 이미지 목록 확인
waz64326348@c4r7s3 Developer % docker images
```

**💻 `포트 매핑 로그`**
```bash
# 포트 매핑(8080:80)과 바인드 마운트(-v 호스트절대경로:컨테이너경로) 적용
docker run -d --name my-web-container -p 8080:80 -v $(pwd)/app:/usr/share/nginx/html my-web-app

curl localhost:8080
<h1>Hello OrbStack! This is my Web Server.</h1>

# 기존 컨테이너 삭제
docker rm -f my-web-container
my-web-container

# 포트 매핑(8081:80)과 바인드 마운트(-v 호스트절대경로:컨테이너경로) 적용
docker run -d --name my-web-container -p 8081:80 -v $(pwd)/app:/usr/share/nginx/html my-web-app

curl localhost:8081
<h1>Hello OrbStack! (Bind Mount Test)</h1>

# 실행 중인 컨테이너 상태 확인
docker ps
```

---

## 🔐 6. 파일 권한 변경 실습

```bash
# 변경 전 권한 확인
# 구분 - 타입 / 소유자 / 그룹 / 나머지
ls -l app/index.html
-rw-r--r--  1 waz64326348  waz64326348  42 Mar 31 19:49 app/index.html

# 권한 변경 777 (모든 사용자에게 읽기/쓰기/실행 권한 부여)
# 읽기(4), 쓰기(2), 실행(1)
chmod 777 app/index.html

# 변경 후 권한 확인
ls -l app/index.html
-rwxrwxrwx  1 waz64326348  waz64326348  42 Mar 31 19:49 app/index.html
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