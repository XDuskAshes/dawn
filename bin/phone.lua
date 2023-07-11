--phone
--Call to a line from a file

local k = require "/kernel"

local function ring()
    local speaker = peripheral.find("speaker")
    if speaker then
        speaker.playNote("bit",3,24)
        sleep(0.1)
        speaker.playNote("bit",3,20)
        sleep(0.1)
        speaker.playNote("bit",3,24)
        sleep(0.1)
        speaker.playNote("bit",3,20)
        sleep(0.1)
        speaker.playNote("bit",3,24)
        sleep(0.1)
        speaker.playNote("bit",3,20)
        sleep(0.1)
        speaker.playNote("bit",3,24)
        sleep(0.1)
        speaker.playNote("bit",3,20)
    else
        print("Ringing...")
    end
end

local function dialTone(desc)
    local speaker = peripheral.find("speaker")
    if speaker then
        speaker.playNote("bit",3,1)
    else
        print("Dial tone: request failed. ("..desc..")")
    end
end

local function dialConnect()
    local speaker = peripheral.find("speaker")
    if speaker then
        speaker.playNote("bit",3,18)
        sleep(0.1)
        speaker.playNote("bit",3,19)
        sleep(0.1)
        speaker.playNote("bit",3,20)
        sleep(0.1)
        speaker.playNote("bit",3,23)
    else
        print("Connected!")
    end
end

local args = {...}

if k.empty(args[1]) or k.empty(args[2]) then
    dialTone("empty arg")
else
    local e = tonumber(args[2])
    ring()
    if fs.exists(args[1]) then
        if fs.isDir(args[1]) then
            dialTone("Path cannot be dir")
        else
            local t = {}
            local handle = fs.open(args[1],"r")
            repeat
                local a = handle.readLine()
                table.insert(t,a)
            until a == nil
            handle.close()
            for i,v in ipairs(t) do
                if e == i then
                    if k.empty(v) then
                        dialTone("line == nil")
                    else
                        dialConnect()
                        print(v)
                    end
                end
            end
        end
    else
        dialTone("Path doesn't exist")
    end
end