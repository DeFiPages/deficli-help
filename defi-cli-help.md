DeFi Blockchain RPC client version v3.1.1

[Accounts](#Accounts)
[Blockchain](#Blockchain)
[Control](#Control)
[Generating](#Generating)
[Icxorderbook](#Icxorderbook)
[Loan](#Loan)
[Masternodes](#Masternodes)
[Mining](#Mining)
[Network](#Network)
[Oracles](#Oracles)
[Poolpair](#Poolpair)
[Proposals](#Proposals)
[Rawtransactions](#Rawtransactions)
[Spv](#Spv)
[Stats](#Stats)
[Tokens](#Tokens)
[Util](#Util)
[Vault](#Vault)
[Wallet](#Wallet)
[Zmq](#Zmq)

## Accounts
<details><summary>accounthistorycount ( "owner" {"no_rewards":bool,"token":"str","txtype":"str"} )</summary><p>
accounthistorycount ( "owner" {"no_rewards":bool,"token":"str","txtype":"str"} )<br>
<br>
Returns count of account history.<br>
<br>
Arguments:<br>
1. owner                      (string) Single account ID (CScript or address) or reserved words: "mine" - to list history for all owned accounts or "all" to list whole DB (default = "mine").<br>
2. options                    (json object)<br>
     {<br>
       "no_rewards": bool,    (boolean) Filter out rewards<br>
       "token": "str",        (string) Filter by token<br>
       "txtype": "str",       (string) Filter by transaction type, supported letter from {CustomTxType}<br>
     }<br>
<br>
Result:<br>
count     (int) Count of account history<br>
<br>
Examples:<br>
> defi-cli accounthistorycount all '{no_rewards: true}'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "accounthistorycount", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>accounttoaccount "from" {"address":"str"} ( [{"txid":"hex","vout":n},...] )</summary><p>
accounttoaccount "from" {"address":"str"} ( [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) a transfer transaction from the specified account to the specfied accounts.<br>
The first optional argument (may be empty array) is an array of specific UTXOs to spend.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. from                     (string, required) The defi address of sender<br>
2. to                       (json object, required)<br>
     {<br>
       "address": "str",    (string, required) The defi address is the key, the value is amount in amount@token format. If multiple tokens are to be transferred, specify an array ["amount1@t1", "amount2@t2"]<br>
     }<br>
3. inputs                   (json array, optional) A json array of json objects<br>
     [<br>
       {                    (json object)<br>
         "txid": "hex",     (string, required) The transaction id<br>
         "vout": n,         (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli accounttoaccount sender_address '{"address1":"1.0@DFI","address2":["2.0@BTC", "3.0@ETH"]}' '[]'<br>

</p></details>

<details><summary>accounttoutxos "from" {"address":"str"} ( [{"txid":"hex","vout":n},...] )</summary><p>
accounttoutxos "from" {"address":"str"} ( [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) a transfer transaction from the specified account to UTXOs.<br>
The third optional argument (may be empty array) is an array of specific UTXOs to spend.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. from                     (string, required) The defi address of sender<br>
2. to                       (json object, required)<br>
     {<br>
       "address": "str",    (string, required) The defi address is the key, the value is amount in amount@token format. If multiple tokens are to be transferred, specify an array ["amount1@t1", "amount2@t2"]<br>
     }<br>
3. inputs                   (json array, optional) A json array of json objects<br>
     [<br>
       {                    (json object)<br>
         "txid": "hex",     (string, required) The transaction id<br>
         "vout": n,         (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli accounttoutxos sender_address '{"address1":"100@DFI"}' '[]'<br>
> defi-cli accounttoutxos sender_address '{"address1":"1.0@DFI","address2":["2.0@BTC", "3.0@ETH"]}' '[]'<br>

</p></details>

<details><summary>executesmartcontract "name" "amount" ( "address" [{"txid":"hex","vout":n},...] )</summary><p>
executesmartcontract "name" "amount" ( "address" [{"txid":"hex","vout":n},...] )<br>
<br>
Creates and sends a transaction to either fund or execute a smart contract. Available contracts: dbtcdfiswap<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. name                    (string, required) Name of the smart contract to send funds to<br>
2. amount                  (string, required) Amount to send in amount@token format<br>
3. address                 (string) Address to be used in contract execution if required<br>
4. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli executesmartcontract dbtcdfiswap 1000@DFI<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "executesmartcontract", "params": [dbtcdfiswap, 1000@DFI] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>futureswap "address" "amount" ( "destination" [{"txid":"hex","vout":n},...] )</summary><p>
futureswap "address" "amount" ( "destination" [{"txid":"hex","vout":n},...] )<br>
<br>
Creates and submits to the network a futures contract<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. address                 (string, required) Address to fund contract and receive resulting token<br>
2. amount                  (string, required) Amount to send in amount@token format<br>
3. destination             (string, optional) Expected dToken if DUSD supplied<br>
4. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli futureswap dLb2jq51qkaUbVkLyCiVQCoEHzRSzRPEsJ 1000@TSLA<br>
> defi-cli futureswap dLb2jq51qkaUbVkLyCiVQCoEHzRSzRPEsJ 1000@DUSD TSLA<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "futureswap", "params": [dLb2jq51qkaUbVkLyCiVQCoEHzRSzRPEsJ, 1000@TSLA] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "futureswap", "params": [dLb2jq51qkaUbVkLyCiVQCoEHzRSzRPEsJ, 1000@DUSD, TSLA] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getaccount "owner" ( {"start":"str","including_start":bool,"limit":n} indexed_amounts )</summary><p>
getaccount "owner" ( {"start":"str","including_start":bool,"limit":n} indexed_amounts )<br>
<br>
Returns information about account.<br>
<br>
Arguments:<br>
1. owner                           (string, required) Owner address in base58/bech32/hex encoding<br>
2. pagination                      (json object)<br>
     {<br>
       "start": "str",             (string) Optional first key to iterate from, in lexicographical order.Typically it's set to last tokenID from previous request.<br>
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default<br>
       "limit": n,                 (numeric) Maximum number of orders to return, 100 by default<br>
     }<br>
3. indexed_amounts                 (boolean) Format of amounts output (default = false): (true: obj = {tokenid:amount,...}, false: array = ["amount@tokenid"...])<br>
<br>
Result:<br>
{...}     (array) Json object with order information<br>
<br>
Examples:<br>
> defi-cli getaccount owner_address<br>

</p></details>

<details><summary>getaccounthistory "owner" blockHeight txn</summary><p>
getaccounthistory "owner" blockHeight txn<br>
<br>
Returns information about account history.<br>
<br>
Arguments:<br>
1. owner          (string, required) Single account ID (CScript or address).<br>
2. blockHeight    (numeric, required) Block Height to search in.<br>
3. txn            (numeric, required) for order in block.<br>
<br>
Result:<br>
{}  An object with account history information<br>
<br>
Examples:<br>
> defi-cli getaccounthistory mxxA2sQMETJFbXcNbNbUzEsBCTn1JSHXST 103 2<br>
> defi-cli getaccounthistory mxxA2sQMETJFbXcNbNbUzEsBCTn1JSHXST, 103, 2<br>

</p></details>

<details><summary>getburninfo</summary><p>
getburninfo<br>
<br>
Returns burn address and burnt coin and token information.<br>
Requires full acindex for correct amount, tokens and feeburn values.<br>
<br>
Result:<br>
{<br>
  "address" : "address",        (string) The defi burn address<br>
  "amount" : n.nnnnnnnn,        (string) The amount of DFI burnt<br>
  "tokens" :  [<br>
      { (array of burnt tokens)      "name" : "name"<br>
      "amount" : n.nnnnnnnn<br>
    ]<br>
  "feeburn" : n.nnnnnnnn,        (string) The amount of fees burnt<br>
  "emissionburn" : n.nnnnnnnn,   (string) The amount of non-utxo coinbase rewards burnt<br>
}<br>
<br>
Examples:<br>
> defi-cli getburninfo <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getburninfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getpendingdusdswaps "address"</summary><p>
getpendingdusdswaps "address"<br>
Get specific pending DFI-to-DUSD swap.<br>
<br>
Arguments:<br>
1. address    (string, required) Address to get all pending future swaps<br>
<br>
Result:<br>
{<br>
    owner :       "address"<br>
    amount :      n.nnnnnnnn<br>
}<br>
<br>
Examples:<br>
> defi-cli getpendingfutureswaps address<br>

</p></details>

<details><summary>getpendingfutureswaps "address"</summary><p>
getpendingfutureswaps "address"<br>
Get specific pending futures.<br>
<br>
Arguments:<br>
1. address    (string, required) Address to get all pending future swaps<br>
<br>
Result:<br>
{<br>
    owner :       "address"<br>
    values : [{<br>
    tokenSymbol : "SYMBOL"<br>
    amount :      n.nnnnnnnn<br>
    destination : "SYMBOL"<br>
    }...]<br>
}<br>
<br>
Examples:<br>
> defi-cli getpendingfutureswaps address<br>

</p></details>

<details><summary>gettokenbalances ( {"start":"str","including_start":bool,"limit":n} indexed_amounts symbol_lookup )</summary><p>
gettokenbalances ( {"start":"str","including_start":bool,"limit":n} indexed_amounts symbol_lookup )<br>
<br>
Returns the balances of all accounts that belong to the wallet.<br>
<br>
Arguments:<br>
1. pagination                      (json object)<br>
     {<br>
       "start": "str",             (string) Optional first key to iterate from, in lexicographical order.Typically it's set to last tokenID from previous request.<br>
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default<br>
       "limit": n,                 (numeric) Maximum number of tokens to return, 100 by default<br>
     }<br>
2. indexed_amounts                 (boolean) Format of amounts output (default = false): (true: obj = {tokenid:amount,...}, false: array = ["amount@tokenid"...])<br>
3. symbol_lookup                   (boolean) Use token symbols in output (default = false)<br>
<br>
Result:<br>
{...}     (array) Json object with balances information<br>
<br>
Examples:<br>
> defi-cli gettokenbalances <br>

</p></details>

<details><summary>listaccounthistory ( "owner" {"maxBlockHeight":n,"depth":n,"no_rewards":bool,"token":"str","txtype":"str","limit":n,"txn":n,"format":"str"} )</summary><p>
listaccounthistory ( "owner" {"maxBlockHeight":n,"depth":n,"no_rewards":bool,"token":"str","txtype":"str","limit":n,"txn":n,"format":"str"} )<br>
<br>
Returns information about account history.<br>
<br>
Arguments:<br>
1. owner                       (string) Single account ID (CScript or address) or reserved words: "mine" - to list history for all owned accounts or "all" to list whole DB (default = "mine").<br>
2. options                     (json object)<br>
     {<br>
       "maxBlockHeight": n,    (numeric) Optional height to iterate from (downto genesis block), (default = chaintip).<br>
       "depth": n,             (numeric) Maximum depth, from the genesis block is the default<br>
       "no_rewards": bool,     (boolean) Filter out rewards<br>
       "token": "str",         (string) Filter by token<br>
       "txtype": "str",        (string) Filter by transaction type, supported letter from {CustomTxType}<br>
       "limit": n,             (numeric) Maximum number of records to return, 100 by default<br>
       "txn": n,               (numeric) Order in block, unlimited by default<br>
       "format": "str",        (string) Return amounts with the following: 'id' -> <amount>@id; (default)'symbol' -> <amount>@symbol<br>
     }<br>
<br>
Result:<br>
[{},{}...]     (array) Objects with account history information<br>
<br>
Examples:<br>
> defi-cli listaccounthistory all '{"maxBlockHeight":160,"depth":10}'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listaccounthistory", "params": [address false] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listaccounts ( {"start":"str","including_start":bool,"limit":n} verbose indexed_amounts is_mine_only )</summary><p>
listaccounts ( {"start":"str","including_start":bool,"limit":n} verbose indexed_amounts is_mine_only )<br>
<br>
Returns information about all accounts on chain.<br>
<br>
Arguments:<br>
1. pagination                      (json object)<br>
     {<br>
       "start": "str",             (string) Optional first key to iterate from, in lexicographical order.Typically it's set to last ID from previous request.<br>
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default<br>
       "limit": n,                 (numeric) Maximum number of orders to return, 100 by default<br>
     }<br>
2. verbose                         (boolean) Flag for verbose list (default = true), otherwise limited objects are listed<br>
3. indexed_amounts                 (boolean) Format of amounts output (default = false): (true: {tokenid:amount}, false: "amount@tokenid")<br>
4. is_mine_only                    (boolean) Get balances about all accounts belonging to the wallet<br>
<br>
Result:<br>
{id:{...},...}     (array) Json object with accounts information<br>
<br>
Examples:<br>
> defi-cli listaccounts <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listaccounts", "params": ['{}' false] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listaccounts", "params": ['{"start":"a914b12ecde1759f792e0228e4fa6d262902687ca7eb87@0","limit":100}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listburnhistory ( {"maxBlockHeight":n,"depth":n,"token":"str","txtype":"str","limit":n} )</summary><p>
listburnhistory ( {"maxBlockHeight":n,"depth":n,"token":"str","txtype":"str","limit":n} )<br>
<br>
Returns information about burn history.<br>
<br>
Arguments:<br>
1. options                     (json object)<br>
     {<br>
       "maxBlockHeight": n,    (numeric) Optional height to iterate from (down to genesis block), (default = chaintip).<br>
       "depth": n,             (numeric) Maximum depth, from the genesis block is the default<br>
       "token": "str",         (string) Filter by token<br>
       "txtype": "str",        (string) Filter by transaction type, supported letter from {CustomTxType}<br>
       "limit": n,             (numeric) Maximum number of records to return, 100 by default<br>
     }<br>
<br>
Result:<br>
[{},{}...]     (array) Objects with burn history information<br>
<br>
Examples:<br>
> defi-cli listburnhistory '{"maxBlockHeight":160,"depth":10}'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listburnhistory", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listcommunitybalances</summary><p>
listcommunitybalances<br>
<br>
Returns information about all community balances.<br>
<br>
Result:<br>
{balance_type:value,...}     (array) Json object with accounts information<br>
<br>
Examples:<br>
> defi-cli listcommunitybalances <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listcommunitybalances", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listpendingdusdswaps</summary><p>
listpendingdusdswaps<br>
Get all pending DFI-to_DUSD swaps.<br>
<br>
Result:<br>
"json"          (string) array containing json-objects having following fields:<br>
[{<br>
    owner :       "address"<br>
    amount :      n.nnnnnnnn<br>
}...]<br>
<br>
Examples:<br>
> defi-cli listpendingdusdswaps <br>

</p></details>

<details><summary>listpendingfutureswaps</summary><p>
listpendingfutureswaps<br>
Get all pending futures.<br>
<br>
Result:<br>
"json"          (string) array containing json-objects having following fields:<br>
    owner :       "address"<br>
    values : [{<br>
        tokenSymbol : "SYMBOL"<br>
        amount :      n.nnnnnnnn<br>
        destination : "SYMBOL"<br>
    }...]<br>
<br>
Examples:<br>
> defi-cli listpendingfutureswaps <br>

</p></details>

<details><summary>sendtokenstoaddress {"address":"str"} {"address":"str"} ( "selectionMode" )</summary><p>
sendtokenstoaddress {"address":"str"} {"address":"str"} ( "selectionMode" )<br>
<br>
Creates (and submits to local node and network) a transfer transaction from your accounts balances (may be picked manualy or autoselected) to the specfied accounts.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. from                     (json object, required)<br>
     {<br>
       "address": "str",    (string) The source defi address is the key, the value is amount in amount@token format. If obj is empty (no address keys exists) then will try to auto-select accounts from wallet with necessary balances to transfer.<br>
     }<br>
2. to                       (json object, required)<br>
     {<br>
       "address": "str",    (string, required) The defi address is the key, the value is amount in amount@token format. If multiple tokens are to be transferred, specify an array ["amount1@t1", "amount2@t2"]<br>
     }<br>
3. selectionMode            (string, optional, default=pie) If param "from" is empty this param indicates accounts autoselection mode.May be once of:<br>
                            "forward" - Selecting accounts without sorting, just as address list sorted.<br>
                            "crumbs" - Selecting accounts by ascending of sum token amounts.<br>
                            It means that we will select first accounts with minimal sum of neccessary token amounts.<br>
                            "pie" - Selecting accounts by descending of sum token amounts.<br>
                            It means that we will select first accounts with maximal sum of neccessary token amounts.<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli sendtokenstoaddress '{}' '{"dstAddress1":"1.0@DFI","dstAddress2":["2.0@BTC", "3.0@ETH"]}' "crumbs"<br>
> defi-cli sendtokenstoaddress '{"srcAddress1":"2.0@DFI", "srcAddress2":["3.0@DFI", "2.0@ETH"]}' '{"dstAddress1":["5.0@DFI", "2.0@ETH"]}'<br>

</p></details>

<details><summary>sendutxosfrom "from" "to" amount ( "change" )</summary><p>
sendutxosfrom "from" "to" amount ( "change" )<br>
<br>
Send a transaction using UTXOs from the specfied address.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. from      (string, required) The address of sender<br>
2. to        (string, required) The address of receiver<br>
3. amount    (numeric, required) The amount to send<br>
4. change    (string) The address to send change to (Default: from address)<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli sendutxosfrom "from" "to" 100<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "sendutxosfrom", "params": ["from", "to", 100"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>utxostoaccount {"address":"str"} ( [{"txid":"hex","vout":n},...] )</summary><p>
utxostoaccount {"address":"str"} ( [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) a transfer transaction from the wallet UTXOs to specfied account.<br>
The second optional argument (may be empty array) is an array of specific UTXOs to spend.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. amounts                  (json object, required)<br>
     {<br>
       "address": "str",    (string, required) The defi address is the key, the value is amount in amount@token format. If multiple tokens are to be transferred, specify an array ["amount1@t1", "amount2@t2"]<br>
     }<br>
2. inputs                   (json array, optional) A json array of json objects<br>
     [<br>
       {                    (json object)<br>
         "txid": "hex",     (string, required) The transaction id<br>
         "vout": n,         (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli utxostoaccount '{"address1":"1.0@DFI","address2":["2.0@BTC", "3.0@ETH"]}' '[]'<br>

</p></details>

<details><summary>withdrawfutureswap "address" "amount" ( "destination" [{"txid":"hex","vout":n},...] )</summary><p>
withdrawfutureswap "address" "amount" ( "destination" [{"txid":"hex","vout":n},...] )<br>
<br>
Creates and submits to the network a withdrawal from futures contract transaction.<br>
 Withdrawal will be back to the address specified in the futures contract.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. address                 (string, required) Address used to fund contract with<br>
2. amount                  (string, required) Amount to withdraw in amount@token format<br>
3. destination             (string, optional) The dToken if DUSD supplied<br>
4. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli withdrawfutureswap dLb2jq51qkaUbVkLyCiVQCoEHzRSzRPEsJ 1000@TSLA<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "withdrawfutureswap", "params": [dLb2jq51qkaUbVkLyCiVQCoEHzRSzRPEsJ, 1000@TSLA] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

## Blockchain
<details><summary>clearmempool</summary><p>
clearmempool<br>
<br>
Clears the memory pool and returns a list of the removed transactions.<br>
<br>
Result:<br>
[                     (json array of string)<br>
  "hash"              (string) The transaction hash<br>
  ,...<br>
]<br>
<br>
Examples:<br>
> defi-cli clearmempool <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "clearmempool", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getbestblockhash</summary><p>
getbestblockhash<br>
<br>
Returns the hash of the best (tip) block in the most-work fully-validated chain.<br>
<br>
Result:<br>
"hex"      (string) the block hash, hex-encoded<br>
<br>
Examples:<br>
> defi-cli getbestblockhash <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getbestblockhash", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getblock "blockhash" ( verbosity )</summary><p>
getblock "blockhash" ( verbosity )<br>
<br>
If verbosity is 0, returns a string that is serialized, hex-encoded data for block 'hash'.<br>
If verbosity is 1, returns an Object with information about block <hash>.<br>
If verbosity is 2, returns an Object with information about block <hash> and information about each transaction. <br>
<br>
Arguments:<br>
1. blockhash    (string, required) The block hash<br>
2. verbosity    (numeric, optional, default=1) 0 for hex-encoded data, 1 for a json object, and 2 for json object with transaction data<br>
<br>
Result (for verbosity = 0):<br>
"data"             (string) A string that is serialized, hex-encoded data for block 'hash'.<br>
<br>
Result (for verbosity = 1):<br>
{<br>
  "hash" : "hash",     (string) the block hash (same as provided)<br>
  "confirmations" : n,   (numeric) The number of confirmations, or -1 if the block is not on the main chain<br>
  "size" : n,            (numeric) The block size<br>
  "strippedsize" : n,    (numeric) The block size excluding witness data<br>
  "weight" : n           (numeric) The block weight as defined in BIP 141<br>
  "height" : n,          (numeric) The block height or index<br>
  "version" : n,         (numeric) The block version<br>
  "versionHex" : "00000000", (string) The block version formatted in hexadecimal<br>
  "merkleroot" : "xxxx", (string) The merkle root<br>
  "nonutxo" : [,         (array of string) Non-UTXO coinbase rewards<br>
     "type" n.nnnnnnnn   (numeric) Reward type and amount<br>
  ],<br>
  "tx" : [               (array of string) The transaction ids<br>
     "transactionid"     (string) The transaction id<br>
     ,...<br>
  ],<br>
  "time" : ttt,          (numeric) The block time in seconds since epoch (Jan 1 1970 GMT)<br>
  "mediantime" : ttt,    (numeric) The median block time in seconds since epoch (Jan 1 1970 GMT)<br>
  "nonce" : n,           (numeric) The nonce<br>
  "bits" : "1d00ffff", (string) The bits<br>
  "difficulty" : x.xxx,  (numeric) The difficulty<br>
  "chainwork" : "xxxx",  (string) Expected number of hashes required to produce the chain up to this block (in hex)<br>
  "nTx" : n,             (numeric) The number of transactions in the block.<br>
  "previousblockhash" : "hash",  (string) The hash of the previous block<br>
  "nextblockhash" : "hash"       (string) The hash of the next block<br>
}<br>
<br>
Result (for verbosity = 2):<br>
{<br>
  ...,                     Same output as verbosity = 1.<br>
  "tx" : [               (array of Objects) The transactions in the format of the getrawtransaction RPC. Different from verbosity = 1 "tx" result.<br>
         ,...<br>
  ],<br>
  ,...                     Same output as verbosity = 1.<br>
}<br>
<br>
Examples:<br>
> defi-cli getblock "00000000c937983704a73af28acdec37b049d214adbda81d7e2a3dd146f6ed09"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblock", "params": ["00000000c937983704a73af28acdec37b049d214adbda81d7e2a3dd146f6ed09"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getblockchaininfo</summary><p>
getblockchaininfo<br>
Returns an object containing various state info regarding blockchain processing.<br>
<br>
Result:<br>
{<br>
  "chain": "xxxx",              (string) current network name as defined in BIP70 (main, test, regtest)<br>
  "blocks": xxxxxx,             (numeric) the height of the most-work fully-validated chain. The genesis block has height 0<br>
  "headers": xxxxxx,            (numeric) the current number of headers we have validated<br>
  "bestblockhash": "...",       (string) the hash of the currently best block<br>
  "difficulty": xxxxxx,         (numeric) the current difficulty<br>
  "mediantime": xxxxxx,         (numeric) median time for the current best block<br>
  "verificationprogress": xxxx, (numeric) estimate of verification progress [0..1]<br>
  "initialblockdownload": xxxx, (bool) (debug information) estimate of whether this node is in Initial Block Download mode.<br>
  "chainwork": "xxxx"           (string) total amount of work in active chain, in hexadecimal<br>
  "size_on_disk": xxxxxx,       (numeric) the estimated size of the block and undo files on disk<br>
  "pruned": xx,                 (boolean) if the blocks are subject to pruning<br>
  "pruneheight": xxxxxx,        (numeric) lowest-height complete block stored (only present if pruning is enabled)<br>
  "automatic_pruning": xx,      (boolean) whether automatic pruning is enabled (only present if pruning is enabled)<br>
  "prune_target_size": xxxxxx,  (numeric) the target size used by pruning (only present if automatic pruning is enabled)<br>
  "softforks": {                (object) status of softforks<br>
     "xxxx" : {                 (string) name of the softfork<br>
        "type": "xxxx",         (string) one of "buried", "bip9"<br>
        "bip9": {               (object) status of bip9 softforks (only for "bip9" type)<br>
           "status": "xxxx",    (string) one of "defined", "started", "locked_in", "active", "failed"<br>
           "bit": xx,           (numeric) the bit (0-28) in the block version field used to signal this softfork (only for "started" status)<br>
           "startTime": xx,     (numeric) the minimum median time past of a block at which the bit gains its meaning<br>
           "timeout": xx,       (numeric) the median time past of a block at which the deployment is considered failed if not yet locked in<br>
           "since": xx,         (numeric) height of the first block to which the status applies<br>
           "statistics": {      (object) numeric statistics about BIP9 signalling for a softfork<br>
              "period": xx,     (numeric) the length in blocks of the BIP9 signalling period <br>
              "threshold": xx,  (numeric) the number of blocks with the version bit set required to activate the feature <br>
              "elapsed": xx,    (numeric) the number of blocks elapsed since the beginning of the current period <br>
              "count": xx,      (numeric) the number of blocks with the version bit set in the current period <br>
              "possible": xx    (boolean) returns false if there are not enough blocks left in this period to pass activation threshold <br>
           }<br>
        },<br>
        "height": "xxxxxx",     (numeric) height of the first block which the rules are or will be enforced (only for "buried" type, or "bip9" type with "active" status)<br>
        "active": xx,           (boolean) true if the rules are enforced for the mempool and the next block<br>
     }<br>
  }<br>
  "warnings" : "...",           (string) any network and blockchain warnings.<br>
}<br>
<br>
Examples:<br>
> defi-cli getblockchaininfo <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockchaininfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getblockcount</summary><p>
getblockcount<br>
<br>
Returns the height of the most-work fully-validated chain.<br>
The genesis block has height 0.<br>
<br>
Result:<br>
n    (numeric) The current block count<br>
<br>
Examples:<br>
> defi-cli getblockcount <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockcount", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getblockfilter "blockhash" ( "filtertype" )</summary><p>
getblockfilter "blockhash" ( "filtertype" )<br>
<br>
Retrieve a BIP 157 content filter for a particular block.<br>
<br>
Arguments:<br>
1. blockhash     (string, required) The hash of the block<br>
2. filtertype    (string, optional, default=basic) The type name of the filter<br>
<br>
Result:<br>
{<br>
  "filter" : (string) the hex-encoded filter data<br>
  "header" : (string) the hex-encoded filter header<br>
}<br>
<br>
Examples:<br>
> defi-cli getblockfilter "00000000c937983704a73af28acdec37b049d214adbda81d7e2a3dd146f6ed09" "basic"<br>

</p></details>

<details><summary>getblockhash height</summary><p>
getblockhash height<br>
<br>
Returns hash of block in best-block-chain at height provided.<br>
<br>
Arguments:<br>
1. height    (numeric, required) The height index<br>
<br>
Result:<br>
"hash"         (string) The block hash<br>
<br>
Examples:<br>
> defi-cli getblockhash 1000<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockhash", "params": [1000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getblockheader "blockhash" ( verbose )</summary><p>
getblockheader "blockhash" ( verbose )<br>
<br>
If verbose is false, returns a string that is serialized, hex-encoded data for blockheader 'hash'.<br>
If verbose is true, returns an Object with information about blockheader <hash>.<br>
<br>
Arguments:<br>
1. blockhash    (string, required) The block hash<br>
2. verbose      (boolean, optional, default=true) true for a json object, false for the hex-encoded data<br>
<br>
Result (for verbose = true):<br>
{<br>
  "hash" : "hash",     (string) the block hash (same as provided)<br>
  "confirmations" : n,   (numeric) The number of confirmations, or -1 if the block is not on the main chain<br>
  "height" : n,          (numeric) The block height or index<br>
  "version" : n,         (numeric) The block version<br>
  "versionHex" : "00000000", (string) The block version formatted in hexadecimal<br>
  "merkleroot" : "xxxx", (string) The merkle root<br>
  "time" : ttt,          (numeric) The block time in seconds since epoch (Jan 1 1970 GMT)<br>
  "mediantime" : ttt,    (numeric) The median block time in seconds since epoch (Jan 1 1970 GMT)<br>
  "nonce" : n,           (numeric) The nonce<br>
  "bits" : "1d00ffff", (string) The bits<br>
  "difficulty" : x.xxx,  (numeric) The difficulty<br>
  "chainwork" : "0000...1f3"     (string) Expected number of hashes required to produce the current chain (in hex)<br>
  "nTx" : n,             (numeric) The number of transactions in the block.<br>
  "previousblockhash" : "hash",  (string) The hash of the previous block<br>
  "nextblockhash" : "hash",      (string) The hash of the next block<br>
}<br>
<br>
Result (for verbose=false):<br>
"data"             (string) A string that is serialized, hex-encoded data for block 'hash'.<br>
<br>
Examples:<br>
> defi-cli getblockheader "00000000c937983704a73af28acdec37b049d214adbda81d7e2a3dd146f6ed09"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockheader", "params": ["00000000c937983704a73af28acdec37b049d214adbda81d7e2a3dd146f6ed09"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getblockstats hash_or_height ( stats )</summary><p>
getblockstats hash_or_height ( stats )<br>
<br>
Compute per block statistics for a given window. All amounts are in satoshis.<br>
It won't work for some heights with pruning.<br>
<br>
Arguments:<br>
1. hash_or_height    (string or numeric, required) The block hash or height of the target block<br>
2. stats             (json array, optional, default=all values) Values to plot (see result below)<br>
     [<br>
       "height",     (string) Selected statistic<br>
       "time",       (string) Selected statistic<br>
       ...<br>
     ]<br>
<br>
Result:<br>
{                           (json object)<br>
  "avgfee": xxxxx,          (numeric) Average fee in the block<br>
  "avgfeerate": xxxxx,      (numeric) Average feerate (in satoshis per virtual byte)<br>
  "avgtxsize": xxxxx,       (numeric) Average transaction size<br>
  "blockhash": xxxxx,       (string) The block hash (to check for potential reorgs)<br>
  "feerate_percentiles": [  (array of numeric) Feerates at the 10th, 25th, 50th, 75th, and 90th percentile weight unit (in satoshis per virtual byte)<br>
      "10th_percentile_feerate",      (numeric) The 10th percentile feerate<br>
      "25th_percentile_feerate",      (numeric) The 25th percentile feerate<br>
      "50th_percentile_feerate",      (numeric) The 50th percentile feerate<br>
      "75th_percentile_feerate",      (numeric) The 75th percentile feerate<br>
      "90th_percentile_feerate",      (numeric) The 90th percentile feerate<br>
  ],<br>
  "height": xxxxx,          (numeric) The height of the block<br>
  "ins": xxxxx,             (numeric) The number of inputs (excluding coinbase)<br>
  "maxfee": xxxxx,          (numeric) Maximum fee in the block<br>
  "maxfeerate": xxxxx,      (numeric) Maximum feerate (in satoshis per virtual byte)<br>
  "maxtxsize": xxxxx,       (numeric) Maximum transaction size<br>
  "medianfee": xxxxx,       (numeric) Truncated median fee in the block<br>
  "mediantime": xxxxx,      (numeric) The block median time past<br>
  "mediantxsize": xxxxx,    (numeric) Truncated median transaction size<br>
  "minfee": xxxxx,          (numeric) Minimum fee in the block<br>
  "minfeerate": xxxxx,      (numeric) Minimum feerate (in satoshis per virtual byte)<br>
  "mintxsize": xxxxx,       (numeric) Minimum transaction size<br>
  "outs": xxxxx,            (numeric) The number of outputs<br>
  "subsidy": xxxxx,         (numeric) The block subsidy<br>
  "swtotal_size": xxxxx,    (numeric) Total size of all segwit transactions<br>
  "swtotal_weight": xxxxx,  (numeric) Total weight of all segwit transactions divided by segwit scale factor (4)<br>
  "swtxs": xxxxx,           (numeric) The number of segwit transactions<br>
  "time": xxxxx,            (numeric) The block time<br>
  "total_out": xxxxx,       (numeric) Total amount in all outputs (excluding coinbase and thus reward [ie subsidy + totalfee])<br>
  "total_size": xxxxx,      (numeric) Total size of all non-coinbase transactions<br>
  "total_weight": xxxxx,    (numeric) Total weight of all non-coinbase transactions divided by segwit scale factor (4)<br>
  "totalfee": xxxxx,        (numeric) The fee total<br>
  "txs": xxxxx,             (numeric) The number of transactions (excluding coinbase)<br>
  "utxo_increase": xxxxx,   (numeric) The increase/decrease in the number of unspent outputs<br>
  "utxo_size_inc": xxxxx,   (numeric) The increase/decrease in size for the utxo index (not discounting op_return and similar)<br>
}<br>
<br>
Examples:<br>
> defi-cli getblockstats 1000 '["minfeerate","avgfeerate"]'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockstats", "params": [1000 '["minfeerate","avgfeerate"]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getchaintips</summary><p>
getchaintips<br>
Return information about all known tips in the block tree, including the main chain as well as orphaned branches.<br>
<br>
Result:<br>
[<br>
  {<br>
    "height": xxxx,         (numeric) height of the chain tip<br>
    "hash": "xxxx",         (string) block hash of the tip<br>
    "branchlen": 0          (numeric) zero for main chain<br>
    "status": "active"      (string) "active" for the main chain<br>
  },<br>
  {<br>
    "height": xxxx,<br>
    "hash": "xxxx",<br>
    "branchlen": 1          (numeric) length of branch connecting the tip to the main chain<br>
    "status": "xxxx"        (string) status of the chain (active, valid-fork, valid-headers, headers-only, invalid)<br>
  }<br>
]<br>
Possible values for status:<br>
1.  "invalid"               This branch contains at least one invalid block<br>
2.  "headers-only"          Not all blocks for this branch are available, but the headers are valid<br>
3.  "valid-headers"         All blocks are available for this branch, but they were never fully validated<br>
4.  "valid-fork"            This branch is not part of the active chain, but is fully validated<br>
5.  "active"                This is the tip of the active main chain, which is certainly valid<br>
<br>
Examples:<br>
> defi-cli getchaintips <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getchaintips", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getchaintxstats ( nblocks "blockhash" )</summary><p>
getchaintxstats ( nblocks "blockhash" )<br>
<br>
Compute statistics about the total number and rate of transactions in the chain.<br>
<br>
Arguments:<br>
1. nblocks      (numeric, optional, default=one month) Size of the window in number of blocks<br>
2. blockhash    (string, optional, default=chain tip) The hash of the block that ends the window.<br>
<br>
Result:<br>
{<br>
  "time": xxxxx,                         (numeric) The timestamp for the final block in the window in UNIX format.<br>
  "txcount": xxxxx,                      (numeric) The total number of transactions in the chain up to that point.<br>
  "window_final_block_hash": "...",      (string) The hash of the final block in the window.<br>
  "window_final_block_height": xxxxx,    (numeric) The height of the final block in the window.<br>
  "window_block_count": xxxxx,           (numeric) Size of the window in number of blocks.<br>
  "window_tx_count": xxxxx,              (numeric) The number of transactions in the window. Only returned if "window_block_count" is > 0.<br>
  "window_interval": xxxxx,              (numeric) The elapsed time in the window in seconds. Only returned if "window_block_count" is > 0.<br>
  "txrate": x.xx,                        (numeric) The average rate of transactions per second in the window. Only returned if "window_interval" is > 0.<br>
}<br>
<br>
Examples:<br>
> defi-cli getchaintxstats <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getchaintxstats", "params": [2016] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getdifficulty</summary><p>
getdifficulty<br>
<br>
Returns the proof-of-work difficulty as a multiple of the minimum difficulty.<br>
<br>
Result:<br>
n.nnn       (numeric) the proof-of-work difficulty as a multiple of the minimum difficulty.<br>
<br>
Examples:<br>
> defi-cli getdifficulty <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getdifficulty", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getgov "name"</summary><p>
getgov "name"<br>
<br>
Returns information about governance variable:<br>
ATTRIBUTES, ICX_TAKERFEE_PER_BTC, LP_DAILY_LOAN_TOKEN_REWARD, LP_LOAN_TOKEN_SPLITS, LP_DAILY_DFI_REWARD,<br>
LOAN_LIQUIDATION_PENALTY, LP_SPLITS, ORACLE_BLOCK_INTERVAL, ORACLE_DEVIATION<br>
<br>
Arguments:<br>
1. name    (string, required) Variable name<br>
<br>
Result:<br>
{id:{...}}     (array) Json object with variable information<br>
<br>
Examples:<br>
> defi-cli getgov LP_SPLITS<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getgov", "params": [LP_DAILY_DFI_REWARD] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getmempoolancestors "txid" ( verbose )</summary><p>
getmempoolancestors "txid" ( verbose )<br>
<br>
If txid is in the mempool, returns all in-mempool ancestors.<br>
<br>
Arguments:<br>
1. txid       (string, required) The transaction id (must be in mempool)<br>
2. verbose    (boolean, optional, default=false) True for a json object, false for array of transaction ids<br>
<br>
Result (for verbose = false):<br>
[                       (json array of strings)<br>
  "transactionid"           (string) The transaction id of an in-mempool ancestor transaction<br>
  ,...<br>
]<br>
<br>
Result (for verbose = true):<br>
{                           (json object)<br>
  "transactionid" : {       (json object)<br>
    "vsize" : n,            (numeric) virtual transaction size as defined in BIP 141. This is different from actual serialized size for witness transactions as witness data is discounted.<br>
    "size" : n,             (numeric) (DEPRECATED) same as vsize. Only returned if defid is started with -deprecatedrpc=size<br>
                              size will be completely removed in v0.20.<br>
    "weight" : n,           (numeric) transaction weight as defined in BIP 141.<br>
    "fee" : n,              (numeric) transaction fee in DFI (DEPRECATED)<br>
    "modifiedfee" : n,      (numeric) transaction fee with fee deltas used for mining priority (DEPRECATED)<br>
    "time" : n,             (numeric) local time transaction entered pool in seconds since 1 Jan 1970 GMT<br>
    "height" : n,           (numeric) block height when transaction entered pool<br>
    "descendantcount" : n,  (numeric) number of in-mempool descendant transactions (including this one)<br>
    "descendantsize" : n,   (numeric) virtual transaction size of in-mempool descendants (including this one)<br>
    "descendantfees" : n,   (numeric) modified fees (see above) of in-mempool descendants (including this one) (DEPRECATED)<br>
    "ancestorcount" : n,    (numeric) number of in-mempool ancestor transactions (including this one)<br>
    "ancestorsize" : n,     (numeric) virtual transaction size of in-mempool ancestors (including this one)<br>
    "ancestorfees" : n,     (numeric) modified fees (see above) of in-mempool ancestors (including this one) (DEPRECATED)<br>
    "wtxid" : hash,         (string) hash of serialized transaction, including witness data<br>
    "fees" : {<br>
        "base" : n,         (numeric) transaction fee in DFI<br>
        "modified" : n,     (numeric) transaction fee with fee deltas used for mining priority in DFI<br>
        "ancestor" : n,     (numeric) modified fees (see above) of in-mempool ancestors (including this one) in DFI<br>
        "descendant" : n,   (numeric) modified fees (see above) of in-mempool descendants (including this one) in DFI<br>
    }<br>
    "depends" : [           (array) unconfirmed transactions used as inputs for this transaction<br>
        "transactionid",    (string) parent transaction id<br>
       ... ]<br>
    "spentby" : [           (array) unconfirmed transactions spending outputs from this transaction<br>
        "transactionid",    (string) child transaction id<br>
       ... ]<br>
    "bip125-replaceable" : true|false,  (boolean) Whether this transaction could be replaced due to BIP125 (replace-by-fee)<br>
  }, ...<br>
}<br>
<br>
Examples:<br>
> defi-cli getmempoolancestors "mytxid"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmempoolancestors", "params": ["mytxid"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getmempooldescendants "txid" ( verbose )</summary><p>
getmempooldescendants "txid" ( verbose )<br>
<br>
If txid is in the mempool, returns all in-mempool descendants.<br>
<br>
Arguments:<br>
1. txid       (string, required) The transaction id (must be in mempool)<br>
2. verbose    (boolean, optional, default=false) True for a json object, false for array of transaction ids<br>
<br>
Result (for verbose = false):<br>
[                       (json array of strings)<br>
  "transactionid"           (string) The transaction id of an in-mempool descendant transaction<br>
  ,...<br>
]<br>
<br>
Result (for verbose = true):<br>
{                           (json object)<br>
  "transactionid" : {       (json object)<br>
    "vsize" : n,            (numeric) virtual transaction size as defined in BIP 141. This is different from actual serialized size for witness transactions as witness data is discounted.<br>
    "size" : n,             (numeric) (DEPRECATED) same as vsize. Only returned if defid is started with -deprecatedrpc=size<br>
                              size will be completely removed in v0.20.<br>
    "weight" : n,           (numeric) transaction weight as defined in BIP 141.<br>
    "fee" : n,              (numeric) transaction fee in DFI (DEPRECATED)<br>
    "modifiedfee" : n,      (numeric) transaction fee with fee deltas used for mining priority (DEPRECATED)<br>
    "time" : n,             (numeric) local time transaction entered pool in seconds since 1 Jan 1970 GMT<br>
    "height" : n,           (numeric) block height when transaction entered pool<br>
    "descendantcount" : n,  (numeric) number of in-mempool descendant transactions (including this one)<br>
    "descendantsize" : n,   (numeric) virtual transaction size of in-mempool descendants (including this one)<br>
    "descendantfees" : n,   (numeric) modified fees (see above) of in-mempool descendants (including this one) (DEPRECATED)<br>
    "ancestorcount" : n,    (numeric) number of in-mempool ancestor transactions (including this one)<br>
    "ancestorsize" : n,     (numeric) virtual transaction size of in-mempool ancestors (including this one)<br>
    "ancestorfees" : n,     (numeric) modified fees (see above) of in-mempool ancestors (including this one) (DEPRECATED)<br>
    "wtxid" : hash,         (string) hash of serialized transaction, including witness data<br>
    "fees" : {<br>
        "base" : n,         (numeric) transaction fee in DFI<br>
        "modified" : n,     (numeric) transaction fee with fee deltas used for mining priority in DFI<br>
        "ancestor" : n,     (numeric) modified fees (see above) of in-mempool ancestors (including this one) in DFI<br>
        "descendant" : n,   (numeric) modified fees (see above) of in-mempool descendants (including this one) in DFI<br>
    }<br>
    "depends" : [           (array) unconfirmed transactions used as inputs for this transaction<br>
        "transactionid",    (string) parent transaction id<br>
       ... ]<br>
    "spentby" : [           (array) unconfirmed transactions spending outputs from this transaction<br>
        "transactionid",    (string) child transaction id<br>
       ... ]<br>
    "bip125-replaceable" : true|false,  (boolean) Whether this transaction could be replaced due to BIP125 (replace-by-fee)<br>
  }, ...<br>
}<br>
<br>
Examples:<br>
> defi-cli getmempooldescendants "mytxid"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmempooldescendants", "params": ["mytxid"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getmempoolentry "txid"</summary><p>
getmempoolentry "txid"<br>
<br>
Returns mempool data for given transaction<br>
<br>
Arguments:<br>
1. txid    (string, required) The transaction id (must be in mempool)<br>
<br>
Result:<br>
{                           (json object)<br>
    "vsize" : n,            (numeric) virtual transaction size as defined in BIP 141. This is different from actual serialized size for witness transactions as witness data is discounted.<br>
    "size" : n,             (numeric) (DEPRECATED) same as vsize. Only returned if defid is started with -deprecatedrpc=size<br>
                              size will be completely removed in v0.20.<br>
    "weight" : n,           (numeric) transaction weight as defined in BIP 141.<br>
    "fee" : n,              (numeric) transaction fee in DFI (DEPRECATED)<br>
    "modifiedfee" : n,      (numeric) transaction fee with fee deltas used for mining priority (DEPRECATED)<br>
    "time" : n,             (numeric) local time transaction entered pool in seconds since 1 Jan 1970 GMT<br>
    "height" : n,           (numeric) block height when transaction entered pool<br>
    "descendantcount" : n,  (numeric) number of in-mempool descendant transactions (including this one)<br>
    "descendantsize" : n,   (numeric) virtual transaction size of in-mempool descendants (including this one)<br>
    "descendantfees" : n,   (numeric) modified fees (see above) of in-mempool descendants (including this one) (DEPRECATED)<br>
    "ancestorcount" : n,    (numeric) number of in-mempool ancestor transactions (including this one)<br>
    "ancestorsize" : n,     (numeric) virtual transaction size of in-mempool ancestors (including this one)<br>
    "ancestorfees" : n,     (numeric) modified fees (see above) of in-mempool ancestors (including this one) (DEPRECATED)<br>
    "wtxid" : hash,         (string) hash of serialized transaction, including witness data<br>
    "fees" : {<br>
        "base" : n,         (numeric) transaction fee in DFI<br>
        "modified" : n,     (numeric) transaction fee with fee deltas used for mining priority in DFI<br>
        "ancestor" : n,     (numeric) modified fees (see above) of in-mempool ancestors (including this one) in DFI<br>
        "descendant" : n,   (numeric) modified fees (see above) of in-mempool descendants (including this one) in DFI<br>
    }<br>
    "depends" : [           (array) unconfirmed transactions used as inputs for this transaction<br>
        "transactionid",    (string) parent transaction id<br>
       ... ]<br>
    "spentby" : [           (array) unconfirmed transactions spending outputs from this transaction<br>
        "transactionid",    (string) child transaction id<br>
       ... ]<br>
    "bip125-replaceable" : true|false,  (boolean) Whether this transaction could be replaced due to BIP125 (replace-by-fee)<br>
}<br>
<br>
Examples:<br>
> defi-cli getmempoolentry "mytxid"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmempoolentry", "params": ["mytxid"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getmempoolinfo</summary><p>
getmempoolinfo<br>
<br>
Returns details on the active state of the TX memory pool.<br>
<br>
Result:<br>
{<br>
  "loaded": true|false         (boolean) True if the mempool is fully loaded<br>
  "size": xxxxx,               (numeric) Current tx count<br>
  "bytes": xxxxx,              (numeric) Sum of all virtual transaction sizes as defined in BIP 141. Differs from actual serialized size because witness data is discounted<br>
  "usage": xxxxx,              (numeric) Total memory usage for the mempool<br>
  "maxmempool": xxxxx,         (numeric) Maximum memory usage for the mempool<br>
  "mempoolminfee": xxxxx       (numeric) Minimum fee rate in DFI/kB for tx to be accepted. Is the maximum of minrelaytxfee and minimum mempool fee<br>
  "minrelaytxfee": xxxxx       (numeric) Current minimum relay fee for transactions<br>
}<br>
<br>
Examples:<br>
> defi-cli getmempoolinfo <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmempoolinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getrawmempool ( verbose )</summary><p>
getrawmempool ( verbose )<br>
<br>
Returns all transaction ids in memory pool as a json array of string transaction ids.<br>
<br>
Hint: use getmempoolentry to fetch a specific transaction from the mempool.<br>
<br>
Arguments:<br>
1. verbose    (boolean, optional, default=false) True for a json object, false for array of transaction ids<br>
<br>
Result (for verbose = false):<br>
[                     (json array of string)<br>
  "transactionid"     (string) The transaction id<br>
  ,...<br>
]<br>
<br>
Result: (for verbose = true):<br>
{                           (json object)<br>
  "transactionid" : {       (json object)<br>
    "vsize" : n,            (numeric) virtual transaction size as defined in BIP 141. This is different from actual serialized size for witness transactions as witness data is discounted.<br>
    "size" : n,             (numeric) (DEPRECATED) same as vsize. Only returned if defid is started with -deprecatedrpc=size<br>
                              size will be completely removed in v0.20.<br>
    "weight" : n,           (numeric) transaction weight as defined in BIP 141.<br>
    "fee" : n,              (numeric) transaction fee in DFI (DEPRECATED)<br>
    "modifiedfee" : n,      (numeric) transaction fee with fee deltas used for mining priority (DEPRECATED)<br>
    "time" : n,             (numeric) local time transaction entered pool in seconds since 1 Jan 1970 GMT<br>
    "height" : n,           (numeric) block height when transaction entered pool<br>
    "descendantcount" : n,  (numeric) number of in-mempool descendant transactions (including this one)<br>
    "descendantsize" : n,   (numeric) virtual transaction size of in-mempool descendants (including this one)<br>
    "descendantfees" : n,   (numeric) modified fees (see above) of in-mempool descendants (including this one) (DEPRECATED)<br>
    "ancestorcount" : n,    (numeric) number of in-mempool ancestor transactions (including this one)<br>
    "ancestorsize" : n,     (numeric) virtual transaction size of in-mempool ancestors (including this one)<br>
    "ancestorfees" : n,     (numeric) modified fees (see above) of in-mempool ancestors (including this one) (DEPRECATED)<br>
    "wtxid" : hash,         (string) hash of serialized transaction, including witness data<br>
    "fees" : {<br>
        "base" : n,         (numeric) transaction fee in DFI<br>
        "modified" : n,     (numeric) transaction fee with fee deltas used for mining priority in DFI<br>
        "ancestor" : n,     (numeric) modified fees (see above) of in-mempool ancestors (including this one) in DFI<br>
        "descendant" : n,   (numeric) modified fees (see above) of in-mempool descendants (including this one) in DFI<br>
    }<br>
    "depends" : [           (array) unconfirmed transactions used as inputs for this transaction<br>
        "transactionid",    (string) parent transaction id<br>
       ... ]<br>
    "spentby" : [           (array) unconfirmed transactions spending outputs from this transaction<br>
        "transactionid",    (string) child transaction id<br>
       ... ]<br>
    "bip125-replaceable" : true|false,  (boolean) Whether this transaction could be replaced due to BIP125 (replace-by-fee)<br>
  }, ...<br>
}<br>
<br>
Examples:<br>
> defi-cli getrawmempool true<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getrawmempool", "params": [true] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>gettxout "txid" n ( include_mempool )</summary><p>
gettxout "txid" n ( include_mempool )<br>
<br>
Returns details about an unspent transaction output.<br>
<br>
Arguments:<br>
1. txid               (string, required) The transaction id<br>
2. n                  (numeric, required) vout number<br>
3. include_mempool    (boolean, optional, default=true) Whether to include the mempool. Note that an unspent output that is spent in the mempool won't appear.<br>
<br>
Result:<br>
{<br>
  "bestblock":  "hash",    (string) The hash of the block at the tip of the chain<br>
  "confirmations" : n,       (numeric) The number of confirmations<br>
  "value" : x.xxx,           (numeric) The transaction value in DFI<br>
  "scriptPubKey" : {         (json object)<br>
     "asm" : "code",       (string) <br>
     "hex" : "hex",        (string) <br>
     "reqSigs" : n,          (numeric) Number of required signatures<br>
     "type" : "pubkeyhash", (string) The type, eg pubkeyhash<br>
     "addresses" : [          (array of string) array of defi addresses<br>
        "address"     (string) defi address<br>
        ,...<br>
     ]<br>
  },<br>
  "coinbase" : true|false   (boolean) Coinbase or not<br>
}<br>
<br>
Examples:<br>
<br>
Get unspent transactions<br>
> defi-cli listunspent <br>
<br>
View the details<br>
> defi-cli gettxout "txid" 1<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "gettxout", "params": ["txid", 1] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>gettxoutproof ["txid",...] ( "blockhash" )</summary><p>
gettxoutproof ["txid",...] ( "blockhash" )<br>
<br>
Returns a hex-encoded proof that "txid" was included in a block.<br>
<br>
NOTE: By default this function only works sometimes. This is when there is an<br>
unspent output in the utxo for this transaction. To make it always work,<br>
you need to maintain a transaction index, using the -txindex command line option or<br>
specify the block in which the transaction is included manually (by blockhash).<br>
<br>
Arguments:<br>
1. txids          (json array, required) A json array of txids to filter<br>
     [<br>
       "txid",    (string) A transaction hash<br>
       ...<br>
     ]<br>
2. blockhash      (string, optional) If specified, looks for txid in the block with this hash<br>
<br>
Result:<br>
"data"           (string) A string that is a serialized, hex-encoded data for the proof.<br>

</p></details>

<details><summary>gettxoutsetinfo</summary><p>
gettxoutsetinfo<br>
<br>
Returns statistics about the unspent transaction output set.<br>
Note this call may take some time.<br>
<br>
Result:<br>
{<br>
  "height":n,     (numeric) The current block height (index)<br>
  "bestblock": "hex",   (string) The hash of the block at the tip of the chain<br>
  "transactions": n,      (numeric) The number of transactions with unspent outputs<br>
  "txouts": n,            (numeric) The number of unspent transaction outputs<br>
  "bogosize": n,          (numeric) A meaningless metric for UTXO set size<br>
  "hash_serialized_2": "hash", (string) The serialized hash<br>
  "disk_size": n,         (numeric) The estimated size of the chainstate on disk<br>
  "total_amount": x.xxx          (numeric) The total amount<br>
}<br>
<br>
Examples:<br>
> defi-cli gettxoutsetinfo <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "gettxoutsetinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>isappliedcustomtx "txid" blockHeight</summary><p>
isappliedcustomtx "txid" blockHeight<br>
<br>
Checks that custom transaction was affected on chain<br>
<br>
Arguments:<br>
1. txid           (string, required) A transaction hash<br>
2. blockHeight    (numeric, required) The height of block which contain tx<br>
<br>
Result:<br>
(bool) The boolean indicate that custom transaction was affected on chain<br>
<br>
Examples:<br>
> defi-cli isappliedcustomtx b2bb09ffe9f9b292f13d23bafa1225ef26d0b9906da7af194c5738b63839b235 1005<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "isappliedcustomtx", "params": [b2bb09ffe9f9b292f13d23bafa1225ef26d0b9906da7af194c5738b63839b235 1005] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listgovs ( "prefix" )</summary><p>
listgovs ( "prefix" )<br>
<br>
Returns information about all governance variables including pending changes<br>
<br>
Arguments:<br>
1. prefix    (string) One of all, gov, attrs, live. Defaults to the all view. Any other string is treated as<br>
             a prefix of attributes to filter with. `v0/` is assumed if not explicitly provided.<br>
<br>
Result:<br>
[[{id:{...}},{height:{...}},...], ...]     (array) Json array with JSON objects with variable information<br>
<br>
Examples:<br>
> defi-cli listgovs <br>
> defi-cli listgovs gov<br>
> defi-cli listgovs live<br>
> defi-cli listgovs token/<br>
> defi-cli listgovs token/15<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listgovs", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listgovs", "params": [live] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> defi-cli listgovs token/<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listgovs", "params": [token/15] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listsmartcontracts</summary><p>
listsmartcontracts<br>
<br>
Returns information on smart contracts<br>
<br>
Result:<br>
(array) JSON array with smart contract information<br>
"name":"name"         smart contract name<br>
"address":"address"   smart contract address<br>
"token id":x.xxxxxxxx   smart contract balance per token<br>
<br>
Examples:<br>
> defi-cli listsmartcontracts <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listsmartcontracts", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>preciousblock "blockhash"</summary><p>
preciousblock "blockhash"<br>
<br>
Treats a block as if it were received before others with the same work.<br>
<br>
A later preciousblock call can override the effect of an earlier one.<br>
<br>
The effects of preciousblock are not retained across restarts.<br>
<br>
Arguments:<br>
1. blockhash    (string, required) the hash of the block to mark as precious<br>
<br>
Examples:<br>
> defi-cli preciousblock "blockhash"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "preciousblock", "params": ["blockhash"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>pruneblockchain height</summary><p>
pruneblockchain height<br>
<br>
Arguments:<br>
1. height    (numeric, required) The block height to prune up to. May be set to a discrete height, or a unix timestamp<br>
             to prune blocks whose block time is at least 2 hours older than the provided timestamp.<br>
<br>
Result:<br>
n    (numeric) Height of the last block pruned.<br>
<br>
Examples:<br>
> defi-cli pruneblockchain 1000<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "pruneblockchain", "params": [1000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>savemempool</summary><p>
savemempool<br>
<br>
Dumps the mempool to disk. It will fail until the previous dump is fully loaded.<br>
<br>
Examples:<br>
> defi-cli savemempool <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "savemempool", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>scantxoutset "action" [scanobjects,...]</summary><p>
scantxoutset "action" [scanobjects,...]<br>
<br>
EXPERIMENTAL warning: this call may be removed or changed in future releases.<br>
<br>
Scans the unspent transaction output set for entries that match certain output descriptors.<br>
Examples of output descriptors are:<br>
    addr(<address>)                      Outputs whose scriptPubKey corresponds to the specified address (does not include P2PK)<br>
    raw(<hex script>)                    Outputs whose scriptPubKey equals the specified hex scripts<br>
    combo(<pubkey>)                      P2PK, P2PKH, P2WPKH, and P2SH-P2WPKH outputs for the given pubkey<br>
    pkh(<pubkey>)                        P2PKH outputs for the given pubkey<br>
    sh(multi(<n>,<pubkey>,<pubkey>,...)) P2SH-multisig outputs for the given threshold and pubkeys<br>
<br>
In the above, <pubkey> either refers to a fixed public key in hexadecimal notation, or to an xpub/xprv optionally followed by one<br>
or more path elements separated by "/", and optionally ending in "/*" (unhardened), or "/*'" or "/*h" (hardened) to specify all<br>
unhardened or hardened child keys.<br>
In the latter case, a range needs to be specified by below if different from 1000.<br>
For more information on output descriptors, see the documentation in the doc/descriptors.md file.<br>
<br>
Arguments:<br>
1. action                        (string, required) The action to execute<br>
                                 "start" for starting a scan<br>
                                 "abort" for aborting the current scan (returns true when abort was successful)<br>
                                 "status" for progress report (in %) of the current scan<br>
2. scanobjects                   (json array, required) Array of scan objects<br>
                                 Every scan object is either a string descriptor or an object:<br>
     [<br>
       "descriptor",             (string) An output descriptor<br>
       {                         (json object) An object with output descriptor and metadata<br>
         "desc": "str",          (string, required) An output descriptor<br>
         "range": n or [n,n],    (numeric or array, optional, default=1000) The range of HD chain indexes to explore (either end or [begin,end])<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
{<br>
  "unspents": [<br>
    {<br>
    "txid" : "transactionid",     (string) The transaction id<br>
    "vout": n,                    (numeric) the vout value<br>
    "scriptPubKey" : "script",    (string) the script key<br>
    "desc" : "descriptor",        (string) A specialized descriptor for the matched scriptPubKey<br>
    "amount" : x.xxx,             (numeric) The total amount in DFI of the unspent output<br>
    "height" : n,                 (numeric) Height of the unspent transaction output<br>
   }<br>
   ,...], <br>
 "total_amount" : x.xxx,          (numeric) The total amount of all found unspent outputs in DFI<br>
]<br>

</p></details>

<details><summary>setgov {"name":"str"} ( [{"txid":"hex","vout":n},...] )</summary><p>
setgov {"name":"str"} ( [{"txid":"hex","vout":n},...] )<br>
<br>
Set special 'governance' variables:: ATTRIBUTES, ICX_TAKERFEE_PER_BTC, LP_LOAN_TOKEN_SPLITS, LP_SPLITS, ORACLE_BLOCK_INTERVAL, ORACLE_DEVIATION<br>
<br>
Arguments:<br>
1. variables               (json object, required) Object with variables<br>
     {<br>
       "name": "str",      (string, required) Variable's name is the key, value is the data. Exact data type depends on variable's name.<br>
     }<br>
2. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli setgov '{"LP_SPLITS": {"2":0.2,"3":0.8}'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "setgov", "params": ['{"ICX_TAKERFEE_PER_BTC":109440}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>setgovheight {"name":"str"} height ( [{"txid":"hex","vout":n},...] )</summary><p>
setgovheight {"name":"str"} height ( [{"txid":"hex","vout":n},...] )<br>
<br>
Change governance variable at height: ATTRIBUTES, ICX_TAKERFEE_PER_BTC, LP_LOAN_TOKEN_SPLITS, LP_SPLITS, ORACLE_DEVIATION<br>
<br>
Arguments:<br>
1. variables               (json object, required) Object with variable<br>
     {<br>
       "name": "str",      (string, required) Variable name is the key, value is the data. Exact data type depends on variable name.<br>
     }<br>
2. height                  (numeric, required) Start height for the changes to take effect.<br>
3. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli setgovheight '{"LP_SPLITS": {"2":0.2,"3":0.8}' 100000<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "setgovheight", "params": ['{"ICX_TAKERFEE_PER_BTC":109440}', 100000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>unsetgov {"name":"str"} ( [{"txid":"hex","vout":n},...] )</summary><p>
unsetgov {"name":"str"} ( [{"txid":"hex","vout":n},...] )<br>
<br>
Unset special 'governance' variables:: ATTRIBUTES, ICX_TAKERFEE_PER_BTC, LP_LOAN_TOKEN_SPLITS, LP_SPLITS, ORACLE_BLOCK_INTERVAL, ORACLE_DEVIATION<br>
<br>
Arguments:<br>
1. variables               (json object, required) Object with variables<br>
     {<br>
       "name": "str",      (string, required) Variable's name is the key.<br>
     }<br>
2. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli unsetgov '{"LP_SPLITS": ["2","3"]'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "unsetgov", "params": ['{"ICX_TAKERFEE_PER_BTC"}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>verifychain ( checklevel nblocks )</summary><p>
verifychain ( checklevel nblocks )<br>
<br>
Verifies blockchain database.<br>
<br>
Arguments:<br>
1. checklevel    (numeric, optional, default=3, range=0-4) How thorough the block verification is.<br>
2. nblocks       (numeric, optional, default=6, 0=all) The number of blocks to check.<br>
<br>
Result:<br>
true|false       (boolean) Verified or not<br>
<br>
Examples:<br>
> defi-cli verifychain <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "verifychain", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>verifytxoutproof "proof"</summary><p>
verifytxoutproof "proof"<br>
<br>
Verifies that a proof points to a transaction in a block, returning the transaction it commits to<br>
and throwing an RPC error if the block is not in our best chain<br>
<br>
Arguments:<br>
1. proof    (string, required) The hex-encoded proof generated by gettxoutproof<br>
<br>
Result:<br>
["txid"]      (array, strings) The txid(s) which the proof commits to, or empty array if the proof can not be validated.<br>

</p></details>

## Control
<details><summary>getmemoryinfo ( "mode" )</summary><p>
getmemoryinfo ( "mode" )<br>
Returns an object containing information about memory usage.<br>
<br>
Arguments:<br>
1. mode    (string, optional, default="stats") determines what kind of information is returned.<br>
           - "stats" returns general statistics about memory usage in the daemon.<br>
           - "mallocinfo" returns an XML string describing low-level heap state (only available if compiled with glibc 2.10+).<br>
<br>
Result (mode "stats"):<br>
{<br>
  "locked": {               (json object) Information about locked memory manager<br>
    "used": xxxxx,          (numeric) Number of bytes used<br>
    "free": xxxxx,          (numeric) Number of bytes available in current arenas<br>
    "total": xxxxxxx,       (numeric) Total number of bytes managed<br>
    "locked": xxxxxx,       (numeric) Amount of bytes that succeeded locking. If this number is smaller than total, locking pages failed at some point and key data could be swapped to disk.<br>
    "chunks_used": xxxxx,   (numeric) Number allocated chunks<br>
    "chunks_free": xxxxx,   (numeric) Number unused chunks<br>
  }<br>
}<br>
<br>
Result (mode "mallocinfo"):<br>
"<malloc version="1">..."<br>
<br>
Examples:<br>
> defi-cli getmemoryinfo <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmemoryinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getrpcinfo</summary><p>
getrpcinfo<br>
<br>
Returns details of the RPC server.<br>
<br>
Result:<br>
{<br>
 "active_commands" (array) All active commands<br>
  [<br>
   {               (object) Information about an active command<br>
    "method"       (string)  The name of the RPC command <br>
    "duration"     (numeric)  The running time in microseconds<br>
   },...<br>
  ],<br>
 "logpath": "xxx" (string) The complete file path to the debug log<br>
}<br>
<br>
Examples:<br>
> defi-cli getrpcinfo <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getrpcinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>help ( "command" )</summary><p>
help ( "command" )<br>
<br>
List all commands, or get help for a specified command.<br>
<br>
Arguments:<br>
1. command    (string, optional, default=all commands) The command to get help on<br>
<br>
Result:<br>
"text"     (string) The help text<br>

</p></details>

<details><summary>logging ( ["include_category",...] ["exclude_category",...] )</summary><p>
logging ( ["include_category",...] ["exclude_category",...] )<br>
Gets and sets the logging configuration.<br>
When called without an argument, returns the list of categories with status that are currently being debug logged or not.<br>
When called with arguments, adds or removes categories from debug logging and return the lists above.<br>
The arguments are evaluated in order "include", "exclude".<br>
If an item is both included and excluded, it will thus end up being excluded.<br>
The valid logging categories are: accountchange, addrman, anchoring, bench, cmpctblock, coindb, customtxbench, db, estimatefee, futureswap, http, leveldb, libevent, loan, mempool, mempoolrej, net, oracle, proxy, prune, rand, reindex, rpc, rpccache, selectcoins, spv, staking, tokensplit, tor, zmq<br>
In addition, the following are available as category names with special meanings:<br>
  - "all",  "1" : represent all logging categories.<br>
  - "none", "0" : even if other logging categories are specified, ignore all of them.<br>
<br>
Arguments:<br>
1. include                    (json array, optional) A json array of categories to add debug logging<br>
     [<br>
       "include_category",    (string) the valid logging category<br>
       ...<br>
     ]<br>
2. exclude                    (json array, optional) A json array of categories to remove debug logging<br>
     [<br>
       "exclude_category",    (string) the valid logging category<br>
       ...<br>
     ]<br>
<br>
Result:<br>
{                   (json object where keys are the logging categories, and values indicates its status<br>
  "category": true|false,  (bool) if being debug logged or not. false:inactive, true:active<br>
  ...<br>
}<br>
<br>
Examples:<br>
> defi-cli logging "[\"all\"]" "[\"http\"]"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "logging", "params": [["all"], ["libevent"]] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>stop</summary><p>
stop<br>
<br>
Stop Defi server.
</p></details>

<details><summary>uptime</summary><p>
uptime<br>
<br>
Returns the total uptime of the server.<br>
<br>
Result:<br>
ttt        (numeric) The number of seconds that the server has been running<br>
<br>
Examples:<br>
> defi-cli uptime <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "uptime", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

## Generating
<details><summary>generatetoaddress nblocks "address" ( maxtries )</summary><p>
generatetoaddress nblocks "address" ( maxtries )<br>
<br>
Mine blocks immediately to a specified address (before the RPC call returns)<br>
<br>
Arguments:<br>
1. nblocks     (numeric, required) How many blocks are generated immediately.<br>
2. address     (string, required) The address to send the newly generated DFI to.<br>
3. maxtries    (numeric, optional, default=-1) How many iterations to try.<br>
<br>
Result:<br>
[ blockhashes ]     (array) hashes of blocks generated<br>
<br>
Examples:<br>
<br>
Generate 11 blocks to myaddress<br>
> defi-cli generatetoaddress 11 "myaddress"<br>
If you are running the DeFi Blockchain wallet, you can get a new address to send the newly generated DFI to with:<br>
> defi-cli getnewaddress <br>

</p></details>

## Icxorderbook
<details><summary>icx_claimdfchtlc ( {"dfchtlcTx":"str","seed":"str"} [{"txid":"hex","vout":n},...] )</summary><p>
icx_claimdfchtlc ( {"dfchtlcTx":"str","seed":"str"} [{"txid":"hex","vout":n},...] )<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>
<br>
Creates (and submits to local node and network) a dfc htlc transaction.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. htlc                       (json object)<br>
     {<br>
       "dfchtlcTx": "str",    (string, required) Txid of dfc htlc tx for which the claim is<br>
       "seed": "str",         (string, required) Secret seed for claiming htlc<br>
     }<br>
2. inputs                     (json array, optional) A json array of json objects<br>
     [<br>
       {                      (json object)<br>
         "txid": "hex",       (string, required) The transaction id<br>
         "vout": n,           (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli icx_claimdfchtlc '{"dfchtlcTx":"<txid>>","seed":"<seed>"}'<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>

</p></details>

<details><summary>icx_closeoffer "offerTx" ( [{"txid":"hex","vout":n},...] )</summary><p>
icx_closeoffer "offerTx" ( [{"txid":"hex","vout":n},...] )<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>
<br>
Closes (and submits to local node and network) offer transaction.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. offerTx                 (string, required) Txid of makeoffer<br>
2. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli closeOffer '{"offerTx":"<txid>>"}'<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>

</p></details>

<details><summary>icx_closeorder "orderTx" ( [{"txid":"hex","vout":n},...] )</summary><p>
icx_closeorder "orderTx" ( [{"txid":"hex","vout":n},...] )<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>
<br>
Closes (and submits to local node and network) order transaction.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. orderTx                 (string, required) Txid of order<br>
2. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli closeorder '{"orderTx":"<txid>>"}'<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>

</p></details>

<details><summary>icx_createorder {"tokenFrom|chainFrom":"str","chainTo|tokenTo":"str","ownerAddress":"str","receivePubkey":"str","amountFrom":n,"orderPrice":n,"expiry":n} ( [{"txid":"hex","vout":n},...] )</summary><p>
icx_createorder {"tokenFrom|chainFrom":"str","chainTo|tokenTo":"str","ownerAddress":"str","receivePubkey":"str","amountFrom":n,"orderPrice":n,"expiry":n} ( [{"txid":"hex","vout":n},...] )<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>
<br>
Creates (and submits to local node and network) a order creation transaction.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. order                                (json object, required)<br>
     {<br>
       "tokenFrom|chainFrom": "str",    (string) Symbol or id of selling token/chain<br>
       "chainTo|tokenTo": "str",        (string) Symbol or id of buying chain/token<br>
       "ownerAddress": "str",           (string, required) Address of DFI token for fees and selling tokens in case of EXT/DFC order type<br>
       "receivePubkey": "str",          (string) Pubkey which can claim external HTLC in case of DFC/EXT order type<br>
       "amountFrom": n,                 (numeric, required) "tokenFrom" coins amount<br>
       "orderPrice": n,                 (numeric, required) Price per unit<br>
       "expiry": n,                     (numeric) Number of blocks until the order expires (Default: 2880 DFI blocks)<br>
     }<br>
2. inputs                               (json array, optional) A json array of json objects<br>
     [<br>
       {                                (json object)<br>
         "txid": "hex",                 (string, required) The transaction id<br>
         "vout": n,                     (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli icx_createorder '{"ownerAddress":"<tokenAddress>","tokenFrom":"GOLD#128","chainTo":"BTC","amountFrom":"10","orderPrice":"10"}'<br>
> defi-cli icx_createorder '{"chainFrom":"BTC","tokenTo":"SILVER#129","amountFrom":"5","orderPrice":"0.01","expiry":"1000"}'<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>

</p></details>

<details><summary>icx_getorder "orderTx"</summary><p>
icx_getorder "orderTx"<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>
<br>
Return information about order or fillorder.<br>
<br>
Arguments:<br>
1. orderTx    (string, required) Txid of createorder or fulfillorder tx<br>
<br>
Result:<br>
{...}     (object) Json object with order information<br>
<br>
Examples:<br>
> defi-cli icx_getorder '{"orderTx":"<txid>>"}'<br>
XPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>

</p></details>

<details><summary>icx_listhtlcs {"offerTx":"str","limit":n,"closed":bool}</summary><p>
icx_listhtlcs {"offerTx":"str","limit":n,"closed":bool}<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>
<br>
Return information about orders.<br>
<br>
Arguments:<br>
1. by                       (json object, required)<br>
     {<br>
       "offerTx": "str",    (string, required) Offer txid  for which to list all HTLCS<br>
       "limit": n,          (numeric) Maximum number of orders to return (default: 20)<br>
       "closed": bool,      (boolean) Display also claimed, expired and refunded HTLCs (default: false)<br>
     }<br>
<br>
Result:<br>
{{...},...}     (array) Json object with orders information<br>
<br>
Examples:<br>
> defi-cli icx_listorders '{"offerTx":"<txid>"}'<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>

</p></details>

<details><summary>icx_listorders ( {"token":n,"chain":n,"orderTx":"str","limit":n,"closed":bool} )</summary><p>
icx_listorders ( {"token":n,"chain":n,"orderTx":"str","limit":n,"closed":bool} )<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>
<br>
Return information about orders.<br>
<br>
Arguments:<br>
1. by                       (json object)<br>
     {<br>
       "token": n,          (numeric) Token asset<br>
       "chain": n,          (numeric) Chain asset<br>
       "orderTx": "str",    (string) Order txid to list all offers for this order<br>
       "limit": n,          (numeric) Maximum number of orders to return (default: 50)<br>
       "closed": bool,      (boolean) Display closed orders (default: false)<br>
     }<br>
<br>
Result:<br>
{{...},...}     (array) Json object with orders information<br>
<br>
Examples:<br>
> defi-cli icx_listorders '{"limit":"10"}'<br>
> defi-cli icx_listorders '{"token":"GOLD#128","chain":"BTC"}'<br>
> defi-cli icx_listorders '{"chain":"BTC","token":"SILVER#129","closed":true}'<br>
> defi-cli icx_listorders '{"orderTx":"<txid>>"}'<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>

</p></details>

<details><summary>icx_makeoffer ( {"orderTx":"str","amount":n,"ownerAddress":"str","receivePubkey":"str","expiry":n} [{"txid":"hex","vout":n},...] )</summary><p>
icx_makeoffer ( {"orderTx":"str","amount":n,"ownerAddress":"str","receivePubkey":"str","expiry":n} [{"txid":"hex","vout":n},...] )<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>
<br>
Creates (and submits to local node and network) a makeoffer transaction.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. offer                          (json object)<br>
     {<br>
       "orderTx": "str",          (string, required) Txid of order tx for which is the offer<br>
       "amount": n,               (numeric, required) Amount fulfilling the order<br>
       "ownerAddress": "str",     (string, required) Address of DFI token and for receiving tokens in case of DFC/EXT order<br>
       "receivePubkey": "str",    (string) Pubkey which can claim external HTLC in case of EXT/DFC order type<br>
       "expiry": n,               (numeric) Number of blocks until the offer expires (Default: 10 DFI blocks)<br>
     }<br>
2. inputs                         (json array, optional) A json array of json objects<br>
     [<br>
       {                          (json object)<br>
         "txid": "hex",           (string, required) The transaction id<br>
         "vout": n,               (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli icx_makeoffer '{"orderTx":"<txid>","amount":"10",eceiveAddress":"<address>",}'<br>
> defi-cli icx_makeoffer '{"orderTx":"txid","amount":"10","ownerAddress":"<address>","receivePubkey":"<pubkey>"}'<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>

</p></details>

<details><summary>icx_submitdfchtlc ( {"offerTx":"str","amount":n,"hash":"str","timeout":n} [{"txid":"hex","vout":n},...] )</summary><p>
icx_submitdfchtlc ( {"offerTx":"str","amount":n,"hash":"str","timeout":n} [{"txid":"hex","vout":n},...] )<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>
<br>
Creates (and submits to local node and network) a dfc htlc transaction.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. htlc                     (json object)<br>
     {<br>
       "offerTx": "str",    (string, required) Txid of offer tx for which the htlc is<br>
       "amount": n,         (numeric, required) Amount in htlc<br>
       "hash": "str",       (string, required) Hash of seed used for the hash lock part<br>
       "timeout": n,        (numeric) Timeout (absolute in blocks) for expiration of htlc in DFI blocks<br>
     }<br>
2. inputs                   (json array, optional) A json array of json objects<br>
     [<br>
       {                    (json object)<br>
         "txid": "hex",     (string, required) The transaction id<br>
         "vout": n,         (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli icx_submitdfchtlc '{"offerTx":"<txid>","amount":"10","receiveAddress":"<address>","hash":"<hash>","timeout":"50"}'<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>

</p></details>

<details><summary>icx_submitexthtlc ( {"offerTx":"str","amount":n,"htlcScriptAddress":"str","hash":"str","ownerPubkey":"str","timeout":n} [{"txid":"hex","vout":n},...] )</summary><p>
icx_submitexthtlc ( {"offerTx":"str","amount":n,"htlcScriptAddress":"str","hash":"str","ownerPubkey":"str","timeout":n} [{"txid":"hex","vout":n},...] )<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>
<br>
Creates (and submits to local node and network) ext htlc transaction.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. htlc                               (json object)<br>
     {<br>
       "offerTx": "str",              (string, required) Txid of offer tx for which the htlc is<br>
       "amount": n,                   (numeric, required) Amount in htlc<br>
       "htlcScriptAddress": "str",    (string, required) Script address of external htlc<br>
       "hash": "str",                 (string, required) Hash of seed used for the hash lock part<br>
       "ownerPubkey": "str",          (string, required) Pubkey of the owner to which the funds are refunded if HTLC timeouts<br>
       "timeout": n,                  (numeric, required) Timeout (absolute in block) for expiration of external htlc in external chain blocks<br>
     }<br>
2. inputs                             (json array, optional) A json array of json objects<br>
     [<br>
       {                              (json object)<br>
         "txid": "hex",               (string, required) The transaction id<br>
         "vout": n,                   (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli icx_submitexthtlc '{"offerTx":"<txid>","amount":"1""htlcScriptAddress":"<script_address>","hash":"<hash>""ownerPubkey":"<pubkey>","timeout":"20"}'<br>
<br>
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.<br>

</p></details>

## Loan
<details><summary>createloanscheme mincolratio interestrate "id" ( [{"txid":"hex","vout":n},...] )</summary><p>
createloanscheme mincolratio interestrate "id" ( [{"txid":"hex","vout":n},...] )<br>
Creates a loan scheme transaction.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. mincolratio             (numeric, required) Minimum collateralization ratio (integer).<br>
2. interestrate            (numeric, required) Interest rate (integer or float).<br>
3. id                      (string, required) Unique identifier of the loan scheme (8 chars max).<br>
4. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli createloanscheme 150 5 LOAN0001<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createloanscheme", "params": [150, 5, LOAN0001] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>destroyloanscheme "id" ( ACTIVATE_AFTER_BLOCK [{"txid":"hex","vout":n},...] )</summary><p>
destroyloanscheme "id" ( ACTIVATE_AFTER_BLOCK [{"txid":"hex","vout":n},...] )<br>
Destroys a loan scheme.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. id                      (string, required) Unique identifier of the loan scheme (8 chars max).<br>
2. ACTIVATE_AFTER_BLOCK    (numeric, optional) Block height at which new changes take effect.<br>
3. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli destroyloanscheme LOAN0001<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "destroyloanscheme", "params": [LOAN0001] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getcollateraltoken "token"</summary><p>
getcollateraltoken "token"<br>
Return collateral token information.<br>
<br>
Arguments:<br>
1. token    (string, required) Symbol or id of collateral token<br>
<br>
Result:<br>
{...}     (object) Json object with collateral token information<br>
<br>
Examples:<br>
> defi-cli getcollateraltoken DFI<br>

</p></details>

<details><summary>getinterest "id" ( "token" )</summary><p>
getinterest "id" ( "token" )<br>
Returns the global and per block interest by loan scheme.<br>
<br>
Arguments:<br>
1. id       (string, required) Unique identifier of the loan scheme (8 chars max).<br>
2. token    (string) The tokens's symbol, id or creation tx<br>
<br>
Result:<br>
{...}     (object) Json object with interest information<br>
            - `interestPerBlock`: Interest per block is always ceiled<br>
               to the min. unit of fi (8 decimals), however interest<br>
               less than this will continue to accrue until actual utilization<br>
               (eg. - payback of the loan), or until sub-fi maturity.             - `realizedInterestPerBlock`: The actual realized interest<br>
               per block. This is continues to accumulate until<br>
               the min. unit of the blockchain (fi) can be realized. <br>
<br>
Examples:<br>
> defi-cli getinterest LOAN0001 TSLA<br>

</p></details>

<details><summary>getloaninfo</summary><p>
getloaninfo<br>
Returns the loan stats.<br>
<br>
Result:<br>
{...}     (object) Json object with loan information<br>
<br>
Examples:<br>
> defi-cli getloaninfo <br>

</p></details>

<details><summary>getloanscheme "id"</summary><p>
getloanscheme "id"<br>
Returns information about loan scheme.<br>
<br>
Arguments:<br>
1. id    (string, required) Unique identifier of the loan scheme (8 chars max).<br>
<br>
Result:<br>
  {<br>
    "id" : n                   (string)<br>
    "mincolratio" : n          (numeric)<br>
    "interestrate" : n         (numeric)<br>
  },<br>
<br>
Examples:<br>
> defi-cli getloanscheme LOAN0001<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getloanscheme", "params": [LOAN0001] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getloantoken "token"</summary><p>
getloantoken "token"<br>
Return loan token information.<br>
<br>
Arguments:<br>
1. token    (string, required) Symbol or id of loan token<br>
<br>
Result:<br>
{...}     (object) Json object with loan token information<br>
<br>
Examples:<br>
> defi-cli getloantoken DFI<br>

</p></details>

<details><summary>listcollateraltokens</summary><p>
listcollateraltokens<br>
Return list of all created collateral tokens. If no parameters passed it will return all current valid setcollateraltoken transactions.<br>
<br>
Result:<br>
{...}     (object) Json object with collateral token information<br>
<br>
Examples:<br>
> defi-cli listcollateraltokens <br>

</p></details>

<details><summary>listloanschemes</summary><p>
listloanschemes<br>
List all available loan schemes.<br>
<br>
Result:<br>
[                         (json array of objects)<br>
  {<br>
    "id" : n                   (string)<br>
    "mincolratio" : n          (numeric)<br>
    "interestrate" : n         (numeric)<br>
  },<br>
  ...<br>
]<br>
<br>
Examples:<br>
> defi-cli listloanschemes <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listloanschemes", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listloantokens</summary><p>
listloantokens<br>
Return list of all created loan tokens.<br>
<br>
Result:<br>
{...}     (object) Json object with loan token information<br>
<br>
Examples:<br>
> defi-cli listloantokens <br>

</p></details>

<details><summary>paybackloan {"vaultId":"hex","from":"str","amounts":"str","loans":[{"dToken":"str","amounts":"str"},...]} ( [{"txid":"hex","vout":n},...] )</summary><p>
paybackloan {"vaultId":"hex","from":"str","amounts":"str","loans":[{"dToken":"str","amounts":"str"},...]} ( [{"txid":"hex","vout":n},...] )<br>
Creates (and submits to local node and network) a tx to return the loan in desired amount.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. metadata                     (json object, required)<br>
     {<br>
       "vaultId": "hex",        (string, required) Id of vault used for loan<br>
       "from": "str",           (string, required) Address containing repayment tokens. If "from" value is: "*" (star), it's means auto-selection accounts from wallet.<br>
       "amounts": "str",        (string) Amount in amount@token format.<br>
       "loans": [               (json array, optional) A json array of json objects<br>
         {                      (json object)<br>
           "dToken": "str",     (string, required) The dTokens's symbol, id or creation tx<br>
           "amounts": "str",    (string, required) Amount in amount@token format.<br>
         },<br>
         ...<br>
       ],<br>
     }<br>
2. inputs                       (json array, optional) A json array of json objects<br>
     [<br>
       {                        (json object)<br>
         "txid": "hex",         (string, required) The transaction id<br>
         "vout": n,             (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli paybackloan '{"vaultId":84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2,"from":"<address>", "amounts":"10@TSLA"}'<br>

</p></details>

<details><summary>setcollateraltoken {"token":"str","factor":n,"fixedIntervalPriceId":"hex","activateAfterBlock":n} ( [{"txid":"hex","vout":n},...] )</summary><p>
setcollateraltoken {"token":"str","factor":n,"fixedIntervalPriceId":"hex","activateAfterBlock":n} ( [{"txid":"hex","vout":n},...] )<br>
Creates (and submits to local node and network) a set colleteral token transaction.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. metadata                              (json object, required)<br>
     {<br>
       "token": "str",                   (string, required) Symbol or id of collateral token<br>
       "factor": n,                      (numeric, required) Collateralization factor<br>
       "fixedIntervalPriceId": "hex",    (string, required) token/currency pair to use for price of token<br>
       "activateAfterBlock": n,          (numeric) changes will be active after the block height (Optional)<br>
     }<br>
2. inputs                                (json array, optional) A json array of json objects<br>
     [<br>
       {                                 (json object)<br>
         "txid": "hex",                  (string, required) The transaction id<br>
         "vout": n,                      (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli setcollateraltoken '{"token":"TSLA","factor":"150","fixedIntervalPriceId":"TSLA/USD"}'<br>

</p></details>

<details><summary>setdefaultloanscheme "id" ( [{"txid":"hex","vout":n},...] )</summary><p>
setdefaultloanscheme "id" ( [{"txid":"hex","vout":n},...] )<br>
Sets the default loan scheme.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. id                      (string, required) Unique identifier of the loan scheme (8 chars max).<br>
2. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli setdefaultloanscheme LOAN0001<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "setdefaultloanscheme", "params": [LOAN0001] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>setloantoken {"symbol":"str","name":"str","fixedIntervalPriceId":"hex","mintable":bool,"interest":n} ( [{"txid":"hex","vout":n},...] )</summary><p>
setloantoken {"symbol":"str","name":"str","fixedIntervalPriceId":"hex","mintable":bool,"interest":n} ( [{"txid":"hex","vout":n},...] )<br>
Creates (and submits to local node and network) a token for a price feed set in collateral token.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. metadata                              (json object, required)<br>
     {<br>
       "symbol": "str",                  (string, required) Token's symbol (unique), not longer than 8<br>
       "name": "str",                    (string) Token's name (optional), not longer than 128<br>
       "fixedIntervalPriceId": "hex",    (string, required) token/currency pair to use for price of token<br>
       "mintable": bool,                 (boolean) Token's 'Mintable' property (bool, optional), default is 'True'<br>
       "interest": n,                    (numeric) Interest rate (default: 0)<br>
     }<br>
2. inputs                                (json array, optional) A json array of json objects<br>
     [<br>
       {                                 (json object)<br>
         "txid": "hex",                  (string, required) The transaction id<br>
         "vout": n,                      (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli setloantoken '{"symbol":"TSLA","name":"TSLA stock token","fixedIntervalPriceId":"TSLA/USD","interest":"3"}'<br>

</p></details>

<details><summary>takeloan {"vaultId":"hex","to":"str","amounts":"str"} ( [{"txid":"hex","vout":n},...] )</summary><p>
takeloan {"vaultId":"hex","to":"str","amounts":"str"} ( [{"txid":"hex","vout":n},...] )<br>
Creates (and submits to local node and network) a tx to mint loan token in desired amount based on defined loan.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. metadata                 (json object, required)<br>
     {<br>
       "vaultId": "hex",    (string, required) Id of vault used for loan<br>
       "to": "str",         (string) Address to transfer tokens (optional)<br>
       "amounts": "str",    (string, required) Amount in amount@token format.<br>
     }<br>
2. inputs                   (json array, optional) A json array of json objects<br>
     [<br>
       {                    (json object)<br>
         "txid": "hex",     (string, required) The transaction id<br>
         "vout": n,         (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli takeloan '{"vaultId":84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2,"amounts":"10@TSLA"}'<br>

</p></details>

<details><summary>updateloanscheme mincolratio interestrate "id" ( ACTIVATE_AFTER_BLOCK [{"txid":"hex","vout":n},...] )</summary><p>
updateloanscheme mincolratio interestrate "id" ( ACTIVATE_AFTER_BLOCK [{"txid":"hex","vout":n},...] )<br>
Updates an existing loan scheme.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. mincolratio             (numeric, required) Minimum collateralization ratio (integer).<br>
2. interestrate            (numeric, required) Interest rate (integer or float).<br>
3. id                      (string, required) Unique identifier of the loan scheme (8 chars max).<br>
4. ACTIVATE_AFTER_BLOCK    (numeric, optional) Block height at which new changes take effect.<br>
5. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli updateloanscheme 150 5 LOAN0001<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "updateloanscheme", "params": [150, 5, LOAN0001] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>updateloantoken "token" {"symbol":"str","name":"str","fixedIntervalPriceId":"hex","mintable":bool,"interest":n} ( [{"txid":"hex","vout":n},...] )</summary><p>
updateloantoken "token" {"symbol":"str","name":"str","fixedIntervalPriceId":"hex","mintable":bool,"interest":n} ( [{"txid":"hex","vout":n},...] )<br>
Creates (and submits to local node and network) a transaction to update loan token metadata.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. token                                 (string, required) The tokens's symbol, id or creation tx<br>
2. metadata                              (json object, required)<br>
     {<br>
       "symbol": "str",                  (string) New token's symbol (unique), not longer than 8<br>
       "name": "str",                    (string) Newoken's name (optional), not longer than 128<br>
       "fixedIntervalPriceId": "hex",    (string) token/currency pair to use for price of token<br>
       "mintable": bool,                 (boolean) Token's 'Mintable' property (bool, optional), default is 'True'<br>
       "interest": n,                    (numeric) Interest rate (optional).<br>
     }<br>
3. inputs                                (json array, optional) A json array of json objects<br>
     [<br>
       {                                 (json object)<br>
         "txid": "hex",                  (string, required) The transaction id<br>
         "vout": n,                      (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli updateloantoken "TSLAAA", {"symbol":"TSLA","fixedIntervalPriceId":"TSLA/USD", "mintable": true, "interest": 0.03}'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "updateloantoken", "params": ["TSLAAA", {"symbol":"TSLA","fixedIntervalPriceId":"TSLA/USD", "mintable": true, "interest": 0.03}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

## Masternodes
<details><summary>createmasternode "ownerAddress" ( "operatorAddress" [{"txid":"hex","vout":n},...] "timelock" )</summary><p>
createmasternode "ownerAddress" ( "operatorAddress" [{"txid":"hex","vout":n},...] "timelock" )<br>
<br>
Creates (and submits to local node and network) a masternode creation transaction with given owner and operator addresses, spending the given inputs..<br>
The last optional argument (may be empty array) is an array of specific UTXOs to spend.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. ownerAddress            (string, required) Any valid address for keeping collateral amount (any P2PKH or P2WKH address) - used as owner key<br>
2. operatorAddress         (string) Optional (== ownerAddress) masternode operator auth address (P2PKH only, unique)<br>
3. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
4. timelock                (string) Defaults to no timelock period so masternode can be resigned once active. To set a timelock period<br>
                           specify either FIVEYEARTIMELOCK or TENYEARTIMELOCK to create a masternode that cannot be resigned for<br>
                           five or ten years and will have 1.5x or 2.0 the staking power respectively. Be aware that this means<br>
                           that you cannot spend the collateral used to create a masternode for whatever period is specified.<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli createmasternode ownerAddress operatorAddress '[{"txid":"id","vout":0}]'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createmasternode", "params": [ownerAddress operatorAddress '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getactivemasternodecount ( blockCount )</summary><p>
getactivemasternodecount ( blockCount )<br>
<br>
Return number of unique masternodes in the last specified number of blocks<br>
<br>
Arguments:<br>
1. blockCount    (numeric) The number of blocks to check for unique masternodes. (Default: 20160)<br>
<br>
Result:<br>
n    (numeric) Number of unique masternodes seen<br>
<br>
Examples:<br>
> defi-cli getactivemasternodecount 20160<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getactivemasternodecount", "params": [20160] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getanchorteams ( blockHeight )</summary><p>
getanchorteams ( blockHeight )<br>
<br>
Returns the auth and confirm anchor masternode teams at current or specified height<br>
<br>
Arguments:<br>
1. blockHeight    (numeric) The height of block which contain tx<br>
<br>
Result:<br>
{"auth":[Address,...],"confirm":[Address,...]} Two sets of masternode operator addresses<br>
<br>
Examples:<br>
> defi-cli getanchorteams 1005<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getanchorteams", "params": [1005] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getmasternode "mn_id"</summary><p>
getmasternode "mn_id"<br>
<br>
Returns information about specified masternode.<br>
<br>
Arguments:<br>
1. mn_id    (string, required) Masternode's id<br>
<br>
Result:<br>
{id:{...}}     (object) Json object with masternode information<br>
<br>
Examples:<br>
> defi-cli getmasternode mn_id<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmasternode", "params": [mn_id] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getmasternodeblocks ( {"id":"hex","ownerAddress":"str","operatorAddress":"str"} depth )</summary><p>
getmasternodeblocks ( {"id":"hex","ownerAddress":"str","operatorAddress":"str"} depth )<br>
<br>
Returns blocks generated by the specified masternode.<br>
<br>
Arguments:<br>
1. identifier                       (json object, optional) A json object containing one masternode identifying information<br>
     {<br>
       "id": "hex",                 (string) Masternode's id<br>
       "ownerAddress": "str",       (string) Masternode owner address<br>
       "operatorAddress": "str",    (string) Masternode operator address<br>
     }<br>
2. depth                            (numeric) Maximum depth, from the genesis block is the default<br>
<br>
Result:<br>
{...}     (object) Json object with block hash and height information<br>
<br>
Examples:<br>
> defi-cli getmasternodeblocks '{"ownerAddress":"dPyup5C9hfRd2SUC1p3a7VcjcNuGSXa9bT"}'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmasternodeblocks", "params": [{"ownerAddress":"dPyup5C9hfRd2SUC1p3a7VcjcNuGSXa9bT"}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listanchors</summary><p>
listanchors<br>
<br>
List anchors (if any)<br>
<br>
Result:<br>
"array"                  Returns array of anchors<br>
<br>
Examples:<br>
> defi-cli listanchors <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listanchors", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listmasternodes ( {"start":"hex","including_start":bool,"limit":n} verbose )</summary><p>
listmasternodes ( {"start":"hex","including_start":bool,"limit":n} verbose )<br>
<br>
Returns information about specified masternodes (or all, if list of ids is empty).<br>
<br>
Arguments:<br>
1. pagination                      (json object)<br>
     {<br>
       "start": "hex",             (string) Optional first key to iterate from, in lexicographical order.Typically it's set to last ID from previous request.<br>
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default<br>
       "limit": n,                 (numeric) Maximum number of orders to return, 1000000 by default<br>
     }<br>
2. verbose                         (boolean) Flag for verbose list (default = true), otherwise only ids are listed<br>
<br>
Result:<br>
{id:{...},...}     (array) Json object with masternodes information<br>
<br>
Examples:<br>
> defi-cli listmasternodes '[mn_id]' false<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listmasternodes", "params": ['[mn_id]' false] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>resignmasternode "mn_id" ( [{"txid":"hex","vout":n},...] )</summary><p>
resignmasternode "mn_id" ( [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) a transaction resigning your masternode. Collateral will be unlocked after 2016 blocks.<br>
The last optional argument (may be empty array) is an array of specific UTXOs to spend. One of UTXO's must belong to the MN's owner (collateral) address<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. mn_id                   (string, required) The Masternode's ID<br>
2. inputs                  (json array, optional) A json array of json objects. Provide it if you want to spent specific UTXOs<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli resignmasternode mn_id '[{"txid":"id","vout":0}]'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "resignmasternode", "params": [mn_id '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>updatemasternode "mn_id" {"ownerAddress":"str","operatorAddress":"str","rewardAddress":"str"} ( [{"txid":"hex","vout":n},...] )</summary><p>
updatemasternode "mn_id" {"ownerAddress":"str","operatorAddress":"str","rewardAddress":"str"} ( [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) a masternode update transaction which update the masternode operator addresses, spending the given inputs..<br>
The last optional argument (may be empty array) is an array of specific UTXOs to spend.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. mn_id                            (string, required) The Masternode's ID<br>
2. values                           (json object, required)<br>
     {<br>
       "ownerAddress": "str",       (string) The new masternode owner address, requires masternode collateral fee (P2PKH or P2WPKH)<br>
       "operatorAddress": "str",    (string) The new masternode operator address (P2PKH or P2WPKH)<br>
       "rewardAddress": "str",      (string) Masternode`s new reward address, empty "" to remove reward address.<br>
     }<br>
3. inputs                           (json array, optional) A json array of json objects<br>
     [<br>
       {                            (json object)<br>
         "txid": "hex",             (string, required) The transaction id<br>
         "vout": n,                 (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli updatemasternode mn_id operatorAddress '[{"txid":"id","vout":0}]'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "updatemasternode", "params": [mn_id operatorAddress '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

## Mining
<details><summary>getblocktemplate ( "template_request" )</summary><p>
getblocktemplate ( "template_request" )<br>
<br>
If the request parameters include a 'mode' key, that is used to explicitly select between the default 'template' request or a 'proposal'.<br>
It returns data needed to construct a block to work on.<br>
For full specification, see BIPs 22, 23, 9, and 145:<br>
    https://github.com/bitcoin/bips/blob/master/bip-0022.mediawiki<br>
    https://github.com/bitcoin/bips/blob/master/bip-0023.mediawiki<br>
    https://github.com/bitcoin/bips/blob/master/bip-0009.mediawiki#getblocktemplate_changes<br>
    https://github.com/bitcoin/bips/blob/master/bip-0145.mediawiki<br>
<br>
Arguments:<br>
1. template_request         (json object, optional, default={}) A json object in the following spec<br>
     {<br>
       "mode": "str",       (string, optional) This must be set to "template", "proposal" (see BIP 23), or omitted<br>
       "capabilities": [    (json array, optional) A list of strings<br>
         "support",         (string) client side supported feature, 'longpoll', 'coinbasetxn', 'coinbasevalue', 'proposal', 'serverlist', 'workid'<br>
         ...<br>
       ],<br>
       "rules": [           (json array, required) A list of strings<br>
         "support",         (string) client side supported softfork deployment<br>
         ...<br>
       ],<br>
     }<br>
<br>
Result:<br>
{<br>
  "version" : n,                    (numeric) The preferred block version<br>
  "rules" : [ "rulename", ... ],    (array of strings) specific block rules that are to be enforced<br>
  "vbavailable" : {                 (json object) set of pending, supported versionbit (BIP 9) softfork deployments<br>
      "rulename" : bitnumber          (numeric) identifies the bit number as indicating acceptance and readiness for the named softfork rule<br>
      ,...<br>
  },<br>
  "vbrequired" : n,                 (numeric) bit mask of versionbits the server requires set in submissions<br>
  "previousblockhash" : "xxxx",     (string) The hash of current highest block<br>
  "transactions" : [                (array) contents of non-coinbase transactions that should be included in the next block<br>
      {<br>
         "data" : "xxxx",             (string) transaction data encoded in hexadecimal (byte-for-byte)<br>
         "txid" : "xxxx",             (string) transaction id encoded in little-endian hexadecimal<br>
         "hash" : "xxxx",             (string) hash encoded in little-endian hexadecimal (including witness data)<br>
         "depends" : [                (array) array of numbers <br>
             n                          (numeric) transactions before this one (by 1-based index in 'transactions' list) that must be present in the final block if this one is<br>
             ,...<br>
         ],<br>
         "fee": n,                    (numeric) difference in value between transaction inputs and outputs (in satoshis); for coinbase transactions, this is a negative Number of the total collected block fees (ie, not including the block subsidy); if key is not present, fee is unknown and clients MUST NOT assume there isn't one<br>
         "sigops" : n,                (numeric) total SigOps cost, as counted for purposes of block limits; if key is not present, sigop cost is unknown and clients MUST NOT assume it is zero<br>
         "weight" : n,                (numeric) total transaction weight, as counted for purposes of block limits<br>
      }<br>
      ,...<br>
  ],<br>
  "coinbaseaux" : {                 (json object) data that should be included in the coinbase's scriptSig content<br>
      "flags" : "xx"                  (string) key name is to be ignored, and value included in scriptSig<br>
  },<br>
  "coinbasevalue" : n,              (numeric) maximum allowable input to coinbase transaction, including the generation award and transaction fees (in satoshis)<br>
  "coinbasetxn" : { ... },          (json object) information for coinbase transaction<br>
  "target" : "xxxx",                (string) The hash target<br>
  "mintime" : xxx,                  (numeric) The minimum timestamp appropriate for next block time in seconds since epoch (Jan 1 1970 GMT)<br>
  "mutable" : [                     (array of string) list of ways the block template may be changed <br>
     "value"                          (string) A way the block template may be changed, e.g. 'time', 'transactions', 'prevblock'<br>
     ,...<br>
  ],<br>
  "noncerange" : "00000000ffffffff",(string) A range of valid nonces<br>
  "sigoplimit" : n,                 (numeric) limit of sigops in blocks<br>
  "sizelimit" : n,                  (numeric) limit of block size<br>
  "weightlimit" : n,                (numeric) limit of block weight<br>
  "curtime" : ttt,                  (numeric) current timestamp in seconds since epoch (Jan 1 1970 GMT)<br>
  "bits" : "xxxxxxxx",              (string) compressed target of next block<br>
  "height" : n                      (numeric) The height of the next block<br>
}<br>
<br>
Examples:<br>
> defi-cli getblocktemplate '{"rules": ["segwit"]}'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblocktemplate", "params": [{"rules": ["segwit"]}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getmininginfo</summary><p>
getmininginfo<br>
<br>
Returns a json object containing mining-related information for all local masternodes<br>
Result:<br>
{<br>
  "blocks": nnn,             (numeric) The current block<br>
  "currentblockweight": nnn, (numeric, optional) The block weight of the last assembled block (only present if a block was ever assembled)<br>
  "currentblocktx": nnn,     (numeric, optional) The number of block transactions of the last assembled block (only present if a block was ever assembled)<br>
  "difficulty": xxx.xxxxx    (numeric) The current difficulty<br>
  "networkhashps": nnn,      (numeric) The network hashes per second<br>
  "pooledtx": n              (numeric) The size of the mempool<br>
  "chain": "xxxx",         (string)  current network name as defined in BIP70 (main, test, regtest)<br>
  "isoperator": true|false   (boolean) Local master nodes are available or not <br>
  "masternodes": []          (array)   an array of objects which includes each master node information<br>
  "warnings": "..."        (string)  any network and blockchain warnings<br>
}<br>
<br>
Examples:<br>
> defi-cli getmininginfo <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmininginfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getmintinginfo</summary><p>
getmintinginfo<br>
<br>
DEPRECATED. Prefer using getmininginfo.<br>
Returns a json object containing mining-related information.<br>
Result:<br>
{<br>
  "blocks": nnn,             (numeric) The current block<br>
  "currentblockweight": nnn, (numeric, optional) The block weight of the last assembled block (only present if a block was ever assembled)<br>
  "currentblocktx": nnn,     (numeric, optional) The number of block transactions of the last assembled block (only present if a block was ever assembled)<br>
  "difficulty": xxx.xxxxx    (numeric) The current difficulty<br>
  "networkhashps": nnn,      (numeric) The network hashes per second<br>
  "pooledtx": n              (numeric) The size of the mempool<br>
  "chain": "xxxx",         (string)  current network name as defined in BIP70 (main, test, regtest)<br>
  "isoperator": true|false   (boolean) Local master nodes are available or not <br>
  "masternodes": []          (array)   an array of objects which includes each master node information<br>
  "warnings": "..."        (string)  any network and blockchain warnings<br>
}<br>
<br>
Examples:<br>
> defi-cli getmintinginfo <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmintinginfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getnetworkhashps ( nblocks height )</summary><p>
getnetworkhashps ( nblocks height )<br>
<br>
Returns the estimated network hashes per second based on the last n blocks.<br>
Pass in [blocks] to override # of blocks, -1 specifies since last difficulty change.<br>
Pass in [height] to estimate the network speed at the time when a certain block was found.<br>
<br>
Arguments:<br>
1. nblocks    (numeric, optional, default=120) The number of blocks, or -1 for blocks since last difficulty change.<br>
2. height     (numeric, optional, default=-1) To estimate at the time of the given height.<br>
<br>
Result:<br>
x             (numeric) Hashes per second estimated<br>
<br>
Examples:<br>
> defi-cli getnetworkhashps <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getnetworkhashps", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>prioritisetransaction "txid" ( dummy ) fee_delta</summary><p>
prioritisetransaction "txid" ( dummy ) fee_delta<br>
Accepts the transaction into mined blocks at a higher (or lower) priority<br>
<br>
Arguments:<br>
1. txid         (string, required) The transaction id.<br>
2. dummy        (numeric, optional) API-Compatibility for previous API. Must be zero or null.<br>
                DEPRECATED. For forward compatibility use named arguments and omit this parameter.<br>
3. fee_delta    (numeric, required) The fee value (in satoshis) to add (or subtract, if negative).<br>
                Note, that this value is not a fee rate. It is a value to modify absolute fee of the TX.<br>
                The fee is not actually paid, only the algorithm for selecting transactions into a block<br>
                considers the transaction as it would have paid a higher (or lower) fee.<br>
<br>
Result:<br>
true              (boolean) Returns true<br>
<br>
Examples:<br>
> defi-cli prioritisetransaction "txid" 0.0 10000<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "prioritisetransaction", "params": ["txid", 0.0, 10000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>submitblock "hexdata" ( "dummy" )</summary><p>
submitblock "hexdata" ( "dummy" )<br>
<br>
Attempts to submit new block to network.<br>
See https://en.bitcoin.it/wiki/BIP_0022 for full specification.<br>
<br>
Arguments:<br>
1. hexdata    (string, required) the hex-encoded block data to submit<br>
2. dummy      (string, optional, default=ignored) dummy value, for compatibility with BIP22. This value is ignored.<br>
<br>
Examples:<br>
> defi-cli submitblock "mydata"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "submitblock", "params": ["mydata"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>submitheader "hexdata"</summary><p>
submitheader "hexdata"<br>
<br>
Decode the given hexdata as a header and submit it as a candidate chain tip if valid.<br>
Throws when the header is invalid.<br>
<br>
Arguments:<br>
1. hexdata    (string, required) the hex-encoded block header data<br>
<br>
Result:<br>
None<br>
Examples:<br>
> defi-cli submitheader "aabbcc"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "submitheader", "params": ["aabbcc"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

## Network
<details><summary>addnode "node" "command"</summary><p>
addnode "node" "command"<br>
<br>
Attempts to add or remove a node from the addnode list.<br>
Or try a connection to a node once.<br>
Nodes added using addnode (or -connect) are protected from DoS disconnection and are not required to be<br>
full nodes/support SegWit as other outbound peers are (though such peers will not be synced from).<br>
<br>
Arguments:<br>
1. node       (string, required) The node (see getpeerinfo for nodes)<br>
2. command    (string, required) 'add' to add a node to the list, 'remove' to remove a node from the list, 'onetry' to try a connection to the node once<br>
<br>
Examples:<br>
> defi-cli addnode "192.168.0.6:8555" "onetry"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "addnode", "params": ["192.168.0.6:8555", "onetry"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>clearbanned</summary><p>
clearbanned<br>
<br>
Clear all banned IPs.<br>
<br>
Examples:<br>
> defi-cli clearbanned <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "clearbanned", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>disconnectnode ( "address" nodeid )</summary><p>
disconnectnode ( "address" nodeid )<br>
<br>
Immediately disconnects from the specified peer node.<br>
<br>
Strictly one out of 'address' and 'nodeid' can be provided to identify the node.<br>
<br>
To disconnect by nodeid, either set 'address' to the empty string, or call using the named 'nodeid' argument only.<br>
<br>
Arguments:<br>
1. address    (string, optional, default=fallback to nodeid) The IP address/port of the node<br>
2. nodeid     (numeric, optional, default=fallback to address) The node ID (see getpeerinfo for node IDs)<br>
<br>
Examples:<br>
> defi-cli disconnectnode "192.168.0.6:8555"<br>
> defi-cli disconnectnode "" 1<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "disconnectnode", "params": ["192.168.0.6:8555"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "disconnectnode", "params": ["", 1] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getaddednodeinfo ( "node" )</summary><p>
getaddednodeinfo ( "node" )<br>
<br>
Returns information about the given added node, or all added nodes<br>
(note that onetry addnodes are not listed here)<br>
<br>
Arguments:<br>
1. node    (string, optional, default=all nodes) If provided, return information about this specific node, otherwise all nodes are returned.<br>
<br>
Result:<br>
[<br>
  {<br>
    "addednode" : "192.168.0.201",   (string) The node IP address or name (as provided to addnode)<br>
    "connected" : true|false,          (boolean) If connected<br>
    "addresses" : [                    (list of objects) Only when connected = true<br>
       {<br>
         "address" : "192.168.0.201:8555",  (string) The DeFi Blockchain server IP and port we're connected to<br>
         "connected" : "outbound"           (string) connection, inbound or outbound<br>
       }<br>
     ]<br>
  }<br>
  ,...<br>
]<br>
<br>
Examples:<br>
> defi-cli getaddednodeinfo "192.168.0.201"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getaddednodeinfo", "params": ["192.168.0.201"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getconnectioncount</summary><p>
getconnectioncount<br>
<br>
Returns the number of connections to other nodes.<br>
<br>
Result:<br>
n          (numeric) The connection count<br>
<br>
Examples:<br>
> defi-cli getconnectioncount <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getconnectioncount", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getnettotals</summary><p>
getnettotals<br>
<br>
Returns information about network traffic, including bytes in, bytes out,<br>
and current time.<br>
<br>
Result:<br>
{<br>
  "totalbytesrecv": n,   (numeric) Total bytes received<br>
  "totalbytessent": n,   (numeric) Total bytes sent<br>
  "timemillis": t,       (numeric) Current UNIX time in milliseconds<br>
  "uploadtarget":<br>
  {<br>
    "timeframe": n,                         (numeric) Length of the measuring timeframe in seconds<br>
    "target": n,                            (numeric) Target in bytes<br>
    "target_reached": true|false,           (boolean) True if target is reached<br>
    "serve_historical_blocks": true|false,  (boolean) True if serving historical blocks<br>
    "bytes_left_in_cycle": t,               (numeric) Bytes left in current time cycle<br>
    "time_left_in_cycle": t                 (numeric) Seconds left in current time cycle<br>
  }<br>
}<br>
<br>
Examples:<br>
> defi-cli getnettotals <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getnettotals", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getnetworkinfo</summary><p>
getnetworkinfo<br>
Returns an object containing various state info regarding P2P networking.<br>
<br>
Result:<br>
{<br>
  "version": xxxxx,                      (numeric) the server version<br>
  "subversion": "/Satoshi:x.x.x/",     (string) the server subversion string<br>
  "protocolversion": xxxxx,              (numeric) the protocol version<br>
  "localservices": "xxxxxxxxxxxxxxxx", (string) the services we offer to the network<br>
  "localrelay": true|false,              (bool) true if transaction relay is requested from peers<br>
  "timeoffset": xxxxx,                   (numeric) the time offset<br>
  "connections": xxxxx,                  (numeric) the number of connections<br>
  "networkactive": true|false,           (bool) whether p2p networking is enabled<br>
  "networks": [                          (array) information per network<br>
  {<br>
    "name": "xxx",                     (string) network (ipv4, ipv6 or onion)<br>
    "limited": true|false,               (boolean) is the network limited using -onlynet?<br>
    "reachable": true|false,             (boolean) is the network reachable?<br>
    "proxy": "host:port"               (string) the proxy that is used for this network, or empty if none<br>
    "proxy_randomize_credentials": true|false,  (string) Whether randomized credentials are used<br>
  }<br>
  ,...<br>
  ],<br>
  "relayfee": x.xxxxxxxx,                (numeric) minimum relay fee for transactions in DFI/kB<br>
  "incrementalfee": x.xxxxxxxx,          (numeric) minimum fee increment for mempool limiting or BIP 125 replacement in DFI/kB<br>
  "localaddresses": [                    (array) list of local addresses<br>
  {<br>
    "address": "xxxx",                 (string) network address<br>
    "port": xxx,                         (numeric) network port<br>
    "score": xxx                         (numeric) relative score<br>
  }<br>
  ,...<br>
  ]<br>
  "warnings": "..."                    (string) any network and blockchain warnings<br>
}<br>
<br>
Examples:<br>
> defi-cli getnetworkinfo <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getnetworkinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getnodeaddresses ( count )</summary><p>
getnodeaddresses ( count )<br>
<br>
Return known addresses which can potentially be used to find new nodes in the network<br>
<br>
Arguments:<br>
1. count    (numeric, optional, default=1) How many addresses to return. Limited to the smaller of 2500 or 23% of all known addresses.<br>
<br>
Result:<br>
[<br>
  {<br>
    "time": ttt,                (numeric) Timestamp in seconds since epoch (Jan 1 1970 GMT) keeping track of when the node was last seen<br>
    "services": n,              (numeric) The services offered<br>
    "address": "host",          (string) The address of the node<br>
    "port": n                   (numeric) The port of the node<br>
  }<br>
  ,....<br>
]<br>
<br>
Examples:<br>
> defi-cli getnodeaddresses 8<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getnodeaddresses", "params": [8] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getpeerinfo</summary><p>
getpeerinfo<br>
<br>
Returns data about each connected network node as a json array of objects.<br>
<br>
Result:<br>
[<br>
  {<br>
    "id": n,                   (numeric) Peer index<br>
    "addr":"host:port",      (string) The IP address and port of the peer<br>
    "addrbind":"ip:port",    (string) Bind address of the connection to the peer<br>
    "addrlocal":"ip:port",   (string) Local address as reported by the peer<br>
    "services":"xxxxxxxxxxxxxxxx",   (string) The services offered<br>
    "relaytxes":true|false,    (boolean) Whether peer has asked us to relay transactions to it<br>
    "lastsend": ttt,           (numeric) The time in seconds since epoch (Jan 1 1970 GMT) of the last send<br>
    "lastrecv": ttt,           (numeric) The time in seconds since epoch (Jan 1 1970 GMT) of the last receive<br>
    "bytessent": n,            (numeric) The total bytes sent<br>
    "bytesrecv": n,            (numeric) The total bytes received<br>
    "conntime": ttt,           (numeric) The connection time in seconds since epoch (Jan 1 1970 GMT)<br>
    "timeoffset": ttt,         (numeric) The time offset in seconds<br>
    "pingtime": n,             (numeric) ping time (if available)<br>
    "minping": n,              (numeric) minimum observed ping time (if any at all)<br>
    "pingwait": n,             (numeric) ping wait (if non-zero)<br>
    "version": v,              (numeric) The peer version, such as 70001<br>
    "subver": "/Satoshi:0.8.5/",  (string) The string version<br>
    "inbound": true|false,     (boolean) Inbound (true) or Outbound (false)<br>
    "addnode": true|false,     (boolean) Whether connection was due to addnode/-connect or if it was an automatic/inbound connection<br>
    "startingheight": n,       (numeric) The starting height (block) of the peer<br>
    "banscore": n,             (numeric) The ban score<br>
    "synced_headers": n,       (numeric) The last header we have in common with this peer<br>
    "synced_blocks": n,        (numeric) The last block we have in common with this peer<br>
    "inflight": [<br>
       n,                        (numeric) The heights of blocks we're currently asking from this peer<br>
       ...<br>
    ],<br>
    "whitelisted": true|false, (boolean) Whether the peer is whitelisted<br>
    "minfeefilter": n,         (numeric) The minimum fee rate for transactions this peer accepts<br>
    "bytessent_per_msg": {<br>
       "msg": n,               (numeric) The total bytes sent aggregated by message type<br>
                               When a message type is not listed in this json object, the bytes sent are 0.<br>
                               Only known message types can appear as keys in the object.<br>
       ...<br>
    },<br>
    "bytesrecv_per_msg": {<br>
       "msg": n,               (numeric) The total bytes received aggregated by message type<br>
                               When a message type is not listed in this json object, the bytes received are 0.<br>
                               Only known message types can appear as keys in the object and all bytes received of unknown message types are listed under '*other*'.<br>
       ...<br>
    }<br>
  }<br>
  ,...<br>
]<br>
<br>
Examples:<br>
> defi-cli getpeerinfo <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getpeerinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getversioninfo</summary><p>
getversioninfo<br>
Returns an object containing various version info about the node.<br>
<br>
Result:<br>
{<br>
 "name": DeFiChain                       (string) Node name<br>
 "version": "xxxxx",                   (string) Node version string<br>
 "numericVersion": xxxxx,                (number) Node numeric version<br>
 "fullVersion": "DefiChain:x.x.x",     (string) Full node version string including name and version<br>
 "userAgent": "/DefiChain:x.x.x/",     (string) P2P user agent string (subversion string conforming to BIP-14)<br>
 "protoVersion": "xxxxx",              (number) Operating protocol version<br>
 "protoVersionMin": "xxxxx",           (number) Minimum protocol that's supported by the node<br>
 "rpcVersion": "xxxxx",                (string) RPC version<br>
 "rpcVersionMin": "xxxxx",             (string) Minimum RPC version supported<br>
 "spv":<br>
 "{<br>
    "btc":<br>
       "{<br>
          "userAgent": "xxxxx",          (string) BTC SPV agent string<br>
          "protoVersion": "xxxxx",       (number) BTC SPV protocol version<br>
          "protoVersionMin": "xxxxx",    (number) Minimum BTC SPV protocol that's supported by the node<br>
       "}<br>
 "}"<br>
}<br>
Examples:<br>
> defi-cli getversioninfo <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getversioninfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listbanned</summary><p>
listbanned<br>
<br>
List all banned IPs/Subnets.<br>
<br>
Examples:<br>
> defi-cli listbanned <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listbanned", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>ping</summary><p>
ping<br>
<br>
Requests that a ping be sent to all other nodes, to measure ping time.<br>
Results provided in getpeerinfo, pingtime and pingwait fields are decimal seconds.<br>
Ping command is handled in queue with all other commands, so it measures processing backlog, not just network ping.<br>
<br>
Examples:<br>
> defi-cli ping <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "ping", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>setban "subnet" "command" ( bantime absolute )</summary><p>
setban "subnet" "command" ( bantime absolute )<br>
<br>
Attempts to add or remove an IP/Subnet from the banned list.<br>
<br>
Arguments:<br>
1. subnet      (string, required) The IP/Subnet (see getpeerinfo for nodes IP) with an optional netmask (default is /32 = single IP)<br>
2. command     (string, required) 'add' to add an IP/Subnet to the list, 'remove' to remove an IP/Subnet from the list<br>
3. bantime     (numeric, optional, default=0) time in seconds how long (or until when if [absolute] is set) the IP is banned (0 or empty means using the default time of 24h which can also be overwritten by the -bantime startup argument)<br>
4. absolute    (boolean, optional, default=false) If set, the bantime must be an absolute timestamp in seconds since epoch (Jan 1 1970 GMT)<br>
<br>
Examples:<br>
> defi-cli setban "192.168.0.6" "add" 86400<br>
> defi-cli setban "192.168.0.0/24" "add"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "setban", "params": ["192.168.0.6", "add", 86400] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>setnetworkactive state</summary><p>
setnetworkactive state<br>
<br>
Disable/enable all p2p network activity.<br>
<br>
Arguments:<br>
1. state    (boolean, required) true to enable networking, false to disable<br>

</p></details>

## Oracles
<details><summary>appointoracle "address" [{"currency":"str","token":"str"},...] weightage ( [{"txid":"hex","vout":n},...] )</summary><p>
appointoracle "address" [{"currency":"str","token":"str"},...] weightage ( [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) a `appoint oracle transaction`, <br>
and saves oracle to database.<br>
The last optional argument (may be empty array) is an array of specific UTXOs to spend.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. address                     (string, required) oracle address<br>
2. pricefeeds                  (json array, required) list of allowed token-currency pairs<br>
     [<br>
       {                       (json object)<br>
         "currency": "str",    (string, required) Currency name<br>
         "token": "str",       (string, required) Token name<br>
       },<br>
       ...<br>
     ]<br>
3. weightage                   (numeric, required) oracle weightage<br>
4. inputs                      (json array, optional) A json array of json objects<br>
     [<br>
       {                       (json object)<br>
         "txid": "hex",        (string, required) The transaction id<br>
         "vout": n,            (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli appointoracle mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF '[{"currency": "USD", "token": "BTC"}, {"currency": "EUR", "token":"ETH"}]' 20<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "appointoracle", "params": [mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF '[{"currency": "USD", "token": "BTC"}, {"currency": "EUR", "token":"ETH"}]' 20] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getdusdswapblock</summary><p>
getdusdswapblock<br>
Get the next block that DFI to DUSD swap will execute on.<br>
<br>
Result:<br>
n    (numeric) DFI to DUSD swap execution block. Zero if not set.<br>
<br>
Examples:<br>
> defi-cli getdusdswapblock <br>

</p></details>

<details><summary>getfixedintervalprice "fixedIntervalPriceId"</summary><p>
getfixedintervalprice "fixedIntervalPriceId"<br>
Get fixed interval price for a given pair.<br>
<br>
Arguments:<br>
1. fixedIntervalPriceId    (string, required) token/currency pair to use for price of token<br>
<br>
Result:<br>
"json"          (string) json-object having following fields:<br>
                  `activePrice` - current price used for loan calculations<br>
                  `nextPrice` - next price to be assigned to pair.<br>
                  `nextPriceBlock` - height of nextPrice.<br>
                  `activePriceBlock` - height of activePrice.<br>
                  `timestamp` - timestamp of active price.<br>
                  `isLive` - price liveness, within parameters                   Possible reasons for a price result to not be live:                   1. Not sufficient live oracles.<br>
                   2. Deviation is over the limit to be considered stable.<br>
<br>
Examples:<br>
> defi-cli getfixedintervalprice TSLA/USD<br>

</p></details>

<details><summary>getfutureswapblock</summary><p>
getfutureswapblock<br>
Get the next block that futures will execute and update on.<br>
<br>
Result:<br>
n    (numeric) Futures execution block. Zero if not set.<br>
<br>
Examples:<br>
> defi-cli getfutureswapblock <br>

</p></details>

<details><summary>getoracledata "oracleid"</summary><p>
getoracledata "oracleid"<br>
<br>
Returns oracle data in json form.<br>
<br>
Arguments:<br>
1. oracleid    (string, required) oracle hex id<br>
<br>
Result:<br>
"json"                  (string) oracle data in json form<br>
<br>
Examples:<br>
> defi-cli getoracledata 5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getoracledata", "params": [5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getprice {"currency":"str","token":"str"}</summary><p>
getprice {"currency":"str","token":"str"}<br>
<br>
Calculates aggregated price, <br>
The only argument is a json-form request containing token and currency names.<br>
<br>
Arguments:<br>
1. request                   (json object, required) request in json-form, containing currency and token names, both are mandatory<br>
     {<br>
       "currency": "str",    (string, required) Currency name<br>
       "token": "str",       (string, required) Token name<br>
     }<br>
<br>
Result:<br>
"string"                  (string) aggregated price if<br>
                        if no live oracles which meet specified request or their weights are zero, throws error<br>
<br>
Examples:<br>
> defi-cli getprice getprice '{"currency": "USD", "token": "BTC"}'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getprice", "params": [getprice '{"currency": "USD", "token": "BTC"}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listfixedintervalprices ( {"start":n,"limit":n} )</summary><p>
listfixedintervalprices ( {"start":n,"limit":n} )<br>
Get all fixed interval prices.<br>
<br>
Arguments:<br>
1. pagination         (json object)<br>
     {<br>
       "start": n,    (numeric) Optional first key to iterate from, in lexicographical order.Typically it's set to last ID from previous request.<br>
       "limit": n,    (numeric) Maximum number of fixed interval prices to return, 100 by default<br>
     }<br>
<br>
Result:<br>
"json"          (string) array containing json-objects having following fields:<br>
                  `activePrice` - current price used for loan calculations<br>
                  `nextPrice` - next price to be assigned to pair.<br>
                  `timestamp` - timestamp of active price.<br>
                  `isLive` - price liveness, within parameters                   Possible reasons for a price result to not be live:                   1. Not sufficient live oracles.<br>
                   2. Deviation is over the limit to be considered stable.<br>
<br>
Examples:<br>
> defi-cli listfixedintervalprices '{""}'<br>

</p></details>

<details><summary>listlatestrawprices ( {"currency":"str","token":"str"} {"start":"hex","including_start":bool,"limit":n} )</summary><p>
listlatestrawprices ( {"currency":"str","token":"str"} {"start":"hex","including_start":bool,"limit":n} )<br>
<br>
Returns latest raw price updates through all the oracles for specified token and currency , <br>
<br>
Arguments:<br>
1. request                         (json object) request in json-form, containing currency and token names<br>
     {<br>
       "currency": "str",          (string, required) Currency name<br>
       "token": "str",             (string, required) Token name<br>
     }<br>
2. pagination                      (json object)<br>
     {<br>
       "start": "hex",             (string) Optional first key to iterate from, in lexicographical order. Typically it's set to last ID from previous request.<br>
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default<br>
       "limit": n,                 (numeric) Maximum number of orders to return, 100 by default<br>
     }<br>
<br>
Result:<br>
"json"                  (string) Array of json objects containing full information about token prices<br>
<br>
Examples:<br>
> defi-cli listlatestrawprices listlatestrawprices '{"currency": "USD", "token": "BTC"}'<br>
> defi-cli listlatestrawprices listlatestrawprices '{"currency": "USD", "token": "BTC"}' '{"start": "b7ffdcef37be39018e8a6f846db1220b3558fd649393e9a12f935007ef3bfb8e", "including_start": true, "limit": 100}'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listlatestrawprices", "params": [listlatestrawprices '{"currency": "USD", "token": "BTC"}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listlatestrawprices", "params": [listlatestrawprices '{"currency": "USD", "token": "BTC"}' '{"start": "b7ffdcef37be39018e8a6f846db1220b3558fd649393e9a12f935007ef3bfb8e", "including_start": true, "limit": 100}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listoracles ( {"start":"hex","including_start":bool,"limit":n} )</summary><p>
listoracles ( {"start":"hex","including_start":bool,"limit":n} )<br>
<br>
Returns list of oracle ids.<br>
<br>
Arguments:<br>
1. pagination                      (json object)<br>
     {<br>
       "start": "hex",             (string) Optional first key to iterate from, in lexicographical order. Typically it's set to last ID from previous request.<br>
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default<br>
       "limit": n,                 (numeric) Maximum number of orders to return, 100 by default<br>
     }<br>
<br>
Result:<br>
"hash"                  (string) list of known oracle ids<br>
<br>
Examples:<br>
> defi-cli listoracles <br>
> defi-cli listoracles '{"start":"3ef9fd5bd1d0ce94751e6286710051361e8ef8fac43cca9cb22397bf0d17e013", "including_start": true, "limit":100}'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listoracles", "params": ['{}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listoracles", "params": ['{"start":"3ef9fd5bd1d0ce94751e6286710051361e8ef8fac43cca9cb22397bf0d17e013", "including_start": true, "limit":100}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listprices ( {"start":n,"including_start":bool,"limit":n} )</summary><p>
listprices ( {"start":n,"including_start":bool,"limit":n} )<br>
<br>
Calculates aggregated prices for all supported pairs (token, currency), <br>
<br>
Arguments:<br>
1. pagination                      (json object)<br>
     {<br>
       "start": n,                 (numeric) Optional first key to iterate from, in lexicographical order.Typically it's set to last ID from previous request.<br>
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default<br>
       "limit": n,                 (numeric) Maximum number of orders to return, 100 by default<br>
     }<br>
<br>
Result:<br>
"json"                  (string) array containing json-objects having following fields:<br>
                  `token` - token name,<br>
                  `currency` - currency name,<br>
                  `price` - aggregated price value,<br>
                  `ok` - `true` if price is valid, otherwise it is populated with the reason description.<br>
                   Possible reasons for a price result to be invalid:                   1. if there are no live oracles which meet specified request.<br>
                   2. Sum of the weight of live oracles is zero.<br>
<br>
Examples:<br>
> defi-cli listprices <br>
> defi-cli listprices '{"start": 2, "including_start": true, "limit":100}'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listprices", "params": ['{}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listprices", "params": ['{"start": 2, "including_start": true, "limit":100}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>removeoracle "oracleid" ( [{"txid":"hex","vout":n},...] )</summary><p>
removeoracle "oracleid" ( [{"txid":"hex","vout":n},...] )<br>
<br>
Removes oracle, <br>
The only argument is oracleid hex value.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. oracleid                (string, required) oracle id<br>
2. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli removeoracle 0xabcd1234ac1243578697085986498694<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "removeoracle", "params": [0xabcd1234ac1243578697085986498694] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>setoracledata "oracleid" timestamp [{"currency":"str","tokenAmount":"str"},...] ( [{"txid":"hex","vout":n},...] )</summary><p>
setoracledata "oracleid" timestamp [{"currency":"str","tokenAmount":"str"},...] ( [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) a `set oracle data transaction`.<br>
The last optional argument (may be empty array) is an array of specific UTXOs to spend.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. oracleid                       (string, required) oracle hex id<br>
2. timestamp                      (numeric, required) balances timestamp<br>
3. prices                         (json array, required) tokens raw prices:the array of price and token strings in price@token format. <br>
     [<br>
       {                          (json object)<br>
         "currency": "str",       (string, required) Currency name<br>
         "tokenAmount": "str",    (string, required) Amount@token<br>
       },<br>
       ...<br>
     ]<br>
4. inputs                         (json array, optional) A json array of json objects<br>
     [<br>
       {                          (json object)<br>
         "txid": "hex",           (string, required) The transaction id<br>
         "vout": n,               (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli setoracledata 5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf 1612237937 '[{"currency":"USD", "tokenAmount":"38293.12@BTC"}"<br>
                               ", {currency:"EUR", "tokenAmount":"1328.32@ETH"}]'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "setoracledata", "params": [5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf 1612237937 '[{"currency":"USD", "tokenAmount":"38293.12@BTC"}"<br>
                               ", {currency:"EUR", "tokenAmount":"1328.32@ETH"}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>updateoracle "oracleid" "address" [{"currency":"str","token":"str"},...] weightage ( [{"txid":"hex","vout":n},...] )</summary><p>
updateoracle "oracleid" "address" [{"currency":"str","token":"str"},...] weightage ( [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) a `update oracle transaction`, <br>
and saves oracle updates to database.<br>
The last optional argument (may be empty array) is an array of specific UTXOs to spend.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. oracleid                    (string, required) oracle id<br>
2. address                     (string, required) oracle address<br>
3. pricefeeds                  (json array, required) list of allowed token-currency pairs<br>
     [<br>
       {                       (json object)<br>
         "currency": "str",    (string, required) Currency name<br>
         "token": "str",       (string, required) Token name<br>
       },<br>
       ...<br>
     ]<br>
4. weightage                   (numeric, required) oracle weightage<br>
5. inputs                      (json array, optional) A json array of json objects<br>
     [<br>
       {                       (json object)<br>
         "txid": "hex",        (string, required) The transaction id<br>
         "vout": n,            (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli updateoracle 84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2 mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF '[{"currency": "USD", "token": "BTC"}, {"currency": "EUR", "token":"ETH"]}' 20<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "updateoracle", "params": [84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2 mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF '[{"currency": "USD", "token": "BTC"}, {"currency": "EUR", "token":"ETH"]}' 20] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

## Poolpair
<details><summary>addpoolliquidity {"address":"str"} "shareAddress" ( [{"txid":"hex","vout":n},...] )</summary><p>
addpoolliquidity {"address":"str"} "shareAddress" ( [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) a add pool liquidity transaction.<br>
The last optional argument (may be empty array) is an array of specific UTXOs to spend.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. from                     (json object, required)<br>
     {<br>
       "address": "str",    (string, required) The defi address(es) is the key(s), the value(s) is amount in amount@token format. You should provide exectly two types of tokens for pool's 'token A' and 'token B' in any combinations.If multiple tokens from one address are to be transferred, specify an array ["amount1@t1", "amount2@t2"]If "from" obj contain only one amount entry with address-key: "*" (star), it's means auto-selection accounts from wallet.<br>
     }<br>
2. shareAddress             (string, required) The defi address for crediting tokens.<br>
3. inputs                   (json array, optional) A json array of json objects<br>
     [<br>
       {                    (json object)<br>
         "txid": "hex",     (string, required) The transaction id<br>
         "vout": n,         (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli addpoolliquidity '{"address1":"1.0@DFI","address2":"1.0@DFI"}' share_address '[]'<br>
> defi-cli addpoolliquidity '{"*": ["2.0@BTC", "3.0@ETH"]}' share_address '[]'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "addpoolliquidity", "params": ['{"address1":"1.0@DFI","address2":"1.0@DFI"}' share_address '[]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>compositeswap {"from":"str","tokenFrom":"str","amountFrom":n,"to":"str","tokenTo":"str","maxPrice":n} ( [{"txid":"hex","vout":n},...] )</summary><p>
compositeswap {"from":"str","tokenFrom":"str","amountFrom":n,"to":"str","tokenTo":"str","maxPrice":n} ( [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) a composite swap (swap between multiple poolpairs) transaction with given metadata.<br>
The second optional argument (may be empty array) is an array of specific UTXOs to spend.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. metadata                   (json object, required)<br>
     {<br>
       "from": "str",         (string, required) Address of the owner of tokenA.<br>
       "tokenFrom": "str",    (string, required) One of the keys may be specified (id/symbol)<br>
       "amountFrom": n,       (numeric, required) tokenFrom coins amount<br>
       "to": "str",           (string, required) Address of the owner of tokenB.<br>
       "tokenTo": "str",      (string, required) One of the keys may be specified (id/symbol)<br>
       "maxPrice": n,         (numeric) Maximum acceptable price<br>
     }<br>
2. inputs                     (json array, optional) A json array of json objects<br>
     [<br>
       {                      (json object)<br>
         "txid": "hex",       (string, required) The transaction id<br>
         "vout": n,           (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli compositeswap '{"from":"MyAddress","tokenFrom":"MyToken1","amountFrom":"0.001","to":"Address","tokenTo":"Token2","maxPrice":"0.01"}' '[{"txid":"id","vout":0}]'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "compositeswap", "params": ['{"from":"MyAddress","tokenFrom":"MyToken1","amountFrom":"0.001","to":"Address","tokenTo":"Token2","maxPrice":"0.01"}' '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>createpoolpair ( {"tokenA":"str","tokenB":"str","commission":n,"status":bool,"ownerAddress":"str","customRewards":"str","pairSymbol":"str"} [{"txid":"hex","vout":n},...] )</summary><p>
createpoolpair ( {"tokenA":"str","tokenB":"str","commission":n,"status":bool,"ownerAddress":"str","customRewards":"str","pairSymbol":"str"} [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) a poolpair transaction with given metadata.<br>
The second optional argument (may be empty array) is an array of specific UTXOs to spend.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. metadata                       (json object)<br>
     {<br>
       "tokenA": "str",           (string, required) One of the keys may be specified (id/symbol)<br>
       "tokenB": "str",           (string, required) One of the keys may be specified (id/symbol)<br>
       "commission": n,           (numeric, required) Pool commission, up to 10^-8<br>
       "status": bool,            (boolean, required) Pool Status: True is Active, False is Restricted<br>
       "ownerAddress": "str",     (string, required) Address of the pool owner.<br>
       "customRewards": "str",    (string) Token reward to be paid on each block, multiple can be specified.<br>
       "pairSymbol": "str",       (string) Pair symbol (unique), no longer than 8<br>
     }<br>
2. inputs                         (json array, optional) A json array of json objects<br>
     [<br>
       {                          (json object)<br>
         "txid": "hex",           (string, required) The transaction id<br>
         "vout": n,               (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli createpoolpair '{"tokenA":"MyToken1","tokenB":"MyToken2","commission":"0.001","status":"True","ownerAddress":"Address","customRewards":"[\"1@tokena\",\"10@tokenb\"]"}' '[{"txid":"id","vout":0}]'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createpoolpair", "params": ['{"tokenA":"MyToken1","tokenB":"MyToken2","commission":"0.001","status":"True","ownerAddress":"Address","customRewards":"[\"1@tokena\",\"10@tokenb\"]"}' '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getpoolpair "key" ( verbose )</summary><p>
getpoolpair "key" ( verbose )<br>
<br>
Returns information about pool.<br>
<br>
Arguments:<br>
1. key        (string, required) One of the keys may be specified (id/symbol/creationTx)<br>
2. verbose    (boolean) Flag for verbose list (default = true), otherwise limited objects are listed<br>
<br>
Result:<br>
{id:{...}}     (array) Json object with pool information<br>
<br>
Examples:<br>
> defi-cli getpoolpair GOLD<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getpoolpair", "params": [GOLD] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listpoolpairs ( {"start":n,"including_start":bool,"limit":n} verbose )</summary><p>
listpoolpairs ( {"start":n,"including_start":bool,"limit":n} verbose )<br>
<br>
Returns information about pools.<br>
<br>
Arguments:<br>
1. pagination                      (json object)<br>
     {<br>
       "start": n,                 (numeric) Optional first key to iterate from, in lexicographical order.Typically it's set to last ID from previous request.<br>
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default<br>
       "limit": n,                 (numeric) Maximum number of pools to return, 100 by default<br>
     }<br>
2. verbose                         (boolean) Flag for verbose list (default = true), otherwise only ids, symbols and names are listed<br>
<br>
Result:<br>
{id:{...},...}     (array) Json object with pools information<br>
<br>
Examples:<br>
> defi-cli listpoolpairs '{"start":128}' false<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listpoolpairs", "params": ['{"start":128}' false] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listpoolshares ( {"start":n,"including_start":bool,"limit":n} verbose is_mine_only )</summary><p>
listpoolshares ( {"start":n,"including_start":bool,"limit":n} verbose is_mine_only )<br>
<br>
Returns information about pool shares.<br>
<br>
Arguments:<br>
1. pagination                      (json object)<br>
     {<br>
       "start": n,                 (numeric) Optional first key to iterate from, in lexicographical order.<br>
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default<br>
       "limit": n,                 (numeric) Maximum number of pools to return, 100 by default<br>
     }<br>
2. verbose                         (boolean) Flag for verbose list (default = true), otherwise only % are shown.<br>
3. is_mine_only                    (boolean) Get shares for all accounts belonging to the wallet (default = false)<br>
<br>
Result:<br>
{id:{...},...}     (array) Json object with pools information<br>
<br>
Examples:<br>
> defi-cli listpoolshares '{"start":128}' false false<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listpoolshares", "params": ['{"start":128}' false false] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>poolswap {"from":"str","tokenFrom":"str","amountFrom":n,"to":"str","tokenTo":"str","maxPrice":n} ( [{"txid":"hex","vout":n},...] )</summary><p>
poolswap {"from":"str","tokenFrom":"str","amountFrom":n,"to":"str","tokenTo":"str","maxPrice":n} ( [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) a poolswap transaction with given metadata.<br>
The second optional argument (may be empty array) is an array of specific UTXOs to spend.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. metadata                   (json object, required)<br>
     {<br>
       "from": "str",         (string, required) Address of the owner of tokenA.<br>
       "tokenFrom": "str",    (string, required) One of the keys may be specified (id/symbol)<br>
       "amountFrom": n,       (numeric, required) tokenFrom coins amount<br>
       "to": "str",           (string, required) Address of the owner of tokenB.<br>
       "tokenTo": "str",      (string, required) One of the keys may be specified (id/symbol)<br>
       "maxPrice": n,         (numeric) Maximum acceptable price<br>
     }<br>
2. inputs                     (json array, optional) A json array of json objects<br>
     [<br>
       {                      (json object)<br>
         "txid": "hex",       (string, required) The transaction id<br>
         "vout": n,           (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli poolswap '{"from":"MyAddress","tokenFrom":"MyToken1","amountFrom":"0.001","to":"Address","tokenTo":"Token2","maxPrice":"0.01"}' '[{"txid":"id","vout":0}]'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "poolswap", "params": ['{"from":"MyAddress","tokenFrom":"MyToken1","amountFrom":"0.001","to":"Address","tokenTo":"Token2","maxPrice":"0.01"}' '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>removepoolliquidity "from" "amount" ( [{"txid":"hex","vout":n},...] )</summary><p>
removepoolliquidity "from" "amount" ( [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) a remove pool liquidity transaction.<br>
The last optional argument (may be empty array) is an array of specific UTXOs to spend.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. from                    (string, required) The defi address which has tokens<br>
2. amount                  (string, required) Liquidity amount@Liquidity pool symbol<br>
3. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli removepoolliquidity from_address 1.0@LpSymbol<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "removepoolliquidity", "params": [from_address 1.0@LpSymbol] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>testpoolswap ( {"from":"str","tokenFrom":"str","amountFrom":n,"to":"str","tokenTo":"str","maxPrice":n} "path" verbose )</summary><p>
testpoolswap ( {"from":"str","tokenFrom":"str","amountFrom":n,"to":"str","tokenTo":"str","maxPrice":n} "path" verbose )<br>
<br>
Tests a poolswap transaction with given metadata and returns poolswap result.<br>
<br>
Arguments:<br>
1. metadata                   (json object)<br>
     {<br>
       "from": "str",         (string, required) Address of the owner of tokenA.<br>
       "tokenFrom": "str",    (string, required) One of the keys may be specified (id/symbol)<br>
       "amountFrom": n,       (numeric, required) tokenFrom coins amount<br>
       "to": "str",           (string, required) Address of the owner of tokenB.<br>
       "tokenTo": "str",      (string, required) One of the keys may be specified (id/symbol)<br>
       "maxPrice": n,         (numeric) Maximum acceptable price<br>
     }<br>
2. path                       (string) One of auto/direct (default = direct)<br>
                              auto - automatically use composite swap or direct swap as needed.<br>
                              direct - uses direct path only or fails.<br>
                              composite - uses composite path only or fails.<br>
                              Note: The default will be switched to auto in the upcoming versions.<br>
3. verbose                    (boolean) Returns estimated composite path when true (default = false)<br>
<br>
Result:<br>
"amount@tokenId"    (string) The string with amount result of poolswap in format AMOUNT@TOKENID.<br>
<br>
Examples:<br>
> defi-cli testpoolswap '{"from":"MyAddress","tokenFrom":"MyToken1","amountFrom":"0.001","to":"Address","tokenTo":"Token2","maxPrice":"0.01"}'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "testpoolswap", "params": ['{"from":"MyAddress","tokenFrom":"MyToken1","amountFrom":"0.001","to":"Address","tokenTo":"Token2","maxPrice":"0.01"}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>updatepoolpair ( {"pool":"str","status":bool,"commission":n,"ownerAddress":"str","customRewards":"str"} [{"txid":"hex","vout":n},...] )</summary><p>
updatepoolpair ( {"pool":"str","status":bool,"commission":n,"ownerAddress":"str","customRewards":"str"} [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) a pool status update transaction.<br>
The second optional argument (may be empty array) is an array of specific UTXOs to spend. One of UTXO's must belong to the pool's owner (collateral) address<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. metadata                       (json object)<br>
     {<br>
       "pool": "str",             (string, required) The pool's symbol, id or creation tx<br>
       "status": bool,            (boolean) Pool Status new property (bool)<br>
       "commission": n,           (numeric) Pool commission, up to 10^-8<br>
       "ownerAddress": "str",     (string) Address of the pool owner.<br>
       "customRewards": "str",    (string) Token reward to be paid on each block, multiple can be specified.<br>
     }<br>
2. inputs                         (json array, optional) A json array of json objects<br>
     [<br>
       {                          (json object)<br>
         "txid": "hex",           (string, required) The transaction id<br>
         "vout": n,               (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli updatepoolpair '{"pool":"POOL","status":true,"commission":0.01,"ownerAddress":"Address","customRewards":"[\"1@tokena\",\"10@tokenb\"]"}' '[{"txid":"id","vout":0}]'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "updatepoolpair", "params": ['{"pool":"POOL","status":true,"commission":0.01,"ownerAddress":"Address","customRewards":"[\"1@tokena\",\"10@tokenb\"]"}' '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

## Proposals
<details><summary>creategovcfp ( {"title":"str","context":"str","contextHash":"str","cycles":n,"amount":amount,"payoutAddress":"str"} [{"txid":"hex","vout":n},...] )</summary><p>
creategovcfp ( {"title":"str","context":"str","contextHash":"str","cycles":n,"amount":amount,"payoutAddress":"str"} [{"txid":"hex","vout":n},...] )<br>
<br>
Creates a Community Fund Proposal<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. data                           (json object, optional) data in json-form, containing cfp data<br>
     {<br>
       "title": "str",            (string, required) The title of community fund request<br>
       "context": "str",          (string, required) The context field of community fund request<br>
       "contextHash": "str",      (string) The hash of the content which context field point to of community fund request<br>
       "cycles": n,               (numeric) Defaulted to one cycle<br>
       "amount": amount,          (numeric or string, required) Amount in DFI to request<br>
       "payoutAddress": "str",    (string, required) Any valid address for receiving<br>
     }<br>
2. inputs                         (json array, optional) A json array of json objects<br>
     [<br>
       {                          (json object)<br>
         "txid": "hex",           (string, required) The transaction id<br>
         "vout": n,               (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli creategovcfp '{"title":"The cfp title","context":"The cfp context","amount":10,"payoutAddress":"address"}' '[{"txid":"id","vout":0}]'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "creategovcfp", "params": ['{"title":"The cfp title","context":"The cfp context","amount":10,"payoutAddress":"address"} '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>creategovvoc ( {"title":"str","context":"str","contextHash":"str","emergency":bool} [{"txid":"hex","vout":n},...] )</summary><p>
creategovvoc ( {"title":"str","context":"str","contextHash":"str","emergency":bool} [{"txid":"hex","vout":n},...] )<br>
<br>
Creates a Vote of Confidence<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. data                         (json object, optional) data in json-form, containing voc data<br>
     {<br>
       "title": "str",          (string, required) The title of vote of confidence<br>
       "context": "str",        (string, required) The context field for vote of confidence<br>
       "contextHash": "str",    (string) The hash of the content which context field point to of vote of confidence request<br>
       "emergency": bool,       (boolean) Is this emergency VOC<br>
     }<br>
2. inputs                       (json array, optional) A json array of json objects<br>
     [<br>
       {                        (json object)<br>
         "txid": "hex",         (string, required) The transaction id<br>
         "vout": n,             (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli creategovvoc 'The voc title' 'The voc context' '[{"txid":"id","vout":0}]'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "creategovvoc", "params": ['The voc title' 'The voc context' '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getgovproposal "proposalId"</summary><p>
getgovproposal "proposalId"<br>
<br>
Returns real time information about proposal state.<br>
<br>
Arguments:<br>
1. proposalId    (string, required) The proposal id)<br>
<br>
Result:<br>
{id:{...},...}     (obj) Json object with proposal vote information<br>
<br>
Examples:<br>
> defi-cli getgovproposal txid<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getgovproposal", "params": [txid] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listgovproposals ( "type" "status" )</summary><p>
listgovproposals ( "type" "status" )<br>
<br>
Returns information about proposals.<br>
<br>
Arguments:<br>
1. type      (string) cfp/voc/all (default = all)<br>
2. status    (string) voting/rejected/completed/all (default = all)<br>
<br>
Result:<br>
{id:{...},...}     (array) Json object with proposals information<br>
<br>
Examples:<br>
> defi-cli listgovproposals <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listgovproposals", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listgovproposalvotes "proposalId" ( "masternode" cycle )</summary><p>
listgovproposalvotes "proposalId" ( "masternode" cycle )<br>
<br>
Returns information about proposal votes.<br>
<br>
Arguments:<br>
1. proposalId    (string, required) The proposal id)<br>
2. masternode    (string) mine/all/id (default = mine)<br>
3. cycle         (numeric) cycle: 0 (show current), cycle: N (show cycle N), cycle: -1 (show all) (default = 0)<br>
<br>
Result:<br>
{id:{...},...}     (array) Json object with proposal vote information<br>
<br>
Examples:<br>
> defi-cli listgovproposalvotes txid<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listgovproposalvotes", "params": [txid] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>votegov "proposalId" "masternodeId" "decision" ( [{"txid":"hex","vout":n},...] )</summary><p>
votegov "proposalId" "masternodeId" "decision" ( [{"txid":"hex","vout":n},...] )<br>
<br>
Vote for community proposal<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. proposalId              (string, required) The proposal txid<br>
2. masternodeId            (string, required) The masternode id which made the vote<br>
3. decision                (string, required) The vote decision (yes/no/neutral)<br>
4. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli votegov txid masternodeId yes<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "votegov", "params": [txid masternodeId yes] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

## Rawtransactions
<details><summary>analyzepsbt "psbt"</summary><p>
analyzepsbt "psbt"<br>
<br>
Analyzes and provides information about the current status of a PSBT and its inputs<br>
<br>
Arguments:<br>
1. psbt    (string, required) A base64 string of a PSBT<br>
<br>
Result:<br>
{<br>
  "inputs" : [                      (array of json objects)<br>
    {<br>
      "has_utxo" : true|false     (boolean) Whether a UTXO is provided<br>
      "is_final" : true|false     (boolean) Whether the input is finalized<br>
      "missing" : {               (json object, optional) Things that are missing that are required to complete this input<br>
        "pubkeys" : [             (array, optional)<br>
          "keyid"                 (string) Public key ID, hash160 of the public key, of a public key whose BIP 32 derivation path is missing<br>
        ]<br>
        "signatures" : [          (array, optional)<br>
          "keyid"                 (string) Public key ID, hash160 of the public key, of a public key whose signature is missing<br>
        ]<br>
        "redeemscript" : "hash"   (string, optional) Hash160 of the redeemScript that is missing<br>
        "witnessscript" : "hash"  (string, optional) SHA256 of the witnessScript that is missing<br>
      }<br>
      "next" : "role"             (string, optional) Role of the next person that this input needs to go to<br>
    }<br>
    ,...<br>
  ]<br>
  "estimated_vsize" : vsize       (numeric, optional) Estimated vsize of the final signed transaction<br>
  "estimated_feerate" : feerate   (numeric, optional) Estimated feerate of the final signed transaction in DFI/kB. Shown only if all UTXO slots in the PSBT have been filled.<br>
  "fee" : fee                     (numeric, optional) The transaction fee paid. Shown only if all UTXO slots in the PSBT have been filled.<br>
  "next" : "role"                 (string) Role of the next person that this psbt needs to go to<br>
}<br>
<br>
Examples:<br>
> defi-cli analyzepsbt "psbt"<br>

</p></details>

<details><summary>combinepsbt ["psbt",...]</summary><p>
combinepsbt ["psbt",...]<br>
<br>
Combine multiple partially signed Defi transactions into one transaction.<br>
Implements the Combiner role.<br>
<br>
Arguments:<br>
1. txs            (json array, required) A json array of base64 strings of partially signed transactions<br>
     [<br>
       "psbt",    (string) A base64 string of a PSBT<br>
       ...<br>
     ]<br>
<br>
Result:<br>
  "psbt"          (string) The base64-encoded partially signed transaction<br>
<br>
Examples:<br>
> defi-cli combinepsbt ["mybase64_1", "mybase64_2", "mybase64_3"]<br>

</p></details>

<details><summary>combinerawtransaction ["hexstring",...]</summary><p>
combinerawtransaction ["hexstring",...]<br>
<br>
Combine multiple partially signed transactions into one transaction.<br>
The combined transaction may be another partially signed transaction or a <br>
fully signed transaction.<br>
Arguments:<br>
1. txs                 (json array, required) A json array of hex strings of partially signed transactions<br>
     [<br>
       "hexstring",    (string) A transaction hash<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hex"            (string) The hex-encoded raw transaction with signature(s)<br>
<br>
Examples:<br>
> defi-cli combinerawtransaction ["myhex1", "myhex2", "myhex3"]<br>

</p></details>

<details><summary>converttopsbt "hexstring" ( permitsigdata iswitness )</summary><p>
converttopsbt "hexstring" ( permitsigdata iswitness )<br>
<br>
Converts a network serialized transaction to a PSBT. This should be used only with createrawtransaction and fundrawtransaction<br>
createpsbt and walletcreatefundedpsbt should be used for new applications.<br>
<br>
Arguments:<br>
1. hexstring        (string, required) The hex string of a raw transaction<br>
2. permitsigdata    (boolean, optional, default=false) If true, any signatures in the input will be discarded and conversion<br>
                    will continue. If false, RPC will fail if any signatures are present.<br>
3. iswitness        (boolean, optional, default=depends on heuristic tests) Whether the transaction hex is a serialized witness transaction.<br>
                    If iswitness is not present, heuristic tests will be used in decoding.<br>
                    If true, only witness deserialization will be tried.<br>
                    If false, only non-witness deserialization will be tried.<br>
                    This boolean should reflect whether the transaction has inputs<br>
                    (e.g. fully valid, or on-chain transactions), if known by the caller.<br>
<br>
Result:<br>
  "psbt"        (string)  The resulting raw transaction (base64-encoded string)<br>
<br>
Examples:<br>
<br>
Create a transaction<br>
> defi-cli createrawtransaction "[{\"txid\":\"myid\",\"vout\":0}]" "[{\"data\":\"00010203\"}]"<br>
<br>
Convert the transaction to a PSBT<br>
> defi-cli converttopsbt "rawtransaction"<br>

</p></details>

<details><summary>createpsbt [{"txid":"hex","vout":n,"sequence":n},...] [{"address":amount},{"data":"hex"},...] ( locktime replaceable )</summary><p>
createpsbt [{"txid":"hex","vout":n,"sequence":n},...] [{"address":amount},{"data":"hex"},...] ( locktime replaceable )<br>
<br>
Creates a transaction in the Partially Signed Transaction format.<br>
Implements the Creator role.<br>
<br>
Arguments:<br>
1. inputs                      (json array, required) A json array of json objects<br>
     [<br>
       {                       (json object)<br>
         "txid": "hex",        (string, required) The transaction id<br>
         "vout": n,            (numeric, required) The output number<br>
         "sequence": n,        (numeric, optional, default=depends on the value of the 'replaceable' and 'locktime' arguments) The sequence number<br>
       },<br>
       ...<br>
     ]<br>
2. outputs                     (json array, required) a json array with outputs (key-value pairs), where none of the keys are duplicated.<br>
                               That is, each address can only appear once and there can only be one 'data' object.<br>
                               For compatibility reasons, a dictionary, which holds the key-value pairs directly, is also<br>
                               accepted as second parameter.<br>
     [<br>
       {                       (json object)<br>
         "address": amount,    (numeric or string, required) A key-value pair. The key (string) is the DFI address, the value (float or string) is the amount in DFI<br>
       },<br>
       {                       (json object)<br>
         "data": "hex",        (string, required) A key-value pair. The key must be "data", the value is hex-encoded data<br>
       },<br>
       ...<br>
     ]<br>
3. locktime                    (numeric, optional, default=0) Raw locktime. Non-0 value also locktime-activates inputs<br>
4. replaceable                 (boolean, optional, default=false) Marks this transaction as BIP125 replaceable.<br>
                               Allows this transaction to be replaced by a transaction with higher fees. If provided, it is an error if explicit sequence numbers are incompatible.<br>
<br>
Result:<br>
  "psbt"        (string)  The resulting raw transaction (base64-encoded string)<br>
<br>
Examples:<br>
> defi-cli createpsbt "[{\"txid\":\"myid\",\"vout\":0}]" "[{\"data\":\"00010203\"}]"<br>

</p></details>

<details><summary>createrawtransaction [{"txid":"hex","vout":n,"sequence":n},...] [{"address":amount},{"data":"hex"},...] ( locktime replaceable )</summary><p>
createrawtransaction [{"txid":"hex","vout":n,"sequence":n},...] [{"address":amount},{"data":"hex"},...] ( locktime replaceable )<br>
<br>
Create a transaction spending the given inputs and creating new outputs.<br>
Outputs can be addresses or data.<br>
Returns hex-encoded raw transaction.<br>
Note that the transaction's inputs are not signed, and<br>
it is not stored in the wallet or transmitted to the network.<br>
<br>
Arguments:<br>
1. inputs                      (json array, required) A json array of json objects<br>
     [<br>
       {                       (json object)<br>
         "txid": "hex",        (string, required) The transaction id<br>
         "vout": n,            (numeric, required) The output number<br>
         "sequence": n,        (numeric, optional, default=depends on the value of the 'replaceable' and 'locktime' arguments) The sequence number<br>
       },<br>
       ...<br>
     ]<br>
2. outputs                     (json array, required) a json array with outputs (key-value pairs), where none of the keys are duplicated.<br>
                               That is, each address can only appear once and there can only be one 'data' object.<br>
                               For compatibility reasons, a dictionary, which holds the key-value pairs directly, is also<br>
                               accepted as second parameter.<br>
     [<br>
       {                       (json object)<br>
         "address": amount,    (numeric or string, required) A key-value pair. The key (string) is the DFI address, the value (float or string) is the amount in DFI<br>
       },<br>
       {                       (json object)<br>
         "data": "hex",        (string, required) A key-value pair. The key must be "data", the value is hex-encoded data<br>
       },<br>
       ...<br>
     ]<br>
3. locktime                    (numeric, optional, default=0) Raw locktime. Non-0 value also locktime-activates inputs<br>
4. replaceable                 (boolean, optional, default=false) Marks this transaction as BIP125-replaceable.<br>
                               Allows this transaction to be replaced by a transaction with higher fees. If provided, it is an error if explicit sequence numbers are incompatible.<br>
<br>
Result:<br>
"transaction"              (string) hex string of the transaction<br>
<br>
Examples:<br>
> defi-cli createrawtransaction "[{\"txid\":\"myid\",\"vout\":0}]" "[{\"address\":0.01}]"<br>
> defi-cli createrawtransaction "[{\"txid\":\"myid\",\"vout\":0}]" "[{\"data\":\"00010203\"}]"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createrawtransaction", "params": ["[{\"txid\":\"myid\",\"vout\":0}]", "[{\"address\":0.01}]"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createrawtransaction", "params": ["[{\"txid\":\"myid\",\"vout\":0}]", "[{\"data\":\"00010203\"}]"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>decodepsbt "psbt"</summary><p>
decodepsbt "psbt"<br>
<br>
Return a JSON object representing the serialized, base64-encoded partially signed Defi transaction.<br>
<br>
Arguments:<br>
1. psbt    (string, required) The PSBT base64 string<br>
<br>
Result:<br>
{<br>
  "tx" : {                   (json object) The decoded network-serialized unsigned transaction.<br>
    ...                                      The layout is the same as the output of decoderawtransaction.<br>
  },<br>
  "unknown" : {                (json object) The unknown global fields<br>
    "key" : "value"            (key-value pair) An unknown key-value pair<br>
     ...<br>
  },<br>
  "inputs" : [                 (array of json objects)<br>
    {<br>
      "non_witness_utxo" : {   (json object, optional) Decoded network transaction for non-witness UTXOs<br>
        ...<br>
      },<br>
      "witness_utxo" : {            (json object, optional) Transaction output for witness UTXOs<br>
        "amount" : x.xxx,           (numeric) The value in DFI<br>
        "scriptPubKey" : {          (json object)<br>
          "asm" : "asm",            (string) The asm<br>
          "hex" : "hex",            (string) The hex<br>
          "type" : "pubkeyhash",    (string) The type, eg 'pubkeyhash'<br>
          "address" : "address"     (string) Defi address if there is one<br>
        }<br>
      },<br>
      "partial_signatures" : {             (json object, optional)<br>
        "pubkey" : "signature",           (string) The public key and signature that corresponds to it.<br>
        ,...<br>
      }<br>
      "sighash" : "type",                  (string, optional) The sighash type to be used<br>
      "redeem_script" : {       (json object, optional)<br>
          "asm" : "asm",            (string) The asm<br>
          "hex" : "hex",            (string) The hex<br>
          "type" : "pubkeyhash",    (string) The type, eg 'pubkeyhash'<br>
        }<br>
      "witness_script" : {       (json object, optional)<br>
          "asm" : "asm",            (string) The asm<br>
          "hex" : "hex",            (string) The hex<br>
          "type" : "pubkeyhash",    (string) The type, eg 'pubkeyhash'<br>
        }<br>
      "bip32_derivs" : {          (json object, optional)<br>
        "pubkey" : {                     (json object, optional) The public key with the derivation path as the value.<br>
          "master_fingerprint" : "fingerprint"     (string) The fingerprint of the master key<br>
          "path" : "path",                         (string) The path<br>
        }<br>
        ,...<br>
      }<br>
      "final_scriptsig" : {       (json object, optional)<br>
          "asm" : "asm",            (string) The asm<br>
          "hex" : "hex",            (string) The hex<br>
        }<br>
       "final_scriptwitness": ["hex", ...] (array of string) hex-encoded witness data (if any)<br>
      "unknown" : {                (json object) The unknown global fields<br>
        "key" : "value"            (key-value pair) An unknown key-value pair<br>
         ...<br>
      },<br>
    }<br>
    ,...<br>
  ]<br>
  "outputs" : [                 (array of json objects)<br>
    {<br>
      "redeem_script" : {       (json object, optional)<br>
          "asm" : "asm",            (string) The asm<br>
          "hex" : "hex",            (string) The hex<br>
          "type" : "pubkeyhash",    (string) The type, eg 'pubkeyhash'<br>
        }<br>
      "witness_script" : {       (json object, optional)<br>
          "asm" : "asm",            (string) The asm<br>
          "hex" : "hex",            (string) The hex<br>
          "type" : "pubkeyhash",    (string) The type, eg 'pubkeyhash'<br>
      }<br>
      "bip32_derivs" : [          (array of json objects, optional)<br>
        {<br>
          "pubkey" : "pubkey",                     (string) The public key this path corresponds to<br>
          "master_fingerprint" : "fingerprint"     (string) The fingerprint of the master key<br>
          "path" : "path",                         (string) The path<br>
          }<br>
        }<br>
        ,...<br>
      ],<br>
      "unknown" : {                (json object) The unknown global fields<br>
        "key" : "value"            (key-value pair) An unknown key-value pair<br>
         ...<br>
      },<br>
    }<br>
    ,...<br>
  ]<br>
  "fee" : fee                      (numeric, optional) The transaction fee paid if all UTXOs slots in the PSBT have been filled.<br>
}<br>
<br>
Examples:<br>
> defi-cli decodepsbt "psbt"<br>

</p></details>

<details><summary>decoderawtransaction "hexstring" ( iswitness )</summary><p>
decoderawtransaction "hexstring" ( iswitness )<br>
<br>
Return a JSON object representing the serialized, hex-encoded transaction.<br>
<br>
Arguments:<br>
1. hexstring    (string, required) The transaction hex string<br>
2. iswitness    (boolean, optional, default=depends on heuristic tests) Whether the transaction hex is a serialized witness transaction.<br>
                If iswitness is not present, heuristic tests will be used in decoding.<br>
                If true, only witness deserialization will be tried.<br>
                If false, only non-witness deserialization will be tried.<br>
                This boolean should reflect whether the transaction has inputs<br>
                (e.g. fully valid, or on-chain transactions), if known by the caller.<br>
<br>
Result:<br>
{<br>
  "txid" : "id",        (string) The transaction id<br>
  "hash" : "id",        (string) The transaction hash (differs from txid for witness transactions)<br>
  "size" : n,             (numeric) The transaction size<br>
  "vsize" : n,            (numeric) The virtual transaction size (differs from size for witness transactions)<br>
  "weight" : n,           (numeric) The transaction's weight (between vsize*4 - 3 and vsize*4)<br>
  "version" : n,          (numeric) The version<br>
  "locktime" : ttt,       (numeric) The lock time<br>
  "vin" : [               (array of json objects)<br>
     {<br>
       "txid": "id",    (string) The transaction id<br>
       "vout": n,         (numeric) The output number<br>
       "scriptSig": {     (json object) The script<br>
         "asm": "asm",  (string) asm<br>
         "hex": "hex"   (string) hex<br>
       },<br>
       "txinwitness": ["hex", ...] (array of string) hex-encoded witness data (if any)<br>
       "sequence": n     (numeric) The script sequence number<br>
     }<br>
     ,...<br>
  ],<br>
  "vout" : [             (array of json objects)<br>
     {<br>
       "value" : x.xxx,            (numeric) The value in DFI<br>
       "n" : n,                    (numeric) index<br>
       "scriptPubKey" : {          (json object)<br>
         "asm" : "asm",          (string) the asm<br>
         "hex" : "hex",          (string) the hex<br>
         "reqSigs" : n,            (numeric) The required sigs<br>
         "type" : "pubkeyhash",  (string) The type, eg 'pubkeyhash'<br>
         "addresses" : [           (json array of string)<br>
           "12tvKAXCxZjSmdNbao16dKXC8tRWfcF5oc"   (string) defi address<br>
           ,...<br>
         ]<br>
       }<br>
     }<br>
     ,...<br>
  ],<br>
}<br>
<br>
Examples:<br>
> defi-cli decoderawtransaction "hexstring"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "decoderawtransaction", "params": ["hexstring"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>decodescript "hexstring"</summary><p>
decodescript "hexstring"<br>
<br>
Decode a hex-encoded script.<br>
<br>
Arguments:<br>
1. hexstring    (string, required) the hex-encoded script<br>
<br>
Result:<br>
{<br>
  "asm":"asm",          (string) Script public key<br>
  "type":"type",        (string) The output type (e.g. nonstandard, pubkey, pubkeyhash, scripthash, multisig, nulldata, witness_v0_scripthash, witness_v0_keyhash, witness_unknown)<br>
  "reqSigs": n,         (numeric) The required signatures<br>
  "addresses": [        (json array of string)<br>
     "address"          (string) defi address<br>
     ,...<br>
  ],<br>
  "p2sh":"str"          (string) address of P2SH script wrapping this redeem script (not returned if the script is already a P2SH).<br>
  "segwit": {           (json object) Result of a witness script public key wrapping this redeem script (not returned if the script is a P2SH or witness).<br>
    "asm":"str",        (string) String representation of the script public key<br>
    "hex":"hexstr",     (string) Hex string of the script public key<br>
    "type":"str",       (string) The type of the script public key (e.g. witness_v0_keyhash or witness_v0_scripthash)<br>
    "reqSigs": n,       (numeric) The required signatures (always 1)<br>
    "addresses": [      (json array of string) (always length 1)<br>
      "address"         (string) segwit address<br>
       ,...<br>
    ],<br>
    "p2sh-segwit":"str" (string) address of the P2SH script wrapping this witness redeem script.<br>
}<br>
<br>
Examples:<br>
> defi-cli decodescript "hexstring"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "decodescript", "params": ["hexstring"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>finalizepsbt "psbt" ( extract )</summary><p>
finalizepsbt "psbt" ( extract )<br>
Finalize the inputs of a PSBT. If the transaction is fully signed, it will produce a<br>
network serialized transaction which can be broadcast with sendrawtransaction. Otherwise a PSBT will be<br>
created which has the final_scriptSig and final_scriptWitness fields filled for inputs that are complete.<br>
Implements the Finalizer and Extractor roles.<br>
<br>
Arguments:<br>
1. psbt       (string, required) A base64 string of a PSBT<br>
2. extract    (boolean, optional, default=true) If true and the transaction is complete,<br>
              extract and return the complete transaction in normal network serialization instead of the PSBT.<br>
<br>
Result:<br>
{<br>
  "psbt" : "value",          (string) The base64-encoded partially signed transaction if not extracted<br>
  "hex" : "value",           (string) The hex-encoded network transaction if extracted<br>
  "complete" : true|false,   (boolean) If the transaction has a complete set of signatures<br>
  ]<br>
}<br>
<br>
Examples:<br>
> defi-cli finalizepsbt "psbt"<br>

</p></details>

<details><summary>fundrawtransaction "hexstring" ( options iswitness )</summary><p>
fundrawtransaction "hexstring" ( options iswitness )<br>
<br>
Add inputs to a transaction until it has enough in value to meet its out value.<br>
This will not modify existing inputs, and will add at most one change output to the outputs.<br>
No existing outputs will be modified unless "subtractFeeFromOutputs" is specified.<br>
Note that inputs which were signed may need to be resigned after completion since in/outputs have been added.<br>
The inputs added will not be signed, use signrawtransactionwithkey<br>
 or signrawtransactionwithwallet for that.<br>
Note that all existing inputs must have their previous output transaction be in the wallet.<br>
Note that all inputs selected must be of standard form and P2SH scripts must be<br>
in the wallet using importaddress or addmultisigaddress (to calculate fees).<br>
You can see whether this is the case by checking the "solvable" field in the listunspent output.<br>
Only pay-to-pubkey, multisig, and P2SH versions thereof are currently supported for watch-only<br>
<br>
Arguments:<br>
1. hexstring                          (string, required) The hex string of the raw transaction<br>
2. options                            (json object, optional) for backward compatibility: passing in a true instead of an object will result in {"includeWatching":true}<br>
     {<br>
       "changeAddress": "str",        (string, optional, default=pool address) The defi address to receive the change<br>
       "changePosition": n,           (numeric, optional, default=random) The index of the change output<br>
       "change_type": "str",          (string, optional, default=set by -changetype) The output type to use. Only valid if changeAddress is not specified. Options are "legacy", "p2sh-segwit", and "bech32".<br>
       "includeWatching": bool,       (boolean, optional, default=true for watch-only wallets, otherwise false) Also select inputs which are watch only<br>
       "lockUnspents": bool,          (boolean, optional, default=false) Lock selected unspent outputs<br>
       "feeRate": amount,             (numeric or string, optional, default=not set: makes wallet determine the fee) Set a specific fee rate in DFI/kB<br>
       "subtractFeeFromOutputs": [    (json array, optional, default=empty array) A json array of integers.<br>
                                      The fee will be equally deducted from the amount of each specified output.<br>
                                      Those recipients will receive less defis than you enter in their corresponding amount field.<br>
                                      If no outputs are specified here, the sender pays the fee.<br>
         vout_index,                  (numeric) The zero-based output index, before a change output is added.<br>
         ...<br>
       ],<br>
       "replaceable": bool,           (boolean, optional, default=wallet default) Marks this transaction as BIP125 replaceable.<br>
                                      Allows this transaction to be replaced by a transaction with higher fees<br>
       "conf_target": n,              (numeric, optional, default=wallet default) Confirmation target (in blocks)<br>
       "estimate_mode": "str",        (string, optional, default=UNSET) The fee estimate mode, must be one of:<br>
                                      "UNSET"<br>
                                      "ECONOMICAL"<br>
                                      "CONSERVATIVE"<br>
     }<br>
3. iswitness                          (boolean, optional, default=depends on heuristic tests) Whether the transaction hex is a serialized witness transaction.<br>
                                      If iswitness is not present, heuristic tests will be used in decoding.<br>
                                      If true, only witness deserialization will be tried.<br>
                                      If false, only non-witness deserialization will be tried.<br>
                                      This boolean should reflect whether the transaction has inputs<br>
                                      (e.g. fully valid, or on-chain transactions), if known by the caller.<br>
<br>
Result:<br>
{<br>
  "hex":       "value", (string)  The resulting raw transaction (hex-encoded string)<br>
  "fee":       n,         (numeric) Fee in DFI the resulting transaction pays<br>
  "changepos": n          (numeric) The position of the added change output, or -1<br>
}<br>
<br>
Examples:<br>
<br>
Create a transaction with no inputs<br>
> defi-cli createrawtransaction "[]" "{\"myaddress\":0.01}"<br>
<br>
Add sufficient unsigned inputs to meet the output value<br>
> defi-cli fundrawtransaction "rawtransactionhex"<br>
<br>
Sign the transaction<br>
> defi-cli signrawtransactionwithwallet "fundedtransactionhex"<br>
<br>
Send the transaction<br>
> defi-cli sendrawtransaction "signedtransactionhex"<br>

</p></details>

<details><summary>getrawtransaction "txid" ( verbose "blockhash" )</summary><p>
getrawtransaction "txid" ( verbose "blockhash" )<br>
<br>
Return the raw transaction data.<br>
<br>
By default this function only works for mempool transactions. When called with a blockhash<br>
argument, getrawtransaction will return the transaction if the specified block is available and<br>
the transaction is found in that block. When called without a blockhash argument, getrawtransaction<br>
will return the transaction if it is in the mempool, or if -txindex is enabled and the transaction<br>
is in a block in the blockchain.<br>
<br>
Hint: Use gettransaction for wallet transactions.<br>
<br>
If verbose is 'true', returns an Object with information about 'txid'.<br>
If verbose is 'false' or omitted, returns a string that is serialized, hex-encoded data for 'txid'.<br>
<br>
Arguments:<br>
1. txid         (string, required) The transaction id<br>
2. verbose      (boolean, optional, default=false) If false, return a string, otherwise return a json object<br>
3. blockhash    (string, optional) The block in which to look for the transaction<br>
<br>
Result (if verbose is not set or set to false):<br>
"data"      (string) The serialized, hex-encoded data for 'txid'<br>
<br>
Result (if verbose is set to true):<br>
{<br>
  "in_active_chain": b, (bool) Whether specified block is in the active chain or not (only present with explicit "blockhash" argument)<br>
  "hex" : "data",       (string) The serialized, hex-encoded data for 'txid'<br>
  "txid" : "id",        (string) The transaction id (same as provided)<br>
  "hash" : "id",        (string) The transaction hash (differs from txid for witness transactions)<br>
  "size" : n,             (numeric) The serialized transaction size<br>
  "vsize" : n,            (numeric) The virtual transaction size (differs from size for witness transactions)<br>
  "weight" : n,           (numeric) The transaction's weight (between vsize*4-3 and vsize*4)<br>
  "version" : n,          (numeric) The version<br>
  "locktime" : ttt,       (numeric) The lock time<br>
  "vin" : [               (array of json objects)<br>
     {<br>
       "txid": "id",    (string) The transaction id<br>
       "vout": n,         (numeric) <br>
       "scriptSig": {     (json object) The script<br>
         "asm": "asm",  (string) asm<br>
         "hex": "hex"   (string) hex<br>
       },<br>
       "sequence": n      (numeric) The script sequence number<br>
       "txinwitness": ["hex", ...] (array of string) hex-encoded witness data (if any)<br>
     }<br>
     ,...<br>
  ],<br>
  "vout" : [              (array of json objects)<br>
     {<br>
       "value" : x.xxx,            (numeric) The value in DFI<br>
       "n" : n,                    (numeric) index<br>
       "scriptPubKey" : {          (json object)<br>
         "asm" : "asm",          (string) the asm<br>
         "hex" : "hex",          (string) the hex<br>
         "reqSigs" : n,            (numeric) The required sigs<br>
         "type" : "pubkeyhash",  (string) The type, eg 'pubkeyhash'<br>
         "addresses" : [           (json array of string)<br>
           "address"        (string) defi address<br>
           ,...<br>
         ]<br>
       }<br>
     }<br>
     ,...<br>
  ],<br>
  "blockhash" : "hash",   (string) the block hash<br>
  "confirmations" : n,      (numeric) The confirmations<br>
  "blocktime" : ttt         (numeric) The block time in seconds since epoch (Jan 1 1970 GMT)<br>
  "time" : ttt,             (numeric) Same as "blocktime"<br>
}<br>
<br>
Examples:<br>
> defi-cli getrawtransaction "mytxid"<br>
> defi-cli getrawtransaction "mytxid" true<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getrawtransaction", "params": ["mytxid", true] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> defi-cli getrawtransaction "mytxid" false "myblockhash"<br>
> defi-cli getrawtransaction "mytxid" true "myblockhash"<br>

</p></details>

<details><summary>joinpsbts ["psbt",...]</summary><p>
joinpsbts ["psbt",...]<br>
<br>
Joins multiple distinct PSBTs with different inputs and outputs into one PSBT with inputs and outputs from all of the PSBTs<br>
No input in any of the PSBTs can be in more than one of the PSBTs.<br>
<br>
Arguments:<br>
1. txs            (json array, required) A json array of base64 strings of partially signed transactions<br>
     [<br>
       "psbt",    (string, required) A base64 string of a PSBT<br>
       ...<br>
     ]<br>
<br>
Result:<br>
  "psbt"          (string) The base64-encoded partially signed transaction<br>
<br>
Examples:<br>
> defi-cli joinpsbts "psbt"<br>

</p></details>

<details><summary>sendrawtransaction "hexstring" ( maxfeerate )</summary><p>
sendrawtransaction "hexstring" ( maxfeerate )<br>
<br>
Submit a raw transaction (serialized, hex-encoded) to local node and network.<br>
<br>
Note that the transaction will be sent unconditionally to all peers, so using this<br>
for manual rebroadcast may degrade privacy by leaking the transaction's origin, as<br>
nodes will normally not rebroadcast non-wallet transactions already in their mempool.<br>
<br>
Also see createrawtransaction and signrawtransactionwithkey calls.<br>
<br>
Arguments:<br>
1. hexstring     (string, required) The hex string of the raw transaction<br>
2. maxfeerate    (numeric or string, optional, default=0.10) Reject transactions whose fee rate is higher than the specified value, expressed in DFI/kB.<br>
                 Set to 0 to accept any fee rate.<br>
                 <br>
<br>
Result:<br>
"hex"             (string) The transaction hash in hex<br>
<br>
Examples:<br>
<br>
Create a transaction<br>
> defi-cli createrawtransaction "[{\"txid\" : \"mytxid\",\"vout\":0}]" "{\"myaddress\":0.01}"<br>
Sign the transaction, and get back the hex<br>
> defi-cli signrawtransactionwithwallet "myhex"<br>
<br>
Send the transaction (signed hex)<br>
> defi-cli sendrawtransaction "signedhex"<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "sendrawtransaction", "params": ["signedhex"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>signrawtransactionwithkey "hexstring" ["privatekey",...] ( [{"txid":"hex","vout":n,"scriptPubKey":"hex","redeemScript":"hex","witnessScript":"hex","amount":amount},...] "sighashtype" )</summary><p>
signrawtransactionwithkey "hexstring" ["privatekey",...] ( [{"txid":"hex","vout":n,"scriptPubKey":"hex","redeemScript":"hex","witnessScript":"hex","amount":amount},...] "sighashtype" )<br>
<br>
Sign inputs for raw transaction (serialized, hex-encoded).<br>
The second argument is an array of base58-encoded private<br>
keys that will be the only keys used to sign the transaction.<br>
The third optional argument (may be null) is an array of previous transaction outputs that<br>
this transaction depends on but may not yet be in the block chain.<br>
<br>
Arguments:<br>
1. hexstring                        (string, required) The transaction hex string<br>
2. privkeys                         (json array, required) A json array of base58-encoded private keys for signing<br>
     [<br>
       "privatekey",                (string) private key in base58-encoding<br>
       ...<br>
     ]<br>
3. prevtxs                          (json array, optional) A json array of previous dependent transaction outputs<br>
     [<br>
       {                            (json object)<br>
         "txid": "hex",             (string, required) The transaction id<br>
         "vout": n,                 (numeric, required) The output number<br>
         "scriptPubKey": "hex",     (string, required) script key<br>
         "redeemScript": "hex",     (string) (required for P2SH) redeem script<br>
         "witnessScript": "hex",    (string) (required for P2WSH or P2SH-P2WSH) witness script<br>
         "amount": amount,          (numeric or string) (required for Segwit inputs) the amount spent<br>
       },<br>
       ...<br>
     ]<br>
4. sighashtype                      (string, optional, default=ALL) The signature hash type. Must be one of:<br>
                                    "ALL"<br>
                                    "NONE"<br>
                                    "SINGLE"<br>
                                    "ALL|ANYONECANPAY"<br>
                                    "NONE|ANYONECANPAY"<br>
                                    "SINGLE|ANYONECANPAY"<br>
                                    <br>
<br>
Result:<br>
{<br>
  "hex" : "value",                  (string) The hex-encoded raw transaction with signature(s)<br>
  "complete" : true|false,          (boolean) If the transaction has a complete set of signatures<br>
  "errors" : [                      (json array of objects) Script verification errors (if there are any)<br>
    {<br>
      "txid" : "hash",              (string) The hash of the referenced, previous transaction<br>
      "vout" : n,                   (numeric) The index of the output to spent and used as input<br>
      "scriptSig" : "hex",          (string) The hex-encoded signature script<br>
      "sequence" : n,               (numeric) Script sequence number<br>
      "error" : "text"              (string) Verification or signing error related to the input<br>
    }<br>
    ,...<br>
  ]<br>
}<br>
<br>
Examples:<br>
> defi-cli signrawtransactionwithkey "myhex" "[\"key1\",\"key2\"]"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "signrawtransactionwithkey", "params": ["myhex", "[\"key1\",\"key2\"]"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>testmempoolaccept ["rawtx",...] ( maxfeerate )</summary><p>
testmempoolaccept ["rawtx",...] ( maxfeerate )<br>
<br>
Returns result of mempool acceptance tests indicating if raw transaction (serialized, hex-encoded) would be accepted by mempool.<br>
<br>
This checks if the transaction violates the consensus or policy rules.<br>
<br>
See sendrawtransaction call.<br>
<br>
Arguments:<br>
1. rawtxs          (json array, required) An array of hex strings of raw transactions.<br>
                   Length must be one for now.<br>
     [<br>
       "rawtx",    (string)<br>
       ...<br>
     ]<br>
2. maxfeerate      (numeric or string, optional, default=0.10) Reject transactions whose fee rate is higher than the specified value, expressed in DFI/kB<br>
                   <br>
<br>
Result:<br>
[                   (array) The result of the mempool acceptance test for each raw transaction in the input array.<br>
                            Length is exactly one for now.<br>
 {<br>
  "txid"           (string) The transaction hash in hex<br>
  "allowed"        (boolean) If the mempool allows this tx to be inserted<br>
  "reject-reason"  (string) Rejection string (only present when 'allowed' is false)<br>
 }<br>
]<br>
<br>
Examples:<br>
<br>
Create a transaction<br>
> defi-cli createrawtransaction "[{\"txid\" : \"mytxid\",\"vout\":0}]" "{\"myaddress\":0.01}"<br>
Sign the transaction, and get back the hex<br>
> defi-cli signrawtransactionwithwallet "myhex"<br>
<br>
Test acceptance of the transaction (signed hex)<br>
> defi-cli testmempoolaccept ["signedhex"]<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "testmempoolaccept", "params": [["signedhex"]] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>utxoupdatepsbt "psbt" ( ["",{"desc":"str","range":n or [n,n]},...] )</summary><p>
utxoupdatepsbt "psbt" ( ["",{"desc":"str","range":n or [n,n]},...] )<br>
<br>
Updates all segwit inputs and outputs in a PSBT with data from output descriptors, the UTXO set or the mempool.<br>
<br>
Arguments:<br>
1. psbt                          (string, required) A base64 string of a PSBT<br>
2. descriptors                   (json array, optional) An array of either strings or objects<br>
     [<br>
       "",                       (string) An output descriptor<br>
       {                         (json object) An object with an output descriptor and extra information<br>
         "desc": "str",          (string, required) An output descriptor<br>
         "range": n or [n,n],    (numeric or array, optional, default=1000) Up to what index HD chains should be explored (either end or [begin,end])<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
  "psbt"          (string) The base64-encoded partially signed transaction with inputs updated<br>
<br>
Examples:<br>
> defi-cli utxoupdatepsbt "psbt"<br>

</p></details>

## Spv
<details><summary>spv_claimhtlc "scriptaddress" "destinationaddress" "seed" ( feerate )</summary><p>
spv_claimhtlc "scriptaddress" "destinationaddress" "seed" ( feerate )<br>
<br>
Claims all coins in HTLC address<br>
<br>
Arguments:<br>
1. scriptaddress         (string, required) HTLC address<br>
2. destinationaddress    (string, required) Destination for funds in the HTLC<br>
3. seed                  (string, required) Seed that was used to generate the hash in the HTLC<br>
4. feerate               (numeric) Feerate (satoshis) per KB (Default: 10000)<br>
<br>
Result:<br>
{<br>
  "txid"                    (string) The transaction id<br>
  "sendmessage"             (string) Error message on failure<br>
}<br>
<br>
Examples:<br>
> defi-cli spv_claimhtlc "3QwKW5GKHc1eSbbwTozsVzB1UBVyAbZQpa" "bc1q28jh8l7a9m0x5ngq0ccld2glpn4ehzwmfczf0n" "696c6c756d696e617469" 100000<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_claimhtlc", "params": ["3QwKW5GKHc1eSbbwTozsVzB1UBVyAbZQpa", "bc1q28jh8l7a9m0x5ngq0ccld2glpn4ehzwmfczf0n", "696c6c756d696e617469", 100000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_createanchor ( [{"txid":"hex","vout":n,"amount":n,"privkey":"str"},...] ) "rewardAddress" ( send feerate )</summary><p>
spv_createanchor ( [{"txid":"hex","vout":n,"amount":n,"privkey":"str"},...] ) "rewardAddress" ( send feerate )<br>
<br>
Creates (and optional submits to bitcoin blockchain) an anchor tx with latest possible (every 15th) authorized blockhash.<br>
The first argument is the specific UTXOs to spend.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. inputs                     (json array, optional) A json array of json objects<br>
     [<br>
       {                      (json object)<br>
         "txid": "hex",       (string, required) The transaction id of the bitcoin UTXO to spend<br>
         "vout": n,           (numeric, required) The output index to spend in UTXO<br>
         "amount": n,         (numeric, required) Amount of output in satoshis<br>
         "privkey": "str",    (string, required) WIF private key of bitcoin for signing this output<br>
       },<br>
       ...<br>
     ]<br>
2. rewardAddress              (string, required) User's P2PKH address (in DeFi chain) for reward<br>
3. send                       (boolean) Send it to btc network (Default = true)<br>
4. feerate                    (numeric) Feerate (satoshis) per 1000 bytes (Default = 1000)<br>
<br>
Result:<br>
"txHex"                  (string) The hex-encoded raw transaction with signature(s)<br>
"txHash"                 (string) The hex-encoded transaction hash<br>
<br>
Examples:<br>
> defi-cli spv_createanchor "[{\"txid\":\"id\",\"vout\":0,\"amount\":10000,\"privkey\":\"WIFprivkey\"}]" \"rewardAddress\" True 2000<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_createanchor", "params": ["[{\"txid\":\"id\",\"vout\":0,\"amount\":10000,\"privkey\":\"WIFprivkey\"}]" \"rewardAddress\" True 2000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_createanchortemplate "rewardAddress"</summary><p>
spv_createanchortemplate "rewardAddress"<br>
<br>
Creates an anchor tx template with latest possible (every 15th) authorized blockhash.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. rewardAddress    (string, required) User's P2PKH address (in DeFi chain) for reward<br>
<br>
Result:<br>
"txHex"                  (string) The hex-encoded raw transaction with signature(s)<br>
<br>
Examples:<br>
> defi-cli spv_createanchortemplate \"rewardAddress\"<br>

</p></details>

<details><summary>spv_createhtlc "receiverPubkey" "ownerPubkey" "timeout" ( "seed" )</summary><p>
spv_createhtlc "receiverPubkey" "ownerPubkey" "timeout" ( "seed" )<br>
<br>
Creates a Bitcoin address whose funds can be unlocked with a seed or as a refund.<br>
It returns a json object with the address and redeemScript.<br>
<br>
Arguments:<br>
1. receiverPubkey    (string, required) The public key of the possessor of the seed<br>
2. ownerPubkey       (string, required) The public key of the recipient of the refund<br>
3. timeout           (string, required) Timeout of the contract (denominated in blocks) relative to its placement in the blockchain. Minimum 9.<br>
4. seed              (string) SHA256 hash of the seed. If none provided one will be generated<br>
<br>
Result:<br>
{<br>
  "address":"address"       (string) The value of the new Bitcoin address<br>
  "redeemScript":"script"   (string) Hex-encoded redemption script<br>
  "seed":"seed"             (string) Hex-encoded seed if no seed provided<br>
  "seedhash":"seedhash"     (string) Hex-encoded seed hash if no seed provided<br>
}<br>
<br>
Examples:<br>
> defi-cli spv_createhtlc 0333ffc4d18c7b2adbd1df49f5486030b0b70449c421189c2c0f8981d0da9669af 034201385acc094d24db4b53a05fc8991b10e3467e6e20a8551c49f89e7e4d0d3c 10 254e38932fdb9fc27f82aac2a5cc6d789664832383e3cf3298f8c120812712db<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_createhtlc", "params": [0333ffc4d18c7b2adbd1df49f5486030b0b70449c421189c2c0f8981d0da9669af, 034201385acc094d24db4b53a05fc8991b10e3467e6e20a8551c49f89e7e4d0d3c, 10, 254e38932fdb9fc27f82aac2a5cc6d789664832383e3cf3298f8c120812712db] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_decodehtlcscript "redeemscript"</summary><p>
spv_decodehtlcscript "redeemscript"<br>
<br>
Decode and return value in a HTLC redeemscript<br>
<br>
Arguments:<br>
1. redeemscript    (string, required) The HTLC redeemscript<br>
<br>
Result:<br>
{<br>
  "receiverPubkey"            (string) The public key of the possessor of the seed<br>
  "ownerPubkey"               (string) The public key of the recipient of the refund<br>
  "blocks"                    (number) Locktime in number of blocks<br>
  "hash"                      (string) Hex-encoded seed hash if no seed provided<br>
}<br>
<br>
Examples:<br>
> defi-cli spv_decodehtlcscript \"redeemscript\"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_decodehtlcscript", "params": [\"redeemscript\"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_dumpprivkey "address"</summary><p>
spv_dumpprivkey "address"<br>
<br>
Reveals the private key corresponding to 'address'<br>
<br>
Arguments:<br>
1. address    (string, required) The BTC address for the private key<br>
<br>
Result:<br>
"key"                (string) The private key<br>
<br>
Examples:<br>
> defi-cli spv_dumpprivkey "myaddress"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_dumpprivkey", "params": ["myaddress"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_estimateanchorcost ( feerate )</summary><p>
spv_estimateanchorcost ( feerate )<br>
<br>
Estimates current anchor cost with default fee, one input and one change output.<br>
<br>
Arguments:<br>
1. feerate    (numeric) Feerate (satoshis) per 1000 bytes (Default = 1000)<br>
<br>
Result:<br>
"cost"                  (numeric) Estimated anchor cost (satoshis)<br>
<br>
Examples:<br>
> defi-cli spv_estimateanchorcost <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_estimateanchorcost", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_getaddresspubkey "address"</summary><p>
spv_getaddresspubkey "address"<br>
<br>
Return raw pubkey for Bitcoin address if in SPV wallet<br>
<br>
Arguments:<br>
1. address    (string, required) Bitcoin address<br>
<br>
Result:<br>
"pubkey"                 (string) Raw pubkey hex<br>
<br>
Examples:<br>
> defi-cli spv_getaddresspubkey <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_getaddresspubkey", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_getalladdresses</summary><p>
spv_getalladdresses<br>
<br>
Returns all user Bitcoin addresses.<br>
<br>
Result:<br>
"array"                  (Array of user addresses)<br>
<br>
Examples:<br>
> defi-cli spv_getalladdresses <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_getalladdresses", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_getbalance</summary><p>
spv_getbalance<br>
<br>
Returns the Bitcoin balance of the SPV wallet<br>
<br>
Result:<br>
amount                 (numeric) The total amount in BTC received in the SPV wallet.<br>
<br>
Examples:<br>
> defi-cli spv_getbalance <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_getbalance", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_getfeerate</summary><p>
spv_getfeerate<br>
<br>
Returns current fee rate in Sats per KB.<br>
<br>
Result:<br>
nnnn                  (Fee rate)<br>
<br>
Examples:<br>
> defi-cli spv_getfeerate <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_getfeerate", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_gethtlcseed "address"</summary><p>
spv_gethtlcseed "address"<br>
<br>
Returns the HTLC secret if available<br>
<br>
Arguments:<br>
1. address    (string, required) HTLC address<br>
<br>
Result:<br>
"secret"                 (string) Returns HTLC seed<br>
<br>
Examples:<br>
> defi-cli spv_gethtlcseed \"address\"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_gethtlcseed", "params": [\"address\"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_getnewaddress</summary><p>
spv_getnewaddress<br>
<br>
Creates and adds a Bitcoin address to the SPV wallet<br>
<br>
Result:<br>
"address"                  Returns a new Bitcoin address<br>
<br>
Examples:<br>
> defi-cli spv_getnewaddress <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_getnewaddress", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_getpeers</summary><p>
spv_getpeers<br>
<br>
Returns info on connected peers.<br>
<br>
Result:<br>
X {                                (Peer number)<br>
  address: xxx.xxx.xxx.xxx          (IP Address)<br>
  timestamp: nnn                    (time)<br>
  flags: nnn                        (flags)<br>
  services: nnn                     (services)<br>
}<br>
<br>
Examples:<br>
> defi-cli spv_getpeers <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_getpeers", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_getrawtransaction "txid"</summary><p>
spv_getrawtransaction "txid"<br>
<br>
Return the raw transaction data.<br>
<br>
Arguments:<br>
1. txid    (string, required) The transaction id<br>
<br>
Result:<br>
"data"      (string) The serialized, hex-encoded data for 'txid'<br>
<br>
Examples:<br>
> defi-cli spv_getrawtransaction "txid"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_getrawtransaction", "params": ["txid"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_gettxconfirmations "txhash"</summary><p>
spv_gettxconfirmations "txhash"<br>
<br>
Reports tx confirmations (if any)...<br>
<br>
Arguments:<br>
1. txhash    (string, required) Hash of tx to look for<br>
<br>
Result:<br>
count                (num) Tx confirmations. Zero if not confirmed yet (mempooled?) and -1 if not found<br>
<br>
Examples:<br>
> defi-cli spv_gettxconfirmations \"txid\"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_gettxconfirmations", "params": [\"txid\"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_listanchorauths</summary><p>
spv_listanchorauths<br>
<br>
List anchor auths (if any)<br>
<br>
Result:<br>
"array"                  Returns array of anchor auths<br>
<br>
Examples:<br>
> defi-cli spv_listanchorauths <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listanchorauths", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_listanchorrewardconfirms</summary><p>
spv_listanchorrewardconfirms<br>
<br>
List anchor reward confirms (if any)<br>
<br>
Result:<br>
"array"                  Returns array of anchor confirms<br>
<br>
Examples:<br>
> defi-cli spv_listanchorrewardconfirms <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listanchorrewardconfirms", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_listanchorrewards</summary><p>
spv_listanchorrewards<br>
<br>
List anchor rewards (if any)<br>
<br>
Result:<br>
"array"                  Returns array of anchor rewards<br>
<br>
Examples:<br>
> defi-cli spv_listanchorrewards <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listanchorrewards", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_listanchors ( minBtcHeight maxBtcHeight minConfs maxConfs startBtcHeight limit )</summary><p>
spv_listanchors ( minBtcHeight maxBtcHeight minConfs maxConfs startBtcHeight limit )<br>
<br>
List anchors (if any)<br>
<br>
Arguments:<br>
1. minBtcHeight      (numeric) min btc height, optional (default = -1)<br>
2. maxBtcHeight      (numeric) max btc height, optional (default = -1)<br>
3. minConfs          (numeric) min anchor confirmations, optional (default = -1)<br>
4. maxConfs          (numeric) max anchor confirmations, optional (default = -1)<br>
5. startBtcHeight    (numeric) max anchor confirmations, optional (default = -1)<br>
6. limit             (numeric) number of records to return (default = unlimited)<br>
<br>
Result:<br>
"array"                  Returns array of anchors<br>
<br>
Examples:<br>
> defi-cli spv_listanchors 1500000 -1 6 -1<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listanchors", "params": [-1 -1 0 0] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_listanchorspending</summary><p>
spv_listanchorspending<br>
<br>
List pending anchors (if any). Pending anchors are waiting on<br>
chain context to be fully validated, for example, anchors read<br>
from SPV while the blockchain is still syncing.<br>
Result:<br>
"array"                  Returns array of pending anchors<br>
<br>
Examples:<br>
> defi-cli spv_listanchorspending <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listanchorspending", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_listanchorsunrewarded</summary><p>
spv_listanchorsunrewarded<br>
<br>
List anchors that have yet to be paid<br>
<br>
Result:<br>
"array"                  Returns array of unrewarded anchors<br>
<br>
Examples:<br>
> defi-cli spv_listanchorsunrewarded <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listanchorsunrewarded", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_listhtlcoutputs ( "address" )</summary><p>
spv_listhtlcoutputs ( "address" )<br>
<br>
List all outputs related to HTLC addresses in the wallet<br>
<br>
Arguments:<br>
1. address    (string) HTLC address to filter results<br>
<br>
Result:<br>
[                       (JSON array of transaction details)<br>
{<br>
  "txid"              (string) The transaction id<br>
  "vout"              (numeric) Output relating to the HTLC address<br>
  "address"           (string) HTLC address<br>
  "confirms"          (numeric) Number of confirmations<br>
  { "spent"           (JSON object containing spent info)<br>
    "txid"            (string) Transaction id spending this output<br>
    "confirms"        (numeric) Number of spent confirmations<br>
  }<br>
}, ...]<br>
<br>
Examples:<br>
> defi-cli spv_listhtlcoutputs <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listhtlcoutputs", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_listreceivedbyaddress ( minconf "address_filter" )</summary><p>
spv_listreceivedbyaddress ( minconf "address_filter" )<br>
<br>
List balances by receiving address.<br>
<br>
Arguments:<br>
1. minconf           (numeric, optional, default=1) The minimum number of confirmations before payments are included.<br>
2. address_filter    (string, optional) If present, only return information on this address.<br>
<br>
Result:<br>
[<br>
  {<br>
    "address" : "receivingaddress",  (string) The receiving address<br>
    "type" : "type",                 (string) Address type, Bech32 or HTLC<br>
    "amount" : x.xxx,                  (numeric) The total amount in BTC received by the address<br>
    "confirmations" : n,               (numeric) The number of confirmations of the most recent transaction included<br>
    "txids": [<br>
       "txid",                         (string) The ids of transactions received with the address <br>
       ...<br>
    ]<br>
  }<br>
  ,...<br>
]<br>
<br>
Examples:<br>
> defi-cli spv_listreceivedbyaddress <br>
> defi-cli spv_listreceivedbyaddress 6<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listreceivedbyaddress", "params": [6] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listreceivedbyaddress", "params": [6, "1M72Sfpbz1BPpXFHz9m3CdqATR44Jvaydd"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_listtransactions</summary><p>
spv_listtransactions<br>
<br>
Returns an array of all Bitcoin transaction hashes.<br>
<br>
Result:<br>
[                         (array of strings)<br>
  "txid"                  (string) The transaction id.<br>
  ...<br>
]<br>
Examples:<br>
> defi-cli spv_listtransactions <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listtransactions", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_refundhtlc "scriptaddress" "destinationaddress" ( feerate )</summary><p>
spv_refundhtlc "scriptaddress" "destinationaddress" ( feerate )<br>
<br>
Refunds all coins in HTLC address<br>
<br>
Arguments:<br>
1. scriptaddress         (string, required) HTLC address<br>
2. destinationaddress    (string, required) Destination for funds in the HTLC<br>
3. feerate               (numeric) Feerate (satoshis) per KB (Default: 10000)<br>
<br>
Result:<br>
{<br>
  "txid"                    (string) The transaction id<br>
  "sendmessage"             (string) Error message on failure<br>
}<br>
<br>
Examples:<br>
> defi-cli spv_refundhtlc "3QwKW5GKHc1eSbbwTozsVzB1UBVyAbZQpa" "bc1q28jh8l7a9m0x5ngq0ccld2glpn4ehzwmfczf0n" 100000<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_refundhtlc", "params": ["3QwKW5GKHc1eSbbwTozsVzB1UBVyAbZQpa", "bc1q28jh8l7a9m0x5ngq0ccld2glpn4ehzwmfczf0n", 100000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_refundhtlcall "destinationaddress" ( feerate )</summary><p>
spv_refundhtlcall "destinationaddress" ( feerate )<br>
<br>
Gets all HTLC contracts stored in wallet and creates refunds transactions for all that have expired<br>
<br>
Arguments:<br>
1. destinationaddress    (string, required) Destination for funds in the HTLC<br>
2. feerate               (numeric) Feerate (satoshis) per KB (Default: 10000)<br>
<br>
Result:<br>
{<br>
  "txid"                    (string) The transaction id<br>
}<br>
<br>
Examples:<br>
> defi-cli spv_refundhtlcall 100000<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_refundhtlcall", "params": [100000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_rescan ( height )</summary><p>
spv_rescan ( height )<br>
<br>
Rescan from block height...<br>
<br>
Arguments:<br>
1. height    (numeric) Block height or ('tip' minus 'height') if negative).<br>
<br>
Result:<br>
"none"                  Returns nothing<br>
<br>
Examples:<br>
> defi-cli spv_rescan 600000<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_rescan", "params": [600000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_sendrawtx "rawtx"</summary><p>
spv_sendrawtx "rawtx"<br>
<br>
Sending raw tx to Bitcoin blockchain<br>
<br>
Arguments:<br>
1. rawtx    (string, required) The hex-encoded raw transaction with signature<br>
<br>
Result:<br>
"none"                  Returns nothing<br>
<br>
Examples:<br>
> defi-cli spv_sendrawtx "rawtx"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_sendrawtx", "params": ["rawtx"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_sendtoaddress "address" amount ( feerate )</summary><p>
spv_sendtoaddress "address" amount ( feerate )<br>
<br>
Send a Bitcoin amount to a given address.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. address    (string, required) The Bitcoin address to send to.<br>
2. amount     (numeric or string, required) The amount in BTC to send. eg 0.1<br>
3. feerate    (numeric) Feerate (satoshis) per KB (Default: 10000)<br>
<br>
Result:<br>
{<br>
  "txid"                    (string) The transaction id<br>
  "sendmessage"             (string) Send message result<br>
}<br>
<br>
Examples:<br>
> defi-cli spv_sendtoaddress "1M72Sfpbz1BPpXFHz9m3CdqATR44Jvaydd" 0.1<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_sendtoaddress", "params": ["1M72Sfpbz1BPpXFHz9m3CdqATR44Jvaydd", 0.1] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_syncstatus</summary><p>
spv_syncstatus<br>
<br>
Returns spv sync status<br>
<br>
Result:<br>
{                           (json object)<br>
   "connected"                (bool) Connection status<br>
   "current"                  (num) Last synced block<br>
   "estimated"                (num) Estimated chain height (as reported by peers)<br>
}<br>
<br>
Examples:<br>
> defi-cli spv_syncstatus <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_syncstatus", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>spv_validateaddress "address"</summary><p>
spv_validateaddress "address"<br>
<br>
Check whether the given Bitcoin address is valid.<br>
<br>
Arguments:<br>
1. address    (string, required) The Bitcoin address to validate<br>
<br>
Result:<br>
{<br>
  "isvalid" : true|false,       (boolean) If the address is valid or not.<br>
  "ismine" : true|false,        (boolean) If the address belongs to the wallet.<br>
}<br>
<br>
Examples:<br>
> defi-cli spv_validateaddress "1PSSGeFHDnKNxiEyFrD1wcEaHr9hrQDDWc"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_validateaddress", "params": ["1PSSGeFHDnKNxiEyFrD1wcEaHr9hrQDDWc"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

## Stats
<details><summary>getrpcstats "command"</summary><p>
getrpcstats "command"<br>
<br>
Get RPC stats for selected command.<br>
<br>
Arguments:<br>
1. command    (string, required) The command to get stats for.<br>
<br>
Result:<br>
 {<br>
  "name":               (string) The RPC command name.<br>
  "latency":            (json object) Min, max and average latency.<br>
  "payload":            (json object) Min, max and average payload size in bytes.<br>
  "count":              (numeric) The number of times this command as been used.<br>
  "lastUsedTime":       (numeric) Last used time as timestamp.<br>
  "history":            (json array) History of last 5 RPC calls.<br>
  [<br>
       {<br>
           "timestamp": (numeric)<br>
           "latency":   (numeric)<br>
           "payload":   (numeric)<br>
       }<br>
  ]<br>
}<br>
Examples:<br>
> defi-cli getrpcstats getblockcount<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getrpcstats", "params": ["getblockcount"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listrpcstats</summary><p>
listrpcstats<br>
<br>
List used RPC commands.<br>
<br>
Result:<br>
[<br>
 {<br>
  "name":               (string) The RPC command name.<br>
  "latency":            (json object) Min, max and average latency.<br>
  "payload":            (json object) Min, max and average payload size in bytes.<br>
  "count":              (numeric) The number of times this command as been used.<br>
  "lastUsedTime":       (numeric) Last used time as timestamp.<br>
  "history":            (json array) History of last 5 RPC calls.<br>
  [<br>
       {<br>
           "timestamp": (numeric)<br>
           "latency":   (numeric)<br>
           "payload":   (numeric)<br>
       }<br>
  ]<br>
 }<br>
]<br>
Examples:<br>
> defi-cli listrpcstats <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listrpcstats", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

## Tokens
<details><summary>burntokens {"amounts":"str","from":"str","context":"str"} ( [{"txid":"hex","vout":n},...] )</summary><p>
burntokens {"amounts":"str","from":"str","context":"str"} ( [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) a transaction burning your token (for accounts and/or UTXOs). <br>
The second optional argument (may be empty array) is an array of specific UTXOs to spend. One of UTXO's must belong to the token's owner (collateral) address<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. metadata                 (json object, required)<br>
     {<br>
       "amounts": "str",    (string, required) Amount as json string, or array. Example: '[ "amount@token" ]'<br>
       "from": "str",       (string, required) Address containing tokens to be burned.<br>
       "context": "str",    (string) Additional data necessary for specific burn type<br>
     }<br>
2. inputs                   (json array, optional) A json array of json objects. Provide it if you want to spent specific UTXOs<br>
     [<br>
       {                    (json object)<br>
         "txid": "hex",     (string, required) The transaction id<br>
         "vout": n,         (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli burntokens '{"amounts":"10@symbol","from":"address"}'<br>
> defi-cli burntokens '{"amounts":"10@symbol","from":"address","context":"consortium_member_address"}'<br>
> defi-cli burntokens '{"amounts":"10@symbol","from":"address"}' '[{"txid":"id","vout":0}]'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "burntokens", "params": ['{"amounts":"10@symbol","from":"address"}' '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>createtoken ( {"symbol":"str","name":"str","isDAT":bool,"decimal":n,"limit":n,"mintable":bool,"tradeable":bool,"collateralAddress":"str"} [{"txid":"hex","vout":n},...] )</summary><p>
createtoken ( {"symbol":"str","name":"str","isDAT":bool,"decimal":n,"limit":n,"mintable":bool,"tradeable":bool,"collateralAddress":"str"} [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) a token creation transaction with given metadata.<br>
The second optional argument (may be empty array) is an array of specific UTXOs to spend.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. metadata                           (json object)<br>
     {<br>
       "symbol": "str",               (string, required) Token's symbol (unique), no longer than 8<br>
       "name": "str",                 (string) Token's name (optional), no longer than 128<br>
       "isDAT": bool,                 (boolean) Token's 'isDAT' property (bool, optional), default is 'False'<br>
       "decimal": n,                  (numeric) Token's decimal places (optional, fixed to 8 for now, unchecked)<br>
       "limit": n,                    (numeric) Token's total supply limit (optional, zero for now, unchecked)<br>
       "mintable": bool,              (boolean) Token's 'Mintable' property (bool, optional), default is 'True'<br>
       "tradeable": bool,             (boolean) Token's 'Tradeable' property (bool, optional), default is 'True'<br>
       "collateralAddress": "str",    (string, required) Any valid destination for keeping collateral amount - used as token's owner auth<br>
     }<br>
2. inputs                             (json array, optional) A json array of json objects<br>
     [<br>
       {                              (json object)<br>
         "txid": "hex",               (string, required) The transaction id<br>
         "vout": n,                   (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli createtoken '{"symbol":"MyToken","collateralAddress":"address"}'<br>
> defi-cli createtoken '{"symbol":"MyToken","collateralAddress":"address"}' '[{"txid":"id","vout":0}]'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createtoken", "params": ['{"symbol":"MyToken","collateralAddress":"address"}' '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>decodecustomtx "hexstring" ( iswitness )</summary><p>
decodecustomtx "hexstring" ( iswitness )<br>
<br>
Get detailed information about a DeFiChain custom transaction.<br>
<br>
Arguments:<br>
1. hexstring    (string, required) The transaction hex string<br>
2. iswitness    (boolean, optional, default=depends on heuristic tests) Whether the transaction hex is a serialized witness transaction.<br>
                If iswitness is not present, heuristic tests will be used in decoding.<br>
                If true, only witness deserialization will be tried.<br>
                If false, only non-witness deserialization will be tried.<br>
                This boolean should reflect whether the transaction has inputs<br>
                (e.g. fully valid, or on-chain transactions), if known by the caller.<br>
<br>
Result:<br>
{<br>
  "txid":               (string) The transaction id.<br>
  "type":               (string) The transaction type.<br>
  "valid"               (bool) Whether the transaction was valid.<br>
  "results"             (json object) Set of results related to the transaction type<br>
}<br>
<br>
Examples:<br>
> defi-cli decodecustomtx "hexstring"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "decodecustomtx", "params": ["hexstring"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getcustomtx "txid" ( "blockhash" )</summary><p>
getcustomtx "txid" ( "blockhash" )<br>
<br>
Get detailed information about a DeFiChain custom transaction. Will search wallet transactions and mempool transaction,<br>
if a blockhash is provided and that block is available then details for that transaction can be returned. -txindex<br>
can be enabled to return details for any transaction.<br>
Arguments:<br>
1. txid         (string, required) The transaction id<br>
2. blockhash    (string, optional) The block in which to look for the transaction<br>
<br>
Result:<br>
{<br>
  "type":               (string) The transaction type.<br>
  "valid"               (bool) Whether the transaction was valid.<br>
  "results"             (json object) Set of results related to the transaction type<br>
  "block height"        (string) The block height containing the transaction.<br>
  "blockhash"           (string) The block hash containing the transaction.<br>
  "confirmations": n,   (numeric) The number of confirmations for the transaction.}<br>
<br>
Examples:<br>
> defi-cli getcustomtx "66ea2ac081e2917f075e2cca7c1c0baa12fb85c469f34561185fa64d7d2f9305"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getcustomtx", "params": ["66ea2ac081e2917f075e2cca7c1c0baa12fb85c469f34561185fa64d7d2f9305"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>gettoken "key"</summary><p>
gettoken "key"<br>
<br>
Returns information about token.<br>
<br>
Arguments:<br>
1. key    (string, required) One of the keys may be specified (id/symbol/creationTx)<br>
<br>
Result:<br>
{id:{...}}     (array) Json object with token information<br>
<br>
Examples:<br>
> defi-cli gettoken GOLD<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "gettoken", "params": [GOLD] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listtokens ( {"start":n,"including_start":bool,"limit":n} verbose )</summary><p>
listtokens ( {"start":n,"including_start":bool,"limit":n} verbose )<br>
<br>
Returns information about tokens.<br>
<br>
Arguments:<br>
1. pagination                      (json object)<br>
     {<br>
       "start": n,                 (numeric) Optional first key to iterate from, in lexicographical order.Typically it's set to last ID from previous request.<br>
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default<br>
       "limit": n,                 (numeric) Maximum number of tokens to return, 100 by default<br>
     }<br>
2. verbose                         (boolean) Flag for verbose list (default = true), otherwise only ids, symbols and names are listed<br>
<br>
Result:<br>
{id:{...},...}     (array) Json object with tokens information<br>
<br>
Examples:<br>
> defi-cli listtokens '{"start":128}' false<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listtokens", "params": ['{"start":128}' false] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>minttokens "amounts" ( [{"txid":"hex","vout":n},...] )</summary><p>
minttokens "amounts" ( [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) a transaction minting your token (for accounts and/or UTXOs). <br>
The second optional argument (may be empty array) is an array of specific UTXOs to spend. One of UTXO's must belong to the token's owner (collateral) address<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. amounts                 (string, required) Amount as json string, or array. Example: '[ "amount@token" ]'<br>
2. inputs                  (json array, optional) A json array of json objects. Provide it if you want to spent specific UTXOs<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli minttokens 10@symbol<br>
> defi-cli minttokens 10@symbol '[{"txid":"id","vout":0}]'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "minttokens", "params": [10@symbol '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>updatetoken "token" ( {"symbol":"str","name":"str","isDAT":bool,"mintable":bool,"tradeable":bool,"finalize":bool} [{"txid":"hex","vout":n},...] )</summary><p>
updatetoken "token" ( {"symbol":"str","name":"str","isDAT":bool,"mintable":bool,"tradeable":bool,"finalize":bool} [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) a transaction of token promotion to isDAT or demotion from isDAT. Collateral will be unlocked.<br>
The second optional argument (may be empty array) is an array of specific UTXOs to spend. One of UTXO's must belong to the token's owner (collateral) address<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. token                     (string, required) The tokens's symbol, id or creation tx<br>
2. metadata                  (json object)<br>
     {<br>
       "symbol": "str",      (string) New token's symbol, no longer than 8<br>
       "name": "str",        (string) New token's name (optional), no longer than 128<br>
       "isDAT": bool,        (boolean) Token's 'isDAT' property (bool, optional), default is 'False'<br>
       "mintable": bool,     (boolean) Token's 'Mintable' property (bool, optional)<br>
       "tradeable": bool,    (boolean) Token's 'Tradeable' property (bool, optional)<br>
       "finalize": bool,     (boolean) Lock token properties forever (bool, optional)<br>
     }<br>
3. inputs                    (json array, optional) A json array of json objects. Provide it if you want to spent specific UTXOs<br>
     [<br>
       {                     (json object)<br>
         "txid": "hex",      (string, required) The transaction id<br>
         "vout": n,          (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli updatetoken token '{"isDAT":true}' '[{"txid":"id","vout":0}]'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "updatetoken", "params": [token '{"isDAT":true}' '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

## Util
<details><summary>createmultisig nrequired ["key",...] ( "address_type" )</summary><p>
createmultisig nrequired ["key",...] ( "address_type" )<br>
<br>
Creates a multi-signature address with n signature of m keys required.<br>
It returns a json object with the address and redeemScript.<br>
<br>
Arguments:<br>
1. nrequired       (numeric, required) The number of required signatures out of the n keys.<br>
2. keys            (json array, required) A json array of hex-encoded public keys.<br>
     [<br>
       "key",      (string) The hex-encoded public key<br>
       ...<br>
     ]<br>
3. address_type    (string, optional, default=legacy) The address type to use. Options are "legacy", "p2sh-segwit", and "bech32".<br>
<br>
Result:<br>
{<br>
  "address":"multisigaddress",  (string) The value of the new multisig address.<br>
  "redeemScript":"script"       (string) The string value of the hex-encoded redemption script.<br>
}<br>
<br>
Examples:<br>
<br>
Create a multisig address from 2 public keys<br>
> defi-cli createmultisig 2 "[\"03789ed0bb717d88f7d321a368d905e7430207ebbd82bd342cf11ae157a7ace5fd\",\"03dbc6764b8884a92e871274b87583e6d5c2a58819473e17e107ef3f6aa5a61626\"]"<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createmultisig", "params": [2, "[\"03789ed0bb717d88f7d321a368d905e7430207ebbd82bd342cf11ae157a7ace5fd\",\"03dbc6764b8884a92e871274b87583e6d5c2a58819473e17e107ef3f6aa5a61626\"]"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>deriveaddresses "descriptor" ( range )</summary><p>
deriveaddresses "descriptor" ( range )<br>
<br>
Derives one or more addresses corresponding to an output descriptor.<br>
Examples of output descriptors are:<br>
    pkh(<pubkey>)                        P2PKH outputs for the given pubkey<br>
    wpkh(<pubkey>)                       Native segwit P2PKH outputs for the given pubkey<br>
    sh(multi(<n>,<pubkey>,<pubkey>,...)) P2SH-multisig outputs for the given threshold and pubkeys<br>
    raw(<hex script>)                    Outputs whose scriptPubKey equals the specified hex scripts<br>
<br>
In the above, <pubkey> either refers to a fixed public key in hexadecimal notation, or to an xpub/xprv optionally followed by one<br>
or more path elements separated by "/", where "h" represents a hardened child key.<br>
For more information on output descriptors, see the documentation in the doc/descriptors.md file.<br>
<br>
Arguments:<br>
1. descriptor    (string, required) The descriptor.<br>
2. range         (numeric or array, optional) If a ranged descriptor is used, this specifies the end or the range (in [begin,end] notation) to derive.<br>
<br>
Result:<br>
[ address ] (array) the derived addresses<br>
<br>
Examples:<br>
First three native segwit receive addresses<br>
> defi-cli deriveaddresses "wpkh([d34db33f/84h/0h/0h]xpub6DJ2dNUysrn5Vt36jH2KLBT2i1auw1tTSSomg8PhqNiUtx8QX2SvC9nrHu81fT41fvDUnhMjEzQgXnQjKEu3oaqMSzhSrHMxyyoEAmUHQbY/0/*)#cjjspncu" "[0,2]"<br>

</p></details>

<details><summary>estimatesmartfee conf_target ( "estimate_mode" )</summary><p>
estimatesmartfee conf_target ( "estimate_mode" )<br>
<br>
Estimates the approximate fee per kilobyte needed for a transaction to begin<br>
confirmation within conf_target blocks if possible and return the number of blocks<br>
for which the estimate is valid. Uses virtual transaction size as defined<br>
in BIP 141 (witness data is discounted).<br>
<br>
Arguments:<br>
1. conf_target      (numeric, required) Confirmation target in blocks (1 - 1008)<br>
2. estimate_mode    (string, optional, default=CONSERVATIVE) The fee estimate mode.<br>
                    Whether to return a more conservative estimate which also satisfies<br>
                    a longer history. A conservative estimate potentially returns a<br>
                    higher feerate and is more likely to be sufficient for the desired<br>
                    target, but is not as responsive to short term drops in the<br>
                    prevailing fee market.  Must be one of:<br>
                    "UNSET"<br>
                    "ECONOMICAL"<br>
                    "CONSERVATIVE"<br>
<br>
Result:<br>
{<br>
  "feerate" : x.x,     (numeric, optional) estimate fee rate in DFI/kB<br>
  "errors": [ str... ] (json array of strings, optional) Errors encountered during processing<br>
  "blocks" : n         (numeric) block number where estimate was found<br>
}<br>
<br>
The request target will be clamped between 2 and the highest target<br>
fee estimation is able to return based on how long it has been running.<br>
An error is returned if not enough transactions and blocks<br>
have been observed to make an estimate for any number of blocks.<br>
<br>
Examples:<br>
> defi-cli estimatesmartfee 6<br>

</p></details>

<details><summary>getdescriptorinfo "descriptor"</summary><p>
getdescriptorinfo "descriptor"<br>
<br>
Analyses a descriptor.<br>
<br>
Arguments:<br>
1. descriptor    (string, required) The descriptor.<br>
<br>
Result:<br>
{<br>
  "descriptor" : "desc",         (string) The descriptor in canonical form, without private keys<br>
  "checksum" : "chksum",         (string) The checksum for the input descriptor<br>
  "isrange" : true|false,        (boolean) Whether the descriptor is ranged<br>
  "issolvable" : true|false,     (boolean) Whether the descriptor is solvable<br>
  "hasprivatekeys" : true|false, (boolean) Whether the input descriptor contained at least one private key<br>
}<br>
<br>
Examples:<br>
Analyse a descriptor<br>
> defi-cli getdescriptorinfo "wpkh([d34db33f/84h/0h/0h]0279be667ef9dcbbac55a06295Ce870b07029Bfcdb2dce28d959f2815b16f81798)"<br>

</p></details>

<details><summary>signmessagewithprivkey "privkey" "message"</summary><p>
signmessagewithprivkey "privkey" "message"<br>
<br>
Sign a message with the private key of an address<br>
<br>
Arguments:<br>
1. privkey    (string, required) The private key to sign the message with.<br>
2. message    (string, required) The message to create a signature of.<br>
<br>
Result:<br>
"signature"          (string) The signature of the message encoded in base 64<br>
<br>
Examples:<br>
<br>
Create the signature<br>
> defi-cli signmessagewithprivkey "privkey" "my message"<br>
<br>
Verify the signature<br>
> defi-cli verifymessage "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX" "signature" "my message"<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "signmessagewithprivkey", "params": ["privkey", "my message"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>validateaddress "address"</summary><p>
validateaddress "address"<br>
<br>
Return information about the given defi address.<br>
<br>
Arguments:<br>
1. address    (string, required) The defi address to validate<br>
<br>
Result:<br>
{<br>
  "isvalid" : true|false,       (boolean) If the address is valid or not. If not, this is the only property returned.<br>
  "address" : "address",        (string) The defi address validated<br>
  "scriptPubKey" : "hex",       (string) The hex-encoded scriptPubKey generated by the address<br>
  "isscript" : true|false,      (boolean) If the key is a script<br>
  "iswitness" : true|false,     (boolean) If the address is a witness address<br>
  "witness_version" : version   (numeric, optional) The version number of the witness program<br>
  "witness_program" : "hex"     (string, optional) The hex value of the witness program<br>
}<br>
<br>
Examples:<br>
> defi-cli validateaddress "1PSSGeFHDnKNxiEyFrD1wcEaHr9hrQDDWc"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "validateaddress", "params": ["1PSSGeFHDnKNxiEyFrD1wcEaHr9hrQDDWc"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>verifymessage "address" "signature" "message"</summary><p>
verifymessage "address" "signature" "message"<br>
<br>
Verify a signed message<br>
<br>
Arguments:<br>
1. address      (string, required) The defi address to use for the signature.<br>
2. signature    (string, required) The signature provided by the signer in base 64 encoding (see signmessage).<br>
3. message      (string, required) The message that was signed.<br>
<br>
Result:<br>
true|false   (boolean) If the signature is verified or not.<br>
<br>
Examples:<br>
<br>
Unlock the wallet for 30 seconds<br>
> defi-cli walletpassphrase "mypassphrase" 30<br>
<br>
Create the signature<br>
> defi-cli signmessage "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX" "my message"<br>
<br>
Verify the signature<br>
> defi-cli verifymessage "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX" "signature" "my message"<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "verifymessage", "params": ["1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX", "signature", "my message"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

## Vault
<details><summary>closevault "vaultId" "to" ( [{"txid":"hex","vout":n},...] )</summary><p>
closevault "vaultId" "to" ( [{"txid":"hex","vout":n},...] )<br>
Close vault transaction.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. vaultId                 (string, required) Vault to be closed<br>
2. to                      (string, required) Any valid address to receive collaterals (if any) and half fee back<br>
3. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli closevault 84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2 mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "closevault", "params": ["84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2", "mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>createvault "ownerAddress" ( "loanSchemeId" [{"txid":"hex","vout":n},...] )</summary><p>
createvault "ownerAddress" ( "loanSchemeId" [{"txid":"hex","vout":n},...] )<br>
Creates a vault transaction.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. ownerAddress            (string, required) Any valid address<br>
2. loanSchemeId            (string) Unique identifier of the loan scheme (8 chars max). If empty, the default loan scheme will be selected (Optional)<br>
3. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli createvault 2MzfSNCkjgCbNLen14CYrVtwGomfDA5AGYv<br>
> defi-cli createvault 2MzfSNCkjgCbNLen14CYrVtwGomfDA5AGYv ""<br>
> defi-cli createvault 2MzfSNCkjgCbNLen14CYrVtwGomfDA5AGYv LOAN0001<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createvault", "params": ["2MzfSNCkjgCbNLen14CYrVtwGomfDA5AGYv"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createvault", "params": ["2MzfSNCkjgCbNLen14CYrVtwGomfDA5AGYv", ""] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createvault", "params": ["2MzfSNCkjgCbNLen14CYrVtwGomfDA5AGYv", "LOAN0001"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>deposittovault "vaultId" "from" "amount" ( [{"txid":"hex","vout":n},...] )</summary><p>
deposittovault "vaultId" "from" "amount" ( [{"txid":"hex","vout":n},...] )<br>
Deposit collateral token amount to vault.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. vaultId                 (string, required) Vault id<br>
2. from                    (string, required) Address containing collateral<br>
3. amount                  (string, required) Amount of collateral in amount@symbol format<br>
4. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli deposittovault 84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2i mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF 1@DFI<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "deposittovault", "params": ["84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2i", "mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF", "1@DFI"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>estimatecollateral "loanAmounts" targetRatio ( {"split":n} )</summary><p>
estimatecollateral "loanAmounts" targetRatio ( {"split":n} )<br>
Returns amount of collateral tokens needed to take an amount of loan tokens for a target collateral ratio.<br>
<br>
Arguments:<br>
1. loanAmounts        (string, required) Amount as json string, or array. Example: '[ "amount@token" ]'<br>
2. targetRatio        (numeric, required) Target collateral ratio.<br>
3. tokens             (json object) Object with collateral token as key and their percent split as value. (defaults to { DFI: 1 }<br>
     {<br>
       "split": n,    (numeric, required) The percent split<br>
     }<br>
<br>
Result:<br>
"json"                  (Array) Array of <amount@token> strings<br>
<br>
Examples:<br>
> defi-cli estimatecollateral 23.55311144@MSFT 150 '{"DFI": 0.8, "BTC":0.2}'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "estimatecollateral", "params": ["23.55311144@MSFT" 150 {"DFI": 0.8, "BTC":0.2}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>estimateloan "vaultId" {"split":n} ( targetRatio )</summary><p>
estimateloan "vaultId" {"split":n} ( targetRatio )<br>
Returns amount of loan tokens a vault can take depending on a target collateral ratio.<br>
<br>
Arguments:<br>
1. vaultId            (string, required) vault hex id<br>
2. tokens             (json object, required) Object with loans token as key and their percent split as value<br>
     {<br>
       "split": n,    (numeric, required) The percent split<br>
     }<br>
3. targetRatio        (numeric) Target collateral ratio. (defaults to vault's loan scheme ratio)<br>
<br>
Result:<br>
"json"                  (Array) Array of <amount@token> strings<br>
<br>
Examples:<br>
> defi-cli estimateloan 5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf '{"TSLA":0.5, "FB": 0.4, "GOOGL":0.1}' 150<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "estimateloan", "params": ["5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf", {"TSLA":0.5, "FB": 0.4, "GOOGL":0.1}, 150] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>estimatevault "collateralAmounts" "loanAmounts"</summary><p>
estimatevault "collateralAmounts" "loanAmounts"<br>
Returns estimated vault for given collateral and loan amounts.<br>
<br>
Arguments:<br>
1. collateralAmounts    (string, required) Collateral amounts as json string, or array. Example: '[ "amount@token" ]'<br>
2. loanAmounts          (string, required) Loan amounts as json string, or array. Example: '[ "amount@token" ]'<br>
<br>
Result:<br>
{<br>
  "collateralValue" : n.nnnnnnnn,        (amount) The total collateral value in USD<br>
  "loanValue" : n.nnnnnnnn,              (amount) The total loan value in USD<br>
  "informativeRatio" : n.nnnnnnnn,       (amount) Informative ratio with 8 digit precision<br>
  "collateralRatio" : n,                 (uint) Ratio as unsigned int<br>
}<br>
<br>
Examples:<br>
> defi-cli estimatevault '["1000.00000000@DFI"]' '["0.65999990@GOOGL"]'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "estimatevault", "params": [["1000.00000000@DFI"], ["0.65999990@GOOGL"]] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getvault "vaultId" ( verbose )</summary><p>
getvault "vaultId" ( verbose )<br>
Returns information about vault.<br>
<br>
Arguments:<br>
1. vaultId    (string, required) vault hex id<br>
2. verbose    (boolean) Verbose vault information (default = false)<br>
<br>
Result:<br>
"json"                  (string) vault data in json form<br>
<br>
Examples:<br>
> defi-cli getvault 5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getvault", "params": ["5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listauctionhistory ( "owner|vaultId" {"maxBlockHeight":n,"vaultId":"hex","index":n,"limit":n} )</summary><p>
listauctionhistory ( "owner|vaultId" {"maxBlockHeight":n,"vaultId":"hex","index":n,"limit":n} )<br>
<br>
Returns information about auction history.<br>
<br>
Arguments:<br>
1. owner|vaultId               (string) Single account ID (CScript or address) or vaultId or reserved words: "mine" - to list history for all owned accounts or "all" to list whole DB (default = "mine").<br>
2. pagination                  (json object)<br>
     {<br>
       "maxBlockHeight": n,    (numeric) Optional height to iterate from (downto genesis block)<br>
       "vaultId": "hex",       (string) Vault id<br>
       "index": n,             (numeric) Batch index<br>
       "limit": n,             (numeric) Maximum number of orders to return, 100 by default<br>
     }<br>
<br>
Result:<br>
[{},{}...]     (array) Objects with auction history information<br>
<br>
Examples:<br>
> defi-cli listauctionhistory all '{"height":160}'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listauctionhistory", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listauctions ( {"start":obj,"including_start":bool,"limit":n} )</summary><p>
listauctions ( {"start":obj,"including_start":bool,"limit":n} )<br>
List all available auctions.<br>
<br>
Arguments:<br>
1. pagination                      (json object)<br>
     {<br>
       "start": {                  (json object)<br>
         "vaultId": "hex",         (string) Vault id<br>
         "height": n,              (numeric) Height to iterate from<br>
       },<br>
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default<br>
       "limit": n,                 (numeric) Maximum number of orders to return, 100 by default<br>
     }<br>
<br>
Result:<br>
[                         (json array of objects)<br>
{...}                 (object) Json object with auction information<br>
]<br>
<br>
Examples:<br>
> defi-cli listauctions <br>
> defi-cli listauctions '{"start": {"vaultId":"eeea650e5de30b77d17e3907204d200dfa4996e5c4d48b000ae8e70078fe7542", "height": 1000}, "including_start": true, "limit":100}'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listauctions", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listauctions", "params": [{"start": {"vaultId":"eeea650e5de30b77d17e3907204d200dfa4996e5c4d48b000ae8e70078fe7542", "height": 1000}, "including_start": true, "limit":100}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listvaulthistory "vaultId" ( {"maxBlockHeight":n,"depth":n,"token":"str","txtype":"str","limit":n} )</summary><p>
listvaulthistory "vaultId" ( {"maxBlockHeight":n,"depth":n,"token":"str","txtype":"str","limit":n} )<br>
<br>
Returns the history of the specified vault.<br>
<br>
Arguments:<br>
1. vaultId                     (string, required) Vault to get history for<br>
2. options                     (json object)<br>
     {<br>
       "maxBlockHeight": n,    (numeric) Optional height to iterate from (down to genesis block), (default = chaintip).<br>
       "depth": n,             (numeric) Maximum depth, from the genesis block is the default<br>
       "token": "str",         (string) Filter by token<br>
       "txtype": "str",        (string) Filter by transaction type, supported letter from {CustomTxType}<br>
       "limit": n,             (numeric) Maximum number of records to return, 100 by default<br>
     }<br>
<br>
Result:<br>
[{},{}...]     (array) Objects with vault history information<br>
<br>
Examples:<br>
> defi-cli listvaulthistory 84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2 '{"maxBlockHeight":160,"depth":10}'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listvaulthistory", "params": [84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2, '{"maxBlockHeight":160,"depth":10}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listvaults ( {"ownerAddress":"str","loanSchemeId":"str","state":"str","verbose":bool} {"start":"hex","including_start":bool,"limit":n} )</summary><p>
listvaults ( {"ownerAddress":"str","loanSchemeId":"str","state":"str","verbose":bool} {"start":"hex","including_start":bool,"limit":n} )<br>
List all available vaults.<br>
<br>
Arguments:<br>
1. options                         (json object)<br>
     {<br>
       "ownerAddress": "str",      (string) Address of the vault owner.<br>
       "loanSchemeId": "str",      (string) Vault's loan scheme id<br>
       "state": "str",             (string) Wether the vault is under a given state. (default = 'unknown')<br>
       "verbose": bool,            (boolean) Flag for verbose list (default = false), otherwise only ids, ownerAddress, loanSchemeIds and state are listed<br>
     }<br>
2. pagination                      (json object)<br>
     {<br>
       "start": "hex",             (string) Optional first key to iterate from, in lexicographical order. Typically it's set to last ID from previous request.<br>
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default<br>
       "limit": n,                 (numeric) Maximum number of orders to return, 100 by default<br>
     }<br>
<br>
Result:<br>
[                         (json array of objects)<br>
{...}                 (object) Json object with vault information<br>
]<br>
<br>
Examples:<br>
> defi-cli listvaults <br>
> defi-cli listvaults '{"loanSchemeId": "LOAN1502"}'<br>
> defi-cli listvaults '{"loanSchemeId": "LOAN1502"}' '{"start":"3ef9fd5bd1d0ce94751e6286710051361e8ef8fac43cca9cb22397bf0d17e013", "including_start": true, "limit":100}'<br>
> defi-cli listvaults {} '{"start":"3ef9fd5bd1d0ce94751e6286710051361e8ef8fac43cca9cb22397bf0d17e013", "including_start": true, "limit":100}'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listvaults", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listvaults", "params": [{"loanSchemeId": "LOAN1502"}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listvaults", "params": [{"loanSchemeId": "LOAN1502"}, {"start":"3ef9fd5bd1d0ce94751e6286710051361e8ef8fac43cca9cb22397bf0d17e013", "including_start": true, "limit":100}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listvaults", "params": [{}, {"start":"3ef9fd5bd1d0ce94751e6286710051361e8ef8fac43cca9cb22397bf0d17e013", "including_start": true, "limit":100}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>paybackwithcollateral "vaultId"</summary><p>
paybackwithcollateral "vaultId"<br>
Payback vault's loans with vault's collaterals.<br>
<br>
Arguments:<br>
1. vaultId    (string, required) vault hex id<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli paybackwithcollateral 5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "paybackwithcollateral", "params": [5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>placeauctionbid "vaultId" index "from" "amount" ( [{"txid":"hex","vout":n},...] )</summary><p>
placeauctionbid "vaultId" index "from" "amount" ( [{"txid":"hex","vout":n},...] )<br>
Bid to vault in auction.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. vaultId                 (string, required) Vault id<br>
2. index                   (numeric, required) Auction index<br>
3. from                    (string, required) Address to get tokens. If "from" value is: "*" (star), it's means auto-selection accounts from wallet.<br>
4. amount                  (string, required) Amount of amount@symbol format<br>
5. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli placeauctionbid 84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2 0 mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF 100@TSLA<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "placeauctionbid", "params": ["84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2", 0, "mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF", "1@DTSLA"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>updatevault "vaultId" {"ownerAddress":"hex","loanSchemeId":"str"} ( [{"txid":"hex","vout":n},...] )</summary><p>
updatevault "vaultId" {"ownerAddress":"hex","loanSchemeId":"str"} ( [{"txid":"hex","vout":n},...] )<br>
<br>
Creates (and submits to local node and network) an `update vault transaction`, <br>
and saves vault updates to database.<br>
The last optional argument (may be empty array) is an array of specific UTXOs to spend.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. vaultId                       (string, required) Vault id<br>
2. parameters                    (json object, required)<br>
     {<br>
       "ownerAddress": "hex",    (string) Vault's owner address<br>
       "loanSchemeId": "str",    (string) Vault's loan scheme id<br>
     }<br>
3. inputs                        (json array, optional) A json array of json objects<br>
     [<br>
       {                         (json object)<br>
         "txid": "hex",          (string, required) The transaction id<br>
         "vout": n,              (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli updatevault 84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2 '{"ownerAddress": "mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF", "loanSchemeId": "LOANSCHEME001"}'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "updatevault", "params": ["84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2", {"ownerAddress": "mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF", "loanSchemeId": "LOANSCHEME001"}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>withdrawfromvault "vaultId" "to" "amount" ( [{"txid":"hex","vout":n},...] )</summary><p>
withdrawfromvault "vaultId" "to" "amount" ( [{"txid":"hex","vout":n},...] )<br>
Withdraw collateral token amount from vault.<br>
<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. vaultId                 (string, required) Vault id<br>
2. to                      (string, required) Destination address for withdraw of collateral<br>
3. amount                  (string, required) Amount of collateral in amount@symbol format<br>
4. inputs                  (json array, optional) A json array of json objects<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli withdrawfromvault 84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2i mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF 1@DFI<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "withdrawfromvault", "params": ["84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2i", "mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF", "1@DFI"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

## Wallet
<details><summary>abandontransaction "txid"</summary><p>
abandontransaction "txid"<br>
<br>
Mark in-wallet transaction <txid> as abandoned<br>
This will mark this transaction and all its in-wallet descendants as abandoned which will allow<br>
for their inputs to be respent.  It can be used to replace "stuck" or evicted transactions.<br>
It only works on transactions which are not included in a block and are not currently in the mempool.<br>
It has no effect on transactions which are already abandoned.<br>
<br>
Arguments:<br>
1. txid    (string, required) The transaction id<br>
<br>
Examples:<br>
> defi-cli abandontransaction "1075db55d416d3ca199f55b6084e2115b9345e16c5cf302fc80e9d5fbf5d48d"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "abandontransaction", "params": ["1075db55d416d3ca199f55b6084e2115b9345e16c5cf302fc80e9d5fbf5d48d"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>abortrescan</summary><p>
abortrescan<br>
<br>
Stops current wallet rescan triggered by an RPC call, e.g. by an importprivkey call.<br>
Note: Use "getwalletinfo" to query the scanning progress.<br>
<br>
Examples:<br>
<br>
Import a private key<br>
> defi-cli importprivkey "mykey"<br>
<br>
Abort the running wallet rescan<br>
> defi-cli abortrescan <br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "abortrescan", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>addmultisigaddress nrequired ["key",...] ( "label" "address_type" )</summary><p>
addmultisigaddress nrequired ["key",...] ( "label" "address_type" )<br>
<br>
Add a nrequired-to-sign multisignature address to the wallet. Requires a new wallet backup.<br>
Each key is a Defi address or hex-encoded public key.<br>
This functionality is only intended for use with non-watchonly addresses.<br>
See `importaddress` for watchonly p2sh address support.<br>
If 'label' is specified, assign address to that label.<br>
<br>
Arguments:<br>
1. nrequired       (numeric, required) The number of required signatures out of the n keys or addresses.<br>
2. keys            (json array, required) A json array of defi addresses or hex-encoded public keys<br>
     [<br>
       "key",      (string) defi address or hex-encoded public key<br>
       ...<br>
     ]<br>
3. label           (string, optional) A label to assign the addresses to.<br>
4. address_type    (string, optional, default=set by -addresstype) The address type to use. Options are "legacy", "p2sh-segwit", and "bech32".<br>
<br>
Result:<br>
{<br>
  "address":"multisigaddress",    (string) The value of the new multisig address.<br>
  "redeemScript":"script"         (string) The string value of the hex-encoded redemption script.<br>
}<br>
<br>
Examples:<br>
<br>
Add a multisig address from 2 addresses<br>
> defi-cli addmultisigaddress 2 "[\"16sSauSf5pF2UkUwvKGq4qjNRzBZYqgEL5\",\"171sgjn4YtPu27adkKGrdDwzRTxnRkBfKV\"]"<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "addmultisigaddress", "params": [2, "[\"16sSauSf5pF2UkUwvKGq4qjNRzBZYqgEL5\",\"171sgjn4YtPu27adkKGrdDwzRTxnRkBfKV\"]"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>backupwallet "destination"</summary><p>
backupwallet "destination"<br>
<br>
Safely copies current wallet file to destination, which can be a directory or a path with filename.<br>
<br>
Arguments:<br>
1. destination    (string, required) The destination directory or file<br>
<br>
Examples:<br>
> defi-cli backupwallet "backup.dat"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "backupwallet", "params": ["backup.dat"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>bumpfee "txid" ( options )</summary><p>
bumpfee "txid" ( options )<br>
<br>
Bumps the fee of an opt-in-RBF transaction T, replacing it with a new transaction B.<br>
An opt-in RBF transaction with the given txid must be in the wallet.<br>
The command will pay the additional fee by reducing change outputs or adding inputs when necessary. It may add a new change output if one does not already exist.<br>
If `totalFee` (DEPRECATED) is given, adding inputs is not supported, so there must be a single change output that is big enough or it will fail.<br>
All inputs in the original transaction will be included in the replacement transaction.<br>
The command will fail if the wallet or mempool contains a transaction that spends one of T's outputs.<br>
By default, the new fee will be calculated automatically using estimatesmartfee.<br>
The user can specify a confirmation target for estimatesmartfee.<br>
Alternatively, the user can specify totalFee (DEPRECATED), or use RPC settxfee to set a higher fee rate.<br>
At a minimum, the new fee rate must be high enough to pay an additional new relay fee (incrementalfee<br>
returned by getnetworkinfo) to enter the node's mempool.<br>
<br>
Arguments:<br>
1. txid                           (string, required) The txid to be bumped<br>
2. options                        (json object, optional)<br>
     {<br>
       "confTarget": n,           (numeric, optional, default=wallet default) Confirmation target (in blocks)<br>
       "totalFee": n,             (numeric, optional, default=fallback to 'confTarget') Total fee (NOT feerate) to pay, in satoshis. (DEPRECATED)<br>
                                  In rare cases, the actual fee paid might be slightly higher than the specified<br>
                                  totalFee if the tx change output has to be removed because it is too close to<br>
                                  the dust threshold.<br>
       "replaceable": bool,       (boolean, optional, default=true) Whether the new transaction should still be<br>
                                  marked bip-125 replaceable. If true, the sequence numbers in the transaction will<br>
                                  be left unchanged from the original. If false, any input sequence numbers in the<br>
                                  original transaction that were less than 0xfffffffe will be increased to 0xfffffffe<br>
                                  so the new transaction will not be explicitly bip-125 replaceable (though it may<br>
                                  still be replaceable in practice, for example if it has unconfirmed ancestors which<br>
                                  are replaceable).<br>
       "estimate_mode": "str",    (string, optional, default=UNSET) The fee estimate mode, must be one of:<br>
                                  "UNSET"<br>
                                  "ECONOMICAL"<br>
                                  "CONSERVATIVE"<br>
     }<br>
<br>
Result:<br>
{<br>
  "txid":    "value",   (string)  The id of the new transaction<br>
  "origfee":  n,         (numeric) Fee of the replaced transaction<br>
  "fee":      n,         (numeric) Fee of the new transaction<br>
  "errors":  [ str... ] (json array of strings) Errors encountered during processing (may be empty)<br>
}<br>
<br>
Examples:<br>
<br>
Bump the fee, get the new transaction's txid<br>
> defi-cli bumpfee <txid><br>

</p></details>

<details><summary>createwallet "wallet_name" ( disable_private_keys blank "passphrase" avoid_reuse )</summary><p>
createwallet "wallet_name" ( disable_private_keys blank "passphrase" avoid_reuse )<br>
<br>
Creates and loads a new wallet.<br>
<br>
Arguments:<br>
1. wallet_name             (string, required) The name for the new wallet. If this is a path, the wallet will be created at the path location.<br>
2. disable_private_keys    (boolean, optional, default=false) Disable the possibility of private keys (only watchonlys are possible in this mode).<br>
3. blank                   (boolean, optional, default=false) Create a blank wallet. A blank wallet has no keys or HD seed. One can be set using sethdseed.<br>
4. passphrase              (string) Encrypt the wallet with this passphrase.<br>
5. avoid_reuse             (boolean, optional, default=false) Keep track of coin reuse, and treat dirty and clean coins differently with privacy considerations in mind.<br>
<br>
Result:<br>
{<br>
  "name" :    <wallet_name>,        (string) The wallet name if created successfully. If the wallet was created using a full path, the wallet_name will be the full path.<br>
  "warning" : <warning>,            (string) Warning message if wallet was not loaded cleanly.<br>
}<br>
<br>
Examples:<br>
> defi-cli createwallet "testwallet"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createwallet", "params": ["testwallet"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>dumpprivkey "address"</summary><p>
dumpprivkey "address"<br>
<br>
Reveals the private key corresponding to 'address'.<br>
Then the importprivkey can be used with this output<br>
<br>
Arguments:<br>
1. address    (string, required) The DFI address for the private key<br>
<br>
Result:<br>
"key"                (string) The private key<br>
<br>
Examples:<br>
> defi-cli dumpprivkey "myaddress"<br>
> defi-cli importprivkey "mykey"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "dumpprivkey", "params": ["myaddress"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>dumpwallet "filename"</summary><p>
dumpwallet "filename"<br>
<br>
Dumps all wallet keys in a human-readable format to a server-side file. This does not allow overwriting existing files.<br>
Imported scripts are included in the dumpfile, but corresponding BIP173 addresses, etc. may not be added automatically by importwallet.<br>
Note that if your wallet contains keys which are not derived from your HD seed (e.g. imported keys), these are not covered by<br>
only backing up the seed itself, and must be backed up too (e.g. ensure you back up the whole dumpfile).<br>
<br>
Arguments:<br>
1. filename    (string, required) The filename with path (either absolute or relative to defid)<br>
<br>
Result:<br>
{                           (json object)<br>
  "filename" : {        (string) The filename with full absolute path<br>
}<br>
<br>
Examples:<br>
> defi-cli dumpwallet "test"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "dumpwallet", "params": ["test"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>encryptwallet "passphrase"</summary><p>
encryptwallet "passphrase"<br>
<br>
Encrypts the wallet with 'passphrase'. This is for first time encryption.<br>
After this, any calls that interact with private keys such as sending or signing <br>
will require the passphrase to be set prior the making these calls.<br>
Use the walletpassphrase call for this, and then walletlock call.<br>
If the wallet is already encrypted, use the walletpassphrasechange call.<br>
<br>
Arguments:<br>
1. passphrase    (string, required) The pass phrase to encrypt the wallet with. It must be at least 1 character, but should be long.<br>
<br>
Examples:<br>
<br>
Encrypt your wallet<br>
> defi-cli encryptwallet "my pass phrase"<br>
<br>
Now set the passphrase to use the wallet, such as for signing or sending defi<br>
> defi-cli walletpassphrase "my pass phrase"<br>
<br>
Now we can do something like sign<br>
> defi-cli signmessage "address" "test message"<br>
<br>
Now lock the wallet again by removing the passphrase<br>
> defi-cli walletlock <br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "encryptwallet", "params": ["my pass phrase"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getaddressesbylabel "label"</summary><p>
getaddressesbylabel "label"<br>
<br>
Returns the list of addresses assigned the specified label.<br>
<br>
Arguments:<br>
1. label    (string, required) The label.<br>
<br>
Result:<br>
{ (json object with addresses as keys)<br>
  "address": { (json object with information about address)<br>
    "purpose": "string" (string)  Purpose of address ("send" for sending address, "receive" for receiving address)<br>
  },...<br>
}<br>
<br>
Examples:<br>
> defi-cli getaddressesbylabel "tabby"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getaddressesbylabel", "params": ["tabby"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getaddressinfo "address"</summary><p>
getaddressinfo "address"<br>
<br>
Return information about the given defi address. Some information requires the address<br>
to be in the wallet.<br>
<br>
Arguments:<br>
1. address    (string, required) The defi address to get the information of.<br>
<br>
Result:<br>
{<br>
  "address" : "address",        (string) The defi address validated<br>
  "scriptPubKey" : "hex",       (string) The hex-encoded scriptPubKey generated by the address<br>
  "ismine" : true|false,        (boolean) If the address is yours or not<br>
  "iswatchonly" : true|false,   (boolean) If the address is watchonly<br>
  "solvable" : true|false,      (boolean) Whether we know how to spend coins sent to this address, ignoring the possible lack of private keys<br>
  "desc" : "desc",            (string, optional) A descriptor for spending coins sent to this address (only when solvable)<br>
  "isscript" : true|false,      (boolean) If the key is a script<br>
  "ischange" : true|false,      (boolean) If the address was used for change output<br>
  "iswitness" : true|false,     (boolean) If the address is a witness address<br>
  "witness_version" : version   (numeric, optional) The version number of the witness program<br>
  "witness_program" : "hex"     (string, optional) The hex value of the witness program<br>
  "script" : "type"             (string, optional) The output script type. Only if "isscript" is true and the redeemscript is known. Possible types: nonstandard, pubkey, pubkeyhash, scripthash, multisig, nulldata, witness_v0_keyhash, witness_v0_scripthash, witness_unknown<br>
  "hex" : "hex",                (string, optional) The redeemscript for the p2sh address<br>
  "pubkeys"                     (string, optional) Array of pubkeys associated with the known redeemscript (only if "script" is "multisig")<br>
    [<br>
      "pubkey"<br>
      ,...<br>
    ]<br>
  "sigsrequired" : xxxxx        (numeric, optional) Number of signatures required to spend multisig output (only if "script" is "multisig")<br>
  "pubkey" : "publickeyhex",    (string, optional) The hex value of the raw public key, for single-key addresses (possibly embedded in P2SH or P2WSH)<br>
  "embedded" : {...},           (object, optional) Information about the address embedded in P2SH or P2WSH, if relevant and known. It includes all getaddressinfo output fields for the embedded address, excluding metadata ("timestamp", "hdkeypath", "hdseedid") and relation to the wallet ("ismine", "iswatchonly").<br>
  "iscompressed" : true|false,  (boolean, optional) If the pubkey is compressed<br>
  "label" :  "label"         (string) The label associated with the address, "" is the default label<br>
  "timestamp" : timestamp,      (number, optional) The creation time of the key if available in seconds since epoch (Jan 1 1970 GMT)<br>
  "hdkeypath" : "keypath"       (string, optional) The HD keypath if the key is HD and available<br>
  "hdseedid" : "<hash160>"      (string, optional) The Hash160 of the HD seed<br>
  "hdmasterfingerprint" : "<hash160>" (string, optional) The fingperint of the master key.<br>
  "labels"                      (object) Array of labels associated with the address.<br>
    [<br>
      { (json object of label data)<br>
        "name": "labelname" (string) The label<br>
        "purpose": "string" (string) Purpose of address ("send" for sending address, "receive" for receiving address)<br>
      },...<br>
    ]<br>
}<br>
<br>
Examples:<br>
> defi-cli getaddressinfo "1PSSGeFHDnKNxiEyFrD1wcEaHr9hrQDDWc"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getaddressinfo", "params": ["1PSSGeFHDnKNxiEyFrD1wcEaHr9hrQDDWc"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getbalance ( "dummy" minconf include_watchonly avoid_reuse with_tokens )</summary><p>
getbalance ( "dummy" minconf include_watchonly avoid_reuse with_tokens )<br>
<br>
Returns the total available balance.<br>
The available balance is what the wallet considers currently spendable, and is<br>
thus affected by options which limit spendability such as -spendzeroconfchange.<br>
<br>
Arguments:<br>
1. dummy                (string, optional) Remains for backward compatibility. Must be excluded or set to "*".<br>
2. minconf              (numeric, optional, default=0) Only include transactions confirmed at least this many times.<br>
3. include_watchonly    (boolean, optional, default=true for watch-only wallets, otherwise false) Also include balance in watch-only addresses (see 'importaddress')<br>
4. avoid_reuse          (boolean, optional, default=true) (only available if avoid_reuse wallet flag is set) Do not include balance in dirty outputs; addresses are considered dirty if they have previously been used in a transaction.<br>
5. with_tokens          (boolean, optional, default=false) Include tokens balances; Default is 'false' for backward compatibility.<br>
<br>
Result:<br>
amount                 (numeric) The total amount in DFI received for this wallet.<br>
   or<br>
{tokenId: amount,...}  (list) If used 'with_tokens' option<br>
<br>
Examples:<br>
<br>
The total amount in the wallet with 1 or more confirmations<br>
> defi-cli getbalance <br>
<br>
The total amount in the wallet at least 6 blocks confirmed<br>
> defi-cli getbalance "*" 6<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getbalance", "params": ["*", 6] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getbalances ( with_tokens )</summary><p>
getbalances ( with_tokens )<br>
Returns an object with all balances in DFI.<br>
<br>
Arguments:<br>
1. with_tokens    (boolean, optional, default=false) Include tokens balances; Default is 'false' for backward compatibility.<br>
<br>
Result:<br>
{<br>
    "mine": {                        (object) balances from outputs that the wallet can sign<br>
      "trusted": xxx                 (numeric) trusted balance (outputs created by the wallet or confirmed outputs)<br>
      "untrusted_pending": xxx       (numeric) untrusted pending balance (outputs created by others that are in the mempool)<br>
      "immature": xxx                (numeric) balance from immature coinbase outputs<br>
      "used": xxx                    (numeric) (only present if avoid_reuse is set) balance from coins sent to addresses that were previously spent from (potentially privacy violating)<br>
    },<br>
    "watchonly": {                   (object) watchonly balances (not present if wallet does not watch anything)<br>
      "trusted": xxx                 (numeric) trusted balance (outputs created by the wallet or confirmed outputs)<br>
      "untrusted_pending": xxx       (numeric) untrusted pending balance (outputs created by others that are in the mempool)<br>
      "immature": xxx                (numeric) balance from immature coinbase outputs<br>
    },<br>
}<br>
<br>
Examples:<br>
> defi-cli getbalances <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getbalances", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getnewaddress ( "label" "address_type" )</summary><p>
getnewaddress ( "label" "address_type" )<br>
<br>
Returns a new Defi address for receiving payments.<br>
If 'label' is specified, it is added to the address book <br>
so payments received with the address will be associated with 'label'.<br>
<br>
Arguments:<br>
1. label           (string, optional, default="") The label name for the address to be linked to. It can also be set to the empty string "" to represent the default label. The label does not need to exist, it will be created if there is no label by the given name.<br>
2. address_type    (string, optional, default=set by -addresstype) The address type to use. Options are "legacy", "p2sh-segwit", and "bech32".<br>
<br>
Result:<br>
"address"    (string) The new defi address<br>
<br>
Examples:<br>
> defi-cli getnewaddress <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getnewaddress", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getrawchangeaddress ( "address_type" )</summary><p>
getrawchangeaddress ( "address_type" )<br>
<br>
Returns a new Defi address, for receiving change.<br>
This is for use with raw transactions, NOT normal use.<br>
<br>
Arguments:<br>
1. address_type    (string, optional, default=set by -changetype) The address type to use. Options are "legacy", "p2sh-segwit", and "bech32".<br>
<br>
Result:<br>
"address"    (string) The address<br>
<br>
Examples:<br>
> defi-cli getrawchangeaddress <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getrawchangeaddress", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getreceivedbyaddress "address" ( minconf )</summary><p>
getreceivedbyaddress "address" ( minconf )<br>
<br>
Returns the total amount received by the given address in transactions with at least minconf confirmations.<br>
<br>
Arguments:<br>
1. address    (string, required) The defi address for transactions.<br>
2. minconf    (numeric, optional, default=1) Only include transactions confirmed at least this many times.<br>
<br>
Result:<br>
amount   (numeric) The total amount in DFI received at this address.<br>
<br>
Examples:<br>
<br>
The amount from transactions with at least 1 confirmation<br>
> defi-cli getreceivedbyaddress "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX"<br>
<br>
The amount including unconfirmed transactions, zero confirmations<br>
> defi-cli getreceivedbyaddress "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX" 0<br>
<br>
The amount with at least 6 confirmations<br>
> defi-cli getreceivedbyaddress "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX" 6<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getreceivedbyaddress", "params": ["1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX", 6] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getreceivedbylabel "label" ( minconf )</summary><p>
getreceivedbylabel "label" ( minconf )<br>
<br>
Returns the total amount received by addresses with <label> in transactions with at least [minconf] confirmations.<br>
<br>
Arguments:<br>
1. label      (string, required) The selected label, may be the default label using "".<br>
2. minconf    (numeric, optional, default=1) Only include transactions confirmed at least this many times.<br>
<br>
Result:<br>
amount              (numeric) The total amount in DFI received for this label.<br>
<br>
Examples:<br>
<br>
Amount received by the default label with at least 1 confirmation<br>
> defi-cli getreceivedbylabel ""<br>
<br>
Amount received at the tabby label including unconfirmed amounts with zero confirmations<br>
> defi-cli getreceivedbylabel "tabby" 0<br>
<br>
The amount with at least 6 confirmations<br>
> defi-cli getreceivedbylabel "tabby" 6<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getreceivedbylabel", "params": ["tabby", 6] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>gettransaction "txid" ( include_watchonly )</summary><p>
gettransaction "txid" ( include_watchonly )<br>
<br>
Get detailed information about in-wallet transaction <txid><br>
<br>
Arguments:<br>
1. txid                 (string, required) The transaction id<br>
2. include_watchonly    (boolean, optional, default=true for watch-only wallets, otherwise false) Whether to include watch-only addresses in balance calculation and details[]<br>
<br>
Result:<br>
{<br>
  "amount" : x.xxx,        (numeric) The transaction amount in DFI<br>
  "fee": x.xxx,            (numeric) The amount of the fee in DFI. This is negative and only available for the <br>
                              'send' category of transactions.<br>
  "confirmations" : n,     (numeric) The number of confirmations<br>
  "blockhash" : "hash",  (string) The block hash<br>
  "blockindex" : xx,       (numeric) The index of the transaction in the block that includes it<br>
  "blocktime" : ttt,       (numeric) The time in seconds since epoch (1 Jan 1970 GMT)<br>
  "txid" : "transactionid",   (string) The transaction id.<br>
  "time" : ttt,            (numeric) The transaction time in seconds since epoch (1 Jan 1970 GMT)<br>
  "timereceived" : ttt,    (numeric) The time received in seconds since epoch (1 Jan 1970 GMT)<br>
  "bip125-replaceable": "yes|no|unknown",  (string) Whether this transaction could be replaced due to BIP125 (replace-by-fee);<br>
                                                   may be unknown for unconfirmed transactions not in the mempool<br>
  "details" : [<br>
    {<br>
      "address" : "address",          (string) The defi address involved in the transaction<br>
      "category" :                      (string) The transaction category.<br>
                   "send"                  Transactions sent.<br>
                   "receive"               Non-coinbase transactions received.<br>
                   "generate"              Coinbase transactions received with more than 100 confirmations.<br>
                   "immature"              Coinbase transactions received with 100 or fewer confirmations.<br>
                   "orphan"                Orphaned coinbase transactions received.<br>
      "amount" : x.xxx,                 (numeric) The amount in DFI<br>
      "label" : "label",              (string) A comment for the address/transaction, if any<br>
      "vout" : n,                       (numeric) the vout value<br>
      "fee": x.xxx,                     (numeric) The amount of the fee in DFI. This is negative and only available for the <br>
                                           'send' category of transactions.<br>
      "abandoned": xxx                  (bool) 'true' if the transaction has been abandoned (inputs are respendable). Only available for the <br>
                                           'send' category of transactions.<br>
    }<br>
    ,...<br>
  ],<br>
  "hex" : "data"         (string) Raw data for transaction<br>
}<br>
<br>
Examples:<br>
> defi-cli gettransaction "1075db55d416d3ca199f55b6084e2115b9345e16c5cf302fc80e9d5fbf5d48d"<br>
> defi-cli gettransaction "1075db55d416d3ca199f55b6084e2115b9345e16c5cf302fc80e9d5fbf5d48d" true<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "gettransaction", "params": ["1075db55d416d3ca199f55b6084e2115b9345e16c5cf302fc80e9d5fbf5d48d"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>getunconfirmedbalance ( with_tokens )</summary><p>
getunconfirmedbalance ( with_tokens )<br>
DEPRECATED<br>
Identical to getbalances().mine.untrusted_pending<br>
<br>
Arguments:<br>
1. with_tokens    (boolean, optional, default=false) Include tokens balances; Default is 'false' for backward compatibility.<br>

</p></details>

<details><summary>getwalletinfo ( with_tokens )</summary><p>
getwalletinfo ( with_tokens )<br>
Returns an object containing various wallet state info.<br>
<br>
Arguments:<br>
1. with_tokens    (boolean, optional, default=false) Include tokens balances; Default is 'false' for backward compatibility.<br>
<br>
Result:<br>
{<br>
  "walletname": xxxxx,               (string) the wallet name<br>
  "walletversion": xxxxx,            (numeric) the wallet version<br>
  "balance": xxxxxxx,                (numeric) DEPRECATED. Identical to getbalances().mine.trusted<br>
  "unconfirmed_balance": xxx,        (numeric) DEPRECATED. Identical to getbalances().mine.untrusted_pending<br>
  "immature_balance": xxxxxx,        (numeric) DEPRECATED. Identical to getbalances().mine.immature<br>
  "txcount": xxxxxxx,                (numeric) the total number of transactions in the wallet<br>
  "keypoololdest": xxxxxx,           (numeric) the timestamp (seconds since Unix epoch) of the oldest pre-generated key in the key pool<br>
  "keypoolsize": xxxx,               (numeric) how many new keys are pre-generated (only counts external keys)<br>
  "keypoolsize_hd_internal": xxxx,   (numeric) how many new keys are pre-generated for internal use (used for change outputs, only appears if the wallet is using this feature, otherwise external keys are used)<br>
  "unlocked_until": ttt,             (numeric) the timestamp in seconds since epoch (midnight Jan 1 1970 GMT) that the wallet is unlocked for transfers, or 0 if the wallet is locked<br>
  "paytxfee": x.xxxx,                (numeric) the transaction fee configuration, set in DFI/kB<br>
  "hdseedid": "<hash160>"            (string, optional) the Hash160 of the HD seed (only present when HD is enabled)<br>
  "private_keys_enabled": true|false (boolean) false if privatekeys are disabled for this wallet (enforced watch-only wallet)<br>
  "avoid_reuse": true|false          (boolean) whether this wallet tracks clean/dirty coins in terms of reuse<br>
  "scanning":                        (json object) current scanning details, or false if no scan is in progress<br>
    {<br>
      "duration" : xxxx              (numeric) elapsed seconds since scan start<br>
      "progress" : x.xxxx,           (numeric) scanning progress percentage [0.0, 1.0]<br>
    }<br>
}<br>
<br>
Examples:<br>
> defi-cli getwalletinfo <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getwalletinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>importaddress "address" ( "label" rescan p2sh )</summary><p>
importaddress "address" ( "label" rescan p2sh )<br>
<br>
Adds an address or script (in hex) that can be watched as if it were in your wallet but cannot be used to spend. Requires a new wallet backup.<br>
<br>
Note: This call can take over an hour to complete if rescan is true, during that time, other rpc calls<br>
may report that the imported address exists but related transactions are still missing, leading to temporarily incorrect/bogus balances and unspent outputs until rescan completes.<br>
If you have the full public key, you should call importpubkey instead of this.<br>
Hint: use importmulti to import more than one address.<br>
<br>
Note: If you import a non-standard raw script in hex form, outputs sending to it will be treated<br>
as change, and not show up in many RPCs.<br>
Note: Use "getwalletinfo" to query the scanning progress.<br>
<br>
Arguments:<br>
1. address    (string, required) The DFI address (or hex-encoded script)<br>
2. label      (string, optional, default="") An optional label<br>
3. rescan     (boolean, optional, default=true) Rescan the wallet for transactions<br>
4. p2sh       (boolean, optional, default=false) Add the P2SH version of the script as well<br>
<br>
Examples:<br>
<br>
Import an address with rescan<br>
> defi-cli importaddress "myaddress"<br>
<br>
Import using a label without rescan<br>
> defi-cli importaddress "myaddress" "testing" false<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "importaddress", "params": ["myaddress", "testing", false] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>importmulti "requests" ( "options" )</summary><p>
importmulti "requests" ( "options" )<br>
<br>
Import addresses/scripts (with private or public keys, redeem script (P2SH)), optionally rescanning the blockchain from the earliest creation time of the imported scripts. Requires a new wallet backup.<br>
If an address/script is imported without all of the private keys required to spend from that address, it will be watchonly. The 'watchonly' option must be set to true in this case or a warning will be returned.<br>
Conversely, if all the private keys are provided and the address/script is spendable, the watchonly option must be set to false, or a warning will be returned.<br>
<br>
Note: This call can take over an hour to complete if rescan is true, during that time, other rpc calls<br>
may report that the imported keys, addresses or scripts exist but related transactions are still missing.<br>
Note: Use "getwalletinfo" to query the scanning progress.<br>
<br>
Arguments:<br>
1. requests                                                         (json array, required) Data to be imported<br>
     [<br>
       {                                                            (json object)<br>
         "desc": "str",                                             (string) Descriptor to import. If using descriptor, do not also provide address/scriptPubKey, scripts, or pubkeys<br>
         "scriptPubKey": "<script>" | { "address":"<address>" },    (string / json, required) Type of scriptPubKey (string for script, json for address). Should not be provided if using a descriptor<br>
         "timestamp": timestamp | "now",                            (integer / string, required) Creation time of the key in seconds since epoch (Jan 1 1970 GMT),<br>
                                                                    or the string "now" to substitute the current synced blockchain time. The timestamp of the oldest<br>
                                                                    key will determine how far back blockchain rescans need to begin for missing wallet transactions.<br>
                                                                    "now" can be specified to bypass scanning, for keys which are known to never have been used, and<br>
                                                                    0 can be specified to scan the entire blockchain. Blocks up to 2 hours before the earliest key<br>
                                                                    creation time of all keys being imported by the importmulti call will be scanned.<br>
         "redeemscript": "str",                                     (string) Allowed only if the scriptPubKey is a P2SH or P2SH-P2WSH address/scriptPubKey<br>
         "witnessscript": "str",                                    (string) Allowed only if the scriptPubKey is a P2SH-P2WSH or P2WSH address/scriptPubKey<br>
         "pubkeys": [                                               (json array, optional, default=empty array) Array of strings giving pubkeys to import. They must occur in P2PKH or P2WPKH scripts. They are not required when the private key is also provided (see the "keys" argument).<br>
           "pubKey",                                                (string)<br>
           ...<br>
         ],<br>
         "keys": [                                                  (json array, optional, default=empty array) Array of strings giving private keys to import. The corresponding public keys must occur in the output or redeemscript.<br>
           "key",                                                   (string)<br>
           ...<br>
         ],<br>
         "range": n or [n,n],                                       (numeric or array) If a ranged descriptor is used, this specifies the end or the range (in the form [begin,end]) to import<br>
         "internal": bool,                                          (boolean, optional, default=false) Stating whether matching outputs should be treated as not incoming payments (also known as change)<br>
         "watchonly": bool,                                         (boolean, optional, default=false) Stating whether matching outputs should be considered watchonly.<br>
         "label": "str",                                            (string, optional, default='') Label to assign to the address, only allowed with internal=false<br>
         "keypool": bool,                                           (boolean, optional, default=false) Stating whether imported public keys should be added to the keypool for when users request new addresses. Only allowed when wallet private keys are disabled<br>
       },<br>
       ...<br>
     ]<br>
2. options                                                          (json object, optional)<br>
     {<br>
       "rescan": bool,                                              (boolean, optional, default=true) Stating if should rescan the blockchain after all imports<br>
     }<br>
<br>
Result:<br>
<br>
Response is an array with the same size as the input that has the execution result :<br>
  [{"success": true}, {"success": true, "warnings": ["Ignoring irrelevant private key"]}, {"success": false, "error": {"code": -1, "message": "Internal Server Error"}}, ...]<br>
<br>
Examples:<br>
> defi-cli importmulti '[{ "scriptPubKey": { "address": "<my address>" }, "timestamp":1455191478 }, { "scriptPubKey": { "address": "<my 2nd address>" }, "label": "example 2", "timestamp": 1455191480 }]'<br>
> defi-cli importmulti '[{ "scriptPubKey": { "address": "<my address>" }, "timestamp":1455191478 }]' '{ "rescan": false}'<br>

</p></details>

<details><summary>importprivkey "privkey" ( "label" rescan )</summary><p>
importprivkey "privkey" ( "label" rescan )<br>
<br>
Adds a private key (as returned by dumpprivkey) to your wallet. Requires a new wallet backup.<br>
Hint: use importmulti to import more than one private key.<br>
<br>
Note: This call can take over an hour to complete if rescan is true, during that time, other rpc calls<br>
may report that the imported key exists but related transactions are still missing, leading to temporarily incorrect/bogus balances and unspent outputs until rescan completes.<br>
Note: Use "getwalletinfo" to query the scanning progress.<br>
<br>
Arguments:<br>
1. privkey    (string, required) The private key (see dumpprivkey)<br>
2. label      (string, optional, default=current label if address exists, otherwise "") An optional label<br>
3. rescan     (boolean, optional, default=true) Rescan the wallet for transactions<br>
<br>
Examples:<br>
<br>
Dump a private key<br>
> defi-cli dumpprivkey "myaddress"<br>
<br>
Import the private key with rescan<br>
> defi-cli importprivkey "mykey"<br>
<br>
Import using a label and without rescan<br>
> defi-cli importprivkey "mykey" "testing" false<br>
<br>
Import using default blank label and without rescan<br>
> defi-cli importprivkey "mykey" "" false<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "importprivkey", "params": ["mykey", "testing", false] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>importprunedfunds "rawtransaction" "txoutproof"</summary><p>
importprunedfunds "rawtransaction" "txoutproof"<br>
<br>
Imports funds without rescan. Corresponding address or script must previously be included in wallet. Aimed towards pruned wallets. The end-user is responsible to import additional transactions that subsequently spend the imported outputs or rescan after the point in the blockchain the transaction is included.<br>
<br>
Arguments:<br>
1. rawtransaction    (string, required) A raw transaction in hex funding an already-existing address in wallet<br>
2. txoutproof        (string, required) The hex output from gettxoutproof that contains the transaction<br>

</p></details>

<details><summary>importpubkey "pubkey" ( "label" rescan )</summary><p>
importpubkey "pubkey" ( "label" rescan )<br>
<br>
Adds a public key (in hex) that can be watched as if it were in your wallet but cannot be used to spend. Requires a new wallet backup.<br>
Hint: use importmulti to import more than one public key.<br>
<br>
Note: This call can take over an hour to complete if rescan is true, during that time, other rpc calls<br>
may report that the imported pubkey exists but related transactions are still missing, leading to temporarily incorrect/bogus balances and unspent outputs until rescan completes.<br>
Note: Use "getwalletinfo" to query the scanning progress.<br>
<br>
Arguments:<br>
1. pubkey    (string, required) The hex-encoded public key<br>
2. label     (string, optional, default="") An optional label<br>
3. rescan    (boolean, optional, default=true) Rescan the wallet for transactions<br>
<br>
Examples:<br>
<br>
Import a public key with rescan<br>
> defi-cli importpubkey "mypubkey"<br>
<br>
Import using a label without rescan<br>
> defi-cli importpubkey "mypubkey" "testing" false<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "importpubkey", "params": ["mypubkey", "testing", false] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>importwallet "filename"</summary><p>
importwallet "filename"<br>
<br>
Imports keys from a wallet dump file (see dumpwallet). Requires a new wallet backup to include imported keys.<br>
Note: Use "getwalletinfo" to query the scanning progress.<br>
<br>
Arguments:<br>
1. filename    (string, required) The wallet file<br>
<br>
Examples:<br>
<br>
Dump the wallet<br>
> defi-cli dumpwallet "test"<br>
<br>
Import the wallet<br>
> defi-cli importwallet "test"<br>
<br>
Import using the json rpc call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "importwallet", "params": ["test"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>keypoolrefill ( newsize )</summary><p>
keypoolrefill ( newsize )<br>
<br>
Fills the keypool.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. newsize    (numeric, optional, default=100) The new keypool size<br>
<br>
Examples:<br>
> defi-cli keypoolrefill <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "keypoolrefill", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listaddressgroupings</summary><p>
listaddressgroupings<br>
<br>
Lists groups of addresses which have had their common ownership<br>
made public by common use as inputs or as the resulting change<br>
in past transactions<br>
<br>
Result:<br>
[<br>
  [<br>
    [<br>
      "address",            (string) The defi address<br>
      amount,                 (numeric) The amount in DFI<br>
      "label"               (string, optional) The label<br>
    ]<br>
    ,...<br>
  ]<br>
  ,...<br>
]<br>
<br>
Examples:<br>
> defi-cli listaddressgroupings <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listaddressgroupings", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listlabels ( "purpose" )</summary><p>
listlabels ( "purpose" )<br>
<br>
Returns the list of all labels, or labels that are assigned to addresses with a specific purpose.<br>
<br>
Arguments:<br>
1. purpose    (string, optional) Address purpose to list labels for ('send','receive'). An empty string is the same as not providing this argument.<br>
<br>
Result:<br>
[               (json array of string)<br>
  "label",      (string) Label name<br>
  ...<br>
]<br>
<br>
Examples:<br>
<br>
List all labels<br>
> defi-cli listlabels <br>
<br>
List labels that have receiving addresses<br>
> defi-cli listlabels receive<br>
<br>
List labels that have sending addresses<br>
> defi-cli listlabels send<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listlabels", "params": [receive] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listlockunspent</summary><p>
listlockunspent<br>
<br>
Returns list of temporarily unspendable outputs.<br>
See the lockunspent call to lock and unlock transactions for spending.<br>
<br>
Result:<br>
[<br>
  {<br>
    "txid" : "transactionid",     (string) The transaction id locked<br>
    "vout" : n                      (numeric) The vout value<br>
  }<br>
  ,...<br>
]<br>
<br>
Examples:<br>
<br>
List the unspent transactions<br>
> defi-cli listunspent <br>
<br>
Lock an unspent transaction<br>
> defi-cli lockunspent false "[{\"txid\":\"a08e6907dbbd3d809776dbfc5d82e371b764ed838b5655e72f463568df1aadf0\",\"vout\":1}]"<br>
<br>
List the locked transactions<br>
> defi-cli listlockunspent <br>
<br>
Unlock the transaction again<br>
> defi-cli lockunspent true "[{\"txid\":\"a08e6907dbbd3d809776dbfc5d82e371b764ed838b5655e72f463568df1aadf0\",\"vout\":1}]"<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listlockunspent", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listreceivedbyaddress ( minconf include_empty include_watchonly "address_filter" )</summary><p>
listreceivedbyaddress ( minconf include_empty include_watchonly "address_filter" )<br>
<br>
List balances by receiving address.<br>
<br>
Arguments:<br>
1. minconf              (numeric, optional, default=1) The minimum number of confirmations before payments are included.<br>
2. include_empty        (boolean, optional, default=false) Whether to include addresses that haven't received any payments.<br>
3. include_watchonly    (boolean, optional, default=true for watch-only wallets, otherwise false) Whether to include watch-only addresses (see 'importaddress')<br>
4. address_filter       (string, optional) If present, only return information on this address.<br>
<br>
Result:<br>
[<br>
  {<br>
    "involvesWatchonly" : true,        (bool) Only returned if imported addresses were involved in transaction<br>
    "address" : "receivingaddress",  (string) The receiving address<br>
    "amount" : x.xxx,                  (numeric) The total amount in DFI received by the address<br>
    "confirmations" : n,               (numeric) The number of confirmations of the most recent transaction included<br>
    "label" : "label",               (string) The label of the receiving address. The default label is "".<br>
    "txids": [<br>
       "txid",                         (string) The ids of transactions received with the address <br>
       ...<br>
    ]<br>
  }<br>
  ,...<br>
]<br>
<br>
Examples:<br>
> defi-cli listreceivedbyaddress <br>
> defi-cli listreceivedbyaddress 6 true<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listreceivedbyaddress", "params": [6, true, true] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listreceivedbyaddress", "params": [6, true, true, "1M72Sfpbz1BPpXFHz9m3CdqATR44Jvaydd"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listreceivedbylabel ( minconf include_empty include_watchonly )</summary><p>
listreceivedbylabel ( minconf include_empty include_watchonly )<br>
<br>
List received transactions by label.<br>
<br>
Arguments:<br>
1. minconf              (numeric, optional, default=1) The minimum number of confirmations before payments are included.<br>
2. include_empty        (boolean, optional, default=false) Whether to include labels that haven't received any payments.<br>
3. include_watchonly    (boolean, optional, default=true for watch-only wallets, otherwise false) Whether to include watch-only addresses (see 'importaddress')<br>
<br>
Result:<br>
[<br>
  {<br>
    "involvesWatchonly" : true,   (bool) Only returned if imported addresses were involved in transaction<br>
    "amount" : x.xxx,             (numeric) The total amount received by addresses with this label<br>
    "confirmations" : n,          (numeric) The number of confirmations of the most recent transaction included<br>
    "label" : "label"           (string) The label of the receiving address. The default label is "".<br>
  }<br>
  ,...<br>
]<br>
<br>
Examples:<br>
> defi-cli listreceivedbylabel <br>
> defi-cli listreceivedbylabel 6 true<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listreceivedbylabel", "params": [6, true, true] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listsinceblock ( "blockhash" target_confirmations include_watchonly include_removed )</summary><p>
listsinceblock ( "blockhash" target_confirmations include_watchonly include_removed )<br>
<br>
Get all transactions in blocks since block [blockhash], or all transactions if omitted.<br>
If "blockhash" is no longer a part of the main chain, transactions from the fork point onward are included.<br>
Additionally, if include_removed is set, transactions affecting the wallet which were removed are returned in the "removed" array.<br>
<br>
Arguments:<br>
1. blockhash               (string, optional) If set, the block hash to list transactions since, otherwise list all transactions.<br>
2. target_confirmations    (numeric, optional, default=1) Return the nth block hash from the main chain. e.g. 1 would mean the best block hash. Note: this is not used as a filter, but only affects [lastblock] in the return value<br>
3. include_watchonly       (boolean, optional, default=true for watch-only wallets, otherwise false) Include transactions to watch-only addresses (see 'importaddress')<br>
4. include_removed         (boolean, optional, default=true) Show transactions that were removed due to a reorg in the "removed" array<br>
                           (not guaranteed to work on pruned nodes)<br>
<br>
Result:<br>
{<br>
  "transactions": [<br>
    "address":"address",    (string) The defi address of the transaction.<br>
    "category":               (string) The transaction category.<br>
                "send"                  Transactions sent.<br>
                "receive"               Non-coinbase transactions received.<br>
                "generate"              Coinbase transactions received with more than 100 confirmations.<br>
                "immature"              Coinbase transactions received with 100 or fewer confirmations.<br>
                "orphan"                Orphaned coinbase transactions received.<br>
    "amount": x.xxx,          (numeric) The amount in DFI. This is negative for the 'send' category, and is positive<br>
                                         for all other categories<br>
    "vout" : n,               (numeric) the vout value<br>
    "fee": x.xxx,             (numeric) The amount of the fee in DFI. This is negative and only available for the 'send' category of transactions.<br>
    "confirmations": n,       (numeric) The number of confirmations for the transaction.<br>
                                          When it's < 0, it means the transaction conflicted that many blocks ago.<br>
    "blockhash": "hashvalue",     (string) The block hash containing the transaction.<br>
    "blockindex": n,          (numeric) The index of the transaction in the block that includes it.<br>
    "blocktime": xxx,         (numeric) The block time in seconds since epoch (1 Jan 1970 GMT).<br>
    "txid": "transactionid",  (string) The transaction id.<br>
    "time": xxx,              (numeric) The transaction time in seconds since epoch (Jan 1 1970 GMT).<br>
    "timereceived": xxx,      (numeric) The time received in seconds since epoch (Jan 1 1970 GMT).<br>
    "bip125-replaceable": "yes|no|unknown",  (string) Whether this transaction could be replaced due to BIP125 (replace-by-fee);<br>
                                                   may be unknown for unconfirmed transactions not in the mempool<br>
    "abandoned": xxx,         (bool) 'true' if the transaction has been abandoned (inputs are respendable). Only available for the 'send' category of transactions.<br>
    "comment": "...",       (string) If a comment is associated with the transaction.<br>
    "label" : "label"       (string) A comment for the address/transaction, if any<br>
    "to": "...",            (string) If a comment to is associated with the transaction.<br>
  ],<br>
  "removed": [<br>
    <structure is the same as "transactions" above, only present if include_removed=true><br>
    Note: transactions that were re-added in the active chain will appear as-is in this array, and may thus have a positive confirmation count.<br>
  ],<br>
  "lastblock": "lastblockhash"     (string) The hash of the block (target_confirmations-1) from the best block on the main chain. This is typically used to feed back into listsinceblock the next time you call it. So you would generally use a target_confirmations of say 6, so you will be continually re-notified of transactions until they've reached 6 confirmations plus any new ones<br>
}<br>
<br>
Examples:<br>
> defi-cli listsinceblock <br>
> defi-cli listsinceblock "000000000000000bacf66f7497b7dc45ef753ee9a7d38571037cdb1a57f663ad" 6<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listsinceblock", "params": ["000000000000000bacf66f7497b7dc45ef753ee9a7d38571037cdb1a57f663ad", 6] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listtransactions ( "label" count skip include_watchonly exclude_custom_tx )</summary><p>
listtransactions ( "label" count skip include_watchonly exclude_custom_tx )<br>
<br>
If a label name is provided, this will return only incoming transactions paying to addresses with the specified label.<br>
<br>
Returns up to 'count' most recent transactions skipping the first 'from' transactions.<br>
<br>
Arguments:<br>
1. label                (string, optional) If set, should be a valid label name to return only incoming transactions<br>
                        with the specified label, or "*" to disable filtering and return all transactions.<br>
2. count                (numeric, optional, default=10) The number of transactions to return<br>
3. skip                 (numeric, optional, default=0) The number of transactions to skip<br>
4. include_watchonly    (boolean, optional, default=true for watch-only wallets, otherwise false) Include transactions to watch-only addresses (see 'importaddress')<br>
5. exclude_custom_tx    (boolean, optional, default=false to include all transactions, otherwise exclude custom transactions) Exclude custom transactions<br>
<br>
Result:<br>
[<br>
  {<br>
    "address":"address",    (string) The defi address of the transaction.<br>
    "category":               (string) The transaction category.<br>
                "send"                  Transactions sent.<br>
                "receive"               Non-coinbase transactions received.<br>
                "generate"              Coinbase transactions received with more than 100 confirmations.<br>
                "immature"              Coinbase transactions received with 100 or fewer confirmations.<br>
                "orphan"                Orphaned coinbase transactions received.<br>
    "amount": x.xxx,          (numeric) The amount in DFI. This is negative for the 'send' category, and is positive<br>
                                        for all other categories<br>
    "label": "label",       (string) A comment for the address/transaction, if any<br>
    "vout": n,                (numeric) the vout value<br>
    "fee": x.xxx,             (numeric) The amount of the fee in DFI. This is negative and only available for the <br>
                                         'send' category of transactions.<br>
    "confirmations": n,       (numeric) The number of confirmations for the transaction. Negative confirmations indicate the<br>
                                         transaction conflicts with the block chain<br>
    "trusted": xxx,           (bool) Whether we consider the outputs of this unconfirmed transaction safe to spend.<br>
    "blockhash": "hashvalue", (string) The block hash containing the transaction.<br>
    "blockindex": n,          (numeric) The index of the transaction in the block that includes it.<br>
    "blocktime": xxx,         (numeric) The block time in seconds since epoch (1 Jan 1970 GMT).<br>
    "txid": "transactionid", (string) The transaction id.<br>
    "time": xxx,              (numeric) The transaction time in seconds since epoch (midnight Jan 1 1970 GMT).<br>
    "timereceived": xxx,      (numeric) The time received in seconds since epoch (midnight Jan 1 1970 GMT).<br>
    "comment": "...",       (string) If a comment is associated with the transaction.<br>
    "bip125-replaceable": "yes|no|unknown",  (string) Whether this transaction could be replaced due to BIP125 (replace-by-fee);<br>
                                                     may be unknown for unconfirmed transactions not in the mempool<br>
    "abandoned": xxx          (bool) 'true' if the transaction has been abandoned (inputs are respendable). Only available for the <br>
                                         'send' category of transactions.<br>
  }<br>
]<br>
<br>
Examples:<br>
<br>
List the most recent 10 transactions in the systems<br>
> defi-cli listtransactions <br>
<br>
List transactions 100 to 120<br>
> defi-cli listtransactions "*" 20 100<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listtransactions", "params": ["*", 20, 100] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listunspent ( minconf maxconf ["address",...] include_unsafe query_options )</summary><p>
listunspent ( minconf maxconf ["address",...] include_unsafe query_options )<br>
<br>
Returns array of unspent transaction outputs<br>
with between minconf and maxconf (inclusive) confirmations.<br>
Optionally filter to only include txouts paid to specified addresses.<br>
<br>
Arguments:<br>
1. minconf                            (numeric, optional, default=1) The minimum confirmations to filter<br>
2. maxconf                            (numeric, optional, default=9999999) The maximum confirmations to filter<br>
3. addresses                          (json array, optional, default=empty array) A json array of defi addresses to filter<br>
     [<br>
       "address",                     (string) defi address<br>
       ...<br>
     ]<br>
4. include_unsafe                     (boolean, optional, default=true) Include outputs that are not safe to spend<br>
                                      See description of "safe" attribute below.<br>
5. query_options                      (json object, optional) JSON with query options<br>
     {<br>
       "minimumAmount": amount,       (numeric or string, optional, default=0) Minimum value of each UTXO in DFI<br>
       "maximumAmount": amount,       (numeric or string, optional, default=unlimited) Maximum value of each UTXO in DFI<br>
       "maximumCount": n,             (numeric, optional, default=unlimited) Maximum number of UTXOs<br>
       "minimumSumAmount": amount,    (numeric or string, optional, default=unlimited) Minimum sum value of all UTXOs in DFI<br>
       "tokenId": "str",              (string, optional, default=all) Filter by token (id/symbol/creationTx)<br>
     }<br>
<br>
Result:<br>
[                   (array of json object)<br>
  {<br>
    "txid" : "txid",          (string) the transaction id <br>
    "vout" : n,               (numeric) the vout value<br>
    "address" : "address",    (string) the defi address<br>
    "label" : "label",        (string) The associated label, or "" for the default label<br>
    "scriptPubKey" : "key",   (string) the script key<br>
    "amount" : x.xxx,         (numeric) the transaction output amount in DFI<br>
    "tokenId" : n,            (numeric) the transaction output token Id<br>
    "confirmations" : n,      (numeric) The number of confirmations<br>
    "redeemScript" : "script" (string) The redeemScript if scriptPubKey is P2SH<br>
    "witnessScript" : "script" (string) witnessScript if the scriptPubKey is P2WSH or P2SH-P2WSH<br>
    "spendable" : xxx,        (bool) Whether we have the private keys to spend this output<br>
    "solvable" : xxx,         (bool) Whether we know how to spend this output, ignoring the lack of keys<br>
    "reused" : xxx,           (bool) (only present if avoid_reuse is set) Whether this output is reused/dirty (sent to an address that was previously spent from)<br>
    "desc" : xxx,             (string, only when solvable) A descriptor for spending this output<br>
    "safe" : xxx              (bool) Whether this output is considered safe to spend. Unconfirmed transactions<br>
                              from outside keys and unconfirmed replacement transactions are considered unsafe<br>
                              and are not eligible for spending by fundrawtransaction and sendtoaddress.<br>
  }<br>
  ,...<br>
]<br>
<br>
Examples:<br>
> defi-cli listunspent <br>
> defi-cli listunspent 6 9999999 "[\"1PGFqEzfmQch1gKD3ra4k18PNj3tTUUSqg\",\"1LtvqCaApEdUGFkpKMM4MstjcaL4dKg8SP\"]"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listunspent", "params": [6, 9999999 "[\"1PGFqEzfmQch1gKD3ra4k18PNj3tTUUSqg\",\"1LtvqCaApEdUGFkpKMM4MstjcaL4dKg8SP\"]"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>
> defi-cli listunspent 6 9999999 '[]' true '{ "minimumAmount": 0.005 }'<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listunspent", "params": [6, 9999999, [] , true, { "minimumAmount": 0.005 } ] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listwalletdir</summary><p>
listwalletdir<br>
Returns a list of wallets in the wallet directory.<br>
<br>
Result:<br>
{<br>
  "wallets" : [                (json array of objects)<br>
    {<br>
      "name" : "name"          (string) The wallet name<br>
    }<br>
    ,...<br>
  ]<br>
}<br>
<br>
Examples:<br>
> defi-cli listwalletdir <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listwalletdir", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>listwallets</summary><p>
listwallets<br>
Returns a list of currently loaded wallets.<br>
For full information on the wallet, use "getwalletinfo"<br>
<br>
Result:<br>
[                         (json array of strings)<br>
  "walletname"            (string) the wallet name<br>
   ...<br>
]<br>
<br>
Examples:<br>
> defi-cli listwallets <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listwallets", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>loadwallet "filename"</summary><p>
loadwallet "filename"<br>
<br>
Loads a wallet from a wallet file or directory.<br>
Note that all wallet command-line options used when starting defid will be<br>
applied to the new wallet (eg -zapwallettxes, upgradewallet, rescan, etc).<br>
<br>
Arguments:<br>
1. filename    (string, required) The wallet directory or .dat file.<br>
<br>
Result:<br>
{<br>
  "name" :    <wallet_name>,        (string) The wallet name if loaded successfully.<br>
  "warning" : <warning>,            (string) Warning message if wallet was not loaded cleanly.<br>
}<br>
<br>
Examples:<br>
> defi-cli loadwallet "test.dat"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "loadwallet", "params": ["test.dat"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>lockunspent unlock ( [{"txid":"hex","vout":n},...] )</summary><p>
lockunspent unlock ( [{"txid":"hex","vout":n},...] )<br>
<br>
Updates list of temporarily unspendable outputs.<br>
Temporarily lock (unlock=false) or unlock (unlock=true) specified transaction outputs.<br>
If no transaction outputs are specified when unlocking then all current locked transaction outputs are unlocked.<br>
A locked transaction output will not be chosen by automatic coin selection, when spending defis.<br>
Locks are stored in memory only. Nodes start with zero locked outputs, and the locked output list<br>
is always cleared (by virtue of process exit) when a node stops or fails.<br>
Also see the listunspent call<br>
<br>
Arguments:<br>
1. unlock                  (boolean, required) Whether to unlock (true) or lock (false) the specified transactions<br>
2. transactions            (json array, optional, default=empty array) A json array of objects. Each object the txid (string) vout (numeric).<br>
     [<br>
       {                   (json object)<br>
         "txid": "hex",    (string, required) The transaction id<br>
         "vout": n,        (numeric, required) The output number<br>
       },<br>
       ...<br>
     ]<br>
<br>
Result:<br>
true|false    (boolean) Whether the command was successful or not<br>
<br>
Examples:<br>
<br>
List the unspent transactions<br>
> defi-cli listunspent <br>
<br>
Lock an unspent transaction<br>
> defi-cli lockunspent false "[{\"txid\":\"a08e6907dbbd3d809776dbfc5d82e371b764ed838b5655e72f463568df1aadf0\",\"vout\":1}]"<br>
<br>
List the locked transactions<br>
> defi-cli listlockunspent <br>
<br>
Unlock the transaction again<br>
> defi-cli lockunspent true "[{\"txid\":\"a08e6907dbbd3d809776dbfc5d82e371b764ed838b5655e72f463568df1aadf0\",\"vout\":1}]"<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "lockunspent", "params": [false, "[{\"txid\":\"a08e6907dbbd3d809776dbfc5d82e371b764ed838b5655e72f463568df1aadf0\",\"vout\":1}]"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>removeprunedfunds "txid"</summary><p>
removeprunedfunds "txid"<br>
<br>
Deletes the specified transaction from the wallet. Meant for use with pruned wallets and as a companion to importprunedfunds. This will affect wallet balances.<br>
<br>
Arguments:<br>
1. txid    (string, required) The hex-encoded id of the transaction you are deleting<br>
<br>
Examples:<br>
> defi-cli removeprunedfunds "a8d0c0184dde994a09ec054286f1ce581bebf46446a512166eae7628734ea0a5"<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "removeprunedfunds", "params": ["a8d0c0184dde994a09ec054286f1ce581bebf46446a512166eae7628734ea0a5"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>rescanblockchain ( start_height stop_height )</summary><p>
rescanblockchain ( start_height stop_height )<br>
<br>
Rescan the local blockchain for wallet related transactions.<br>
Note: Use "getwalletinfo" to query the scanning progress.<br>
<br>
Arguments:<br>
1. start_height    (numeric, optional, default=0) block height where the rescan should start<br>
2. stop_height     (numeric, optional) the last block height that should be scanned. If none is provided it will rescan up to the tip at return time of this call.<br>
<br>
Result:<br>
{<br>
  "start_height"     (numeric) The block height where the rescan started (the requested height or 0)<br>
  "stop_height"      (numeric) The height of the last rescanned block. May be null in rare cases if there was a reorg and the call didn't scan any blocks because they were already scanned in the background.<br>
}<br>
<br>
Examples:<br>
> defi-cli rescanblockchain 100000 120000<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "rescanblockchain", "params": [100000, 120000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>sendmany "" {"address":amount} ( minconf "comment" ["address",...] replaceable conf_target "estimate_mode" )</summary><p>
sendmany "" {"address":amount} ( minconf "comment" ["address",...] replaceable conf_target "estimate_mode" )<br>
<br>
Send multiple times. Amounts are double-precision floating point numbers.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. dummy                     (string, required) Must be set to "" for backwards compatibility.<br>
2. amounts                   (json object, required) A json object with addresses and amounts<br>
     {<br>
       "address": amount,    (numeric or string, required) The defi address is the key, the numeric amount (can be string) in DFI is the value<br>
     }<br>
3. minconf                   (numeric, optional) Ignored dummy value<br>
4. comment                   (string, optional) A comment<br>
5. subtractfeefrom           (json array, optional) A json array with addresses.<br>
                             The fee will be equally deducted from the amount of each selected address.<br>
                             Those recipients will receive less defis than you enter in their corresponding amount field.<br>
                             If no addresses are specified here, the sender pays the fee.<br>
     [<br>
       "address",            (string) Subtract fee from this address<br>
       ...<br>
     ]<br>
6. replaceable               (boolean, optional, default=wallet default) Allow this transaction to be replaced by a transaction with higher fees via BIP 125<br>
7. conf_target               (numeric, optional, default=wallet default) Confirmation target (in blocks)<br>
8. estimate_mode             (string, optional, default=UNSET) The fee estimate mode, must be one of:<br>
                             "UNSET"<br>
                             "ECONOMICAL"<br>
                             "CONSERVATIVE"<br>
<br>
Result:<br>
"txid"                   (string) The transaction id for the send. Only 1 transaction is created regardless of <br>
                                    the number of addresses.<br>
<br>
Examples:<br>
<br>
Send two amounts to two different addresses:<br>
> defi-cli sendmany "" "{\"1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX\":0.01,\"1353tsE8YMTA4EuV7dgUXGjNFf9KpVvKHz\":0.02}"<br>
<br>
Send two amounts to two different addresses setting the confirmation and comment:<br>
> defi-cli sendmany "" "{\"1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX\":0.01,\"1353tsE8YMTA4EuV7dgUXGjNFf9KpVvKHz\":0.02}" 6 "testing"<br>
<br>
Send two amounts to two different addresses, subtract fee from amount:<br>
> defi-cli sendmany "" "{\"1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX\":0.01,\"1353tsE8YMTA4EuV7dgUXGjNFf9KpVvKHz\":0.02}" 1 "" "[\"1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX\",\"1353tsE8YMTA4EuV7dgUXGjNFf9KpVvKHz\"]"<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "sendmany", "params": ["", {"1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX":0.01,"1353tsE8YMTA4EuV7dgUXGjNFf9KpVvKHz":0.02}, 6, "testing"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>sendtoaddress "address" amount ( "comment" "comment_to" subtractfeefromamount replaceable conf_target "estimate_mode" avoid_reuse )</summary><p>
sendtoaddress "address" amount ( "comment" "comment_to" subtractfeefromamount replaceable conf_target "estimate_mode" avoid_reuse )<br>
<br>
Send an amount to a given address.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. address                  (string, required) The defi address to send to.<br>
2. amount                   (numeric or string, required) The amount in DFI to send. eg 0.1<br>
3. comment                  (string, optional) A comment used to store what the transaction is for.<br>
                            This is not part of the transaction, just kept in your wallet.<br>
4. comment_to               (string, optional) A comment to store the name of the person or organization<br>
                            to which you're sending the transaction. This is not part of the <br>
                            transaction, just kept in your wallet.<br>
5. subtractfeefromamount    (boolean, optional, default=false) The fee will be deducted from the amount being sent.<br>
                            The recipient will receive less defis than you enter in the amount field.<br>
6. replaceable              (boolean, optional, default=wallet default) Allow this transaction to be replaced by a transaction with higher fees via BIP 125<br>
7. conf_target              (numeric, optional, default=wallet default) Confirmation target (in blocks)<br>
8. estimate_mode            (string, optional, default=UNSET) The fee estimate mode, must be one of:<br>
                            "UNSET"<br>
                            "ECONOMICAL"<br>
                            "CONSERVATIVE"<br>
9. avoid_reuse              (boolean, optional, default=true) (only available if avoid_reuse wallet flag is set) Avoid spending from dirty addresses; addresses are considered<br>
                            dirty if they have previously been used in a transaction.<br>
<br>
Result:<br>
"hash"                  (string) The hex-encoded hash of broadcasted transaction<br>
<br>
Examples:<br>
> defi-cli sendtoaddress "1M72Sfpbz1BPpXFHz9m3CdqATR44Jvaydd" 0.1<br>
> defi-cli sendtoaddress "1M72Sfpbz1BPpXFHz9m3CdqATR44Jvaydd" 0.1 "donation" "seans outpost"<br>
> defi-cli sendtoaddress "1M72Sfpbz1BPpXFHz9m3CdqATR44Jvaydd" 0.1 "" "" true<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "sendtoaddress", "params": ["1M72Sfpbz1BPpXFHz9m3CdqATR44Jvaydd", 0.1, "donation", "seans outpost"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>sethdseed ( newkeypool "seed" )</summary><p>
sethdseed ( newkeypool "seed" )<br>
<br>
Set or generate a new HD wallet seed. Non-HD wallets will not be upgraded to being a HD wallet. Wallets that are already<br>
HD will have a new HD seed set so that new keys added to the keypool will be derived from this new seed.<br>
<br>
Note that you will need to MAKE A NEW BACKUP of your wallet after setting the HD wallet seed.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. newkeypool    (boolean, optional, default=true) Whether to flush old unused addresses, including change addresses, from the keypool and regenerate it.<br>
                 If true, the next address from getnewaddress and change address from getrawchangeaddress will be from this new seed.<br>
                 If false, addresses (including change addresses if the wallet already had HD Chain Split enabled) from the existing<br>
                 keypool will be used until it has been depleted.<br>
2. seed          (string, optional, default=random seed) The WIF private key to use as the new HD seed.<br>
                 The seed value can be retrieved using the dumpwallet command. It is the private key marked hdseed=1<br>
<br>
Examples:<br>
> defi-cli sethdseed <br>
> defi-cli sethdseed false<br>
> defi-cli sethdseed true "wifkey"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "sethdseed", "params": [true, "wifkey"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>setlabel "address" "label"</summary><p>
setlabel "address" "label"<br>
<br>
Sets the label associated with the given address.<br>
<br>
Arguments:<br>
1. address    (string, required) The defi address to be associated with a label.<br>
2. label      (string, required) The label to assign to the address.<br>
<br>
Examples:<br>
> defi-cli setlabel "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX" "tabby"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "setlabel", "params": ["1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX", "tabby"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>settxfee amount</summary><p>
settxfee amount<br>
<br>
Set the transaction fee per kB for this wallet. Overrides the global -paytxfee command line parameter.<br>
<br>
Arguments:<br>
1. amount    (numeric or string, required) The transaction fee in DFI/kB<br>
<br>
Result:<br>
true|false        (boolean) Returns true if successful<br>
<br>
Examples:<br>
> defi-cli settxfee 0.00001<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "settxfee", "params": [0.00001] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>setwalletflag "flag" ( value )</summary><p>
setwalletflag "flag" ( value )<br>
<br>
Change the state of the given wallet flag for a wallet.<br>
<br>
Arguments:<br>
1. flag     (string, required) The name of the flag to change. Current available flags: avoid_reuse<br>
2. value    (boolean, optional, default=true) The new state.<br>
<br>
Result:<br>
{<br>
    "flag_name": string   (string) The name of the flag that was modified<br>
    "flag_state": bool    (bool) The new state of the flag<br>
    "warnings": string    (string) Any warnings associated with the change<br>
}<br>
<br>
Examples:<br>
> defi-cli setwalletflag avoid_reuse<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "setwalletflag", "params": ["avoid_reuse"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>signmessage "address" "message"</summary><p>
signmessage "address" "message"<br>
<br>
Sign a message with the private key of an address<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. address    (string, required) The defi address to use for the private key.<br>
2. message    (string, required) The message to create a signature of.<br>
<br>
Result:<br>
"signature"          (string) The signature of the message encoded in base 64<br>
<br>
Examples:<br>
<br>
Unlock the wallet for 30 seconds<br>
> defi-cli walletpassphrase "mypassphrase" 30<br>
<br>
Create the signature<br>
> defi-cli signmessage "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX" "my message"<br>
<br>
Verify the signature<br>
> defi-cli verifymessage "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX" "signature" "my message"<br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "signmessage", "params": ["1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX", "my message"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>signrawtransactionwithwallet "hexstring" ( [{"txid":"hex","vout":n,"scriptPubKey":"hex","redeemScript":"hex","witnessScript":"hex","amount":amount},...] "sighashtype" )</summary><p>
signrawtransactionwithwallet "hexstring" ( [{"txid":"hex","vout":n,"scriptPubKey":"hex","redeemScript":"hex","witnessScript":"hex","amount":amount},...] "sighashtype" )<br>
<br>
Sign inputs for raw transaction (serialized, hex-encoded).<br>
The second optional argument (may be null) is an array of previous transaction outputs that<br>
this transaction depends on but may not yet be in the block chain.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. hexstring                        (string, required) The transaction hex string<br>
2. prevtxs                          (json array, optional) A json array of previous dependent transaction outputs<br>
     [<br>
       {                            (json object)<br>
         "txid": "hex",             (string, required) The transaction id<br>
         "vout": n,                 (numeric, required) The output number<br>
         "scriptPubKey": "hex",     (string, required) script key<br>
         "redeemScript": "hex",     (string) (required for P2SH) redeem script<br>
         "witnessScript": "hex",    (string) (required for P2WSH or P2SH-P2WSH) witness script<br>
         "amount": amount,          (numeric or string) (required for Segwit inputs) the amount spent<br>
       },<br>
       ...<br>
     ]<br>
3. sighashtype                      (string, optional, default=ALL) The signature hash type. Must be one of<br>
                                    "ALL"<br>
                                    "NONE"<br>
                                    "SINGLE"<br>
                                    "ALL|ANYONECANPAY"<br>
                                    "NONE|ANYONECANPAY"<br>
                                    "SINGLE|ANYONECANPAY"<br>
<br>
Result:<br>
{<br>
  "hex" : "value",                  (string) The hex-encoded raw transaction with signature(s)<br>
  "complete" : true|false,          (boolean) If the transaction has a complete set of signatures<br>
  "errors" : [                      (json array of objects) Script verification errors (if there are any)<br>
    {<br>
      "txid" : "hash",              (string) The hash of the referenced, previous transaction<br>
      "vout" : n,                   (numeric) The index of the output to spent and used as input<br>
      "scriptSig" : "hex",          (string) The hex-encoded signature script<br>
      "sequence" : n,               (numeric) Script sequence number<br>
      "error" : "text"              (string) Verification or signing error related to the input<br>
    }<br>
    ,...<br>
  ]<br>
}<br>
<br>
Examples:<br>
> defi-cli signrawtransactionwithwallet "myhex"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "signrawtransactionwithwallet", "params": ["myhex"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>unloadwallet ( "wallet_name" )</summary><p>
unloadwallet ( "wallet_name" )<br>
Unloads the wallet referenced by the request endpoint otherwise unloads the wallet specified in the argument.<br>
Specifying the wallet name on a wallet endpoint is invalid.<br>
Arguments:<br>
1. wallet_name    (string, optional, default=the wallet name from the RPC request) The name of the wallet to unload.<br>
<br>
Examples:<br>
> defi-cli unloadwallet wallet_name<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "unloadwallet", "params": [wallet_name] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>walletcreatefundedpsbt [{"txid":"hex","vout":n,"sequence":n},...] [{"address":amount},{"data":"hex"},...] ( locktime options bip32derivs )</summary><p>
walletcreatefundedpsbt [{"txid":"hex","vout":n,"sequence":n},...] [{"address":amount},{"data":"hex"},...] ( locktime options bip32derivs )<br>
<br>
Creates and funds a transaction in the Partially Signed Transaction format. Inputs will be added if supplied inputs are not enough<br>
Implements the Creator and Updater roles.<br>
<br>
Arguments:<br>
1. inputs                             (json array, required) A json array of json objects<br>
     [<br>
       {                              (json object)<br>
         "txid": "hex",               (string, required) The transaction id<br>
         "vout": n,                   (numeric, required) The output number<br>
         "sequence": n,               (numeric, required) The sequence number<br>
       },<br>
       ...<br>
     ]<br>
2. outputs                            (json array, required) a json array with outputs (key-value pairs), where none of the keys are duplicated.<br>
                                      That is, each address can only appear once and there can only be one 'data' object.<br>
                                      For compatibility reasons, a dictionary, which holds the key-value pairs directly, is also<br>
                                      accepted as second parameter.<br>
     [<br>
       {                              (json object)<br>
         "address": amount,           (numeric or string, required) A key-value pair. The key (string) is the defi address, the value (float or string) is the amount in DFI<br>
       },<br>
       {                              (json object)<br>
         "data": "hex",               (string, required) A key-value pair. The key must be "data", the value is hex-encoded data<br>
       },<br>
       ...<br>
     ]<br>
3. locktime                           (numeric, optional, default=0) Raw locktime. Non-0 value also locktime-activates inputs<br>
4. options                            (json object, optional)<br>
     {<br>
       "changeAddress": "hex",        (string, optional, default=pool address) The defi address to receive the change<br>
       "changePosition": n,           (numeric, optional, default=random) The index of the change output<br>
       "change_type": "str",          (string, optional, default=set by -changetype) The output type to use. Only valid if changeAddress is not specified. Options are "legacy", "p2sh-segwit", and "bech32".<br>
       "includeWatching": bool,       (boolean, optional, default=true for watch-only wallets, otherwise false) Also select inputs which are watch only<br>
       "lockUnspents": bool,          (boolean, optional, default=false) Lock selected unspent outputs<br>
       "feeRate": amount,             (numeric or string, optional, default=not set: makes wallet determine the fee) Set a specific fee rate in DFI/kB<br>
       "subtractFeeFromOutputs": [    (json array, optional, default=empty array) A json array of integers.<br>
                                      The fee will be equally deducted from the amount of each specified output.<br>
                                      Those recipients will receive less defis than you enter in their corresponding amount field.<br>
                                      If no outputs are specified here, the sender pays the fee.<br>
         vout_index,                  (numeric) The zero-based output index, before a change output is added.<br>
         ...<br>
       ],<br>
       "replaceable": bool,           (boolean, optional, default=wallet default) Marks this transaction as BIP125 replaceable.<br>
                                      Allows this transaction to be replaced by a transaction with higher fees<br>
       "conf_target": n,              (numeric, optional, default=Fallback to wallet's confirmation target) Confirmation target (in blocks)<br>
       "estimate_mode": "str",        (string, optional, default=UNSET) The fee estimate mode, must be one of:<br>
                                      "UNSET"<br>
                                      "ECONOMICAL"<br>
                                      "CONSERVATIVE"<br>
     }<br>
5. bip32derivs                        (boolean, optional, default=false) If true, includes the BIP 32 derivation paths for public keys if we know them<br>
<br>
Result:<br>
{<br>
  "psbt": "value",        (string)  The resulting raw transaction (base64-encoded string)<br>
  "fee":       n,         (numeric) Fee in DFI the resulting transaction pays<br>
  "changepos": n          (numeric) The position of the added change output, or -1<br>
}<br>
<br>
Examples:<br>
<br>
Create a transaction with no inputs<br>
> defi-cli walletcreatefundedpsbt "[{\"txid\":\"myid\",\"vout\":0}]" "[{\"data\":\"00010203\"}]"<br>

</p></details>

<details><summary>walletlock</summary><p>
walletlock<br>
<br>
Removes the wallet encryption key from memory, locking the wallet.<br>
After calling this method, you will need to call walletpassphrase again<br>
before being able to call any methods which require the wallet to be unlocked.<br>
<br>
Examples:<br>
<br>
Set the passphrase for 2 minutes to perform a transaction<br>
> defi-cli walletpassphrase "my pass phrase" 120<br>
<br>
Perform a send (requires passphrase set)<br>
> defi-cli sendtoaddress "1M72Sfpbz1BPpXFHz9m3CdqATR44Jvaydd" 1.0<br>
<br>
Clear the passphrase since we are done before 2 minutes is up<br>
> defi-cli walletlock <br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "walletlock", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>walletpassphrase "passphrase" timeout</summary><p>
walletpassphrase "passphrase" timeout<br>
<br>
Stores the wallet decryption key in memory for 'timeout' seconds.<br>
This is needed prior to performing transactions related to private keys such as sending defis<br>
<br>
Note:<br>
Issuing the walletpassphrase command while the wallet is already unlocked will set a new unlock<br>
time that overrides the old one.<br>
<br>
Arguments:<br>
1. passphrase    (string, required) The wallet passphrase<br>
2. timeout       (numeric, required) The time to keep the decryption key in seconds; capped at 100000000 (~3 years).<br>
<br>
Examples:<br>
<br>
Unlock the wallet for 60 seconds<br>
> defi-cli walletpassphrase "my pass phrase" 60<br>
<br>
Lock the wallet again (before 60 seconds)<br>
> defi-cli walletlock <br>
<br>
As a JSON-RPC call<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "walletpassphrase", "params": ["my pass phrase", 60] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>walletpassphrasechange "oldpassphrase" "newpassphrase"</summary><p>
walletpassphrasechange "oldpassphrase" "newpassphrase"<br>
<br>
Changes the wallet passphrase from 'oldpassphrase' to 'newpassphrase'.<br>
<br>
Arguments:<br>
1. oldpassphrase    (string, required) The current passphrase<br>
2. newpassphrase    (string, required) The new passphrase<br>
<br>
Examples:<br>
> defi-cli walletpassphrasechange "old one" "new one"<br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "walletpassphrasechange", "params": ["old one", "new one"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

<details><summary>walletprocesspsbt "psbt" ( sign "sighashtype" bip32derivs )</summary><p>
walletprocesspsbt "psbt" ( sign "sighashtype" bip32derivs )<br>
<br>
Update a PSBT with input information from our wallet and then sign inputs<br>
that we can sign for.<br>
Requires wallet passphrase to be set with walletpassphrase call.<br>
<br>
Arguments:<br>
1. psbt           (string, required) The transaction base64 string<br>
2. sign           (boolean, optional, default=true) Also sign the transaction when updating<br>
3. sighashtype    (string, optional, default=ALL) The signature hash type to sign with if not specified by the PSBT. Must be one of<br>
                  "ALL"<br>
                  "NONE"<br>
                  "SINGLE"<br>
                  "ALL|ANYONECANPAY"<br>
                  "NONE|ANYONECANPAY"<br>
                  "SINGLE|ANYONECANPAY"<br>
4. bip32derivs    (boolean, optional, default=false) If true, includes the BIP 32 derivation paths for public keys if we know them<br>
<br>
Result:<br>
{<br>
  "psbt" : "value",          (string) The base64-encoded partially signed transaction<br>
  "complete" : true|false,   (boolean) If the transaction has a complete set of signatures<br>
  ]<br>
}<br>
<br>
Examples:<br>
> defi-cli walletprocesspsbt "psbt"<br>

</p></details>

## Zmq
<details><summary>getzmqnotifications</summary><p>
getzmqnotifications<br>
<br>
Returns information about the active ZeroMQ notifications.<br>
<br>
Result:<br>
[<br>
  {                        (json object)<br>
    "type": "pubhashtx",   (string) Type of notification<br>
    "address": "...",      (string) Address of the publisher<br>
    "hwm": n                 (numeric) Outbound message high water mark<br>
  },<br>
  ...<br>
]<br>
<br>
Examples:<br>
> defi-cli getzmqnotifications <br>
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getzmqnotifications", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/<br>

</p></details>

