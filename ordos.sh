#
# // Copyright (C) 2022 Salman Wahib Recoded By NodeX Capital
#

#!/bin/bash
clear

echo -e "\033[0;33m"
echo "================================================================="
echo " ░██████╗██████╗░████████╗░░░░░░███╗░░██╗░█████╗░██████╗░███████╗"
echo " ██╔════╝██╔══██╗╚══██╔══╝░░░░░░████╗░██║██╔══██╗██╔══██╗██╔════╝"
echo " ╚█████╗░██████╔╝░░░██║░░░█████╗██╔██╗██║██║░░██║██║░░██║█████╗░░"
echo " ░╚═══██╗██╔═══╝░░░░██║░░░╚════╝██║╚████║██║░░██║██║░░██║██╔══╝░░"
echo " ██████╔╝██║░░░░░░░░██║░░░░░░░░░██║░╚███║╚█████╔╝██████╔╝███████╗"
echo " ╚═════╝░╚═╝░░░░░░░░╚═╝░░░░░░░░░╚═╝░░╚══╝░╚════╝░╚═════╝░╚══════╝"
echo "================================================================="
echo -e "\e[0m"
echo -e '\e[33mNama Project =\e[55m' Coreum 
echo -e '\e[33mKomunitas Kami =\e[55m' Sipaling Testnet X CNESIA112
echo -e '\e[33mChannel Telegram =\e[55m' https://t.me/ssipalingtestnet
echo -e '\e[33mGroup Telegram =\e[55m' https://t.me/diskusisipalingairdrop
echo -e "\e[0m"
echo -e "\033[0;33m"
echo "================================================================="


sleep 1


#
# // Copyright (C) 2022 Salman Wahib (sxlmnwb)
#

# Variable
ORDOS_WALLET=wallet
ORDOS=ordosd
ORDOS_ID=ordos-1
ORDOS_FOLDER=.ordos
ORDOS_VER=v0.0.1-goa
ORDOS_REPO=https://github.com/terra-money/alliance
ORDOS_GENESIS=https://raw.githubusercontent.com/sxlzptprjkt/resource/master/testnet/goa/ordos/genesis.json
ORDOS_ADDRBOOK=https://raw.githubusercontent.com/sxlzptprjkt/resource/master/testnet/goa/ordos/addrbook.json
ORDOS_DENOM=uord
ORDOS_PORT=01

echo "export ORDOS_WALLET=${ORDOS_WALLET}" >> $HOME/.bash_profile
echo "export ORDOS=${ORDOS}" >> $HOME/.bash_profile
echo "export ORDOS_ID=${ORDOS_ID}" >> $HOME/.bash_profile
echo "export ORDOS_FOLDER=${ORDOS_FOLDER}" >> $HOME/.bash_profile
echo "export ORDOS_VER=${ORDOS_VER}" >> $HOME/.bash_profile
echo "export ORDOS_REPO=${ORDOS_REPO}" >> $HOME/.bash_profile
echo "export ORDOS_GENESIS=${ORDOS_GENESIS}" >> $HOME/.bash_profile
echo "export ORDOS_ADDRBOOK=${ORDOS_ADDRBOOK}" >> $HOME/.bash_profile
echo "export ORDOS_DENOM=${ORDOS_DENOM}" >> $HOME/.bash_profile
echo "export ORDOS_PORT=${ORDOS_PORT}" >> $HOME/.bash_profile
source $HOME/.bash_profile

# Set Vars
if [ ! $ORDOS_NODENAME ]; then
        read -p "sxlzptprjkt@w00t666w00t:~# [ENTER YOUR NODE] > " ORDOS_NODENAME
        echo 'export ORDOS_NODENAME='$ORDOS_NODENAME >> $HOME/.bash_profile
fi
echo ""
echo -e "YOUR NODE NAME : \e[1m\e[31m$ORDOS_NODENAME\e[0m"
echo -e "NODE CHAIN ID  : \e[1m\e[31m$ORDOS_ID\e[0m"
echo -e "NODE PORT      : \e[1m\e[31m$ORDOS_PORT\e[0m"
echo ""

