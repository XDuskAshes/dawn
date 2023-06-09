--[[
    Dawn Kernel
    By Dusk
    1.0.0-idev1
]]

local function _SYSCALL()
    local i = fs.open("/var/.dawninf","r")
    local inf1 = i.readLine(1)
    local inf2 = i.readLine(2)
    local inf3 = i.readLine(3)
    local inf4 = i.readLine(4)
    i.close()
    print(inf1)
    print(inf2)
    print(inf3)
    print(inf4)
end

local function checkbase()
    local basefs = {
        "/bin/",
        "/boot/",
        "/dev/",
        "/etc/",
        "/lib/",
        "/mnt/",
        "/opt/",
        "/run/",
        "/sbin/",
        "/srv/",
        "/startup/",
        "/tmp/",
        "/var/",
        "/sys/",
        "/usr/",
        "/usr/bin/",
        "/usr/lib/",
        "/usr/local/",
        "/usr/sbin/",
        "/usr/share/"
    }

    local core = {
        "/kernel.lua",
        "/boot/.bootfile",
        "/boot/dboot.lua",
        "/usr/bin/dash.lua"
    }
    
    for _,v in pairs(basefs) do
        if fs.exists(v) ~= true then
            printError("/kernel.lua:53:",v,"does not exist.")
            error()
        end
    end
    
    for _,v in pairs(core) do
        if fs.exists(v) ~= true then
            printError("/kernel.lua:60:",v,"does not exist.")
            error()
        end
    end
end

--kernelcall()

function kernelcall(func) --call kernel functions
    local funcs = {
        [ "_SYSCALL" ] = _SYSCALL,
        [ "checkbase" ] = checkbase
    }

    for k,v in pairs(funcs) do
        if func == k then
            v()
            break
        end
    end
end