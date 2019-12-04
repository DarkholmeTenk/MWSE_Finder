local xmlreader = import("darkcraft.dev.ui.util.xmlreader")
local databind = import("darkcraft.dev.ui.util.databind")
local spellDataProvider = import("darkcraft.finder.spell.spellDataProvider")

local spellDetail = {}

local spellDetailXml = [[
    <Menu id="SpellDetailUI" width="500" height="600" fixedSize="true"
                dragFrame="true"  
                text="{title}" autoWidth="false" autoHeight="false" flowDirection="top_to_bottom">
        <Block flowDirection="left_to_right" widthProportional="1" heightProportional="1">
            <SpellDetails spell="{spell}" />
            <SpellSales spell="{spell}" />
        </Block>
        <Button mouseClick="{SpellDetailUI#close}" text="Close" />
    </Menu>
]]

spellDetail.openSpellDetailMenu = function(renderInstance, spell)
    local data = databind:__wrap{spell = spell, title = "Spell Details - " .. spell.name}
    local xml = xmlreader.parse(spellDetailXml)
    renderInstance:render(nil, xml, data)
end

return spellDetail