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
    local list_food = {name = {zh=List(),en=List()}, tag = {type=List(),hunger=List(),health=List(),sanity=List()}, attribute=List()}
    -- 遍历所有的食谱。
    for cooker, v in pairs(cooking.recipes) do
        -- 遍历这个烹饪设备可以制作的所有食物，并将这些食物的信息添加到字符串中。
        if cooker == "portablecookpot" then
            local str=""
            for name, recipe in pairs(v) do
                
                str=str..name..":"
                -- 获取食物的饥饿值、生命值和精神值
                list_food.name.en:add(name)
                list_food.name.zh:add(STRINGS.NAMES[string.upper(name)] or "")
                list_food.tag.health:add(recipe.health)
                list_food.tag.hunger:add(recipe.hunger)
                list_food.tag.sanity:add(recipe.sanity)
                list_food.tag.type:add(recipe.foodtype)     
                local attribute={perishtime=recipe.perishtime,cooktime=recipe.cooktime}--,ingredients=recipe.card_def.ingredients
                list_food.attribute:add(attribute)

                

                for k3,v3 in pairs(recipe)do
                    print(k3,v3)
                    
                    if type(v3)=="table" then
                        for k4,v4 in pairs(v3)do
                            if type(v4)=="table" then
                                for k5,v5 in pairs(v4)do
                                    if type(v5)=="table" then
                                        for k6,v6 in pairs(v5)do
                                            str=str..k6..":"..v6.."\t"
                                        end
                                    else
                                        str=str..k5..":"..v5.."\t"
                                    end
                                end
                            else
                                str=str..k4..":"..v4.."\t"
                            end 
                        end
                    elseif type(v3)=="string" then
                        str=str..k3..":"..v3.."\t" 
                    end
                end
                print("\n")
                str=str.."\n"
            end
            TheSim:SetPersistentString("myrecipe.txt",str)
        end       
    end
    return list_food
end

return {GetIngredientList=GetIngredientList,GetFoodList=GetFoodList}
