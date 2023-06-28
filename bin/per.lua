--[[
    Peripheral messery
    by Dusk
]]

local k = require "/kernel"

local args = {...}

local per = peripheral.getNames()

if k.empty(args[1]) then
    print("Usage: read the docs")
elseif args[1] == "disk" then
    if k.empty(args[2]) then
        print("Read docs for usage of",args[1])
    elseif args[2] == "-l" then
        local drive = peripheral.find("drive") or error("no drives")
        print("| SIDE | MOUNT |")
        for i,v in ipairs(per) do
            local t = peripheral.getType(v)
            if t == "drive" then
                if k.empty(args[3]) then
                    local present = disk.isPresent(v)
                        if present then
                            local mnt = disk.getMountPath(v)
                            write("["..v.."]|"..mnt.."|\n")
                        else
                            write("["..v.."]|nil|\n")
                        end
                    elseif args[3] == "-v" then
                    local present = disk.isPresent(v)
                        if present then
                            local mnt = disk.getMountPath(v)
                            local cap = fs.getCapacity(mnt)
                            local free = fs.getFreeSpace(mnt)
                            write("+["..v.."]|"..mnt.."|\n")
                            write("|Capacity: "..cap.."|Space Free: "..free.."|\n")
                        else
                            write("["..v.."]|nil|\n")
                        end
                end
            end
        end
    elseif args[2] == "-e" then
        if k.empty(args[2]) then
            print("Usage: disk -e <side>")
        else
            for _,v in ipairs(per) do
                local present = disk.isPresent(v)
                if present then
                    disk.eject(args[3])
                end
            end
        end
    else
        print("Supplied argument '"..args[2].."' is not applicable.")
    end
elseif args[1] == "modem" then
    if k.empty(args[2]) then
        print("Read docs for usage of",args[1])
    end
end