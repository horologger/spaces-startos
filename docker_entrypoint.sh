#!/bin/bash
#exec /bin/start.sh &
#exec /bin/launch-edgestore.sh &
DAOS=$(uname -s | tr '[:upper:]' '[:lower:]')
# echo $DAOS
if [ "$DAOS" == "linux" ]; then
  echo "Running on Linux"
  FNOS="linux"
else
  echo "Running on Mac"
  FNOS="darwin"
fi

DAARCH=$(uname -p | tr '[:upper:]' '[:lower:]')
DAARCH=$(uname -m | tr '[:upper:]' '[:lower:]')

# echo $DAARCH
DAARCH=$(uname -m | tr '[:upper:]' '[:lower:]')
# echo $DAARCH
if [ "$DAARCH" == "x86_64" ]; then
  echo "Running on x86_64"
  FNARCH="amd64"
  FNSUFFIX="gnu"
elif [ "$DAARCH" == "aarch64" ]; then
  echo "Running on aarch64"
  FNARCH="aarch64"
  FNSUFFIX="gnu"
else
  echo "Running on Raspberry???"
  FNARCH="arm"
  FNSUFFIX="gnueabihf"
fi
# echo $FNOS
# echo $FNARCH

echo "BTC_RPC_HOST:" $BTC_RPC_HOST
echo "BTC_RPC_PORT:" $BTC_RPC_PORT

FNVER="27.1"

BTCFN="bitcoin-$FNVER-$FNARCH-linux-$FNSUFFIX.tar.gz"
BTCURL="https://bitcoincore.org/bin/bitcoin-core-$FNVER/$BTCFN"
echo "Got: "$BTCURL

#https://bitcoincore.org/bin/bitcoin-core-27.1/bitcoin-27.1-x86_64-linux-gnu.tar.gz
#https://bitcoincore.org/bin/bitcoin-core-27.1/bitcoin-27.1-arm-linux-gnueabihf.tar.gz

# This is now done in BTCShell
# wget -O /tmp/bitcoin.tar.gz $BTCURL
# tar xzf /tmp/bitcoin.tar.gz -C /tmp
# cp /tmp/bitcoin-$FNVER/bin/bitcoin-cli /usr/local/bin

mkdir -p /data/bin
echo 'export PATH=/data/bin:$PATH' >> /root/.bashrc

# Let it use the defaults http://127.0.0.1:7224
# export SPACED_RPC_BIND=$BTC_RPC_HOST
# export SPACED_RPC_PORT=$BTC_RPC_PORT
export SPACED_BITCOIN_RPC_USER=$BTC_RPC_USER
export SPACED_BITCOIN_RPC_PASSWORD=$BTC_RPC_PASSWORD
export SPACED_DATA_DIR='/data'
export SPACED_CHAIN='testnet4'
export SPACED_BITCOIN_RPC_URL='http://'$BTC_RPC_HOST':'$BTC_RPC_PORT
export SPACED_RPC_HOST='127.0.0.1'
export SPACED_RPC_PORT='7224'
export SPACED_RPC_URL='http://'$SPACED_RPC_HOST':'$SPACED_RPC_PORT
export SPACED_BLOCK_INDEX='true'
echo "echo bitcoin-cli -getinfo" >> /root/.bashrc
echo "echo spaces help" >> /root/.bashrc
echo "echo" >> /root/.bashrc
echo "echo 'For getting started info: https://docs.spacesprotocol.org/getting-started/quickstart'" >> /root/.bashrc
echo "echo" >> /root/.bashrc
echo "echo 'Monitor the spaced daemon with the following. <Ctrl-a> d to detach from session.'" >> /root/.bashrc
echo "echo 'screen -x spaced'" >> /root/.bashrc
echo "alias spaces='space-cli --chain testnet4'" >> /root/.bashrc
echo "screen -S spaced -d -m spaced" >> /root/.bashrc
echo "export PS1='spaces:\w$ '" >> /root/.bashrc
# Launch background processes in their own screen detached
# Need to do this in an if stmt so that it only happens once
echo "if [[ \$(screen -ls | grep htop | wc -l) > 0 ]]; then" >> /root/.bashrc
echo "  echo 'already running htop'" >> /root/.bashrc                     
echo "else" >> /root/.bashrc                                              
echo "  /usr/bin/screen -S htop -d -m /usr/bin/htop" >> /root/.bashrc     
echo "fi" >> /root/.bashrc  

# /usr/bin/screen -S indexer -d -m /usr/bin/npm run start

