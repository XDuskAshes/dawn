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

local handle2 = fs.open("/stat/.dawninf","r")
local kernelVer = handle2.readLine()
handle2.close()

local function isempty(s) --i robbed this from https://stackoverflow.com/questions/19664666/check-if-a-string-isnt-nil-or-empty-in-lua
    return s == nil or s == ''
end

local function t()
    local termSize, termS = term.getSize()
    local tCurs,yCurs = term.getCursorPos()
    if yCurs == 1 then
        yCurs = yCurs + 2
    end
    term.clearLine(1,1)
    term.setCursorPos(1,1)
    write("DASH 1.0 | ["..termSize..":"..termS.."] | ")
    write(string.rep(" ",termSize))
    write(string.rep("=", termSize))
    term.setCursorPos(tCurs,yCurs)
end

t()

while true do
    if fs.exists("/etc/config/colorterm") then
        shell.run("/etc/config/colorterm","r")
    end
    write(user.."-$")
    term.setTextColor(colors.white)
    local input = read()
    if isempty(input) then
        write("")
    elseif input == "reboot" then
        shell.run("/sbin/r.lua")
    else
        shell.run("/bin/"..input)
    end
    t()
end