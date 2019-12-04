local base = import("darkcraft.dev.ui.renderer.base")
local databind = import("darkcraft.dev.ui.util.databind")
local xmlreader = import("darkcraft.dev.ui.util.xmlreader")
local Memoize = import("darkcraft.dev.util.Memoize")

local getEffects = Memoize.noArgs(function()
    local effects = {}
    for i,v in pairs(tes3.dataHandler.nonDynamicData.magicEffects) do
        table.insert(effects, v)
    end
    return effects
end)

local selectorMenuXml = [[
    <Menu id="effectSelectorMenu" fixedFrame="true" width="350" height="500" flowDirection="top_to_bottom" autoWidth="false" autoHeight="false">
        <Label text="Select Magic Effect" />
        <VerticalScrollPane proportionalWidth="1" proportionalHeight="1">
            <ForEach from="{effects}" value="effect" flowDirection="top_to_bottom">
                <Button text="${return d.effect.name}" mouseClick="${return function(e,a,r) d.select(d) end}" />
            </ForEach>
        </VerticalScrollPane>
        <Block flowDirection="left_to_right" autoWidth="true" autoHeight="true">
            <Button text="None" mouseClick="${return function(e,a,r) d.select(d) end}" />
            <Button text="Cancel" mouseClick="{effectSelectorMenu#close}" />
        </Block>
    </Menu>
]]

local function getOpenSelectorMenu(onChange)
    return function(element, argument, renderer)
        local data = databind:__wrap{
            select = function(d)
                mwse.log("Effect selected")
                onChange(d.effect)
                d["effectSelectorMenu#close"]()
            end,
            effects= getEffects()
        }
        renderer:render(nil, xmlreader.parse(selectorMenuXml), data)
    end
end

local function getDefaultButtonLabel(currentSelected)
    if(currentSelected ~= nil and currentSelected ~= -1) then
        local effect = tes3.getMagicEffect(currentSelected)
        if(effect ~= nil) then
            return "Magic Effect: " .. effect.name
        end
    end
    return "Select Magic Effect"
end

local EffectSelectorElement = base.xml:extend([[
    <Button text="{label}" mouseClick="{openSelectorMenu}"/>
]], function(attributes, data)
    data.effects = getEffects()
    data.label = attributes.label or getDefaultButtonLabel(attributes.selected)
    data.openSelectorMenu = getOpenSelectorMenu(attributes.onChange)
end)

return EffectSelectorElement