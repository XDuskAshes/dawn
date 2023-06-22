--[[
    For creation and management of disks (using periphemu)
    By Dusk

    Definitions:
    Sector = dir in disk root (/disk/)
]]

local kernel = require("/kernel")

local args = {...}
if #args < 1 then
    print("Usage: disk (-c, -r)")
    return
end

if args[1] == "-c" then
    if #args < 2 then
        printError("Need side")
        return
    else
        periphemu.create(args[2],"drive",1)
        kernel.scrMSG(1,"Created drive on "..args[2])
    end
end
if args[1] == "-r" then
    if #args < 2 then
        printError("Need side")
        return
    else
        if peripheral.isPresent(args[2]) == true then
            periphemu.remove(args[2])
            kernel.scrMSG(1,"removed drive on "..args[2])
        else
            kernel.scrMSG(3,"peripheral simply doesn't exist.")
            return
        end
    end
end