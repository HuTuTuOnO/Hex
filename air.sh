#!/bin/bash
# VMSSR 多功能机场脚本
# Author: HuTuTu<https://www.vmssr.co/>

RED="\033[31m"      # Error message
GREEN="\033[32m"    # Success message
YELLOW="\033[33m"   # Warning message
BLUE="\033[36m"     # Info message
PLAIN='\033[0m'     # Plain message

checkSystem() {
    result=$(id | awk '{print $1}')
    if [[ $result != "uid=0(root)" ]]; then
        colorEcho $RED " 请以root身份执行该脚本"
        exit 1
    fi

    res=`which yum 2>/dev/null`
    if [[ "$?" != "0" ]]; then
        res=`which apt 2>/dev/null`
        if [[ "$?" != "0" ]]; then
            colorEcho $RED " 不受支持的Linux系统"
            exit 1
        fi
        PMT="apt"
        CMD_INSTALL="apt install -y "
        CMD_REMOVE="apt remove -y "
        CMD_UPGRADE="apt update; apt upgrade -y; apt autoremove -y"
    else
        PMT="yum"
        CMD_INSTALL="yum install -y "
        CMD_REMOVE="yum remove -y "
        CMD_UPGRADE="yum update -y"
    fi
    res=`which systemctl 2>/dev/null`
    if [[ "$?" != "0" ]]; then
        colorEcho $RED " 系统版本过低，请升级到最新版本"
        exit 1
    fi
}

colorEcho() {
    echo -e "${1}${@:2}${PLAIN}"
}

UpdateXrayRDnsAddress{

}

menu() {
    clear
    echo "############################################################"
    echo -e "# ${RED}VMSSR 多功能机场脚本${PLAIN}"
    echo -e "# ${GREEN}作者${PLAIN}: HuTuTu"
    echo -e "# ${GREEN}网址${PLAIN}: https://www.vmssr.co"
    echo "#############################################################"

    echo -e "  ${GREEN}1.${PLAIN}   替换XrayR DNS解锁地址"
    echo " -------------"
    echo -e "  ${GREEN}0.${PLAIN}   退出"
    read -p " 请选择操作[0-17]：" answer
    case $answer in
        0)
            exit 0
            ;;
        *)
            colorEcho $RED " 请选择正确的操作！"
            exit 1
            ;;
    esac
}

action=$1
[[ -z $1 ]] && action=menu
case "$action" in
    menu|UpdateXrayRDnsAddress)
        ${action}
        ;;
    *)
        echo " 参数错误"
        echo " 用法: `basename $0` [menu|update|uninstall|start|restart|stop|showInfo|showLog]"
        ;;
esac
