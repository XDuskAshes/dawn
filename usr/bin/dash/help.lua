--[[
    Help program
    Pull from /etc/dash/help/
    By Dusk
]]

local args = {...}
if #args < 1 then
    print("Usage: help (<topic>, -i)")
    return
end

if args[1] == "-i" then
    local i = fs.list("/etc/dash/help/")
    for k,v in pairs(i) do
        print(v)
    end
else
    local handle = fs.open("/etc/dash/help/"..args[1],"r")
    local content = handle.readAll()
    handle.close()
    print(content)
end