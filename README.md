# idea-license-server
An IntelliJ IDEA License Server

# docker build -t "idea-license" .
docker run -d --restart=always --name="idea-license" -p 1017:80 idea-license

# 参考：https://mengniuge.com/creat-jet-server.html
wget --no-check-certificate -O jetbrains.sh https://mengniuge.com/download/shell/jetbrains.sh && chmod +x jetbrains.sh && bash jetbrains.sh
