local EasyMCM = import("easyMCM.EasyMCM")

local configPath = "darkcraft_finder.config"
local config = {}
config.data = mwse.loadConfig(configPath) or {}

config.register = function()
    mwse.log("Registering MCM for Finder")
    local template = EasyMCM.createTemplate("DC - Finder")
    template:saveOnClose(configPath, config.data)
    local page = template:createPage()
    local category = page:createCategory("Menu Settings")
    category:createKeyBinder{
        label = "Open Finder UI Keybind",
        allowCombinations = true,
        variable = EasyMCM.createTableVariable{
            id = "demo_ui_keybind",
            table = config.data,
            defaultSetting = {
                keyCode = tes3.scanCode.f,
                isShiftDown = false,
                isAltDown = false,
                isControlDown = true
            }
        }
    }
    EasyMCM.register(template)
end

config.getFinderUIKeybind = function()
    return config.data.demo_ui_keybind
end

config.isKeybindPressed = function(e, kb)
    return e.keyCode == kb.keyCode and
        e.isControlDown == kb.isControlDown and
        e.isShiftDown == kb.isShiftDown and 
        e.isAltDown == kb.isAltDown 
end

return config