--[[
    dbios init
    by Dusk
]]

local k = require "/kernel"

k.scrMSG(3,"dbios init called, please wait")

if fs.exists("/boot/dbios/core/") then
    k.scrMSG(3,"check core files")
else
    k.scrMSG(4,"error: core dir does not exist [PANIC,HANG]")
    shell.run("fg shell")
    repeat
        sleep(0.001)
    until fs.exists("/boot/dbios/core/")
end

local coreLS = {
    "set",
    "config",
    "reboot",
}

for _,v in pairs(coreLS) do
    if fs.exists("/boot/dbios/core/"..v..".lua") then
        k.scrMSG(1,v.." exists")
    else
        k.scrMSG(4,"error: core file "..v.." does not exist [PANIC,HANG]")
        shell.run("fg shell")
        repeat
        sleep(0.001)
        until fs.exists("/boot/dbios/core/"..v..".lua")
    end
end

shell.run("/boot/dbios/dbios.lua")