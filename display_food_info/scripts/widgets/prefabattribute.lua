local Widget = require "widgets/widget"
local Attribute = require("widgets/attribute")
local PrefabAttributeWidget = Class(Widget, function(self, range, pos, tags)
    Widget._ctor(self, "PrefabAttributeWidget")
    self.w=range.w
    self.h=range.h
    --print("range_wh:"..tostring(self.w)..","..tostring(self.h))
    self.x=pos.x
    self.y=pos.y
    --print("pos:"..tostring(self.x)..","..tostring(self.y))
    self.tags=tags
    --画一个背景
    self.root = self:AddChild(Widget("ROOT"))
    self.root:SetPosition(self.x,self.y)
    local s=.75
    --fruitattribute
    self.root.fruitattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["fruit"].name or "fruit", tostring(self.tags["fruit"].value) or "?"))
        local width_fruitattribute,height_fruitattribute=self.root.fruitattribute:GetSize()
        --print("src_fruitattribute_wh:"..tostring(width_fruitattribute)..","..tostring(height_fruitattribute))
        local scale_x = math.min(1, (self.w*.5)*s / width_fruitattribute)
        local scale_y = math.min(1, (self.h*.25)*s / height_fruitattribute)
        local scale=math.min(scale_x,scale_y)
        --print("scale:"..tostring(scale))
        self.root.fruitattribute:SetScale(scale)
        --self.root.fruitattribute:SetSize(scale*width_fruitattribute, scale*height_fruitattribute)
        width_fruitattribute,height_fruitattribute=self.root.fruitattribute:GetSize()
        --print("fruitattribute_wh:"..tostring(width_fruitattribute)..","..tostring(height_fruitattribute))
        local x_fruitattribute=-self.w*.5+width_fruitattribute*.5
        local y_fruitattribute=self.h*.5-height_fruitattribute*.5
        --print("fruitattribute_pos:"..tostring(x_fruitattribute)..","..tostring(y_fruitattribute))
        self.root.fruitattribute:SetPosition(x_fruitattribute,y_fruitattribute)
        --self.root.fruitattribute:SetScale(.8)
    --precookattribute
    self.root.precookattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["precook"].name or "precook", tostring(self.tags["precook"].value) or "?"))
        local width_precookattribute,height_precookattribute=self.root.precookattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*s / width_precookattribute)
        local scale_y = math.min(1, (self.h*.25)*s / height_precookattribute)
        local scale=math.min(scale_x,scale_y)
        self.root.precookattribute:SetScale(scale)
        --self.root.precookattribute:SetSize(scale*width_precookattribute, scale*height_precookattribute)
        width_precookattribute,height_precookattribute=self.root.precookattribute:GetSize()
        local x_precookattribute=self.w*.5-width_precookattribute*.5
        local y_precookattribute=y_fruitattribute
        self.root.precookattribute:SetPosition(x_precookattribute,y_precookattribute)
        --self.root.precookattribute:SetScale(.8)
    --meatattribute
    self.root.meatattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["meat"].name or "meat", tostring(self.tags["meat"].value) or "?"))
        local width_meatattribute,height_meatattribute=self.root.meatattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*s / width_meatattribute)
        local scale_y = math.min(1, (self.h*.25)*s / height_meatattribute)
        local scale=math.min(scale_x,scale_y)
        self.root.meatattribute:SetScale(scale)
        --self.root.meatattribute:SetSize(scale*width_meatattribute, scale*height_meatattribute)
        width_meatattribute,height_meatattribute=self.root.meatattribute:GetSize()
        local x_meatattribute=x_fruitattribute
        local y_meatattribute=self.h*.25-height_meatattribute*.5
        self.root.meatattribute:SetPosition(x_meatattribute,y_meatattribute)
        --self.root.meatattribute:SetScale(.8)
    --fishattribute
    self.root.fishattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["fish"].name or "fish", tostring(self.tags["fish"].value) or "?"))
        local width_fishattribute,height_fishattribute=self.root.fishattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*s / width_fishattribute)
        local scale_y = math.min(1, (self.h*.25)*s / height_fishattribute)
        local scale=math.min(scale_x,scale_y)
        self.root.fishattribute:SetScale(scale)
        --self.root.fishattribute:SetSize(scale*width_fishattribute, scale*height_fishattribute)
        width_fishattribute,height_fishattribute=self.root.fishattribute:GetSize()
        local x_fishattribute=x_precookattribute
        local y_fishattribute=y_meatattribute
        self.root.fishattribute:SetPosition(x_fishattribute,y_fishattribute)
        --self.root.fishattribute:SetScale(.8)
    --veggieattribute
    self.root.veggieattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["veggie"].name or "veggie", tostring(self.tags["veggie"].value) or "?"))
        local width_veggieattribute,height_veggieattribute=self.root.veggieattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*s / width_veggieattribute)
        local scale_y = math.min(1, (self.h*.25)*s / height_veggieattribute)
        local scale=math.min(scale_x,scale_y)
        self.root.veggieattribute:SetScale(scale)
        --self.root.veggieattribute:SetSize(scale*width_veggieattribute, scale*height_veggieattribute)
        width_veggieattribute,height_veggieattribute=self.root.veggieattribute:GetSize()
        --print("veggieattribute_wh:"..tostring(width_veggieattribute)..","..tostring(height_veggieattribute))
        local x_veggieattribute=x_fruitattribute
        local y_veggieattribute=-height_veggieattribute*.5
        --print("veggieattribute_pos:"..tostring(x_veggieattribute)..","..tostring(y_veggieattribute))
        self.root.veggieattribute:SetPosition(x_veggieattribute,y_veggieattribute)
    --self.root.veggieattribute:SetScale(.8)
    --eggattribute
    self.root.eggattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["egg"].name or "egg", tostring(self.tags["egg"].value) or "?"))
        local width_eggattribute,height_eggattribute=self.root.eggattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*s / width_eggattribute)
        local scale_y = math.min(1, (self.h*.25)*s / height_eggattribute)
        local scale=math.min(scale_x,scale_y)
        self.root.eggattribute:SetScale(scale)
        --self.root.eggattribute:SetSize(scale*width_eggattribute, scale*height_eggattribute)
        width_eggattribute,height_eggattribute=self.root.eggattribute:GetSize()
        local x_eggattribute=x_precookattribute
        local y_eggattribute=y_veggieattribute
        self.root.eggattribute:SetPosition(x_eggattribute,y_eggattribute)
        --self.root.eggattribute:SetScale(.8)
    --monsterattribute
    self.root.monsterattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["monster"].name or "monster", tostring(self.tags["monster"].value) or "?"))
        local width_monsterattribute,height_monsterattribute=self.root.monsterattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*s / width_monsterattribute)
        local scale_y = math.min(1, (self.h*.25)*s / height_monsterattribute)
        local scale=math.min(scale_x,scale_y)
        self.root.monsterattribute:SetScale(scale)
        --self.root.monsterattribute:SetSize(scale*width_monsterattribute, scale*height_monsterattribute)
        width_monsterattribute,height_monsterattribute=self.root.monsterattribute:GetSize()
        --print("monsterattribute_wh:"..tostring(width_monsterattribute)..","..tostring(height_monsterattribute))
        local x_monsterattribute=x_fruitattribute
        local y_monsterattribute=-self.h*.25-height_monsterattribute*.5
        --print("monsterattribute_pos:"..tostring(x_monsterattribute)..","..tostring(y_monsterattribute))
        self.root.monsterattribute:SetPosition(x_monsterattribute,y_monsterattribute)
        --self.root.monsterattribute:SetScale(.8)
    --sweetenerattribute
    self.root.sweetenerattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["sweetener"].name or "sweetener", tostring(self.tags["sweetener"].value) or "?"))
        local width_sweetenerattribute,height_sweetenerattribute=self.root.sweetenerattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*s / width_sweetenerattribute)
        local scale_y = math.min(1, (self.h*.25)*s / height_sweetenerattribute)
        local scale=math.min(scale_x,scale_y)
        self.root.sweetenerattribute:SetScale(scale)
        --self.root.sweetenerattribute:SetSize(scale*width_sweetenerattribute, scale*height_sweetenerattribute)
        width_sweetenerattribute,height_sweetenerattribute=self.root.sweetenerattribute:GetSize()
        local x_sweetenerattribute=x_precookattribute
        local y_sweetenerattribute=y_monsterattribute
        self.root.sweetenerattribute:SetPosition(x_sweetenerattribute,y_sweetenerattribute)
        --self.root.sweetenerattribute:SetScale(.8)