# Update
sudo apt update && sudo apt upgrade -y

# Package
sudo apt install make build-essential gcc git jq chrony lz4 -y

# Install GO
ver="1.19.5"
cd $HOME
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile
source ~/.bash_profile
go version

# Get testnet version of alliance (terra)
cd $HOME
rm -rf alliance
git clone $ORDOS_REPO
cd alliance
git checkout $ORDOS_VER
make build-alliance ACC_PREFIX=ordos
sudo mv build/$ORDOS /usr/bin/

# Init generation
$ORDOS config chain-id $ORDOS_ID
$ORDOS config keyring-backend file
$ORDOS config node tcp://localhost:${ORDOS_PORT}657
$ORDOS init $ORDOS_NODENAME --chain-id $ORDOS_ID

# Set peers and seeds
PEERS="0135478355cc4beb4d6ba4991e4ab677d0f1a5ff@65.21.135.86:5000,6ebf0000ee85ff987f1d9de3223d605745736ca9@35.168.16.221:41356,2c66624a7bbecd94e8be4005d0ece19ce284d7c3@54.196.186.174:41356,418a1b8485e79d7e12f934ce7ec622cfcbde97d3@52.91.39.40:41356,60cd771bf04e5ca9860a26ce024dd93406e4e1ce@146.190.127.9:01656,4680b83972a9d2a1db2f9453b8dd111072566a47@65.108.81.34:26656,3f486d41a9be9808ae60573712dbe7f6343eed31@164.92.91.248:10656,076c0380ace716c98bd02f71806f1d4b1b8cfee7@34.101.122.41:01656,4ae10e9c2aac86c12da8ad585dd8ab7cab416ac6@89.163.130.46:26656,1677dabde46280cf7101472ac96777d855c0fbf0@65.109.32.226:26656,6deac387b71a1a83ce6ca3a7b3422ca472d19788@217.76.59.213:26656,74c67144a1dd53a73edff2bde17c0f42a025c924@65.21.134.202:27656,0c795b273ca8fbabe9421396129209ffe9d278b8@54.202.211.7:26656,c4c71cf90ebe51a215c71f5cc769cf7b188ff155@131.153.158.173:26656,2cae9adec56ffc7cb7447ddbd37adf4eba5525e8@65.109.93.35:29656,0ee82b65de8d0a189fe218f9bb751e69e59a11ae@65.108.149.243:26656,8af4410f28b52d9c58b9e8ef2ea5e9a97994595e@164.92.104.66:26656,ba90f800b800b14c05e5a8614a7cb07a9cfefbf9@95.216.114.212:20656,a6c789d6a707bb7881d39093749cbacc3f8aedb0@65.109.71.119:21656,9f32299169e166c58bf32b6adf553b8056e69ad0@144.76.97.251:37656,48cb0fbc088e0f0ad0afe7a5ae11431a5d687b49@37.120.245.79:26656,94d9e475a532d121f4ba96d2254d47be63662c01@184.174.34.131:26656,4c2605d4b9b2c9b2f74373b9ed2165e9f5901f93@65.108.9.50:36656,b9abf3fa1823a8b0324d07077f6159c73dc9fd40@54.36.109.62:18056,8c3459aebbd9d74f213b65ad106641480b817ba4@38.242.134.77:10656,6d26ed3f5ba59dde6bf45d56c1b2c5b00a214c09@185.219.142.32:01656,b00447e7083d42b7a7dbb3d61d271369315c3842@146.190.40.115:01656,6a6cada77645f1a96a3e5653d7aed22a48ffe4f7@142.93.200.253:26656,ec59607ab8aed67fbb6b976cef1fedff6e54076c@159.65.178.241:26656,a4145ed2ca124c12d863b144aeed1a574d77f7a3@65.108.40.46:29656,825134bb3caf9d287c6fb8a3797892209c2d65b6@23.88.44.225:26656,a41fd4f51d29fc47849a87c6dc9aa2e36830f631@65.21.132.27:26656,728e015f58edbbad80e03db90399a83580ae3c60@142.132.202.50:39656,57f7b3067819700e2e95647fb8b968fd39d4bc17@159.65.229.196:01656,2945a38f7a2cfc42f0b44697127a8c06c1023f0e@89.116.28.2:26656,fad83257e9b5e312c5514bc291c853f8b95de15d@194.163.164.52:46656,8421d69ba1272c3cf872fd5b229d4e0670f46a77@128.199.101.34:01656,0cb92a083865897dc07b390b39735022c99339ed@161.35.195.106:01656,a6265b52b454508c058fa899e1d4c9da4c354385@138.197.88.229:26656,53bcdf7b919e58c086bb27781d88b0fda5665509@134.209.21.58:01656,09f36539c8caba263ff047ae9a593d219e59fc27@128.199.75.51:26656,97b1ca0d0746126b2e2df45509c0e567af2facca@65.109.117.208:4000,969ea931ee6da4a4f56afd30c40f9e9fb5e964fc@168.119.138.109:26656,06d52fa557e44f3d08eb81129878fc942e3e2d7f@146.190.134.77:26656,5c52ee64af7fe766fdcc20fd3cc69f42b0346d90@142.132.213.231:5000,e857240b7b21aad5e37e10e0f1d3075108c7fbb4@137.184.61.155:01656"
SEEDS="1772a7a48530cc8adc447fdb7b720c064411667b@goa-seeds.lavenderfive.com:11656"
sed -i -e "s|^persistent_peers *=.*|persistent_peers = \"$PEERS\"|" $HOME/$ORDOS_FOLDER/config/config.toml
sed -i -e "s|^seeds *=.*|seeds = \"$SEEDS\"|" $HOME/$ORDOS_FOLDER/config/config.toml

