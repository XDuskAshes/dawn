if fs.exists("/etc/logs/boot") then
    fs.delete("/etc/logs/boot")
end

shell.run("set shell.allow_disk_startup false")

shell.run("/boot/dboot.lua")