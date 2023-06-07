--Make sure the base does exist

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
    "/startup/",
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
    --"/sys/boot.lua"
    --Uncomment the above line (and this) if you make an OS based on this
}

for _,v in pairs(basefs) do
    if fs.exists(v) then
        print(v,"exists")
    else
        printError("/startup/ensurebase.lua:38:",v,"does not exist.")
        error()
    end
end

for _,v in pairs(core) do
    if fs.exists(v) then
        print(v,"exists")
    else
        printError("/startup/ensurebase.lua:47:",v,"does not exist.")
        error()
    end
end

shell.run("/boot/dboot.lua")