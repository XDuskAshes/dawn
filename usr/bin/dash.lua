--[[
    DASH Terminal
    Custom for dawn kernel
    By Dusk
]]

local wd = "/"

local function cd() --this isn't working as intended, im gonna comment what it should do and ask for help later
    write("cd from "..wd.." to:") --the prompt
    local i = read() --i should be a string
    if fs.isDir(i) then --if it is a directory
        if fs.exists(wd..i) then --'wd..i' should just concatenate the string together (by default it's '/')
            wd = wd..i --add i to wd
        elseif fs.exists(wd..i) ~= true then --if it isn't true
            wd = i --change wd to i exactly
        end
    end
end

local function ls()
    shell.run("ls",wd)
end

local z = {
    [ "ext" ] = error,
    [ "reboot" ] = os.reboot,
    [ "cd" ] = cd,
    [ "ls" ] = ls
}

local function pass(a)
    for k,v in pairs(z) do
        if a == k then
            v()
            break
        end
    end
end

while true do
    write("dash@("..wd..")-$")
    local input = read()
    pass(input)
end