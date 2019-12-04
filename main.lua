require("darkcraft.dev.package_manager.import")

local config = import("darkcraft.finder.config")
local mainUI = import("darkcraft.finder.mainUI")

event.register("modConfigReady", config.register)
event.register("keyDown", function(e)
    if(config.isKeybindPressed(e, config.getFinderUIKeybind())) then
        mainUI.open()
    end
end)