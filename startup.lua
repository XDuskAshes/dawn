if fs.exists("/etc/logs/boot") then
    fs.delete("/etc/logs/boot")
end

shell.run("/boot/dboot.lua")