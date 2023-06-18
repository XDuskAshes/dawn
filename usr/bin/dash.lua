--[[
    DASH Terminal
    Custom for dawn kernel
    By Dusk
]]

local user = ""

local kernel = require("/kernel")

local label = os.getComputerID() or os.getComputerLabel()

write("User:")
local seluser = read()
if fs.exists("/etc/usr/"..seluser..".txt") then
    local handle = fs.open("/etc/usr/"..seluser..".txt","r")
    local passwd = handle.readLine(1)
    local sudo = handle.readLine(2)
    local home = handle.readLine(3)
    handle.close()
    write("Password:")
    local pass = read() 
        if passwd == passwd then
            user = seluser
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

while true do
    write(user.."@dash".."-$")
    local input = read()
    if input == "ext" then
        os.reboot()
    else
        shell.run("/usr/bin/dash/"..input)
    end
end