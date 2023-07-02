--[[
    PKG - Package Manager
    Downloads list from https://raw.githubusercontent.com/XDuskAshes/dawn/pkgs/pkg-list
    Downloads ignore from https://raw.githubusercontent.com/XDuskAshes/dawn/pkgs/pkg-ignore
]]

local kernel = require("/kernel")

local args = {...}
if #args < 1 then
    print("Usage: pkg (-i/-r/-l/--add-src (not fully useful))")
    return
end

if args[1] == "-i" then
    local handle = assert(http.get("https://raw.githubusercontent.com/XDuskAshes/dawn/pkgs/pkg-list"))
    local pkg = textutils.unserialize(handle.readAll())
    handle.close()

    for k,v in pairs(pkg) do
        if args[2] == "all" then
            shell.run("wget",v,"/bin/"..k..".lua")
        elseif args[2] == k then
            shell.run("wget",v,"/bin/"..k..".lua")
        end
    end
elseif args[1] == "-r" then
    local handle = assert(http.get("https://raw.githubusercontent.com/XDuskAshes/dawn/pkgs/pkg-ignore"))
    local ignore = textutils.unserialize(handle.readAll())
    handle.close()
    
    if args[2] == "all" then
        local handle2 = assert(http.get("https://raw.githubusercontent.com/XDuskAshes/dawn/pkgs/pkg-list"))
        local pkg = textutils.unserialize(handle2.readAll())
        handle2.close()
        for k,v in pairs(pkg) do
            if fs.exists("/bin/"..k..".lua") then
                fs.delete("/bin/"..k..".lua")
            end
        end
    else
        for k,v in pairs(ignore) do
            if args[2] == v then
                kernel.scrMSG(5,"Cannot delete "..args[2]..": defined in ignore")
            elseif args[2] == "pkg" then
                print("(insert J. Jonah Jameson laughing hysterically)")
                error()
            end
        end
            if fs.exists("/bin/"..args[2]..".lua") then
                fs.delete("/bin/"..args[2]..".lua")
                kernel.scrMSG(1,"Deleted:"..args[2]..".lua")
            else
                kernel.scrMSG(3,"File "..args[2]..".lua doesn't exist.")
                return
            end
        end
elseif args[1] == "-l" then
    local handle = assert(http.get("https://raw.githubusercontent.com/XDuskAshes/dawn/pkgs/pkg-list"))
    local pkg = textutils.unserialize(handle.readAll())
    handle.close()
    for k,v in pairs(pkg) do
        if fs.exists("/bin/"..k..".lua") then
            write(k.." (")
            term.setTextColor(colors.green)
            write("INSTALLED")
            term.setTextColor(colors.white)
            write(")\n")
        else
            write(k.." (")
            term.setTextColor(colors.red)
            write("NOT INSTALLED")
            term.setTextColor(colors.white)
            write(")\n")
        end
    end
--[[elseif args[1] == "--add-src" then
    if kernel.empty(args[2]) then
        print("Usage: pkg --add-src <link>")
    else
        local handle3 = fs.open("/stat/pkg/sources-list.txt","a")
        handle3.writeLine(args[2])
        handle3.close()
    end
else
    kernel.scrMSG(5,args[1].." is not valid arg")
]]
end