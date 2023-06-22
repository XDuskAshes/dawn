--[[
    dash label program
    by Dusk
]]

local args = {...}
if args[1] == "-s" then
    os.setComputerLabel(args[2])
end

if args[1] == "-c" then
    os.setComputerLabel(nil)
end

if args[1] == "-d" then
    local a = os.getComputerLabel()
    print(a)
end