--[[
    PKG - Package Manager
    Downloads list from /stat/pkg/sources-list.txt
    Downloads ignore from https://raw.githubusercontent.com/XDuskAshes/dawn/pkgs/pkg-ignore
]]

local kern = require("/kernel")
local handle2
local args = {...}
if #args < 1 then
    print("Usage: pkg (-i/-r/-l/-add-src/-rm-src)")
    return
end

if args[1] == "-i" then
    if kern.empty(args[2]) then
        print("<pkg> field left blank")
    else
        local sources = {}
    local srcs = fs.open("/stat/pkg/sources-list.txt","r")
    repeat
        local a = srcs.readLine()
        table.insert(sources,a)
    until a == nil
    srcs.close()
    for k,v in pairs(sources) do
        local handle = assert(http.get(v))
        print("Hit ["..k.."]:"..v)
        local pkg = textutils.unserialize(handle.readAll())
        handle.close()
            for k,v in pairs(pkg) do
                if args[2] == k then
                    handle2 = assert(http.get(v))
                    local pkg_info = textutils.unserialize(handle2.readAll())
                    handle2.close()
                    print("Name:",pkg_info[1])
                    print("Version:",pkg_info[2])
                    print("Description:",pkg_info[3])
                    write("Install? (y/n)")
                    local yn = read()
                        if yn == "y" then
                            shell.run("fg wget",pkg_info[4],"/bin/"..args[2]..".lua")
                        elseif yn == "n" then 
                            error("Cancelling!",0)
                    else
                        kern.scrMSG(5,"Bailed due to invalid input.")
                    end
                else
                end
            end
        end
    end
elseif args[1] == "-r" then
    local handle = assert(http.get("https://raw.githubusercontent.com/XDuskAshes/dawn/pkgs/pkg-ignore"))
    local ingnore = textutils.unserialize(handle.readAll())
    handle.close()

    for k,v in pairs(ingnore) do
        if args[2] == v then
            kern.scrMSG(5,"cannot rm: "..args[2].." (ignore)")
        end
    end

    if fs.exists("/bin/"..args[2]..".lua") then
        fs.delete("/bin/"..args[2]..".lua")
        print("Removed",args[2]..".lua")
    else
        kern.scrMSG(5,"Cannot find: "..args[2]..".lua")
    end
elseif args[1] == "-l" then
    local ls = {}
    local handle = fs.open("/stat/pkg/sources-list.txt","r")
    repeat
        local a = handle.readLine()
        table.insert(ls,a)
    until a == nil
    handle.close()

    for k,v in pairs(ls) do
        local pkg_get = assert(http.get(v))
        local pkg = textutils.unserialize(pkg_get.readAll())
        pkg_get.close()

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
    end
elseif args[1] == "-add-src" then
    if kern.empty(args[2]) then
        error("pkg -add-src <link> (blank <link> arg)",0)
    else
        local handle = fs.open("/stat/pkg/sources-list.txt","a")
        textutils.slowWrite("#")
        handle.writeLine(args[2])
        textutils.slowWrite("#")
        handle.close()
        textutils.slowWrite("#\n")
    end
elseif args[1] == "-rm-src" then
    if kern.empty(args[2]) then
        error("pkg -rm-src <src> (empty <src> arg)",0)
    elseif args[2] == "https://raw.githubusercontent.com/XDuskAshes/dawn/pkgs/pkg-list" then
        kern.scrMSG(5,"cannot -rm-src ("..args[2].."): main pkg repo")
    else
        local srcls = {}
        local handle = fs.open("/stat/pkg/sources-list.txt","r")
        repeat
            local a = handle.readLine()
            table.insert(srcls,a)
            textutils.slowWrite("#")
        until a == nil
        handle.close()

        fs.delete("/stat/pkg/sources-list.txt")
        textutils.slowWrite("#")
        fs.copy("/etc/file","/stat/pkg/sources-list.txt")
        textutils.slowWrite("#")
        for k,v in pairs(srcls) do
            if args[2] == v then
                table.remove(srcls,k)
                textutils.slowWrite("#")
            end
        end

        local reWrite = fs.open("/stat/pkg/sources-list.txt","w")
        for k,v in pairs(srcls) do
            reWrite.writeLine(v)
            textutils.slowWrite("#")
        end
        reWrite.close()
        textutils.slowWrite("#\n")
    end
end