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

function k.empty(s) --see line 11
    return s == nil or s == ""
end

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