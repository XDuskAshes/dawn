--dawn default boot program
--by dusk

local b = fs.open("/boot/.bootfile","r")
local bootfile = b.readLine(1)
b.close()

local c = fs.open("/boot/.bailto","r")
local bailto = c.readLine(1)
c.close()

if fs.exists(bootfile) then
    print("Boot file exists.")
    print("boot...")
    shell.run(bootfile)
else
    printError("File defined in '/boot/.bootfile' doesn't exist.")
    print("Launch",bailto)
    shell.run(bailto)
end