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
PEERS=""
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
