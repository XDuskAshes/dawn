--[[
    Dawn Kernel
    By Dusk
    1.0.0-idev1
]]

--require("/sbin/dawn/core/fhs") --throws an error: 'loop or previous error loading module "/sbin/dawn/core/fhs"'

function _SYSCALL()
    local i = fs.open("/stat/.dawninf","r")
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

function scrMSG(type,msg) --type: 1,2,3,4 (see docs); msg: message
    if type == 1 then
        write("[ ")
        term.setTextColor(colors.green)
        write("OK")
        term.setTextColor(colors.white)
        write(" ] "..msg.."\n")
    elseif type == 2 then
        write("[ ")
        term.setTextColor(colors.yellow)
        write("WARN")
        term.setTextColor(colors.white)
        write(" ] "..msg.."\n")
    elseif type == 3 then
        printError("[ ERROR ]",msg)
    elseif type == 4 then
        printError("[ ERROR ]",msg)
        error()
    end
end