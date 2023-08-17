#!/bin/bash
# VMSSR 多功能机场脚本
# Author: HuTuTu<https://www.vmssr.co/>

RED="\033[31m"      # Error message
GREEN="\033[32m"    # Success message
YELLOW="\033[33m"   # Warning message
BLUE="\033[36m"     # Info message
PLAIN='\033[0m'     # Plain message

menu() {
    clear
    echo "#############################################################"
    echo -e "#                   ${RED}VMSSR 多功能机场脚本${PLAIN}        #"
    echo -e "# ${GREEN}作者${PLAIN}: HuTuTu                           #"
    echo -e "# ${GREEN}网址${PLAIN}: https://www.vmssr.co                 #"
    echo "#############################################################"

    echo -e "  ${GREEN}1.${PLAIN}   替换XrayR DNS解锁地址"
}
