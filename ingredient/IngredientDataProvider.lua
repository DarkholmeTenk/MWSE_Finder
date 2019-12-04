local Memoize = import("darkcraft.dev.util.Memoize")

local IngredientDataProvider = {}

IngredientDataProvider.getIngredients = Memoize.noArgs(function()
    local ingredients = {}
    for ingredient in tes3.iterateObjects(tes3.objectType.ingredient) do
        table.insert(ingredients, ingredient)
    end
    return ingredients
end)

IngredientDataProvider.hasEffect = function(ingredient, effectID)
    if(effectID == -1) then return true end
    for i,v in pairs(ingredient.effects) do
        if(v == effectID) then return true end
    end
    return false
end

return IngredientDataProvider