#!/bin/bash
#URL: https://mengniuge.com/creat-jet-server.html
clear
echo "    ################################################"
echo "    #                                              #"
echo "    #            Build Jetbrains Server            #"
echo "    #                Version 0.1.2                  #"
echo "    ################################################"
#Prepare the installation environment
echo -e ""
echo -e "Prepare the installation environment."
if cat /etc/*-release | grep -Eqi "centos|red hat|redhat"; then
  echo "RPM-based"
  if rpm -qa | grep -Eqi "unzip";then
    echo "unzip installed"
  else
    echo "unzip installing"
    yum -y install unzip
  fi
  if rpm -qa | grep -Eqi "wget";then
    echo "wget installed"
  else
    echo "wget installing"
    yum -y install wget
  fi
elif cat /etc/*-release | grep -Eqi "debian|ubuntu|deepin"; then
  echo "Debian-based"
  if dpkg -l | grep -Eqi "unzip";then
    echo "unzip installed"
  else
    echo "unzip installing"
    apt-get -y install unzip
  fi
  if dpkg -l | grep -Eqi "wget";then
    echo "wget installed"
  else
    echo "wget installing"
    apt-get -y install wget
  fi
else
  echo "This release is not supported."
  exit
fi
#Check instruction
if getconf LONG_BIT | grep -Eqi "64"; then
  arch=64
else
  arch=32
fi
#Build Jetbrains Server
wget --no-check-certificate https://mengniuge.com/download/shell/JetbrainsServer.zip
unzip JetbrainsServer.zip
if cat /etc/*-release | grep -Eqi "raspbian"; then
  mv JetbrainsServer/binaries/arm jetbrains
else
  if [ "$arch" -eq 32 ]; then
    mv JetbrainsServer/binaries/i386 jetbrains
  else
    mv JetbrainsServer/binaries/amd64 jetbrains
  fi
fi
mv jetbrains /usr/bin/
chmod +x /usr/bin/jetbrains
nohup jetbrains > /home/jetbrains.log 2>&1 &
echo -ne '\n@reboot root nohup jetbrains > /home/jetbrains.log 2>&1 &\n\n' >>/etc/crontab
#Cleaning Work
rm -rf JetbrainsServer
#Check jetbrains server status
sleep 1
echo "Check Jetbrains Server status..."
sleep 1
PIDS=`ps -ef |grep jetbrains |grep -v grep | awk '{print $2}'`
if [ "$PIDS" != "" ]; then
  echo "jetbrains server is runing!"
else
  echo "jetbrains server is NOT running!"
fi
