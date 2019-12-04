local Memoize = import("darkcraft.dev.util.Memoize")

local IngredientDataHelper = {}

IngredientDataHelper.getIngredients = Memoize.noArgs(function()
    local ingredients = {}
    for ingredient in tes3.iterateObjects(tes3.objectType.ingredient) do
        table.insert(ingredients, ingredient)
    end
    return ingredients
end)

return IngredientDataHelper