package = "kong-log-google"
version = "1.0-1"

source = {
  url = "git://github.com/yesinteractive/kong-log-google.git"
}

description = {
  summary = "Logs Kong gatway transactions to Google Analytics",
  license = "MIT"
}

dependencies = {
  "lua ~> 5.1"
}

build = {
  type = "builtin",
  modules = {
    ["kong.plugins.jwt2header.handler"] = "plugin/handler.lua",
    ["kong.plugins.jwt2header.schema"] = "plugin/schema.lua",
  }
}
