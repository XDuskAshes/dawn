--[[
    Dawn Kernel
    By Dusk
    1.0.0-idev1
]]

--require("/sbin/dawn/core/fhs") --throws an error: 'loop or previous error loading module "/sbin/dawn/core/fhs"'

local function _SYSCALL()
    local i = fs.open("/var/.dawninf","r")
    local inf1 = i.readLine(1)
    local inf2 = i.readLine(2)
    local inf3 = i.readLine(3)
    local inf4 = i.readLine(4)
    i.close()
    print(inf1)
    print(inf2)
    print(inf3)
    print(inf4)
end

--fhs checks

--check("root")


--kernelcall()

function kernelcall(func) --call kernel functions
    local funcs = {
        [ "_SYSCALL" ] = _SYSCALL,
    }

    for k,v in pairs(funcs) do
        if func == k then
            v()
            break
        end
    end
end