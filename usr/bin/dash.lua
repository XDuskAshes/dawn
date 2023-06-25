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
user = handle.readLine()
handle.close()

local function isempty(s) --i robbed this from https://stackoverflow.com/questions/19664666/check-if-a-string-isnt-nil-or-empty-in-lua
    return s == nil or s == ''
end

while true do
    write(user.."@dash".."-$")
    local input = read()
    if isempty(input) then
        write("")
    elseif input == "reboot" then
        shell.run("/sbin/r.lua")
        error()
    else
        shell.run("/bin/"..input)
    end
end