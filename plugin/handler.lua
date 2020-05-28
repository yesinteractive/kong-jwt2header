-- dynamic routing based on JWT Claim

local jwt = require "kong.openid-connect.jwt"
local jws = require "kong.openid-connect.jws"
local sub = string.sub
local type = type
local pairs = pairs
local lower = string.lower


local JWT2Header = {
  PRIORITY = 900,
  VERSION = "1.0"
}


function JWT2Header:rewrite(conf)
   kong.service.request.set_header("X-Kong-JWT-Kong-Proceed", "no")
  kong.log.debug(kong.request.get_header("Authorization") )
   local claims = nil
   if kong.request.get_header("Authorization") ~= nil then kong.log.debug(kong.request.get_header("Authorization") )
    if  string.match(lower(kong.request.get_header("Authorization")), 'bearer') ~= nil then kong.log.debug("2" ..   kong.request.get_path() )
      if jwt.type(sub(kong.request.get_header("Authorization"), 8)) == "JWS" then  kong.log.debug("3" )
        if type(jws.decode(sub(kong.request.get_header("Authorization"), 8), { verify_signature = false })) == "table" then  kong.log.debug("4" .. kong.request.get_path() )
          -- token = 
           claims = jws.decode(sub(kong.request.get_header("Authorization"), 8), { verify_signature = false }).payload
           kong.service.request.set_header("X-Kong-JWT-Kong-Proceed", "yes")
        end
      end
    end
  end

  if kong.request.get_header("X-Kong-JWT-Kong-Proceed") == "yes" then
    for claim, value in pairs(claims) do
      if type(claim) == "string" and type(value) == "string" then
        kong.service.request.set_header("X-Kong-JWT-Claim-" .. claim, value)
      end
    end
   end
 
end


function JWT2Header:access(conf)
  if kong.request.get_header("X-Kong-JWT-Kong-Proceed") == "yes" then    
      -- ctx oesn't work in kong 1.5, only in 2.x local claims = kong.ctx.plugin.claims
      local claims = kong.request.get_headers();
      if not claims then
        kong.log.debug("empty claim" )
        return
      end

    if conf.strip_claims == "true" then
      for claim, value in pairs(claims) do
          kong.log.debug("found header " .. claim )
        if type(claim) == "string" and string.match(claim, 'x%-kong%-jwt%-claim') ~= nil then  
          kong.service.request.clear_header(claim)
          kong.log.debug("removed header " .. claim)
        end
      end
      kong.service.request.clear_header("X-Kong-JWT-Kong-Proceed")
    end

      --kong.ctx.plugin.claims = nil
   elseif conf.token_required == "true" then 
        kong.service.request.clear_header("X-Kong-JWT-Kong-Proceed")
        kong.response.exit(404, '{"error": "No valid JWT token found"}')
   else kong.service.request.clear_header("X-Kong-JWT-Kong-Proceed")
   
  end
end



return JWT2Header
