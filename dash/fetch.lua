--[[
    dash fetch
    made for dawn
    by dusk
]]

local ver = fs.open("/stat/.dawninf", "r")
local z = ver.readLine(1)
local vers = ver.readLine(2)
ver.close()

print("runtime",_HOST)
print("lua",_VERSION)
print(vers)