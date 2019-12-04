local npcDataProvider = {}

npcDataProvider.getNpcs = function()
    if(npcDataProvider.npcs == nil) then
        npcDataProvider.npcs = {}
        for npc in tes3.iterateObjects(tes3.objectType.npc) do
            if(npc.id ~= "player") then
                table.insert(npcDataProvider.npcs, npc)
            end
        end
    end
    return npcDataProvider.npcs
end

npcDataProvider.getSpellMerchants = function()
    if(npcDataProvider.spellMerchants == nil) then
        npcDataProvider.spellMerchants = {}
        for _,npc in pairs(npcDataProvider.getNpcs()) do
            if(npc.class.offersSpells) then
                table.insert(npcDataProvider.spellMerchants, npc)
            end
        end
    end
    mwse.log("Spell sellers " .. #npcDataProvider.spellMerchants)
    return npcDataProvider.spellMerchants
end

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