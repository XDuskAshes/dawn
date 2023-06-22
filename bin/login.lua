--[[
    Login for DASH
    By Dusk
]]

local kernel = require "/kernel"

kernel.scrMSG(1,"Reached: login")

if fs.exists("/etc/usr/.login") then
    fs.delete("/etc/usr/.login")
    fs.copy("/etc/.file","/etc/usr/.login")
else
    fs.copy("/etc/.file","/etc/usr/.login")
end

local handle = fs.open("/etc/passwd","r")
write("User:")
local userlog = read()
write("Password:")
local userpass = read()
local cshell
local user
local pass
local id
local home

repeat
    local a = handle.readLine()
    user, pass, id, home, cshell = string.match(a, "([^:]+):([^:]+):([^:]+):([^:]+):([^:]+)")
  until
    user == userlog and pass == userpass
    handle.close()
    local handle2 = fs.open("/etc/usr/.login","w")
    handle2.writeLine(user)
    handle2.close()
    if fs.exists(cshell) then
        shell.run(cshell)
    else
        kernel.scrMSG(2,cshell.." does not exist. Use /usr/bin/dash")
        shell.run("/usr/bin/dash.lua")
    end