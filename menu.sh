#BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
#BIBlue='\033[1;94m'       # Blue
#BIPurple='\033[1;95m'     # Purple
#BICyan='\033[1;96m'       # Cyan
BICyan='\033[1;97m'      # White
Uwhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
NC='\e[0m'

# // Exporting Language to UTF-8

export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'


# // Export Color & Information
export m="\033[0;1;31m"
export y="\033[0;1;34m"
export yy="\033[0;1;36m"
export yl="\033[0;1;37m"
export wh="\033[0;1;33m"
export xz="\033[0;1;35m"
export gr="\033[0;1;32m"

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

# // Exporting URL Host
export Server_URL="raw.githubusercontent.com/andresakti7/test/main"
export Server1_URL="raw.githubusercontent.com/andresakti7/limit/main"
export Server_Port="443"
export Server_IP="underfined"
export Script_Mode="Stable"
export Auther=".bijipeler"

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi

# // Exporting IP Address
export IP=$( curl -s https://ipinfo.io/ip/ )

# // Exporting Network Interface
export NETWORK_IFACE="$(ip route show to default | awk '{print $5}')"

# // Validate Result ( 1 )
touch /etc/${Auther}/license.key
export Your_License_Key="$( cat /etc/${Auther}/license.key | awk '{print $1}' )"
export Validated_Your_License_Key_With_Server="$( curl -s https://${Server_URL}/validated-registered-license-key.txt | grep -w $Your_License_Key | head -n1 | cut -d ' ' -f 1 )"
if [[ "$Validated_Your_License_Key_With_Server" == "$Your_License_Key" ]]; then
    validated='true'
else
    echo -e "${EROR} License Key Not Valid"
    exit 1
fi

# // Checking VPS Status > Got Banned / No
if [[ $IP == "$( curl -s https://${Server_URL}/blacklist.txt | cut -d ' ' -f 1 | grep -w $IP | head -n1 )" ]]; then
    echo -e "${EROR} 403 Forbidden ( Your VPS Has Been Banned )"
    exit  1
fi

# // Checking VPS Status > Got Banned / No
if [[ $Your_License_Key == "$( curl -s https://${Server_URL} | cut -d ' ' -f 1 | grep -w $Your_License_Key | head -n1)" ]]; then
    echo -e "${EROR} 403 Forbidden ( Your License Has Been Limited )"
    exit  1
fi

# // Checking VPS Status > Got Banned / No
if [[ 'Standart' == "$( curl -s https://${Server_URL}/validated-registered-license-key.txt | grep -w $Your_License_Key | head -n1 | cut -d ' ' -f 6 )" ]]; then 
    License_Mode='Standart'
elif [[ Pro == "$( curl -s https://${Server_URL}/validated-registered-license-key.txt | grep -w $Your_License_Key | head -n1 | cut -d ' ' -f 6 )" ]]; then 
    License_Mode='Pro'
else
    echo -e "${EROR} Please Using Genuine License !"
    exit 1
fi

# // Checking Script Expired
exp=$( curl -s https://${Server1_URL}/limit.txt | grep -w $IP | cut -d ' ' -f 3 )
now=`date -d "0 days" +"%Y-%m-%d"`
expired_date=$(date -d "$exp" +%s)
now_date=$(date -d "$now" +%s)
sisa_hari=$(( ($expired_date - $now_date) / 86400 ))
if [[ $sisa_hari -lt 0 ]]; then
    echo $sisa_hari > /etc/${Auther}/license-remaining-active-days.db
    echo -e "${EROR} Your License Key Expired ( $sisa_hari Days )"
    exit 1
else
    echo $sisa_hari > /etc/${Auther}/license-remaining-active-days.db
fi

# // Clear
clear
clear && clear && clear
clear;clear;clear
cek=$(service ssh status | grep active | cut -d ' ' -f5)
if [ "$cek" = "active" ]; then
stat=-f5
else
stat=-f7
fi
ssh=$(service ssh status | grep active | cut -d ' ' $stat)
if [ "$ssh" = "active" ]; then
ressh="${green}ON${NC}"
else
ressh="${red}OFF${NC}"
fi
sshstunel=$(service stunnel4 status | grep active | cut -d ' ' $stat)
if [ "$sshstunel" = "active" ]; then
resst="${green}ON${NC}"
else
resst="${red}OFF${NC}"
fi
sshws=$(service ws-stunnel status | grep active | cut -d ' ' $stat)
if [ "$sshws" = "active" ]; then
ressshws="${green}ON${NC}"
else
ressshws="${red}OFF${NC}"
fi
ngx=$(service nginx status | grep active | cut -d ' ' $stat)
if [ "$ngx" = "active" ]; then
resngx="${green}ON${NC}"
else
resngx="${red}OFF${NC}"
fi
dbr=$(service dropbear status | grep active | cut -d ' ' $stat)
if [ "$dbr" = "active" ]; then
resdbr="${green}ON${NC}"
else
resdbr="${red}OFF${NC}"
fi
v2r=$(service xray status | grep active | cut -d ' ' $stat)
if [ "$v2r" = "active" ]; then
resv2r="${green}ON${NC}"
else
resv2r="${red}OFF${NC}"
fi
function addhost(){
clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -rp "Domain/Host: " -e host
echo ""
if [ -z $host ]; then
echo "????"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
setting-menu
else
echo "IP=$host" > /var/lib/scrz-prem/ipvps.conf
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo "Dont forget to renew cert"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
fi
}
function cek-bandwidth(){
clear
echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m                   BANDWIDTH MONITOR                           \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "${wh}"
echo -e "     1 ⸩   Lihat Total Bandwith Tersisa"

echo -e "     2 ⸩   Tabel Penggunaan Setiap 5 Menit"

echo -e "     3 ⸩   Tabel Penggunaan Setiap Jam"

echo -e "     4 ⸩   Tabel Penggunaan Setiap Hari"

echo -e "     5 ⸩   Tabel Penggunaan Setiap Bulan"

echo -e "     6 ⸩   Tabel Penggunaan Setiap Tahun"

echo -e "     7 ⸩   Tabel Penggunaan Tertinggi"

echo -e "     8 ⸩   Statistik Penggunaan Setiap Jam"

echo -e "     9 ⸩   Lihat Penggunaan Aktif Saat Ini"

echo -e "    10 ⸩   Lihat Trafik Penggunaan Aktif Saat Ini [5s]"

echo -e "    11 ⸩   Menu"
echo -e "${off}"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "${wh}"
read -p "     [#]  Masukkan Nomor :  " noo
echo -e "${off}"

case $noo in
1)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m              TOTAL BANDWIDTH SERVER TERSISA                   \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

vnstat

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

2)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m              PENGGUNAAN BANDWIDTH SETIAP 5 MENIT              \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

vnstat -5

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

3)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m                PENGGUNAAN BANDWIDTH SETIAP JAM                \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

