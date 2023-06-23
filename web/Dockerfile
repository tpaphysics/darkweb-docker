# Dockerfile_web
FROM nginx:latest

# Copia o site para o diretório de trabalho
COPY /index.html /usr/share/nginx/html
COPY /matrixtext.js /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
