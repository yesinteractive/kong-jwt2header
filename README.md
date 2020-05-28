# Kong Plugin: JWT To Header (Route by JWT Claim)

This Kong Plugin can be used to route requests by JWT claim. It does this by converting JWT claims to headers during rewrite phase so 
that Kong's route by header functionality can be used to route the request appropriately. Alternatively, the plugin can be used to 
simply convert JWT claims to headers that can be consumed by the upstream service. 

## Installation

### Manual

To manually install plugin, create directory called `/usr/local/share/lua/5.1/kong/plugins/jwt2header` on Kong node and copy contents of `/plugins` directory there.

Restart Kong and you're ready to go.

### luarocks

Verify Git is installed on your Kong Node then install via luarocks:

<pre>
$ apk add --no-cache git
$ luarocks install kong-jwt2header
</pre>


## Configuration

You can add the plugin on a service by executing the following request against the Kong admin API (plugins can also be applied to a route, consumer, globally, etc.):

<pre>
$ curl -X POST http://kong:8001/services/SERVICE_NAME_OR_ID/plugins \
    --data "name=jwt2header" \
    --data "config.strip_claims=false" \
    --data "config.token_required=true"
</pre>


| Parameter     | Default     | Description  |  Required  |
| ------------- |-------------|------------- |-------------| 
| strip\_claims | false |  If enabled, claims will be removed from headers before being sent upstream. | yes
| token\_required      | true     |   If enabled, an error will be returned if token is not present in request | yes

