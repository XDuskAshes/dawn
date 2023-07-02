--[[
    dash label program
    by Dusk
]]

local args = {...}

if args[1] == nil or args[1] == "" then
    print("Usage: label (-s <label>/-c/-d)")
end

if args[1] == "-s" then
    if args[2] == nil or args[2] == "" then
        print("Need label")
    else
        os.setComputerLabel(args[2])
    end
end

if args[1] == "-c" then
    os.setComputerLabel(nil)
end

if args[1] == "-d" then
    local a = os.getComputerLabel()
    print(a)
end