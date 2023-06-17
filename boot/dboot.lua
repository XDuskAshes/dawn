--dawn default boot program
--by dusk

require("/kernel")

term.clear()
term.setCursorPos(1,1)

local basefs = {
    "/bin/",
    "/boot/",
    "/dev/",
    "/etc/",
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

local core = {
    "/kernel.lua",
    "/boot/.bootfile",
    "/boot/dboot.lua",
    "/usr/bin/dash.lua",
    "/sbin/core/",
    "/sbin/sys/",
    "/sbin/core/fhs.lua",
    "/sbin/sys/criterr.lua"
    --"/sys/boot.lua"
    --Uncomment the above line (and this) if you make an OS based on this
}

for _,v in pairs(basefs) do
    if fs.exists(v) ~= true then
        scrMSG(4,v.." does not exist.")
    end
end

for _,v in pairs(core) do
    if fs.exists(v) ~= true then
        scrMSG(4,v.." does not exist.")
    end
end

scrMSG(1,"basefs and core are present")

local function setboot()
    write("Boot file path:")
    local bootfileNew = read()
    fs.delete("/boot/.bootfile")
    scrMSG(1,"deleted .bootfile")
    fs.copy("/etc/.file", "/tmp/.bootfile")
    scrMSG(1,"copied /etc/.file to /tmp/ as .bootfile")
    local tmpb = fs.open("/tmp/.bootfile","w")
    tmpb.write(bootfileNew)
    tmpb.close()
    scrMSG(1,"opened and written "..bootfileNew.." to /tmp/.bootfile")
    fs.move("/tmp/.bootfile", "/boot/.bootfile")
    scrMSG(1,"file moved successfully.")
end

local function setbail()
    write("bail file path:")
    local bailfileNew = read()
    fs.delete("/boot/.bailto")
    scrMSG(1,"deleted .bailto")
    fs.copy("/etc/.file", "/tmp/.bailto")
    scrMSG(1,"copied /etc/.file to /tmp/ as .bailto")
    local tmpb = fs.open("/tmp/.bailto","w")
    tmpb.write(bailfileNew)
    tmpb.close()
    scrMSG(1,"opened and written "..bailfileNew.." to /tmp/.bailto")
    fs.move("/tmp/.bailto", "/boot/.bailto")
    scrMSG(1,"file moved successfully.")
end

local limitshell = {
    [ "setboot" ] = setboot,
    [ "setbail" ] = setbail,
    [ "reboot" ] = os.reboot
}

local function run(a)
    if a == "help" then
        for k,v in pairs(limitshell) do
            print(k)
        end
    end
    for k,v in pairs(limitshell) do
        if a == k then
            v()
            break
        end
    end
end

local b = fs.open("/boot/.bootfile","r")
local bootfile = b.readLine(1)
b.close()

local c = fs.open("/boot/.bailto","r")
local bailto = c.readLine(1)
c.close()

if fs.isDir(bootfile) then
    scrMSG(2,"bootfile is dir")
    while true do
        write(">>")
        local a = read()
        run(a)
    end
end

scrMSG(1,"bootfile ~= dir")

if fs.isDir(bailto) then
    scrMSG(2,"bailfile is dir")
    while true do
        write(">>")
        local a = read()
        run(a)
    end
end

scrMSG(1,"bailfile ~= dir")

if fs.exists(bootfile) then
    scrMSG(1,"Boot file exists.")
    scrMSG(1,"boot...")
    shell.run(bootfile)
elseif fs.exists(bootfile) ~= true then
    scrMSG(2,"File defined in '/boot/.bootfile' doesn't exist.")
    print("Attempt:",bailto)
        if fs.exists(bailto) then
            shell.run(bailto)
        else
            scrMSG(2,"bootfile "..bootfile.." and bail file "..bailto.." do not exist.")
            while true do
                write(">>")
                local a = read()
                run(a)
            end
        end
end
