--[[
    Core FHS dawn lib
    dawn uses FHS as a base, and adds modifications
    basically a glorified fs lookup
    by dusk
    contributed to by: (names go here if any)
]]

require("/kernel")

--what should the root be
local root = {
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
    "/sys/",
    "/tmp/",
    "/usr/",
    "/var/",
    "/stat/"
}

local function rootch()
    for k,v in pairs(root) do
        if fs.exists(v) ~= true then
            error("folder "..v.." doesn't exist")
        end
    end
    print("Root checked with no issues.")
end

--what /etc/ should contain
local etc = {
    "/etc/.file",
    "/etc/file",
    "/etc/usr/",
    "/etc/usr/root"
}

local function etcch()
    for k,v in pairs(etc) do
        if fs.exists(v) ~= true then
            error("folder "..v.." doesn't exist")
        end
    end
    print("etc checked with no issues.")
end

--/usr/ secondary
local usr = {
    "/usr/bin/",
    "/usr/lib/",
    "/usr/local/",
    "/usr/sbin/",
    "/usr/share/"
}

local function usrch()
    for k,v in pairs(usr) do
        if fs.exists(v) ~= true then
            error("folder "..v.." doesn't exist")
        end
    end
    print("usr checked with no issues.")
end

function check(a) --a is the thing to check (root, etc, usr)
    local lookups = {
        [ "root" ] = rootch,
        [ "etc" ] = etcch,
        [ "usr" ] = usrch
    }    

    for k,v in pairs(lookups) do
        if a == k then
            v()
        end
    end
end