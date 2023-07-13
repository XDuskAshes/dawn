--[[
    dash fetch
    made for dawn
    by dusk
]]

local ver = fs.open("/stat/.dawninf", "r")
local z = ver.readLine()
local vers = ver.readLine()
ver.close()

print("runtime",_HOST)
print("lua",_VERSION)
print(vers)