end)

function PrefabAttributeWidget:SetAttribute(attribute)
    --[[print("prefabattribute.lua:type:"..type(attribute))
    for tag,tagval in pairs(attribute)do
        print("prefabattribute.lua:attribute:"..tag..","..tostring(tagval))
    end]]
    self.root.fruitattribute:SetDownText(attribute["fruit"] or "nil")
    self.root.precookattribute:SetDownText(attribute["precook"] or "nil")
    self.root.meatattribute:SetDownText(attribute["meat"] or "nil")
    self.root.fishattribute:SetDownText(attribute["fish"] or "nil")
    self.root.veggieattribute:SetDownText(attribute["veggie"] or "nil")
    self.root.eggattribute:SetDownText(attribute["egg"] or "nil")
    self.root.monsterattribute:SetDownText(attribute["monster"] or "nil") 
    self.root.sweetenerattribute:SetDownText(attribute["sweetener"] or "nil") 
    if attribute["fruit"] then       
        self.root.fruitattribute:SetColour({255,0,0,1})
    else
        self.root.fruitattribute:SetColour({0,0,0,1})
    end
    if attribute["precook"] then       
        self.root.precookattribute:SetColour({255,0,0,1})
    else
        self.root.precookattribute:SetColour({0,0,0,1})
    end
    if attribute["meat"] then        
        self.root.meatattribute:SetColour({255,0,0,1})
    else
        self.root.meatattribute:SetColour({0,0,0,1})
    end
    if attribute["fish"] then         
        self.root.fishattribute:SetColour({255,0,0,1})
    else
        self.root.fishattribute:SetColour({0,0,0,1})
    end
    if attribute["veggie"] then       
        self.root.veggieattribute:SetColour({255,0,0,1})
    else
        self.root.veggieattribute:SetColour({0,0,0,1})
    end
    if attribute["egg"] then       
        self.root.eggattribute:SetColour({255,0,0,1})
    else
        self.root.eggattribute:SetColour({0,0,0,1})
    end
    if attribute["monster"] then       
        self.root.monsterattribute:SetColour({255,0,0,1})
    else
        self.root.monsterattribute:SetColour({0,0,0,1})
    end 
    if attribute["sweetener"] then        
        self.root.sweetenerattribute:SetColour({255,0,0,1})
    else
        self.root.sweetenerattribute:SetColour({0,0,0,1})
    end 
end

return PrefabAttributeWidget