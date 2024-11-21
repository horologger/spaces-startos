## Setting the default configuration

1. Click `CONFIGURE` button.  Make a note of the user name and click the 'eye icon' to reveal the generated password.  You'll need to note these credentials in order to log into your Spaces Shell.  Click `SAVE`
2. Click `START`.  Wait for the Web UI Health check to indicate Spaces is ready.
3. Click `LAUNCH UI` to bring up your Spaces Shell in a new browser window.  Enter the Username and Password from step #1.

## The Spaces Shell

You interact with spaces through a command line tool called space-cli.  In the future this project may provide a complete graphical user interface, but for now it's command line only.  The Shell is a minimal linux environment with access to your Bitcoin Node already configured.  You can test this by running the 'bitcoin-cli -getinfo' command.  Any other bitcoin-cli commands will work as well.

A command 'spaces' is an alias of the 'space-cli' command so you can user either.

## Creating a new wallet(for Spaces functions)

1. At the spaces: prompt, run the 'space-cli createwallet' command.  This will create a new Taproot "default" wallet.
2. Next run the 'space-cli exportwallet -' command.

## Funding the wallet

1. 'space-cli newaddress'
2. Send some satoshis to the new address.  How many depends on what amount of bidding activity you intend to engage in and how high you're willing to go to secure your desired name.
3. Once the funds are confirmed with the 'space-cli balance' command you can start opening auctions.

## Importing and exisiting Taproot wallet(for Spaces functions)
1. 'space-cli createwallet'
2. 'mkdir -p /data/mainnet/wallets_backup/default'
3. 'mv /data/mainnet/wallets/default/wallet.json /data/mainnet/wallets_backup/default'
4. 'rm -rf /data/mainnet/wallets/default'
5. 'vi /data/mainnet/wallets_backup/default/wallet.json'  Replace the xprv with yours. :wq to save
6. 'space-cli importwallet /data/mainnet/wallets_backup/default/wallet.json'
7. 'space-cli balance'
8. 'space-cli listspaces' If you had any active auctions/registered spaces.

## Open up an auction for bidding.

Check the [Spaces Documentation : Opening an Auction](https://docs.spacesprotocol.org/getting-started/quickstart#opening-an-auction) for next steps.

## Getting Help

For more information, see the [Spaces Protocol Help](https://docs.spacesprotocol.org/).

You can also ask for assistance in the [Spaces Telegram Channel](https://t.me/spacesprotocol).
