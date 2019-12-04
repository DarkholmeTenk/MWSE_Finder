local xmlreader = import("darkcraft.dev.ui.util.xmlreader")
local databind = import("darkcraft.dev.ui.util.databind")
local spellDataProvider = import("darkcraft.finder.spell.spellDataProvider")
local spellDetailUI = import("darkcraft.finder.spell.spellDetailUI")

local spellFinder = {}

local spellFinderXml = [[
    <Menu id="SpellFinderUI" width="700" height="900" fixedSize="true"
                dragFrame="true"  absolutePosAlignX="0.5" absolutePosAlignY="0.5"
                text="Spell Finder" autoWidth="false" autoHeight="false" flowDirection="top_to_bottom">
        <SpellFilterSelector onChange="{filterSpells}" />
        <Filter from="{spells}" to="currentSpells" filter="{spellFilter}">
            <PagingProvider id="currentSpellPaging" from="{currentSpells}" to="currentSpellPage">
                <VerticalScrollPane widthProportional="1" heightProportional="1">
                    <ForEach value="spell" from="{currentSpellPage}" autoWidth="true" autoHeight="true" flowDirection="top_to_bottom">
                        <SpellRow spell="{spell}" />
                    </ForEach>
                </VerticalScrollPane>
                <Block flowDirection="left_to_right" widthProportional="1" autoHeight="true">
                    <Button text="Back" mouseClick="{currentSpellPaging#prev}" />
                    <Label text="{currentSpellPaging#str}" />
                    <Button text="Next" mouseClick="{currentSpellPaging#next}" />
                </Block>
            </PagingProvider>
        </Filter>
        <Button mouseClick="{SpellFinderUI#close}" text="Close" />
    </Menu>
]]

spellFinder.openSpellMenu = function(_,_,renderInstance)
    local data = databind:__wrap{spells=spellDataProvider.getSpells(),
            spellFilter=function() return true end,
            openSpellDetailMenu = spellDetailUI.openSpellDetailMenu}
    data.filterSpells = function(filter)
        data.spellFilter = filter
    end
    local xml = xmlreader.parse(spellFinderXml)
    renderInstance:render(nil, xml, data)
end

return spellFinder