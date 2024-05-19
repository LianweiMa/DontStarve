local Widget = require "widgets/widget"
local Attribute = require("widgets/attribute")
local FoodAttributeWidget = Class(Widget, function(self, range, pos, tags)
    Widget._ctor(self, "FoodAttributeWidget")
    self.w=range.w
    self.h=range.h
    self.x=pos.x
    self.y=pos.y
    self.tags=tags
    --画一个背景
    self.root = self:AddChild(Widget("ROOT"))
    self.root:SetPosition(self.x,self.y)
    --foodtypeattribute
    self.root.foodtypeattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["foodtype"].name or "foodtype", tostring(self.tags["foodtype"].value) or "?"))
        local width_foodtypeattribute,height_foodtypeattribute=self.root.foodtypeattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*.6 / width_foodtypeattribute)
        local scale_y = math.min(1, (self.h*.25)*.6 / height_foodtypeattribute)
        self.root.foodtypeattribute:SetSize(scale_x*width_foodtypeattribute, scale_y*height_foodtypeattribute)
        width_foodtypeattribute,height_foodtypeattribute=self.root.foodtypeattribute:GetSize()
        print("foodtypeattribute_wh:"..tostring(width_foodtypeattribute)..","..tostring(height_foodtypeattribute))
        local x_foodtypeattribute=-self.w*.5+width_foodtypeattribute*.5
        local y_foodtypeattribute=self.h*.5-height_foodtypeattribute*.5
        print("foodtypeattribute_pos:"..tostring(x_foodtypeattribute)..","..tostring(y_foodtypeattribute))
        self.root.foodtypeattribute:SetPosition(x_foodtypeattribute,y_foodtypeattribute)
        --self.root.foodtypeattribute:SetScale(.8)
    --cooktimeattribute
    self.root.cooktimeattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["cooktime"].name or "cooktime", tostring(self.tags["cooktime"].value) or "?"))
        local width_cooktimeattribute,height_cooktimeattribute=self.root.cooktimeattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*.6 / width_cooktimeattribute)
        local scale_y = math.min(1, (self.h*.25)*.6 / height_cooktimeattribute)
        self.root.cooktimeattribute:SetSize(scale_x*width_cooktimeattribute, scale_y*height_cooktimeattribute)
        width_cooktimeattribute,height_cooktimeattribute=self.root.cooktimeattribute:GetSize()
        local x_cooktimeattribute=self.w*.5-width_cooktimeattribute*.5
        local y_cooktimeattribute=y_fruitattribute
        self.root.cooktimeattribute:SetPosition(x_cooktimeattribute,y_cooktimeattribute)
        --self.root.cooktimeattribute:SetScale(.8)
    --meatattribute
    self.root.meatattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["meat"].name or "meat", tostring(self.tags["meat"].value) or "?"))
        local width_meatattribute,height_meatattribute=self.root.meatattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*.6 / width_meatattribute)
        local scale_y = math.min(1, (self.h*.5)*.6 / height_meatattribute)
        self.root.meatattribute:SetSize(scale_x*width_meatattribute, scale_y*height_meatattribute)
        width_meatattribute,height_meatattribute=self.root.meatattribute:GetSize()
        local x_meatattribute=x_fruitattribute
        local y_meatattribute=self.h*.25-height_meatattribute*.5
        self.root.meatattribute:SetPosition(x_meatattribute,y_meatattribute)
        --self.root.meatattribute:SetScale(.8)
    --fishattribute
    self.root.fishattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["fish"].name or "fish", tostring(self.tags["fish"].value) or "?"))
        local width_fishattribute,height_fishattribute=self.root.fishattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*.6 / width_fishattribute)
        local scale_y = math.min(1, (self.h*.5)*.6 / height_fishattribute)
        self.root.fishattribute:SetSize(scale_x*width_fishattribute, scale_y*height_fishattribute)
        width_fishattribute,height_fishattribute=self.root.fishattribute:GetSize()
        local x_fishattribute=x_precookattribute
        local y_fishattribute=y_meatattribute
        self.root.fishattribute:SetPosition(x_fishattribute,y_fishattribute)
        --self.root.fishattribute:SetScale(.8)
    --perishtimeattribute
    self.root.perishtimeattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["perishtime"].name or "perishtime", tostring(self.tags["perishtime"].value) or "?"))
        local width_perishtimeattribute,height_perishtimeattribute=self.root.perishtimeattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*.6 / width_perishtimeattribute)
        local scale_y = math.min(1, (self.h*.25)*.6 / height_perishtimeattribute)
        self.root.perishtimeattribute:SetSize(scale_x*width_perishtimeattribute, scale_y*height_perishtimeattribute)
        width_perishtimeattribute,height_perishtimeattribute=self.root.perishtimeattribute:GetSize()
        print("perishtimeattribute_wh:"..tostring(width_perishtimeattribute)..","..tostring(height_perishtimeattribute))
        local x_perishtimeattribute=x_fruitattribute
        local y_perishtimeattribute=self.h*.5+height_perishtimeattribute*.5
        print("perishtimeattribute_pos:"..tostring(x_perishtimeattribute)..","..tostring(y_perishtimeattribute))
        self.root.perishtimeattribute:SetPosition(x_perishtimeattribute,y_perishtimeattribute)
    --self.root.perishtimeattribute:SetScale(.8)
    --Prohibitattribute
    self.root.prohibitattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["prohibit"].name or "prohibit", tostring(self.tags["prohibit"].value) or "?"))
        local width_prohibitattribute,height_prohibitattribute=self.root.prohibitattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*.6 / width_prohibitattribute)
        local scale_y = math.min(1, (self.h*.25)*.6 / height_prohibitattribute)
        self.root.prohibitattribute:SetSize(scale_x*width_prohibitattribute, scale_y*height_prohibitattribute)
        width_prohibitattribute,height_prohibitattribute=self.root.prohibitattribute:GetSize()
        local x_prohibitattribute=x_precookattribute
        local y_prohibitattribute=y_vprohibitieattribute
        self.root.prohibitattribute:SetPosition(x_prohibitattribute,y_prohibitattribute)
        --self.root.prohibitattribute:SetScale(.8)
    --recipeline
    self.root.monsterattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["monster"].name or "monster", tostring(self.tags["monster"].value) or "?"))
        local width_monsterattribute,height_monsterattribute=self.root.monsterattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*.6 / width_monsterattribute)
        local scale_y = math.min(1, (self.h*.25)*.6 / height_monsterattribute)
        self.root.monsterattribute:SetSize(scale_x*width_monsterattribute, scale_y*height_monsterattribute)
        width_monsterattribute,height_monsterattribute=self.root.monsterattribute:GetSize()
        print("monsterattribute_wh:"..tostring(width_monsterattribute)..","..tostring(height_monsterattribute))
        local x_monsterattribute=x_fruitattribute
        local y_monsterattribute=-self.h*.5+height_monsterattribute*.5
        print("monsterattribute_pos:"..tostring(x_monsterattribute)..","..tostring(y_monsterattribute))
        self.root.monsterattribute:SetPosition(x_monsterattribute,y_monsterattribute)
        --self.root.monsterattribute:SetScale(.8)
    --sweetenerattribute
    self.root.sweetenerattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["sweetener"].name or "sweetener", tostring(self.tags["sweetener"].value) or "?"))
        local width_sweetenerattribute,height_sweetenerattribute=self.root.sweetenerattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*.6 / width_sweetenerattribute)
        local scale_y = math.min(1, (self.h*.25)*.6 / height_sweetenerattribute)
        self.root.sweetenerattribute:SetSize(scale_x*width_sweetenerattribute, scale_y*height_sweetenerattribute)
        width_sweetenerattribute,height_sweetenerattribute=self.root.sweetenerattribute:GetSize()
        local x_sweetenerattribute=x_precookattribute
        local y_sweetenerattribute=y_monsterattribute
        self.root.sweetenerattribute:SetPosition(x_sweetenerattribute,y_sweetenerattribute)
        --self.root.sweetenerattribute:SetScale(.8)
end)
return FoodAttributeWidget