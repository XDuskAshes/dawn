--[[
    Dawn Kernel
    By Dusk
    1.0.0-idev1
]]

local kernel = {}

function kernel.SYSCALL(a)

end

function kernel.scrMSG(type,msg) --type: 1,2,3,4,5 (see docs); msg: message
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
        write("[ ")
        term.setTextColor(colors.brown)
        write("INFO")
        term.setTextColor(colors.white)
        write(" ] "..msg.."\n")
    elseif type == 4 then
        printError("[ ERROR ]",msg)
    elseif type == 5 then
        printError("[ ERROR ]",msg)
        error()
    end
end

function kernel.sudoCheck(user) --Check the sudo status of a user
    
end

return kernel