--modmain.lua

local foodinfo_screen = GLOBAL.require("screens/foodinfo_screen")

-- 加载图像资源
Assets = {
    Asset("ATLAS", "images/inventoryimages/back.xml"), 
    Asset("IMAGE", "images/inventoryimages/back.tex"),
    Asset("ATLAS", "images/inventoryimages/bg.xml"),
    Asset("IMAGE", "images/inventoryimages/bg.tex"),
    Asset("ATLAS", "images/inventoryimages/next.xml"),
    Asset("IMAGE", "images/inventoryimages/next.tex"),
    Asset("ATLAS", "images/inventoryimages/slotbg_fresh.xml"),
    Asset("IMAGE", "images/inventoryimages/slotbg_fresh.tex"),
    Asset("ATLAS", "images/inventoryimages/slotbg_normal.xml"),
    Asset("IMAGE", "images/inventoryimages/slotbg_normal.tex"),
    Asset("ATLAS", "images/inventoryimages/title_food.xml"),
    Asset("IMAGE", "images/inventoryimages/title_food.tex")
}

GLOBAL.TheInput:AddKeyHandler(function(key, down)
    -- 检查按下的键是否是 F3 键
   if (key == GLOBAL.KEY_F3 and not down) then
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
            TheFrontEnd:PushScreen(foodinfo_screen())
            return true
        else
            -- If the screen is already open, close it
            if screen.name == "FoodInfoScreen" then
                screen:Close()
            end
        end
    end
end)
