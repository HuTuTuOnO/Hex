#!/bin/bash
# Hex 多功能机场脚本
# Author: HuTu<https://www.hu.tu/>

RED="\033[31m"      # Error message
GREEN="\033[32m"    # Success message
YELLOW="\033[33m"   # Warning message
BLUE="\033[36m"     # Info message
PLAIN='\033[0m'     # Plain message

colorEcho() {
    echo -e "${1}${@:2}${PLAIN}"
}

modifyXrayRDnsAddress() {
    echo -e "> 替换XrayRDNS解锁地址"
        if [ $# -lt 2 ]; then
        read -ep "请输入原DNS地址: " oldDnsAddress &&
        read -ep "请输入新DNS地址: " newDnsAddress &&
        if [[ -z "${oldDnsAddress}" || -z "${newDnsAddress}" ]]; then
            echo -e "${red}所有选项都不能为空${plain}"
            beforeShowMenu
            return 1
        fi
    else
        oldDnsAddress=$1
        newDnsAddress=$2
    fi
    echo -e "${oldDnsAddress}"
    echo -e "${newDnsAddress}"
    echo -e "替换XrayRDNS解锁地址 ${green}修改成功，请稍等重启生效${plain}"
    
    sed -i 's/${oldDnsAddress}/${newDnsAddress}/g' /etc/XrayR/dns.json

    echo -e "替换XrayRDNS解锁地址 ${green}修改成功，请稍等重启生效${plain}"

    XrayR restart

    if [[ $# == 0 ]]; then
        beforeShowMenu
    fi
}

beforeShowMenu() {
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    showMenu
}

showMenu() {
    clear
    echo "############################################################"
    echo -e "# ${RED}Hex 多功能机场脚本${PLAIN}"
    echo -e "# ${GREEN}作者${PLAIN}: HuTu"
    echo -e "# ${GREEN}网址${PLAIN}: https://www.hu.tu"
    echo "#############################################################"

    echo -e "  ${GREEN}1.${PLAIN}   替换XrayR DNS解锁地址"
    echo " -------------"
    echo -e "  ${GREEN}0.${PLAIN}   退出"
    read -p " 请选择操作[0-17]：" answer
    case $answer in
        1)
            modifyXrayRDnsAddress 0
            exit 0
            ;;
        *)
            colorEcho $RED " 请选择正确的操作！"
            exit 1
            ;;
    esac
}

if [[ $# > 0 ]]; then
    case $1 in
        "modifyXrayRDnsAddress")
            shift
            if [ $# -ge 2 ]; then
                modifyXrayRDnsAddress "$@"
            else
                modifyXrayRDnsAddress 0
            fi
        ;;
        *)
            echo " 参数错误"
            echo " 用法: `basename $0` [menu|update|uninstall|start|restart|stop|showInfo|showLog]"
        ;;
    esac
else
    showMenu
fi
