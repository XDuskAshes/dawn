--[[
    content lib
    made for dawn
    by Dusk
]]

local k = require("/kernel")

local c = {}

function c.lookup(what,thing) --look in the 'what' for 'thing' and print it out
    if fs.exists(what) then
      if fs.isDir(what) then
        k.scrMSG(5,"Dirs not supported")
      else
        local handle = fs.open(what)
        
      end
    else
      k.scrMSG(5,"Does not exist")
    end
  end

return c