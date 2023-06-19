--[[
    Help program
    Pull from /etc/dash/help/
    By Dusk
]]

local kernel = require "/kernel"

local args = {...}
if #args < 1 then
    print("Usage: help (<topic>, -i)")
    return
end

if args[1] == "-i" then
    local i = fs.list("/etc/dash/help/")
    for k,v in pairs(i) do
        print(v)
    end
elseif args[1] == "-l" then
    local i = fs.list("/usr/bin/dash/")
        for k,v in pairs(i) do
            print(v)
        end
else
    local a = fs.open("/etc/dash/help/"..args[1],"r")
    if a == nil then
        kernel.scrMSG(4,"Cannot get: '"..args[1].."' (nil value)")
    else
        local content = a.readAll()
        a.close()
        print(content)
    end
end