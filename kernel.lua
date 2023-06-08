--[[
    Dawn Kernel
    By Dusk
    1.0.0-idev1
]]

function _SYSCALL()
    local i = fs.open("/var/.dawninf","r")
    local inf1 = i.readLine(1)
    local inf2 = i.readLine(2)
    local inf3 = i.readLine(3)
    local inf4 = i.readLine(4)
    i.close()
    print(inf1)
    print(inf2)
    print(inf3)
    print(inf4)
end

_SYSCALL()