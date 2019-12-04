local xmlreader = import("darkcraft.dev.ui.util.xmlreader")
local databind = import("darkcraft.dev.ui.util.databind")
local npcDataProvider = import("darkcraft.finder.npc.npcDataProvider")

local NpcDetailUI = {}

local npcDetailXml = [[
    <Menu id="NpcDetailUI" width="400" height="500" fixedSize="true"
            dragFrame="true" 
            text="{title}" autoWidth="false" autoHeight="false" flowDirection="top_to_bottom">
        <Block flowDirection="top_to_bottom" heightProportional="1" widthProportional="1">
            <FieldLabel fieldLabel="ID:" fieldValue="{npcID}" />
            <FieldLabel fieldLabel="Name:" fieldValue="{npcName}" />
            <FieldLabel fieldLabel="Location:" fieldValue="{npcLocation}" />
            <NpcTrainer npc="{npc}" />
        </Block>
        <Button mouseClick="{NpcDetailUI#close}" text="Close" />
    </Menu>
]]

NpcDetailUI.openNpcDetailMenu = function(renderer, npc)
    local data = databind:__wrap{title="NPC Details - " .. npc.name,
        npcID = npc.id,
        npcName = npc.name,
        npcLocation = npcDataProvider.getNpcLocation(npc),
        npc = npc}
    local xml = xmlreader.parse(npcDetailXml)
    renderer:render(nil, xml, data)
end

return NpcDetailUI