--[[
    All user stuffs
    By Dusk
]]

local kernel = require "/kernel"

local function isempty(s) --i robbed this from https://stackoverflow.com/questions/19664666/check-if-a-string-isnt-nil-or-empty-in-lua
    return s == nil or s == ''
end

local args = {...}

if args[1] == "-a" then
    
elseif args[1] == "-r" then

elseif args[1] == "-l" then
    
elseif isempty(args[1]) then
    print("Usage: usr (-a/-r/-l)")
end