local base = import("darkcraft.dev.ui.renderer.base")
local spellDataProvider = import("darkcraft.finder.spell.spellDataProvider")
local npcDataProvider = import("darkcraft.finder.npc.npcDataProvider")

local function rebuild(attributes, data, current)
    data.selectedSchool = current.schoolID
    data.selectedType = current.spellType
    data.selectedEffectID = current.effectID
    attributes.onChange(function(spell)
        if(current.spellType ~= -1 and spell.castType ~= current.spellType) then
            return false
        end
        if(current.schoolID ~= -1 and spellDataProvider.spellHasEffectInSchool(spell, current.schoolID) == false) then
            return false
        end
        if(current.effectID ~= -1 and spellDataProvider.spellHasEffect(spell, current.effectID) == false) then
            return false
        end
        if(current.hasSeller and #npcDataProvider.findNPCSelling(spell) == 0) then
            return false
        end
        return spell.name:find(current.text) ~= nil
    end)
    mwse.log("Updating spell filter " .. table.tostring(current))
end

local function getText(name, id, selectedID)
    if(id == selectedID) then
        return "* " .. name
    else
        return name
    end
end

local filter = base.xml:extend([[
    <Block autoWidth="true" autoHeight="true" flowDirection="top_to_bottom" >
        <Block flowDirection="left_to_right" widthProportional="1" autoHeight="true">
            <Label text="Filter: " />
            <TextInput onChange="{changeFilter}" widthProportional="1"/>
        </Block>
        <Block flowDirection="left_to_right" widthProportional="1" autoHeight="true">
            <EffectSelector onChange="{selectEffect}" selected="{selectedEffectID}"/>
            <Toggle default="false" onChange="{setHasSeller}" trueText="Has Sellers (*)" falseText="Has Sellers ( )" />
        </Block>
        <ForEach flowDirection="left_to_right" key="schoolName" value="schoolID" from="{spellSchools}">
            <Button text="${return d.getText(d.schoolName, d.schoolID, d.selectedSchool)}" mouseClick="${return function() d.selectSchool(d.schoolID) end}"/>
        </ForEach>
        <ForEach flowDirection="left_to_right" key="typeName" value="typeID" from="{spellTypes}">
            <Button text="${return d.getText(d.typeName, d.typeID, d.selectedType)}" mouseClick="${return function() d.selectType(d.typeID) end}"/>
        </ForEach>
    </Block>
]], function(attributes, data)
    local current = {
        spellType = tes3.spellType.spell,
        schoolID = -1,
        effectID = -1,
        hasSeller = false,
        text = ""
    }
    data.spellSchools = tes3.magicSchool
    data.spellTypes = tes3.spellType
    data.getText = getText
    rebuild(attributes, data, current)
    data.selectSchool = function(schoolID)
        if(schoolID == current.schoolID) then
            current.schoolID = -1
        else
            current.schoolID = schoolID
        end
        rebuild(attributes, data, current)
    end
    data.selectType = function(typeID)
        if(typeID == current.spellType) then
            current.spellType = -1
        else
            current.spellType = typeID
        end
        rebuild(attributes, data, current)
    end
    data.changeFilter = function(element, event)
        current.text = element.text
        rebuild(attributes, data, current)
    end
    data.selectEffect = function(effect)
        if(effect == nil) then
            current.effectID = -1
        else
            current.effectID = effect.id
        end
        rebuild(attributes, data, current)
    end
    data.setHasSeller = function(newValue)
        current.hasSeller = newValue
        rebuild(attributes, data, current)
    end
end)
return filter