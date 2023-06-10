--[[
    dawn fetch
    by dusk
]]

local ver = fs.open("/var/.dawninf", "r")
local version = ver.readLine(2)
ver.close()

print("runtime",_HOST)
print("lua",_VERSION)
print(version)