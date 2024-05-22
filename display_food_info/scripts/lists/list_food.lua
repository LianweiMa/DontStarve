require "lists/list_func"
local cooking = require("cooking")

local roundsg = function(value) return math.floor(value * 10 + 0.5) / 10 end

local function GetIngredientList()
    local list_ingredient = {name = {zh=List(),en=List()}, tag = {type=List(),hunger=List(),health=List(),sanity=List()}, attribute=List()}
    local attribute={}
    attribute.default="default"
    -- 遍历所有的食材。
    for k, v in pairs(cooking.ingredients) do
        local item = SpawnPrefab(k) --生成物品
        if item then
            local item_components = item.components
            if item_components then
                local i_c_e = item_components.edible
                if i_c_e then -- 如果物品是可食用的
                    -- 获取食物的饥饿值、生命值和精神值，并四舍五入
                    list_ingredient.name.en:add(k)
                    list_ingredient.name.zh:add(STRINGS.NAMES[string.upper(k)] or "")
                    list_ingredient.tag.health:add(roundsg(i_c_e:GetHealth(item)))
                    list_ingredient.tag.hunger:add(roundsg(i_c_e:GetHunger(item)))
                    list_ingredient.tag.sanity:add(roundsg(i_c_e:GetSanity(item)))
                    list_ingredient.tag.type:add(i_c_e.foodtype)
                    if v.tags then
                        list_ingredient.attribute:add(v.tags)
                    else        
                        list_ingredient.attribute:add(attribute)
                        --[[local attribute={}
                        for tag,tagval in pairs(v.tags)do
                            attribute[tag]=tagval
                            --table.insert(attribute,{tag,tagval})
                        end
                        list_ingredient.attribute:add(attribute)]]
                    end
                end
            end
        end 
        
    end
    
    return list_ingredient
end

local function GetFoodList()
    local list_food = {name = {zh=List(),en=List()}, tag = {type=List(),hunger=List(),health=List(),sanity=List()}, attribute={name=List(),value=List()}}
    -- 遍历所有的食谱。
    for cooker, v in pairs(cooking.recipes) do
        -- 遍历这个烹饪设备可以制作的所有食物，并将这些食物的信息添加到字符串中。
        if cooker == "portablecookpot" then
            for name, recipe in pairs(v) do
                -- 获取食物的饥饿值、生命值和精神值
                list_food.name.en:add(name)
                list_food.name.zh:add(STRINGS.NAMES[string.upper(name)] or "")
                list_food.tag.health:add(recipe.health)
                list_food.tag.hunger:add(recipe.hunger)
                list_food.tag.sanity:add(recipe.sanity)
                list_food.tag.type:add(recipe.foodtype)     
                list_food.attribute.name:add("perishtime")
                list_food.attribute.value:add(recipe.perishtime)
                list_food.attribute.name:add("cooktime")
                list_food.attribute.value:add(recipe.cooktime)
                list_food.attribute.name:add("ingredients")
                list_food.attribute.value:add(recipe.card_def.ingredients)

            end
        end       
    end
    return list_food
end

return {GetIngredientList=GetIngredientList,GetFoodList=GetFoodList}
