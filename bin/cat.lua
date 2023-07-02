--cat

local k = require "/kernel"

local args = {...}

if k.empty(args[1]) then
    print("Usage: cat <file>")
else
    if fs.exists(args[1]) then
        local t = {}
        local handle = fs.open(args[1],"r")
        repeat
            local a = handle.readLine()
            table.insert(t,a)
        until a == nil
        for i,v in ipairs(t) do
            textutils.pagedPrint(v)
        end
    end
end