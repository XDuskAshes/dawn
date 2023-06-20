--[[
    Remove users
    By Dusk
]]

local kernel = require "/kernel"

local handle = fs.open("/etc/usr/.login","r")
local login = handle.readLine()
handle.close()

local args = {...}

if args[1] == "--sudo" then
    local handle2 = fs.open("/etc/usr/"..login..".txt","r")
    local eh = handle2.readLine()
    local sudo = handle2.readLine()
    handle2.close()

    if sudo == "false" then
        kernel.scrMSG(4,"sudo not available for this user")
    elseif sudo == "true" then
        if args[2] == "root" then
            kernel.scrMSG(4,"cannot remove root")
        elseif args[2] == login then
            kernel.scrMSG(4,"user is logged in. please try as different user or root.")
        elseif fs.exists("/etc/usr/"..args[2]..".txt") ~= true then
            kernel.scrMSG(4,"user doesn't exist")
        elseif args[2] == nil then
            kernel.scrMSG(4,"please supply a user")
        else
            local handle3 = fs.open("/etc/usr/"..args[2]..".txt","r")
            local skip = handle3.readLine()
            local alsoskip = handle3.readLine()
            local home = handle3.readLine()
            handle3.close()

            if home == "true" then
                fs.delete("/home/"..args[2])
                kernel.scrMSG(1,"removed home folder for "..args[2])
            end

            fs.delete("/etc/usr/"..args[2]..".txt")
            kernel.scrMSG(1,"user "..args[2].." deleted")
                
        end
    end
else
    kernel.scrMSG(4,"must be run with sudo")
end