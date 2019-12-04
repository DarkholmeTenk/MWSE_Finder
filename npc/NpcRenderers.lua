local base = import("darkcraft.dev.ui.renderer.base")
local NpcDetailUI = import("darkcraft.finder.npc.NpcDetailUI")
local NpcTrainerElement = import("darkcraft.finder.npc.NpcTrainerElement")

local NpcRenderers = {
    NpcRow = base.xml:extend([[
        <TextSelect text="{npcName}" mouseClick="{openNpcDetailMenu}">
            <TooltipMenu>
                <Label text="{npcName}" />
            </TooltipMenu>
        </TextSelect>
    ]], function(attributes, data)
        local npc = attributes.npc
        data.npcName = npc.name
        data.openNpcDetailMenu = function(e,t,r) NpcDetailUI.openNpcDetailMenu(r, npc) end
    end),
    NpcTrainer = NpcTrainerElement
}

return NpcRenderers