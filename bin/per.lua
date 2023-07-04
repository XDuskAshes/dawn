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
    print("| SIDE | TYPE |")
    for i,v in ipairs(per) do
        local t = peripheral.getType(v)
        if v == "bottom" then v = "bott" end
        if v == "front" then v = "fron" end
        if t == "speaker" then t = "spea" end
        if t == "drive" then t = "driv" end
        print("|",v,"|",t,"|")
    end
end

if args[1] == "disk" then
    
end