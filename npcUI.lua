local npcUI = {
}

npcUI.getSpellMerchants = function()
    if(npcUI.spellMerchants == nil) then
        npcUI.spellMerchants = {}
        for npc in tes3.iterateObjects(tes3.objectType.npc) do
            if(npc.id ~= "player" and npc.class.offersSpells) then
                table.insert(npcUI.spellMerchants, npc)
            end
        end
    end
    return npcUI.spellMerchants
end

npcUI.findNPCSelling = function(spell)
    local containing = {}
    for _,npc in pairs(npcUI.getSpellMerchants()) do
        if(npc.spells:contains(spell.id)) then
            table.insert(containing, npc)
        end
    end
    return containing
end

return npcUI