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
    "/run/",
    "/sbin/",
    "/srv/",
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
    "/usr/bin/dash.lua"
    --"/sys/boot.lua"
    --Uncomment the above line (and this) if you make an OS based on this
}

for _,v in pairs(basefs) do
    if fs.exists(v) then
        print(v," exists")
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
