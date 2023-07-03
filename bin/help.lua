--[[
    Help program
    Pull from /etc/dash/help/
    By Dusk
]]

local kernel = require "/kernel"

local args = {...}
if #args < 1 then
    local t = {}
    local handle = fs.open("/etc/dash/commlist","r")
    repeat
        local a = handle.readLine()
        table.insert(t,a)
    until a == nil
    for i,v in ipairs(t) do
        textutils.pagedPrint(v)
    end
    error()
end

if args[1] == "-l" then
    local i = fs.list("/bin/")
        for k,v in pairs(i) do
            print(v)
        end
elseif kernel.empty(args[1]) then
    print("No empty args[1]")
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