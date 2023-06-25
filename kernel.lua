--[[
    Dawn Kernel
    By Dusk
    1.0.0-idev1
]]

local k = {}



function k.scrMSG(type,msg) --type: 1,2,3,4,5 (see docs); msg: message
    local name = fs.getName(shell.getRunningProgram())
    if type == 1 then
        write("("..name.."):[")
        term.setTextColor(colors.green)
        write("OK")
        term.setTextColor(colors.white)
        write("]:"..msg.."\n")
    elseif type == 2 then
        write("("..name.."):[")
        term.setTextColor(colors.yellow)
        write("WARN")
        term.setTextColor(colors.white)
        write("]:"..msg.."\n")
    elseif type == 3 then
        write("("..name.."):[")
        term.setTextColor(colors.brown)
        write("INFO")
        term.setTextColor(colors.white)
        write("]:"..msg.."\n")
    elseif type == 4 then
        printError("("..name.."):[ ERROR ]:"..msg)
    elseif type == 5 then
        printError("("..name.."):[ ERROR ]:"..msg)
        error()
    end
end

return k