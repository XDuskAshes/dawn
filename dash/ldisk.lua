--[[
    DASH ldisk
    per disk -l -v, with more, plus file saving
    by Dusk
]]

local args = {...}

local sFile = "ldisk-log"
local mnt
local label
local med
local spCap
local spFre
local spUse
local per = peripheral.getNames()

if fs.exists("/etc/logs/"..sFile) then
    local n = 0
    repeat
        local nn = n + 1
        sFile = "ldisk-log-"..nn
    until fs.exists("/etc/logs/"..sFile) ~= true
        fs.copy("/etc/file","/etc/logs/"..sFile)
end

if args[1] == nil or args[1] == "" then
    print("Usage: ldisk <drive>")
else
    for k,v in pairs(per) do
        local pres = disk.isPresent(args[1])
            if pres then
                local dat = disk.hasData(args[1])
                if dat ~= true then
                    mnt = "None"
                else
                    mnt = disk.getMountPath(args[1])
                end
                label = disk.getLabel(args[1])
                    if label == nil then
                       label = disk.getID(args[1])
                    end
            end
    end
    local music = disk.hasAudio(args[1])
        if music then
            med = "Disk has audio."
            spCap = "nil"
            spFre = "nil"
            spUse = "nil"
        else
            med = "Disk does not have audio."
            spCap = fs.getCapacity(mnt)
            spFre = fs.getFreeSpace(mnt)
            spUse = spCap - spFre
        end
    local handle = fs.open("/etc/logs/"..sFile,"w")
    print("--------------------")
    handle.writeLine("Info of "..args[1]..":")
    print("Info of",args[1]..":")
    handle.writeLine("Mounted as: "..mnt)
    print("Mounted as:",mnt)
    handle.writeLine("Label/ID: "..label)
    print("Label/ID:",label)
    handle.writeLine("Has audio?: "..med)
    print("Has audio?:",med)
    handle.writeLine("Total space: "..spCap)
    print("Total space:",spCap)
    handle.writeLine("Space left: "..spFre)
    print("Space left:",spFre)
    handle.writeLine("Space used: "..spUse)
    print("Space used:",spUse)
    handle.close()
end
