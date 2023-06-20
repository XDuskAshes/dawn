--[[
    Add users
    By Dusk
]]

local newPass = ""
local newSudo = ""
local newHome = ""

local kernel = require "/kernel"

local args = {...}

if args[1] == "--sudo" then
    local handle1 = fs.open("/etc/usr/.login","r")
    local user = handle1.readLine()
    handle1.close()

    local handle2 = fs.open("/etc/usr/"..user..".txt","r")
    local eh = handle2.readLine()
    local sudo = handle2.readLine()
    handle2.close()

    if sudo == "false" then
        kernel.scrMSG(4,"Sudo is not active for"..user)
    end

    if args[2] == "-y" then
        newSudo = "true"
    elseif args[2] == "-n" then
        newSudo = "false"
    elseif args[2] == nil then
        kernel.scrMSG(4,"no option for sudo selected")
    else
         kernel.scrMSG(4,args[2].." is not acceptable sudo opt")
    end

    if args[3] == "yHome" then
        newHome = "true"
    elseif args[3] == "nHome" then
        newHome = "nil"
    elseif args[3] == nil then
        kernel.scrMSG(4,"no opt chosen for home (yHome/nHome)")
    else
        kernel.scrMSG(4,args[3].." is not acceptable opt for home (yHome/nHome)")
    end

    if args[4] == nil then
        kernel.scrMSG(4,"no name chosen")
    end

    if args[5] == nil then
        kernel.scrMSG(4,"no password set")
    else
        newPass = args[5]
    end

    if fs.exists("/etc/usr/"..args[4]..".txt") then
        kernel.scrMSG(4,"user exists")
    else

    fs.copy("/etc/file","/etc/usr/"..args[4]..".txt")
    if fs.exists("/etc/usr/"..args[4]..".txt") then
        kernel.scrMSG(1,"/etc/usr/"..args[4]..".txt created")
    else
        kernel.scrMSG(4,"/etc/usr/"..args[4]..".txt not created")
    end
    local handle = fs.open("/etc/usr/"..args[4]..".txt","w")
    handle.writeLine(newPass)
    kernel.scrMSG(1,"password ("..newPass..") written")
    handle.writeLine(newSudo)
    kernel.scrMSG(1,"sudo value ("..newSudo..") written")
    handle.writeLine(newHome)
    kernel.scrMSG(1,"home value ("..newHome..") written")
    handle.close()
    end
else
    kernel.scrMSG(4,"Command must be run with sudo")
end

    if newHome == "true" then
        fs.makeDir("/home/"..args[4])
            if fs.exists("/home/"..args[4]) then
                kernel.scrMSG(1,"/home/"..args[4].."/ created")
            else
               kernel.scrMSG(4,"/home/"..args[4].."/ not created")
            end 
    end