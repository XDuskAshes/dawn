--[[
    PKG - Package Manager
    Downloads list from /stat/pkg/sources-list.txt
    Downloads ignore from https://raw.githubusercontent.com/XDuskAshes/dawn/pkgs/pkg-ignore
]]

local kern = require("/kernel")

local args = {...}
if #args < 1 then
    print("Usage: pkg (-i/-r/-l/-u")
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
    for _,v in pairs(sources) do 
        local handle = assert(http.get(v)) 
        print("Hit: "..v)
        local pkg = textutils.unserialize(handle.readAll()) 
        handle.close()
            for k,v in pairs(pkg) do 
                if args[2] == k then 
                    local handle2 = assert(http.get(v)) 
                        local pkg_info = textutils.unserialize(handle2.readAll())
                    handle2.close()
                    print("Name:",pkg_info[1])
                    print("Version:",pkg_info[2])
                    print("Description:",pkg_info[3])
                    write("Install? (y/n)")
                    local yn = read() 
                        if yn == "y" then 
                            shell.run("wget",pkg_info[4],"/bin/"..args[2]..".lua")
                        elseif yn == "n" then 
                            error("Cancelling!",0)
                    else
                        kern.scrMSG(5,"Bailed due to invalid input.")
                    end
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
end