local Widget = require "widgets/widget"
local Attribute = require("widgets/attribute")
local RecipeAttribute = require("widgets/recipeattribute")
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
    local s=.75
    --foodtypeattribute
    self.root.foodtypeattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["foodtype"].name or "foodtype", tostring(self.tags["foodtype"].value) or "?"))
        local width_foodtypeattribute,height_foodtypeattribute=self.root.foodtypeattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*s / width_foodtypeattribute)
        local scale_y = math.min(1, (self.h*.25)*s / height_foodtypeattribute)
        local scale=math.min(scale_x,scale_y)
        self.root.foodtypeattribute:SetScale(scale)
        --self.root.foodtypeattribute:SetSize(scale_x*width_foodtypeattribute, scale_y*height_foodtypeattribute)
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
        local scale_x = math.min(1, (self.w*.5)*s / width_cooktimeattribute)
        local scale_y = math.min(1, (self.h*.25)*s / height_cooktimeattribute)
        local scale=math.min(scale_x,scale_y)
        self.root.cooktimeattribute:SetScale(scale)
        --self.root.cooktimeattribute:SetSize(scale_x*width_cooktimeattribute, scale_y*height_cooktimeattribute)
        width_cooktimeattribute,height_cooktimeattribute=self.root.cooktimeattribute:GetSize()
        local x_cooktimeattribute=self.w*.5-width_cooktimeattribute*.5
        local y_cooktimeattribute=y_foodtypeattribute
        self.root.cooktimeattribute:SetPosition(x_cooktimeattribute,y_cooktimeattribute)      
    --perishtimeattribute
    self.root.perishtimeattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["perishtime"].name or "perishtime", tostring(self.tags["perishtime"].value) or "?"))
        local width_perishtimeattribute,height_perishtimeattribute=self.root.perishtimeattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*s / width_perishtimeattribute)
        local scale_y = math.min(1, (self.h*.5)*s / height_perishtimeattribute)
        local scale=math.min(scale_x,scale_y)
        self.root.perishtimeattribute:SetScale(scale)
        --self.root.perishtimeattribute:SetSize(scale_x*width_perishtimeattribute, scale_y*height_perishtimeattribute)
        width_perishtimeattribute,height_perishtimeattribute=self.root.perishtimeattribute:GetSize()
        local x_perishtimeattribute=x_foodtypeattribute
        local y_perishtimeattribute=self.h*.25-height_perishtimeattribute*.5
        self.root.perishtimeattribute:SetPosition(x_perishtimeattribute,y_perishtimeattribute)
        --self.root.perishtimeattribute:SetScale(.8)
    --prohibitattribute
    self.root.prohibitattribute = self.root:AddChild(Attribute(NEWFONT, 30, self.tags["prohibit"].name or "prohibit", tostring(self.tags["prohibit"].value) or "?"))
        local width_prohibitattribute,height_prohibitattribute=self.root.prohibitattribute:GetSize()
        local scale_x = math.min(1, (self.w*.5)*s / width_prohibitattribute)
        local scale_y = math.min(1, (self.h*.5)*s / height_prohibitattribute)
        local scale=math.min(scale_x,scale_y)
        self.root.prohibitattribute:SetScale(scale)
        --self.root.prohibitattribute:SetSize(scale_x*width_prohibitattribute, scale_y*height_prohibitattribute)
        width_prohibitattribute,height_prohibitattribute=self.root.prohibitattribute:GetSize()
        local x_prohibitattribute=x_cooktimeattribute
        local y_prohibitattribute=y_perishtimeattribute
        self.root.prohibitattribute:SetPosition(x_prohibitattribute,y_prohibitattribute)
        --self.root.prohibitattribute:SetScale(.8)   
    --recipelineattribute
    self.root.recipelineattribute = self.root:AddChild(Attribute(NEWFONT, 30, "recipe", "","images/quagmire_recipebook.xml","quagmire_recipe_line_short.tex"))
        local width_recipelineattribute,height_recipelineattribute=self.root.recipelineattribute:GetSize()
        local scale_x = math.min(1, (self.w)*s / width_recipelineattribute)
        --local scale_y = math.min(1, (self.h*.25)*s / height_recipelineattribute)
        --local scale=math.min(scale_x,scale_y)
        self.root.recipelineattribute:SetScale(scale_x)
        --self.root.recipelineattribute:SetSize(scale_x*width_recipelineattribute, scale_y*height_recipelineattribute)
        width_recipelineattribute,height_recipelineattribute=self.root.recipelineattribute:GetSize()
        --print("recipelineattribute_wh:"..tostring(width_recipelineattribute)..","..tostring(height_recipelineattribute))
        local x_recipelineattribute=0
        local y_recipelineattribute=-height_recipelineattribute*.5
        --print("recipelineattribute_pos:"..tostring(x_recipelineattribute)..","..tostring(y_recipelineattribute))
        self.root.recipelineattribute:SetPosition(x_recipelineattribute,y_recipelineattribute)      
    --recipeattribute
    self.root.recipeattribute = self.root:AddChild(RecipeAttribute({w=width_recipelineattribute,h=self.h*.25},NEWFONT, 30))
        local width_recipeattribute,height_recipeattribute=self.root.recipeattribute:GetSize()
        --[[local scale_x = math.min(1, (self.w*.5)*.6 / width_recipeattribute)
        local scale_y = math.min(1, (self.h*.25)*.6 / height_recipeattribute)
        self.root.recipeattribute:SetSize(scale_x*width_recipeattribute, scale_y*height_recipeattribute)
        width_recipeattribute,height_recipeattribute=self.root.recipeattribute:GetSize()]]
        local x_recipeattribute=0
        local y_recipeattribute=y_recipelineattribute-height_recipeattribute*.5
        self.root.recipeattribute:SetPosition(x_recipeattribute,y_recipeattribute)
        --self.root.recipeattribute:SetScale(.8)
