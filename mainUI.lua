local renderer = import("darkcraft.dev.ui.renderer")
local xmlreader = import("darkcraft.dev.ui.util.xmlreader")
local databind = import("darkcraft.dev.ui.util.databind")
local elementRenderers = import("darkcraft.finder.elementRenderers")

local spellFinderUI = import("darkcraft.finder.spell.spellFinderUI")
local ingredientFinderUI = import("darkcraft.finder.ingredient.IngredientFinderUI")

local mainUI = {}

local mainXML = [[
    <Menu id="FinderUI" width="300", height="400" fixedFrame="true" autoWidth="false" autoHeight="false" flowDirection="top_to_bottom">
        <Label text="Finder Menu" />
        <Button mouseClick="{openSpellMenu}" text="Spells" />
        <Button mouseClick="{openIngredientMenu}" text="Ingredients" />
        <Button mouseClick="{FinderUI#close}" text="Close"/>
    </Menu>
]]

mainUI.open = function()
    local data = databind:__wrap{
        openSpellMenu=spellFinderUI.openSpellMenu,
        openIngredientMenu=ingredientFinderUI.open
    }
    local xml = xmlreader.parse(mainXML)
    local renderInstance = renderer:new()
    renderInstance:addRenderGroups(elementRenderers)
    renderInstance:render(nil, xml, data)
end

return mainUI