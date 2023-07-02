--[[
    Peripheral messery
    by Dusk
]]

local k = require "/kernel"

local args = {...}
local mnt
local per = peripheral.getNames()

if k.empty(args[1]) then
    print("Usage: read the docs")
    error()
end

if args[1] == "-m" then
    if not periphemu then
        print("-m only available in CCPC")
        error()
    else
        print("Work on this in ccpc")
    end
end

if args[1] == "-l" then
    for i,v in ipairs(per) do
        local t = peripheral.getType(v)
        print("SIDE | TYPE")
        print(v,"|",t)
    end
end

if args[1] == "disk" then
    
end