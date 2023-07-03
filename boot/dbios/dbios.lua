--[[
    dbios for dawn
    By Dusk
]]

local function isempty(s) --i robbed this from https://stackoverflow.com/questions/19664666/check-if-a-string-isnt-nil-or-empty-in-lua
    return s == nil or s == ''
end

while true do
    write("@ ")
    local a = read()
    if isempty(a) then
        write("")
    else
        shell.run("/boot/dbios/core/"..a)
    end
end