# Download genesis and addrbook
curl -Ls $ORDOS_GENESIS > $HOME/$ORDOS_FOLDER/config/genesis.json
curl -Ls $ORDOS_ADDRBOOK > $HOME/$ORDOS_FOLDER/config/addrbook.json

# Set Port
sed -i.bak -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:${ORDOS_PORT}658\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:${ORDOS_PORT}657\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:${ORDOS_PORT}060\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:${ORDOS_PORT}656\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":${ORDOS_PORT}660\"%" $HOME/$ORDOS_FOLDER/config/config.toml
sed -i.bak -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:${ORDOS_PORT}317\"%; s%^address = \":8080\"%address = \":${ORDOS_PORT}080\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:${ORDOS_PORT}090\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:${ORDOS_PORT}091\"%" $HOME/$ORDOS_FOLDER/config/app.toml

# Set Config Pruning
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="19"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/$ORDOS_FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/$ORDOS_FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/$ORDOS_FOLDER/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/$ORDOS_FOLDER/config/app.toml

# Set minimum gas price
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.001$ORDOS_DENOM\"/" $HOME/$ORDOS_FOLDER/config/app.toml

# Enable snapshots
$ORDOS tendermint unsafe-reset-all --home $HOME/$ORDOS_FOLDER --keep-addr-book
curl -o - -L https://snap-ordos.hexskrt.net/ordos-snapshot.tar.lz4 | tar -Ilz4 -xf - -C $HOME/$ORDOS_FOLDER

# Create Service
sudo tee /etc/systemd/system/$ORDOS.service > /dev/null <<EOF
[Unit]
Description=$ORDOS
After=network-online.target

[Service]
User=$USER
ExecStart=$(which $ORDOS) start --home $HOME/$ORDOS_FOLDER
Restart=on-failure
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
EOF

# Register And Start Service
sudo systemctl daemon-reload
sudo systemctl enable $ORDOS
sudo systemctl start $ORDOS

echo -e "\e[1m\e[31mSETUP FINISHED\e[0m"
echo ""
echo -e "CHECK RUNNING LOGS : \e[1m\e[31mjournalctl -fu $ORDOS -o cat\e[0m"
echo -e "CHECK LOCAL STATUS : \e[1m\e[31mcurl -s localhost:${ORDOS_PORT}657/status | jq .result.sync_info\e[0m"
echo ""

# End
