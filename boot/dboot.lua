--dawn default boot program
--by dusk

local function setboot()
    write("Boot file path:")
    local bootfileNew = read()
    print("remove bootfile")
    fs.delete("/boot/.bootfile")
    print("copy from /etc/backup/")
    fs.copy("/etc/backup/.bootfile", "/tmp/.bootfile")
    print("open and write",bootfileNew,"to /tmp/.bootfile")
    local tmpb = fs.open("/tmp/.bootfile","w")
    tmpb.write(bootfileNew)
    tmpb.close()
    print("move to /boot/")
    fs.move("/tmp/.bootfile", "/boot/.bootfile")
end

local function setbail()
    write("bail file path:")
    local bailfileNew = read()
    print("remove bailto")
    fs.delete("/boot/.bailto")
    print("copy from /etc/backup/")
    fs.copy("/etc/backup/.bailto", "/tmp/.bailto")
    print("open and write",bailfileNew,"to /tmp/.bailto")
    local tmpb = fs.open("/tmp/.bailto","w")
    tmpb.write(bailfileNew)
    tmpb.close()
    print("move to /boot/")
    fs.move("/tmp/.bailto" "/boot/.bailto")
end

local limitshell = {
    [ "setboot" ] = setboot,
    [ "setbail" ] = setbail,
    [ "reboot" ] = os.reboot
}

local function run(a)
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

if fs.exists(bootfile) then
    print("Boot file exists.")
    print("boot...")
    shell.run(bootfile)
else
    printError("File defined in '/boot/.bootfile' doesn't exist.")
    print("Attempt:",bailto)
        if fs.exists(bailto) then
            shell.run(bailto)
        else
            printError("bootfile",bootfile,"and bail file",bailto,"do not exist.")
            while true do
                write(">>")
                local a = read()
                run(a)
            end
        end
end
