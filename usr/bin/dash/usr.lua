--[[
    All user stuffs
    By Dusk
]]

local kernel = require "/kernel"

local args = {...}

if args[1] == "-a" then --add user
    local newPass = ""
    local newSudo = ""
    local newHome = ""

    --check for sudo

    if args[2] == "--sudo" then
        local handle1 = fs.open("/etc/usr/.login","r")
        local user = handle1.readLine()
        handle1.close()

        local handle2 = fs.open("/etc/usr/"..user..".txt","r")
        local eh = handle2.readLine()
        local sudo = handle2.readLine()
        handle2.close()

        if sudo == "false" then
            kernel.scrMSG(4,"Sudo is not active for"..user)
        end

        --sudo for new user
        if args[3] == "-y" then
            newSudo = "true"
        elseif args[3] == "-n" then
            newSudo = "false"
        elseif args[3] == nil then
            kernel.scrMSG(4,"no option for sudo selected")
        else
            kernel.scrMSG(4,args[3].." is not acceptable sudo opt")
        end

    --home for new user
    if args[4] == "yHome" then
        newHome = "true"
    elseif args[4] == "nHome" then
        newHome = "nil"
    elseif args[4] == nil then
        kernel.scrMSG(4,"no opt chosen for home (yHome/nHome)")
    else
        kernel.scrMSG(4,args[4].." is not acceptable opt for home (yHome/nHome)")
    end

    --name for new user
    if args[5] == nil then
        kernel.scrMSG(4,"no name chosen")
    end

    --password for new user
    if args[6] == nil then
        kernel.scrMSG(4,"no password set")
    else
        newPass = args[6]
    end

    if fs.exists("/etc/usr/"..args[5]..".txt") then
        kernel.scrMSG(4,"user exists")
    else
    
    --make the user file
    fs.copy("/etc/file","/etc/usr/"..args[5]..".txt")
    if fs.exists("/etc/usr/"..args[5]..".txt") then
        kernel.scrMSG(1,"/etc/usr/"..args[5]..".txt created")
    else
        kernel.scrMSG(4,"/etc/usr/"..args[5]..".txt not created")
    end
    --open and write password, sudo stat, and if has home
    local handle = fs.open("/etc/usr/"..args[5]..".txt","w")
    handle.writeLine(newPass)
    kernel.scrMSG(1,"password ("..newPass..") written")
    handle.writeLine(newSudo)
    kernel.scrMSG(1,"sudo value ("..newSudo..") written")
    handle.writeLine(newHome)
    kernel.scrMSG(1,"home value ("..newHome..") written")
    handle.close()
    end
else
    kernel.scrMSG(4,"Command must be run with sudo")
end
    --if home yes then make
    if newHome == "true" then
        fs.makeDir("/home/"..args[5])
            if fs.exists("/home/"..args[5]) then
                kernel.scrMSG(1,"/home/"..args[5].."/ created")
            else
               kernel.scrMSG(4,"/home/"..args[5].."/ not created")
            end 
    end
elseif args[1] == "-r" then --remove user
    local handle = fs.open("/etc/usr/.login","r")
    local login = handle.readLine()
    handle.close()

    if args[2] == "--sudo" then
    local handle2 = fs.open("/etc/usr/"..login..".txt","r")
    local eh = handle2.readLine()
    local sudo = handle2.readLine()
    handle2.close()

    if sudo == "false" then
        kernel.scrMSG(4,"sudo not available for this user")
    elseif sudo == "true" then
        if args[3] == "root" then
            kernel.scrMSG(4,"cannot remove root")
        elseif args[3] == login then
            kernel.scrMSG(4,"user is logged in. please try as different user or root.")
        elseif fs.exists("/etc/usr/"..args[3]..".txt") ~= true then
            kernel.scrMSG(4,"user doesn't exist")
        elseif args[3] == nil then
            kernel.scrMSG(4,"please supply a user")
        else
            local handle3 = fs.open("/etc/usr/"..args[3]..".txt","r")
            local skip = handle3.readLine()
            local alsoskip = handle3.readLine()
            local home = handle3.readLine()
            handle3.close()

            if home == "true" then
                fs.delete("/home/"..args[3])
                kernel.scrMSG(1,"removed home folder for "..args[3])
            end

            fs.delete("/etc/usr/"..args[3]..".txt")
            kernel.scrMSG(1,"user "..args[3].." deleted")
                
        end
    end
else
    kernel.scrMSG(4,"must be run with sudo")
end
elseif args[1] == "-l" then --list users
    local a = fs.list("/etc/usr/")
    table.remove(a,1)
    for k,v in pairs(a) do
        print(v)
    end
elseif args[1] == nil then
    kernel.scrMSG(4,"Invalid or no flag (-a, -r, -l) selected")
end