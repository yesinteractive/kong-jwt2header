package = "kong-jwt2header"
version = "1.0-3"

source = {
  url = "https://github.com/yesinteractive/kong-jwt2header.git"
}

description = {
  summary = "Converts JWT claims to Headers to allow for Routing by JWT Claim and/or upstream JWT Claim consumption by header",
  license = "MIT"
}

dependencies = {
  "lua ~> 5.1"
}

build = {
  type = "builtin",
  modules = {
    ["kong.plugins.kong-jwt2header.handler"] = "plugin/handler.lua",
    ["kong.plugins.kong-jwt2header.schema"] = "plugin/schema.lua",
  }
}
