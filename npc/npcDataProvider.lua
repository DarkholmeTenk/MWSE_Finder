local Memoize = import("darkcraft.dev.util.Memoize")

local npcDataProvider = {}

npcDataProvider.getNpcs = Memoize.noArgs(function()
    local npcs = {}
    for npc in tes3.iterateObjects(tes3.objectType.npc) do
        if(npc.id ~= "player") then
            table.insert(npcs, npc)
        end
    end
    return npcs
end)

npcDataProvider.getSpellMerchants = Memoize.noArgs(function()
    local spellMerchants = {}
    for _,npc in pairs(npcDataProvider.getNpcs()) do
        if(npc.class.offersSpells) then
            table.insert(spellMerchants, npc)
        end
    end
    return spellMerchants
end)

npcDataProvider.findNPCSelling = function(spell)
    local containing = {}
    for _,npc in pairs(npcDataProvider.getSpellMerchants()) do
        if(npc.spells:contains(spell.id)) then
            table.insert(containing, npc)
        end
    end
    return containing
end

npcDataProvider.getNpcLocation = function(npc)
    if(tes3.getPlayerCell() == nil) then
        return "Game not loaded"
    else
        local ref = tes3.dataHandler.nonDynamicData:findFirstCloneOfActor(npc.id)
        if(ref ~= nil) then
            return ref.cell.name
        end
    end
    return "Unable to find actor"
end

return npcDataProvider