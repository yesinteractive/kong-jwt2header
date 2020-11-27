# Kong Plugin: JWT To Header (Route by JWT Claim)
![alt text](https://github.com/yesinteractive/kong-jwt2header/blob/master/banner-jwt2header.png "Kong Jwt2header plugin")

Update: Previously this plugin only worked with Kong Enterprise but has been updated to support both Kong community and enterprise as it uses the Kong commmunity JWT libraries.

This Kong Plugin can be used to route requests by JWT claim. It does this by converting JWT claims to headers during rewrite phase so 
that Kong's route by header functionality can be used to route the request appropriately. Alternatively, the plugin can be used to 
simply convert JWT claims to headers that can be consumed by the upstream service. 

Please note that this plugin does NOT validate JWT tokens. You will still need to use the proper Kong auth plugin (JWT, OIDC, etc.) to do so. 

## Installation

### Manual

1. To manually install plugin, create directory called `/usr/local/share/lua/5.1/kong/plugins/kong-jwt2header` on Kong node and copy contents of `/plugins` directory there.
2. Update your KONG_PLUGINS environment variable or configuration to include `kong-jwt2header`
3. Restart Kong and you're ready to go.

If you are using Docker, a helpful script is included to help deploy the plugin to a Docker container and reload Kong with proper env variables.

### luarocks

Verify Git is installed on your Kong Node then install via luarocks:

<pre>
$ apk add --no-cache git
$ luarocks install kong-jwt2header
</pre>

Once installed, besure to include `kong-jwt2header` in your KONG_PLUGINS environment variable and reload Kong. 


## Configuration

Since this plugin has elements that must run in the Rewrite execution phase, this plugin can only be configured to run globally in a kong workspace or cluster.

<pre>
$ curl -X POST http://kong:8001/plugins \
    --data "name=kong-jwt2header" \
    --data "config.strip_claims=false" \
    --data "config.token_required=true"
</pre>


| Parameter     | Default     | Description  |  Required  |
| ------------- |-------------|------------- |-------------| 
| strip\_claims | false |  If enabled, claims will be removed from headers before being sent upstream. | yes
| token\_required      | true     |   If enabled, an error will be returned if token is not present in request | yes

