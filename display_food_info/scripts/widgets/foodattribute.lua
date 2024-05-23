local Widget = require "widgets/widget"
local Attribute = require("widgets/attribute")
local Recipe = require("widgets/recipe")
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
        --print("foodtypeattribute_wh:"..tostring(width_foodtypeattribute)..","..tostring(height_foodtypeattribute))
        local x_foodtypeattribute=-self.w*.5+width_foodtypeattribute*.5
        local y_foodtypeattribute=self.h*.5-height_foodtypeattribute*.5
        --print("foodtypeattribute_pos:"..tostring(x_foodtypeattribute)..","..tostring(y_foodtypeattribute))
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
        local y_cooktimeattribute=y_foodtypeattribute
        self.root.cooktimeattribute:SetPosition(x_cooktimeattribute,y_cooktimeattribute)
        --self.root.cooktimeattribute:SetScale(.8)
    --perishtimeattribute
    self.root.perishtimeattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["perishtime"].name or "perishtime", tostring(self.tags["perishtime"].value) or "?"))
        local width_perishtimeattribute,height_perishtimeattribute=self.root.perishtimeattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*.6 / width_perishtimeattribute)
        local scale_y = math.min(1, (self.h*.5)*.6 / height_perishtimeattribute)
        self.root.perishtimeattribute:SetSize(scale_x*width_perishtimeattribute, scale_y*height_perishtimeattribute)
        width_perishtimeattribute,height_perishtimeattribute=self.root.perishtimeattribute:GetSize()
        local x_perishtimeattribute=x_foodtypeattribute
        local y_perishtimeattribute=self.h*.25-height_perishtimeattribute*.5
        self.root.perishtimeattribute:SetPosition(x_perishtimeattribute,y_perishtimeattribute)
        --self.root.perishtimeattribute:SetScale(.8)
    --prohibitattribute
    self.root.prohibitattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["prohibit"].name or "prohibit", tostring(self.tags["prohibit"].value) or "?"))
        local width_prohibitattribute,height_prohibitattribute=self.root.prohibitattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*.6 / width_prohibitattribute)
        local scale_y = math.min(1, (self.h*.5)*.6 / height_prohibitattribute)
        self.root.prohibitattribute:SetSize(scale_x*width_prohibitattribute, scale_y*height_prohibitattribute)
        width_prohibitattribute,height_prohibitattribute=self.root.prohibitattribute:GetSize()
        local x_prohibitattribute=x_cooktimeattribute
        local y_prohibitattribute=y_perishtimeattribute
        self.root.prohibitattribute:SetPosition(x_prohibitattribute,y_prohibitattribute)
        --self.root.prohibitattribute:SetScale(.8)   
    --recipelineattribute
    self.root.recipelineattribute = self.root:AddChild(Attribute(NEWFONT, 30, "recipe", ""))
        local width_recipelineattribute,height_recipelineattribute=self.root.recipelineattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*.6 / width_recipelineattribute)
        local scale_y = math.min(1, (self.h*.25)*.6 / height_recipelineattribute)
        self.root.recipelineattribute:SetSize(scale_x*width_recipelineattribute, scale_y*height_recipelineattribute)
        width_recipelineattribute,height_recipelineattribute=self.root.recipelineattribute:GetSize()
        --print("recipelineattribute_wh:"..tostring(width_recipelineattribute)..","..tostring(height_recipelineattribute))
        local x_recipelineattribute=0
        local y_recipelineattribute=-self.h*.5+height_recipelineattribute*.5
        --print("recipelineattribute_pos:"..tostring(x_recipelineattribute)..","..tostring(y_recipelineattribute))
        self.root.recipelineattribute:SetPosition(x_recipelineattribute,y_recipelineattribute)
        --self.root.recipelineattribute:SetScale(.8)
    --recipeattribute
    self.root.recipeattribute = self.root:AddChild(Recipe({w=self.w,h=self.h*.25},NEWFONT, 30))
        local width_recipeattribute,height_recipeattribute=self.root.recipeattribute:GetSize()
        --[[local scale_x = math.min(1, (self.w*.5)*.6 / width_recipeattribute)
        local scale_y = math.min(1, (self.h*.25)*.6 / height_recipeattribute)
        self.root.recipeattribute:SetSize(scale_x*width_recipeattribute, scale_y*height_recipeattribute)
        width_recipeattribute,height_recipeattribute=self.root.recipeattribute:GetSize()]]
        local x_recipeattribute=0
        local y_recipeattribute=-self.h*.25-height_recipeattribute*.5
        self.root.recipeattribute:SetPosition(x_recipeattribute,y_recipeattribute)
        --self.root.recipeattribute:SetScale(.8)
end)

function FoodAttributeWidget:SetAttribute(attribute)
    --[[print("prefabattribute.lua:type:"..type(attribute))
    for tag,tagval in pairs(attribute)do
        print("prefabattribute.lua:attribute:"..tag..","..tostring(tagval))
    end]]
    self.root.foodtypeattribute:SetDownText(attribute["foodtype"] or "nil")
    self.root.cooktimeattribute:SetDownText(attribute["cooktime"] or "nil")
    self.root.perishtimeattribute:SetDownText(attribute["perishtime"] or "nil")
    self.root.prohibitattribute:SetDownText(attribute["prohibit"] or "nil")
    if attribute["foodtype"] then       
        self.root.foodtypeattribute:SetColour({255,0,0,1})
    else
        self.root.foodtypeattribute:SetColour({0,0,0,1})
    end
    if attribute["cooktime"] then       
        self.root.cooktimeattribute:SetColour({255,0,0,1})
    else
        self.root.cooktimeattribute:SetColour({0,0,0,1})
    end
    if attribute["perishtime"] then        
        self.root.perishtimeattribute:SetColour({255,0,0,1})
    else
        self.root.perishtimeattribute:SetColour({0,0,0,1})
    end
    if attribute["prohibit"] then         
        self.root.prohibitattribute:SetColour({255,0,0,1})
    else
        self.root.prohibitattribute:SetColour({0,0,0,1})
    end
    if attribute["ingredients"] then  
        for k,v in pairs(attribute["ingredients"]) do
            for kk,vv in pairs(v) do
                for i=1,vv do
                    self.root.recipeattribute:SetAttribute(i,kk,"images/inventoryimages.xml",kk..".tex")
                end
            end
        end       
    else
        self.root.recipeattribute:SetDefaultAttribute()
    end
    
end

return FoodAttributeWidget