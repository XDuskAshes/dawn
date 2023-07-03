shell.run("set shell.allow_disk_startup false")
term.clear()
if fs.exists("/etc/logs/startup") then
    fs.delete("/etc/logs/startup")
end

local per = peripheral.getNames()
local yesSpeaker = false
local s
for i,v in ipairs(per) do
    local t = peripheral.getType(v)
        if t == "speaker" then
            yesSpeaker = true
            s = peripheral.find("speaker")
            s.playNote("bit",3,18)
            s.playNote("bit",3,23)
            s.playNote("bit",3,18)
            sleep(0.3)
            s.playNote("bit",3,19)
            s.playNote("bit",3,24)
            s.playNote("bit",3,19)
        end
end

local handle = fs.open("/etc/logs/startup","w")
handle.writeLine("DAWN CP-BSL Log")

local tSizex, tSizey = term.getSize()
local id = os.getComputerID()
local label = os.getComputerLabel()
local ComLab

if label == nil then
    ComLab = id
else
    ComLab = label
end

term.clear()
term.setCursorPos(1,1)
print("DAWN CP-BSL (Computer Post-Boot State Log)") --Computer Post-Boot State Log
handle.writeLine("Termsize ["..tSizex..","..tSizey.."]")
print("Termsize ["..tSizex..","..tSizey.."]")
handle.writeLine("ID/Label: "..ComLab)
print("ID/Label:",ComLab)
print("Color scale:")
print("==================")
write("|")
local col = 1
local shuffle = 2
repeat
    paintutils.drawPixel(shuffle, 6, col)
    col = col * 2
    shuffle = shuffle + 1
until col == 65536
print("|")
print("==================")
local c = os.clock()
handle.writeLine("Basic info retrieved in: "..c.."s")

if tSizex < 51 then
    handle.writeLine("tSizex smaller than required (51)")
    print("DAWN is made for standard computers.")
    if not periphemu then
        handle.writeLine("CCPC Not detected")
        print("Please run this on a normal computer via file transfer in disk drive.")
        handle.writeLine("Printed disk drive message")
        sleep(1)
        handle.writeLine("Reached shutdown")
        handle.close()
        os.shutdown()
    else
        handle.writeLine("CCPC detected, hanging to resize")
        print("Please resize the screen until you see the letter 'A' below.")
        repeat
            sleep(1)
        until tSizex == 51 and tSizey == 19
        print("A")
        handle.writeLine("resize success.")
    end
end

if periphemu then
    handle.writeLine("Check for CCPC configs")
    if fs.exists("/etc/config/add-debug") then
        handle.writeLine("Found: /etc/config/add-debug")
        shell.run("attach bottom debugger")
        handle.writeLine("attached debugger")
    end
end

if periphemu then
    handle.writeLine("Avoiding bug with keys, suggestion will be passed through with dboot.")
    handle.close()
    print("Avoiding bug with keys, suggestion will be passed through with dboot.")
    local handle2 = fs.open("/etc/ccpcBug","w")
    handle2.write("'dbios' can launch into dbios from login.")
    handle2.close()
    sleep(3)
    shell.run("/boot/dboot.lua")
else
    term.setCursorPos(1,10)
    print("           ENTER for boot, Z for dbios")
    while true do
        local event = {os.pullEvent()}
        local eventD = event[1]
    
        if eventD == "key" then
            local k = event[2]
            if k == 90 then
                shell.run("/bin/cls.lua")
                sleep(0.001)
                handle.writeLine("Booted dbios.")
                handle.close()
                shell.run("/boot/dbios/init.lua")
            elseif k == 257 then
                sleep(0.001)
                local c = os.clock()
                handle.writeLine("Reached boot in: "..c.."s")
                handle.close()
                shell.run("/boot/dboot.lua")
            end
        end
    end
end
