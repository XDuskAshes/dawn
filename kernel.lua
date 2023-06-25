--[[
    Dawn Kernel
    By Dusk
    1.0.0-idev1
]]

local handle

local n

local function isempty(s) --i robbed this from https://stackoverflow.com/questions/19664666/check-if-a-string-isnt-nil-or-empty-in-lua
    return s == nil or s == ''
end

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

function k.initLog(name)
    if fs.exists("/etc/logs/"..name) ~= true then
        fs.copy("/etc/file","/etc/logs/"..name)
    elseif fs.exists("/etc/logs/"..name) then
        k.scrMSG(4,"Already exists.")
    elseif isempty(name) then
        k.scrMSG(4,"No type selected.")
    end

    handle = fs.open("/etc/logs/"..name,"w")
    sleep(0.1)
end

function k.log(msg,type) --type: (1)ok, (2)info, (3)issue
    local name = fs.getName(shell.getRunningProgram())
    if type == 1 then --OK
        handle.writeLine("("..name.."):[ok]"..msg.."\n")
    elseif type == 2 then --INFO
        handle.writeLine("("..name.."):[info]"..msg.."\n")
    elseif type == 3 then --ISSUE
        handle.writeLine("("..name.."):[issue]"..msg.."\n")
    end
end

function k.logClose()
    handle.writeLine("(k.logClose()):[close]close log")
    handle.close()
    fs.move("/etc/logs/"..n,"/etc/backups/")
end

return k