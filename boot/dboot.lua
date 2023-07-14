--dawn default boot program
--by dusk

local kernel = require "/kernel"

term.clear()
term.setCursorPos(1,1)

if fs.exists("/etc/config/simpleboot") then --The very simple looking one
    term.setCursorPos(17,10)
    print("dboot is running...")
    term.setCursorPos(18,11)
    textutils.slowWrite("[ ---------- ]")
    term.setCursorPos(20,11)
    local tSizex, tSizey = term.getSize()
    write("=")
    local basefs = {
        "/bin/",
        "/boot/",
        "/dev/",
        "/etc/",
        "/etc/usr/",
        "/etc/dash/",
        "/etc/dash/help/",
        "/etc/logs/",
        "/etc/config/",
        "/lib/",
        "/mnt/",
        "/sbin/",
        "/tmp/",
        "/var/",
        "/sys/",
        "/usr/",
        "/home/",
        "/usr/bin/",
        "/usr/lib/",
        "/usr/local/",
        "/usr/sbin/",
        "/usr/share/"
    }
    textutils.slowWrite("=")

    local core = {
        "/kernel.lua",
        "/boot/.bootfile",
        "/boot/dboot.lua",
        "/usr/bin/dash.lua",
        "/etc/.file",
        "/etc/file",
        --"/sys/boot.lua"
        --Uncomment the above line if you make an OS based on this
    }
    textutils.slowWrite("=")

    for _,v in pairs(basefs) do
        if fs.exists(v) ~= true then
            kernel.scrMSG(4,v.." does not exist.")
        end
    end
    textutils.slowWrite("=")
    for _,v in pairs(core) do
        if fs.exists(v) ~= true then
            kernel.scrMSG(4,v.." does not exist.")
        end
    end
    textutils.slowWrite("=")

    local b = fs.open("/boot/.bootfile","r")
    local bootfile = b.readLine()
    b.close()
    textutils.slowWrite("=")
    local c = fs.open("/boot/.bailto","r")
    local bailto = c.readLine()
    c.close()
    textutils.slowWrite("=")
    if fs.isDir(bootfile) then
        kernel.scrMSG(2,"bootfile is dir")
        sleep(1)
        term.clear()
        term.setCursorPos(1,1)
        shell.run("/boot/dbios/init.lua")
        error()
    end

    if fs.isDir(bailto) then
        kernel.scrMSG(2,"bailfile is dir")
        sleep(1)
        term.clear()
        term.setCursorPos(1,1)
        shell.run("/boot/dbios/init.lua")
        error()
    end

    if fs.exists(bootfile) then
        textutils.slowWrite("===")
        print("")
        sleep(1)
        shell.run(bootfile)
    else
        term.setTextColor(colors.yellow)
        textutils.slowWrite("+")
            if fs.exists(bailto) then
                term.setTextColor(colors.orange)
                textutils.slowWrite("==")
                sleep(1)
                term.setTextColor(colors.white)
                print("")
                shell.run(bailto)
            else
                term.setTextColor(colors.red)
                textutils.slowWrite("@")
                if fs.exists("/boot/dbios/init.lua") then
                    textutils.slowWrite("$$")
                    sleep(1)
                    term.setTextColor(colors.white)
                    print("")
                    shell.run("/boot/dbios/init.lua")
                end
            end
    end
else --the logging one

    local tSizex, tSizey = term.getSize()

    if not periphemu then
        kernel.scrMSG(3,"Did not detect 'periphemu'. Assuming env is in-game.")
    else
        kernel.scrMSG(3,"Detected 'periphemu'. Assuming env is CCPC.")
    end

    kernel.scrMSG(3,"Term size: ["..tSizex..":"..tSizey.."]")

    local basefs = {
        "/bin/",
        "/boot/",
        "/dev/",
        "/etc/",
        "/etc/usr/",
        "/etc/dash/",
        "/etc/dash/help/",
        "/etc/logs/",
        "/etc/config/",
        "/lib/",
        "/mnt/",
        "/sbin/",
        "/tmp/",
        "/var/",
        "/sys/",
        "/usr/",
        "/home/",
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
        "/usr/bin/dash.lua",
        "/etc/.file",
        "/etc/file",
        --"/sys/boot.lua"
        --Uncomment the above line if you make an OS based on this
    }
    
    kernel.scrMSG(1,"init basefs & core table")
    
    for _,v in pairs(basefs) do
        if fs.exists(v) ~= true then
            fs.makeDir(v)
            kernel.scrMSG(4,v.." does not exist.")
        end
    end

    
    for _,v in pairs(core) do
        if fs.exists(v) ~= true then
            kernel.scrMSG(4,v.." does not exist.")
        end
    end
    
    kernel.scrMSG(1,"complete basefs & core check")
    
    local b = fs.open("/boot/.bootfile","r")
    local bootfile = b.readLine()
    b.close()
    
    local c = fs.open("/boot/.bailto","r")
    local bailto = c.readLine()
    c.close()
    
    if fs.isDir(bootfile) then
        kernel.scrMSG(2,"bootfile is dir")
        shell.run("/boot/dbios/init.lua")
        error()
    end
    
    kernel.scrMSG(1,"bootfile ~= dir")
    
    if fs.isDir(bailto) then
        kernel.scrMSG(2,"bailfile is dir")
        shell.run("/boot/dbios/init.lua")
        error()
    end
    
    kernel.scrMSG(1,"bailfile ~= dir")
    
    if fs.exists(bootfile) then
        kernel.scrMSG(1,"Boot file exists.")
        kernel.scrMSG(1,"boot...")
        shell.run(bootfile)
    elseif fs.exists(bootfile) ~= true then
        kernel.scrMSG(3,"File defined in '/boot/.bootfile' doesn't exist.")
        print("Attempt:",bailto)
            if fs.exists(bailto) then
                shell.run(bailto)
            else
                kernel.scrMSG(4,"bootfile "..bootfile.." and bail file "..bailto.." do not exist.")
                shell.run("/boot/dbios/init.lua")
            end
    end
end