#echo "/usr/bin/screen -S spaced -d -m /root/.cargo/bin/spaced" >> /root/.bashrc
echo "if [[ \$(screen -ls | grep spaced | wc -l) > 0 ]]; then" >> /root/.bashrc
echo "  echo 'already running spaced'" >> /root/.bashrc                     
echo "else" >> /root/.bashrc                                              
echo "  /usr/bin/screen -S spaced -d -m /root/.cargo/bin/spaced" >> /root/.bashrc     
echo "fi" >> /root/.bashrc                                            

#echo "/usr/bin/screen -S fabric -d -m /usr/local/bin/fabric --host 70.251.209.207 --port 22253 --watch /data/fabric" >> /root/.bashrc

# https://spacesprotocol.org/#install-spaced for more command info


echo APP_USER = $APP_USER
echo APP_PASSWORD = $APP_PASSWORD

GOTTY_CREDS=$APP_USER:$APP_PASSWORD

echo GOTTY_CREDS = $GOTTY_CREDS

# This is being done in btcshell instead

# https://spacesprotocol.org/#install-spaced
# git clone https://github.com/spacesprotocol/spaced && cd spaced
# cargo build --release
# cargo install --path node --locked
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc

#mkdir -p /data/bin
#echo '#!/bin/bash' > /data/setpath
#echo 'export PATH=/data/bin:$PATH' >> /data/setpath
#chmod a+x /data/setpath

mkdir -p ~/.bitcoin
echo 'rpcuser='$BTC_RPC_USER > ~/.bitcoin/bitcoin.conf
echo 'rpcpassword='$BTC_RPC_PASSWORD >> ~/.bitcoin/bitcoin.conf
echo 'rpcconnect='$BTC_RPC_HOST >> ~/.bitcoin/bitcoin.conf
echo 'rpcport='$BTC_RPC_PORT >> ~/.bitcoin/bitcoin.conf

#PostgreSQL startup

# if [ -d "/data/postgresql/data" ]; then
#   echo "Skipping PostgreSL Initialization"
#   echo "Starting PostgreSL"
#   # rm -rf ./data/postgresql/data  for testing of init below
#   su postgres - -c '/usr/bin/pg_ctl start -D /data/postgresql/data'
# else 
#   echo "Initializing PostgreSL"

#   mkdir -p /data/postgresql/run
#   chown postgres:postgres /data/postgresql/run

#   mkdir -p /data/postgresql/data
#   chown postgres:postgres /data/postgresql/data
#   chmod 0700 /data/postgresql/data

#   su postgres - -c 'initdb -D /data/postgresql/data'

#   export POSTGRES_USER=postgres
#   export POSTGRES_PASSWORD=password

#   mkdir -p /run/postgresql
#   chown postgres:postgres /run/postgresql
#   # su postgres - -c 'echo "host all all 0.0.0.0/0 md5" >> /data/postgresql/data/pg_hba.conf'
#   # su postgres - -c 'echo "listen_addresses='"'"'*'"'"'" >> /data/postgresql/data/postgresql.conf'
#   echo "Starting PostgreSL"

#   su postgres - -c '/usr/bin/pg_ctl start -D /data/postgresql/data'
#   echo "Waiting 3 secs for things to warm up."
#   sleep 3
#   su postgres - -c '/usr/bin/psql -c "create database spacesprotocol_explorer;"'

#   echo "Initializing Schema"

#   # git clone in the Docker file..
#   # This is in spaces-explorer/indexer : Prompts to continue...
#   cd /root/spaces-explorer/indexer
#   npm i
#   cp .env.example .env
#   # su postgres - -c 'npx drizzle-kit push'
#   npx drizzle-kit push
#   # npm run start

#   # Prep the explorer
#   cd /root/spaces-explorer/explorer
#   npm i
#   cp .env.example .env
#   # npm run start

#   cd

#   export POSTGRES_DB=spacesprotocol_explorer
# fi

# Show that the tables exist
# psql --username=$POSTGRES_USER --dbname=$POSTGRES_DB --command='\dt'

# export DB_URL=postgres://postgres:password@127.0.0.1:5432/spacesprotocol_explorer
export NETWORK=testnet4
export SPACES_STARTING_BLOCKHEIGHT=871100
export BITCOIN_RPC_URL=$SPACED_BITCOIN_RPC_URL
export BITCOIN_RPC_USER=$SPACED_BITCOIN_RPC_USER
export BITCOIN_RPC_PASSWORD=$SPACED_BITCOIN_RPC_PASSWORD
# export SPACED_RPC_URL='http://127.0.0.1:7224'

exec /usr/bin/gotty --port 8080 -c $GOTTY_CREDS --permit-write --reconnect /bin/bash