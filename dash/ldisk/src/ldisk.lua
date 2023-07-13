--[[
    DASH ldisk
    per disk -l -v, with more, plus file saving
    by Dusk
]]

local args = {...}

local mnt
local label
local med
local spCap
local spFre
local spUse
local per = peripheral.getNames()

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
    print("--------------------")
    print("Info of",args[1]..":")
    print("Mounted as:",mnt)
    print("Label/ID:",label)
    print("Has audio?:",med)
    print("Total space:",spCap)
    print("Space left:",spFre)
    print("Space used:",spUse)
end
