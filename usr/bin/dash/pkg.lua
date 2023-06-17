--[[
    PKG - Package Manager
    Downloads list from https://raw.githubusercontent.com/XDuskAshes/dawn/pkgs/pkg-list.txt
]]

require("/kernel")

scrMSG(1,"get pkg list")
local pkgs = http.get("https://raw.githubusercontent.com/XDuskAshes/dawn/pkgs/pkg-list.txt")