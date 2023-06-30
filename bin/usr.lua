--[[
    All user stuffs
    By Dusk
]]

local k = require "/kernel"

local function isempty(s) --i robbed this from https://stackoverflow.com/questions/19664666/check-if-a-string-isnt-nil-or-empty-in-lua
    return s == nil or s == ''
end

local args = {...}

if args[1] == "-a" then
    local toWrite = ""
elseif args[1] == "-r" then
    if args[2] == "root" then
        k.scrMSG(5,"root cannot be removed.")
    else
        local user
        local passwd = {}
        local handle = fs.open("/etc/passwd","r")
        repeat
            local a = handle.readLine()
            table.insert(passwd,a)
        until a == nil
        handle.close()
        for i,v in pairs(passwd) do
            user = string.match(v, "([^:]+):([^:]+):([^:]+):([^:]+):([^:]+)")
            if args[2] == user then
                table.remove(passwd,i)
                fs.delete("/etc/passwd")
                fs.copy("/etc/file","/etc/passwd")
                local handle2 = fs.open("/etc/passwd","w")
                for u,b in pairs(passwd) do
                    local a = handle2.writeLine(b)
                end
                handle2.close()
            end
        end
    end
elseif args[1] == "-l" then
    local wdpass = {}
    local handle3 = fs.open("/etc/passwd","r")
    repeat
        local b = handle3.readLine()
        table.insert(wdpass,b)
    until b == nil
    
else
    print("Usage: usr (-a/-r/-l)")
end