DeFi Blockchain RPC client version v4.1.9

[Accounts](#Accounts)
[Blockchain](#Blockchain)
[Control](#Control)
[Evm](#Evm)
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
<details><summary>accounthistorycount ( "owner" {"no_rewards":bool,"token":"str","txtype":"str","txtypes":["Transaction Type",...]} )</summary><p>
accounthistorycount ( "owner" {"no_rewards":bool,"token":"str","txtype":"str","txtypes":["Transaction Type",...]} )  
  
Returns count of account history.  
  
Arguments:  
1. owner                        (string) Single account ID (CScript or address) or reserved words: "mine" - to list history for all owned accounts or "all" to list whole DB (default = "mine").  
2. options                      (json object)  
     {  
       "no_rewards": bool,      (boolean) Filter out rewards  
       "token": "str",          (string) Filter by token  
       "txtype": "str",         (string) Filter by transaction type, supported letter from {CustomTxType}  
       "txtypes": [             (json array) Filter multiple transaction types, supported letter from {CustomTxType}  
         "Transaction Type",    (string) letter from {CustomTxType}  
         ...  
       ],  
     }  
  
Result:  
count     (int) Count of account history  
  
Examples:  
> defi-cli accounthistorycount all '{no_rewards: true}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "accounthistorycount", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>accounttoaccount "from" {"address":"str"} ( [{"txid":"hex","vout":n},...] )</summary><p>
accounttoaccount "from" {"address":"str"} ( [{"txid":"hex","vout":n},...] )  
  
Creates (and submits to local node and network) a transfer transaction from the specified account to the specfied accounts.  
The first optional argument (may be empty array) is an array of specific UTXOs to spend.  
  
Arguments:  
1. from                     (string, required) The defi address of sender  
2. to                       (json object, required)  
     {  
       "address": "str",    (string, required) The defi address is the key, the value is amount in amount@token format. If multiple tokens are to be transferred, specify an array ["amount1@t1", "amount2@t2"]  
     }  
3. inputs                   (json array, optional) A json array of json objects  
     [  
       {                    (json object)  
         "txid": "hex",     (string, required) The transaction id  
         "vout": n,         (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli accounttoaccount sender_address '{"address1":"1.0@DFI","address2":["2.0@BTC", "3.0@ETH"]}' '[]'  

</p></details>

<details><summary>accounttoutxos "from" {"address":"str"} ( [{"txid":"hex","vout":n},...] )</summary><p>
accounttoutxos "from" {"address":"str"} ( [{"txid":"hex","vout":n},...] )  
  
Creates (and submits to local node and network) a transfer transaction from the specified account to UTXOs.  
The third optional argument (may be empty array) is an array of specific UTXOs to spend.  
  
Arguments:  
1. from                     (string, required) The defi address of sender  
2. to                       (json object, required)  
     {  
       "address": "str",    (string, required) The defi address is the key, the value is amount in amount@token format. If multiple tokens are to be transferred, specify an array ["amount1@t1", "amount2@t2"]  
     }  
3. inputs                   (json array, optional) A json array of json objects  
     [  
       {                    (json object)  
         "txid": "hex",     (string, required) The transaction id  
         "vout": n,         (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli accounttoutxos sender_address '{"address1":"100@DFI"}' '[]'  
> defi-cli accounttoutxos sender_address '{"address1":"1.0@DFI","address2":["2.0@BTC", "3.0@ETH"]}' '[]'  

</p></details>

<details><summary>executesmartcontract "name" "amount" ( "address" [{"txid":"hex","vout":n},...] )</summary><p>
executesmartcontract "name" "amount" ( "address" [{"txid":"hex","vout":n},...] )  
  
Creates and sends a transaction to either fund or execute a smart contract. Available contracts: dbtcdfiswap  
  
Arguments:  
1. name                    (string, required) Name of the smart contract to send funds to  
2. amount                  (string, required) Amount to send in amount@token format  
3. address                 (string) Address to be used in contract execution if required  
4. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli executesmartcontract dbtcdfiswap 1000@DFI  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "executesmartcontract", "params": [dbtcdfiswap, 1000@DFI] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>futureswap "address" "amount" ( "destination" [{"txid":"hex","vout":n},...] )</summary><p>
futureswap "address" "amount" ( "destination" [{"txid":"hex","vout":n},...] )  
  
Creates and submits to the network a futures contract  
  
Arguments:  
1. address                 (string, required) Address to fund contract and receive resulting token  
2. amount                  (string, required) Amount to send in amount@token format  
3. destination             (string, optional) Expected dToken if DUSD supplied  
4. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli futureswap dLb2jq51qkaUbVkLyCiVQCoEHzRSzRPEsJ 1000@TSLA  
> defi-cli futureswap dLb2jq51qkaUbVkLyCiVQCoEHzRSzRPEsJ 1000@DUSD TSLA  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "futureswap", "params": [dLb2jq51qkaUbVkLyCiVQCoEHzRSzRPEsJ, 1000@TSLA] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "futureswap", "params": [dLb2jq51qkaUbVkLyCiVQCoEHzRSzRPEsJ, 1000@DUSD, TSLA] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getaccount "owner" ( {"start":"str","including_start":bool,"limit":n} indexed_amounts )</summary><p>
getaccount "owner" ( {"start":"str","including_start":bool,"limit":n} indexed_amounts )  
  
Returns information about account.  
  
Arguments:  
1. owner                           (string, required) Owner address in base58/bech32/hex encoding  
2. pagination                      (json object)  
     {  
       "start": "str",             (string) Optional first key to iterate from, in lexicographical order.Typically it's set to last tokenID from previous request.  
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default  
       "limit": n,                 (numeric) Maximum number of orders to return, 100 by default  
     }  
3. indexed_amounts                 (boolean) Format of amounts output (default = false): (true: obj = {tokenid:amount,...}, false: array = ["amount@tokenid"...])  
  
Result:  
{...}     (array) Json object with order information  
  
Examples:  
> defi-cli getaccount owner_address  

</p></details>

<details><summary>getaccounthistory "owner" blockHeight txn</summary><p>
getaccounthistory "owner" blockHeight txn  
  
Returns information about account history.  
  
Arguments:  
1. owner          (string, required) Single account ID (CScript or address).  
2. blockHeight    (numeric, required) Block Height to search in.  
3. txn            (numeric, required) for order in block.  
  
Result:  
{}  An object with account history information  
  
Examples:  
> defi-cli getaccounthistory mxxA2sQMETJFbXcNbNbUzEsBCTn1JSHXST 103 2  
> defi-cli getaccounthistory mxxA2sQMETJFbXcNbNbUzEsBCTn1JSHXST, 103, 2  

</p></details>

<details><summary>getburninfo</summary><p>
getburninfo  
  
Returns burn address and burnt coin and token information.  
Requires full acindex for correct amount, tokens and feeburn values.  
  
Result:  
{  
  "address" : "address",        (string) The defi burn address  
  "amount" : n.nnnnnnnn,        (string) The amount of DFI burnt  
  "tokens" :  [  
      { (array of burnt tokens)      "name" : "name"  
      "amount" : n.nnnnnnnn  
    ]  
  "feeburn" : n.nnnnnnnn,        (string) The amount of fees burnt  
  "emissionburn" : n.nnnnnnnn,   (string) The amount of non-utxo coinbase rewards burnt  
}  
  
Examples:  
> defi-cli getburninfo   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getburninfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getlockedtokens "address"</summary><p>
getlockedtokens "address"  
  
Get specific locked tokens.  
  
Arguments:  
1. address    (string, required) Address to get all locked tokens  
  
Result:  
["amount1@token1","amount1@token1"...]  
  
Examples:  
> defi-cli getlockedtokens address  

</p></details>

<details><summary>getpendingdusdswaps "address"</summary><p>
getpendingdusdswaps "address"  
Get specific pending DFI-to-DUSD swap.  
  
Arguments:  
1. address    (string, required) Address to get all pending future swaps  
  
Result:  
{  
    owner :       "address"  
    amount :      n.nnnnnnnn  
}  
  
Examples:  
> defi-cli getpendingfutureswaps address  

</p></details>

<details><summary>getpendingfutureswaps "address"</summary><p>
getpendingfutureswaps "address"  
Get specific pending futures.  
  
Arguments:  
1. address    (string, required) Address to get all pending future swaps  
  
Result:  
{  
    owner :       "address"  
    values : [{  
    tokenSymbol : "SYMBOL"  
    amount :      n.nnnnnnnn  
    destination : "SYMBOL"  
    }...]  
}  
  
Examples:  
> defi-cli getpendingfutureswaps address  

</p></details>

<details><summary>gettokenbalances ( {"start":"str","including_start":bool,"limit":n} indexed_amounts symbol_lookup evm )</summary><p>
gettokenbalances ( {"start":"str","including_start":bool,"limit":n} indexed_amounts symbol_lookup evm )  
  
Returns the balances of all accounts that belong to the wallet.  
  
Arguments:  
1. pagination                      (json object)  
     {  
       "start": "str",             (string) Optional first key to iterate from, in lexicographical order.Typically it's set to last tokenID from previous request.  
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default  
       "limit": n,                 (numeric) Maximum number of tokens to return, 100 by default  
     }  
2. indexed_amounts                 (boolean) Format of amounts output (default = false): (true: obj = {tokenid:amount,...}, false: array = ["amount@tokenid"...])  
3. symbol_lookup                   (boolean) Use token symbols in output (default = false)  
4. evm                             (boolean) Include DFI balances in the EVM layer (default = false): Note: This does not include DST20 tokens  
  
Result:  
{...}     (array) Json object with balances information  
  
Examples:  
> defi-cli gettokenbalances   

</p></details>

<details><summary>listaccounthistory ( "owner" {"maxBlockHeight":n,"depth":n,"no_rewards":bool,"token":"str","txtype":"str","txtypes":["Transaction Type",...],"limit":n,"start":n,"including_start":bool,"txn":n,"format":"str"} )</summary><p>
listaccounthistory ( "owner" {"maxBlockHeight":n,"depth":n,"no_rewards":bool,"token":"str","txtype":"str","txtypes":["Transaction Type",...],"limit":n,"start":n,"including_start":bool,"txn":n,"format":"str"} )  
  
Returns information about account history.  
  
Arguments:  
1. owner                           (string) Single account ID (CScript or address) or reserved words: "mine" - to list history for all owned accounts or "all" to list whole DB (default = "mine").  
2. options                         (json object)  
     {  
       "maxBlockHeight": n,        (numeric) Optional height to iterate from (downto genesis block), (default = chaintip).  
       "depth": n,                 (numeric) Maximum depth, from the genesis block is the default  
       "no_rewards": bool,         (boolean) Filter out rewards  
       "token": "str",             (string) Filter by token  
       "txtype": "str",            (string) Filter by transaction type, supported letter from {CustomTxType}. Ignored if txtypes is provided  
       "txtypes": [                (json array) Filter multiple transaction types, supported letter from {CustomTxType}  
         "Transaction Type",       (string) letter from {CustomTxType}  
         ...  
       ],  
       "limit": n,                 (numeric) Maximum number of records to return, 100 by default  
       "start": n,                 (numeric) Number of entries to skip  
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default  
       "txn": n,                   (numeric) Order in block, unlimited by default  
       "format": "str",            (string) Return amounts with the following: 'id' -> <amount>@id; (default)'symbol' -> <amount>@symbol  
     }  
  
Result:  
[{},{}...]     (array) Objects with account history information  
  
Examples:  
> defi-cli listaccounthistory all '{"maxBlockHeight":160,"depth":10}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listaccounthistory", "params": [address false] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listaccounts ( {"start":"str","including_start":bool,"limit":n} verbose indexed_amounts is_mine_only )</summary><p>
listaccounts ( {"start":"str","including_start":bool,"limit":n} verbose indexed_amounts is_mine_only )  
  
Returns information about all accounts on chain.  
  
Arguments:  
1. pagination                      (json object)  
     {  
       "start": "str",             (string) Optional first key to iterate from, in lexicographical order.Typically it's set to last ID from previous request.  
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default  
       "limit": n,                 (numeric) Maximum number of orders to return, 100 by default  
     }  
2. verbose                         (boolean) Flag for verbose list (default = true), otherwise limited objects are listed  
3. indexed_amounts                 (boolean) Format of amounts output (default = false): (true: {tokenid:amount}, false: "amount@tokenid")  
4. is_mine_only                    (boolean) Get balances about all accounts belonging to the wallet  
  
Result:  
{id:{...},...}     (array) Json object with accounts information  
  
Examples:  
> defi-cli listaccounts   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listaccounts", "params": ['{}' false] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listaccounts", "params": ['{"start":"a914b12ecde1759f792e0228e4fa6d262902687ca7eb87@0","limit":100}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listburnhistory ( {"maxBlockHeight":n,"depth":n,"token":"str","txtype":"str","limit":n} )</summary><p>
listburnhistory ( {"maxBlockHeight":n,"depth":n,"token":"str","txtype":"str","limit":n} )  
  
Returns information about burn history.  
  
Arguments:  
1. options                     (json object)  
     {  
       "maxBlockHeight": n,    (numeric) Optional height to iterate from (down to genesis block), (default = chaintip).  
       "depth": n,             (numeric) Maximum depth, from the genesis block is the default  
       "token": "str",         (string) Filter by token  
       "txtype": "str",        (string) Filter by transaction type, supported letter from {CustomTxType}  
       "limit": n,             (numeric) Maximum number of records to return, 100 by default  
     }  
  
Result:  
[{},{}...]     (array) Objects with burn history information  
  
Examples:  
> defi-cli listburnhistory '{"maxBlockHeight":160,"depth":10}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listburnhistory", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listcommunitybalances</summary><p>
listcommunitybalances  
  
Returns information about all community balances.  
  
Result:  
{balance_type:value,...}     (array) Json object with accounts information  
  
Examples:  
> defi-cli listcommunitybalances   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listcommunitybalances", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listlockedtokens</summary><p>
listlockedtokens  
Get all locked loan tokens.  
  
Result:  
"json"      (string) array containing json-objects having following fields:  
    owner  :  "address"  
    values : ["amount1@token1","amount1@token1"...]  
  
Examples:  
> defi-cli listlockedtokens   

</p></details>

<details><summary>listpendingdusdswaps</summary><p>
listpendingdusdswaps  
Get all pending DFI-to_DUSD swaps.  
  
Result:  
"json"          (string) array containing json-objects having following fields:  
[{  
    owner :       "address"  
    amount :      n.nnnnnnnn  
}...]  
  
Examples:  
> defi-cli listpendingdusdswaps   

</p></details>

<details><summary>listpendingfutureswaps</summary><p>
listpendingfutureswaps  
Get all pending futures.  
  
Result:  
"json"          (string) array containing json-objects having following fields:  
    owner :       "address"  
    values : [{  
        tokenSymbol : "SYMBOL"  
        amount :      n.nnnnnnnn  
        destination : "SYMBOL"  
    }...]  
  
Examples:  
> defi-cli listpendingfutureswaps   

</p></details>

<details><summary>releaselockedtokens releasePart ( [{"txid":"hex","vout":n},...] )</summary><p>
releaselockedtokens releasePart ( [{"txid":"hex","vout":n},...] )  
  
releases a tranche of locked loan tokens  
  
Arguments:  
1. releasePart             (numeric, required) Percentagepoints to be released  
2. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli releaselockedtokens 3  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "releaselockedtokens", "params": [1.23] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>sendtokenstoaddress {"address":"str"} {"address":"str"} ( "selectionMode" )</summary><p>
sendtokenstoaddress {"address":"str"} {"address":"str"} ( "selectionMode" )  
  
Creates (and submits to local node and network) a transfer transaction from your accounts balances (may be picked manualy or autoselected) to the specfied accounts.  
  
  
Arguments:  
1. from                     (json object, required)  
     {  
       "address": "str",    (string) The source defi address is the key, the value is amount in amount@token format. If obj is empty (no address keys exists) then will try to auto-select accounts from wallet with necessary balances to transfer.  
     }  
2. to                       (json object, required)  
     {  
       "address": "str",    (string, required) The defi address is the key, the value is amount in amount@token format. If multiple tokens are to be transferred, specify an array ["amount1@t1", "amount2@t2"]  
     }  
3. selectionMode            (string, optional, default=pie) If param "from" is empty this param indicates accounts autoselection mode.May be once of:  
                            "forward" - Selecting accounts without sorting, just as address list sorted.  
                            "crumbs" - Selecting accounts by ascending of sum token amounts.  
                            It means that we will select first accounts with minimal sum of neccessary token amounts.  
                            "pie" - Selecting accounts by descending of sum token amounts.  
                            It means that we will select first accounts with maximal sum of neccessary token amounts.  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli sendtokenstoaddress '{}' '{"dstAddress1":"1.0@DFI","dstAddress2":["2.0@BTC", "3.0@ETH"]}' "crumbs"  
> defi-cli sendtokenstoaddress '{"srcAddress1":"2.0@DFI", "srcAddress2":["3.0@DFI", "2.0@ETH"]}' '{"dstAddress1":["5.0@DFI", "2.0@ETH"]}'  

</p></details>

<details><summary>sendutxosfrom "from" "to" amount ( "change" )</summary><p>
sendutxosfrom "from" "to" amount ( "change" )  
  
Send a transaction using UTXOs from the specfied address.  
  
  
Arguments:  
1. from      (string, required) The address of sender  
2. to        (string, required) The address of receiver  
3. amount    (numeric, required) The amount to send  
4. change    (string) The address to send change to (Default: from address)  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli sendutxosfrom "from" "to" 100  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "sendutxosfrom", "params": ["from", "to", 100"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>transferdomain [{"src":obj,"dst":obj,"nonce":n,"singlekeycheck":bool},...]</summary><p>
transferdomain [{"src":obj,"dst":obj,"nonce":n,"singlekeycheck":bool},...]  
Creates (and submits to local node and network) a tx to transfer assets across domains. DVM to EVM/EVM to DVM, etc.  
  
  
Arguments:  
1. array                            (json array, required) A json array of src and dst json objects  
     [  
       {                            (json object)  
         "src": {                   (json object) Source arguments  
           "address": "str",        (string, required) Source address  
           "amount": "str",         (string, required) Amount transfered, the value is amount in amount@token format  
           "domain": n,             (numeric, required) Domain of source: 2 - DVM, 3 - EVM  
         },  
         "dst": {                   (json object) Destination arguments  
           "address": "str",        (string, required) Destination address  
           "amount": "str",         (string, required) Amount transfered, the value is amount in amount@token format  
           "domain": n,             (numeric, required) Domain of source: 2 - DVM, 3 - EVM  
         },  
         "nonce": n,                (numeric) Optional parameter to specify the transaction nonce  
         "singlekeycheck": bool,    (boolean) Optional flag to ensure single key check between the corresponding address types (default = true)  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli transferdomain '[{"src":{"address":"<DFI_address>", "amount":"1.0@DFI", "domain": 2}, "dst":{"address":"<ETH_address>", "amount":"1.0@DFI", "domain": 3}}]'  
> defi-cli transferdomain '[{"src":{"address":"<ETH_address>", "amount":"1.0@DFI", "domain": 3}, "dst":{"address":"<DFI_address>", "amount":"1.0@DFI", "domain": 2}}]'  

</p></details>

<details><summary>utxostoaccount {"address":"str"} ( [{"txid":"hex","vout":n},...] )</summary><p>
utxostoaccount {"address":"str"} ( [{"txid":"hex","vout":n},...] )  
  
Creates (and submits to local node and network) a transfer transaction from the wallet UTXOs to specfied account.  
The second optional argument (may be empty array) is an array of specific UTXOs to spend.  
  
Arguments:  
1. amounts                  (json object, required)  
     {  
       "address": "str",    (string, required) The defi address is the key, the value is amount in amount@token format. If multiple tokens are to be transferred, specify an array ["amount1@t1", "amount2@t2"]  
     }  
2. inputs                   (json array, optional) A json array of json objects  
     [  
       {                    (json object)  
         "txid": "hex",     (string, required) The transaction id  
         "vout": n,         (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli utxostoaccount '{"address1":"1.0@DFI","address2":["2.0@BTC", "3.0@ETH"]}' '[]'  

</p></details>

<details><summary>withdrawfutureswap "address" "amount" ( "destination" [{"txid":"hex","vout":n},...] )</summary><p>
withdrawfutureswap "address" "amount" ( "destination" [{"txid":"hex","vout":n},...] )  
  
Creates and submits to the network a withdrawal from futures contract transaction.  
 Withdrawal will be back to the address specified in the futures contract.  
  
Arguments:  
1. address                 (string, required) Address used to fund contract with  
2. amount                  (string, required) Amount to withdraw in amount@token format  
3. destination             (string, optional) The dToken if DUSD supplied  
4. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli withdrawfutureswap dLb2jq51qkaUbVkLyCiVQCoEHzRSzRPEsJ 1000@TSLA  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "withdrawfutureswap", "params": [dLb2jq51qkaUbVkLyCiVQCoEHzRSzRPEsJ, 1000@TSLA] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

## Blockchain
<details><summary>cleargovheights ( [{"txid":"hex","vout":n},...] )</summary><p>
cleargovheights ( [{"txid":"hex","vout":n},...] )  
  
Clear all pending setgovheight and unsetgovheight changes  
  
Arguments:  
1. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "cleargovheights", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>clearmempool</summary><p>
clearmempool  
  
Clears the memory pool and returns a list of the removed transactions.  
  
Result:  
[                     (json array of string)  
  "hash"              (string) The transaction hash  
  ,...  
]  
  
Examples:  
> defi-cli clearmempool   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "clearmempool", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getbestblockhash</summary><p>
getbestblockhash  
  
Returns the hash of the best (tip) block in the most-work fully-validated chain.  
  
Result:  
"hex"      (string) the block hash, hex-encoded  
  
Examples:  
> defi-cli getbestblockhash   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getbestblockhash", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getblock "blockhash" ( verbosity )</summary><p>
getblock "blockhash" ( verbosity )  
  
If verbosity is 0, returns a string that is serialized, hex-encoded data for block 'hash'.  
If verbosity is 1, returns an Object with information about block <hash>.  
If verbosity is 2, returns an Object with information about block <hash> and information about each transaction.   
If verbosity is 3, returns an Object with version 2 API (DVM, EVM, etc).   
If verbosity is 4, returns an Object with version 2 API (DVM, EVM, etc with Hex)   
  
Arguments:  
1. blockhash    (string, required) The block hash  
2. verbosity    (numeric, optional, default=1) 0 for hex-encoded data, 1 for a json object, and 2 for json object with transaction data  
  
Result (for verbosity = 0):  
"data"             (string) A string that is serialized, hex-encoded data for block 'hash'.  
  
Result (for verbosity = 1):  
{  
  "hash" : "hash",             (string) the block hash (same as provided)  
  "confirmations" : n,         (numeric) The number of confirmations, or -1 if the block is not on the main chain  
  "size" : n,                  (numeric) The block size  
  "strippedsize" : n,          (numeric) The block size excluding witness data  
  "weight" : n                 (numeric) The block weight as defined in BIP 141  
  "height" : n,                (numeric) The block height or index  
  "masternode" : "hex",        (string) Masternode ID of the block minter  
  "minter" : "address",        (string) Operator address of block minter  
  "mintedBlocks" : n,          (numeric) Total number of blocks minted by block minter  
  "stakeModifier" : "hex",     (string) The block stake modifier  
  "version" : n,               (numeric) The block version  
  "versionHex" : "00000000",   (string) The block version formatted in hexadecimal  
  "merkleroot" : "xxxx",       (string) The merkle root  
  "nonutxo" : [,               (array of string) Non-UTXO coinbase rewards  
     "type" n.nnnnnnnn         (numeric) Reward type and amount  
  ],  
  "tx" : [                     (array of string) The transaction ids  
     "transactionid"           (string) The transaction id  
     ,...  
  ],  
  "time" : ttt,                (numeric) The block time in seconds since epoch (Jan 1 1970 GMT)  
  "mediantime" : ttt,          (numeric) The median block time in seconds since epoch (Jan 1 1970 GMT)  
  "nonce" : n,                 (numeric) The nonce  
  "bits" : "1d00ffff",         (string) The bits  
  "difficulty" : x.xxx,        (numeric) The difficulty  
  "chainwork" : "xxxx",        (string) Expected number of hashes required to produce the chain up to this block (in hex)  
  "nTx" : n,                   (numeric) The number of transactions in the block.  
  "previousblockhash" : "hash",  (string) The hash of the previous block  
  "nextblockhash" : "hash"       (string) The hash of the next block  
}  
  
Result (for verbosity = 2):  
{  
  ...,                     Same output as verbosity = 1.  
  "tx" : [               (array of Objects) The transactions in the format of the getrawtransaction RPC. Different from verbosity = 1 "tx" result.  
         ,...  
  ],  
  ,...                     Same output as verbosity = 1.  
}  
  
Examples:  
> defi-cli getblock "00000000c937983704a73af28acdec37b049d214adbda81d7e2a3dd146f6ed09"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblock", "params": ["00000000c937983704a73af28acdec37b049d214adbda81d7e2a3dd146f6ed09"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getblockchaininfo</summary><p>
getblockchaininfo  
Returns an object containing various state info regarding blockchain processing.  
  
Result:  
{  
  "chain": "xxxx",              (string) current network name as defined in BIP70 (main, test, regtest)  
  "blocks": xxxxxx,             (numeric) the height of the most-work fully-validated chain. The genesis block has height 0  
  "headers": xxxxxx,            (numeric) the current number of headers we have validated  
  "bestblockhash": "...",       (string) the hash of the currently best block  
  "difficulty": xxxxxx,         (numeric) the current difficulty  
  "mediantime": xxxxxx,         (numeric) median time for the current best block  
  "verificationprogress": xxxx, (numeric) estimate of verification progress [0..1]  
  "initialblockdownload": xxxx, (bool) (debug information) estimate of whether this node is in Initial Block Download mode.  
  "chainwork": "xxxx"           (string) total amount of work in active chain, in hexadecimal  
  "size_on_disk": xxxxxx,       (numeric) the estimated size of the block and undo files on disk  
  "pruned": xx,                 (boolean) if the blocks are subject to pruning  
  "pruneheight": xxxxxx,        (numeric) lowest-height complete block stored (only present if pruning is enabled)  
  "automatic_pruning": xx,      (boolean) whether automatic pruning is enabled (only present if pruning is enabled)  
  "prune_target_size": xxxxxx,  (numeric) the target size used by pruning (only present if automatic pruning is enabled)  
  "softforks": {                (object) status of softforks  
     "xxxx" : {                 (string) name of the softfork  
        "type": "xxxx",         (string) one of "buried", "bip9"  
        "bip9": {               (object) status of bip9 softforks (only for "bip9" type)  
           "status": "xxxx",    (string) one of "defined", "started", "locked_in", "active", "failed"  
           "bit": xx,           (numeric) the bit (0-28) in the block version field used to signal this softfork (only for "started" status)  
           "startTime": xx,     (numeric) the minimum median time past of a block at which the bit gains its meaning  
           "timeout": xx,       (numeric) the median time past of a block at which the deployment is considered failed if not yet locked in  
           "since": xx,         (numeric) height of the first block to which the status applies  
           "statistics": {      (object) numeric statistics about BIP9 signalling for a softfork  
              "period": xx,     (numeric) the length in blocks of the BIP9 signalling period   
              "threshold": xx,  (numeric) the number of blocks with the version bit set required to activate the feature   
              "elapsed": xx,    (numeric) the number of blocks elapsed since the beginning of the current period   
              "count": xx,      (numeric) the number of blocks with the version bit set in the current period   
              "possible": xx    (boolean) returns false if there are not enough blocks left in this period to pass activation threshold   
           }  
        },  
        "height": "xxxxxx",     (numeric) height of the first block which the rules are or will be enforced (only for "buried" type, or "bip9" type with "active" status)  
        "active": xx,           (boolean) true if the rules are enforced for the mempool and the next block  
     }  
  }  
  "warnings" : "...",           (string) any network and blockchain warnings.  
}  
  
Examples:  
> defi-cli getblockchaininfo   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockchaininfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getblockcount</summary><p>
getblockcount  
  
Returns the height of the most-work fully-validated chain.  
The genesis block has height 0.  
  
Result:  
n    (numeric) The current block count  
  
Examples:  
> defi-cli getblockcount   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockcount", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getblockfilter "blockhash" ( "filtertype" )</summary><p>
getblockfilter "blockhash" ( "filtertype" )  
  
Retrieve a BIP 157 content filter for a particular block.  
  
Arguments:  
1. blockhash     (string, required) The hash of the block  
2. filtertype    (string, optional, default=basic) The type name of the filter  
  
Result:  
{  
  "filter" : (string) the hex-encoded filter data  
  "header" : (string) the hex-encoded filter header  
}  
  
Examples:  
> defi-cli getblockfilter "00000000c937983704a73af28acdec37b049d214adbda81d7e2a3dd146f6ed09" "basic"  

</p></details>

<details><summary>getblockhash height</summary><p>
getblockhash height  
  
Returns hash of block in best-block-chain at height provided.  
  
Arguments:  
1. height    (numeric, required) The height index  
  
Result:  
"hash"         (string) The block hash  
  
Examples:  
> defi-cli getblockhash 1000  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockhash", "params": [1000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getblockheader "blockhash" ( verbose )</summary><p>
getblockheader "blockhash" ( verbose )  
  
If verbose is false, returns a string that is serialized, hex-encoded data for blockheader 'hash'.  
If verbose is true, returns an Object with information about blockheader <hash>.  
  
Arguments:  
1. blockhash    (string, required) The block hash  
2. verbose      (boolean, optional, default=true) true for a json object, false for the hex-encoded data  
  
Result (for verbose = true):  
{  
  "hash" : "hash",     (string) the block hash (same as provided)  
  "confirmations" : n,   (numeric) The number of confirmations, or -1 if the block is not on the main chain  
  "height" : n,          (numeric) The block height or index  
  "version" : n,         (numeric) The block version  
  "versionHex" : "00000000", (string) The block version formatted in hexadecimal  
  "merkleroot" : "xxxx", (string) The merkle root  
  "time" : ttt,          (numeric) The block time in seconds since epoch (Jan 1 1970 GMT)  
  "mediantime" : ttt,    (numeric) The median block time in seconds since epoch (Jan 1 1970 GMT)  
  "nonce" : n,           (numeric) The nonce  
  "bits" : "1d00ffff", (string) The bits  
  "difficulty" : x.xxx,  (numeric) The difficulty  
  "chainwork" : "0000...1f3"     (string) Expected number of hashes required to produce the current chain (in hex)  
  "nTx" : n,             (numeric) The number of transactions in the block.  
  "previousblockhash" : "hash",  (string) The hash of the previous block  
  "nextblockhash" : "hash",      (string) The hash of the next block  
}  
  
Result (for verbose=false):  
"data"             (string) A string that is serialized, hex-encoded data for block 'hash'.  
  
Examples:  
> defi-cli getblockheader "00000000c937983704a73af28acdec37b049d214adbda81d7e2a3dd146f6ed09"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockheader", "params": ["00000000c937983704a73af28acdec37b049d214adbda81d7e2a3dd146f6ed09"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getblockstats hash_or_height ( stats )</summary><p>
getblockstats hash_or_height ( stats )  
  
Compute per block statistics for a given window. All amounts are in satoshis.  
It won't work for some heights with pruning.  
  
Arguments:  
1. hash_or_height    (string or numeric, required) The block hash or height of the target block  
2. stats             (json array, optional, default=all values) Values to plot (see result below)  
     [  
       "height",     (string) Selected statistic  
       "time",       (string) Selected statistic  
       ...  
     ]  
  
Result:  
{                           (json object)  
  "avgfee": xxxxx,          (numeric) Average fee in the block  
  "avgfeerate": xxxxx,      (numeric) Average feerate (in satoshis per virtual byte)  
  "avgtxsize": xxxxx,       (numeric) Average transaction size  
  "blockhash": xxxxx,       (string) The block hash (to check for potential reorgs)  
  "feerate_percentiles": [  (array of numeric) Feerates at the 10th, 25th, 50th, 75th, and 90th percentile weight unit (in satoshis per virtual byte)  
      "10th_percentile_feerate",      (numeric) The 10th percentile feerate  
      "25th_percentile_feerate",      (numeric) The 25th percentile feerate  
      "50th_percentile_feerate",      (numeric) The 50th percentile feerate  
      "75th_percentile_feerate",      (numeric) The 75th percentile feerate  
      "90th_percentile_feerate",      (numeric) The 90th percentile feerate  
  ],  
  "height": xxxxx,          (numeric) The height of the block  
  "ins": xxxxx,             (numeric) The number of inputs (excluding coinbase)  
  "maxfee": xxxxx,          (numeric) Maximum fee in the block  
  "maxfeerate": xxxxx,      (numeric) Maximum feerate (in satoshis per virtual byte)  
  "maxtxsize": xxxxx,       (numeric) Maximum transaction size  
  "medianfee": xxxxx,       (numeric) Truncated median fee in the block  
  "mediantime": xxxxx,      (numeric) The block median time past  
  "mediantxsize": xxxxx,    (numeric) Truncated median transaction size  
  "minfee": xxxxx,          (numeric) Minimum fee in the block  
  "minfeerate": xxxxx,      (numeric) Minimum feerate (in satoshis per virtual byte)  
  "mintxsize": xxxxx,       (numeric) Minimum transaction size  
  "outs": xxxxx,            (numeric) The number of outputs  
  "subsidy": xxxxx,         (numeric) The block subsidy  
  "swtotal_size": xxxxx,    (numeric) Total size of all segwit transactions  
  "swtotal_weight": xxxxx,  (numeric) Total weight of all segwit transactions divided by segwit scale factor (4)  
  "swtxs": xxxxx,           (numeric) The number of segwit transactions  
  "time": xxxxx,            (numeric) The block time  
  "total_out": xxxxx,       (numeric) Total amount in all outputs (excluding coinbase and thus reward [ie subsidy + totalfee])  
  "total_size": xxxxx,      (numeric) Total size of all non-coinbase transactions  
  "total_weight": xxxxx,    (numeric) Total weight of all non-coinbase transactions divided by segwit scale factor (4)  
  "totalfee": xxxxx,        (numeric) The fee total  
  "txs": xxxxx,             (numeric) The number of transactions (excluding coinbase)  
  "utxo_increase": xxxxx,   (numeric) The increase/decrease in the number of unspent outputs  
  "utxo_size_inc": xxxxx,   (numeric) The increase/decrease in size for the utxo index (not discounting op_return and similar)  
}  
  
Examples:  
> defi-cli getblockstats 1000 '["minfeerate","avgfeerate"]'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockstats", "params": [1000 '["minfeerate","avgfeerate"]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getchaintips</summary><p>
getchaintips  
Return information about all known tips in the block tree, including the main chain as well as orphaned branches.  
  
Result:  
[  
  {  
    "height": xxxx,         (numeric) height of the chain tip  
    "hash": "xxxx",         (string) block hash of the tip  
    "branchlen": 0          (numeric) zero for main chain  
    "status": "active"      (string) "active" for the main chain  
  },  
  {  
    "height": xxxx,  
    "hash": "xxxx",  
    "branchlen": 1          (numeric) length of branch connecting the tip to the main chain  
    "status": "xxxx"        (string) status of the chain (active, valid-fork, valid-headers, headers-only, invalid)  
  }  
]  
Possible values for status:  
1.  "invalid"               This branch contains at least one invalid block  
2.  "headers-only"          Not all blocks for this branch are available, but the headers are valid  
3.  "valid-headers"         All blocks are available for this branch, but they were never fully validated  
4.  "valid-fork"            This branch is not part of the active chain, but is fully validated  
5.  "active"                This is the tip of the active main chain, which is certainly valid  
  
Examples:  
> defi-cli getchaintips   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getchaintips", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getchaintxstats ( nblocks "blockhash" )</summary><p>
getchaintxstats ( nblocks "blockhash" )  
  
Compute statistics about the total number and rate of transactions in the chain.  
  
Arguments:  
1. nblocks      (numeric, optional, default=one month) Size of the window in number of blocks  
2. blockhash    (string, optional, default=chain tip) The hash of the block that ends the window.  
  
Result:  
{  
  "time": xxxxx,                         (numeric) The timestamp for the final block in the window in UNIX format.  
  "txcount": xxxxx,                      (numeric) The total number of transactions in the chain up to that point.  
  "window_final_block_hash": "...",      (string) The hash of the final block in the window.  
  "window_final_block_height": xxxxx,    (numeric) The height of the final block in the window.  
  "window_block_count": xxxxx,           (numeric) Size of the window in number of blocks.  
  "window_tx_count": xxxxx,              (numeric) The number of transactions in the window. Only returned if "window_block_count" is > 0.  
  "window_interval": xxxxx,              (numeric) The elapsed time in the window in seconds. Only returned if "window_block_count" is > 0.  
  "txrate": x.xx,                        (numeric) The average rate of transactions per second in the window. Only returned if "window_interval" is > 0.  
}  
  
Examples:  
> defi-cli getchaintxstats   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getchaintxstats", "params": [2016] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getdifficulty</summary><p>
getdifficulty  
  
Returns the proof-of-work difficulty as a multiple of the minimum difficulty.  
  
Result:  
n.nnn       (numeric) the proof-of-work difficulty as a multiple of the minimum difficulty.  
  
Examples:  
> defi-cli getdifficulty   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getdifficulty", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getgov "name"</summary><p>
getgov "name"  
  
Returns information about governance variable:  
ATTRIBUTES, ICX_TAKERFEE_PER_BTC, LP_DAILY_LOAN_TOKEN_REWARD, LP_LOAN_TOKEN_SPLITS, LP_DAILY_DFI_REWARD,  
LOAN_LIQUIDATION_PENALTY, LP_SPLITS, ORACLE_BLOCK_INTERVAL, ORACLE_DEVIATION  
  
Arguments:  
1. name    (string, required) Variable name  
  
Result:  
{id:{...}}     (array) Json object with variable information  
  
Examples:  
> defi-cli getgov LP_SPLITS  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getgov", "params": [LP_DAILY_DFI_REWARD] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getmempoolancestors "txid" ( verbose )</summary><p>
getmempoolancestors "txid" ( verbose )  
  
If txid is in the mempool, returns all in-mempool ancestors.  
  
Arguments:  
1. txid       (string, required) The transaction id (must be in mempool)  
2. verbose    (boolean, optional, default=false) True for a json object, false for array of transaction ids  
  
Result (for verbose = false):  
[                       (json array of strings)  
  "transactionid"           (string) The transaction id of an in-mempool ancestor transaction  
  ,...  
]  
  
Result (for verbose = true):  
{                           (json object)  
  "transactionid" : {       (json object)  
    "vsize" : n,            (numeric) virtual transaction size as defined in BIP 141. This is different from actual serialized size for witness transactions as witness data is discounted.  
    "size" : n,             (numeric) (DEPRECATED) same as vsize. Only returned if defid is started with -deprecatedrpc=size  
                              size will be completely removed in v0.20.  
    "weight" : n,           (numeric) transaction weight as defined in BIP 141.  
    "fee" : n,              (numeric) transaction fee in DFI (DEPRECATED)  
    "modifiedfee" : n,      (numeric) transaction fee with fee deltas used for mining priority (DEPRECATED)  
    "time" : n,             (numeric) local time transaction entered pool in seconds since 1 Jan 1970 GMT  
    "height" : n,           (numeric) block height when transaction entered pool  
    "descendantcount" : n,  (numeric) number of in-mempool descendant transactions (including this one)  
    "descendantsize" : n,   (numeric) virtual transaction size of in-mempool descendants (including this one)  
    "descendantfees" : n,   (numeric) modified fees (see above) of in-mempool descendants (including this one) (DEPRECATED)  
    "ancestorcount" : n,    (numeric) number of in-mempool ancestor transactions (including this one)  
    "ancestorsize" : n,     (numeric) virtual transaction size of in-mempool ancestors (including this one)  
    "ancestorfees" : n,     (numeric) modified fees (see above) of in-mempool ancestors (including this one) (DEPRECATED)  
    "wtxid" : hash,         (string) hash of serialized transaction, including witness data  
    "fees" : {  
        "base" : n,         (numeric) transaction fee in DFI  
        "modified" : n,     (numeric) transaction fee with fee deltas used for mining priority in DFI  
        "ancestor" : n,     (numeric) modified fees (see above) of in-mempool ancestors (including this one) in DFI  
        "descendant" : n,   (numeric) modified fees (see above) of in-mempool descendants (including this one) in DFI  
    }  
    "depends" : [           (array) unconfirmed transactions used as inputs for this transaction  
        "transactionid",    (string) parent transaction id  
       ... ]  
    "spentby" : [           (array) unconfirmed transactions spending outputs from this transaction  
        "transactionid",    (string) child transaction id  
       ... ]  
    "bip125-replaceable" : true|false,  (boolean) Whether this transaction could be replaced due to BIP125 (replace-by-fee)  
  }, ...  
}  
  
Examples:  
> defi-cli getmempoolancestors "mytxid"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmempoolancestors", "params": ["mytxid"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getmempooldescendants "txid" ( verbose )</summary><p>
getmempooldescendants "txid" ( verbose )  
  
If txid is in the mempool, returns all in-mempool descendants.  
  
Arguments:  
1. txid       (string, required) The transaction id (must be in mempool)  
2. verbose    (boolean, optional, default=false) True for a json object, false for array of transaction ids  
  
Result (for verbose = false):  
[                       (json array of strings)  
  "transactionid"           (string) The transaction id of an in-mempool descendant transaction  
  ,...  
]  
  
Result (for verbose = true):  
{                           (json object)  
  "transactionid" : {       (json object)  
    "vsize" : n,            (numeric) virtual transaction size as defined in BIP 141. This is different from actual serialized size for witness transactions as witness data is discounted.  
    "size" : n,             (numeric) (DEPRECATED) same as vsize. Only returned if defid is started with -deprecatedrpc=size  
                              size will be completely removed in v0.20.  
    "weight" : n,           (numeric) transaction weight as defined in BIP 141.  
    "fee" : n,              (numeric) transaction fee in DFI (DEPRECATED)  
    "modifiedfee" : n,      (numeric) transaction fee with fee deltas used for mining priority (DEPRECATED)  
    "time" : n,             (numeric) local time transaction entered pool in seconds since 1 Jan 1970 GMT  
    "height" : n,           (numeric) block height when transaction entered pool  
    "descendantcount" : n,  (numeric) number of in-mempool descendant transactions (including this one)  
    "descendantsize" : n,   (numeric) virtual transaction size of in-mempool descendants (including this one)  
    "descendantfees" : n,   (numeric) modified fees (see above) of in-mempool descendants (including this one) (DEPRECATED)  
    "ancestorcount" : n,    (numeric) number of in-mempool ancestor transactions (including this one)  
    "ancestorsize" : n,     (numeric) virtual transaction size of in-mempool ancestors (including this one)  
    "ancestorfees" : n,     (numeric) modified fees (see above) of in-mempool ancestors (including this one) (DEPRECATED)  
    "wtxid" : hash,         (string) hash of serialized transaction, including witness data  
    "fees" : {  
        "base" : n,         (numeric) transaction fee in DFI  
        "modified" : n,     (numeric) transaction fee with fee deltas used for mining priority in DFI  
        "ancestor" : n,     (numeric) modified fees (see above) of in-mempool ancestors (including this one) in DFI  
        "descendant" : n,   (numeric) modified fees (see above) of in-mempool descendants (including this one) in DFI  
    }  
    "depends" : [           (array) unconfirmed transactions used as inputs for this transaction  
        "transactionid",    (string) parent transaction id  
       ... ]  
    "spentby" : [           (array) unconfirmed transactions spending outputs from this transaction  
        "transactionid",    (string) child transaction id  
       ... ]  
    "bip125-replaceable" : true|false,  (boolean) Whether this transaction could be replaced due to BIP125 (replace-by-fee)  
  }, ...  
}  
  
Examples:  
> defi-cli getmempooldescendants "mytxid"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmempooldescendants", "params": ["mytxid"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getmempoolentry "txid"</summary><p>
getmempoolentry "txid"  
  
Returns mempool data for given transaction  
  
Arguments:  
1. txid    (string, required) The transaction id (must be in mempool)  
  
Result:  
{                           (json object)  
    "vsize" : n,            (numeric) virtual transaction size as defined in BIP 141. This is different from actual serialized size for witness transactions as witness data is discounted.  
    "size" : n,             (numeric) (DEPRECATED) same as vsize. Only returned if defid is started with -deprecatedrpc=size  
                              size will be completely removed in v0.20.  
    "weight" : n,           (numeric) transaction weight as defined in BIP 141.  
    "fee" : n,              (numeric) transaction fee in DFI (DEPRECATED)  
    "modifiedfee" : n,      (numeric) transaction fee with fee deltas used for mining priority (DEPRECATED)  
    "time" : n,             (numeric) local time transaction entered pool in seconds since 1 Jan 1970 GMT  
    "height" : n,           (numeric) block height when transaction entered pool  
    "descendantcount" : n,  (numeric) number of in-mempool descendant transactions (including this one)  
    "descendantsize" : n,   (numeric) virtual transaction size of in-mempool descendants (including this one)  
    "descendantfees" : n,   (numeric) modified fees (see above) of in-mempool descendants (including this one) (DEPRECATED)  
    "ancestorcount" : n,    (numeric) number of in-mempool ancestor transactions (including this one)  
    "ancestorsize" : n,     (numeric) virtual transaction size of in-mempool ancestors (including this one)  
    "ancestorfees" : n,     (numeric) modified fees (see above) of in-mempool ancestors (including this one) (DEPRECATED)  
    "wtxid" : hash,         (string) hash of serialized transaction, including witness data  
    "fees" : {  
        "base" : n,         (numeric) transaction fee in DFI  
        "modified" : n,     (numeric) transaction fee with fee deltas used for mining priority in DFI  
        "ancestor" : n,     (numeric) modified fees (see above) of in-mempool ancestors (including this one) in DFI  
        "descendant" : n,   (numeric) modified fees (see above) of in-mempool descendants (including this one) in DFI  
    }  
    "depends" : [           (array) unconfirmed transactions used as inputs for this transaction  
        "transactionid",    (string) parent transaction id  
       ... ]  
    "spentby" : [           (array) unconfirmed transactions spending outputs from this transaction  
        "transactionid",    (string) child transaction id  
       ... ]  
    "bip125-replaceable" : true|false,  (boolean) Whether this transaction could be replaced due to BIP125 (replace-by-fee)  
}  
  
Examples:  
> defi-cli getmempoolentry "mytxid"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmempoolentry", "params": ["mytxid"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getmempoolinfo</summary><p>
getmempoolinfo  
  
Returns details on the active state of the TX memory pool.  
  
Result:  
{  
  "loaded": true|false         (boolean) True if the mempool is fully loaded  
  "size": xxxxx,               (numeric) Current tx count  
  "bytes": xxxxx,              (numeric) Sum of all virtual transaction sizes as defined in BIP 141. Differs from actual serialized size because witness data is discounted  
  "usage": xxxxx,              (numeric) Total memory usage for the mempool  
  "maxmempool": xxxxx,         (numeric) Maximum memory usage for the mempool  
  "mempoolminfee": xxxxx       (numeric) Minimum fee rate in DFI/kB for tx to be accepted. Is the maximum of minrelaytxfee and minimum mempool fee  
  "minrelaytxfee": xxxxx       (numeric) Current minimum relay fee for transactions  
}  
  
Examples:  
> defi-cli getmempoolinfo   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmempoolinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getrawmempool ( verbose )</summary><p>
getrawmempool ( verbose )  
  
Returns all transaction ids in memory pool as a json array of string transaction ids.  
  
Hint: use getmempoolentry to fetch a specific transaction from the mempool.  
  
Arguments:  
1. verbose    (boolean, optional, default=false) True for a json object, false for array of transaction ids  
  
Result (for verbose = false):  
[                     (json array of string)  
  "transactionid"     (string) The transaction id  
  ,...  
]  
  
Result: (for verbose = true):  
{                           (json object)  
  "transactionid" : {       (json object)  
    "vsize" : n,            (numeric) virtual transaction size as defined in BIP 141. This is different from actual serialized size for witness transactions as witness data is discounted.  
    "size" : n,             (numeric) (DEPRECATED) same as vsize. Only returned if defid is started with -deprecatedrpc=size  
                              size will be completely removed in v0.20.  
    "weight" : n,           (numeric) transaction weight as defined in BIP 141.  
    "fee" : n,              (numeric) transaction fee in DFI (DEPRECATED)  
    "modifiedfee" : n,      (numeric) transaction fee with fee deltas used for mining priority (DEPRECATED)  
    "time" : n,             (numeric) local time transaction entered pool in seconds since 1 Jan 1970 GMT  
    "height" : n,           (numeric) block height when transaction entered pool  
    "descendantcount" : n,  (numeric) number of in-mempool descendant transactions (including this one)  
    "descendantsize" : n,   (numeric) virtual transaction size of in-mempool descendants (including this one)  
    "descendantfees" : n,   (numeric) modified fees (see above) of in-mempool descendants (including this one) (DEPRECATED)  
    "ancestorcount" : n,    (numeric) number of in-mempool ancestor transactions (including this one)  
    "ancestorsize" : n,     (numeric) virtual transaction size of in-mempool ancestors (including this one)  
    "ancestorfees" : n,     (numeric) modified fees (see above) of in-mempool ancestors (including this one) (DEPRECATED)  
    "wtxid" : hash,         (string) hash of serialized transaction, including witness data  
    "fees" : {  
        "base" : n,         (numeric) transaction fee in DFI  
        "modified" : n,     (numeric) transaction fee with fee deltas used for mining priority in DFI  
        "ancestor" : n,     (numeric) modified fees (see above) of in-mempool ancestors (including this one) in DFI  
        "descendant" : n,   (numeric) modified fees (see above) of in-mempool descendants (including this one) in DFI  
    }  
    "depends" : [           (array) unconfirmed transactions used as inputs for this transaction  
        "transactionid",    (string) parent transaction id  
       ... ]  
    "spentby" : [           (array) unconfirmed transactions spending outputs from this transaction  
        "transactionid",    (string) child transaction id  
       ... ]  
    "bip125-replaceable" : true|false,  (boolean) Whether this transaction could be replaced due to BIP125 (replace-by-fee)  
  }, ...  
}  
  
Examples:  
> defi-cli getrawmempool true  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getrawmempool", "params": [true] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>gettxout "txid" n ( include_mempool )</summary><p>
gettxout "txid" n ( include_mempool )  
  
Returns details about an unspent transaction output.  
  
Arguments:  
1. txid               (string, required) The transaction id  
2. n                  (numeric, required) vout number  
3. include_mempool    (boolean, optional, default=true) Whether to include the mempool. Note that an unspent output that is spent in the mempool won't appear.  
  
Result:  
{  
  "bestblock":  "hash",    (string) The hash of the block at the tip of the chain  
  "confirmations" : n,       (numeric) The number of confirmations  
  "value" : x.xxx,           (numeric) The transaction value in DFI  
  "scriptPubKey" : {         (json object)  
     "asm" : "code",       (string)   
     "hex" : "hex",        (string)   
     "reqSigs" : n,          (numeric) Number of required signatures  
     "type" : "pubkeyhash", (string) The type, eg pubkeyhash  
     "addresses" : [          (array of string) array of defi addresses  
        "address"     (string) defi address  
        ,...  
     ]  
  },  
  "coinbase" : true|false   (boolean) Coinbase or not  
}  
  
Examples:  
  
Get unspent transactions  
> defi-cli listunspent   
  
View the details  
> defi-cli gettxout "txid" 1  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "gettxout", "params": ["txid", 1] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>gettxoutproof ["txid",...] ( "blockhash" )</summary><p>
gettxoutproof ["txid",...] ( "blockhash" )  
  
Returns a hex-encoded proof that "txid" was included in a block.  
  
NOTE: By default this function only works sometimes. This is when there is an  
unspent output in the utxo for this transaction. To make it always work,  
you need to maintain a transaction index, using the -txindex command line option or  
specify the block in which the transaction is included manually (by blockhash).  
  
Arguments:  
1. txids          (json array, required) A json array of txids to filter  
     [  
       "txid",    (string) A transaction hash  
       ...  
     ]  
2. blockhash      (string, optional) If specified, looks for txid in the block with this hash  
  
Result:  
"data"           (string) A string that is a serialized, hex-encoded data for the proof.  

</p></details>

<details><summary>gettxoutsetinfo</summary><p>
gettxoutsetinfo  
  
Returns statistics about the unspent transaction output set.  
Note this call may take some time.  
  
Result:  
{  
  "height":n,     (numeric) The current block height (index)  
  "bestblock": "hex",   (string) The hash of the block at the tip of the chain  
  "transactions": n,      (numeric) The number of transactions with unspent outputs  
  "txouts": n,            (numeric) The number of unspent transaction outputs  
  "bogosize": n,          (numeric) A meaningless metric for UTXO set size  
  "hash_serialized_2": "hash", (string) The serialized hash  
  "disk_size": n,         (numeric) The estimated size of the chainstate on disk  
  "total_amount": x.xxx          (numeric) The total amount  
}  
  
Examples:  
> defi-cli gettxoutsetinfo   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "gettxoutsetinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>isappliedcustomtx "txid" blockHeight</summary><p>
isappliedcustomtx "txid" blockHeight  
  
Checks that custom transaction was affected on chain  
  
Arguments:  
1. txid           (string, required) A transaction hash  
2. blockHeight    (numeric, required) The height of block which contain tx  
  
Result:  
(bool) The boolean indicate that custom transaction was affected on chain  
  
Examples:  
> defi-cli isappliedcustomtx b2bb09ffe9f9b292f13d23bafa1225ef26d0b9906da7af194c5738b63839b235 1005  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "isappliedcustomtx", "params": [b2bb09ffe9f9b292f13d23bafa1225ef26d0b9906da7af194c5738b63839b235 1005] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listgovs ( "prefix" )</summary><p>
listgovs ( "prefix" )  
  
Returns information about all governance variables including pending changes  
  
Arguments:  
1. prefix    (string) One of all, gov, attrs, live. Defaults to the all view. Any other string is treated as  
             a prefix of attributes to filter with. `v0/` is assumed if not explicitly provided.  
  
Result:  
[[{id:{...}},{height:{...}},...], ...]     (array) Json array with JSON objects with variable information  
  
Examples:  
> defi-cli listgovs   
> defi-cli listgovs gov  
> defi-cli listgovs live  
> defi-cli listgovs token/  
> defi-cli listgovs token/15  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listgovs", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listgovs", "params": [live] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> defi-cli listgovs token/  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listgovs", "params": [token/15] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listsmartcontracts</summary><p>
listsmartcontracts  
  
Returns information on smart contracts  
  
Result:  
(array) JSON array with smart contract information  
"name":"name"         smart contract name  
"address":"address"   smart contract address  
"token id":x.xxxxxxxx   smart contract balance per token  
  
Examples:  
> defi-cli listsmartcontracts   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listsmartcontracts", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>preciousblock "blockhash"</summary><p>
preciousblock "blockhash"  
  
Treats a block as if it were received before others with the same work.  
  
A later preciousblock call can override the effect of an earlier one.  
  
The effects of preciousblock are not retained across restarts.  
  
Arguments:  
1. blockhash    (string, required) the hash of the block to mark as precious  
  
Examples:  
> defi-cli preciousblock "blockhash"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "preciousblock", "params": ["blockhash"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>pruneblockchain height</summary><p>
pruneblockchain height  
  
Arguments:  
1. height    (numeric, required) The block height to prune up to. May be set to a discrete height, or a unix timestamp  
             to prune blocks whose block time is at least 2 hours older than the provided timestamp.  
  
Result:  
n    (numeric) Height of the last block pruned.  
  
Examples:  
> defi-cli pruneblockchain 1000  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "pruneblockchain", "params": [1000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>savemempool</summary><p>
savemempool  
  
Dumps the mempool to disk. It will fail until the previous dump is fully loaded.  
  
Examples:  
> defi-cli savemempool   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "savemempool", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>scantxoutset "action" [scanobjects,...]</summary><p>
scantxoutset "action" [scanobjects,...]  
  
EXPERIMENTAL warning: this call may be removed or changed in future releases.  
  
Scans the unspent transaction output set for entries that match certain output descriptors.  
Examples of output descriptors are:  
    addr(<address>)                      Outputs whose scriptPubKey corresponds to the specified address (does not include P2PK)  
    raw(<hex script>)                    Outputs whose scriptPubKey equals the specified hex scripts  
    combo(<pubkey>)                      P2PK, P2PKH, P2WPKH, and P2SH-P2WPKH outputs for the given pubkey  
    pkh(<pubkey>)                        P2PKH outputs for the given pubkey  
    sh(multi(<n>,<pubkey>,<pubkey>,...)) P2SH-multisig outputs for the given threshold and pubkeys  
  
In the above, <pubkey> either refers to a fixed public key in hexadecimal notation, or to an xpub/xprv optionally followed by one  
or more path elements separated by "/", and optionally ending in "/*" (unhardened), or "/*'" or "/*h" (hardened) to specify all  
unhardened or hardened child keys.  
In the latter case, a range needs to be specified by below if different from 1000.  
For more information on output descriptors, see the documentation in the doc/descriptors.md file.  
  
Arguments:  
1. action                        (string, required) The action to execute  
                                 "start" for starting a scan  
                                 "abort" for aborting the current scan (returns true when abort was successful)  
                                 "status" for progress report (in %) of the current scan  
2. scanobjects                   (json array, required) Array of scan objects  
                                 Every scan object is either a string descriptor or an object:  
     [  
       "descriptor",             (string) An output descriptor  
       {                         (json object) An object with output descriptor and metadata  
         "desc": "str",          (string, required) An output descriptor  
         "range": n or [n,n],    (numeric or array, optional, default=1000) The range of HD chain indexes to explore (either end or [begin,end])  
       },  
       ...  
     ]  
  
Result:  
{  
  "unspents": [  
    {  
    "txid" : "transactionid",     (string) The transaction id  
    "vout": n,                    (numeric) the vout value  
    "scriptPubKey" : "script",    (string) the script key  
    "desc" : "descriptor",        (string) A specialized descriptor for the matched scriptPubKey  
    "amount" : x.xxx,             (numeric) The total amount in DFI of the unspent output  
    "height" : n,                 (numeric) Height of the unspent transaction output  
   }  
   ,...],   
 "total_amount" : x.xxx,          (numeric) The total amount of all found unspent outputs in DFI  
]  

</p></details>

<details><summary>setgov {"name":"str"} ( [{"txid":"hex","vout":n},...] )</summary><p>
setgov {"name":"str"} ( [{"txid":"hex","vout":n},...] )  
  
Set special 'governance' variables:: ATTRIBUTES, ICX_TAKERFEE_PER_BTC, LP_LOAN_TOKEN_SPLITS, LP_SPLITS, ORACLE_BLOCK_INTERVAL, ORACLE_DEVIATION  
  
Arguments:  
1. variables               (json object, required) Object with variables  
     {  
       "name": "str",      (string, required) Variable's name is the key, value is the data. Exact data type depends on variable's name.  
     }  
2. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli setgov '{"LP_SPLITS": {"2":0.2,"3":0.8}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "setgov", "params": ['{"ICX_TAKERFEE_PER_BTC":109440}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>setgovheight {"name":"str"} height ( [{"txid":"hex","vout":n},...] )</summary><p>
setgovheight {"name":"str"} height ( [{"txid":"hex","vout":n},...] )  
  
Change governance variable at height: ATTRIBUTES, ICX_TAKERFEE_PER_BTC, LP_LOAN_TOKEN_SPLITS, LP_SPLITS, ORACLE_DEVIATION  
  
Arguments:  
1. variables               (json object, required) Object with variable  
     {  
       "name": "str",      (string, required) Variable name is the key, value is the data. Exact data type depends on variable name.  
     }  
2. height                  (numeric, required) Start height for the changes to take effect.  
3. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli setgovheight '{"LP_SPLITS": {"2":0.2,"3":0.8}' 100000  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "setgovheight", "params": ['{"ICX_TAKERFEE_PER_BTC":109440}', 100000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>unsetgov {"name":"str"} ( [{"txid":"hex","vout":n},...] )</summary><p>
unsetgov {"name":"str"} ( [{"txid":"hex","vout":n},...] )  
  
Unset special 'governance' variables:: ATTRIBUTES, ICX_TAKERFEE_PER_BTC, LP_LOAN_TOKEN_SPLITS, LP_SPLITS, ORACLE_BLOCK_INTERVAL, ORACLE_DEVIATION  
  
Arguments:  
1. variables               (json object, required) Object with variables  
     {  
       "name": "str",      (string, required) Variable's name is the key.  
     }  
2. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli unsetgov '{"LP_SPLITS": ["2","3"]'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "unsetgov", "params": ['{"ICX_TAKERFEE_PER_BTC"}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>unsetgovheight {"name":"str"} height ( [{"txid":"hex","vout":n},...] )</summary><p>
unsetgovheight {"name":"str"} height ( [{"txid":"hex","vout":n},...] )  
  
Unset governance variables at height: ATTRIBUTES, ICX_TAKERFEE_PER_BTC, LP_LOAN_TOKEN_SPLITS, LP_SPLITS, ORACLE_BLOCK_INTERVAL, ORACLE_DEVIATION  
  
Arguments:  
1. variables               (json object, required) Object with variables  
     {  
       "name": "str",      (string, required) Variable's name is the key.  
     }  
2. height                  (numeric, required) Start height for the changes to take effect.  
3. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli unsetgovheight '{"LP_SPLITS": ["2","3"]}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "unsetgovheight", "params": ['{"ATTRIBUTES": ["v0/params/feature/pizza-party"]}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>verifychain ( checklevel nblocks )</summary><p>
verifychain ( checklevel nblocks )  
  
Verifies blockchain database.  
  
Arguments:  
1. checklevel    (numeric, optional, default=3, range=0-4) How thorough the block verification is.  
2. nblocks       (numeric, optional, default=6, 0=all) The number of blocks to check.  
  
Result:  
true|false       (boolean) Verified or not  
  
Examples:  
> defi-cli verifychain   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "verifychain", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>verifytxoutproof "proof"</summary><p>
verifytxoutproof "proof"  
  
Verifies that a proof points to a transaction in a block, returning the transaction it commits to  
and throwing an RPC error if the block is not in our best chain  
  
Arguments:  
1. proof    (string, required) The hex-encoded proof generated by gettxoutproof  
  
Result:  
["txid"]      (array, strings) The txid(s) which the proof commits to, or empty array if the proof can not be validated.  

</p></details>

## Control
<details><summary>getmemoryinfo ( "mode" )</summary><p>
getmemoryinfo ( "mode" )  
Returns an object containing information about memory usage.  
  
Arguments:  
1. mode    (string, optional, default="stats") determines what kind of information is returned.  
           - "stats" returns general statistics about memory usage in the daemon.  
           - "mallocinfo" returns an XML string describing low-level heap state (only available if compiled with glibc 2.10+).  
  
Result (mode "stats"):  
{  
  "locked": {               (json object) Information about locked memory manager  
    "used": xxxxx,          (numeric) Number of bytes used  
    "free": xxxxx,          (numeric) Number of bytes available in current arenas  
    "total": xxxxxxx,       (numeric) Total number of bytes managed  
    "locked": xxxxxx,       (numeric) Amount of bytes that succeeded locking. If this number is smaller than total, locking pages failed at some point and key data could be swapped to disk.  
    "chunks_used": xxxxx,   (numeric) Number allocated chunks  
    "chunks_free": xxxxx,   (numeric) Number unused chunks  
  }  
}  
  
Result (mode "mallocinfo"):  
"<malloc version="1">..."  
  
Examples:  
> defi-cli getmemoryinfo   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmemoryinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getrpcinfo</summary><p>
getrpcinfo  
  
Returns details of the RPC server.  
  
Result:  
{  
 "active_commands" (array) All active commands  
  [  
   {               (object) Information about an active command  
    "method"       (string)  The name of the RPC command   
    "duration"     (numeric)  The running time in microseconds  
   },...  
  ],  
 "logpath": "xxx" (string) The complete file path to the debug log  
}  
  
Examples:  
> defi-cli getrpcinfo   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getrpcinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>help ( "command" )</summary><p>
help ( "command" )  
  
List all commands, or get help for a specified command.  
  
Arguments:  
1. command    (string, optional, default=all commands) The command to get help on  
  
Result:  
"text"     (string) The help text  

</p></details>

<details><summary>logging ( ["include_category",...] ["exclude_category",...] )</summary><p>
logging ( ["include_category",...] ["exclude_category",...] )  
Gets and sets the logging configuration.  
When called without an argument, returns the list of categories with status that are currently being debug logged or not.  
When called with arguments, adds or removes categories from debug logging and return the lists above.  
The arguments are evaluated in order "include", "exclude".  
If an item is both included and excluded, it will thus end up being excluded.  
The valid logging categories are: accountchange, addrman, anchoring, bench, cmpctblock, coindb, connect, customtxbench, db, estimatefee, futureswap, http, leveldb, libevent, loan, mempool, mempoolrej, net, oracle, proxy, prune, rand, reindex, rpc, rpccache, selectcoins, spv, staking, swapresult, tokensplit, tor, zmq  
In addition, the following are available as category names with special meanings:  
  - "all",  "1" : represent all logging categories.  
  - "none", "0" : even if other logging categories are specified, ignore all of them.  
  
Arguments:  
1. include                    (json array, optional) A json array of categories to add debug logging  
     [  
       "include_category",    (string) the valid logging category  
       ...  
     ]  
2. exclude                    (json array, optional) A json array of categories to remove debug logging  
     [  
       "exclude_category",    (string) the valid logging category  
       ...  
     ]  
  
Result:  
{                   (json object where keys are the logging categories, and values indicates its status  
  "category": true|false,  (bool) if being debug logged or not. false:inactive, true:active  
  ...  
}  
  
Examples:  
> defi-cli logging "[\"all\"]" "[\"http\"]"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "logging", "params": [["all"], ["libevent"]] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>stop</summary><p>
stop  
  
Stop Defi server.
</p></details>

<details><summary>uptime</summary><p>
uptime  
  
Returns the total uptime of the server.  
  
Result:  
ttt        (numeric) The number of seconds that the server has been running  
  
Examples:  
> defi-cli uptime   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "uptime", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

## Evm
<details><summary>dumpevmdb ( {"dumparg":"str","from":"str","limit":n} )</summary><p>
dumpevmdb ( {"dumparg":"str","from":"str","limit":n} )  
Dump the full evm backend db for debugging.  
  
Arguments:  
1. options                  (json object)  
     {  
       "dumparg": "str",    (string) Option to specify dump index  
       "from": "str",       (string) Specify starting key  
       "limit": n,          (numeric) Specify dump limit  
     }  
  
Result:  
"dbdump"                  (string) The full evm backend db dump.This is for debugging purposes only.  
  
Examples:  
> defi-cli dumpevmdb '{"dumparg":"all", "from":<hex>, "limit":100}'  

</p></details>

<details><summary>evmtx "from" nonce gasPrice gasLimit "to" value ( "data" )</summary><p>
evmtx "from" nonce gasPrice gasLimit "to" value ( "data" )  
Creates (and submits to local node and network) a tx to send DFI token to EVM address.  
  
  
Arguments:  
1. from        (string, required) From ERC55 address  
2. nonce       (numeric, required) Transaction nonce  
3. gasPrice    (numeric, required) Gas Price in Gwei  
4. gasLimit    (numeric, required) Gas limit  
5. to          (string, required) To address. Can be empty  
6. value       (numeric, required) Amount to send in DFI  
7. data        (string) Hex encoded data. Can be blank.  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli evmtx '"<hex>"'  

</p></details>

<details><summary>logevmaccountstates</summary><p>
logevmaccountstates  
Log the full evm account states for debugging.  
  
Result:  
"accountstates"                  (string) The full evm account states.This is for debugging purposes only.  
  
Examples:  
> defi-cli logevmaccountstates   

</p></details>

<details><summary>logvmmaps type</summary><p>
logvmmaps type  
Logs all block or tx indexes for debugging.  
  
Arguments:  
1. type    (numeric, required) Type of log:  
           0 - DVMToEVM Blocks  
           1 - EVMToDVM Blocks  
           2 - DVMToEVM TXs  
           3 - EVMToDVM TXs  
  
Result:  
{...} (array) Json object with account balances if rpcresult is enabled.This is for debugging purposes only.  
  
Examples:  
> defi-cli logvmmaps '"<hex>"' 1  

</p></details>

<details><summary>vmmap "input" ( type )</summary><p>
vmmap "input" ( type )  
Give the equivalent of an address, blockhash or transaction from EVM to DVM  
  
Arguments:  
1. input    (string, required) DVM address, EVM blockhash, EVM transaction  
2. type     (numeric) Map types:   
            0 - Auto (Default)   
            1 - Block Number: DVM -> EVM   
            2 - Block Number: EVM -> DVM   
            3 - Block Hash: DVM -> EVM   
            4 - Block Hash: EVM -> DVM   
            5 - Tx Hash: DVM -> EVM   
            6 - Tx Hash: EVM -> DVM   
              
  
Result:  
"input"                  (string) The hex-encoded string for address, block or transaction  
                                            or (number) block number  
  
Examples:  
> defi-cli vmmap '"<hash>"' 1  

</p></details>

## Generating
<details><summary>generatetoaddress nblocks "address" ( maxtries )</summary><p>
generatetoaddress nblocks "address" ( maxtries )  
  
Mine blocks immediately to a specified address (before the RPC call returns)  
  
Arguments:  
1. nblocks     (numeric, required) How many blocks are generated immediately.  
2. address     (string, required) The address to send the newly generated DFI to.  
3. maxtries    (numeric, optional, default=-1) How many iterations to try.  
  
Result:  
[ blockhashes ]     (array) hashes of blocks generated  
  
Examples:  
  
Generate 11 blocks to myaddress  
> defi-cli generatetoaddress 11 "myaddress"  
If you are running the DeFi Blockchain wallet, you can get a new address to send the newly generated DFI to with:  

</p></details>

## Icxorderbook
<details><summary>icx_claimdfchtlc ( {"dfchtlcTx":"str","seed":"str"} [{"txid":"hex","vout":n},...] )</summary><p>
icx_claimdfchtlc ( {"dfchtlcTx":"str","seed":"str"} [{"txid":"hex","vout":n},...] )  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  
  
Creates (and submits to local node and network) a dfc htlc transaction.  
  
  
Arguments:  
1. htlc                       (json object)  
     {  
       "dfchtlcTx": "str",    (string, required) Txid of dfc htlc tx for which the claim is  
       "seed": "str",         (string, required) Secret seed for claiming htlc  
     }  
2. inputs                     (json array, optional) A json array of json objects  
     [  
       {                      (json object)  
         "txid": "hex",       (string, required) The transaction id  
         "vout": n,           (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli icx_claimdfchtlc '{"dfchtlcTx":"<txid>>","seed":"<seed>"}'  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  

</p></details>

<details><summary>icx_closeoffer "offerTx" ( [{"txid":"hex","vout":n},...] )</summary><p>
icx_closeoffer "offerTx" ( [{"txid":"hex","vout":n},...] )  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  
  
Closes (and submits to local node and network) offer transaction.  
  
  
Arguments:  
1. offerTx                 (string, required) Txid of makeoffer  
2. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli closeOffer '{"offerTx":"<txid>>"}'  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  

</p></details>

<details><summary>icx_closeorder "orderTx" ( [{"txid":"hex","vout":n},...] )</summary><p>
icx_closeorder "orderTx" ( [{"txid":"hex","vout":n},...] )  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  
  
Closes (and submits to local node and network) order transaction.  
  
  
Arguments:  
1. orderTx                 (string, required) Txid of order  
2. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli closeorder '{"orderTx":"<txid>>"}'  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  

</p></details>

<details><summary>icx_createorder {"tokenFrom|chainFrom":"str","chainTo|tokenTo":"str","ownerAddress":"str","receivePubkey":"str","amountFrom":n,"orderPrice":n,"expiry":n} ( [{"txid":"hex","vout":n},...] )</summary><p>
icx_createorder {"tokenFrom|chainFrom":"str","chainTo|tokenTo":"str","ownerAddress":"str","receivePubkey":"str","amountFrom":n,"orderPrice":n,"expiry":n} ( [{"txid":"hex","vout":n},...] )  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  
  
Creates (and submits to local node and network) a order creation transaction.  
  
  
Arguments:  
1. order                                (json object, required)  
     {  
       "tokenFrom|chainFrom": "str",    (string) Symbol or id of selling token/chain  
       "chainTo|tokenTo": "str",        (string) Symbol or id of buying chain/token  
       "ownerAddress": "str",           (string, required) Address of DFI token for fees and selling tokens in case of EXT/DFC order type  
       "receivePubkey": "str",          (string) Pubkey which can claim external HTLC in case of DFC/EXT order type  
       "amountFrom": n,                 (numeric, required) "tokenFrom" coins amount  
       "orderPrice": n,                 (numeric, required) Price per unit  
       "expiry": n,                     (numeric) Number of blocks until the order expires (Default: 2880 DFI blocks)  
     }  
2. inputs                               (json array, optional) A json array of json objects  
     [  
       {                                (json object)  
         "txid": "hex",                 (string, required) The transaction id  
         "vout": n,                     (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli icx_createorder '{"ownerAddress":"<tokenAddress>","tokenFrom":"GOLD#128","chainTo":"BTC","amountFrom":"10","orderPrice":"10"}'  
> defi-cli icx_createorder '{"chainFrom":"BTC","tokenTo":"SILVER#129","amountFrom":"5","orderPrice":"0.01","expiry":"1000"}'  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  

</p></details>

<details><summary>icx_getorder "orderTx"</summary><p>
icx_getorder "orderTx"  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  
  
Return information about order or fillorder.  
  
Arguments:  
1. orderTx    (string, required) Txid of createorder or fulfillorder tx  
  
Result:  
{...}     (object) Json object with order information  
  
Examples:  
> defi-cli icx_getorder '{"orderTx":"<txid>>"}'  
XPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  

</p></details>

<details><summary>icx_listhtlcs {"offerTx":"str","limit":n,"closed":bool}</summary><p>
icx_listhtlcs {"offerTx":"str","limit":n,"closed":bool}  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  
  
Return information about orders.  
  
Arguments:  
1. by                       (json object, required)  
     {  
       "offerTx": "str",    (string, required) Offer txid  for which to list all HTLCS  
       "limit": n,          (numeric) Maximum number of orders to return (default: 20)  
       "closed": bool,      (boolean) Display also claimed, expired and refunded HTLCs (default: false)  
     }  
  
Result:  
{{...},...}     (array) Json object with orders information  
  
Examples:  
> defi-cli icx_listorders '{"offerTx":"<txid>"}'  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  

</p></details>

<details><summary>icx_listorders ( {"token":n,"chain":n,"orderTx":"str","limit":n,"closed":bool} )</summary><p>
icx_listorders ( {"token":n,"chain":n,"orderTx":"str","limit":n,"closed":bool} )  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  
  
Return information about orders.  
  
Arguments:  
1. by                       (json object)  
     {  
       "token": n,          (numeric) Token asset  
       "chain": n,          (numeric) Chain asset  
       "orderTx": "str",    (string) Order txid to list all offers for this order  
       "limit": n,          (numeric) Maximum number of orders to return (default: 50)  
       "closed": bool,      (boolean) Display closed orders (default: false)  
     }  
  
Result:  
{{...},...}     (array) Json object with orders information  
  
Examples:  
> defi-cli icx_listorders '{"limit":"10"}'  
> defi-cli icx_listorders '{"token":"GOLD#128","chain":"BTC"}'  
> defi-cli icx_listorders '{"chain":"BTC","token":"SILVER#129","closed":true}'  
> defi-cli icx_listorders '{"orderTx":"<txid>>"}'  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  

</p></details>

<details><summary>icx_makeoffer ( {"orderTx":"str","amount":n,"ownerAddress":"str","receivePubkey":"str","expiry":n} [{"txid":"hex","vout":n},...] )</summary><p>
icx_makeoffer ( {"orderTx":"str","amount":n,"ownerAddress":"str","receivePubkey":"str","expiry":n} [{"txid":"hex","vout":n},...] )  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  
  
Creates (and submits to local node and network) a makeoffer transaction.  
  
  
Arguments:  
1. offer                          (json object)  
     {  
       "orderTx": "str",          (string, required) Txid of order tx for which is the offer  
       "amount": n,               (numeric, required) Amount fulfilling the order  
       "ownerAddress": "str",     (string, required) Address of DFI token and for receiving tokens in case of DFC/EXT order  
       "receivePubkey": "str",    (string) Pubkey which can claim external HTLC in case of EXT/DFC order type  
       "expiry": n,               (numeric) Number of blocks until the offer expires (Default: 10 DFI blocks)  
     }  
2. inputs                         (json array, optional) A json array of json objects  
     [  
       {                          (json object)  
         "txid": "hex",           (string, required) The transaction id  
         "vout": n,               (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli icx_makeoffer '{"orderTx":"<txid>","amount":"10",eceiveAddress":"<address>",}'  
> defi-cli icx_makeoffer '{"orderTx":"txid","amount":"10","ownerAddress":"<address>","receivePubkey":"<pubkey>"}'  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  

</p></details>

<details><summary>icx_submitdfchtlc ( {"offerTx":"str","amount":n,"hash":"str","timeout":n} [{"txid":"hex","vout":n},...] )</summary><p>
icx_submitdfchtlc ( {"offerTx":"str","amount":n,"hash":"str","timeout":n} [{"txid":"hex","vout":n},...] )  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  
  
Creates (and submits to local node and network) a dfc htlc transaction.  
  
  
Arguments:  
1. htlc                     (json object)  
     {  
       "offerTx": "str",    (string, required) Txid of offer tx for which the htlc is  
       "amount": n,         (numeric, required) Amount in htlc  
       "hash": "str",       (string, required) Hash of seed used for the hash lock part  
       "timeout": n,        (numeric) Timeout (absolute in blocks) for expiration of htlc in DFI blocks  
     }  
2. inputs                   (json array, optional) A json array of json objects  
     [  
       {                    (json object)  
         "txid": "hex",     (string, required) The transaction id  
         "vout": n,         (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli icx_submitdfchtlc '{"offerTx":"<txid>","amount":"10","receiveAddress":"<address>","hash":"<hash>","timeout":"50"}'  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  

</p></details>

<details><summary>icx_submitexthtlc ( {"offerTx":"str","amount":n,"htlcScriptAddress":"str","hash":"str","ownerPubkey":"str","timeout":n} [{"txid":"hex","vout":n},...] )</summary><p>
icx_submitexthtlc ( {"offerTx":"str","amount":n,"htlcScriptAddress":"str","hash":"str","ownerPubkey":"str","timeout":n} [{"txid":"hex","vout":n},...] )  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  
  
Creates (and submits to local node and network) ext htlc transaction.  
  
  
Arguments:  
1. htlc                               (json object)  
     {  
       "offerTx": "str",              (string, required) Txid of offer tx for which the htlc is  
       "amount": n,                   (numeric, required) Amount in htlc  
       "htlcScriptAddress": "str",    (string, required) Script address of external htlc  
       "hash": "str",                 (string, required) Hash of seed used for the hash lock part  
       "ownerPubkey": "str",          (string, required) Pubkey of the owner to which the funds are refunded if HTLC timeouts  
       "timeout": n,                  (numeric, required) Timeout (absolute in block) for expiration of external htlc in external chain blocks  
     }  
2. inputs                             (json array, optional) A json array of json objects  
     [  
       {                              (json object)  
         "txid": "hex",               (string, required) The transaction id  
         "vout": n,                   (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli icx_submitexthtlc '{"offerTx":"<txid>","amount":"1""htlcScriptAddress":"<script_address>","hash":"<hash>""ownerPubkey":"<pubkey>","timeout":"20"}'  
  
EXPERIMENTAL warning: ICX and Atomic Swap are experimental features. You might end up losing your funds. USE IT AT YOUR OWN RISK.  

</p></details>

## Loan
<details><summary>createloanscheme mincolratio interestrate "id" ( [{"txid":"hex","vout":n},...] )</summary><p>
createloanscheme mincolratio interestrate "id" ( [{"txid":"hex","vout":n},...] )  
Creates a loan scheme transaction.  
  
  
Arguments:  
1. mincolratio             (numeric, required) Minimum collateralization ratio (integer).  
2. interestrate            (numeric, required) Interest rate (integer or float).  
3. id                      (string, required) Unique identifier of the loan scheme (8 chars max).  
4. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli createloanscheme 150 5 LOAN0001  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createloanscheme", "params": [150, 5, LOAN0001] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>destroyloanscheme "id" ( ACTIVATE_AFTER_BLOCK [{"txid":"hex","vout":n},...] )</summary><p>
destroyloanscheme "id" ( ACTIVATE_AFTER_BLOCK [{"txid":"hex","vout":n},...] )  
Destroys a loan scheme.  
  
  
Arguments:  
1. id                      (string, required) Unique identifier of the loan scheme (8 chars max).  
2. ACTIVATE_AFTER_BLOCK    (numeric, optional) Block height at which new changes take effect.  
3. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli destroyloanscheme LOAN0001  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "destroyloanscheme", "params": [LOAN0001] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getcollateraltoken "token"</summary><p>
getcollateraltoken "token"  
Return collateral token information.  
  
Arguments:  
1. token    (string, required) Symbol or id of collateral token  
  
Result:  
{...}     (object) Json object with collateral token information  
  
Examples:  
> defi-cli getcollateraltoken DFI  

</p></details>

<details><summary>getinterest "id" ( "token" )</summary><p>
getinterest "id" ( "token" )  
Returns the global and per block interest by loan scheme.  
  
Arguments:  
1. id       (string, required) Unique identifier of the loan scheme (8 chars max).  
2. token    (string) The tokens's symbol, id or creation tx  
  
Result:  
{...}     (object) Json object with interest information  
            - `interestPerBlock`: Interest per block is always ceiled  
               to the min. unit of fi (8 decimals), however interest  
               less than this will continue to accrue until actual utilization  
               (eg. - payback of the loan), or until sub-fi maturity.             - `realizedInterestPerBlock`: The actual realized interest  
               per block. This is continues to accumulate until  
               the min. unit of the blockchain (fi) can be realized.   
  
Examples:  
> defi-cli getinterest LOAN0001 TSLA  

</p></details>

<details><summary>getloaninfo</summary><p>
getloaninfo  
Returns the loan stats.  
  
Result:  
{...}     (object) Json object with loan information  
  
Examples:  
> defi-cli getloaninfo   

</p></details>

<details><summary>getloanscheme "id"</summary><p>
getloanscheme "id"  
Returns information about loan scheme.  
  
Arguments:  
1. id    (string, required) Unique identifier of the loan scheme (8 chars max).  
  
Result:  
  {  
    "id" : n                   (string)  
    "mincolratio" : n          (numeric)  
    "interestrate" : n         (numeric)  
  },  
  
Examples:  
> defi-cli getloanscheme LOAN0001  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getloanscheme", "params": [LOAN0001] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getloantoken "token"</summary><p>
getloantoken "token"  
Return loan token information.  
  
Arguments:  
1. token    (string, required) Symbol or id of loan token  
  
Result:  
{...}     (object) Json object with loan token information  
  
Examples:  
> defi-cli getloantoken DFI  

</p></details>

<details><summary>listcollateraltokens</summary><p>
listcollateraltokens  
Return list of all created collateral tokens. If no parameters passed it will return all current valid setcollateraltoken transactions.  
  
Result:  
{...}     (object) Json object with collateral token information  
  
Examples:  
> defi-cli listcollateraltokens   

</p></details>

<details><summary>listloanschemes</summary><p>
listloanschemes  
List all available loan schemes.  
  
Result:  
[                         (json array of objects)  
  {  
    "id" : n                   (string)  
    "mincolratio" : n          (numeric)  
    "interestrate" : n         (numeric)  
  },  
  ...  
]  
  
Examples:  
> defi-cli listloanschemes   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listloanschemes", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listloantokens</summary><p>
listloantokens  
Return list of all created loan tokens.  
  
Result:  
{...}     (object) Json object with loan token information  
  
Examples:  
> defi-cli listloantokens   

</p></details>

<details><summary>paybackloan {"vaultId":"hex","from":"str","amounts":"str","loans":[{"dToken":"str","amounts":"str"},...]} ( [{"txid":"hex","vout":n},...] )</summary><p>
paybackloan {"vaultId":"hex","from":"str","amounts":"str","loans":[{"dToken":"str","amounts":"str"},...]} ( [{"txid":"hex","vout":n},...] )  
Creates (and submits to local node and network) a tx to return the loan in desired amount.  
  
  
Arguments:  
1. metadata                     (json object, required)  
     {  
       "vaultId": "hex",        (string, required) Id of vault used for loan  
       "from": "str",           (string, required) Address containing repayment tokens. If "from" value is: "*" (star), it's means auto-selection accounts from wallet.  
       "amounts": "str",        (string) Amount in amount@token format.  
       "loans": [               (json array, optional) A json array of json objects  
         {                      (json object)  
           "dToken": "str",     (string, required) The dTokens's symbol, id or creation tx  
           "amounts": "str",    (string, required) Amount in amount@token format.  
         },  
         ...  
       ],  
     }  
2. inputs                       (json array, optional) A json array of json objects  
     [  
       {                        (json object)  
         "txid": "hex",         (string, required) The transaction id  
         "vout": n,             (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli paybackloan '{"vaultId":84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2,"from":"<address>", "amounts":"10@TSLA"}'  

</p></details>

<details><summary>setcollateraltoken {"token":"str","factor":n,"fixedIntervalPriceId":"hex","activateAfterBlock":n} ( [{"txid":"hex","vout":n},...] )</summary><p>
setcollateraltoken {"token":"str","factor":n,"fixedIntervalPriceId":"hex","activateAfterBlock":n} ( [{"txid":"hex","vout":n},...] )  
Creates (and submits to local node and network) a set colleteral token transaction.  
  
  
Arguments:  
1. metadata                              (json object, required)  
     {  
       "token": "str",                   (string, required) Symbol or id of collateral token  
       "factor": n,                      (numeric, required) Collateralization factor  
       "fixedIntervalPriceId": "hex",    (string, required) token/currency pair to use for price of token  
       "activateAfterBlock": n,          (numeric) changes will be active after the block height (Optional)  
     }  
2. inputs                                (json array, optional) A json array of json objects  
     [  
       {                                 (json object)  
         "txid": "hex",                  (string, required) The transaction id  
         "vout": n,                      (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli setcollateraltoken '{"token":"TSLA","factor":"150","fixedIntervalPriceId":"TSLA/USD"}'  

</p></details>

<details><summary>setdefaultloanscheme "id" ( [{"txid":"hex","vout":n},...] )</summary><p>
setdefaultloanscheme "id" ( [{"txid":"hex","vout":n},...] )  
Sets the default loan scheme.  
  
  
Arguments:  
1. id                      (string, required) Unique identifier of the loan scheme (8 chars max).  
2. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli setdefaultloanscheme LOAN0001  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "setdefaultloanscheme", "params": [LOAN0001] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>setloantoken {"symbol":"str","name":"str","fixedIntervalPriceId":"hex","mintable":bool,"interest":n} ( [{"txid":"hex","vout":n},...] )</summary><p>
setloantoken {"symbol":"str","name":"str","fixedIntervalPriceId":"hex","mintable":bool,"interest":n} ( [{"txid":"hex","vout":n},...] )  
Creates (and submits to local node and network) a token for a price feed set in collateral token.  
  
  
Arguments:  
1. metadata                              (json object, required)  
     {  
       "symbol": "str",                  (string, required) Token's symbol (unique), not longer than 8  
       "name": "str",                    (string) Token's name (optional), not longer than 128  
       "fixedIntervalPriceId": "hex",    (string, required) token/currency pair to use for price of token  
       "mintable": bool,                 (boolean) Token's 'Mintable' property (bool, optional), default is 'True'  
       "interest": n,                    (numeric) Interest rate (default: 0)  
     }  
2. inputs                                (json array, optional) A json array of json objects  
     [  
       {                                 (json object)  
         "txid": "hex",                  (string, required) The transaction id  
         "vout": n,                      (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli setloantoken '{"symbol":"TSLA","name":"TSLA stock token","fixedIntervalPriceId":"TSLA/USD","interest":"3"}'  

</p></details>

<details><summary>takeloan {"vaultId":"hex","to":"str","amounts":"str"} ( [{"txid":"hex","vout":n},...] )</summary><p>
takeloan {"vaultId":"hex","to":"str","amounts":"str"} ( [{"txid":"hex","vout":n},...] )  
Creates (and submits to local node and network) a tx to mint loan token in desired amount based on defined loan.  
  
  
Arguments:  
1. metadata                 (json object, required)  
     {  
       "vaultId": "hex",    (string, required) Id of vault used for loan  
       "to": "str",         (string) Address to transfer tokens (optional)  
       "amounts": "str",    (string, required) Amount in amount@token format.  
     }  
2. inputs                   (json array, optional) A json array of json objects  
     [  
       {                    (json object)  
         "txid": "hex",     (string, required) The transaction id  
         "vout": n,         (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli takeloan '{"vaultId":84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2,"amounts":"10@TSLA"}'  

</p></details>

<details><summary>updateloanscheme mincolratio interestrate "id" ( ACTIVATE_AFTER_BLOCK [{"txid":"hex","vout":n},...] )</summary><p>
updateloanscheme mincolratio interestrate "id" ( ACTIVATE_AFTER_BLOCK [{"txid":"hex","vout":n},...] )  
Updates an existing loan scheme.  
  
  
Arguments:  
1. mincolratio             (numeric, required) Minimum collateralization ratio (integer).  
2. interestrate            (numeric, required) Interest rate (integer or float).  
3. id                      (string, required) Unique identifier of the loan scheme (8 chars max).  
4. ACTIVATE_AFTER_BLOCK    (numeric, optional) Block height at which new changes take effect.  
5. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli updateloanscheme 150 5 LOAN0001  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "updateloanscheme", "params": [150, 5, LOAN0001] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>updateloantoken "token" {"symbol":"str","name":"str","fixedIntervalPriceId":"hex","mintable":bool,"interest":n} ( [{"txid":"hex","vout":n},...] )</summary><p>
updateloantoken "token" {"symbol":"str","name":"str","fixedIntervalPriceId":"hex","mintable":bool,"interest":n} ( [{"txid":"hex","vout":n},...] )  
Creates (and submits to local node and network) a transaction to update loan token metadata.  
  
  
Arguments:  
1. token                                 (string, required) The tokens's symbol, id or creation tx  
2. metadata                              (json object, required)  
     {  
       "symbol": "str",                  (string) New token's symbol (unique), not longer than 8  
       "name": "str",                    (string) Newoken's name (optional), not longer than 128  
       "fixedIntervalPriceId": "hex",    (string) token/currency pair to use for price of token  
       "mintable": bool,                 (boolean) Token's 'Mintable' property (bool, optional), default is 'True'  
       "interest": n,                    (numeric) Interest rate (optional).  
     }  
3. inputs                                (json array, optional) A json array of json objects  
     [  
       {                                 (json object)  
         "txid": "hex",                  (string, required) The transaction id  
         "vout": n,                      (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli updateloantoken "TSLAAA", {"symbol":"TSLA","fixedIntervalPriceId":"TSLA/USD", "mintable": true, "interest": 0.03}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "updateloantoken", "params": ["TSLAAA", {"symbol":"TSLA","fixedIntervalPriceId":"TSLA/USD", "mintable": true, "interest": 0.03}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

## Masternodes
<details><summary>createmasternode "ownerAddress" ( "operatorAddress" [{"txid":"hex","vout":n},...] "timelock" )</summary><p>
createmasternode "ownerAddress" ( "operatorAddress" [{"txid":"hex","vout":n},...] "timelock" )  
  
Creates (and submits to local node and network) a masternode creation transaction with given owner and operator addresses, spending the given inputs..  
The last optional argument (may be empty array) is an array of specific UTXOs to spend.  
  
Arguments:  
1. ownerAddress            (string, required) Any valid address for keeping collateral amount (any P2PKH or P2WKH address) - used as owner key  
2. operatorAddress         (string) Optional (== ownerAddress) masternode operator auth address (P2PKH only, unique)  
3. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
4. timelock                (string) Defaults to no timelock period so masternode can be resigned once active. To set a timelock period  
                           specify either FIVEYEARTIMELOCK or TENYEARTIMELOCK to create a masternode that cannot be resigned for  
                           five or ten years and will have 1.5x or 2.0 the staking power respectively. Be aware that this means  
                           that you cannot spend the collateral used to create a masternode for whatever period is specified.  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli createmasternode ownerAddress operatorAddress '[{"txid":"id","vout":0}]'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createmasternode", "params": [ownerAddress operatorAddress '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getactivemasternodecount ( blockCount )</summary><p>
getactivemasternodecount ( blockCount )  
  
Return number of unique masternodes in the last specified number of blocks  
  
Arguments:  
1. blockCount    (numeric) The number of blocks to check for unique masternodes. (Default: 20160)  
  
Result:  
n    (numeric) Number of unique masternodes seen  
  
Examples:  
> defi-cli getactivemasternodecount 20160  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getactivemasternodecount", "params": [20160] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getanchorteams ( blockHeight )</summary><p>
getanchorteams ( blockHeight )  
  
Returns the auth and confirm anchor masternode teams at current or specified height  
  
Arguments:  
1. blockHeight    (numeric) The height of block which contain tx  
  
Result:  
{"auth":[Address,...],"confirm":[Address,...]} Two sets of masternode operator addresses  
  
Examples:  
> defi-cli getanchorteams 1005  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getanchorteams", "params": [1005] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getmasternode "mn_id"</summary><p>
getmasternode "mn_id"  
  
Returns information about specified masternode.  
  
Arguments:  
1. mn_id    (string, required) Masternode's ID, operator or owner address  
  
Result:  
{id:{...}}     (object) Json object with masternode information  
  
Examples:  
> defi-cli getmasternode mn_id  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmasternode", "params": [mn_id] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getmasternodeblocks ( {"id":"hex","ownerAddress":"str","operatorAddress":"str"} depth )</summary><p>
getmasternodeblocks ( {"id":"hex","ownerAddress":"str","operatorAddress":"str"} depth )  
  
Returns blocks generated by the specified masternode.  
  
Arguments:  
1. identifier                       (json object, optional) A json object containing one masternode identifying information  
     {  
       "id": "hex",                 (string) Masternode's id  
       "ownerAddress": "str",       (string) Masternode owner address  
       "operatorAddress": "str",    (string) Masternode operator address  
     }  
2. depth                            (numeric) Maximum depth, from the genesis block is the default  
  
Result:  
{...}     (object) Json object with block hash and height information  
  
Examples:  
> defi-cli getmasternodeblocks '{"ownerAddress":"dPyup5C9hfRd2SUC1p3a7VcjcNuGSXa9bT"}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmasternodeblocks", "params": [{"ownerAddress":"dPyup5C9hfRd2SUC1p3a7VcjcNuGSXa9bT"}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listanchors</summary><p>
listanchors  
  
List anchors (if any)  
  
Result:  
"array"                  Returns array of anchors  
  
Examples:  
> defi-cli listanchors   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listanchors", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listmasternodes ( {"start":"hex","including_start":bool,"limit":n} verbose )</summary><p>
listmasternodes ( {"start":"hex","including_start":bool,"limit":n} verbose )  
  
Returns information about specified masternodes (or all, if list of ids is empty).  
  
Arguments:  
1. pagination                      (json object)  
     {  
       "start": "hex",             (string) Optional first key to iterate from, in lexicographical order.Typically it's set to last ID from previous request.  
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default  
       "limit": n,                 (numeric) Maximum number of orders to return, 1000000 by default  
     }  
2. verbose                         (boolean) Flag for verbose list (default = true), otherwise only ids are listed  
  
Result:  
{id:{...},...}     (array) Json object with masternodes information  
  
Examples:  
> defi-cli listmasternodes '[mn_id]' false  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listmasternodes", "params": ['[mn_id]' false] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>resignmasternode "mn_id" ( [{"txid":"hex","vout":n},...] )</summary><p>
resignmasternode "mn_id" ( [{"txid":"hex","vout":n},...] )  
  
Creates (and submits to local node and network) a transaction resigning your masternode. Collateral will be unlocked after 60 blocks.  
The last optional argument (may be empty array) is an array of specific UTXOs to spend. One of UTXO's must belong to the MN's owner (collateral) address  
  
Arguments:  
1. mn_id                   (string, required) The Masternode's ID  
2. inputs                  (json array, optional) A json array of json objects. Provide it if you want to spent specific UTXOs  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli resignmasternode mn_id '[{"txid":"id","vout":0}]'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "resignmasternode", "params": [mn_id '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>updatemasternode "mn_id" {"ownerAddress":"str","operatorAddress":"str","rewardAddress":"str"} ( [{"txid":"hex","vout":n},...] )</summary><p>
updatemasternode "mn_id" {"ownerAddress":"str","operatorAddress":"str","rewardAddress":"str"} ( [{"txid":"hex","vout":n},...] )  
  
Creates (and submits to local node and network) a masternode update transaction which update the masternode operator addresses, spending the given inputs..  
The last optional argument (may be empty array) is an array of specific UTXOs to spend.  
  
Arguments:  
1. mn_id                            (string, required) The Masternode's ID  
2. values                           (json object, required)  
     {  
       "ownerAddress": "str",       (string) The new masternode owner address, requires masternode collateral fee (P2PKH or P2WPKH)  
       "operatorAddress": "str",    (string) The new masternode operator address (P2PKH or P2WPKH)  
       "rewardAddress": "str",      (string) Masternode`s new reward address, empty "" to remove reward address.  
     }  
3. inputs                           (json array, optional) A json array of json objects  
     [  
       {                            (json object)  
         "txid": "hex",             (string, required) The transaction id  
         "vout": n,                 (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli updatemasternode mn_id operatorAddress '[{"txid":"id","vout":0}]'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "updatemasternode", "params": [mn_id operatorAddress '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

## Mining
<details><summary>getblocktemplate ( "template_request" )</summary><p>
getblocktemplate ( "template_request" )  
  
If the request parameters include a 'mode' key, that is used to explicitly select between the default 'template' request or a 'proposal'.  
It returns data needed to construct a block to work on.  
For full specification, see BIPs 22, 23, 9, and 145:  
    https://github.com/bitcoin/bips/blob/master/bip-0022.mediawiki  
    https://github.com/bitcoin/bips/blob/master/bip-0023.mediawiki  
    https://github.com/bitcoin/bips/blob/master/bip-0009.mediawiki#getblocktemplate_changes  
    https://github.com/bitcoin/bips/blob/master/bip-0145.mediawiki  
  
Arguments:  
1. template_request         (json object, optional, default={}) A json object in the following spec  
     {  
       "mode": "str",       (string, optional) This must be set to "template", "proposal" (see BIP 23), or omitted  
       "capabilities": [    (json array, optional) A list of strings  
         "support",         (string) client side supported feature, 'longpoll', 'coinbasetxn', 'coinbasevalue', 'proposal', 'serverlist', 'workid'  
         ...  
       ],  
       "rules": [           (json array, required) A list of strings  
         "support",         (string) client side supported softfork deployment  
         ...  
       ],  
     }  
  
Result:  
{  
  "version" : n,                    (numeric) The preferred block version  
  "rules" : [ "rulename", ... ],    (array of strings) specific block rules that are to be enforced  
  "vbavailable" : {                 (json object) set of pending, supported versionbit (BIP 9) softfork deployments  
      "rulename" : bitnumber          (numeric) identifies the bit number as indicating acceptance and readiness for the named softfork rule  
      ,...  
  },  
  "vbrequired" : n,                 (numeric) bit mask of versionbits the server requires set in submissions  
  "previousblockhash" : "xxxx",     (string) The hash of current highest block  
  "transactions" : [                (array) contents of non-coinbase transactions that should be included in the next block  
      {  
         "data" : "xxxx",             (string) transaction data encoded in hexadecimal (byte-for-byte)  
         "txid" : "xxxx",             (string) transaction id encoded in little-endian hexadecimal  
         "hash" : "xxxx",             (string) hash encoded in little-endian hexadecimal (including witness data)  
         "depends" : [                (array) array of numbers   
             n                          (numeric) transactions before this one (by 1-based index in 'transactions' list) that must be present in the final block if this one is  
             ,...  
         ],  
         "fee": n,                    (numeric) difference in value between transaction inputs and outputs (in satoshis); for coinbase transactions, this is a negative Number of the total collected block fees (ie, not including the block subsidy); if key is not present, fee is unknown and clients MUST NOT assume there isn't one  
         "sigops" : n,                (numeric) total SigOps cost, as counted for purposes of block limits; if key is not present, sigop cost is unknown and clients MUST NOT assume it is zero  
         "weight" : n,                (numeric) total transaction weight, as counted for purposes of block limits  
      }  
      ,...  
  ],  
  "coinbaseaux" : {                 (json object) data that should be included in the coinbase's scriptSig content  
      "flags" : "xx"                  (string) key name is to be ignored, and value included in scriptSig  
  },  
  "coinbasevalue" : n,              (numeric) maximum allowable input to coinbase transaction, including the generation award and transaction fees (in satoshis)  
  "coinbasetxn" : { ... },          (json object) information for coinbase transaction  
  "target" : "xxxx",                (string) The hash target  
  "mintime" : xxx,                  (numeric) The minimum timestamp appropriate for next block time in seconds since epoch (Jan 1 1970 GMT)  
  "mutable" : [                     (array of string) list of ways the block template may be changed   
     "value"                          (string) A way the block template may be changed, e.g. 'time', 'transactions', 'prevblock'  
     ,...  
  ],  
  "noncerange" : "00000000ffffffff",(string) A range of valid nonces  
  "sigoplimit" : n,                 (numeric) limit of sigops in blocks  
  "sizelimit" : n,                  (numeric) limit of block size  
  "weightlimit" : n,                (numeric) limit of block weight  
  "curtime" : ttt,                  (numeric) current timestamp in seconds since epoch (Jan 1 1970 GMT)  
  "bits" : "xxxxxxxx",              (string) compressed target of next block  
  "height" : n                      (numeric) The height of the next block  
}  
  
Examples:  
> defi-cli getblocktemplate '{"rules": ["segwit"]}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblocktemplate", "params": [{"rules": ["segwit"]}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getmininginfo</summary><p>
getmininginfo  
  
Returns a json object containing mining-related information for all local masternodes  
Result:  
{  
  "blocks": nnn,             (numeric) The current block  
  "currentblockweight": nnn, (numeric, optional) The block weight of the last assembled block (only present if a block was ever assembled)  
  "currentblocktx": nnn,     (numeric, optional) The number of block transactions of the last assembled block (only present if a block was ever assembled)  
  "difficulty": xxx.xxxxx    (numeric) The current difficulty  
  "networkhashps": nnn,      (numeric) The network hashes per second  
  "pooledtx": n              (numeric) The size of the mempool  
  "chain": "xxxx",         (string)  current network name as defined in BIP70 (main, test, regtest)  
  "isoperator": true|false   (boolean) Local master nodes are available or not   
  "masternodes": []          (array)   an array of objects which includes each master node information  
  "warnings": "..."        (string)  any network and blockchain warnings  
}  
  
Examples:  
> defi-cli getmininginfo   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmininginfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getmintinginfo</summary><p>
getmintinginfo  
  
DEPRECATED. Prefer using getmininginfo.  
Returns a json object containing mining-related information.  
Result:  
{  
  "blocks": nnn,             (numeric) The current block  
  "currentblockweight": nnn, (numeric, optional) The block weight of the last assembled block (only present if a block was ever assembled)  
  "currentblocktx": nnn,     (numeric, optional) The number of block transactions of the last assembled block (only present if a block was ever assembled)  
  "difficulty": xxx.xxxxx    (numeric) The current difficulty  
  "networkhashps": nnn,      (numeric) The network hashes per second  
  "pooledtx": n              (numeric) The size of the mempool  
  "chain": "xxxx",         (string)  current network name as defined in BIP70 (main, test, regtest)  
  "isoperator": true|false   (boolean) Local master nodes are available or not   
  "masternodes": []          (array)   an array of objects which includes each master node information  
  "warnings": "..."        (string)  any network and blockchain warnings  
}  
  
Examples:  
> defi-cli getmintinginfo   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getmintinginfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getnetworkhashps ( nblocks height )</summary><p>
getnetworkhashps ( nblocks height )  
  
Returns the estimated network hashes per second based on the last n blocks.  
Pass in [blocks] to override # of blocks, -1 specifies since last difficulty change.  
Pass in [height] to estimate the network speed at the time when a certain block was found.  
  
Arguments:  
1. nblocks    (numeric, optional, default=120) The number of blocks, or -1 for blocks since last difficulty change.  
2. height     (numeric, optional, default=-1) To estimate at the time of the given height.  
  
Result:  
x             (numeric) Hashes per second estimated  
  
Examples:  
> defi-cli getnetworkhashps   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getnetworkhashps", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>prioritisetransaction "txid" ( dummy ) fee_delta</summary><p>
prioritisetransaction "txid" ( dummy ) fee_delta  
Accepts the transaction into mined blocks at a higher (or lower) priority  
  
Arguments:  
1. txid         (string, required) The transaction id.  
2. dummy        (numeric, optional) API-Compatibility for previous API. Must be zero or null.  
                DEPRECATED. For forward compatibility use named arguments and omit this parameter.  
3. fee_delta    (numeric, required) The fee value (in satoshis) to add (or subtract, if negative).  
                Note, that this value is not a fee rate. It is a value to modify absolute fee of the TX.  
                The fee is not actually paid, only the algorithm for selecting transactions into a block  
                considers the transaction as it would have paid a higher (or lower) fee.  
  
Result:  
true              (boolean) Returns true  
  
Examples:  
> defi-cli prioritisetransaction "txid" 0.0 10000  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "prioritisetransaction", "params": ["txid", 0.0, 10000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>submitblock "hexdata" ( "dummy" )</summary><p>
submitblock "hexdata" ( "dummy" )  
  
Attempts to submit new block to network.  
See https://en.bitcoin.it/wiki/BIP_0022 for full specification.  
  
Arguments:  
1. hexdata    (string, required) the hex-encoded block data to submit  
2. dummy      (string, optional, default=ignored) dummy value, for compatibility with BIP22. This value is ignored.  
  
Examples:  
> defi-cli submitblock "mydata"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "submitblock", "params": ["mydata"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>submitheader "hexdata"</summary><p>
submitheader "hexdata"  
  
Decode the given hexdata as a header and submit it as a candidate chain tip if valid.  
Throws when the header is invalid.  
  
Arguments:  
1. hexdata    (string, required) the hex-encoded block header data  
  
Result:  
None  
Examples:  
> defi-cli submitheader "aabbcc"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "submitheader", "params": ["aabbcc"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

## Network
<details><summary>addnode "node" "command"</summary><p>
addnode "node" "command"  
  
Attempts to add or remove a node from the addnode list.  
Or try a connection to a node once.  
Nodes added using addnode (or -connect) are protected from DoS disconnection and are not required to be  
full nodes/support SegWit as other outbound peers are (though such peers will not be synced from).  
  
Arguments:  
1. node       (string, required) The node (see getpeerinfo for nodes)  
2. command    (string, required) 'add' to add a node to the list, 'remove' to remove a node from the list, 'onetry' to try a connection to the node once  
  
Examples:  
> defi-cli addnode "192.168.0.6:8555" "onetry"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "addnode", "params": ["192.168.0.6:8555", "onetry"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>clearbanned</summary><p>
clearbanned  
  
Clear all banned IPs.  
  
Examples:  
> defi-cli clearbanned   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "clearbanned", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>disconnectnode ( "address" nodeid )</summary><p>
disconnectnode ( "address" nodeid )  
  
Immediately disconnects from the specified peer node.  
  
Strictly one out of 'address' and 'nodeid' can be provided to identify the node.  
  
To disconnect by nodeid, either set 'address' to the empty string, or call using the named 'nodeid' argument only.  
  
Arguments:  
1. address    (string, optional, default=fallback to nodeid) The IP address/port of the node  
2. nodeid     (numeric, optional, default=fallback to address) The node ID (see getpeerinfo for node IDs)  
  
Examples:  
> defi-cli disconnectnode "192.168.0.6:8555"  
> defi-cli disconnectnode "" 1  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "disconnectnode", "params": ["192.168.0.6:8555"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "disconnectnode", "params": ["", 1] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getaddednodeinfo ( "node" )</summary><p>
getaddednodeinfo ( "node" )  
  
Returns information about the given added node, or all added nodes  
(note that onetry addnodes are not listed here)  
  
Arguments:  
1. node    (string, optional, default=all nodes) If provided, return information about this specific node, otherwise all nodes are returned.  
  
Result:  
[  
  {  
    "addednode" : "192.168.0.201",   (string) The node IP address or name (as provided to addnode)  
    "connected" : true|false,          (boolean) If connected  
    "addresses" : [                    (list of objects) Only when connected = true  
       {  
         "address" : "192.168.0.201:8555",  (string) The DeFi Blockchain server IP and port we're connected to  
         "connected" : "outbound"           (string) connection, inbound or outbound  
       }  
     ]  
  }  
  ,...  
]  
  
Examples:  
> defi-cli getaddednodeinfo "192.168.0.201"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getaddednodeinfo", "params": ["192.168.0.201"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getconnectioncount</summary><p>
getconnectioncount  
  
Returns the number of connections to other nodes.  
  
Result:  
n          (numeric) The connection count  
  
Examples:  
> defi-cli getconnectioncount   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getconnectioncount", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getnettotals</summary><p>
getnettotals  
  
Returns information about network traffic, including bytes in, bytes out,  
and current time.  
  
Result:  
{  
  "totalbytesrecv": n,   (numeric) Total bytes received  
  "totalbytessent": n,   (numeric) Total bytes sent  
  "timemillis": t,       (numeric) Current UNIX time in milliseconds  
  "uploadtarget":  
  {  
    "timeframe": n,                         (numeric) Length of the measuring timeframe in seconds  
    "target": n,                            (numeric) Target in bytes  
    "target_reached": true|false,           (boolean) True if target is reached  
    "serve_historical_blocks": true|false,  (boolean) True if serving historical blocks  
    "bytes_left_in_cycle": t,               (numeric) Bytes left in current time cycle  
    "time_left_in_cycle": t                 (numeric) Seconds left in current time cycle  
  }  
}  
  
Examples:  
> defi-cli getnettotals   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getnettotals", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getnetworkinfo</summary><p>
getnetworkinfo  
Returns an object containing various state info regarding P2P networking.  
  
Result:  
{  
  "version": xxxxx,                      (numeric) the server version  
  "subversion": "/Satoshi:x.x.x/",     (string) the server subversion string  
  "protocolversion": xxxxx,              (numeric) the protocol version  
  "localservices": "xxxxxxxxxxxxxxxx", (string) the services we offer to the network  
  "localrelay": true|false,              (bool) true if transaction relay is requested from peers  
  "timeoffset": xxxxx,                   (numeric) the time offset  
  "connections": xxxxx,                  (numeric) the number of connections  
  "networkactive": true|false,           (bool) whether p2p networking is enabled  
  "networks": [                          (array) information per network  
  {  
    "name": "xxx",                     (string) network (ipv4, ipv6 or onion)  
    "limited": true|false,               (boolean) is the network limited using -onlynet?  
    "reachable": true|false,             (boolean) is the network reachable?  
    "proxy": "host:port"               (string) the proxy that is used for this network, or empty if none  
    "proxy_randomize_credentials": true|false,  (string) Whether randomized credentials are used  
  }  
  ,...  
  ],  
  "relayfee": x.xxxxxxxx,                (numeric) minimum relay fee for transactions in DFI/kB  
  "incrementalfee": x.xxxxxxxx,          (numeric) minimum fee increment for mempool limiting or BIP 125 replacement in DFI/kB  
  "localaddresses": [                    (array) list of local addresses  
  {  
    "address": "xxxx",                 (string) network address  
    "port": xxx,                         (numeric) network port  
    "score": xxx                         (numeric) relative score  
  }  
  ,...  
  ]  
  "warnings": "..."                    (string) any network and blockchain warnings  
}  
  
Examples:  
> defi-cli getnetworkinfo   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getnetworkinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getnodeaddresses ( count )</summary><p>
getnodeaddresses ( count )  
  
Return known addresses which can potentially be used to find new nodes in the network  
  
Arguments:  
1. count    (numeric, optional, default=1) How many addresses to return. Limited to the smaller of 2500 or 23% of all known addresses.  
  
Result:  
[  
  {  
    "time": ttt,                (numeric) Timestamp in seconds since epoch (Jan 1 1970 GMT) keeping track of when the node was last seen  
    "services": n,              (numeric) The services offered  
    "address": "host",          (string) The address of the node  
    "port": n                   (numeric) The port of the node  
  }  
  ,....  
]  
  
Examples:  
> defi-cli getnodeaddresses 8  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getnodeaddresses", "params": [8] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getnodestatusinfo</summary><p>
getnodestatusinfo  
  
Returns data about the node status information as a json array of objects.  
  
Result:  
{  
  "health_status": true|false,     (boolean) Health status flag (sync_to_tip && connected_nodes)   
  "sync_to_tip": true|false,       (boolean) Whether node is sync-ed to tip  
  "active_peer_nodes": true|false, (boolean) Whether node is connected to minimum number of active peer nodes. Minimum of 5peer nodes with a lastrecv of less than 300 seconds  
}  
  
Examples:  
> defi-cli getnodestatusinfo   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getnodestatusinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getpeerinfo</summary><p>
getpeerinfo  
  
Returns data about each connected network node as a json array of objects.  
  
Result:  
[  
  {  
    "id": n,                   (numeric) Peer index  
    "addr":"host:port",      (string) The IP address and port of the peer  
    "addrbind":"ip:port",    (string) Bind address of the connection to the peer  
    "addrlocal":"ip:port",   (string) Local address as reported by the peer  
    "services":"xxxxxxxxxxxxxxxx",   (string) The services offered  
    "relaytxes":true|false,    (boolean) Whether peer has asked us to relay transactions to it  
    "lastsend": ttt,           (numeric) The time in seconds since epoch (Jan 1 1970 GMT) of the last send  
    "lastrecv": ttt,           (numeric) The time in seconds since epoch (Jan 1 1970 GMT) of the last receive  
    "bytessent": n,            (numeric) The total bytes sent  
    "bytesrecv": n,            (numeric) The total bytes received  
    "conntime": ttt,           (numeric) The connection time in seconds since epoch (Jan 1 1970 GMT)  
    "timeoffset": ttt,         (numeric) The time offset in seconds  
    "pingtime": n,             (numeric) ping time (if available)  
    "minping": n,              (numeric) minimum observed ping time (if any at all)  
    "pingwait": n,             (numeric) ping wait (if non-zero)  
    "version": v,              (numeric) The peer version, such as 70001  
    "subver": "/Satoshi:0.8.5/",  (string) The string version  
    "inbound": true|false,     (boolean) Inbound (true) or Outbound (false)  
    "addnode": true|false,     (boolean) Whether connection was due to addnode/-connect or if it was an automatic/inbound connection  
    "startingheight": n,       (numeric) The starting height (block) of the peer  
    "banscore": n,             (numeric) The ban score  
    "synced_headers": n,       (numeric) The last header we have in common with this peer  
    "synced_blocks": n,        (numeric) The last block we have in common with this peer  
    "inflight": [  
       n,                        (numeric) The heights of blocks we're currently asking from this peer  
       ...  
    ],  
    "addr_processed": n,       (numeric) The total number of addresses processed, excluding those dropped due to rate limiting  
    "addr_rate_limited": n,    (numeric) The total number of addresses dropped due to rate limiting  
    "whitelisted": true|false, (boolean) Whether the peer is whitelisted  
    "minfeefilter": n,         (numeric) The minimum fee rate for transactions this peer accepts  
    "bytessent_per_msg": {  
       "msg": n,               (numeric) The total bytes sent aggregated by message type  
                               When a message type is not listed in this json object, the bytes sent are 0.  
                               Only known message types can appear as keys in the object.  
       ...  
    },  
    "bytesrecv_per_msg": {  
       "msg": n,               (numeric) The total bytes received aggregated by message type  
                               When a message type is not listed in this json object, the bytes received are 0.  
                               Only known message types can appear as keys in the object and all bytes received of unknown message types are listed under '*other*'.  
       ...  
    }  
  }  
  ,...  
]  
  
Examples:  
> defi-cli getpeerinfo   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getpeerinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getversioninfo</summary><p>
getversioninfo  
Returns an object containing various version info about the node.  
  
Result:  
{  
 "name": DeFiChain                       (string) Node name  
 "version": "xxxxx",                   (string) Node version string  
 "numericVersion": xxxxx,                (number) Node numeric version  
 "fullVersion": "DefiChain:x.x.x",     (string) Full node version string including name and version  
 "userAgent": "/DefiChain:x.x.x/",     (string) P2P user agent string (subversion string conforming to BIP-14)  
 "protoVersion": "xxxxx",              (number) Operating protocol version  
 "protoVersionMin": "xxxxx",           (number) Minimum protocol that's supported by the node  
 "rpcVersion": "xxxxx",                (string) RPC version  
 "rpcVersionMin": "xxxxx",             (string) Minimum RPC version supported  
 "spv":  
 "{  
    "btc":  
       "{  
          "userAgent": "xxxxx",          (string) BTC SPV agent string  
          "protoVersion": "xxxxx",       (number) BTC SPV protocol version  
          "protoVersionMin": "xxxxx",    (number) Minimum BTC SPV protocol that's supported by the node  
       "}  
 "}"  
}  
Examples:  
> defi-cli getversioninfo   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getversioninfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listbanned</summary><p>
listbanned  
  
List all banned IPs/Subnets.  
  
Examples:  
> defi-cli listbanned   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listbanned", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>ping</summary><p>
ping  
  
Requests that a ping be sent to all other nodes, to measure ping time.  
Results provided in getpeerinfo, pingtime and pingwait fields are decimal seconds.  
Ping command is handled in queue with all other commands, so it measures processing backlog, not just network ping.  
  
Examples:  
> defi-cli ping   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "ping", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>setban "subnet" "command" ( bantime absolute )</summary><p>
setban "subnet" "command" ( bantime absolute )  
  
Attempts to add or remove an IP/Subnet from the banned list.  
  
Arguments:  
1. subnet      (string, required) The IP/Subnet (see getpeerinfo for nodes IP) with an optional netmask (default is /32 = single IP)  
2. command     (string, required) 'add' to add an IP/Subnet to the list, 'remove' to remove an IP/Subnet from the list  
3. bantime     (numeric, optional, default=0) time in seconds how long (or until when if [absolute] is set) the IP is banned (0 or empty means using the default time of 24h which can also be overwritten by the -bantime startup argument)  
4. absolute    (boolean, optional, default=false) If set, the bantime must be an absolute timestamp in seconds since epoch (Jan 1 1970 GMT)  
  
Examples:  
> defi-cli setban "192.168.0.6" "add" 86400  
> defi-cli setban "192.168.0.0/24" "add"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "setban", "params": ["192.168.0.6", "add", 86400] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>setnetworkactive state</summary><p>
setnetworkactive state  
  
Disable/enable all p2p network activity.  
  
Arguments:  
1. state    (boolean, required) true to enable networking, false to disable  

</p></details>

## Oracles
<details><summary>appointoracle "address" [{"currency":"str","token":"str"},...] weightage ( [{"txid":"hex","vout":n},...] )</summary><p>
appointoracle "address" [{"currency":"str","token":"str"},...] weightage ( [{"txid":"hex","vout":n},...] )  
  
Creates (and submits to local node and network) a `appoint oracle transaction`,   
and saves oracle to database.  
The last optional argument (may be empty array) is an array of specific UTXOs to spend.  
  
Arguments:  
1. address                     (string, required) oracle address  
2. pricefeeds                  (json array, required) list of allowed token-currency pairs  
     [  
       {                       (json object)  
         "currency": "str",    (string, required) Currency name  
         "token": "str",       (string, required) Token name  
       },  
       ...  
     ]  
3. weightage                   (numeric, required) oracle weightage  
4. inputs                      (json array, optional) A json array of json objects  
     [  
       {                       (json object)  
         "txid": "hex",        (string, required) The transaction id  
         "vout": n,            (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli appointoracle mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF '[{"currency": "USD", "token": "BTC"}, {"currency": "EUR", "token":"ETH"}]' 20  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "appointoracle", "params": [mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF '[{"currency": "USD", "token": "BTC"}, {"currency": "EUR", "token":"ETH"}]' 20] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getdusdswapblock</summary><p>
getdusdswapblock  
Get the next block that DFI to DUSD swap will execute on.  
  
Result:  
n    (numeric) DFI to DUSD swap execution block. Zero if not set.  
  
Examples:  
> defi-cli getdusdswapblock   

</p></details>

<details><summary>getfixedintervalprice "fixedIntervalPriceId"</summary><p>
getfixedintervalprice "fixedIntervalPriceId"  
Get fixed interval price for a given pair.  
  
Arguments:  
1. fixedIntervalPriceId    (string, required) token/currency pair to use for price of token  
  
Result:  
"json"          (string) json-object having following fields:  
                  `activePrice` - current price used for loan calculations  
                  `nextPrice` - next price to be assigned to pair.  
                  `nextPriceBlock` - height of nextPrice.  
                  `activePriceBlock` - height of activePrice.  
                  `timestamp` - timestamp of active price.  
                  `isLive` - price liveness, within parameters                   Possible reasons for a price result to not be live:                   1. Not sufficient live oracles.  
                   2. Deviation is over the limit to be considered stable.  
  
Examples:  
> defi-cli getfixedintervalprice TSLA/USD  

</p></details>

<details><summary>getfutureswapblock</summary><p>
getfutureswapblock  
Get the next block that futures will execute and update on.  
  
Result:  
n    (numeric) Futures execution block. Zero if not set.  
  
Examples:  
> defi-cli getfutureswapblock   

</p></details>

<details><summary>getoracledata "oracleid"</summary><p>
getoracledata "oracleid"  
  
Returns oracle data in json form.  
  
Arguments:  
1. oracleid    (string, required) oracle hex id  
  
Result:  
"json"                  (string) oracle data in json form  
  
Examples:  
> defi-cli getoracledata 5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getoracledata", "params": [5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getprice {"currency":"str","token":"str"}</summary><p>
getprice {"currency":"str","token":"str"}  
  
Calculates aggregated price,   
The only argument is a json-form request containing token and currency names.  
  
Arguments:  
1. request                   (json object, required) request in json-form, containing currency and token names, both are mandatory  
     {  
       "currency": "str",    (string, required) Currency name  
       "token": "str",       (string, required) Token name  
     }  
  
Result:  
"string"                  (string) aggregated price if  
                        if no live oracles which meet specified request or their weights are zero, throws error  
  
Examples:  
> defi-cli getprice getprice '{"currency": "USD", "token": "BTC"}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getprice", "params": [getprice '{"currency": "USD", "token": "BTC"}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listfixedintervalprices ( {"start":n,"limit":n} )</summary><p>
listfixedintervalprices ( {"start":n,"limit":n} )  
Get all fixed interval prices.  
  
Arguments:  
1. pagination         (json object)  
     {  
       "start": n,    (numeric) Optional first key to iterate from, in lexicographical order.Typically it's set to last ID from previous request.  
       "limit": n,    (numeric) Maximum number of fixed interval prices to return, 100 by default  
     }  
  
Result:  
"json"          (string) array containing json-objects having following fields:  
                  `activePrice` - current price used for loan calculations  
                  `nextPrice` - next price to be assigned to pair.  
                  `timestamp` - timestamp of active price.  
                  `isLive` - price liveness, within parameters                   Possible reasons for a price result to not be live:                   1. Not sufficient live oracles.  
                   2. Deviation is over the limit to be considered stable.  
  
Examples:  
> defi-cli listfixedintervalprices '{""}'  

</p></details>

<details><summary>listlatestrawprices ( {"currency":"str","token":"str"} {"start":"hex","including_start":bool,"limit":n} )</summary><p>
listlatestrawprices ( {"currency":"str","token":"str"} {"start":"hex","including_start":bool,"limit":n} )  
  
Returns latest raw price updates through all the oracles for specified token and currency ,   
  
Arguments:  
1. request                         (json object) request in json-form, containing currency and token names  
     {  
       "currency": "str",          (string, required) Currency name  
       "token": "str",             (string, required) Token name  
     }  
2. pagination                      (json object)  
     {  
       "start": "hex",             (string) Optional first key to iterate from, in lexicographical order. Typically it's set to last ID from previous request.  
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default  
       "limit": n,                 (numeric) Maximum number of orders to return, 100 by default  
     }  
  
Result:  
"json"                  (string) Array of json objects containing full information about token prices  
  
Examples:  
> defi-cli listlatestrawprices listlatestrawprices '{"currency": "USD", "token": "BTC"}'  
> defi-cli listlatestrawprices listlatestrawprices '{"currency": "USD", "token": "BTC"}' '{"start": "b7ffdcef37be39018e8a6f846db1220b3558fd649393e9a12f935007ef3bfb8e", "including_start": true, "limit": 100}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listlatestrawprices", "params": [listlatestrawprices '{"currency": "USD", "token": "BTC"}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listlatestrawprices", "params": [listlatestrawprices '{"currency": "USD", "token": "BTC"}' '{"start": "b7ffdcef37be39018e8a6f846db1220b3558fd649393e9a12f935007ef3bfb8e", "including_start": true, "limit": 100}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listoracles ( {"start":"hex","including_start":bool,"limit":n} )</summary><p>
listoracles ( {"start":"hex","including_start":bool,"limit":n} )  
  
Returns list of oracle ids.  
  
Arguments:  
1. pagination                      (json object)  
     {  
       "start": "hex",             (string) Optional first key to iterate from, in lexicographical order. Typically it's set to last ID from previous request.  
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default  
       "limit": n,                 (numeric) Maximum number of orders to return, 100 by default  
     }  
  
Result:  
"hash"                  (string) list of known oracle ids  
  
Examples:  
> defi-cli listoracles   
> defi-cli listoracles '{"start":"3ef9fd5bd1d0ce94751e6286710051361e8ef8fac43cca9cb22397bf0d17e013", "including_start": true, "limit":100}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listoracles", "params": ['{}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listoracles", "params": ['{"start":"3ef9fd5bd1d0ce94751e6286710051361e8ef8fac43cca9cb22397bf0d17e013", "including_start": true, "limit":100}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listprices ( {"start":n,"including_start":bool,"limit":n} )</summary><p>
listprices ( {"start":n,"including_start":bool,"limit":n} )  
  
Calculates aggregated prices for all supported pairs (token, currency),   
  
Arguments:  
1. pagination                      (json object)  
     {  
       "start": n,                 (numeric) Optional first key to iterate from, in lexicographical order.Typically it's set to last ID from previous request.  
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default  
       "limit": n,                 (numeric) Maximum number of orders to return, 100 by default  
     }  
  
Result:  
"json"                  (string) array containing json-objects having following fields:  
                  `token` - token name,  
                  `currency` - currency name,  
                  `price` - aggregated price value,  
                  `ok` - `true` if price is valid, otherwise it is populated with the reason description.  
                   Possible reasons for a price result to be invalid:                   1. if there are no live oracles which meet specified request.  
                   2. Sum of the weight of live oracles is zero.  
  
Examples:  
> defi-cli listprices   
> defi-cli listprices '{"start": 2, "including_start": true, "limit":100}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listprices", "params": ['{}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listprices", "params": ['{"start": 2, "including_start": true, "limit":100}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>removeoracle "oracleid" ( [{"txid":"hex","vout":n},...] )</summary><p>
removeoracle "oracleid" ( [{"txid":"hex","vout":n},...] )  
  
Removes oracle,   
The only argument is oracleid hex value.  
  
Arguments:  
1. oracleid                (string, required) oracle id  
2. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli removeoracle 0xabcd1234ac1243578697085986498694  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "removeoracle", "params": [0xabcd1234ac1243578697085986498694] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>setoracledata "oracleid" timestamp [{"currency":"str","tokenAmount":"str"},...] ( [{"txid":"hex","vout":n},...] )</summary><p>
setoracledata "oracleid" timestamp [{"currency":"str","tokenAmount":"str"},...] ( [{"txid":"hex","vout":n},...] )  
  
Creates (and submits to local node and network) a `set oracle data transaction`.  
The last optional argument (may be empty array) is an array of specific UTXOs to spend.  
  
Arguments:  
1. oracleid                       (string, required) oracle hex id  
2. timestamp                      (numeric, required) balances timestamp  
3. prices                         (json array, required) tokens raw prices:the array of price and token strings in price@token format.   
     [  
       {                          (json object)  
         "currency": "str",       (string, required) Currency name  
         "tokenAmount": "str",    (string, required) Amount@token  
       },  
       ...  
     ]  
4. inputs                         (json array, optional) A json array of json objects  
     [  
       {                          (json object)  
         "txid": "hex",           (string, required) The transaction id  
         "vout": n,               (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli setoracledata 5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf 1612237937 '[{"currency":"USD", "tokenAmount":"38293.12@BTC"}"  
                               ", {currency:"EUR", "tokenAmount":"1328.32@ETH"}]'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "setoracledata", "params": [5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf 1612237937 '[{"currency":"USD", "tokenAmount":"38293.12@BTC"}"  
                               ", {currency:"EUR", "tokenAmount":"1328.32@ETH"}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>updateoracle "oracleid" "address" [{"currency":"str","token":"str"},...] weightage ( [{"txid":"hex","vout":n},...] )</summary><p>
updateoracle "oracleid" "address" [{"currency":"str","token":"str"},...] weightage ( [{"txid":"hex","vout":n},...] )  
  
Creates (and submits to local node and network) a `update oracle transaction`,   
and saves oracle updates to database.  
The last optional argument (may be empty array) is an array of specific UTXOs to spend.  
  
Arguments:  
1. oracleid                    (string, required) oracle id  
2. address                     (string, required) oracle address  
3. pricefeeds                  (json array, required) list of allowed token-currency pairs  
     [  
       {                       (json object)  
         "currency": "str",    (string, required) Currency name  
         "token": "str",       (string, required) Token name  
       },  
       ...  
     ]  
4. weightage                   (numeric, required) oracle weightage  
5. inputs                      (json array, optional) A json array of json objects  
     [  
       {                       (json object)  
         "txid": "hex",        (string, required) The transaction id  
         "vout": n,            (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli updateoracle 84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2 mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF '[{"currency": "USD", "token": "BTC"}, {"currency": "EUR", "token":"ETH"]}' 20  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "updateoracle", "params": [84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2 mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF '[{"currency": "USD", "token": "BTC"}, {"currency": "EUR", "token":"ETH"]}' 20] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

## Poolpair
<details><summary>addpoolliquidity {"address":"str"} "shareAddress" ( [{"txid":"hex","vout":n},...] )</summary><p>
addpoolliquidity {"address":"str"} "shareAddress" ( [{"txid":"hex","vout":n},...] )  
  
Creates (and submits to local node and network) a add pool liquidity transaction.  
The last optional argument (may be empty array) is an array of specific UTXOs to spend.  
  
Arguments:  
1. from                     (json object, required)  
     {  
       "address": "str",    (string, required) The defi address(es) is the key(s), the value(s) is amount in amount@token format. You should provide exectly two types of tokens for pool's 'token A' and 'token B' in any combinations.If multiple tokens from one address are to be transferred, specify an array ["amount1@t1", "amount2@t2"]If "from" obj contain only one amount entry with address-key: "*" (star), it's means auto-selection accounts from wallet.  
     }  
2. shareAddress             (string, required) The defi address for crediting tokens.  
3. inputs                   (json array, optional) A json array of json objects  
     [  
       {                    (json object)  
         "txid": "hex",     (string, required) The transaction id  
         "vout": n,         (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli addpoolliquidity '{"address1":"1.0@DFI","address2":"1.0@DFI"}' share_address '[]'  
> defi-cli addpoolliquidity '{"*": ["2.0@BTC", "3.0@ETH"]}' share_address '[]'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "addpoolliquidity", "params": ['{"address1":"1.0@DFI","address2":"1.0@DFI"}' share_address '[]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>compositeswap {"from":"str","tokenFrom":"str","amountFrom":n,"to":"str","tokenTo":"str","maxPrice":n} ( [{"txid":"hex","vout":n},...] )</summary><p>
compositeswap {"from":"str","tokenFrom":"str","amountFrom":n,"to":"str","tokenTo":"str","maxPrice":n} ( [{"txid":"hex","vout":n},...] )  
  
Creates (and submits to local node and network) a composite swap (swap between multiple poolpairs) transaction with given metadata.  
The second optional argument (may be empty array) is an array of specific UTXOs to spend.  
  
Arguments:  
1. metadata                   (json object, required)  
     {  
       "from": "str",         (string, required) Address of the owner of tokenA.  
       "tokenFrom": "str",    (string, required) One of the keys may be specified (id/symbol)  
       "amountFrom": n,       (numeric, required) tokenFrom coins amount  
       "to": "str",           (string, required) Address of the owner of tokenB.  
       "tokenTo": "str",      (string, required) One of the keys may be specified (id/symbol)  
       "maxPrice": n,         (numeric) Maximum acceptable price  
     }  
2. inputs                     (json array, optional) A json array of json objects  
     [  
       {                      (json object)  
         "txid": "hex",       (string, required) The transaction id  
         "vout": n,           (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli compositeswap '{"from":"MyAddress","tokenFrom":"MyToken1","amountFrom":"0.001","to":"Address","tokenTo":"Token2","maxPrice":"0.01"}' '[{"txid":"id","vout":0}]'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "compositeswap", "params": ['{"from":"MyAddress","tokenFrom":"MyToken1","amountFrom":"0.001","to":"Address","tokenTo":"Token2","maxPrice":"0.01"}' '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>createpoolpair ( {"tokenA":"str","tokenB":"str","commission":n,"status":bool,"ownerAddress":"str","customRewards":"str","pairSymbol":"str"} [{"txid":"hex","vout":n},...] )</summary><p>
createpoolpair ( {"tokenA":"str","tokenB":"str","commission":n,"status":bool,"ownerAddress":"str","customRewards":"str","pairSymbol":"str"} [{"txid":"hex","vout":n},...] )  
  
Creates (and submits to local node and network) a poolpair transaction with given metadata.  
The second optional argument (may be empty array) is an array of specific UTXOs to spend.  
  
Arguments:  
1. metadata                       (json object)  
     {  
       "tokenA": "str",           (string, required) One of the keys may be specified (id/symbol)  
       "tokenB": "str",           (string, required) One of the keys may be specified (id/symbol)  
       "commission": n,           (numeric, required) Pool commission, up to 10^-8  
       "status": bool,            (boolean, required) Pool Status: True is Active, False is Restricted  
       "ownerAddress": "str",     (string, required) Address of the pool owner.  
       "customRewards": "str",    (string) Token reward to be paid on each block, multiple can be specified.  
       "pairSymbol": "str",       (string) Pair symbol (unique), no longer than 8  
     }  
2. inputs                         (json array, optional) A json array of json objects  
     [  
       {                          (json object)  
         "txid": "hex",           (string, required) The transaction id  
         "vout": n,               (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli createpoolpair '{"tokenA":"MyToken1","tokenB":"MyToken2","commission":"0.001","status":"True","ownerAddress":"Address","customRewards":"[\"1@tokena\",\"10@tokenb\"]"}' '[{"txid":"id","vout":0}]'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createpoolpair", "params": ['{"tokenA":"MyToken1","tokenB":"MyToken2","commission":"0.001","status":"True","ownerAddress":"Address","customRewards":"[\"1@tokena\",\"10@tokenb\"]"}' '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getpoolpair "key" ( verbose )</summary><p>
getpoolpair "key" ( verbose )  
  
Returns information about pool.  
  
Arguments:  
1. key        (string, required) One of the keys may be specified (id/symbol/creationTx)  
2. verbose    (boolean) Flag for verbose list (default = true), otherwise limited objects are listed  
  
Result:  
{id:{...}}     (array) Json object with pool information  
  
Examples:  
> defi-cli getpoolpair GOLD  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getpoolpair", "params": [GOLD] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listloantokenliquidity</summary><p>
listloantokenliquidity  
  
Returns information about the average liquidity for loan tokens if a sufficient sample is available.  
  
Result:  
{token symbol : value }     (array) JSON object with token ID and average liquidity  
  
Examples:  
> defi-cli listloantokenliquidity   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listloantokenliquidity", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listpoolpairs ( {"start":n,"including_start":bool,"limit":n} verbose )</summary><p>
listpoolpairs ( {"start":n,"including_start":bool,"limit":n} verbose )  
  
Returns information about pools.  
  
Arguments:  
1. pagination                      (json object)  
     {  
       "start": n,                 (numeric) Optional first key to iterate from, in lexicographical order.Typically it's set to last ID from previous request.  
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default  
       "limit": n,                 (numeric) Maximum number of pools to return, 100 by default  
     }  
2. verbose                         (boolean) Flag for verbose list (default = true), otherwise only ids, symbols and names are listed  
  
Result:  
{id:{...},...}     (array) Json object with pools information  
  
Examples:  
> defi-cli listpoolpairs '{"start":128}' false  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listpoolpairs", "params": ['{"start":128}' false] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listpoolshares ( {"start":n,"including_start":bool,"limit":n} verbose is_mine_only )</summary><p>
listpoolshares ( {"start":n,"including_start":bool,"limit":n} verbose is_mine_only )  
  
Returns information about pool shares.  
  
Arguments:  
1. pagination                      (json object)  
     {  
       "start": n,                 (numeric) Optional first key to iterate from, in lexicographical order.  
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default  
       "limit": n,                 (numeric) Maximum number of pools to return, 100 by default  
     }  
2. verbose                         (boolean) Flag for verbose list (default = true), otherwise only % are shown.  
3. is_mine_only                    (boolean) Get shares for all accounts belonging to the wallet (default = false)  
  
Result:  
{id:{...},...}     (array) Json object with pools information  
  
Examples:  
> defi-cli listpoolshares '{"start":128}' false false  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listpoolshares", "params": ['{"start":128}' false false] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>poolswap {"from":"str","tokenFrom":"str","amountFrom":n,"to":"str","tokenTo":"str","maxPrice":n} ( [{"txid":"hex","vout":n},...] )</summary><p>
poolswap {"from":"str","tokenFrom":"str","amountFrom":n,"to":"str","tokenTo":"str","maxPrice":n} ( [{"txid":"hex","vout":n},...] )  
  
Creates (and submits to local node and network) a poolswap transaction with given metadata.  
The second optional argument (may be empty array) is an array of specific UTXOs to spend.  
  
Arguments:  
1. metadata                   (json object, required)  
     {  
       "from": "str",         (string, required) Address of the owner of tokenA.  
       "tokenFrom": "str",    (string, required) One of the keys may be specified (id/symbol)  
       "amountFrom": n,       (numeric, required) tokenFrom coins amount  
       "to": "str",           (string, required) Address of the owner of tokenB.  
       "tokenTo": "str",      (string, required) One of the keys may be specified (id/symbol)  
       "maxPrice": n,         (numeric) Maximum acceptable price  
     }  
2. inputs                     (json array, optional) A json array of json objects  
     [  
       {                      (json object)  
         "txid": "hex",       (string, required) The transaction id  
         "vout": n,           (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli poolswap '{"from":"MyAddress","tokenFrom":"MyToken1","amountFrom":"0.001","to":"Address","tokenTo":"Token2","maxPrice":"0.01"}' '[{"txid":"id","vout":0}]'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "poolswap", "params": ['{"from":"MyAddress","tokenFrom":"MyToken1","amountFrom":"0.001","to":"Address","tokenTo":"Token2","maxPrice":"0.01"}' '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>removepoolliquidity "from" "amount" ( [{"txid":"hex","vout":n},...] )</summary><p>
removepoolliquidity "from" "amount" ( [{"txid":"hex","vout":n},...] )  
  
Creates (and submits to local node and network) a remove pool liquidity transaction.  
The last optional argument (may be empty array) is an array of specific UTXOs to spend.  
  
Arguments:  
1. from                    (string, required) The defi address which has tokens  
2. amount                  (string, required) Liquidity amount@Liquidity pool symbol  
3. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli removepoolliquidity from_address 1.0@LpSymbol  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "removepoolliquidity", "params": [from_address 1.0@LpSymbol] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>testpoolswap ( {"from":"str","tokenFrom":"str","amountFrom":n,"to":"str","tokenTo":"str","maxPrice":n} "path" verbose )</summary><p>
testpoolswap ( {"from":"str","tokenFrom":"str","amountFrom":n,"to":"str","tokenTo":"str","maxPrice":n} "path" verbose )  
  
Tests a poolswap transaction with given metadata and returns poolswap result.  
  
Arguments:  
1. metadata                   (json object)  
     {  
       "from": "str",         (string, required) Address of the owner of tokenA.  
       "tokenFrom": "str",    (string, required) One of the keys may be specified (id/symbol)  
       "amountFrom": n,       (numeric, required) tokenFrom coins amount  
       "to": "str",           (string, required) Address of the owner of tokenB.  
       "tokenTo": "str",      (string, required) One of the keys may be specified (id/symbol)  
       "maxPrice": n,         (numeric) Maximum acceptable price  
     }  
2. path                       (string) One of auto/direct (default = direct)  
                              auto - automatically use composite swap or direct swap as needed.  
                              direct - uses direct path only or fails.  
                              composite - uses composite path only or fails.  
                              Note: The default will be switched to auto in the upcoming versions.  
3. verbose                    (boolean) Returns estimated composite path when true (default = false)  
  
Result:  
"amount@tokenId"    (string) The string with amount result of poolswap in format AMOUNT@TOKENID.  
  
Examples:  
> defi-cli testpoolswap '{"from":"MyAddress","tokenFrom":"MyToken1","amountFrom":"0.001","to":"Address","tokenTo":"Token2","maxPrice":"0.01"}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "testpoolswap", "params": ['{"from":"MyAddress","tokenFrom":"MyToken1","amountFrom":"0.001","to":"Address","tokenTo":"Token2","maxPrice":"0.01"}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>updatepoolpair ( {"pool":"str","status":bool,"commission":n,"ownerAddress":"str","customRewards":"str","name":"str","symbol":"str"} [{"txid":"hex","vout":n},...] )</summary><p>
updatepoolpair ( {"pool":"str","status":bool,"commission":n,"ownerAddress":"str","customRewards":"str","name":"str","symbol":"str"} [{"txid":"hex","vout":n},...] )  
  
Creates (and submits to local node and network) a pool status update transaction.  
The second optional argument (may be empty array) is an array of specific UTXOs to spend. One of UTXO's must belong to the pool's owner (collateral) address  
  
Arguments:  
1. metadata                       (json object)  
     {  
       "pool": "str",             (string, required) The pool's symbol, id or creation tx  
       "status": bool,            (boolean) Pool Status new property (bool)  
       "commission": n,           (numeric) Pool commission, up to 10^-8  
       "ownerAddress": "str",     (string) Address of the pool owner.  
       "customRewards": "str",    (string) Token reward to be paid on each block, multiple can be specified.  
       "name": "str",             (string, required) Pool name  
       "symbol": "str",           (string, required) Pool symbol  
     }  
2. inputs                         (json array, optional) A json array of json objects  
     [  
       {                          (json object)  
         "txid": "hex",           (string, required) The transaction id  
         "vout": n,               (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli updatepoolpair '{"pool":"POOL","status":true,"commission":0.01,"ownerAddress":"Address","customRewards":"[\"1@tokena\",\"10@tokenb\"]"}' '[{"txid":"id","vout":0}]'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "updatepoolpair", "params": ['{"pool":"POOL","status":true,"commission":0.01,"ownerAddress":"Address","customRewards":"[\"1@tokena\",\"10@tokenb\"]"}' '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

## Proposals
<details><summary>creategovcfp ( {"title":"str","context":"str","contextHash":"str","cycles":n,"amount":amount,"payoutAddress":"str"} [{"txid":"hex","vout":n},...] )</summary><p>
creategovcfp ( {"title":"str","context":"str","contextHash":"str","cycles":n,"amount":amount,"payoutAddress":"str"} [{"txid":"hex","vout":n},...] )  
  
Creates a Community Fund Proposal  
  
Arguments:  
1. data                           (json object, optional) data in json-form, containing cfp data  
     {  
       "title": "str",            (string, required) The title of community fund request  
       "context": "str",          (string, required) The context field of community fund request  
       "contextHash": "str",      (string) The hash of the content which context field point to of community fund request  
       "cycles": n,               (numeric) Defaulted to one cycle  
       "amount": amount,          (numeric or string, required) Amount in DFI to request  
       "payoutAddress": "str",    (string, required) Any valid address for receiving  
     }  
2. inputs                         (json array, optional) A json array of json objects  
     [  
       {                          (json object)  
         "txid": "hex",           (string, required) The transaction id  
         "vout": n,               (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli creategovcfp '{"title":"The cfp title","context":"The cfp context","amount":10,"payoutAddress":"address"}' '[{"txid":"id","vout":0}]'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "creategovcfp", "params": ['{"title":"The cfp title","context":"The cfp context","amount":10,"payoutAddress":"address"} '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>creategovvoc ( {"title":"str","context":"str","contextHash":"str","emergency":bool,"special":bool} [{"txid":"hex","vout":n},...] )</summary><p>
creategovvoc ( {"title":"str","context":"str","contextHash":"str","emergency":bool,"special":bool} [{"txid":"hex","vout":n},...] )  
  
Creates a Vote of Confidence  
  
Arguments:  
1. data                         (json object, optional) data in json-form, containing voc data  
     {  
       "title": "str",          (string, required) The title of vote of confidence  
       "context": "str",        (string, required) The context field for vote of confidence  
       "contextHash": "str",    (string) The hash of the content which context field point to of vote of confidence request  
       "emergency": bool,       (boolean) Is this emergency VOC  
       "special": bool,         (boolean) Preferred alias for emergency VOC  
     }  
2. inputs                       (json array, optional) A json array of json objects  
     [  
       {                        (json object)  
         "txid": "hex",         (string, required) The transaction id  
         "vout": n,             (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli creategovvoc 'The voc title' 'The voc context' '[{"txid":"id","vout":0}]'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "creategovvoc", "params": ['The voc title' 'The voc context' '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getgovproposal "proposalId"</summary><p>
getgovproposal "proposalId"  
  
Returns real time information about proposal state.  
  
Arguments:  
1. proposalId    (string, required) The proposal id)  
  
Result:  
{id:{...},...}     (obj) Json object with proposal vote information  
  
Examples:  
> defi-cli getgovproposal txid  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getgovproposal", "params": [txid] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listgovproposals ( "type" "status" cycle {"start":"hex","including_start":bool,"limit":n} )</summary><p>
listgovproposals ( "type" "status" cycle {"start":"hex","including_start":bool,"limit":n} )  
  
Returns information about proposals.  
  
Arguments:  
1. type                            (string) cfp/voc/all (default = all)  
2. status                          (string) voting/rejected/completed/all (default = all)  
3. cycle                           (numeric) cycle: 0 (all), cycle: N (show cycle N), cycle: -1 (show previous cycle) (default = 0)  
4. pagination                      (json object)  
     {  
       "start": "hex",             (string) Proposal id to iterate from.Typically it's set to last ID from previous request.  
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default  
       "limit": n,                 (numeric) Maximum number of proposals to return, 100 by default  
     }  
  
Result:  
{id:{...},...}     (array) Json object with proposals information  
  
Examples:  
> defi-cli listgovproposals   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listgovproposals", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listgovproposalvotes ( "proposalId" "masternode" cycle {"start":n,"including_start":bool,"limit":n} aggregate valid )</summary><p>
listgovproposalvotes ( "proposalId" "masternode" cycle {"start":n,"including_start":bool,"limit":n} aggregate valid )  
  
Returns information about proposal votes.  
  
Arguments:  
1. proposalId                      (string) The proposal id)  
2. masternode                      (string) mine/all/id (default = mine)  
3. cycle                           (numeric) cycle: 0 (show current), cycle: N (show cycle N), cycle: -1 (show all) (default = 0)  
4. pagination                      (json object)  
     {  
       "start": n,                 (numeric) Vote index to iterate from.Typically it's set to last ID from previous request.  
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default  
       "limit": n,                 (numeric) Maximum number of votes to return, 100 by default  
     }  
5. aggregate                       (boolean) 0: return raw vote data, 1: return total votes by type  
6. valid                           (boolean) 0: show only invalid votes at current height, 1: show only valid votes at current height (default: 1)  
  
Result:  
{id:{...},...}     (array) Json object with proposal vote information  
  
Examples:  
> defi-cli listgovproposalvotes txid  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listgovproposalvotes", "params": [txid] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>votegov "proposalId" "masternodeId" "decision" ( [{"txid":"hex","vout":n},...] )</summary><p>
votegov "proposalId" "masternodeId" "decision" ( [{"txid":"hex","vout":n},...] )  
  
Vote for community proposal  
  
Arguments:  
1. proposalId              (string, required) The proposal txid  
2. masternodeId            (string, required) The masternode id / owner address / operator address which made the vote  
3. decision                (string, required) The vote decision (yes/no/neutral)  
4. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli votegov txid masternodeId yes  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "votegov", "params": [txid masternodeId yes] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>votegovbatch ["proposalId","masternodeId","decision",...] ( sleepTime )</summary><p>
votegovbatch ["proposalId","masternodeId","decision",...] ( sleepTime )  
  
Vote for community proposal with multiple masternodes  
  
Arguments:  
1. votes                  (json array, required) A json array of proposal ID, masternode IDs, operator or owner addresses and vote decision (yes/no/neutral).  
     [  
       "proposalId",      (string) The proposal txid  
       "masternodeId",    (string) The masternode ID, operator or owner address  
       "decision",        (string) The vote decision (yes/no/neutral)  
       ...  
     ]  
2. sleepTime              (numeric) No. of milliseconds to wait between each vote. A small wait time is required for large number of votes to prevent the node from being too busy to broadcast TXs (default: 500)  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli votegovbatch {{proposalId, masternodeId, yes}...}  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "votegovbatch", "params": [{{proposalId, masternodeId, yes}...}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

## Rawtransactions
<details><summary>analyzepsbt "psbt"</summary><p>
analyzepsbt "psbt"  
  
Analyzes and provides information about the current status of a PSBT and its inputs  
  
Arguments:  
1. psbt    (string, required) A base64 string of a PSBT  
  
Result:  
{  
  "inputs" : [                      (array of json objects)  
    {  
      "has_utxo" : true|false     (boolean) Whether a UTXO is provided  
      "is_final" : true|false     (boolean) Whether the input is finalized  
      "missing" : {               (json object, optional) Things that are missing that are required to complete this input  
        "pubkeys" : [             (array, optional)  
          "keyid"                 (string) Public key ID, hash160 of the public key, of a public key whose BIP 32 derivation path is missing  
        ]  
        "signatures" : [          (array, optional)  
          "keyid"                 (string) Public key ID, hash160 of the public key, of a public key whose signature is missing  
        ]  
        "redeemscript" : "hash"   (string, optional) Hash160 of the redeemScript that is missing  
        "witnessscript" : "hash"  (string, optional) SHA256 of the witnessScript that is missing  
      }  
      "next" : "role"             (string, optional) Role of the next person that this input needs to go to  
    }  
    ,...  
  ]  
  "estimated_vsize" : vsize       (numeric, optional) Estimated vsize of the final signed transaction  
  "estimated_feerate" : feerate   (numeric, optional) Estimated feerate of the final signed transaction in DFI/kB. Shown only if all UTXO slots in the PSBT have been filled.  
  "fee" : fee                     (numeric, optional) The transaction fee paid. Shown only if all UTXO slots in the PSBT have been filled.  
  "next" : "role"                 (string) Role of the next person that this psbt needs to go to  
}  
  
Examples:  
> defi-cli analyzepsbt "psbt"  

</p></details>

<details><summary>combinepsbt ["psbt",...]</summary><p>
combinepsbt ["psbt",...]  
  
Combine multiple partially signed Defi transactions into one transaction.  
Implements the Combiner role.  
  
Arguments:  
1. txs            (json array, required) A json array of base64 strings of partially signed transactions  
     [  
       "psbt",    (string) A base64 string of a PSBT  
       ...  
     ]  
  
Result:  
  "psbt"          (string) The base64-encoded partially signed transaction  
  
Examples:  
> defi-cli combinepsbt ["mybase64_1", "mybase64_2", "mybase64_3"]  

</p></details>

<details><summary>combinerawtransaction ["hexstring",...]</summary><p>
combinerawtransaction ["hexstring",...]  
  
Combine multiple partially signed transactions into one transaction.  
The combined transaction may be another partially signed transaction or a   
fully signed transaction.  
Arguments:  
1. txs                 (json array, required) A json array of hex strings of partially signed transactions  
     [  
       "hexstring",    (string) A transaction hash  
       ...  
     ]  
  
Result:  
"hex"            (string) The hex-encoded raw transaction with signature(s)  
  
Examples:  
> defi-cli combinerawtransaction ["myhex1", "myhex2", "myhex3"]  

</p></details>

<details><summary>converttopsbt "hexstring" ( permitsigdata iswitness )</summary><p>
converttopsbt "hexstring" ( permitsigdata iswitness )  
  
Converts a network serialized transaction to a PSBT. This should be used only with createrawtransaction and fundrawtransaction  
createpsbt and walletcreatefundedpsbt should be used for new applications.  
  
Arguments:  
1. hexstring        (string, required) The hex string of a raw transaction  
2. permitsigdata    (boolean, optional, default=false) If true, any signatures in the input will be discarded and conversion  
                    will continue. If false, RPC will fail if any signatures are present.  
3. iswitness        (boolean, optional, default=depends on heuristic tests) Whether the transaction hex is a serialized witness transaction.  
                    If iswitness is not present, heuristic tests will be used in decoding.  
                    If true, only witness deserialization will be tried.  
                    If false, only non-witness deserialization will be tried.  
                    This boolean should reflect whether the transaction has inputs  
                    (e.g. fully valid, or on-chain transactions), if known by the caller.  
  
Result:  
  "psbt"        (string)  The resulting raw transaction (base64-encoded string)  
  
Examples:  
  
Create a transaction  
> defi-cli createrawtransaction "[{\"txid\":\"myid\",\"vout\":0}]" "[{\"data\":\"00010203\"}]"  
  
Convert the transaction to a PSBT  
> defi-cli converttopsbt "rawtransaction"  

</p></details>

<details><summary>createpsbt [{"txid":"hex","vout":n,"sequence":n},...] [{"address":amount},{"data":"hex"},...] ( locktime replaceable )</summary><p>
createpsbt [{"txid":"hex","vout":n,"sequence":n},...] [{"address":amount},{"data":"hex"},...] ( locktime replaceable )  
  
Creates a transaction in the Partially Signed Transaction format.  
Implements the Creator role.  
  
Arguments:  
1. inputs                      (json array, required) A json array of json objects  
     [  
       {                       (json object)  
         "txid": "hex",        (string, required) The transaction id  
         "vout": n,            (numeric, required) The output number  
         "sequence": n,        (numeric, optional, default=depends on the value of the 'replaceable' and 'locktime' arguments) The sequence number  
       },  
       ...  
     ]  
2. outputs                     (json array, required) a json array with outputs (key-value pairs), where none of the keys are duplicated.  
                               That is, each address can only appear once and there can only be one 'data' object.  
                               For compatibility reasons, a dictionary, which holds the key-value pairs directly, is also  
                               accepted as second parameter.  
     [  
       {                       (json object)  
         "address": amount,    (numeric or string, required) A key-value pair. The key (string) is the DFI address, the value (float or string) is the amount in DFI  
       },  
       {                       (json object)  
         "data": "hex",        (string, required) A key-value pair. The key must be "data", the value is hex-encoded data  
       },  
       ...  
     ]  
3. locktime                    (numeric, optional, default=0) Raw locktime. Non-0 value also locktime-activates inputs  
4. replaceable                 (boolean, optional, default=false) Marks this transaction as BIP125 replaceable.  
                               Allows this transaction to be replaced by a transaction with higher fees. If provided, it is an error if explicit sequence numbers are incompatible.  
  
Result:  
  "psbt"        (string)  The resulting raw transaction (base64-encoded string)  
  
Examples:  
> defi-cli createpsbt "[{\"txid\":\"myid\",\"vout\":0}]" "[{\"data\":\"00010203\"}]"  

</p></details>

<details><summary>createrawtransaction [{"txid":"hex","vout":n,"sequence":n},...] [{"address":amount},{"data":"hex"},...] ( locktime replaceable )</summary><p>
createrawtransaction [{"txid":"hex","vout":n,"sequence":n},...] [{"address":amount},{"data":"hex"},...] ( locktime replaceable )  
  
Create a transaction spending the given inputs and creating new outputs.  
Outputs can be addresses or data.  
Returns hex-encoded raw transaction.  
Note that the transaction's inputs are not signed, and  
it is not stored in the wallet or transmitted to the network.  
  
Arguments:  
1. inputs                      (json array, required) A json array of json objects  
     [  
       {                       (json object)  
         "txid": "hex",        (string, required) The transaction id  
         "vout": n,            (numeric, required) The output number  
         "sequence": n,        (numeric, optional, default=depends on the value of the 'replaceable' and 'locktime' arguments) The sequence number  
       },  
       ...  
     ]  
2. outputs                     (json array, required) a json array with outputs (key-value pairs), where none of the keys are duplicated.  
                               That is, each address can only appear once and there can only be one 'data' object.  
                               For compatibility reasons, a dictionary, which holds the key-value pairs directly, is also  
                               accepted as second parameter.  
     [  
       {                       (json object)  
         "address": amount,    (numeric or string, required) A key-value pair. The key (string) is the DFI address, the value (float or string) is the amount in DFI  
       },  
       {                       (json object)  
         "data": "hex",        (string, required) A key-value pair. The key must be "data", the value is hex-encoded data  
       },  
       ...  
     ]  
3. locktime                    (numeric, optional, default=0) Raw locktime. Non-0 value also locktime-activates inputs  
4. replaceable                 (boolean, optional, default=false) Marks this transaction as BIP125-replaceable.  
                               Allows this transaction to be replaced by a transaction with higher fees. If provided, it is an error if explicit sequence numbers are incompatible.  
  
Result:  
"transaction"              (string) hex string of the transaction  
  
Examples:  
> defi-cli createrawtransaction "[{\"txid\":\"myid\",\"vout\":0}]" "[{\"address\":0.01}]"  
> defi-cli createrawtransaction "[{\"txid\":\"myid\",\"vout\":0}]" "[{\"data\":\"00010203\"}]"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createrawtransaction", "params": ["[{\"txid\":\"myid\",\"vout\":0}]", "[{\"address\":0.01}]"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createrawtransaction", "params": ["[{\"txid\":\"myid\",\"vout\":0}]", "[{\"data\":\"00010203\"}]"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>decodepsbt "psbt"</summary><p>
decodepsbt "psbt"  
  
Return a JSON object representing the serialized, base64-encoded partially signed Defi transaction.  
  
Arguments:  
1. psbt    (string, required) The PSBT base64 string  
  
Result:  
{  
  "tx" : {                   (json object) The decoded network-serialized unsigned transaction.  
    ...                                      The layout is the same as the output of decoderawtransaction.  
  },  
  "unknown" : {                (json object) The unknown global fields  
    "key" : "value"            (key-value pair) An unknown key-value pair  
     ...  
  },  
  "inputs" : [                 (array of json objects)  
    {  
      "non_witness_utxo" : {   (json object, optional) Decoded network transaction for non-witness UTXOs  
        ...  
      },  
      "witness_utxo" : {            (json object, optional) Transaction output for witness UTXOs  
        "amount" : x.xxx,           (numeric) The value in DFI  
        "scriptPubKey" : {          (json object)  
          "asm" : "asm",            (string) The asm  
          "hex" : "hex",            (string) The hex  
          "type" : "pubkeyhash",    (string) The type, eg 'pubkeyhash'  
          "address" : "address"     (string) Defi address if there is one  
        }  
      },  
      "partial_signatures" : {             (json object, optional)  
        "pubkey" : "signature",           (string) The public key and signature that corresponds to it.  
        ,...  
      }  
      "sighash" : "type",                  (string, optional) The sighash type to be used  
      "redeem_script" : {       (json object, optional)  
          "asm" : "asm",            (string) The asm  
          "hex" : "hex",            (string) The hex  
          "type" : "pubkeyhash",    (string) The type, eg 'pubkeyhash'  
        }  
      "witness_script" : {       (json object, optional)  
          "asm" : "asm",            (string) The asm  
          "hex" : "hex",            (string) The hex  
          "type" : "pubkeyhash",    (string) The type, eg 'pubkeyhash'  
        }  
      "bip32_derivs" : {          (json object, optional)  
        "pubkey" : {                     (json object, optional) The public key with the derivation path as the value.  
          "master_fingerprint" : "fingerprint"     (string) The fingerprint of the master key  
          "path" : "path",                         (string) The path  
        }  
        ,...  
      }  
      "final_scriptsig" : {       (json object, optional)  
          "asm" : "asm",            (string) The asm  
          "hex" : "hex",            (string) The hex  
        }  
       "final_scriptwitness": ["hex", ...] (array of string) hex-encoded witness data (if any)  
      "unknown" : {                (json object) The unknown global fields  
        "key" : "value"            (key-value pair) An unknown key-value pair  
         ...  
      },  
    }  
    ,...  
  ]  
  "outputs" : [                 (array of json objects)  
    {  
      "redeem_script" : {       (json object, optional)  
          "asm" : "asm",            (string) The asm  
          "hex" : "hex",            (string) The hex  
          "type" : "pubkeyhash",    (string) The type, eg 'pubkeyhash'  
        }  
      "witness_script" : {       (json object, optional)  
          "asm" : "asm",            (string) The asm  
          "hex" : "hex",            (string) The hex  
          "type" : "pubkeyhash",    (string) The type, eg 'pubkeyhash'  
      }  
      "bip32_derivs" : [          (array of json objects, optional)  
        {  
          "pubkey" : "pubkey",                     (string) The public key this path corresponds to  
          "master_fingerprint" : "fingerprint"     (string) The fingerprint of the master key  
          "path" : "path",                         (string) The path  
          }  
        }  
        ,...  
      ],  
      "unknown" : {                (json object) The unknown global fields  
        "key" : "value"            (key-value pair) An unknown key-value pair  
         ...  
      },  
    }  
    ,...  
  ]  
  "fee" : fee                      (numeric, optional) The transaction fee paid if all UTXOs slots in the PSBT have been filled.  
}  
  
Examples:  
> defi-cli decodepsbt "psbt"  

</p></details>

<details><summary>decoderawtransaction "hexstring" ( iswitness )</summary><p>
decoderawtransaction "hexstring" ( iswitness )  
  
Return a JSON object representing the serialized, hex-encoded transaction.  
  
Arguments:  
1. hexstring    (string, required) The transaction hex string  
2. iswitness    (boolean, optional, default=depends on heuristic tests) Whether the transaction hex is a serialized witness transaction.  
                If iswitness is not present, heuristic tests will be used in decoding.  
                If true, only witness deserialization will be tried.  
                If false, only non-witness deserialization will be tried.  
                This boolean should reflect whether the transaction has inputs  
                (e.g. fully valid, or on-chain transactions), if known by the caller.  
  
Result:  
{  
  "txid" : "id",        (string) The transaction id  
  "hash" : "id",        (string) The transaction hash (differs from txid for witness transactions)  
  "size" : n,             (numeric) The transaction size  
  "vsize" : n,            (numeric) The virtual transaction size (differs from size for witness transactions)  
  "weight" : n,           (numeric) The transaction's weight (between vsize*4 - 3 and vsize*4)  
  "version" : n,          (numeric) The version  
  "locktime" : ttt,       (numeric) The lock time  
  "vin" : [               (array of json objects)  
     {  
       "txid": "id",    (string) The transaction id  
       "vout": n,         (numeric) The output number  
       "scriptSig": {     (json object) The script  
         "asm": "asm",  (string) asm  
         "hex": "hex"   (string) hex  
       },  
       "txinwitness": ["hex", ...] (array of string) hex-encoded witness data (if any)  
       "sequence": n     (numeric) The script sequence number  
     }  
     ,...  
  ],  
  "vout" : [             (array of json objects)  
     {  
       "value" : x.xxx,            (numeric) The value in DFI  
       "n" : n,                    (numeric) index  
       "scriptPubKey" : {          (json object)  
         "asm" : "asm",          (string) the asm  
         "hex" : "hex",          (string) the hex  
         "reqSigs" : n,            (numeric) The required sigs  
         "type" : "pubkeyhash",  (string) The type, eg 'pubkeyhash'  
         "addresses" : [           (json array of string)  
           "12tvKAXCxZjSmdNbao16dKXC8tRWfcF5oc"   (string) defi address  
           ,...  
         ]  
       }  
     }  
     ,...  
  ],  
}  
  
Examples:  
> defi-cli decoderawtransaction "hexstring"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "decoderawtransaction", "params": ["hexstring"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>decodescript "hexstring"</summary><p>
decodescript "hexstring"  
  
Decode a hex-encoded script.  
  
Arguments:  
1. hexstring    (string, required) the hex-encoded script  
  
Result:  
{  
  "asm":"asm",          (string) Script public key  
  "type":"type",        (string) The output type (e.g. nonstandard, pubkey, pubkeyhash, scripthash, multisig, nulldata, witness_v0_scripthash, witness_v0_keyhash, witness_v16_ethhash, witness_unknown)  
  "reqSigs": n,         (numeric) The required signatures  
  "addresses": [        (json array of string)  
     "address"          (string) defi address  
     ,...  
  ],  
  "p2sh":"str"          (string) address of P2SH script wrapping this redeem script (not returned if the script is already a P2SH).  
  "segwit": {           (json object) Result of a witness script public key wrapping this redeem script (not returned if the script is a P2SH or witness).  
    "asm":"str",        (string) String representation of the script public key  
    "hex":"hexstr",     (string) Hex string of the script public key  
    "type":"str",       (string) The type of the script public key (e.g. witness_v0_keyhash or witness_v0_scripthash)  
    "reqSigs": n,       (numeric) The required signatures (always 1)  
    "addresses": [      (json array of string) (always length 1)  
      "address"         (string) segwit address  
       ,...  
    ],  
    "p2sh-segwit":"str" (string) address of the P2SH script wrapping this witness redeem script.  
}  
  
Examples:  
> defi-cli decodescript "hexstring"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "decodescript", "params": ["hexstring"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>finalizepsbt "psbt" ( extract )</summary><p>
finalizepsbt "psbt" ( extract )  
Finalize the inputs of a PSBT. If the transaction is fully signed, it will produce a  
network serialized transaction which can be broadcast with sendrawtransaction. Otherwise a PSBT will be  
created which has the final_scriptSig and final_scriptWitness fields filled for inputs that are complete.  
Implements the Finalizer and Extractor roles.  
  
Arguments:  
1. psbt       (string, required) A base64 string of a PSBT  
2. extract    (boolean, optional, default=true) If true and the transaction is complete,  
              extract and return the complete transaction in normal network serialization instead of the PSBT.  
  
Result:  
{  
  "psbt" : "value",          (string) The base64-encoded partially signed transaction if not extracted  
  "hex" : "value",           (string) The hex-encoded network transaction if extracted  
  "complete" : true|false,   (boolean) If the transaction has a complete set of signatures  
  ]  
}  
  
Examples:  
> defi-cli finalizepsbt "psbt"  

</p></details>

<details><summary>fundrawtransaction "hexstring" ( options iswitness )</summary><p>
fundrawtransaction "hexstring" ( options iswitness )  
  
Add inputs to a transaction until it has enough in value to meet its out value.  
This will not modify existing inputs, and will add at most one change output to the outputs.  
No existing outputs will be modified unless "subtractFeeFromOutputs" is specified.  
Note that inputs which were signed may need to be resigned after completion since in/outputs have been added.  
The inputs added will not be signed, use signrawtransactionwithkey  
 or signrawtransactionwithwallet for that.  
Note that all existing inputs must have their previous output transaction be in the wallet.  
Note that all inputs selected must be of standard form and P2SH scripts must be  
in the wallet using importaddress or addmultisigaddress (to calculate fees).  
You can see whether this is the case by checking the "solvable" field in the listunspent output.  
Only pay-to-pubkey, multisig, and P2SH versions thereof are currently supported for watch-only  
  
Arguments:  
1. hexstring                          (string, required) The hex string of the raw transaction  
2. options                            (json object, optional) for backward compatibility: passing in a true instead of an object will result in {"includeWatching":true}  
     {  
       "changeAddress": "str",        (string, optional, default=pool address) The defi address to receive the change  
       "changePosition": n,           (numeric, optional, default=random) The index of the change output  
       "change_type": "str",          (string, optional, default=set by -changetype) The output type to use. Only valid if changeAddress is not specified. Options are "legacy", "p2sh-segwit", and "bech32".  
       "includeWatching": bool,       (boolean, optional, default=true for watch-only wallets, otherwise false) Also select inputs which are watch only  
       "lockUnspents": bool,          (boolean, optional, default=false) Lock selected unspent outputs  
       "feeRate": amount,             (numeric or string, optional, default=not set: makes wallet determine the fee) Set a specific fee rate in DFI/kB  
       "subtractFeeFromOutputs": [    (json array, optional, default=empty array) A json array of integers.  
                                      The fee will be equally deducted from the amount of each specified output.  
                                      Those recipients will receive less defis than you enter in their corresponding amount field.  
                                      If no outputs are specified here, the sender pays the fee.  
         vout_index,                  (numeric) The zero-based output index, before a change output is added.  
         ...  
       ],  
       "replaceable": bool,           (boolean, optional, default=wallet default) Marks this transaction as BIP125 replaceable.  
                                      Allows this transaction to be replaced by a transaction with higher fees  
       "conf_target": n,              (numeric, optional, default=wallet default) Confirmation target (in blocks)  
       "estimate_mode": "str",        (string, optional, default=UNSET) The fee estimate mode, must be one of:  
                                      "UNSET"  
                                      "ECONOMICAL"  
                                      "CONSERVATIVE"  
     }  
3. iswitness                          (boolean, optional, default=depends on heuristic tests) Whether the transaction hex is a serialized witness transaction.  
                                      If iswitness is not present, heuristic tests will be used in decoding.  
                                      If true, only witness deserialization will be tried.  
                                      If false, only non-witness deserialization will be tried.  
                                      This boolean should reflect whether the transaction has inputs  
                                      (e.g. fully valid, or on-chain transactions), if known by the caller.  
  
Result:  
{  
  "hex":       "value", (string)  The resulting raw transaction (hex-encoded string)  
  "fee":       n,         (numeric) Fee in DFI the resulting transaction pays  
  "changepos": n          (numeric) The position of the added change output, or -1  
}  
  
Examples:  
  
Create a transaction with no inputs  
> defi-cli createrawtransaction "[]" "{\"myaddress\":0.01}"  
  
Add sufficient unsigned inputs to meet the output value  
> defi-cli fundrawtransaction "rawtransactionhex"  
  
Sign the transaction  
> defi-cli signrawtransactionwithwallet "fundedtransactionhex"  
  
Send the transaction  
> defi-cli sendrawtransaction "signedtransactionhex"  

</p></details>

<details><summary>getrawtransaction "txid" ( verbose "blockhash" )</summary><p>
getrawtransaction "txid" ( verbose "blockhash" )  
  
Return the raw transaction data.  
  
By default this function only works for mempool transactions. When called with a blockhash  
argument, getrawtransaction will return the transaction if the specified block is available and  
the transaction is found in that block. When called without a blockhash argument, getrawtransaction  
will return the transaction if it is in the mempool, or if -txindex is enabled and the transaction  
is in a block in the blockchain.  
  
Hint: Use gettransaction for wallet transactions.  
  
If verbose is 'true', returns an Object with information about 'txid'.  
If verbose is 'false' or omitted, returns a string that is serialized, hex-encoded data for 'txid'.  
  
Arguments:  
1. txid         (string, required) The transaction id  
2. verbose      (boolean, optional, default=false) If false, return a string, otherwise return a json object  
3. blockhash    (string, optional) The block in which to look for the transaction  
  
Result (if verbose is not set or set to false):  
"data"      (string) The serialized, hex-encoded data for 'txid'  
  
Result (if verbose is set to true):  
{  
  "in_active_chain": b, (bool) Whether specified block is in the active chain or not (only present with explicit "blockhash" argument)  
  "hex" : "data",       (string) The serialized, hex-encoded data for 'txid'  
  "txid" : "id",        (string) The transaction id (same as provided)  
  "hash" : "id",        (string) The transaction hash (differs from txid for witness transactions)  
  "size" : n,             (numeric) The serialized transaction size  
  "vsize" : n,            (numeric) The virtual transaction size (differs from size for witness transactions)  
  "weight" : n,           (numeric) The transaction's weight (between vsize*4-3 and vsize*4)  
  "version" : n,          (numeric) The version  
  "locktime" : ttt,       (numeric) The lock time  
  "vin" : [               (array of json objects)  
     {  
       "txid": "id",    (string) The transaction id  
       "vout": n,         (numeric)   
       "scriptSig": {     (json object) The script  
         "asm": "asm",  (string) asm  
         "hex": "hex"   (string) hex  
       },  
       "sequence": n      (numeric) The script sequence number  
       "txinwitness": ["hex", ...] (array of string) hex-encoded witness data (if any)  
     }  
     ,...  
  ],  
  "vout" : [              (array of json objects)  
     {  
       "value" : x.xxx,            (numeric) The value in DFI  
       "n" : n,                    (numeric) index  
       "scriptPubKey" : {          (json object)  
         "asm" : "asm",          (string) the asm  
         "hex" : "hex",          (string) the hex  
         "reqSigs" : n,            (numeric) The required sigs  
         "type" : "pubkeyhash",  (string) The type, eg 'pubkeyhash'  
         "addresses" : [           (json array of string)  
           "address"        (string) defi address  
           ,...  
         ]  
       }  
     }  
     ,...  
  ],  
  "blockhash" : "hash",   (string) the block hash  
  "confirmations" : n,      (numeric) The confirmations  
  "blocktime" : ttt         (numeric) The block time in seconds since epoch (Jan 1 1970 GMT)  
  "time" : ttt,             (numeric) Same as "blocktime"  
}  
  
Examples:  
> defi-cli getrawtransaction "mytxid"  
> defi-cli getrawtransaction "mytxid" true  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getrawtransaction", "params": ["mytxid", true] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> defi-cli getrawtransaction "mytxid" false "myblockhash"  
> defi-cli getrawtransaction "mytxid" true "myblockhash"  

</p></details>

<details><summary>joinpsbts ["psbt",...]</summary><p>
joinpsbts ["psbt",...]  
  
Joins multiple distinct PSBTs with different inputs and outputs into one PSBT with inputs and outputs from all of the PSBTs  
No input in any of the PSBTs can be in more than one of the PSBTs.  
  
Arguments:  
1. txs            (json array, required) A json array of base64 strings of partially signed transactions  
     [  
       "psbt",    (string, required) A base64 string of a PSBT  
       ...  
     ]  
  
Result:  
  "psbt"          (string) The base64-encoded partially signed transaction  
  
Examples:  
> defi-cli joinpsbts "psbt"  

</p></details>

<details><summary>sendrawtransaction "hexstring" ( maxfeerate )</summary><p>
sendrawtransaction "hexstring" ( maxfeerate )  
  
Submit a raw transaction (serialized, hex-encoded) to local node and network.  
  
Note that the transaction will be sent unconditionally to all peers, so using this  
for manual rebroadcast may degrade privacy by leaking the transaction's origin, as  
nodes will normally not rebroadcast non-wallet transactions already in their mempool.  
  
Also see createrawtransaction and signrawtransactionwithkey calls.  
  
Arguments:  
1. hexstring     (string, required) The hex string of the raw transaction  
2. maxfeerate    (numeric or string, optional, default=0.10) Reject transactions whose fee rate is higher than the specified value, expressed in DFI/kB.  
                 Set to 0 to accept any fee rate.  
                   
  
Result:  
"hex"             (string) The transaction hash in hex  
  
Examples:  
  
Create a transaction  
> defi-cli createrawtransaction "[{\"txid\" : \"mytxid\",\"vout\":0}]" "{\"myaddress\":0.01}"  
Sign the transaction, and get back the hex  
> defi-cli signrawtransactionwithwallet "myhex"  
  
Send the transaction (signed hex)  
> defi-cli sendrawtransaction "signedhex"  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "sendrawtransaction", "params": ["signedhex"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>signrawtransactionwithkey "hexstring" ["privatekey",...] ( [{"txid":"hex","vout":n,"scriptPubKey":"hex","redeemScript":"hex","witnessScript":"hex","amount":amount},...] "sighashtype" )</summary><p>
signrawtransactionwithkey "hexstring" ["privatekey",...] ( [{"txid":"hex","vout":n,"scriptPubKey":"hex","redeemScript":"hex","witnessScript":"hex","amount":amount},...] "sighashtype" )  
  
Sign inputs for raw transaction (serialized, hex-encoded).  
The second argument is an array of base58-encoded private  
keys that will be the only keys used to sign the transaction.  
The third optional argument (may be null) is an array of previous transaction outputs that  
this transaction depends on but may not yet be in the block chain.  
  
Arguments:  
1. hexstring                        (string, required) The transaction hex string  
2. privkeys                         (json array, required) A json array of base58-encoded private keys for signing  
     [  
       "privatekey",                (string) private key in base58-encoding  
       ...  
     ]  
3. prevtxs                          (json array, optional) A json array of previous dependent transaction outputs  
     [  
       {                            (json object)  
         "txid": "hex",             (string, required) The transaction id  
         "vout": n,                 (numeric, required) The output number  
         "scriptPubKey": "hex",     (string, required) script key  
         "redeemScript": "hex",     (string) (required for P2SH) redeem script  
         "witnessScript": "hex",    (string) (required for P2WSH or P2SH-P2WSH) witness script  
         "amount": amount,          (numeric or string) (required for Segwit inputs) the amount spent  
       },  
       ...  
     ]  
4. sighashtype                      (string, optional, default=ALL) The signature hash type. Must be one of:  
                                    "ALL"  
                                    "NONE"  
                                    "SINGLE"  
                                    "ALL|ANYONECANPAY"  
                                    "NONE|ANYONECANPAY"  
                                    "SINGLE|ANYONECANPAY"  
                                      
  
Result:  
{  
  "hex" : "value",                  (string) The hex-encoded raw transaction with signature(s)  
  "complete" : true|false,          (boolean) If the transaction has a complete set of signatures  
  "errors" : [                      (json array of objects) Script verification errors (if there are any)  
    {  
      "txid" : "hash",              (string) The hash of the referenced, previous transaction  
      "vout" : n,                   (numeric) The index of the output to spent and used as input  
      "scriptSig" : "hex",          (string) The hex-encoded signature script  
      "sequence" : n,               (numeric) Script sequence number  
      "error" : "text"              (string) Verification or signing error related to the input  
    }  
    ,...  
  ]  
}  
  
Examples:  
> defi-cli signrawtransactionwithkey "myhex" "[\"key1\",\"key2\"]"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "signrawtransactionwithkey", "params": ["myhex", "[\"key1\",\"key2\"]"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>testmempoolaccept ["rawtx",...] ( maxfeerate )</summary><p>
testmempoolaccept ["rawtx",...] ( maxfeerate )  
  
Returns result of mempool acceptance tests indicating if raw transaction (serialized, hex-encoded) would be accepted by mempool.  
  
This checks if the transaction violates the consensus or policy rules.  
  
See sendrawtransaction call.  
  
Arguments:  
1. rawtxs          (json array, required) An array of hex strings of raw transactions.  
                   Length must be one for now.  
     [  
       "rawtx",    (string)  
       ...  
     ]  
2. maxfeerate      (numeric or string, optional, default=0.10) Reject transactions whose fee rate is higher than the specified value, expressed in DFI/kB  
                     
  
Result:  
[                   (array) The result of the mempool acceptance test for each raw transaction in the input array.  
                            Length is exactly one for now.  
 {  
  "txid"           (string) The transaction hash in hex  
  "allowed"        (boolean) If the mempool allows this tx to be inserted  
  "reject-reason"  (string) Rejection string (only present when 'allowed' is false)  
 }  
]  
  
Examples:  
  
Create a transaction  
> defi-cli createrawtransaction "[{\"txid\" : \"mytxid\",\"vout\":0}]" "{\"myaddress\":0.01}"  
Sign the transaction, and get back the hex  
> defi-cli signrawtransactionwithwallet "myhex"  
  
Test acceptance of the transaction (signed hex)  
> defi-cli testmempoolaccept ["signedhex"]  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "testmempoolaccept", "params": [["signedhex"]] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>utxoupdatepsbt "psbt" ( ["",{"desc":"str","range":n or [n,n]},...] )</summary><p>
utxoupdatepsbt "psbt" ( ["",{"desc":"str","range":n or [n,n]},...] )  
  
Updates all segwit inputs and outputs in a PSBT with data from output descriptors, the UTXO set or the mempool.  
  
Arguments:  
1. psbt                          (string, required) A base64 string of a PSBT  
2. descriptors                   (json array, optional) An array of either strings or objects  
     [  
       "",                       (string) An output descriptor  
       {                         (json object) An object with an output descriptor and extra information  
         "desc": "str",          (string, required) An output descriptor  
         "range": n or [n,n],    (numeric or array, optional, default=1000) Up to what index HD chains should be explored (either end or [begin,end])  
       },  
       ...  
     ]  
  
Result:  
  "psbt"          (string) The base64-encoded partially signed transaction with inputs updated  
  
Examples:  
> defi-cli utxoupdatepsbt "psbt"  

</p></details>

## Spv
<details><summary>spv_claimhtlc "scriptaddress" "destinationaddress" "seed" ( feerate )</summary><p>
spv_claimhtlc "scriptaddress" "destinationaddress" "seed" ( feerate )  
  
Claims all coins in HTLC address  
  
Arguments:  
1. scriptaddress         (string, required) HTLC address  
2. destinationaddress    (string, required) Destination for funds in the HTLC  
3. seed                  (string, required) Seed that was used to generate the hash in the HTLC  
4. feerate               (numeric) Feerate (satoshis) per KB (Default: 10000)  
  
Result:  
{  
  "txid"                    (string) The transaction id  
  "sendmessage"             (string) Error message on failure  
}  
  
Examples:  
> defi-cli spv_claimhtlc "3QwKW5GKHc1eSbbwTozsVzB1UBVyAbZQpa" "bc1q28jh8l7a9m0x5ngq0ccld2glpn4ehzwmfczf0n" "696c6c756d696e617469" 100000  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_claimhtlc", "params": ["3QwKW5GKHc1eSbbwTozsVzB1UBVyAbZQpa", "bc1q28jh8l7a9m0x5ngq0ccld2glpn4ehzwmfczf0n", "696c6c756d696e617469", 100000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_createanchor ( [{"txid":"hex","vout":n,"amount":n,"privkey":"str"},...] ) "rewardAddress" ( send feerate )</summary><p>
spv_createanchor ( [{"txid":"hex","vout":n,"amount":n,"privkey":"str"},...] ) "rewardAddress" ( send feerate )  
  
Creates (and optional submits to bitcoin blockchain) an anchor tx with latest possible (every 15th) authorized blockhash.  
The first argument is the specific UTXOs to spend.  
  
Arguments:  
1. inputs                     (json array, optional) A json array of json objects  
     [  
       {                      (json object)  
         "txid": "hex",       (string, required) The transaction id of the bitcoin UTXO to spend  
         "vout": n,           (numeric, required) The output index to spend in UTXO  
         "amount": n,         (numeric, required) Amount of output in satoshis  
         "privkey": "str",    (string, required) WIF private key of bitcoin for signing this output  
       },  
       ...  
     ]  
2. rewardAddress              (string, required) User's P2PKH address (in DeFi chain) for reward  
3. send                       (boolean) Send it to btc network (Default = true)  
4. feerate                    (numeric) Feerate (satoshis) per 1000 bytes (Default = 1000)  
  
Result:  
"txHex"                  (string) The hex-encoded raw transaction with signature(s)  
"txHash"                 (string) The hex-encoded transaction hash  
  
Examples:  
> defi-cli spv_createanchor "[{\"txid\":\"id\",\"vout\":0,\"amount\":10000,\"privkey\":\"WIFprivkey\"}]" \"rewardAddress\" True 2000  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_createanchor", "params": ["[{\"txid\":\"id\",\"vout\":0,\"amount\":10000,\"privkey\":\"WIFprivkey\"}]" \"rewardAddress\" True 2000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_createanchortemplate "rewardAddress"</summary><p>
spv_createanchortemplate "rewardAddress"  
  
Creates an anchor tx template with latest possible (every 15th) authorized blockhash.  
  
  
Arguments:  
1. rewardAddress    (string, required) User's P2PKH address (in DeFi chain) for reward  
  
Result:  
"txHex"                  (string) The hex-encoded raw transaction with signature(s)  
  
Examples:  
> defi-cli spv_createanchortemplate \"rewardAddress\"  

</p></details>

<details><summary>spv_createhtlc "receiverPubkey" "ownerPubkey" "timeout" ( "seed" )</summary><p>
spv_createhtlc "receiverPubkey" "ownerPubkey" "timeout" ( "seed" )  
  
Creates a Bitcoin address whose funds can be unlocked with a seed or as a refund.  
It returns a json object with the address and redeemScript.  
  
Arguments:  
1. receiverPubkey    (string, required) The public key of the possessor of the seed  
2. ownerPubkey       (string, required) The public key of the recipient of the refund  
3. timeout           (string, required) Timeout of the contract (denominated in blocks) relative to its placement in the blockchain. Minimum 9.  
4. seed              (string) SHA256 hash of the seed. If none provided one will be generated  
  
Result:  
{  
  "address":"address"       (string) The value of the new Bitcoin address  
  "redeemScript":"script"   (string) Hex-encoded redemption script  
  "seed":"seed"             (string) Hex-encoded seed if no seed provided  
  "seedhash":"seedhash"     (string) Hex-encoded seed hash if no seed provided  
}  
  
Examples:  
> defi-cli spv_createhtlc 0333ffc4d18c7b2adbd1df49f5486030b0b70449c421189c2c0f8981d0da9669af 034201385acc094d24db4b53a05fc8991b10e3467e6e20a8551c49f89e7e4d0d3c 10 254e38932fdb9fc27f82aac2a5cc6d789664832383e3cf3298f8c120812712db  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_createhtlc", "params": [0333ffc4d18c7b2adbd1df49f5486030b0b70449c421189c2c0f8981d0da9669af, 034201385acc094d24db4b53a05fc8991b10e3467e6e20a8551c49f89e7e4d0d3c, 10, 254e38932fdb9fc27f82aac2a5cc6d789664832383e3cf3298f8c120812712db] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_decodehtlcscript "redeemscript"</summary><p>
spv_decodehtlcscript "redeemscript"  
  
Decode and return value in a HTLC redeemscript  
  
Arguments:  
1. redeemscript    (string, required) The HTLC redeemscript  
  
Result:  
{  
  "receiverPubkey"            (string) The public key of the possessor of the seed  
  "ownerPubkey"               (string) The public key of the recipient of the refund  
  "blocks"                    (number) Locktime in number of blocks  
  "hash"                      (string) Hex-encoded seed hash if no seed provided  
}  
  
Examples:  
> defi-cli spv_decodehtlcscript \"redeemscript\"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_decodehtlcscript", "params": [\"redeemscript\"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_dumpprivkey "address"</summary><p>
spv_dumpprivkey "address"  
  
Reveals the private key corresponding to 'address'  
  
Arguments:  
1. address    (string, required) The BTC address for the private key  
  
Result:  
"key"                (string) The private key  
  
Examples:  
> defi-cli spv_dumpprivkey "myaddress"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_dumpprivkey", "params": ["myaddress"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_estimateanchorcost ( feerate )</summary><p>
spv_estimateanchorcost ( feerate )  
  
Estimates current anchor cost with default fee, one input and one change output.  
  
Arguments:  
1. feerate    (numeric) Feerate (satoshis) per 1000 bytes (Default = 1000)  
  
Result:  
"cost"                  (numeric) Estimated anchor cost (satoshis)  
  
Examples:  
> defi-cli spv_estimateanchorcost   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_estimateanchorcost", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_getaddresspubkey "address"</summary><p>
spv_getaddresspubkey "address"  
  
Return raw pubkey for Bitcoin address if in SPV wallet  
  
Arguments:  
1. address    (string, required) Bitcoin address  
  
Result:  
"pubkey"                 (string) Raw pubkey hex  
  
Examples:  
> defi-cli spv_getaddresspubkey   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_getaddresspubkey", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_getalladdresses</summary><p>
spv_getalladdresses  
  
Returns all user Bitcoin addresses.  
  
Result:  
"array"                  (Array of user addresses)  
  
Examples:  
> defi-cli spv_getalladdresses   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_getalladdresses", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_getbalance</summary><p>
spv_getbalance  
  
Returns the Bitcoin balance of the SPV wallet  
  
Result:  
amount                 (numeric) The total amount in BTC received in the SPV wallet.  
  
Examples:  
> defi-cli spv_getbalance   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_getbalance", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_getfeerate</summary><p>
spv_getfeerate  
  
Returns current fee rate in Sats per KB.  
  
Result:  
nnnn                  (Fee rate)  
  
Examples:  
> defi-cli spv_getfeerate   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_getfeerate", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_gethtlcseed "address"</summary><p>
spv_gethtlcseed "address"  
  
Returns the HTLC secret if available  
  
Arguments:  
1. address    (string, required) HTLC address  
  
Result:  
"secret"                 (string) Returns HTLC seed  
  
Examples:  
> defi-cli spv_gethtlcseed \"address\"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_gethtlcseed", "params": [\"address\"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_getnewaddress</summary><p>
spv_getnewaddress  
  
Creates and adds a Bitcoin address to the SPV wallet  
  
Result:  
"address"                  Returns a new Bitcoin address  
  
Examples:  
> defi-cli spv_getnewaddress   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_getnewaddress", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_getpeers</summary><p>
spv_getpeers  
  
Returns info on connected peers.  
  
Result:  
X {                                (Peer number)  
  address: xxx.xxx.xxx.xxx          (IP Address)  
  timestamp: nnn                    (time)  
  flags: nnn                        (flags)  
  services: nnn                     (services)  
}  
  
Examples:  
> defi-cli spv_getpeers   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_getpeers", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_getrawtransaction "txid"</summary><p>
spv_getrawtransaction "txid"  
  
Return the raw transaction data.  
  
Arguments:  
1. txid    (string, required) The transaction id  
  
Result:  
"data"      (string) The serialized, hex-encoded data for 'txid'  
  
Examples:  
> defi-cli spv_getrawtransaction "txid"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_getrawtransaction", "params": ["txid"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_gettxconfirmations "txhash"</summary><p>
spv_gettxconfirmations "txhash"  
  
Reports tx confirmations (if any)...  
  
Arguments:  
1. txhash    (string, required) Hash of tx to look for  
  
Result:  
count                (num) Tx confirmations. Zero if not confirmed yet (mempooled?) and -1 if not found  
  
Examples:  
> defi-cli spv_gettxconfirmations \"txid\"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_gettxconfirmations", "params": [\"txid\"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_listanchorauths</summary><p>
spv_listanchorauths  
  
List anchor auths (if any)  
  
Result:  
"array"                  Returns array of anchor auths  
  
Examples:  
> defi-cli spv_listanchorauths   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listanchorauths", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_listanchorrewardconfirms</summary><p>
spv_listanchorrewardconfirms  
  
List anchor reward confirms (if any)  
  
Result:  
"array"                  Returns array of anchor confirms  
  
Examples:  
> defi-cli spv_listanchorrewardconfirms   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listanchorrewardconfirms", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_listanchorrewards</summary><p>
spv_listanchorrewards  
  
List anchor rewards (if any)  
  
Result:  
"array"                  Returns array of anchor rewards  
  
Examples:  
> defi-cli spv_listanchorrewards   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listanchorrewards", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_listanchors ( minBtcHeight maxBtcHeight minConfs maxConfs startBtcHeight limit )</summary><p>
spv_listanchors ( minBtcHeight maxBtcHeight minConfs maxConfs startBtcHeight limit )  
  
List anchors (if any)  
  
Arguments:  
1. minBtcHeight      (numeric) min btc height, optional (default = -1)  
2. maxBtcHeight      (numeric) max btc height, optional (default = -1)  
3. minConfs          (numeric) min anchor confirmations, optional (default = -1)  
4. maxConfs          (numeric) max anchor confirmations, optional (default = -1)  
5. startBtcHeight    (numeric) max anchor confirmations, optional (default = -1)  
6. limit             (numeric) number of records to return (default = unlimited)  
  
Result:  
"array"                  Returns array of anchors  
  
Examples:  
> defi-cli spv_listanchors 1500000 -1 6 -1  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listanchors", "params": [-1 -1 0 0] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_listanchorspending</summary><p>
spv_listanchorspending  
  
List pending anchors (if any). Pending anchors are waiting on  
chain context to be fully validated, for example, anchors read  
from SPV while the blockchain is still syncing.  
Result:  
"array"                  Returns array of pending anchors  
  
Examples:  
> defi-cli spv_listanchorspending   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listanchorspending", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_listanchorsunrewarded</summary><p>
spv_listanchorsunrewarded  
  
List anchors that have yet to be paid  
  
Result:  
"array"                  Returns array of unrewarded anchors  
  
Examples:  
> defi-cli spv_listanchorsunrewarded   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listanchorsunrewarded", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_listhtlcoutputs ( "address" )</summary><p>
spv_listhtlcoutputs ( "address" )  
  
List all outputs related to HTLC addresses in the wallet  
  
Arguments:  
1. address    (string) HTLC address to filter results  
  
Result:  
[                       (JSON array of transaction details)  
{  
  "txid"              (string) The transaction id  
  "vout"              (numeric) Output relating to the HTLC address  
  "address"           (string) HTLC address  
  "confirms"          (numeric) Number of confirmations  
  { "spent"           (JSON object containing spent info)  
    "txid"            (string) Transaction id spending this output  
    "confirms"        (numeric) Number of spent confirmations  
  }  
}, ...]  
  
Examples:  
> defi-cli spv_listhtlcoutputs   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listhtlcoutputs", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_listreceivedbyaddress ( minconf "address_filter" )</summary><p>
spv_listreceivedbyaddress ( minconf "address_filter" )  
  
List balances by receiving address.  
  
Arguments:  
1. minconf           (numeric, optional, default=1) The minimum number of confirmations before payments are included.  
2. address_filter    (string, optional) If present, only return information on this address.  
  
Result:  
[  
  {  
    "address" : "receivingaddress",  (string) The receiving address  
    "type" : "type",                 (string) Address type, Bech32 or HTLC  
    "amount" : x.xxx,                  (numeric) The total amount in BTC received by the address  
    "confirmations" : n,               (numeric) The number of confirmations of the most recent transaction included  
    "txids": [  
       "txid",                         (string) The ids of transactions received with the address   
       ...  
    ]  
  }  
  ,...  
]  
  
Examples:  
> defi-cli spv_listreceivedbyaddress   
> defi-cli spv_listreceivedbyaddress 6  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listreceivedbyaddress", "params": [6] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listreceivedbyaddress", "params": [6, "1M72Sfpbz1BPpXFHz9m3CdqATR44Jvaydd"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_listtransactions</summary><p>
spv_listtransactions  
  
Returns an array of all Bitcoin transaction hashes.  
  
Result:  
[                         (array of strings)  
  "txid"                  (string) The transaction id.  
  ...  
]  
Examples:  
> defi-cli spv_listtransactions   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_listtransactions", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_refundhtlc "scriptaddress" "destinationaddress" ( feerate )</summary><p>
spv_refundhtlc "scriptaddress" "destinationaddress" ( feerate )  
  
Refunds all coins in HTLC address  
  
Arguments:  
1. scriptaddress         (string, required) HTLC address  
2. destinationaddress    (string, required) Destination for funds in the HTLC  
3. feerate               (numeric) Feerate (satoshis) per KB (Default: 10000)  
  
Result:  
{  
  "txid"                    (string) The transaction id  
  "sendmessage"             (string) Error message on failure  
}  
  
Examples:  
> defi-cli spv_refundhtlc "3QwKW5GKHc1eSbbwTozsVzB1UBVyAbZQpa" "bc1q28jh8l7a9m0x5ngq0ccld2glpn4ehzwmfczf0n" 100000  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_refundhtlc", "params": ["3QwKW5GKHc1eSbbwTozsVzB1UBVyAbZQpa", "bc1q28jh8l7a9m0x5ngq0ccld2glpn4ehzwmfczf0n", 100000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_refundhtlcall "destinationaddress" ( feerate )</summary><p>
spv_refundhtlcall "destinationaddress" ( feerate )  
  
Gets all HTLC contracts stored in wallet and creates refunds transactions for all that have expired  
  
Arguments:  
1. destinationaddress    (string, required) Destination for funds in the HTLC  
2. feerate               (numeric) Feerate (satoshis) per KB (Default: 10000)  
  
Result:  
{  
  "txid"                    (string) The transaction id  
}  
  
Examples:  
> defi-cli spv_refundhtlcall 100000  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_refundhtlcall", "params": [100000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_rescan ( height )</summary><p>
spv_rescan ( height )  
  
Rescan from block height...  
  
Arguments:  
1. height    (numeric) Block height or ('tip' minus 'height') if negative).  
  
Result:  
"none"                  Returns nothing  
  
Examples:  
> defi-cli spv_rescan 600000  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_rescan", "params": [600000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_sendrawtx "rawtx"</summary><p>
spv_sendrawtx "rawtx"  
  
Sending raw tx to Bitcoin blockchain  
  
Arguments:  
1. rawtx    (string, required) The hex-encoded raw transaction with signature  
  
Result:  
"none"                  Returns nothing  
  
Examples:  
> defi-cli spv_sendrawtx "rawtx"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_sendrawtx", "params": ["rawtx"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_sendtoaddress "address" amount ( feerate )</summary><p>
spv_sendtoaddress "address" amount ( feerate )  
  
Send a Bitcoin amount to a given address.  
  
Arguments:  
1. address    (string, required) The Bitcoin address to send to.  
2. amount     (numeric or string, required) The amount in BTC to send. eg 0.1  
3. feerate    (numeric) Feerate (satoshis) per KB (Default: 10000)  
  
Result:  
{  
  "txid"                    (string) The transaction id  
  "sendmessage"             (string) Send message result  
}  
  
Examples:  
> defi-cli spv_sendtoaddress "1M72Sfpbz1BPpXFHz9m3CdqATR44Jvaydd" 0.1  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_sendtoaddress", "params": ["1M72Sfpbz1BPpXFHz9m3CdqATR44Jvaydd", 0.1] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_syncstatus</summary><p>
spv_syncstatus  
  
Returns spv sync status  
  
Result:  
{                           (json object)  
   "connected"                (bool) Connection status  
   "current"                  (num) Last synced block  
   "estimated"                (num) Estimated chain height (as reported by peers)  
}  
  
Examples:  
> defi-cli spv_syncstatus   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_syncstatus", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>spv_validateaddress "address"</summary><p>
spv_validateaddress "address"  
  
Check whether the given Bitcoin address is valid.  
  
Arguments:  
1. address    (string, required) The Bitcoin address to validate  
  
Result:  
{  
  "isvalid" : true|false,       (boolean) If the address is valid or not.  
  "ismine" : true|false,        (boolean) If the address belongs to the wallet.  
}  
  
Examples:  
> defi-cli spv_validateaddress "1PSSGeFHDnKNxiEyFrD1wcEaHr9hrQDDWc"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "spv_validateaddress", "params": ["1PSSGeFHDnKNxiEyFrD1wcEaHr9hrQDDWc"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

## Stats
<details><summary>getrpcstats "command"</summary><p>
getrpcstats "command"  
  
Get RPC stats for selected command.  
  
Arguments:  
1. command    (string, required) The command to get stats for.  
  
Result:  
 {  
  "name":               (string) The RPC command name.  
  "latency":            (json object) Min, max and average latency.  
  "payload":            (json object) Min, max and average payload size in bytes.  
  "count":              (numeric) The number of times this command as been used.  
  "lastUsedTime":       (numeric) Last used time as timestamp.  
  "history":            (json array) History of last 5 RPC calls.  
  [  
       {  
           "timestamp": (numeric)  
           "latency":   (numeric)  
           "payload":   (numeric)  
       }  
  ]  
}  
Examples:  
> defi-cli getrpcstats getblockcount  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getrpcstats", "params": ["getblockcount"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listrpcstats</summary><p>
listrpcstats  
  
List used RPC commands.  
  
Result:  
[  
 {  
  "name":               (string) The RPC command name.  
  "latency":            (json object) Min, max and average latency.  
  "payload":            (json object) Min, max and average payload size in bytes.  
  "count":              (numeric) The number of times this command as been used.  
  "lastUsedTime":       (numeric) Last used time as timestamp.  
  "history":            (json array) History of last 5 RPC calls.  
  [  
       {  
           "timestamp": (numeric)  
           "latency":   (numeric)  
           "payload":   (numeric)  
       }  
  ]  
 }  
]  
Examples:  
> defi-cli listrpcstats   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listrpcstats", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

## Tokens
<details><summary>burntokens {"amounts":"str","from":"str","context":"str"} ( [{"txid":"hex","vout":n},...] )</summary><p>
burntokens {"amounts":"str","from":"str","context":"str"} ( [{"txid":"hex","vout":n},...] )  
  
Creates (and submits to local node and network) a transaction burning your token (for accounts and/or UTXOs).   
The second optional argument (may be empty array) is an array of specific UTXOs to spend. One of UTXO's must belong to the token's owner (collateral) address  
  
Arguments:  
1. metadata                 (json object, required)  
     {  
       "amounts": "str",    (string, required) Amount as json string, or array. Example: '[ "amount@token" ]'  
       "from": "str",       (string) Address containing tokens to be burned.  
       "context": "str",    (string) Additional data necessary for specific burn type  
     }  
2. inputs                   (json array, optional) A json array of json objects. Provide it if you want to spent specific UTXOs  
     [  
       {                    (json object)  
         "txid": "hex",     (string, required) The transaction id  
         "vout": n,         (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli burntokens '{"amounts":"10@symbol","from":"address"}'  
> defi-cli burntokens '{"amounts":"10@symbol","from":"address","context":"consortium_member_address"}'  
> defi-cli burntokens '{"amounts":"10@symbol","from":"address"}' '[{"txid":"id","vout":0}]'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "burntokens", "params": ['{"amounts":"10@symbol","from":"address"}' '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>createtoken ( {"symbol":"str","name":"str","isDAT":bool,"decimal":n,"limit":n,"mintable":bool,"tradeable":bool,"collateralAddress":"str"} [{"txid":"hex","vout":n},...] )</summary><p>
createtoken ( {"symbol":"str","name":"str","isDAT":bool,"decimal":n,"limit":n,"mintable":bool,"tradeable":bool,"collateralAddress":"str"} [{"txid":"hex","vout":n},...] )  
  
Creates (and submits to local node and network) a token creation transaction with given metadata.  
The second optional argument (may be empty array) is an array of specific UTXOs to spend.  
  
Arguments:  
1. metadata                           (json object)  
     {  
       "symbol": "str",               (string, required) Token's symbol (unique), no longer than 8  
       "name": "str",                 (string) Token's name (optional), no longer than 30  
       "isDAT": bool,                 (boolean) Token's 'isDAT' property (bool, optional), default is 'False'  
       "decimal": n,                  (numeric) Token's decimal places (optional, fixed to 8 for now, unchecked)  
       "limit": n,                    (numeric) Token's total supply limit (optional, zero for now, unchecked)  
       "mintable": bool,              (boolean) Token's 'Mintable' property (bool, optional), default is 'True'  
       "tradeable": bool,             (boolean) Token's 'Tradeable' property (bool, optional), default is 'True'  
       "collateralAddress": "str",    (string, required) Any valid destination for keeping collateral amount - used as token's owner auth  
     }  
2. inputs                             (json array, optional) A json array of json objects  
     [  
       {                              (json object)  
         "txid": "hex",               (string, required) The transaction id  
         "vout": n,                   (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli createtoken '{"symbol":"MyToken","collateralAddress":"address"}'  
> defi-cli createtoken '{"symbol":"MyToken","collateralAddress":"address"}' '[{"txid":"id","vout":0}]'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createtoken", "params": ['{"symbol":"MyToken","collateralAddress":"address"}' '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>decodecustomtx "hexstring" ( iswitness )</summary><p>
decodecustomtx "hexstring" ( iswitness )  
  
Get detailed information about a DeFiChain custom transaction.  
  
Arguments:  
1. hexstring    (string, required) The transaction hex string  
2. iswitness    (boolean, optional, default=depends on heuristic tests) Whether the transaction hex is a serialized witness transaction.  
                If iswitness is not present, heuristic tests will be used in decoding.  
                If true, only witness deserialization will be tried.  
                If false, only non-witness deserialization will be tried.  
                This boolean should reflect whether the transaction has inputs  
                (e.g. fully valid, or on-chain transactions), if known by the caller.  
  
Result:  
{  
  "txid":               (string) The transaction id.  
  "type":               (string) The transaction type.  
  "valid"               (bool) Whether the transaction was valid.  
  "results"             (json object) Set of results related to the transaction type  
}  
  
Examples:  
> defi-cli decodecustomtx "hexstring"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "decodecustomtx", "params": ["hexstring"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getcustomtx "txid" ( "blockhash" )</summary><p>
getcustomtx "txid" ( "blockhash" )  
  
Get detailed information about a DeFiChain custom transaction. Will search wallet transactions and mempool transaction,  
if a blockhash is provided and that block is available then details for that transaction can be returned. -txindex  
can be enabled to return details for any transaction.  
Arguments:  
1. txid         (string, required) The transaction id  
2. blockhash    (string, optional) The block in which to look for the transaction  
  
Result:  
{  
  "type":               (string) The transaction type.  
  "valid"               (bool) Whether the transaction was valid.  
  "results"             (json object) Set of results related to the transaction type  
  "block height"        (string) The block height containing the transaction.  
  "blockhash"           (string) The block hash containing the transaction.  
  "confirmations": n,   (numeric) The number of confirmations for the transaction.}  
  
Examples:  
> defi-cli getcustomtx "66ea2ac081e2917f075e2cca7c1c0baa12fb85c469f34561185fa64d7d2f9305"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getcustomtx", "params": ["66ea2ac081e2917f075e2cca7c1c0baa12fb85c469f34561185fa64d7d2f9305"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>gettoken "key"</summary><p>
gettoken "key"  
  
Returns information about token.  
  
Arguments:  
1. key    (string, required) One of the keys may be specified (id/symbol/creationTx)  
  
Result:  
{id:{...}}     (array) Json object with token information  
  
Examples:  
> defi-cli gettoken GOLD  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "gettoken", "params": [GOLD] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listtokens ( {"start":n,"including_start":bool,"limit":n} verbose )</summary><p>
listtokens ( {"start":n,"including_start":bool,"limit":n} verbose )  
  
Returns information about tokens.  
  
Arguments:  
1. pagination                      (json object)  
     {  
       "start": n,                 (numeric) Optional first key to iterate from, in lexicographical order.Typically it's set to last ID from previous request.  
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default  
       "limit": n,                 (numeric) Maximum number of tokens to return, 100 by default  
     }  
2. verbose                         (boolean) Flag for verbose list (default = true), otherwise only ids, symbols and names are listed  
  
Result:  
{id:{...},...}     (array) Json object with tokens information  
  
Examples:  
> defi-cli listtokens '{"start":128}' false  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listtokens", "params": ['{"start":128}' false] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>minttokens "amounts" ( [{"txid":"hex","vout":n},...] "to" )</summary><p>
minttokens "amounts" ( [{"txid":"hex","vout":n},...] "to" )  
  
Creates (and submits to local node and network) a transaction minting your token (for accounts and/or UTXOs).   
The second optional argument (may be empty array) is an array of specific UTXOs to spend. One of UTXO's must belong to the token's owner (collateral) address.   
All arguments may optionally be passed in a JSON object.  
  
Arguments:  
1. amounts                 (string, required) Amount as json string, or array. Example: '[ "amount@token" ]'  
2. inputs                  (json array, optional) A json array of json objects. Provide it if you want to spent specific UTXOs  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
3. to                      (string) Address to mint tokens to  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli minttokens 10@symbol  
> defi-cli minttokens 10@symbol '[{"txid":"id","vout":0}]'  
> defi-cli minttokens 10@symbol '[{"txid":"id","vout":0}]' address  
> defi-cli minttokens 10@symbol '' address  
> defi-cli minttokens '{"amounts": ["10@symbol"], "to": "address"}'  
> defi-cli minttokens '{"amounts": ["10@symbol"], "to": "address", "inputs": "[{"txid": "id","vout": 0}]"}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "minttokens", "params": [10@symbol '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>updatetoken "token" ( {"symbol":"str","name":"str","isDAT":bool,"mintable":bool,"tradeable":bool,"finalize":bool,"deprecate":bool,"collateralAddress":"str"} [{"txid":"hex","vout":n},...] )</summary><p>
updatetoken "token" ( {"symbol":"str","name":"str","isDAT":bool,"mintable":bool,"tradeable":bool,"finalize":bool,"deprecate":bool,"collateralAddress":"str"} [{"txid":"hex","vout":n},...] )  
  
Creates (and submits to local node and network) a transaction of token promotion to isDAT or demotion from isDAT. Collateral will be unlocked.  
The second optional argument (may be empty array) is an array of specific UTXOs to spend. One of UTXO's must belong to the token's owner (collateral) address  
  
Arguments:  
1. token                              (string, required) The tokens's symbol, id or creation tx  
2. metadata                           (json object)  
     {  
       "symbol": "str",               (string) New token's symbol, no longer than 8  
       "name": "str",                 (string) New token's name (optional), no longer than 128  
       "isDAT": bool,                 (boolean) Token's 'isDAT' property (bool, optional), default is 'False'  
       "mintable": bool,              (boolean) Token's 'Mintable' property (bool, optional)  
       "tradeable": bool,             (boolean) Token's 'Tradeable' property (bool, optional)  
       "finalize": bool,              (boolean) Lock token properties forever (bool, optional)  
       "deprecate": bool,             (boolean) Marks a token as deprecated and attaches end of life prefix to symbol (bool, optional)  
       "collateralAddress": "str",    (string) New collateral address to transfer token ownership to (string, optional)  
     }  
3. inputs                             (json array, optional) A json array of json objects. Provide it if you want to spent specific UTXOs  
     [  
       {                              (json object)  
         "txid": "hex",               (string, required) The transaction id  
         "vout": n,                   (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli updatetoken token '{"isDAT":true}' '[{"txid":"id","vout":0}]'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "updatetoken", "params": [token '{"isDAT":true}' '[{"txid":"id","vout":0}]'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

## Util
<details><summary>createmultisig nrequired ["key",...] ( "address_type" )</summary><p>
createmultisig nrequired ["key",...] ( "address_type" )  
  
Creates a multi-signature address with n signature of m keys required.  
It returns a json object with the address and redeemScript.  
  
Arguments:  
1. nrequired       (numeric, required) The number of required signatures out of the n keys.  
2. keys            (json array, required) A json array of hex-encoded public keys.  
     [  
       "key",      (string) The hex-encoded public key  
       ...  
     ]  
3. address_type    (string, optional, default=legacy) The address type to use. Options are "legacy", "p2sh-segwit", and "bech32".  
  
Result:  
{  
  "address":"multisigaddress",  (string) The value of the new multisig address.  
  "redeemScript":"script"       (string) The string value of the hex-encoded redemption script.  
}  
  
Examples:  
  
Create a multisig address from 2 public keys  
> defi-cli createmultisig 2 "[\"03789ed0bb717d88f7d321a368d905e7430207ebbd82bd342cf11ae157a7ace5fd\",\"03dbc6764b8884a92e871274b87583e6d5c2a58819473e17e107ef3f6aa5a61626\"]"  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createmultisig", "params": [2, "[\"03789ed0bb717d88f7d321a368d905e7430207ebbd82bd342cf11ae157a7ace5fd\",\"03dbc6764b8884a92e871274b87583e6d5c2a58819473e17e107ef3f6aa5a61626\"]"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>deriveaddresses "descriptor" ( range )</summary><p>
deriveaddresses "descriptor" ( range )  
  
Derives one or more addresses corresponding to an output descriptor.  
Examples of output descriptors are:  
    pkh(<pubkey>)                        P2PKH outputs for the given pubkey  
    wpkh(<pubkey>)                       Native segwit P2PKH outputs for the given pubkey  
    sh(multi(<n>,<pubkey>,<pubkey>,...)) P2SH-multisig outputs for the given threshold and pubkeys  
    raw(<hex script>)                    Outputs whose scriptPubKey equals the specified hex scripts  
  
In the above, <pubkey> either refers to a fixed public key in hexadecimal notation, or to an xpub/xprv optionally followed by one  
or more path elements separated by "/", where "h" represents a hardened child key.  
For more information on output descriptors, see the documentation in the doc/descriptors.md file.  
  
Arguments:  
1. descriptor    (string, required) The descriptor.  
2. range         (numeric or array, optional) If a ranged descriptor is used, this specifies the end or the range (in [begin,end] notation) to derive.  
  
Result:  
[ address ] (array) the derived addresses  
  
Examples:  
First three native segwit receive addresses  
> defi-cli deriveaddresses "wpkh([d34db33f/84h/0h/0h]xpub6DJ2dNUysrn5Vt36jH2KLBT2i1auw1tTSSomg8PhqNiUtx8QX2SvC9nrHu81fT41fvDUnhMjEzQgXnQjKEu3oaqMSzhSrHMxyyoEAmUHQbY/0/*)#cjjspncu" "[0,2]"  

</p></details>

<details><summary>estimatesmartfee conf_target ( "estimate_mode" )</summary><p>
estimatesmartfee conf_target ( "estimate_mode" )  
  
Estimates the approximate fee per kilobyte needed for a transaction to begin  
confirmation within conf_target blocks if possible and return the number of blocks  
for which the estimate is valid. Uses virtual transaction size as defined  
in BIP 141 (witness data is discounted).  
  
Arguments:  
1. conf_target      (numeric, required) Confirmation target in blocks (1 - 1008)  
2. estimate_mode    (string, optional, default=CONSERVATIVE) The fee estimate mode.  
                    Whether to return a more conservative estimate which also satisfies  
                    a longer history. A conservative estimate potentially returns a  
                    higher feerate and is more likely to be sufficient for the desired  
                    target, but is not as responsive to short term drops in the  
                    prevailing fee market.  Must be one of:  
                    "UNSET"  
                    "ECONOMICAL"  
                    "CONSERVATIVE"  
  
Result:  
{  
  "feerate" : x.x,     (numeric, optional) estimate fee rate in DFI/kB  
  "errors": [ str... ] (json array of strings, optional) Errors encountered during processing  
  "blocks" : n         (numeric) block number where estimate was found  
}  
  
The request target will be clamped between 2 and the highest target  
fee estimation is able to return based on how long it has been running.  
An error is returned if not enough transactions and blocks  
have been observed to make an estimate for any number of blocks.  
  
Examples:  
> defi-cli estimatesmartfee 6  

</p></details>

<details><summary>getdescriptorinfo "descriptor"</summary><p>
getdescriptorinfo "descriptor"  
  
Analyses a descriptor.  
  
Arguments:  
1. descriptor    (string, required) The descriptor.  
  
Result:  
{  
  "descriptor" : "desc",         (string) The descriptor in canonical form, without private keys  
  "checksum" : "chksum",         (string) The checksum for the input descriptor  
  "isrange" : true|false,        (boolean) Whether the descriptor is ranged  
  "issolvable" : true|false,     (boolean) Whether the descriptor is solvable  
  "hasprivatekeys" : true|false, (boolean) Whether the input descriptor contained at least one private key  
}  
  
Examples:  
Analyse a descriptor  
> defi-cli getdescriptorinfo "wpkh([d34db33f/84h/0h/0h]0279be667ef9dcbbac55a06295Ce870b07029Bfcdb2dce28d959f2815b16f81798)"  

</p></details>

<details><summary>signmessagewithprivkey "privkey" "message"</summary><p>
signmessagewithprivkey "privkey" "message"  
  
Sign a message with the private key of an address  
  
Arguments:  
1. privkey    (string, required) The private key to sign the message with.  
2. message    (string, required) The message to create a signature of.  
  
Result:  
"signature"          (string) The signature of the message encoded in base 64  
  
Examples:  
  
Create the signature  
> defi-cli signmessagewithprivkey "privkey" "my message"  
  
Verify the signature  
> defi-cli verifymessage "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX" "signature" "my message"  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "signmessagewithprivkey", "params": ["privkey", "my message"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>validateaddress "address"</summary><p>
validateaddress "address"  
  
Return information about the given defi address.  
  
Arguments:  
1. address    (string, required) The defi address to validate  
  
Result:  
{  
  "isvalid" : true|false,       (boolean) If the address is valid or not. If not, this is the only property returned.  
  "address" : "address",        (string) The defi address validated  
  "scriptPubKey" : "hex",       (string) The hex-encoded scriptPubKey generated by the address  
  "isscript" : true|false,      (boolean) If the key is a script  
  "iswitness" : true|false,     (boolean) If the address is a witness address  
  "witness_version" : version   (numeric, optional) The version number of the witness program  
  "witness_program" : "hex"     (string, optional) The hex value of the witness program  
}  
  
Examples:  
> defi-cli validateaddress "1PSSGeFHDnKNxiEyFrD1wcEaHr9hrQDDWc"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "validateaddress", "params": ["1PSSGeFHDnKNxiEyFrD1wcEaHr9hrQDDWc"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>verifymessage "address" "signature" "message"</summary><p>
verifymessage "address" "signature" "message"  
  
Verify a signed message  
  
Arguments:  
1. address      (string, required) The defi address to use for the signature.  
2. signature    (string, required) The signature provided by the signer in base 64 encoding (see signmessage).  
3. message      (string, required) The message that was signed.  
  
Result:  
true|false   (boolean) If the signature is verified or not.  
  
Examples:  
  
Unlock the wallet for 30 seconds  
> defi-cli walletpassphrase "mypassphrase" 30  
  
Create the signature  
> defi-cli signmessage "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX" "my message"  
  
Verify the signature  
> defi-cli verifymessage "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX" "signature" "my message"  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "verifymessage", "params": ["1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX", "signature", "my message"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

## Vault
<details><summary>closevault "vaultId" "to" ( [{"txid":"hex","vout":n},...] )</summary><p>
closevault "vaultId" "to" ( [{"txid":"hex","vout":n},...] )  
Close vault transaction.  
  
  
Arguments:  
1. vaultId                 (string, required) Vault to be closed  
2. to                      (string, required) Any valid address to receive collaterals (if any) and half fee back  
3. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli closevault 84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2 mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "closevault", "params": ["84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2", "mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>createvault "ownerAddress" ( "loanSchemeId" [{"txid":"hex","vout":n},...] )</summary><p>
createvault "ownerAddress" ( "loanSchemeId" [{"txid":"hex","vout":n},...] )  
Creates a vault transaction.  
  
  
Arguments:  
1. ownerAddress            (string, required) Any valid address  
2. loanSchemeId            (string) Unique identifier of the loan scheme (8 chars max). If empty, the default loan scheme will be selected (Optional)  
3. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli createvault 2MzfSNCkjgCbNLen14CYrVtwGomfDA5AGYv  
> defi-cli createvault 2MzfSNCkjgCbNLen14CYrVtwGomfDA5AGYv ""  
> defi-cli createvault 2MzfSNCkjgCbNLen14CYrVtwGomfDA5AGYv LOAN0001  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createvault", "params": ["2MzfSNCkjgCbNLen14CYrVtwGomfDA5AGYv"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createvault", "params": ["2MzfSNCkjgCbNLen14CYrVtwGomfDA5AGYv", ""] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createvault", "params": ["2MzfSNCkjgCbNLen14CYrVtwGomfDA5AGYv", "LOAN0001"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>deposittovault "vaultId" "from" "amount" ( [{"txid":"hex","vout":n},...] )</summary><p>
deposittovault "vaultId" "from" "amount" ( [{"txid":"hex","vout":n},...] )  
Deposit collateral token amount to vault.  
  
  
Arguments:  
1. vaultId                 (string, required) Vault id  
2. from                    (string, required) Address containing collateral  
3. amount                  (string, required) Amount of collateral in amount@symbol format  
4. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli deposittovault 84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2i mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF 1@DFI  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "deposittovault", "params": ["84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2i", "mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF", "1@DFI"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>estimatecollateral "loanAmounts" targetRatio ( {"split":n} )</summary><p>
estimatecollateral "loanAmounts" targetRatio ( {"split":n} )  
Returns amount of collateral tokens needed to take an amount of loan tokens for a target collateral ratio.  
  
Arguments:  
1. loanAmounts        (string, required) Amount as json string, or array. Example: '[ "amount@token" ]'  
2. targetRatio        (numeric, required) Target collateral ratio.  
3. tokens             (json object) Object with collateral token as key and their percent split as value. (defaults to { DFI: 1 }  
     {  
       "split": n,    (numeric, required) The percent split  
     }  
  
Result:  
"json"                  (Array) Array of <amount@token> strings  
  
Examples:  
> defi-cli estimatecollateral 23.55311144@MSFT 150 '{"DFI": 0.8, "BTC":0.2}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "estimatecollateral", "params": ["23.55311144@MSFT" 150 {"DFI": 0.8, "BTC":0.2}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>estimateloan "vaultId" {"split":n} ( targetRatio )</summary><p>
estimateloan "vaultId" {"split":n} ( targetRatio )  
Returns amount of loan tokens a vault can take depending on a target collateral ratio.  
  
Arguments:  
1. vaultId            (string, required) vault hex id  
2. tokens             (json object, required) Object with loans token as key and their percent split as value  
     {  
       "split": n,    (numeric, required) The percent split  
     }  
3. targetRatio        (numeric) Target collateral ratio. (defaults to vault's loan scheme ratio)  
  
Result:  
"json"                  (Array) Array of <amount@token> strings  
  
Examples:  
> defi-cli estimateloan 5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf '{"TSLA":0.5, "FB": 0.4, "GOOGL":0.1}' 150  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "estimateloan", "params": ["5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf", {"TSLA":0.5, "FB": 0.4, "GOOGL":0.1}, 150] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>estimatevault "collateralAmounts" "loanAmounts"</summary><p>
estimatevault "collateralAmounts" "loanAmounts"  
Returns estimated vault for given collateral and loan amounts.  
  
Arguments:  
1. collateralAmounts    (string, required) Collateral amounts as json string, or array. Example: '[ "amount@token" ]'  
2. loanAmounts          (string, required) Loan amounts as json string, or array. Example: '[ "amount@token" ]'  
  
Result:  
{  
  "collateralValue" : n.nnnnnnnn,        (amount) The total collateral value in USD  
  "loanValue" : n.nnnnnnnn,              (amount) The total loan value in USD  
  "informativeRatio" : n.nnnnnnnn,       (amount) Informative ratio with 8 digit precision  
  "collateralRatio" : n,                 (uint) Ratio as unsigned int  
}  
  
Examples:  
> defi-cli estimatevault '["1000.00000000@DFI"]' '["0.65999990@GOOGL"]'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "estimatevault", "params": [["1000.00000000@DFI"], ["0.65999990@GOOGL"]] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getvault "vaultId" ( verbose )</summary><p>
getvault "vaultId" ( verbose )  
Returns information about vault.  
  
Arguments:  
1. vaultId    (string, required) vault hex id  
2. verbose    (boolean) Verbose vault information (default = false)  
  
Result:  
"json"                  (string) vault data in json form  
  
Examples:  
> defi-cli getvault 5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getvault", "params": ["5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listauctionhistory ( "owner|vaultId" {"maxBlockHeight":n,"vaultId":"hex","index":n,"limit":n} )</summary><p>
listauctionhistory ( "owner|vaultId" {"maxBlockHeight":n,"vaultId":"hex","index":n,"limit":n} )  
  
Returns information about auction history.  
  
Arguments:  
1. owner|vaultId               (string) Single account ID (CScript or address) or vaultId or reserved words: "mine" - to list history for all owned accounts or "all" to list whole DB (default = "mine").  
2. pagination                  (json object)  
     {  
       "maxBlockHeight": n,    (numeric) Optional height to iterate from (downto genesis block)  
       "vaultId": "hex",       (string) Vault id  
       "index": n,             (numeric) Batch index  
       "limit": n,             (numeric) Maximum number of orders to return, 100 by default  
     }  
  
Result:  
[{},{}...]     (array) Objects with auction history information  
  
Examples:  
> defi-cli listauctionhistory all '{"height":160}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listauctionhistory", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listauctions ( {"start":obj,"including_start":bool,"limit":n} )</summary><p>
listauctions ( {"start":obj,"including_start":bool,"limit":n} )  
List all available auctions.  
  
Arguments:  
1. pagination                      (json object)  
     {  
       "start": {                  (json object)  
         "vaultId": "hex",         (string) Vault id  
         "height": n,              (numeric) Height to iterate from  
       },  
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default  
       "limit": n,                 (numeric) Maximum number of orders to return, 100 by default  
     }  
  
Result:  
[                         (json array of objects)  
{...}                 (object) Json object with auction information  
]  
  
Examples:  
> defi-cli listauctions   
> defi-cli listauctions '{"start": {"vaultId":"eeea650e5de30b77d17e3907204d200dfa4996e5c4d48b000ae8e70078fe7542", "height": 1000}, "including_start": true, "limit":100}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listauctions", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listauctions", "params": [{"start": {"vaultId":"eeea650e5de30b77d17e3907204d200dfa4996e5c4d48b000ae8e70078fe7542", "height": 1000}, "including_start": true, "limit":100}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listvaulthistory "vaultId" ( {"maxBlockHeight":n,"depth":n,"token":"str","txtype":"str","limit":n} )</summary><p>
listvaulthistory "vaultId" ( {"maxBlockHeight":n,"depth":n,"token":"str","txtype":"str","limit":n} )  
  
Returns the history of the specified vault.  
  
Arguments:  
1. vaultId                     (string, required) Vault to get history for  
2. options                     (json object)  
     {  
       "maxBlockHeight": n,    (numeric) Optional height to iterate from (down to genesis block), (default = chaintip).  
       "depth": n,             (numeric) Maximum depth, from the genesis block is the default  
       "token": "str",         (string) Filter by token  
       "txtype": "str",        (string) Filter by transaction type, supported letter from {CustomTxType}  
       "limit": n,             (numeric) Maximum number of records to return, 100 by default  
     }  
  
Result:  
[{},{}...]     (array) Objects with vault history information  
  
Examples:  
> defi-cli listvaulthistory 84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2 '{"maxBlockHeight":160,"depth":10}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listvaulthistory", "params": [84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2, '{"maxBlockHeight":160,"depth":10}'] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listvaults ( {"ownerAddress":"str","loanSchemeId":"str","state":"str","verbose":bool} {"start":"hex","including_start":bool,"limit":n} )</summary><p>
listvaults ( {"ownerAddress":"str","loanSchemeId":"str","state":"str","verbose":bool} {"start":"hex","including_start":bool,"limit":n} )  
List all available vaults.  
  
Arguments:  
1. options                         (json object)  
     {  
       "ownerAddress": "str",      (string) Address of the vault owner.  
       "loanSchemeId": "str",      (string) Vault's loan scheme id  
       "state": "str",             (string) Wether the vault is under a given state. (default = 'unknown')  
       "verbose": bool,            (boolean) Flag for verbose list (default = false), otherwise only ids, ownerAddress, loanSchemeIds and state are listed  
     }  
2. pagination                      (json object)  
     {  
       "start": "hex",             (string) Optional first key to iterate from, in lexicographical order. Typically it's set to last ID from previous request.  
       "including_start": bool,    (boolean) If true, then iterate including starting position. False by default  
       "limit": n,                 (numeric) Maximum number of orders to return, 100 by default  
     }  
  
Result:  
[                         (json array of objects)  
{...}                 (object) Json object with vault information  
]  
  
Examples:  
> defi-cli listvaults   
> defi-cli listvaults '{"loanSchemeId": "LOAN1502"}'  
> defi-cli listvaults '{"loanSchemeId": "LOAN1502"}' '{"start":"3ef9fd5bd1d0ce94751e6286710051361e8ef8fac43cca9cb22397bf0d17e013", "including_start": true, "limit":100}'  
> defi-cli listvaults {} '{"start":"3ef9fd5bd1d0ce94751e6286710051361e8ef8fac43cca9cb22397bf0d17e013", "including_start": true, "limit":100}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listvaults", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listvaults", "params": [{"loanSchemeId": "LOAN1502"}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listvaults", "params": [{"loanSchemeId": "LOAN1502"}, {"start":"3ef9fd5bd1d0ce94751e6286710051361e8ef8fac43cca9cb22397bf0d17e013", "including_start": true, "limit":100}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listvaults", "params": [{}, {"start":"3ef9fd5bd1d0ce94751e6286710051361e8ef8fac43cca9cb22397bf0d17e013", "including_start": true, "limit":100}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>paybackwithcollateral "vaultId"</summary><p>
paybackwithcollateral "vaultId"  
Payback vault's loans with vault's collaterals.  
  
Arguments:  
1. vaultId    (string, required) vault hex id  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli paybackwithcollateral 5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "paybackwithcollateral", "params": [5474b2e9bfa96446e5ef3c9594634e1aa22d3a0722cb79084d61253acbdf87bf] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>placeauctionbid "vaultId" index "from" "amount" ( [{"txid":"hex","vout":n},...] )</summary><p>
placeauctionbid "vaultId" index "from" "amount" ( [{"txid":"hex","vout":n},...] )  
Bid to vault in auction.  
  
  
Arguments:  
1. vaultId                 (string, required) Vault id  
2. index                   (numeric, required) Auction index  
3. from                    (string, required) Address to get tokens. If "from" value is: "*" (star), it's means auto-selection accounts from wallet.  
4. amount                  (string, required) Amount of amount@symbol format  
5. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli placeauctionbid 84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2 0 mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF 100@TSLA  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "placeauctionbid", "params": ["84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2", 0, "mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF", "1@DTSLA"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>updatevault "vaultId" {"ownerAddress":"hex","loanSchemeId":"str"} ( [{"txid":"hex","vout":n},...] )</summary><p>
updatevault "vaultId" {"ownerAddress":"hex","loanSchemeId":"str"} ( [{"txid":"hex","vout":n},...] )  
  
Creates (and submits to local node and network) an `update vault transaction`,   
and saves vault updates to database.  
The last optional argument (may be empty array) is an array of specific UTXOs to spend.  
  
Arguments:  
1. vaultId                       (string, required) Vault id  
2. parameters                    (json object, required)  
     {  
       "ownerAddress": "hex",    (string) Vault's owner address  
       "loanSchemeId": "str",    (string) Vault's loan scheme id  
     }  
3. inputs                        (json array, optional) A json array of json objects  
     [  
       {                         (json object)  
         "txid": "hex",          (string, required) The transaction id  
         "vout": n,              (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli updatevault 84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2 '{"ownerAddress": "mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF", "loanSchemeId": "LOANSCHEME001"}'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "updatevault", "params": ["84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2", {"ownerAddress": "mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF", "loanSchemeId": "LOANSCHEME001"}] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>withdrawfromvault "vaultId" "to" "amount" ( [{"txid":"hex","vout":n},...] )</summary><p>
withdrawfromvault "vaultId" "to" "amount" ( [{"txid":"hex","vout":n},...] )  
Withdraw collateral token amount from vault.  
  
  
Arguments:  
1. vaultId                 (string, required) Vault id  
2. to                      (string, required) Destination address for withdraw of collateral  
3. amount                  (string, required) Amount of collateral in amount@symbol format  
4. inputs                  (json array, optional) A json array of json objects  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli withdrawfromvault 84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2i mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF 1@DFI  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "withdrawfromvault", "params": ["84b22eee1964768304e624c416f29a91d78a01dc5e8e12db26bdac0670c67bb2i", "mwSDMvn1Hoc8DsoB7AkLv7nxdrf5Ja4jsF", "1@DFI"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

## Wallet
<details><summary>abandontransaction "txid"</summary><p>
abandontransaction "txid"  
  
Mark in-wallet transaction <txid> as abandoned  
This will mark this transaction and all its in-wallet descendants as abandoned which will allow  
for their inputs to be respent.  It can be used to replace "stuck" or evicted transactions.  
It only works on transactions which are not included in a block and are not currently in the mempool.  
It has no effect on transactions which are already abandoned.  
  
Arguments:  
1. txid    (string, required) The transaction id  
  
Examples:  
> defi-cli abandontransaction "1075db55d416d3ca199f55b6084e2115b9345e16c5cf302fc80e9d5fbf5d48d"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "abandontransaction", "params": ["1075db55d416d3ca199f55b6084e2115b9345e16c5cf302fc80e9d5fbf5d48d"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>abortrescan</summary><p>
abortrescan  
  
Stops current wallet rescan triggered by an RPC call, e.g. by an importprivkey call.  
Note: Use "getwalletinfo" to query the scanning progress.  
  
Examples:  
  
Import a private key  
> defi-cli importprivkey "mykey"  
  
Abort the running wallet rescan  
> defi-cli abortrescan   
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "abortrescan", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>addmultisigaddress nrequired ["key",...] ( "label" "address_type" )</summary><p>
addmultisigaddress nrequired ["key",...] ( "label" "address_type" )  
  
Add a nrequired-to-sign multisignature address to the wallet. Requires a new wallet backup.  
Each key is a Defi address or hex-encoded public key.  
This functionality is only intended for use with non-watchonly addresses.  
See `importaddress` for watchonly p2sh address support.  
If 'label' is specified, assign address to that label.  
  
Arguments:  
1. nrequired       (numeric, required) The number of required signatures out of the n keys or addresses.  
2. keys            (json array, required) A json array of defi addresses or hex-encoded public keys  
     [  
       "key",      (string) defi address or hex-encoded public key  
       ...  
     ]  
3. label           (string, optional) A label to assign the addresses to.  
4. address_type    (string, optional, default=set by -addresstype) The address type to use. Options are "legacy", "p2sh-segwit", and "bech32".  
  
Result:  
{  
  "address":"multisigaddress",    (string) The value of the new multisig address.  
  "redeemScript":"script"         (string) The string value of the hex-encoded redemption script.  
}  
  
Examples:  
  
Add a multisig address from 2 addresses  
> defi-cli addmultisigaddress 2 "[\"16sSauSf5pF2UkUwvKGq4qjNRzBZYqgEL5\",\"171sgjn4YtPu27adkKGrdDwzRTxnRkBfKV\"]"  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "addmultisigaddress", "params": [2, "[\"16sSauSf5pF2UkUwvKGq4qjNRzBZYqgEL5\",\"171sgjn4YtPu27adkKGrdDwzRTxnRkBfKV\"]"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>addressmap "input" type</summary><p>
addressmap "input" type  
Give the equivalent of an address from EVM to DVM and versa  
  
Arguments:  
1. input    (string, required) DVM address or EVM address  
2. type     (numeric, required) Map types:   
            1 - Address format: DFI -> ERC55   
            2 - Address format: ERC55 -> DFI   
              
  
Result:  
{  
    input :    "address",         (string) The input address to be converted  
    type :     "map type"  
       (numeric) address map type indicator    format : {   
       bech32: "address"  
        (string, optional) output converted address       p2pkh:  "address"  
        (string, optional) output converted address       erc55 : "address"  
        ...    }]  
}  
  
Examples:  
> defi-cli addressmap '"<address>"' 1  

</p></details>

<details><summary>backupwallet "destination"</summary><p>
backupwallet "destination"  
  
Safely copies current wallet file to destination, which can be a directory or a path with filename.  
  
Arguments:  
1. destination    (string, required) The destination directory or file  
  
Examples:  
> defi-cli backupwallet "backup.dat"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "backupwallet", "params": ["backup.dat"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>bumpfee "txid" ( options )</summary><p>
bumpfee "txid" ( options )  
  
Bumps the fee of an opt-in-RBF transaction T, replacing it with a new transaction B.  
An opt-in RBF transaction with the given txid must be in the wallet.  
The command will pay the additional fee by reducing change outputs or adding inputs when necessary. It may add a new change output if one does not already exist.  
If `totalFee` (DEPRECATED) is given, adding inputs is not supported, so there must be a single change output that is big enough or it will fail.  
All inputs in the original transaction will be included in the replacement transaction.  
The command will fail if the wallet or mempool contains a transaction that spends one of T's outputs.  
By default, the new fee will be calculated automatically using estimatesmartfee.  
The user can specify a confirmation target for estimatesmartfee.  
Alternatively, the user can specify totalFee (DEPRECATED), or use RPC settxfee to set a higher fee rate.  
At a minimum, the new fee rate must be high enough to pay an additional new relay fee (incrementalfee  
returned by getnetworkinfo) to enter the node's mempool.  
  
Arguments:  
1. txid                           (string, required) The txid to be bumped  
2. options                        (json object, optional)  
     {  
       "confTarget": n,           (numeric, optional, default=wallet default) Confirmation target (in blocks)  
       "totalFee": n,             (numeric, optional, default=fallback to 'confTarget') Total fee (NOT feerate) to pay, in satoshis. (DEPRECATED)  
                                  In rare cases, the actual fee paid might be slightly higher than the specified  
                                  totalFee if the tx change output has to be removed because it is too close to  
                                  the dust threshold.  
       "replaceable": bool,       (boolean, optional, default=true) Whether the new transaction should still be  
                                  marked bip-125 replaceable. If true, the sequence numbers in the transaction will  
                                  be left unchanged from the original. If false, any input sequence numbers in the  
                                  original transaction that were less than 0xfffffffe will be increased to 0xfffffffe  
                                  so the new transaction will not be explicitly bip-125 replaceable (though it may  
                                  still be replaceable in practice, for example if it has unconfirmed ancestors which  
                                  are replaceable).  
       "estimate_mode": "str",    (string, optional, default=UNSET) The fee estimate mode, must be one of:  
                                  "UNSET"  
                                  "ECONOMICAL"  
                                  "CONSERVATIVE"  
     }  
  
Result:  
{  
  "txid":    "value",   (string)  The id of the new transaction  
  "origfee":  n,         (numeric) Fee of the replaced transaction  
  "fee":      n,         (numeric) Fee of the new transaction  
  "errors":  [ str... ] (json array of strings) Errors encountered during processing (may be empty)  
}  
  
Examples:  
  
Bump the fee, get the new transaction's txid  
> defi-cli bumpfee <txid>  

</p></details>

<details><summary>createwallet "wallet_name" ( disable_private_keys blank "passphrase" avoid_reuse )</summary><p>
createwallet "wallet_name" ( disable_private_keys blank "passphrase" avoid_reuse )  
  
Creates and loads a new wallet.  
  
Arguments:  
1. wallet_name             (string, required) The name for the new wallet. If this is a path, the wallet will be created at the path location.  
2. disable_private_keys    (boolean, optional, default=false) Disable the possibility of private keys (only watchonlys are possible in this mode).  
3. blank                   (boolean, optional, default=false) Create a blank wallet. A blank wallet has no keys or HD seed. One can be set using sethdseed.  
4. passphrase              (string) Encrypt the wallet with this passphrase.  
5. avoid_reuse             (boolean, optional, default=false) Keep track of coin reuse, and treat dirty and clean coins differently with privacy considerations in mind.  
  
Result:  
{  
  "name" :    <wallet_name>,        (string) The wallet name if created successfully. If the wallet was created using a full path, the wallet_name will be the full path.  
  "warning" : <warning>,            (string) Warning message if wallet was not loaded cleanly.  
}  
  
Examples:  
> defi-cli createwallet "testwallet"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "createwallet", "params": ["testwallet"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>dumpprivkey "address"</summary><p>
dumpprivkey "address"  
  
Reveals the private key corresponding to 'address'.  
Then the importprivkey can be used with this output  
  
Arguments:  
1. address    (string, required) The DFI address for the private key  
  
Result:  
"key"                (string) The private key  
  
Examples:  
> defi-cli dumpprivkey "myaddress"  
> defi-cli importprivkey "mykey"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "dumpprivkey", "params": ["myaddress"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>dumpwallet "filename"</summary><p>
dumpwallet "filename"  
  
Dumps all wallet keys in a human-readable format to a server-side file. This does not allow overwriting existing files.  
Imported scripts are included in the dumpfile, but corresponding BIP173 addresses, etc. may not be added automatically by importwallet.  
Note that if your wallet contains keys which are not derived from your HD seed (e.g. imported keys), these are not covered by  
only backing up the seed itself, and must be backed up too (e.g. ensure you back up the whole dumpfile).  
  
Arguments:  
1. filename    (string, required) The filename with path (either absolute or relative to defid)  
  
Result:  
{                           (json object)  
  "filename" : {        (string) The filename with full absolute path  
}  
  
Examples:  
> defi-cli dumpwallet "test"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "dumpwallet", "params": ["test"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>encryptwallet "passphrase"</summary><p>
encryptwallet "passphrase"  
  
Encrypts the wallet with 'passphrase'. This is for first time encryption.  
After this, any calls that interact with private keys such as sending or signing   
will require the passphrase to be set prior the making these calls.  
Use the walletpassphrase call for this, and then walletlock call.  
If the wallet is already encrypted, use the walletpassphrasechange call.  
  
Arguments:  
1. passphrase    (string, required) The pass phrase to encrypt the wallet with. It must be at least 1 character, but should be long.  
  
Examples:  
  
Encrypt your wallet  
> defi-cli encryptwallet "my pass phrase"  
  
Now set the passphrase to use the wallet, such as for signing or sending defi  
> defi-cli walletpassphrase "my pass phrase"  
  
Now we can do something like sign  
> defi-cli signmessage "address" "test message"  
  
Now lock the wallet again by removing the passphrase  
> defi-cli walletlock   
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "encryptwallet", "params": ["my pass phrase"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getaddressesbylabel "label"</summary><p>
getaddressesbylabel "label"  
  
Returns the list of addresses assigned the specified label.  
  
Arguments:  
1. label    (string, required) The label.  
  
Result:  
{ (json object with addresses as keys)  
  "address": { (json object with information about address)  
    "purpose": "string" (string)  Purpose of address ("send" for sending address, "receive" for receiving address)  
  },...  
}  
  
Examples:  
> defi-cli getaddressesbylabel "tabby"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getaddressesbylabel", "params": ["tabby"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getaddressinfo "address"</summary><p>
getaddressinfo "address"  
  
Return information about the given defi address. Some information requires the address  
to be in the wallet.  
  
Arguments:  
1. address    (string, required) The defi address to get the information of.  
  
Result:  
{  
  "address" : "address",        (string) The defi address validated  
  "scriptPubKey" : "hex",       (string) The hex-encoded scriptPubKey generated by the address  
  "ismine" : true|false,        (boolean) If the address is yours or not  
  "iswatchonly" : true|false,   (boolean) If the address is watchonly  
  "solvable" : true|false,      (boolean) Whether we know how to spend coins sent to this address, ignoring the possible lack of private keys  
  "desc" : "desc",            (string, optional) A descriptor for spending coins sent to this address (only when solvable)  
  "isscript" : true|false,      (boolean) If the key is a script  
  "ischange" : true|false,      (boolean) If the address was used for change output  
  "iswitness" : true|false,     (boolean) If the address is a witness address  
  "witness_version" : version   (numeric, optional) The version number of the witness program  
  "witness_program" : "hex"     (string, optional) The hex value of the witness program  
  "script" : "type"             (string, optional) The output script type. Only if "isscript" is true and the redeemscript is known. Possible types: nonstandard, pubkey, pubkeyhash, scripthash, multisig, nulldata, witness_v0_keyhash, witness_v0_scripthash, witness_unknown  
  "hex" : "hex",                (string, optional) The redeemscript for the p2sh address  
  "pubkeys"                     (string, optional) Array of pubkeys associated with the known redeemscript (only if "script" is "multisig")  
    [  
      "pubkey"  
      ,...  
    ]  
  "sigsrequired" : xxxxx        (numeric, optional) Number of signatures required to spend multisig output (only if "script" is "multisig")  
  "pubkey" : "publickeyhex",    (string, optional) The hex value of the raw public key, for single-key addresses (possibly embedded in P2SH or P2WSH)  
  "embedded" : {...},           (object, optional) Information about the address embedded in P2SH or P2WSH, if relevant and known. It includes all getaddressinfo output fields for the embedded address, excluding metadata ("timestamp", "hdkeypath", "hdseedid") and relation to the wallet ("ismine", "iswatchonly").  
  "iscompressed" : true|false,  (boolean, optional) If the pubkey is compressed  
  "label" :  "label"         (string) The label associated with the address, "" is the default label  
  "timestamp" : timestamp,      (number, optional) The creation time of the key if available in seconds since epoch (Jan 1 1970 GMT)  
  "hdkeypath" : "keypath"       (string, optional) The HD keypath if the key is HD and available  
  "hdseedid" : "<hash160>"      (string, optional) The Hash160 of the HD seed  
  "hdmasterfingerprint" : "<hash160>" (string, optional) The fingperint of the master key.  
  "labels"                      (object) Array of labels associated with the address.  
    [  
      { (json object of label data)  
        "name": "labelname" (string) The label  
        "purpose": "string" (string) Purpose of address ("send" for sending address, "receive" for receiving address)  
      },...  
    ]  
}  
  
Examples:  
> defi-cli getaddressinfo "1PSSGeFHDnKNxiEyFrD1wcEaHr9hrQDDWc"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getaddressinfo", "params": ["1PSSGeFHDnKNxiEyFrD1wcEaHr9hrQDDWc"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getbalance ( "dummy" minconf include_watchonly avoid_reuse with_tokens )</summary><p>
getbalance ( "dummy" minconf include_watchonly avoid_reuse with_tokens )  
  
Returns the total available balance.  
The available balance is what the wallet considers currently spendable, and is  
thus affected by options which limit spendability such as -spendzeroconfchange.  
  
Arguments:  
1. dummy                (string, optional) Remains for backward compatibility. Must be excluded or set to "*".  
2. minconf              (numeric, optional, default=0) Only include transactions confirmed at least this many times.  
3. include_watchonly    (boolean, optional, default=true for watch-only wallets, otherwise false) Also include balance in watch-only addresses (see 'importaddress')  
4. avoid_reuse          (boolean, optional, default=true) (only available if avoid_reuse wallet flag is set) Do not include balance in dirty outputs; addresses are considered dirty if they have previously been used in a transaction.  
5. with_tokens          (boolean, optional, default=false) Include tokens balances; Default is 'false' for backward compatibility.  
  
Result:  
amount                 (numeric) The total amount in DFI received for this wallet.  
   or  
{tokenId: amount,...}  (list) If used 'with_tokens' option  
  
Examples:  
  
The total amount in the wallet with 1 or more confirmations  
> defi-cli getbalance   
  
The total amount in the wallet at least 6 blocks confirmed  
> defi-cli getbalance "*" 6  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getbalance", "params": ["*", 6] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getbalances ( with_tokens )</summary><p>
getbalances ( with_tokens )  
Returns an object with all balances in DFI.  
  
Arguments:  
1. with_tokens    (boolean, optional, default=false) Include tokens balances; Default is 'false' for backward compatibility.  
  
Result:  
{  
    "mine": {                        (object) balances from outputs that the wallet can sign  
      "trusted": xxx                 (numeric) trusted balance (outputs created by the wallet or confirmed outputs)  
      "untrusted_pending": xxx       (numeric) untrusted pending balance (outputs created by others that are in the mempool)  
      "immature": xxx                (numeric) balance from immature coinbase outputs  
      "used": xxx                    (numeric) (only present if avoid_reuse is set) balance from coins sent to addresses that were previously spent from (potentially privacy violating)  
    },  
    "watchonly": {                   (object) watchonly balances (not present if wallet does not watch anything)  
      "trusted": xxx                 (numeric) trusted balance (outputs created by the wallet or confirmed outputs)  
      "untrusted_pending": xxx       (numeric) untrusted pending balance (outputs created by others that are in the mempool)  
      "immature": xxx                (numeric) balance from immature coinbase outputs  
    },  
}  
  
Examples:  
> defi-cli getbalances   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getbalances", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getnewaddress ( "label" "address_type" )</summary><p>
getnewaddress ( "label" "address_type" )  
  
Returns a new Defi address for receiving payments.  
If 'label' is specified, it is added to the address book   
so payments received with the address will be associated with 'label'.  
  
Arguments:  
1. label           (string, optional, default="") The label name for the address to be linked to. It can also be set to the empty string "" to represent the default label. The label does not need to exist, it will be created if there is no label by the given name.  
2. address_type    (string, optional, default=set by -addresstype) The address type to use. Options are "legacy", "p2sh-segwit", "bech32" and "erc55".  
  
Result:  
"address"    (string) The new defi address  
  
Examples:  
> defi-cli getnewaddress   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getnewaddress", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getrawchangeaddress ( "address_type" )</summary><p>
getrawchangeaddress ( "address_type" )  
  
Returns a new Defi address, for receiving change.  
This is for use with raw transactions, NOT normal use.  
  
Arguments:  
1. address_type    (string, optional, default=set by -changetype) The address type to use. Options are "legacy", "p2sh-segwit", and "bech32".  
  
Result:  
"address"    (string) The address  
  
Examples:  
> defi-cli getrawchangeaddress   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getrawchangeaddress", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getreceivedbyaddress "address" ( minconf )</summary><p>
getreceivedbyaddress "address" ( minconf )  
  
Returns the total amount received by the given address in transactions with at least minconf confirmations.  
  
Arguments:  
1. address    (string, required) The defi address for transactions.  
2. minconf    (numeric, optional, default=1) Only include transactions confirmed at least this many times.  
  
Result:  
amount   (numeric) The total amount in DFI received at this address.  
  
Examples:  
  
The amount from transactions with at least 1 confirmation  
> defi-cli getreceivedbyaddress "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX"  
  
The amount including unconfirmed transactions, zero confirmations  
> defi-cli getreceivedbyaddress "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX" 0  
  
The amount with at least 6 confirmations  
> defi-cli getreceivedbyaddress "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX" 6  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getreceivedbyaddress", "params": ["1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX", 6] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getreceivedbylabel "label" ( minconf )</summary><p>
getreceivedbylabel "label" ( minconf )  
  
Returns the total amount received by addresses with <label> in transactions with at least [minconf] confirmations.  
  
Arguments:  
1. label      (string, required) The selected label, may be the default label using "".  
2. minconf    (numeric, optional, default=1) Only include transactions confirmed at least this many times.  
  
Result:  
amount              (numeric) The total amount in DFI received for this label.  
  
Examples:  
  
Amount received by the default label with at least 1 confirmation  
> defi-cli getreceivedbylabel ""  
  
Amount received at the tabby label including unconfirmed amounts with zero confirmations  
> defi-cli getreceivedbylabel "tabby" 0  
  
The amount with at least 6 confirmations  
> defi-cli getreceivedbylabel "tabby" 6  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getreceivedbylabel", "params": ["tabby", 6] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>gettransaction "txid" ( include_watchonly )</summary><p>
gettransaction "txid" ( include_watchonly )  
  
Get detailed information about in-wallet transaction <txid>  
  
Arguments:  
1. txid                 (string, required) The transaction id  
2. include_watchonly    (boolean, optional, default=true for watch-only wallets, otherwise false) Whether to include watch-only addresses in balance calculation and details[]  
  
Result:  
{  
  "amount" : x.xxx,        (numeric) The transaction amount in DFI  
  "fee": x.xxx,            (numeric) The amount of the fee in DFI. This is negative and only available for the   
                              'send' category of transactions.  
  "confirmations" : n,     (numeric) The number of confirmations  
  "blockhash" : "hash",  (string) The block hash  
  "blockindex" : xx,       (numeric) The index of the transaction in the block that includes it  
  "blocktime" : ttt,       (numeric) The time in seconds since epoch (1 Jan 1970 GMT)  
  "txid" : "transactionid",   (string) The transaction id.  
  "time" : ttt,            (numeric) The transaction time in seconds since epoch (1 Jan 1970 GMT)  
  "timereceived" : ttt,    (numeric) The time received in seconds since epoch (1 Jan 1970 GMT)  
  "bip125-replaceable": "yes|no|unknown",  (string) Whether this transaction could be replaced due to BIP125 (replace-by-fee);  
                                                   may be unknown for unconfirmed transactions not in the mempool  
  "details" : [  
    {  
      "address" : "address",          (string) The defi address involved in the transaction  
      "category" :                      (string) The transaction category.  
                   "send"                  Transactions sent.  
                   "receive"               Non-coinbase transactions received.  
                   "generate"              Coinbase transactions received with more than 100 confirmations.  
                   "immature"              Coinbase transactions received with 100 or fewer confirmations.  
                   "orphan"                Orphaned coinbase transactions received.  
      "amount" : x.xxx,                 (numeric) The amount in DFI  
      "label" : "label",              (string) A comment for the address/transaction, if any  
      "vout" : n,                       (numeric) the vout value  
      "fee": x.xxx,                     (numeric) The amount of the fee in DFI. This is negative and only available for the   
                                           'send' category of transactions.  
      "abandoned": xxx                  (bool) 'true' if the transaction has been abandoned (inputs are respendable). Only available for the   
                                           'send' category of transactions.  
    }  
    ,...  
  ],  
  "hex" : "data"         (string) Raw data for transaction  
}  
  
Examples:  
> defi-cli gettransaction "1075db55d416d3ca199f55b6084e2115b9345e16c5cf302fc80e9d5fbf5d48d"  
> defi-cli gettransaction "1075db55d416d3ca199f55b6084e2115b9345e16c5cf302fc80e9d5fbf5d48d" true  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "gettransaction", "params": ["1075db55d416d3ca199f55b6084e2115b9345e16c5cf302fc80e9d5fbf5d48d"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>getunconfirmedbalance ( with_tokens )</summary><p>
getunconfirmedbalance ( with_tokens )  
DEPRECATED  
Identical to getbalances().mine.untrusted_pending  
  
Arguments:  
1. with_tokens    (boolean, optional, default=false) Include tokens balances; Default is 'false' for backward compatibility.  

</p></details>

<details><summary>getwalletinfo ( with_tokens )</summary><p>
getwalletinfo ( with_tokens )  
Returns an object containing various wallet state info.  
  
Arguments:  
1. with_tokens    (boolean, optional, default=false) Include tokens balances; Default is 'false' for backward compatibility.  
  
Result:  
{  
  "walletname": xxxxx,               (string) the wallet name  
  "walletversion": xxxxx,            (numeric) the wallet version  
  "balance": xxxxxxx,                (numeric) DEPRECATED. Identical to getbalances().mine.trusted  
  "unconfirmed_balance": xxx,        (numeric) DEPRECATED. Identical to getbalances().mine.untrusted_pending  
  "immature_balance": xxxxxx,        (numeric) DEPRECATED. Identical to getbalances().mine.immature  
  "txcount": xxxxxxx,                (numeric) the total number of transactions in the wallet  
  "keypoololdest": xxxxxx,           (numeric) the timestamp (seconds since Unix epoch) of the oldest pre-generated key in the key pool  
  "keypoolsize": xxxx,               (numeric) how many new keys are pre-generated (only counts external keys)  
  "keypoolsize_hd_internal": xxxx,   (numeric) how many new keys are pre-generated for internal use (used for change outputs, only appears if the wallet is using this feature, otherwise external keys are used)  
  "unlocked_until": ttt,             (numeric) the timestamp in seconds since epoch (midnight Jan 1 1970 GMT) that the wallet is unlocked for transfers, or 0 if the wallet is locked  
  "paytxfee": x.xxxx,                (numeric) the transaction fee configuration, set in DFI/kB  
  "hdseedid": "<hash160>"            (string, optional) the Hash160 of the HD seed (only present when HD is enabled)  
  "private_keys_enabled": true|false (boolean) false if privatekeys are disabled for this wallet (enforced watch-only wallet)  
  "avoid_reuse": true|false          (boolean) whether this wallet tracks clean/dirty coins in terms of reuse  
  "scanning":                        (json object) current scanning details, or false if no scan is in progress  
    {  
      "duration" : xxxx              (numeric) elapsed seconds since scan start  
      "progress" : x.xxxx,           (numeric) scanning progress percentage [0.0, 1.0]  
    }  
}  
  
Examples:  
> defi-cli getwalletinfo   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getwalletinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>importaddress "address" ( "label" rescan p2sh )</summary><p>
importaddress "address" ( "label" rescan p2sh )  
  
Adds an address or script (in hex) that can be watched as if it were in your wallet but cannot be used to spend. Requires a new wallet backup.  
  
Note: This call can take over an hour to complete if rescan is true, during that time, other rpc calls  
may report that the imported address exists but related transactions are still missing, leading to temporarily incorrect/bogus balances and unspent outputs until rescan completes.  
If you have the full public key, you should call importpubkey instead of this.  
Hint: use importmulti to import more than one address.  
  
Note: If you import a non-standard raw script in hex form, outputs sending to it will be treated  
as change, and not show up in many RPCs.  
Note: Use "getwalletinfo" to query the scanning progress.  
  
Arguments:  
1. address    (string, required) The DFI address (or hex-encoded script)  
2. label      (string, optional, default="") An optional label  
3. rescan     (boolean, optional, default=true) Rescan the wallet for transactions  
4. p2sh       (boolean, optional, default=false) Add the P2SH version of the script as well  
  
Examples:  
  
Import an address with rescan  
> defi-cli importaddress "myaddress"  
  
Import using a label without rescan  
> defi-cli importaddress "myaddress" "testing" false  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "importaddress", "params": ["myaddress", "testing", false] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>importmulti "requests" ( "options" )</summary><p>
importmulti "requests" ( "options" )  
  
Import addresses/scripts (with private or public keys, redeem script (P2SH)), optionally rescanning the blockchain from the earliest creation time of the imported scripts. Requires a new wallet backup.  
If an address/script is imported without all of the private keys required to spend from that address, it will be watchonly. The 'watchonly' option must be set to true in this case or a warning will be returned.  
Conversely, if all the private keys are provided and the address/script is spendable, the watchonly option must be set to false, or a warning will be returned.  
  
Note: This call can take over an hour to complete if rescan is true, during that time, other rpc calls  
may report that the imported keys, addresses or scripts exist but related transactions are still missing.  
Note: Use "getwalletinfo" to query the scanning progress.  
  
Arguments:  
1. requests                                                         (json array, required) Data to be imported  
     [  
       {                                                            (json object)  
         "desc": "str",                                             (string) Descriptor to import. If using descriptor, do not also provide address/scriptPubKey, scripts, or pubkeys  
         "scriptPubKey": "<script>" | { "address":"<address>" },    (string / json, required) Type of scriptPubKey (string for script, json for address). Should not be provided if using a descriptor  
         "timestamp": timestamp | "now",                            (integer / string, required) Creation time of the key in seconds since epoch (Jan 1 1970 GMT),  
                                                                    or the string "now" to substitute the current synced blockchain time. The timestamp of the oldest  
                                                                    key will determine how far back blockchain rescans need to begin for missing wallet transactions.  
                                                                    "now" can be specified to bypass scanning, for keys which are known to never have been used, and  
                                                                    0 can be specified to scan the entire blockchain. Blocks up to 2 hours before the earliest key  
                                                                    creation time of all keys being imported by the importmulti call will be scanned.  
         "redeemscript": "str",                                     (string) Allowed only if the scriptPubKey is a P2SH or P2SH-P2WSH address/scriptPubKey  
         "witnessscript": "str",                                    (string) Allowed only if the scriptPubKey is a P2SH-P2WSH or P2WSH address/scriptPubKey  
         "pubkeys": [                                               (json array, optional, default=empty array) Array of strings giving pubkeys to import. They must occur in P2PKH or P2WPKH scripts. They are not required when the private key is also provided (see the "keys" argument).  
           "pubKey",                                                (string)  
           ...  
         ],  
         "keys": [                                                  (json array, optional, default=empty array) Array of strings giving private keys to import. The corresponding public keys must occur in the output or redeemscript.  
           "key",                                                   (string)  
           ...  
         ],  
         "range": n or [n,n],                                       (numeric or array) If a ranged descriptor is used, this specifies the end or the range (in the form [begin,end]) to import  
         "internal": bool,                                          (boolean, optional, default=false) Stating whether matching outputs should be treated as not incoming payments (also known as change)  
         "watchonly": bool,                                         (boolean, optional, default=false) Stating whether matching outputs should be considered watchonly.  
         "label": "str",                                            (string, optional, default='') Label to assign to the address, only allowed with internal=false  
         "keypool": bool,                                           (boolean, optional, default=false) Stating whether imported public keys should be added to the keypool for when users request new addresses. Only allowed when wallet private keys are disabled  
       },  
       ...  
     ]  
2. options                                                          (json object, optional)  
     {  
       "rescan": bool,                                              (boolean, optional, default=true) Stating if should rescan the blockchain after all imports  
     }  
  
Result:  
  
Response is an array with the same size as the input that has the execution result :  
  [{"success": true}, {"success": true, "warnings": ["Ignoring irrelevant private key"]}, {"success": false, "error": {"code": -1, "message": "Internal Server Error"}}, ...]  
  
Examples:  
> defi-cli importmulti '[{ "scriptPubKey": { "address": "<my address>" }, "timestamp":1455191478 }, { "scriptPubKey": { "address": "<my 2nd address>" }, "label": "example 2", "timestamp": 1455191480 }]'  
> defi-cli importmulti '[{ "scriptPubKey": { "address": "<my address>" }, "timestamp":1455191478 }]' '{ "rescan": false}'  

</p></details>

<details><summary>importprivkey "privkey" ( "label" rescan )</summary><p>
importprivkey "privkey" ( "label" rescan )  
  
Adds a private key (as returned by dumpprivkey) to your wallet. Requires a new wallet backup.  
Hint: use importmulti to import more than one private key.  
  
Note: This call can take over an hour to complete if rescan is true, during that time, other rpc calls  
may report that the imported key exists but related transactions are still missing, leading to temporarily incorrect/bogus balances and unspent outputs until rescan completes.  
Note: Use "getwalletinfo" to query the scanning progress.  
  
Arguments:  
1. privkey    (string, required) The private key (see dumpprivkey)  
2. label      (string, optional, default=current label if address exists, otherwise "") An optional label  
3. rescan     (boolean, optional, default=true) Rescan the wallet for transactions  
  
Examples:  
  
Dump a private key  
> defi-cli dumpprivkey "myaddress"  
  
Import the private key with rescan  
> defi-cli importprivkey "mykey"  
  
Import using a label and without rescan  
> defi-cli importprivkey "mykey" "testing" false  
  
Import using default blank label and without rescan  
> defi-cli importprivkey "mykey" "" false  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "importprivkey", "params": ["mykey", "testing", false] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>importprunedfunds "rawtransaction" "txoutproof"</summary><p>
importprunedfunds "rawtransaction" "txoutproof"  
  
Imports funds without rescan. Corresponding address or script must previously be included in wallet. Aimed towards pruned wallets. The end-user is responsible to import additional transactions that subsequently spend the imported outputs or rescan after the point in the blockchain the transaction is included.  
  
Arguments:  
1. rawtransaction    (string, required) A raw transaction in hex funding an already-existing address in wallet  
2. txoutproof        (string, required) The hex output from gettxoutproof that contains the transaction  

</p></details>

<details><summary>importpubkey "pubkey" ( "label" rescan )</summary><p>
importpubkey "pubkey" ( "label" rescan )  
  
Adds a public key (in hex) that can be watched as if it were in your wallet but cannot be used to spend. Requires a new wallet backup.  
Hint: use importmulti to import more than one public key.  
  
Note: This call can take over an hour to complete if rescan is true, during that time, other rpc calls  
may report that the imported pubkey exists but related transactions are still missing, leading to temporarily incorrect/bogus balances and unspent outputs until rescan completes.  
Note: Use "getwalletinfo" to query the scanning progress.  
  
Arguments:  
1. pubkey    (string, required) The hex-encoded public key  
2. label     (string, optional, default="") An optional label  
3. rescan    (boolean, optional, default=true) Rescan the wallet for transactions  
  
Examples:  
  
Import a public key with rescan  
> defi-cli importpubkey "mypubkey"  
  
Import using a label without rescan  
> defi-cli importpubkey "mypubkey" "testing" false  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "importpubkey", "params": ["mypubkey", "testing", false] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>importwallet "filename"</summary><p>
importwallet "filename"  
  
Imports keys from a wallet dump file (see dumpwallet). Requires a new wallet backup to include imported keys.  
Note: Use "getwalletinfo" to query the scanning progress.  
  
Arguments:  
1. filename    (string, required) The wallet file  
  
Examples:  
  
Dump the wallet  
> defi-cli dumpwallet "test"  
  
Import the wallet  
> defi-cli importwallet "test"  
  
Import using the json rpc call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "importwallet", "params": ["test"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>keypoolrefill ( newsize )</summary><p>
keypoolrefill ( newsize )  
  
Fills the keypool.  
  
Arguments:  
1. newsize    (numeric, optional, default=100) The new keypool size  
  
Examples:  
> defi-cli keypoolrefill   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "keypoolrefill", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listaddressgroupings</summary><p>
listaddressgroupings  
  
Lists groups of addresses which have had their common ownership  
made public by common use as inputs or as the resulting change  
in past transactions  
  
Result:  
[  
  [  
    [  
      "address",            (string) The defi address  
      amount,                 (numeric) The amount in DFI  
      "label"               (string, optional) The label  
    ]  
    ,...  
  ]  
  ,...  
]  
  
Examples:  
> defi-cli listaddressgroupings   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listaddressgroupings", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listlabels ( "purpose" )</summary><p>
listlabels ( "purpose" )  
  
Returns the list of all labels, or labels that are assigned to addresses with a specific purpose.  
  
Arguments:  
1. purpose    (string, optional) Address purpose to list labels for ('send','receive'). An empty string is the same as not providing this argument.  
  
Result:  
[               (json array of string)  
  "label",      (string) Label name  
  ...  
]  
  
Examples:  
  
List all labels  
> defi-cli listlabels   
  
List labels that have receiving addresses  
> defi-cli listlabels receive  
  
List labels that have sending addresses  
> defi-cli listlabels send  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listlabels", "params": [receive] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listlockunspent</summary><p>
listlockunspent  
  
Returns list of temporarily unspendable outputs.  
See the lockunspent call to lock and unlock transactions for spending.  
  
Result:  
[  
  {  
    "txid" : "transactionid",     (string) The transaction id locked  
    "vout" : n                      (numeric) The vout value  
  }  
  ,...  
]  
  
Examples:  
  
List the unspent transactions  
> defi-cli listunspent   
  
Lock an unspent transaction  
> defi-cli lockunspent false "[{\"txid\":\"a08e6907dbbd3d809776dbfc5d82e371b764ed838b5655e72f463568df1aadf0\",\"vout\":1}]"  
  
List the locked transactions  
> defi-cli listlockunspent   
  
Unlock the transaction again  
> defi-cli lockunspent true "[{\"txid\":\"a08e6907dbbd3d809776dbfc5d82e371b764ed838b5655e72f463568df1aadf0\",\"vout\":1}]"  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listlockunspent", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listreceivedbyaddress ( minconf include_empty include_watchonly "address_filter" )</summary><p>
listreceivedbyaddress ( minconf include_empty include_watchonly "address_filter" )  
  
List balances by receiving address.  
  
Arguments:  
1. minconf              (numeric, optional, default=1) The minimum number of confirmations before payments are included.  
2. include_empty        (boolean, optional, default=false) Whether to include addresses that haven't received any payments.  
3. include_watchonly    (boolean, optional, default=true for watch-only wallets, otherwise false) Whether to include watch-only addresses (see 'importaddress')  
4. address_filter       (string, optional) If present, only return information on this address.  
  
Result:  
[  
  {  
    "involvesWatchonly" : true,        (bool) Only returned if imported addresses were involved in transaction  
    "address" : "receivingaddress",  (string) The receiving address  
    "amount" : x.xxx,                  (numeric) The total amount in DFI received by the address  
    "confirmations" : n,               (numeric) The number of confirmations of the most recent transaction included  
    "label" : "label",               (string) The label of the receiving address. The default label is "".  
    "txids": [  
       "txid",                         (string) The ids of transactions received with the address   
       ...  
    ]  
  }  
  ,...  
]  
  
Examples:  
> defi-cli listreceivedbyaddress   
> defi-cli listreceivedbyaddress 6 true  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listreceivedbyaddress", "params": [6, true, true] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listreceivedbyaddress", "params": [6, true, true, "1M72Sfpbz1BPpXFHz9m3CdqATR44Jvaydd"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listreceivedbylabel ( minconf include_empty include_watchonly )</summary><p>
listreceivedbylabel ( minconf include_empty include_watchonly )  
  
List received transactions by label.  
  
Arguments:  
1. minconf              (numeric, optional, default=1) The minimum number of confirmations before payments are included.  
2. include_empty        (boolean, optional, default=false) Whether to include labels that haven't received any payments.  
3. include_watchonly    (boolean, optional, default=true for watch-only wallets, otherwise false) Whether to include watch-only addresses (see 'importaddress')  
  
Result:  
[  
  {  
    "involvesWatchonly" : true,   (bool) Only returned if imported addresses were involved in transaction  
    "amount" : x.xxx,             (numeric) The total amount received by addresses with this label  
    "confirmations" : n,          (numeric) The number of confirmations of the most recent transaction included  
    "label" : "label"           (string) The label of the receiving address. The default label is "".  
  }  
  ,...  
]  
  
Examples:  
> defi-cli listreceivedbylabel   
> defi-cli listreceivedbylabel 6 true  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listreceivedbylabel", "params": [6, true, true] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listsinceblock ( "blockhash" target_confirmations include_watchonly include_removed )</summary><p>
listsinceblock ( "blockhash" target_confirmations include_watchonly include_removed )  
  
Get all transactions in blocks since block [blockhash], or all transactions if omitted.  
If "blockhash" is no longer a part of the main chain, transactions from the fork point onward are included.  
Additionally, if include_removed is set, transactions affecting the wallet which were removed are returned in the "removed" array.  
  
Arguments:  
1. blockhash               (string, optional) If set, the block hash to list transactions since, otherwise list all transactions.  
2. target_confirmations    (numeric, optional, default=1) Return the nth block hash from the main chain. e.g. 1 would mean the best block hash. Note: this is not used as a filter, but only affects [lastblock] in the return value  
3. include_watchonly       (boolean, optional, default=true for watch-only wallets, otherwise false) Include transactions to watch-only addresses (see 'importaddress')  
4. include_removed         (boolean, optional, default=true) Show transactions that were removed due to a reorg in the "removed" array  
                           (not guaranteed to work on pruned nodes)  
  
Result:  
{  
  "transactions": [  
    "address":"address",    (string) The defi address of the transaction.  
    "category":               (string) The transaction category.  
                "send"                  Transactions sent.  
                "receive"               Non-coinbase transactions received.  
                "generate"              Coinbase transactions received with more than 100 confirmations.  
                "immature"              Coinbase transactions received with 100 or fewer confirmations.  
                "orphan"                Orphaned coinbase transactions received.  
    "amount": x.xxx,          (numeric) The amount in DFI. This is negative for the 'send' category, and is positive  
                                         for all other categories  
    "vout" : n,               (numeric) the vout value  
    "fee": x.xxx,             (numeric) The amount of the fee in DFI. This is negative and only available for the 'send' category of transactions.  
    "confirmations": n,       (numeric) The number of confirmations for the transaction.  
                                          When it's < 0, it means the transaction conflicted that many blocks ago.  
    "blockhash": "hashvalue",     (string) The block hash containing the transaction.  
    "blockindex": n,          (numeric) The index of the transaction in the block that includes it.  
    "blocktime": xxx,         (numeric) The block time in seconds since epoch (1 Jan 1970 GMT).  
    "txid": "transactionid",  (string) The transaction id.  
    "time": xxx,              (numeric) The transaction time in seconds since epoch (Jan 1 1970 GMT).  
    "timereceived": xxx,      (numeric) The time received in seconds since epoch (Jan 1 1970 GMT).  
    "bip125-replaceable": "yes|no|unknown",  (string) Whether this transaction could be replaced due to BIP125 (replace-by-fee);  
                                                   may be unknown for unconfirmed transactions not in the mempool  
    "abandoned": xxx,         (bool) 'true' if the transaction has been abandoned (inputs are respendable). Only available for the 'send' category of transactions.  
    "comment": "...",       (string) If a comment is associated with the transaction.  
    "label" : "label"       (string) A comment for the address/transaction, if any  
    "to": "...",            (string) If a comment to is associated with the transaction.  
  ],  
  "removed": [  
    <structure is the same as "transactions" above, only present if include_removed=true>  
    Note: transactions that were re-added in the active chain will appear as-is in this array, and may thus have a positive confirmation count.  
  ],  
  "lastblock": "lastblockhash"     (string) The hash of the block (target_confirmations-1) from the best block on the main chain. This is typically used to feed back into listsinceblock the next time you call it. So you would generally use a target_confirmations of say 6, so you will be continually re-notified of transactions until they've reached 6 confirmations plus any new ones  
}  
  
Examples:  
> defi-cli listsinceblock   
> defi-cli listsinceblock "000000000000000bacf66f7497b7dc45ef753ee9a7d38571037cdb1a57f663ad" 6  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listsinceblock", "params": ["000000000000000bacf66f7497b7dc45ef753ee9a7d38571037cdb1a57f663ad", 6] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listtransactions ( "label" count skip include_watchonly exclude_custom_tx )</summary><p>
listtransactions ( "label" count skip include_watchonly exclude_custom_tx )  
  
If a label name is provided, this will return only incoming transactions paying to addresses with the specified label.  
  
Returns up to 'count' most recent transactions skipping the first 'from' transactions.  
  
Arguments:  
1. label                (string, optional) If set, should be a valid label name to return only incoming transactions  
                        with the specified label, or "*" to disable filtering and return all transactions.  
2. count                (numeric, optional, default=10) The number of transactions to return  
3. skip                 (numeric, optional, default=0) The number of transactions to skip  
4. include_watchonly    (boolean, optional, default=true for watch-only wallets, otherwise false) Include transactions to watch-only addresses (see 'importaddress')  
5. exclude_custom_tx    (boolean, optional, default=false to include all transactions, otherwise exclude custom transactions) Exclude custom transactions  
  
Result:  
[  
  {  
    "address":"address",    (string) The defi address of the transaction.  
    "category":               (string) The transaction category.  
                "send"                  Transactions sent.  
                "receive"               Non-coinbase transactions received.  
                "generate"              Coinbase transactions received with more than 100 confirmations.  
                "immature"              Coinbase transactions received with 100 or fewer confirmations.  
                "orphan"                Orphaned coinbase transactions received.  
    "amount": x.xxx,          (numeric) The amount in DFI. This is negative for the 'send' category, and is positive  
                                        for all other categories  
    "label": "label",       (string) A comment for the address/transaction, if any  
    "vout": n,                (numeric) the vout value  
    "fee": x.xxx,             (numeric) The amount of the fee in DFI. This is negative and only available for the   
                                         'send' category of transactions.  
    "confirmations": n,       (numeric) The number of confirmations for the transaction. Negative confirmations indicate the  
                                         transaction conflicts with the block chain  
    "trusted": xxx,           (bool) Whether we consider the outputs of this unconfirmed transaction safe to spend.  
    "blockhash": "hashvalue", (string) The block hash containing the transaction.  
    "blockindex": n,          (numeric) The index of the transaction in the block that includes it.  
    "blocktime": xxx,         (numeric) The block time in seconds since epoch (1 Jan 1970 GMT).  
    "txid": "transactionid", (string) The transaction id.  
    "time": xxx,              (numeric) The transaction time in seconds since epoch (midnight Jan 1 1970 GMT).  
    "timereceived": xxx,      (numeric) The time received in seconds since epoch (midnight Jan 1 1970 GMT).  
    "comment": "...",       (string) If a comment is associated with the transaction.  
    "generated": "...",       (boolean) If transaction is a coinbase transaction.  
    "walletconflicts": [  
      "txid": "..." (string) Conflicting transaction ID  
    ],  
    "bip125-replaceable": "yes|no|unknown",  (string) Whether this transaction could be replaced due to BIP125 (replace-by-fee);  
                                                     may be unknown for unconfirmed transactions not in the mempool  
    "abandoned": xxx          (bool) 'true' if the transaction has been abandoned (inputs are respendable). Only available for the   
                                         'send' category of transactions.  
  }  
]  
  
Examples:  
  
List the most recent 10 transactions in the systems  
> defi-cli listtransactions   
  
List transactions 100 to 120  
> defi-cli listtransactions "*" 20 100  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listtransactions", "params": ["*", 20, 100] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listunspent ( minconf maxconf ["address",...] include_unsafe query_options )</summary><p>
listunspent ( minconf maxconf ["address",...] include_unsafe query_options )  
  
Returns array of unspent transaction outputs  
with between minconf and maxconf (inclusive) confirmations.  
Optionally filter to only include txouts paid to specified addresses.  
  
Arguments:  
1. minconf                            (numeric, optional, default=1) The minimum confirmations to filter  
2. maxconf                            (numeric, optional, default=9999999) The maximum confirmations to filter  
3. addresses                          (json array, optional, default=empty array) A json array of defi addresses to filter  
     [  
       "address",                     (string) defi address  
       ...  
     ]  
4. include_unsafe                     (boolean, optional, default=true) Include outputs that are not safe to spend  
                                      See description of "safe" attribute below.  
5. query_options                      (json object, optional) JSON with query options  
     {  
       "minimumAmount": amount,       (numeric or string, optional, default=0) Minimum value of each UTXO in DFI  
       "maximumAmount": amount,       (numeric or string, optional, default=unlimited) Maximum value of each UTXO in DFI  
       "maximumCount": n,             (numeric, optional, default=unlimited) Maximum number of UTXOs  
       "minimumSumAmount": amount,    (numeric or string, optional, default=unlimited) Minimum sum value of all UTXOs in DFI  
       "tokenId": "str",              (string, optional, default=all) Filter by token (id/symbol/creationTx)  
     }  
  
Result:  
[                   (array of json object)  
  {  
    "txid" : "txid",          (string) the transaction id   
    "vout" : n,               (numeric) the vout value  
    "address" : "address",    (string) the defi address  
    "label" : "label",        (string) The associated label, or "" for the default label  
    "scriptPubKey" : "key",   (string) the script key  
    "amount" : x.xxx,         (numeric) the transaction output amount in DFI  
    "tokenId" : n,            (numeric) the transaction output token Id  
    "confirmations" : n,      (numeric) The number of confirmations  
    "redeemScript" : "script" (string) The redeemScript if scriptPubKey is P2SH  
    "witnessScript" : "script" (string) witnessScript if the scriptPubKey is P2WSH or P2SH-P2WSH  
    "spendable" : xxx,        (bool) Whether we have the private keys to spend this output  
    "solvable" : xxx,         (bool) Whether we know how to spend this output, ignoring the lack of keys  
    "reused" : xxx,           (bool) (only present if avoid_reuse is set) Whether this output is reused/dirty (sent to an address that was previously spent from)  
    "desc" : xxx,             (string, only when solvable) A descriptor for spending this output  
    "safe" : xxx              (bool) Whether this output is considered safe to spend. Unconfirmed transactions  
                              from outside keys and unconfirmed replacement transactions are considered unsafe  
                              and are not eligible for spending by fundrawtransaction and sendtoaddress.  
  }  
  ,...  
]  
  
Examples:  
> defi-cli listunspent   
> defi-cli listunspent 6 9999999 "[\"1PGFqEzfmQch1gKD3ra4k18PNj3tTUUSqg\",\"1LtvqCaApEdUGFkpKMM4MstjcaL4dKg8SP\"]"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listunspent", "params": [6, 9999999 "[\"1PGFqEzfmQch1gKD3ra4k18PNj3tTUUSqg\",\"1LtvqCaApEdUGFkpKMM4MstjcaL4dKg8SP\"]"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  
> defi-cli listunspent 6 9999999 '[]' true '{ "minimumAmount": 0.005 }'  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listunspent", "params": [6, 9999999, [] , true, { "minimumAmount": 0.005 } ] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listwalletdir</summary><p>
listwalletdir  
Returns a list of wallets in the wallet directory.  
  
Result:  
{  
  "wallets" : [                (json array of objects)  
    {  
      "name" : "name"          (string) The wallet name  
    }  
    ,...  
  ]  
}  
  
Examples:  
> defi-cli listwalletdir   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listwalletdir", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>listwallets</summary><p>
listwallets  
Returns a list of currently loaded wallets.  
For full information on the wallet, use "getwalletinfo"  
  
Result:  
[                         (json array of strings)  
  "walletname"            (string) the wallet name  
   ...  
]  
  
Examples:  
> defi-cli listwallets   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "listwallets", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>loadwallet "filename"</summary><p>
loadwallet "filename"  
  
Loads a wallet from a wallet file or directory.  
Note that all wallet command-line options used when starting defid will be  
applied to the new wallet (eg -zapwallettxes, upgradewallet, rescan, etc).  
  
Arguments:  
1. filename    (string, required) The wallet directory or .dat file.  
  
Result:  
{  
  "name" :    <wallet_name>,        (string) The wallet name if loaded successfully.  
  "warning" : <warning>,            (string) Warning message if wallet was not loaded cleanly.  
}  
  
Examples:  
> defi-cli loadwallet "test.dat"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "loadwallet", "params": ["test.dat"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>lockunspent unlock ( [{"txid":"hex","vout":n},...] )</summary><p>
lockunspent unlock ( [{"txid":"hex","vout":n},...] )  
  
Updates list of temporarily unspendable outputs.  
Temporarily lock (unlock=false) or unlock (unlock=true) specified transaction outputs.  
If no transaction outputs are specified when unlocking then all current locked transaction outputs are unlocked.  
A locked transaction output will not be chosen by automatic coin selection, when spending defis.  
Locks are stored in memory only. Nodes start with zero locked outputs, and the locked output list  
is always cleared (by virtue of process exit) when a node stops or fails.  
Also see the listunspent call  
  
Arguments:  
1. unlock                  (boolean, required) Whether to unlock (true) or lock (false) the specified transactions  
2. transactions            (json array, optional, default=empty array) A json array of objects. Each object the txid (string) vout (numeric).  
     [  
       {                   (json object)  
         "txid": "hex",    (string, required) The transaction id  
         "vout": n,        (numeric, required) The output number  
       },  
       ...  
     ]  
  
Result:  
true|false    (boolean) Whether the command was successful or not  
  
Examples:  
  
List the unspent transactions  
> defi-cli listunspent   
  
Lock an unspent transaction  
> defi-cli lockunspent false "[{\"txid\":\"a08e6907dbbd3d809776dbfc5d82e371b764ed838b5655e72f463568df1aadf0\",\"vout\":1}]"  
  
List the locked transactions  
> defi-cli listlockunspent   
  
Unlock the transaction again  
> defi-cli lockunspent true "[{\"txid\":\"a08e6907dbbd3d809776dbfc5d82e371b764ed838b5655e72f463568df1aadf0\",\"vout\":1}]"  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "lockunspent", "params": [false, "[{\"txid\":\"a08e6907dbbd3d809776dbfc5d82e371b764ed838b5655e72f463568df1aadf0\",\"vout\":1}]"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>removeprunedfunds "txid"</summary><p>
removeprunedfunds "txid"  
  
Deletes the specified transaction from the wallet. Meant for use with pruned wallets and as a companion to importprunedfunds. This will affect wallet balances.  
  
Arguments:  
1. txid    (string, required) The hex-encoded id of the transaction you are deleting  
  
Examples:  
> defi-cli removeprunedfunds "a8d0c0184dde994a09ec054286f1ce581bebf46446a512166eae7628734ea0a5"  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "removeprunedfunds", "params": ["a8d0c0184dde994a09ec054286f1ce581bebf46446a512166eae7628734ea0a5"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>rescanblockchain ( start_height stop_height )</summary><p>
rescanblockchain ( start_height stop_height )  
  
Rescan the local blockchain for wallet related transactions.  
Note: Use "getwalletinfo" to query the scanning progress.  
  
Arguments:  
1. start_height    (numeric, optional, default=0) block height where the rescan should start  
2. stop_height     (numeric, optional) the last block height that should be scanned. If none is provided it will rescan up to the tip at return time of this call.  
  
Result:  
{  
  "start_height"     (numeric) The block height where the rescan started (the requested height or 0)  
  "stop_height"      (numeric) The height of the last rescanned block. May be null in rare cases if there was a reorg and the call didn't scan any blocks because they were already scanned in the background.  
}  
  
Examples:  
> defi-cli rescanblockchain 100000 120000  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "rescanblockchain", "params": [100000, 120000] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>sendmany "" {"address":amount} ( minconf "comment" ["address",...] replaceable conf_target "estimate_mode" )</summary><p>
sendmany "" {"address":amount} ( minconf "comment" ["address",...] replaceable conf_target "estimate_mode" )  
  
Send multiple times. Amounts are double-precision floating point numbers.  
  
Arguments:  
1. dummy                     (string, required) Must be set to "" for backwards compatibility.  
2. amounts                   (json object, required) A json object with addresses and amounts  
     {  
       "address": amount,    (numeric or string, required) The defi address is the key, the numeric amount (can be string) in DFI is the value  
     }  
3. minconf                   (numeric, optional) Ignored dummy value  
4. comment                   (string, optional) A comment  
5. subtractfeefrom           (json array, optional) A json array with addresses.  
                             The fee will be equally deducted from the amount of each selected address.  
                             Those recipients will receive less defis than you enter in their corresponding amount field.  
                             If no addresses are specified here, the sender pays the fee.  
     [  
       "address",            (string) Subtract fee from this address  
       ...  
     ]  
6. replaceable               (boolean, optional, default=wallet default) Allow this transaction to be replaced by a transaction with higher fees via BIP 125  
7. conf_target               (numeric, optional, default=wallet default) Confirmation target (in blocks)  
8. estimate_mode             (string, optional, default=UNSET) The fee estimate mode, must be one of:  
                             "UNSET"  
                             "ECONOMICAL"  
                             "CONSERVATIVE"  
  
Result:  
"txid"                   (string) The transaction id for the send. Only 1 transaction is created regardless of   
                                    the number of addresses.  
  
Examples:  
  
Send two amounts to two different addresses:  
> defi-cli sendmany "" "{\"1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX\":0.01,\"1353tsE8YMTA4EuV7dgUXGjNFf9KpVvKHz\":0.02}"  
  
Send two amounts to two different addresses setting the confirmation and comment:  
> defi-cli sendmany "" "{\"1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX\":0.01,\"1353tsE8YMTA4EuV7dgUXGjNFf9KpVvKHz\":0.02}" 6 "testing"  
  
Send two amounts to two different addresses, subtract fee from amount:  
> defi-cli sendmany "" "{\"1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX\":0.01,\"1353tsE8YMTA4EuV7dgUXGjNFf9KpVvKHz\":0.02}" 1 "" "[\"1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX\",\"1353tsE8YMTA4EuV7dgUXGjNFf9KpVvKHz\"]"  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "sendmany", "params": ["", {"1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX":0.01,"1353tsE8YMTA4EuV7dgUXGjNFf9KpVvKHz":0.02}, 6, "testing"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>sendtoaddress "address" amount ( "comment" "comment_to" subtractfeefromamount replaceable conf_target "estimate_mode" avoid_reuse )</summary><p>
sendtoaddress "address" amount ( "comment" "comment_to" subtractfeefromamount replaceable conf_target "estimate_mode" avoid_reuse )  
  
Send an amount to a given address.  
  
Arguments:  
1. address                  (string, required) The defi address to send to.  
2. amount                   (numeric or string, required) The amount in DFI to send. eg 0.1  
3. comment                  (string, optional) A comment used to store what the transaction is for.  
                            This is not part of the transaction, just kept in your wallet.  
4. comment_to               (string, optional) A comment to store the name of the person or organization  
                            to which you're sending the transaction. This is not part of the   
                            transaction, just kept in your wallet.  
5. subtractfeefromamount    (boolean, optional, default=false) The fee will be deducted from the amount being sent.  
                            The recipient will receive less defis than you enter in the amount field.  
6. replaceable              (boolean, optional, default=wallet default) Allow this transaction to be replaced by a transaction with higher fees via BIP 125  
7. conf_target              (numeric, optional, default=wallet default) Confirmation target (in blocks)  
8. estimate_mode            (string, optional, default=UNSET) The fee estimate mode, must be one of:  
                            "UNSET"  
                            "ECONOMICAL"  
                            "CONSERVATIVE"  
9. avoid_reuse              (boolean, optional, default=true) (only available if avoid_reuse wallet flag is set) Avoid spending from dirty addresses; addresses are considered  
                            dirty if they have previously been used in a transaction.  
  
Result:  
"hash"                  (string) The hex-encoded hash of broadcasted transaction  
  
Examples:  
> defi-cli sendtoaddress "1M72Sfpbz1BPpXFHz9m3CdqATR44Jvaydd" 0.1  
> defi-cli sendtoaddress "1M72Sfpbz1BPpXFHz9m3CdqATR44Jvaydd" 0.1 "donation" "seans outpost"  
> defi-cli sendtoaddress "1M72Sfpbz1BPpXFHz9m3CdqATR44Jvaydd" 0.1 "" "" true  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "sendtoaddress", "params": ["1M72Sfpbz1BPpXFHz9m3CdqATR44Jvaydd", 0.1, "donation", "seans outpost"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>sethdseed ( newkeypool "seed" )</summary><p>
sethdseed ( newkeypool "seed" )  
  
Set or generate a new HD wallet seed. Non-HD wallets will not be upgraded to being a HD wallet. Wallets that are already  
HD will have a new HD seed set so that new keys added to the keypool will be derived from this new seed.  
  
Note that you will need to MAKE A NEW BACKUP of your wallet after setting the HD wallet seed.  
  
Arguments:  
1. newkeypool    (boolean, optional, default=true) Whether to flush old unused addresses, including change addresses, from the keypool and regenerate it.  
                 If true, the next address from getnewaddress and change address from getrawchangeaddress will be from this new seed.  
                 If false, addresses (including change addresses if the wallet already had HD Chain Split enabled) from the existing  
                 keypool will be used until it has been depleted.  
2. seed          (string, optional, default=random seed) The WIF private key to use as the new HD seed.  
                 The seed value can be retrieved using the dumpwallet command. It is the private key marked hdseed=1  
  
Examples:  
> defi-cli sethdseed   
> defi-cli sethdseed false  
> defi-cli sethdseed true "wifkey"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "sethdseed", "params": [true, "wifkey"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>setlabel "address" "label"</summary><p>
setlabel "address" "label"  
  
Sets the label associated with the given address.  
  
Arguments:  
1. address    (string, required) The defi address to be associated with a label.  
2. label      (string, required) The label to assign to the address.  
  
Examples:  
> defi-cli setlabel "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX" "tabby"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "setlabel", "params": ["1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX", "tabby"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>settxfee amount</summary><p>
settxfee amount  
  
Set the transaction fee per kB for this wallet. Overrides the global -paytxfee command line parameter.  
  
Arguments:  
1. amount    (numeric or string, required) The transaction fee in DFI/kB  
  
Result:  
true|false        (boolean) Returns true if successful  
  
Examples:  
> defi-cli settxfee 0.00001  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "settxfee", "params": [0.00001] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>setwalletflag "flag" ( value )</summary><p>
setwalletflag "flag" ( value )  
  
Change the state of the given wallet flag for a wallet.  
  
Arguments:  
1. flag     (string, required) The name of the flag to change. Current available flags: avoid_reuse  
2. value    (boolean, optional, default=true) The new state.  
  
Result:  
{  
    "flag_name": string   (string) The name of the flag that was modified  
    "flag_state": bool    (bool) The new state of the flag  
    "warnings": string    (string) Any warnings associated with the change  
}  
  
Examples:  
> defi-cli setwalletflag avoid_reuse  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "setwalletflag", "params": ["avoid_reuse"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>signmessage "address" "message"</summary><p>
signmessage "address" "message"  
  
Sign a message with the private key of an address  
  
Arguments:  
1. address    (string, required) The defi address to use for the private key.  
2. message    (string, required) The message to create a signature of.  
  
Result:  
"signature"          (string) The signature of the message encoded in base 64  
  
Examples:  
  
Unlock the wallet for 30 seconds  
> defi-cli walletpassphrase "mypassphrase" 30  
  
Create the signature  
> defi-cli signmessage "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX" "my message"  
  
Verify the signature  
> defi-cli verifymessage "1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX" "signature" "my message"  
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "signmessage", "params": ["1D1ZrZNe3JUo7ZycKEYQQiQAWd9y54F4XX", "my message"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>signrawtransactionwithwallet "hexstring" ( [{"txid":"hex","vout":n,"scriptPubKey":"hex","redeemScript":"hex","witnessScript":"hex","amount":amount},...] "sighashtype" )</summary><p>
signrawtransactionwithwallet "hexstring" ( [{"txid":"hex","vout":n,"scriptPubKey":"hex","redeemScript":"hex","witnessScript":"hex","amount":amount},...] "sighashtype" )  
  
Sign inputs for raw transaction (serialized, hex-encoded).  
The second optional argument (may be null) is an array of previous transaction outputs that  
this transaction depends on but may not yet be in the block chain.  
  
Arguments:  
1. hexstring                        (string, required) The transaction hex string  
2. prevtxs                          (json array, optional) A json array of previous dependent transaction outputs  
     [  
       {                            (json object)  
         "txid": "hex",             (string, required) The transaction id  
         "vout": n,                 (numeric, required) The output number  
         "scriptPubKey": "hex",     (string, required) script key  
         "redeemScript": "hex",     (string) (required for P2SH) redeem script  
         "witnessScript": "hex",    (string) (required for P2WSH or P2SH-P2WSH) witness script  
         "amount": amount,          (numeric or string) (required for Segwit inputs) the amount spent  
       },  
       ...  
     ]  
3. sighashtype                      (string, optional, default=ALL) The signature hash type. Must be one of  
                                    "ALL"  
                                    "NONE"  
                                    "SINGLE"  
                                    "ALL|ANYONECANPAY"  
                                    "NONE|ANYONECANPAY"  
                                    "SINGLE|ANYONECANPAY"  
  
Result:  
{  
  "hex" : "value",                  (string) The hex-encoded raw transaction with signature(s)  
  "complete" : true|false,          (boolean) If the transaction has a complete set of signatures  
  "errors" : [                      (json array of objects) Script verification errors (if there are any)  
    {  
      "txid" : "hash",              (string) The hash of the referenced, previous transaction  
      "vout" : n,                   (numeric) The index of the output to spent and used as input  
      "scriptSig" : "hex",          (string) The hex-encoded signature script  
      "sequence" : n,               (numeric) Script sequence number  
      "error" : "text"              (string) Verification or signing error related to the input  
    }  
    ,...  
  ]  
}  
  
Examples:  
> defi-cli signrawtransactionwithwallet "myhex"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "signrawtransactionwithwallet", "params": ["myhex"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>unloadwallet ( "wallet_name" )</summary><p>
unloadwallet ( "wallet_name" )  
Unloads the wallet referenced by the request endpoint otherwise unloads the wallet specified in the argument.  
Specifying the wallet name on a wallet endpoint is invalid.  
Arguments:  
1. wallet_name    (string, optional, default=the wallet name from the RPC request) The name of the wallet to unload.  
  
Examples:  
> defi-cli unloadwallet wallet_name  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "unloadwallet", "params": [wallet_name] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>walletcreatefundedpsbt [{"txid":"hex","vout":n,"sequence":n},...] [{"address":amount},{"data":"hex"},...] ( locktime options bip32derivs )</summary><p>
walletcreatefundedpsbt [{"txid":"hex","vout":n,"sequence":n},...] [{"address":amount},{"data":"hex"},...] ( locktime options bip32derivs )  
  
Creates and funds a transaction in the Partially Signed Transaction format. Inputs will be added if supplied inputs are not enough  
Implements the Creator and Updater roles.  
  
Arguments:  
1. inputs                             (json array, required) A json array of json objects  
     [  
       {                              (json object)  
         "txid": "hex",               (string, required) The transaction id  
         "vout": n,                   (numeric, required) The output number  
         "sequence": n,               (numeric, required) The sequence number  
       },  
       ...  
     ]  
2. outputs                            (json array, required) a json array with outputs (key-value pairs), where none of the keys are duplicated.  
                                      That is, each address can only appear once and there can only be one 'data' object.  
                                      For compatibility reasons, a dictionary, which holds the key-value pairs directly, is also  
                                      accepted as second parameter.  
     [  
       {                              (json object)  
         "address": amount,           (numeric or string, required) A key-value pair. The key (string) is the defi address, the value (float or string) is the amount in DFI  
       },  
       {                              (json object)  
         "data": "hex",               (string, required) A key-value pair. The key must be "data", the value is hex-encoded data  
       },  
       ...  
     ]  
3. locktime                           (numeric, optional, default=0) Raw locktime. Non-0 value also locktime-activates inputs  
4. options                            (json object, optional)  
     {  
       "changeAddress": "hex",        (string, optional, default=pool address) The defi address to receive the change  
       "changePosition": n,           (numeric, optional, default=random) The index of the change output  
       "change_type": "str",          (string, optional, default=set by -changetype) The output type to use. Only valid if changeAddress is not specified. Options are "legacy", "p2sh-segwit", and "bech32".  
       "includeWatching": bool,       (boolean, optional, default=true for watch-only wallets, otherwise false) Also select inputs which are watch only  
       "lockUnspents": bool,          (boolean, optional, default=false) Lock selected unspent outputs  
       "feeRate": amount,             (numeric or string, optional, default=not set: makes wallet determine the fee) Set a specific fee rate in DFI/kB  
       "subtractFeeFromOutputs": [    (json array, optional, default=empty array) A json array of integers.  
                                      The fee will be equally deducted from the amount of each specified output.  
                                      Those recipients will receive less defis than you enter in their corresponding amount field.  
                                      If no outputs are specified here, the sender pays the fee.  
         vout_index,                  (numeric) The zero-based output index, before a change output is added.  
         ...  
       ],  
       "replaceable": bool,           (boolean, optional, default=wallet default) Marks this transaction as BIP125 replaceable.  
                                      Allows this transaction to be replaced by a transaction with higher fees  
       "conf_target": n,              (numeric, optional, default=Fallback to wallet's confirmation target) Confirmation target (in blocks)  
       "estimate_mode": "str",        (string, optional, default=UNSET) The fee estimate mode, must be one of:  
                                      "UNSET"  
                                      "ECONOMICAL"  
                                      "CONSERVATIVE"  
     }  
5. bip32derivs                        (boolean, optional, default=false) If true, includes the BIP 32 derivation paths for public keys if we know them  
  
Result:  
{  
  "psbt": "value",        (string)  The resulting raw transaction (base64-encoded string)  
  "fee":       n,         (numeric) Fee in DFI the resulting transaction pays  
  "changepos": n          (numeric) The position of the added change output, or -1  
}  
  
Examples:  
  
Create a transaction with no inputs  
> defi-cli walletcreatefundedpsbt "[{\"txid\":\"myid\",\"vout\":0}]" "[{\"data\":\"00010203\"}]"  

</p></details>

<details><summary>walletlock</summary><p>
walletlock  
  
Removes the wallet encryption key from memory, locking the wallet.  
After calling this method, you will need to call walletpassphrase again  
before being able to call any methods which require the wallet to be unlocked.  
  
Examples:  
  
Set the passphrase for 2 minutes to perform a transaction  
> defi-cli walletpassphrase "my pass phrase" 120  
  
Perform a send (requires passphrase set)  
> defi-cli sendtoaddress "1M72Sfpbz1BPpXFHz9m3CdqATR44Jvaydd" 1.0  
  
Clear the passphrase since we are done before 2 minutes is up  
> defi-cli walletlock   
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "walletlock", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>walletpassphrase "passphrase" timeout</summary><p>
walletpassphrase "passphrase" timeout  
  
Stores the wallet decryption key in memory for 'timeout' seconds.  
This is needed prior to performing transactions related to private keys such as sending defis  
  
Note:  
Issuing the walletpassphrase command while the wallet is already unlocked will set a new unlock  
time that overrides the old one.  
  
Arguments:  
1. passphrase    (string, required) The wallet passphrase  
2. timeout       (numeric, required) The time to keep the decryption key in seconds; capped at 100000000 (~3 years).  
  
Examples:  
  
Unlock the wallet for 60 seconds  
> defi-cli walletpassphrase "my pass phrase" 60  
  
Lock the wallet again (before 60 seconds)  
> defi-cli walletlock   
  
As a JSON-RPC call  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "walletpassphrase", "params": ["my pass phrase", 60] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>walletpassphrasechange "oldpassphrase" "newpassphrase"</summary><p>
walletpassphrasechange "oldpassphrase" "newpassphrase"  
  
Changes the wallet passphrase from 'oldpassphrase' to 'newpassphrase'.  
  
Arguments:  
1. oldpassphrase    (string, required) The current passphrase  
2. newpassphrase    (string, required) The new passphrase  
  
Examples:  
> defi-cli walletpassphrasechange "old one" "new one"  
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "walletpassphrasechange", "params": ["old one", "new one"] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

<details><summary>walletprocesspsbt "psbt" ( sign "sighashtype" bip32derivs )</summary><p>
walletprocesspsbt "psbt" ( sign "sighashtype" bip32derivs )  
  
Update a PSBT with input information from our wallet and then sign inputs  
that we can sign for.  
  
Arguments:  
1. psbt           (string, required) The transaction base64 string  
2. sign           (boolean, optional, default=true) Also sign the transaction when updating  
3. sighashtype    (string, optional, default=ALL) The signature hash type to sign with if not specified by the PSBT. Must be one of  
                  "ALL"  
                  "NONE"  
                  "SINGLE"  
                  "ALL|ANYONECANPAY"  
                  "NONE|ANYONECANPAY"  
                  "SINGLE|ANYONECANPAY"  
4. bip32derivs    (boolean, optional, default=false) If true, includes the BIP 32 derivation paths for public keys if we know them  
  
Result:  
{  
  "psbt" : "value",          (string) The base64-encoded partially signed transaction  
  "complete" : true|false,   (boolean) If the transaction has a complete set of signatures  
  ]  
}  
  
Examples:  
> defi-cli walletprocesspsbt "psbt"  

</p></details>

## Zmq
<details><summary>getzmqnotifications</summary><p>
getzmqnotifications  
  
Returns information about the active ZeroMQ notifications.  
  
Result:  
[  
  {                        (json object)  
    "type": "pubhashtx",   (string) Type of notification  
    "address": "...",      (string) Address of the publisher  
    "hwm": n                 (numeric) Outbound message high water mark  
  },  
  ...  
]  
  
Examples:  
> defi-cli getzmqnotifications   
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getzmqnotifications", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8554/  

</p></details>

