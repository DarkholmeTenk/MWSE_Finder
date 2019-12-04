local base = require("darkcraft.dev.ui.renderer.base")
local npcUI = require("darkcraft.finder.npcUI")

local renderers = {
    import("darkcraft.finder.spell.spellRenderers"),
    import("darkcraft.finder.npc.NpcRenderers"),
    import("darkcraft.finder.helper.HelperRenderGroup"),
    import("darkcraft.finder.ingredient.IngredientRenderGroup")
}

return renderers