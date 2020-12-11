#!/bin/bash

detect_distro() {
    if [ -z "$distro" ]; then
        distro=$(ls /etc | awk 'match($0, "(.+?)[-_](?:release|version)", groups) {if(groups[1] != "os") {print groups[1]}}')
    fi

    if [ -z "$distro" ]; then
        if [[ "$OSTYPE" == linux-android* ]]; then
            distro="termux"
        elif [ -f "/etc/os-release" ]; then
            distro="$(source /etc/os-release && echo $ID)"
        elif [ "$OSTYPE" == "darwin" ]; then
            distro="darwin"
        else 
            distro="invalid"
        fi
    fi
}

pause() {
    read -n1 -r -p "Press any key to continue..." key
}
banner() {
    clear
    echo -e "\e[1;31m"
    if ! [ -x "$(command -v figlet)" ]; then
        echo 'Introducing TBomb'
    else
        figlet TBomb
    fi
    if ! [ -x "$(command -v toilet)" ]; then
        echo -e "\e[4;34m This Bomber Was modify By \e[1;32mNitro Hacker \e[0m"
    else
        echo -e "\e[1;34mCreated By \e[1;34m"
        toilet -f mono12 -F border Nitro Hacker
    fi
    echo -e "\e[1;34m For Any Queries Mail Me!!!\e[0m"
    echo -e "\e[1;32m           Mail: nitro-hacker.ml \e[0m"
    echo -e "\e[4;32m   YouTube: https://www.youtube.com/channel/UCv80Btv_4kn_9b-GVgPIwMg \e[0m"
    echo " "

}

init_environ(){
    declare -A backends; backends=(
        ["arch"]="pacman -S --noconfirm"
        ["debian"]="apt-get -y install"
        ["ubuntu"]="apt -y install"
        ["termux"]="apt -y install"
        ["fedora"]="yum -y install"
        ["redhat"]="yum -y install"
        ["SuSE"]="zypper -n install"
        ["sles"]="zypper -n install"
        ["darwin"]="brew install"
        ["alpine"]="apk add"
    )

    INSTALL="${backends[$distro]}"

    if [ "$distro" == "termux" ]; then
        PYTHON="python"
        SUDO=""
    else
        PYTHON="python3"
        SUDO="sudo"
    fi
    PIP="$PYTHON -m pip"
}


banner
pause
detect_distro
init_environ
if [ -f .update ];then
    echo "All Requirements Found...."
else
    echo 'Installing Requirements....'
    echo .
    echo .
    install_deps
    echo This Script modify by Nitro Hacker > .update
    echo 'Requirements Installed....'
    pause
fi
while :
do
    banner
    echo -e "\e[4;31m Please Read Instruction Carefully !!! \e[0m"
    echo " "
    echo "Press 1 To  Start SMS  Bomber "
    echo "Press 2 To  Start CALL Bomber "
    echo "Press 3 To  Start MAIL Bomber "
    echo "Press 4 To  Update (Works On Linux And Linux Emulators) "
    echo "Press 5 To  Exit "
    read ch
    clear
    if [ $ch -eq 1 ];then
        $python3 bomber.py --sms
        exit
    elif [ $ch -eq 2 ];then
        $python3 bomber.py --call
        exit
    elif [ $ch -eq 3 ];then
         cd $HOME
        git clone https://github.com/ha-mrx/Emailbomb
         cd Emailbomb
        chmod +x Emailbomb.py
        python2 Emailbomb.py

        exit
    elif [ $ch -eq 4 ];then
        echo -e "\e[1;34m Downloading Latest Files..."
        rm -f .update
        $python3 bomber.py --update
        echo -e "\e[1;34m RUN TBomb Again..."
        pause
        exit
    elif [ $ch -eq 5 ];then
        banner
        exit
    else
        echo -e "\e[4;32m Invalid Input !!! \e[0m"
        pause
    fi
done
