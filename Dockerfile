# 베이스 이미지로 가벼운 웹 서버인 nginx:alpine 사용
FROM nginx:alpine

# 우리가 만든 app 폴더의 index.html을 Nginx의 기본 서빙 폴더로 복사
COPY ./app/index.html /usr/share/nginx/html/index.html

# 80번 포트 노출
EXPOSE 80