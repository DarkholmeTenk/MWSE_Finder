local xmlreader = import("darkcraft.dev.ui.util.xmlreader")
local databind = import("darkcraft.dev.ui.util.databind")
local IngredientDataProvider = import("darkcraft.finder.ingredient.IngredientDataProvider")

local IngredientFinderUI = {}

local ingredientFinderMenuXml = [[
    <Menu id="IngredientFinderUI" width="700" height="900" fixedSize="true"
                dragFrame="true"  absolutePosAlignX="0.5" absolutePosAlignY="0.5"
                text="Ingredient Finder" autoWidth="false" autoHeight="false" flowDirection="top_to_bottom">
        <IngredientFilter onChange="{setFilter}" />
        <Filter from="{ingredients}" to="currentIngredients" filter="{filter}">
            <PagingProvider id="paging" from="{currentIngredients}" to="currentPage">
                <ThinBorder widthProportional="1" heightProportional="1">
                    <ForEach value="ingredient" from="{currentPage}" autoWidth="true" autoHeight="true" flowDirection="top_to_bottom">
                        <Label text="${return d.ingredient.name}" />
                    </ForEach>
                </ThinBorder>
                <Block flowDirection="left_to_right" widthProportional="1" autoHeight="true">
                    <Button text="Back" mouseClick="{paging#prev}" />
                    <Label text="{paging#str}" />
                    <Button text="Next" mouseClick="{paging#next}" />
                </Block>
            </PagingProvider>
        </Filter>
    </Menu>
]]

IngredientFinderUI.open = function(_,_,renderer)
    local data = databind:__wrap{
        ingredients = IngredientDataProvider.getIngredients(),
        filter = function() return true end
    }
    data.setFilter = function(filter) data.filter = filter end
    local xml = xmlreader.parse(ingredientFinderMenuXml)
    renderer:render(nil, xml, data)
end

return IngredientFinderUI