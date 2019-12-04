local Memoize = import("darkcraft.dev.util.Memoize")

local spellDataProvider = {}

spellDataProvider.getSpells = Memoize.noArgs(function()
    local spells = {}
    for spell in tes3.iterateObjects(tes3.objectType.spell) do
        table.insert(spells, spell) 
    end
    return spells
end)

spellDataProvider.spellHasEffectInSchool = function(spell, schoolID)
    for _,effect in pairs(spell.effects) do
        if(effect.id == -1) then return false end
        
        local effectObj = tes3.getMagicEffect(effect.id)
        if(effectObj ~= nil and effectObj.school == schoolID) then 
            return true 
        end
    end
    return false
end

spellDataProvider.spellHasEffect = function(spell, effectID)
    for _,effect in pairs(spell.effects) do
        if(effect.id == -1) then return false end
        
        if(effect.id == effectID) then
            return true
        end
    end
    return false
end

return spellDataProvider