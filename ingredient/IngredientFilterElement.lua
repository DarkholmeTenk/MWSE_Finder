local base = import("darkcraft.dev.ui.renderer.base")
local IngredientDataProvider = import("darkcraft.finder.ingredient.IngredientDataProvider")

local function buildFilter(current)
    return function(ingredient)
        return IngredientDataProvider.hasEffect(ingredient, current.effectID)
    end
end

local IngredientFilterElement = base.xml:extend([[
    <Block autoWidth="true" autoHeight="true">
        <EffectSelector onChange="{selectEffect}" selected="{selectedEffectID}"/>
    </Block>
]], function(attributes, data)
    local current = {
        effectID = -1
    }

    local function rebuild()
        data.selectedEffectID = current.effectID
        attributes.onChange(buildFilter(current))
    end
    rebuild()

    data.selectEffect = function(effect)
        current.effectID = effect and effect.id or -1
        rebuild()
    end
end)

return IngredientFilterElement