end)

function FoodAttributeWidget:IniAttribute()
    self.root.foodtypeattribute:SetDownText("nil")
    self.root.cooktimeattribute:SetDownText("nil")
    self.root.perishtimeattribute:SetDownText("nil")
    self.root.prohibitattribute:SetDownText("nil")
    self.root.recipeattribute:SetDefaultAttribute()
end

function FoodAttributeWidget:SetAttribute(attribute)
    --[[print("prefabattribute.lua:type:"..type(attribute))
    for tag,tagval in pairs(attribute)do
        print("prefabattribute.lua:attribute:"..tag..","..tostring(tagval))
    end]]
    self:IniAttribute()
    self.root.foodtypeattribute:SetDownText(STRINGS.NAMES[string.upper(attribute["foodtype"])] or attribute["foodtype"] or "nil")
    self.root.cooktimeattribute:SetDownText(tostring(attribute["cooktime"]*20).."秒" or "nil")
    self.root.perishtimeattribute:SetDownText(tostring(attribute["perishtime"]/480).."天" or "永久")
    self.root.prohibitattribute:SetDownText(STRINGS.NAMES[string.upper(attribute["prohibit"])] or attribute["prohibit"] or "nil")
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
    local name=""
    local text=""
    local i=1
    if attribute["ingredients"] then 
        -- {meat = {value=2.5,sign=">="}, fish =  {value=1.5,sign=">="}}
        -- {{drumstick={value=1,sign=">"}, meat={value=1,sign=">"}, veggie={value=0.5,sign=">="}},{drumstick={value=1,sign=">"}, meat={value=1,sign=">"}, fruit={value=0.5,sign=">="}}}
        for k,v in pairs(attribute["ingredients"]) do--k=meat,--v={value=2.5,sign=">="}//--k=0,1--v={meat = {value=2.5,sign=">="}, fish =  {value=1.5,sign=">="}}
            --k=meat//v={value=2.5,sign=">="}
            --k=0//v={drumstick={value=1,sign=">"}, meat={value=1,sign=">"}, veggie={value=0.5,sign=">="}}
            if type(k)=="number" then
                --kk=drumstick//vv={value=1,sign=">"}
                for kk,vv in pairs(v) do--vv=2.5//vv={value=2.5,sign=">="}
                    name=kk
                    text=text..(STRINGS.NAMES[string.upper(kk)] or kk)..vv.sign..tostring(vv.value).."\t"
                    self.root.recipeattribute:SetAttribute(i,STRINGS.NAMES[string.upper(name)] or name,"images/inventoryimages.xml",name..".tex")
                    i=i+1
                    print(text)
                end
            else
                name=k
                text=text..(STRINGS.NAMES[string.upper(k)] or k)..v.sign..tostring(v.value).."\t"
                self.root.recipeattribute:SetAttribute(i,STRINGS.NAMES[string.upper(name)] or name,"images/inventoryimages.xml",name..".tex")
                i=i+1
                print(text) 
            end           
        end  

    else
        self.root.recipeattribute:SetDefaultAttribute()
    end
    self.root.recipelineattribute:SetUpText(text)
end

return FoodAttributeWidget