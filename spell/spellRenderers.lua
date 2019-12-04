local base = import("darkcraft.dev.ui.renderer.base")
local spellDetailUI = import("darkcraft.finder.spell.spellDetailUI")

local function getCastTypeString(castType)
    for i,v in pairs(tes3.spellType) do
        if(v == castType) then
            return i
        end
    end
    return "Unknown"
end

local spellRenderers = {
    SpellEffect = base.xml:extend([[
        <Block autoWidth="true" autoHeight="true">
            <FieldLabel fieldLabel="Effect:"  fieldValue="{effectName}" />
        </Block>
    ]], function(attributes, data)
        local effect = attributes.effect
        local effectBase = tes3.getMagicEffect(effect.id)
        data.effectName = effectBase.name
    end),
    SpellDetails = base.xml:extend([[
        <Block flowDirection="top_to_bottom" autoWidth="true" autoHeight="true">
            <FieldLabel fieldLabel="ID:" fieldValue="{spellID}" />
            <FieldLabel fieldLabel="Name:" fieldValue="{spellName}" />
            <FieldLabel fieldLabel="Type:" fieldValue="{spellType}" />
            <FieldLabel fieldLabel="Spell Cost:" fieldValue="{spellCost}" />
            <Label text="Effects:" />
            <Block autoWidth="true" autoHeight="true" paddingLeft="10">
                <ForEach from="{spellEffects}" value="spellEffect" flowDirection="top_to_bottom">
                    <SpellEffect effect="{spellEffect}" />
                </ForEach>
            </Block>
        </Block>
    ]], function(attributes, data)
        local spell = attributes.spell
        data.spellID = spell.id
        data.spellName = spell.name
        data.spellCost = spell.magickaCost
        data.spellType = getCastTypeString(spell.castType)
        local effects = {}
        for _,v in pairs(spell.effects) do if(v.id ~= -1) then table.insert(effects, v) end end
        data.spellEffects = effects
    end),
    SpellRow = base.xml:extend([[
        <TextSelect text="{spellName}" mouseClick="{openSpellDetailMenu}" >
            <TooltipMenu><SpellDetails spell="{spell}" /></TooltipMenu>
        </TextSelect>
    ]], function(attributes, data)
        local spell = attributes.spell
        data.spellName = spell.name
        data.openSpellDetailMenu = function(e,t,r) spellDetailUI.openSpellDetailMenu(r, spell) end
    end),
    SpellFilterSelector = import("darkcraft.finder.spell.SpellFilterElement"),
    SpellSales = import("darkcraft.finder.spell.SpellSalesElement")
}

return spellRenderers