vnstat -h

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

4)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m                PENGGUNAAN BANDWIDTH SETIAP HARI               \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

vnstat -d

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

5)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m                PENGGUNAAN BANDWIDTH SETIAP BULAN              \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

vnstat -m

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

6)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m                PENGGUNAAN BANDWIDTH SETIAP TAHUN              \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

vnstat -y

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

7)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m                 PENGGUNAAN BANDWIDTH TERTINGGI                \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

vnstat -t

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

8)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m              GRAFIK BANDWIDTH TERPAKAI SETIAP JAM             \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

vnstat -hg

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

9)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m               LIVE PENGGUNAAN BANDWIDTH SAAT INI              \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ${GREEN}CTRL+C Untuk Berhenti!${off}"
echo -e ""

vnstat -l

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

10)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m                LIVE TRAFIK PENGGUNAAN BANDWIDTH               \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

vnstat -tr

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

11)
sleep 1
menu
;;

*)
sleep 1
echo -e "${m}Nomor Yang Anda Masukkan Salah!${yy}"
;;
esac
read -n 1 -s -r -p "Press any key to back on menu"

menu
}
function limitspeed(){
clear
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(cat /home/limit)
NIC=$(ip -o $ANU -4 route show to default | awk '{print $5}');
function start () {
echo -e "Limit Speed All Service"
read -p "Set maximum download rate (in Kbps): " down
read -p "Set maximum upload rate (in Kbps): " up
if [[ -z "$down" ]] && [[ -z "$up" ]]; then
echo > /dev/null 2>&1
else
echo "Start Configuration"
sleep 0.5
wondershaper -a $NIC -d $down -u $up > /dev/null 2>&1
systemctl enable --now wondershaper.service
echo "start" > /home/limit
echo "Done"
fi
}
function stop () {
wondershaper -ca $NIC
systemctl stop wondershaper.service
echo "Stop Configuration"
sleep 0.5
echo > /home/limit
echo "Done"
}
if [[ "$cek" = "start" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
clear
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m                Limit Bandwidth Speed                           \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " Status $sts"
echo -e "  1. Start Limit"
echo -e "  2. Stop Limit"
echo -e " Press CTRL+C to return"
read -rp " Please Enter The Correct Number : " -e num
if [[ "$num" = "1" ]]; then
start
elif [[ "$num" = "2" ]]; then
stop
else
clear
echo " You Entered The Wrong Number"
read -n 1 -s -r -p "Press any key to back on menu"
menu
fi
}
function genssl(){
clear
systemctl stop nginx
domain=$(cat /var/lib/scrz-prem/ipvps.conf | cut -d'=' -f2)
Cek=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
if [[ ! -z "$Cek" ]]; then
sleep 1
echo -e "[ ${red}WARNING${NC} ] Detected port 80 used by $Cek " 
systemctl stop $Cek
sleep 2
echo -e "[ ${green}INFO${NC} ] Processing to stop $Cek " 
sleep 1
fi
echo -e "[ ${green}INFO${NC} ] Starting renew cert... " 
sleep 2
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
echo -e "[ ${green}INFO${NC} ] Renew cert done... " 
sleep 2
echo -e "[ ${green}INFO${NC} ] Starting service $Cek " 
sleep 2
echo $domain > /etc/xray/domain
systemctl restart xray
systemctl restart nginx
echo -e "[ ${green}INFO${NC} ] All finished... " 
sleep 0.5
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}
export sem=$( curl -s https://raw.githubusercontent.com/andresakti7/test/main/versions)
export pak=$( cat /home/.ver)
IPVPS=$(curl -s ipinfo.io/ip )
export Server_URL="raw.githubusercontent.com/andresakti7/test/main"
License_Key=$(cat /etc/${Auther}/license.key)
export Nama_Issued_License=$( curl -s https://${Server_URL}/validated-registered-license-key.txt | grep -w $License_Key | cut -d ' ' -f 7-100 | tr -d '\r' | tr -d '\r\n')
#information
OK="${yy}[OK]${yl}"
Error="${m}[Mistake]${yl}"
#pkg install ncurses-utils
#echo -e "Getting Information Please Wait...."
is_root() {
    if [ 0 == $UID ]; then
        echo -e "${OK} ${yl} The current user is the root user..${yl}"
        sleep 1
        echo -e "Getting Information...."
    else
        echo -e "${Error} ${yl} Please switch to the root user and execute start-menu again ${yl}"
        exit 1
    fi
}
is_root
#pkg install ncurses-utils
ip=$(wget -qO- ipinfo.io/ip)
#domainhost=$(cat /root/domain)
# GETTING DOMAIN NAME
Domen=$(cat /etc/xray/domain)
region=$(wget -qO- ipinfo.io/region)
isp=$(wget -qO- ipinfo.io/org)
timezone=$(wget -qO- ipinfo.io/timezone)
ossys=$(neofetch | grep "OS" | cut -d: -f2 | sed 's/ //g')
host=$(neofetch | grep "Host" | cut -d: -f2 | sed 's/ //g')
kernel=$(neofetch | grep "Kernel" | cut -d: -f2 | sed 's/ //g')
uptime=$(neofetch | grep "Uptime" | cut -d: -f2 | sed 's/ //g')
cpu=$(neofetch | grep "CPU" | cut -d: -f2 | sed 's/ //g')
memory=$(neofetch | grep "Memory" | cut -d: -f2 | sed 's/ //g')
echo -e "Getting Information..."
clear
echo -e " \e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e " \E[0;41;37m                     SYSTEM INFORMATION                        \E[0m"
echo -e " \E[0;41;37m                   SCRIPT BY ANDRE SAKTI                       \E[0m"
echo -e " \e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e " $yy IP Address  :$xz $ip $xz"
#echo -e " $yy Domain     :$yl $domainhost $yl"
echo -e " $yy Domain      :$yl $Domen $yl"
echo -e " $yy City        :$yl $region $yl"
echo -e " $yy ISP         :$yl $isp $yl"
#echo -e " $yy Host       :$yl $host $yl"
#echo -e " $yy CPU        :$yl $cpu $yl"
#echo -e " $yy Kernel     :$yl $kernel $yl"
echo -e " $yy OS System   :$yl $ossys $yl"
#echo -e " $yy Time Zone  :$yl $timezone $yl"
echo -e " $yy RAM         :$yl $memory $yl"
echo -e " $yy Up Time     :$yl $uptime $yl"
echo -e " $yy Date        :$yl $(date +%A) $(date +%m-%d-%Y)"
echo -e " $yy My Telegram :$xz https://t.me/AndreSakti_Store $xz"
echo -e " \e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"     
echo -e " ${On_IRed}         ${BICyan} SSH${On_IRed}: $ressh${On_IRed}"  "${BICyan} NGINX${On_IRed}: $resngx""${On_IRed} ${BICyan}  XRAY${NC}${On_IRed}: $resv2r""${On_IRed} ${BICyan} TROJAN${NC}${On_IRed}: $resv2r${On_IRed}           ${NC}"
echo -e " ${On_IRed}       ${BICyan}${On_IRed}      ${BICyan}STUNNEL${NC}${On_IRed}: $resst${On_IRed}${BICyan} DROPBEAR${NC}${On_IRed}: $resdbr${On_IRed}${BICyan} SSH-WS${NC}${On_IRed}: $ressshws${On_IRed}              ${NC}"
echo -e "${yl}┌──────────────────────────────────────────────────────────────┐${yl}"
echo -e "${yl}│                                                              ${yl}│${yl}"
echo -e "${yl}│  $yy 1$wh. SSH $wh       $yy[${wh}Menu$yy]         7$wh.  BANDWIDTH$wh        $yy[${wh}Menu$yy]   ${yl}│${yl}"
echo -e "${yl}│  $yy 2$wh. VMESS $wh     $yy[${wh}Menu$yy]         8$wh.  LIMIT SPEED$wh      $yy[${wh}Menu$yy]   ${yl}│${yl}"  
echo -e "${yl}│  $yy 3$wh. VLESS $wh     $yy[${wh}Menu$yy]         9$wh.  ADD-HOST$wh         $yy[${wh}Menu$yy]   ${yl}│${yl}" 
echo -e "${yl}│  $yy 4$wh. TROJAN $wh    $yy[${wh}Menu$yy]         10$wh. BACKUP$wh           $yy[${wh}Menu$yy]   ${yl}│${yl}" 
echo -e "${yl}│  $yy 5$wh. SS WS $wh     $yy[${wh}Menu$yy]         11$wh. GEN SSL$wh          $yy[${wh}Menu$yy]   ${yl}│${yl}" 
echo -e "${yl}│  $yy 6$wh. SOCK WS $wh   $yy[${wh}Menu$yy]         12$wh. RESTART SERVICE$wh  $yy[${wh}Menu$yy]   ${yl}│${yl}" 
echo -e "${yl}│                                                              ${yl}│${yl}"
echo -e "${yl}└──────────────────────────────────────────────────────────────┘${yl}"
echo -e "${yl}┌──────────────────────────────────────────────────────────────┐${NC}"
echo -e "${yl}   Version       :\033[1;36m 1.0\e[0m"
echo -e "${yl}   User          :\033[1;36m $Nama_Issued_License \e[0m"
echo -e "${yl}   Expiry script $yl: ${BIYellow}$(cat /etc/${Auther}/license-remaining-active-days.db)${NC}"
echo -e "${yl}└──────────────────────────────────────────────────────────────┘${NC}"
echo
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; menu-ssh ;;
2) clear ; menu-vmess ;;
3) clear ; menu-vless ;;
4) clear ; menu-trojan ;;
5) clear ; menu-ss ;;
6) clear ; menu-socks ;;
7) clear ; cek-bandwidth ;;
8) clear ; limitspeed ;;
#007) clear ; wget https://raw.githubusercontent.com/andresakti7/ranjau-darate/main/cek-bandwidth.sh && chmod +x cek-bandwidth.sh && ./cek-bandwidth.sh && rm -f /root/cek-bandwidth.sh ;;
#008) clear ; wget https://raw.githubusercontent.com/andresakti7/ranjau-darate/main/limitspeed.sh && chmod +x limitspeed.sh && ./limitspeed.sh && rm -f /root/limitspeed.sh ;;
9) clear ; addhost ;;
10) clear ; menu-bckp ;;
11) clear ; genssl ;;
12) clear ; systemctl restart xray; systemctl restart ws-stunnel; systemctl restart nginx; systemctl restart fail2ban; systemctl restart dropbear; systemctl restart ssh; systemctl restart stunnel4;
    clear; echo -e "${OKEY} Successfull Restarted All Service";
    ;;
#069) clear ; wget https://raw.githubusercontent.com/andresakti7/ranjau-darate/main/update.sh && chmod +x update.sh && ./update.sh && rm -f /root/update.sh ;;
0) clear ; menu ;;
x) exit ;;
*) echo -e "" ; echo "Press any key to back exit" ; sleep 1 ; exit ;;
esac
