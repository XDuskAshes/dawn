--[[
    DASH Terminal
    Custom for dawn kernel
    By Dusk
]]

local wd = "/"
local root = fs.list("/")

while true do
    write("dash@"..wd.."-$")
    local input = read()
    shell.run("/usr/bin/dash/"..input)
end