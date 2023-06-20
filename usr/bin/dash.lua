--[[
    DASH Terminal
    Custom for dawn kernel
    By Dusk
]]

local user = ""

local kernel = require("/kernel")

local label = os.getComputerID() or os.getComputerLabel()

if fs.exists("/etc/usr/.login") ~= true then
    shell.run("/usr/bin/dash-login.lua")
end

local handle = fs.open("/etc/usr/.login","r")
user = handle.readLine(1)
handle.close()

while true do
    write(user.."@dash".."-$")
    local input = read()
    if input == "logout" then
        os.reboot()
    else
        shell.run("/usr/bin/dash/"..input)
    end
end