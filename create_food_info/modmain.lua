local foodinfo_button = GLOBAL.require("screens/foodinfo_button")

-- 加载图像资源
Assets = {
    Asset("ATLAS", "images/inventoryimages/food_act_cn.xml"), 
    Asset("IMAGE", "images/inventoryimages/food_act_cn.tex")
}

GLOBAL.TheInput:AddKeyHandler(function(key, down)
    -- 检查按下的键是否是 F1 键
   if (key == GLOBAL.KEY_F1 and not down) then
        local screen = TheFrontEnd:GetActiveScreen()    
        --print("screen name : "..screen.name)  
        -- End if we can't find the screen name (e.g. asleep)
        if not screen or not screen.name then 
            --print("not screen or not screen.name")
            return true 
        end
        -- If the hud exists, open the UI
        if screen.name:find("HUD") then
            -- We want to pass in the (clientside) player entity         
            TheFrontEnd:PushScreen(foodinfo_button())
            return true
        else
            -- If the screen is already open, close it
            if screen.name == "FoodInfoButton" then
                screen:Close()
            end
        end
    end
end)