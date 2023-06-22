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
--LOGIN IS BROKEN ATM
write("User:")
local userlog = read()
write("Password:")
local userpass = read()
repeat
    local a = handle.readLine()
    local user, pass = string.match(userlog, userpass "([^:]+):([^:]+):")
  until
    user == userlog