local Screen = require "widgets/screen" -- 引入"widgets/screen"模块
local Widget = require "widgets/widget"
local ImageButton = require "widgets/imagebutton"
local cooking = require("cooking")
local roundsg = function(value) return math.floor(value * 10 + 0.5) / 10 end
local FoodInfoButton = Class(Screen, function(self, ower)
    Screen._ctor(self, "FoodInfoButton") -- 构造函数，创建一个名为"FoodInfoButton"的屏幕
    self.ower = ower 
    --画一个背景
     self.root = self:AddChild(Widget("ROOT"))
        self.root:SetVAnchor(ANCHOR_MIDDLE)
        self.root:SetHAnchor(ANCHOR_MIDDLE)
        local w_hud, h_hud = TheSim:GetScreenSize()
        self.root:SetPosition(-w_hud*.25, h_hud*.25) 
     --添加一个背景
     self.root.bg = self.root:AddChild(ImageButton("images/inventoryimages/food_act_cn.xml", "food_act_cn.tex"))
        self.root.bg:SetPosition(0, 0) 
        self.root.bg:SetNormalScale(1,1,1)
        self.root.bg:SetFocusScale(1,1,1)
        self.root.bg:SetOnGainFocus(function() self.root.bg:ScaleTo(1,1.15,.125) end)
        self.root.bg:SetOnLoseFocus(function() self.root.bg:ScaleTo(1.15,1,.25) end)
        self.root.bg:SetOnClick(function()
            local foodinfo='ingredients = {\n'
            -- 遍历所有的食材。
            for k, v in pairs(cooking.ingredients) do
                local item = SpawnPrefab(k) --生成物品
                if item then
                    local item_components = item.components
                    if item_components then
                        local i_c_e = item_components.edible
                        if i_c_e then -- 如果物品是可食用的
                            -- 获取食物的饥饿值、生命值和精神值，并四舍五入
                            local name_cn=STRINGS.NAMES[string.upper(k)] or ""
                            local health=tostring(roundsg(i_c_e:GetHealth(item)))
                            local hunger=tostring(roundsg(i_c_e:GetHunger(item)))
                            local sanity=tostring(roundsg(i_c_e:GetSanity(item)))
                            local type=i_c_e.foodtype
                            foodinfo=foodinfo..'{ name = \"'..k..'\", '..'name_cn = \"'..name_cn..'\", '..'health = '..health..', '..'hunger = '..hunger..', '..'sanity = '..sanity..', '
                            if v.tags then
                                for tag,tagval in pairs(v.tags)do
                                    foodinfo=foodinfo..tag..' = '..tostring(tagval)..', '
                                end
                            end
                            foodinfo=foodinfo..'type = '..type..' }, \n'
                        end
                    end
                end                    
            end
            foodinfo=foodinfo..'}\n'
            -- 遍历所有的食谱。
            for cooker, v in pairs(cooking.recipes) do
                -- 遍历这个烹饪设备可以制作的所有食物，并将这些食物的信息添加到字符串中。
                if cooker == "portablecookpot" then
                    foodinfo=foodinfo..'recipes = {\n'
                    for name, recipe in pairs(v) do
                        -- 获取食物的饥饿值、生命值和精神值
                        local name_cn=STRINGS.NAMES[string.upper(name)] or ""
                        local health=tostring(recipe.health)
                        local hunger=tostring(recipe.hunger)
                        local sanity=tostring(recipe.sanity)
                        local type=recipe.foodtype or  ""
                        local perishtime=tostring(recipe.perishtime)
                        local cooktime=tostring(recipe.cooktime)    
                        foodinfo=foodinfo..'{name = \"'..name..'\", '..'name_cn = \"'..name_cn..'\", '..'health = '..health..', '..'hunger = '..hunger..', '..'sanity = '..sanity..', '..'type = '..type..', '..'perishtime = '..perishtime..', '..'cooktime = '..cooktime..', '
                        foodinfo=foodinfo..'ingredients = {}, prohibit = {} }, \n'
                    end
                end
            end
            foodinfo=foodinfo..'}'
            TheSim:SetPersistentString("foodinfo.lua",foodinfo)
        end)                  
end)
function FoodInfoButton:Close()
    TheFrontEnd:PopScreen(self) -- 当取消时，弹出当前屏幕
end

return FoodInfoButton -- 返回FoodInfoButton类


