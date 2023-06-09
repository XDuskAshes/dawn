--[[
    DASH Terminal
    Custom for dawn kernel
    By Dusk
]]

local wd = "/"
local root = fs.list("/")
local ver = fs.open("/var/.dawninf")
local version = ver.readLine(1)
ver.close()
local target

local function targetdir()
    write("target is:")
    local t = read()
    target == t
end

local cmd = {
    [ "targetdir" ] = targetdir
}

