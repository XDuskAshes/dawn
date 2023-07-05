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
    local uName
    local pWord
    local sudo
    local cShell
    local uHome

    if k.empty(args[2]) then
        print("No arg for uName provided")
        error()
    else
        uName = args[2]
    end

    if k.empty(args[3]) then
        print("No arg for pWord provided")
        error()
    else
        pWord = args[3]
    end

    if k.empty(args[4]) then
        print("No sudo arg (-y/-n) given")
        error()
    elseif args[4] == "-y" then
        sudo = true
    elseif args[4] == "-n" then
        sudo = false
    else
        print(args[4],"not suitable sudo arg")
        error()
    end

    if k.empty(args[5]) then
        print("Input shell.")
        error()
    else
        cShell = args[5]
    end

    if k.empty(args[6]) then
        print("Provide home arg (-y/-n)")
        error()
    elseif args[6] == "-y" then
        uHome = true
    elseif args[6] == "-n" then
        uHome = false
    else
        print(args[6],"not suitable home arg")
        error()
    end

    local ID
    local UUID
    local b = {}
    local handle = fs.open("/etc/passwd","r")
    repeat
        local a = handle.readLine()
        table.insert(b,a)
    until k.empty(a)
    handle.close()

    for i,v in ipairs(b) do
        ID = i
    end

    UUID = ID

    if uHome ~= true then
        local tWrite = uName..":"..pWord..":"..UUID..":".."/home/"..uName..":".."/usr/bin/"..cShell..".lua"
        local handle2 = fs.open("/etc/passwd","a")
        handle2.writeLine(tWrite)
        handle2.close()
    else
        local tWrite = uName..":"..pWord..":"..UUID..":".."/home/"..uName..":".."/usr/bin/"..cShell..".lua"
        local handle2 = fs.open("/etc/passwd","a")
        handle2.writeLine(tWrite)
        handle2.close()
    end

    if sudo == true then
        local handle3 = fs.open("/etc/sudoers","a")
        handle3.writeLine(uName)
        handle3.close()
    end

elseif args[1] == "-r" then
    local check = fs.open("/etc/usr/.login","r")
    local a = check.readLine()
    check.close()
    if args[2] == "root" then
        k.scrMSG(5,"root cannot be removed.")
    elseif args[2] == a then
            k.scrMSG(5,"cannot remove:"..args[2].." (is current user)")
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