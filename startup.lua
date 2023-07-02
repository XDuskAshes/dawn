shell.run("set shell.allow_disk_startup false")

if fs.exists("/etc/logs/startup") then
    fs.delete("/etc/logs/startup")
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
print("DAWN CP-BSL") --Computer Post-Boot State Log
handle.writeLine("Termsize ["..tSizex..","..tSizey.."]")
print("Termsize ["..tSizex..","..tSizey.."]")
handle.writeLine("ID/Label: "..ComLab)
print("ID/Label:",ComLab)
if term.isColor then
    handle.writeLine("Color: Yes")
    print("Color: Yes")
else
    handle.writeLine("Color: No")
    print("Color: No")
end

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

local c = os.clock()
handle.writeLine("Reached boot in: "..c.."s")

handle.close()

sleep(1)

shell.run("/boot/dboot.lua")