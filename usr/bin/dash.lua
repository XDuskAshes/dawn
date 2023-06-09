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
