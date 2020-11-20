local typedefs = require "kong.db.schema.typedefs"


return {
  name = "jwt-to-header",
  fields = {
    {
      route = typedefs.no_route,
    },
    {
      service = typedefs.no_service,
    },
    {
      consumer = typedefs.no_consumer,
    },
    {
      protocols = typedefs.protocols_http,
    },
    {
      config = {
        type = "record",
        fields = {
            {  strip_claims = { type     = "string", required = true, default  = "false" }, },
            {  token_required = { type     = "string", required = true, default  = "true" }, },          
        },
      },
    },
  },
}
