local base = import("darkcraft.dev.ui.renderer.base")

local function getTop3Skills(npc)
    local skills = {}
    for i,v in pairs(npc.skills) do
        table.insert(skills, {name=tes3.skillName[i], value=v})
    end
    table.sort(skills, function(a,b) return a.value > b.value end)
    return {skills[1], skills[2], skills[3]}
end

local NpcTrainerElement = base.xml:extend([[
    <Block visible="{isTrainer}" autoWidth="true" autoHeight="true">
        <Block width="150" autoHeight="true">
            <Label text="Trains:" />
        </Block>
        <ForEach from="{skills}" value="skill" flowDirection="top_to_bottom">
            <Unpack from="{skill}" id="skill">
                <FieldLabel fieldLabel="{skill#name}" fieldWidth="100" fieldValue="{skill#value}" />
            </Unpack>
        </ForEach>
    </Block>
]], function(attributes, data)
    local npc = attributes.npc
    local class = npc.class
    local ref = tes3.getReference(npc)
    data.isTrainer = class.offersTraining
    data.skills = getTop3Skills(npc)
end)

return NpcTrainerElement