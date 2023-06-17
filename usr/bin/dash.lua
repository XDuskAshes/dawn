--[[
    DASH Terminal
    Custom for dawn kernel
    By Dusk
]]

require("/kernel")

local wd = "/"

local function cd()
    write("cd from "..wd.." to:")
    local i = read()
    if fs.exists(i) then
        if fs.isDir(i) then
            wd = i
        elseif fs.isDir(i) ~= true then
            scrMSG(3,i.." is not a dir")
        elseif i == nil or "" then
            scrMSG(3,i.." is not valid.")
        end
    else
        scrMSG(3,i.." doesn't exist as dir or file.")
    end

    if wd == nil then
        wd = "/"
        scrMSG(3,"Not a proper dir.")
    end

    if wd == "" then
        wd = "/"
        scrMSG(3,"Not a proper dir.")
    end
end

local function ls()
    shell.run("ls",wd)
end

local function pkg()
    write(" -")
    local flag = read()
    if flag == "i" then
        write(" ")
        local package = read()
        
        
    end
end

local z = {
    [ "ext" ] = error,
    [ "reboot" ] = os.reboot,
    [ "cd" ] = cd,
    [ "ls" ] = ls,
    [ "pkg" ] = pkg
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