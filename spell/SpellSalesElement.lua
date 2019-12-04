local base = import("darkcraft.dev.ui.renderer.base")
local npcDataProvider = import("darkcraft.finder.npc.npcDataProvider")

local SpellSalesElement = base.xml:extend([[
    <Block flowDirection="top_to_bottom" width="200" height="300" paddingLeft="5" paddingRight="5">
        <Label text="Sellers:" />
        <VerticalScrollPane widthProportional="1" heightProportional="1" borderLeft="10" paddingAllSides="5" >
            <ForEach from="{sellers}" value="seller" flowDirection="top_to_bottom" autoWidth="true" autoHeight="true">
                <NpcRow npc="{seller}"/>
            </ForEach>
            <Label text="No sellers" visible="{noSellers}"/>
        </VerticalScrollPane>
    </Block>
]], function(attributes, data)
    local spell = attributes.spell
    local sellers = npcDataProvider.findNPCSelling(spell)
    data.sellers = sellers
    data.noSellers = #sellers == 0
end)

return SpellSalesElement