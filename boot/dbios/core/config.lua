--set configs (dawn only)
--saved to /etc/config/

local args = {...}

local function e(a)
    return a == nil or a == ""
end

local configs = {
    "simpleboot"
}

if e(args[1]) then
    print("usage: config (-l/-s <config>/-u <config>)")
elseif args[1] == "-l" then
    for _,v in pairs(configs) do
        if fs.exists("/etc/config/"..v) then
            print(v.." - enabled")
        else
            print(v.." - disabled")
        end
    end
elseif args[1] == "-s" then
    if e(args[2]) then
        print("usage (-s): config -s <config>")
    else
        for _,v in pairs(configs) do
            if args[2] == v then
                if fs.exists("/etc/config/"..args[2]) then
                    print("Config exists.")
                    error()
                else
                    fs.copy("/etc/file","/etc/config/"..args[2])
                    error()
                end
            else
                print("Config doesn't exist: "..args[2])
                error()
            end
        end
    end
elseif args[1] == "-u" then
    if e(args[2]) then
        print("usage (-u): config -u <config>")
    else
        for _,v in pairs(configs) do
            if args[2] == v then
                if fs.exists("/etc/config/"..args[2]) ~= true then
                    print("Config not set.")
                    error()
                else
                    fs.delete("/etc/config/"..args[2])
                    error()
                end
            else
                print("Config doesn't exist: "..args[2])
                error()
            end
        end
    end
end