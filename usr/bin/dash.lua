--[[
    DASH Terminal
    Custom for dawn kernel
    By Dusk
]]

local kernel = require("/kernel")

local wd

local label = os.getComputerLabel() or os.getComputerID()

while true do
    write("dash@("..label..")-$")
    local input = read()
    shell.run("/usr/bin/dash/"..input)
end