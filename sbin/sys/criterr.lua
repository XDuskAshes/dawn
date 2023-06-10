--[[
    criterr
    when a critical error occurs, the kernel should launch this and stop all processes
    by dusk
]]

term.clear()
term.setCursorPos(1,1)
printError("kernel encountered a critical error.")
print("Info:".."example text") --todo: figure out how to get error texts to feed into here
print("From process:".."process") --todo: figure out how to get the process that caused it to feed into here
print("The system will restart in 10 seconds.")
sleep(10)
os.reboot()