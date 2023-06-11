--Make sure the base does exist
--By Dusk

term.clear()
term.setCursorPos(1,1)

local basefs = {
    "/bin/",
    "/boot/",
    "/dev/",
    "/etc/",
    "/lib/",
    "/mnt/",
    "/opt/",
    "/sbin/",
    "/tmp/",
    "/var/",
    "/sys/",
    "/usr/",
    "/usr/bin/",
    "/usr/lib/",
    "/usr/local/",
    "/usr/sbin/",
    "/usr/share/"
}

local core = {
    "/kernel.lua",
    "/boot/.bootfile",
    "/boot/dboot.lua",
    "/usr/bin/dash.lua",
    "/sbin/core/",
    "/sbin/sys/",
    "/sbin/core/fhs.lua",
    "/sbin/sys/criterr.lua"
    --"/sys/boot.lua"
    --Uncomment the above line (and this) if you make an OS based on this
}

for _,v in pairs(basefs) do
    if fs.exists(v) then
        print(v,"exists")
    else
        error(v.." does not exist.")
    end
end

for _,v in pairs(core) do
    if fs.exists(v) then
        print(v,"exists")
    else
        error(v.." does not exist.")
    end
end

shell.run("/boot/dboot.lua")
