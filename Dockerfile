FROM alpine

WORKDIR /home/
EXPOSE 80

ADD LicenseServer /home/

RUN chmod +xr /home/LicenseServer

CMD [ "/home/LicenseServer","-p","80","-u","JetBrains" ]
