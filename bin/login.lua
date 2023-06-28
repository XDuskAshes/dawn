--[[
    Login for DASH
    By Dusk
]]

local kernel = require "/kernel"

kernel.scrMSG(1,"Reached: login")

local function isempty(s) --i robbed this from https://stackoverflow.com/questions/19664666/check-if-a-string-isnt-nil-or-empty-in-lua
    return s == nil or s == ''
end

if fs.exists("/etc/usr/.login") then
    fs.delete("/etc/usr/.login")
    fs.copy("/etc/.file","/etc/usr/.login")
else
    fs.copy("/etc/.file","/etc/usr/.login")
end

local handle = fs.open("/etc/passwd","r")
write("User:")
local userlog = read()
if isempty(userlog) then
    os.reboot()
end

if userlog == "dbios" then
    shell.run("/boot/dbios/init.lua")
    error()
end

write("Password:")
local userpass = read()
if isempty(userpass) then
    os.reboot()
end
local cshell
local user
local pass
local id
local home

repeat
    local a = handle.readLine()
    if a == nil then
        os.reboot()
    end
    user, pass, id, home, cshell = string.match(a, "([^:]+):([^:]+):([^:]+):([^:]+):([^:]+)")
    if user == nil then
        kernel.scrMSG(4,"No user found.")
        sleep(1)
        os.reboot()
    end
    if pass == nil then
        kernel.scrMSG(4,"No user found.")
        sleep(1)
        os.reboot()
    end
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