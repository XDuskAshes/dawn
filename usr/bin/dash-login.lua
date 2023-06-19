--[[
    Login for DASH
    By Dusk
]]

local kernel = require "/kernel"

kernel.scrMSG(1,"Reached: dash-login")

if fs.exists("/etc/usr/.login") then
    fs.delete("/etc/usr/.login")
    fs.copy("/etc/.file","/etc/usr/.login")
else
    fs.copy("/etc/.file","/etc/usr/.login")
end

write("User:")
local seluser = read()
write("Password:")
local key = read()
if fs.exists("/etc/usr/"..seluser..".txt") then
    local handle = fs.open("/etc/usr/"..seluser..".txt","r")
    local passwd = handle.readLine(1)
    local sudo = handle.readLine(2)
    local home = handle.readLine(3)
    handle.close()
        if key == passwd then
            local handle = fs.open("/etc/usr/.login","w")
            handle.write(seluser,1)
            handle.close()
            shell.run("/usr/bin/dash.lua")
            error()
        else
            kernel.scrMSG(3,"Invalid password.")
            sleep(1)
            os.reboot()
        end
else
    kernel.scrMSG(3,"Invalid user.")
    sleep(1)
    os.reboot()
end