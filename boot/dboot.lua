--dawn default boot program
--by dusk

local kernel = require "/kernel"

term.clear()
term.setCursorPos(1,1)

local basefs = {
    "/bin/",
    "/boot/",
    "/dev/",
    "/etc/",
    "/etc/usr/",
    "/etc/dash/",
    "/etc/dash/help/",
    "/lib/",
    "/mnt/",
    "/sbin/",
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

kernel.scrMSG(1,"init basefs table")

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

kernel.scrMSG(1,"init core table")

for _,v in pairs(basefs) do
    if fs.exists(v) ~= true then
        kernel.scrMSG(4,v.." does not exist.")
    end
end

kernel.scrMSG(1,"complete basefs check")

for _,v in pairs(core) do
    if fs.exists(v) ~= true then
        kernel.scrMSG(4,v.." does not exist.")
    end
end

kernel.scrMSG(1,"complete core check")

local b = fs.open("/boot/.bootfile","r")
local bootfile = b.readLine(1)
b.close()

local c = fs.open("/boot/.bailto","r")
local bailto = c.readLine(1)
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
