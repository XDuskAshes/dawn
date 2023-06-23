--[[
    dbios set
    by Dusk
]]

local k = require "/kernel"

local args = {...}

if args[1] == "-bail" then
    write("bail file path:")
    local bailfileNew = read()
    fs.delete("/boot/.bailto")
    k.scrMSG(1,"deleted .bailto")
    fs.copy("/etc/.file", "/tmp/.bailto")
    k.scrMSG(1,"copied /etc/.file to /tmp/ as .bailto")
    local tmpb = fs.open("/tmp/.bailto","w")
    tmpb.write(bailfileNew)
    tmpb.close()
    k.scrMSG(1,"opened and written "..bailfileNew.." to /tmp/.bailto")
    fs.move("/tmp/.bailto", "/boot/.bailto")
    k.scrMSG(1,"file moved successfully.")
elseif args[1] == "-boot" then
    write("Boot file path:")
    local bootfileNew = read()
    fs.delete("/boot/.bootfile")
    k.scrMSG(1,"deleted .bootfile")
    fs.copy("/etc/.file", "/tmp/.bootfile")
    k.scrMSG(1,"copied /etc/.file to /tmp/ as .bootfile")
    local tmpb = fs.open("/tmp/.bootfile","w")
    tmpb.write(bootfileNew)
    tmpb.close()
    k.scrMSG(1,"opened and written "..bootfileNew.." to /tmp/.bootfile")
    fs.move("/tmp/.bootfile", "/boot/.bootfile")
    k.scrMSG(1,"file moved successfully.")
end