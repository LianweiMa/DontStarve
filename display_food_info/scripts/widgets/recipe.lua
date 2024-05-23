local Widget = require "widgets/widget"
local Image = require "widgets/image"
local Text = require "widgets/text"
local RecipeImage = require("widgets/recipeimage")
local Recipe = Class(Widget, function(self, range, fonttype, fontsize)
    Widget._ctor(self, "Recipe")
    self.w=range.w
    self.h=range.h
    --print("recipe.lua:range:"..tostring(self.w)..","..tostring(self.h))
    self.fonttype = fonttype
    self.fontsize = fontsize
    --self.x=0`
    --self.y=0
    --画一个背景
    self.root = self:AddChild(Widget("ROOT"))
    --self.root:SetPosition(self.x,self.y)
    --添加一个背景
    self.root.bg = self.root:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_menu_block.tex")) 
    self.root.bg:SetSize(self.w,self.h)
    self.root.bg:SetPosition(0,0)
    local gap_x=10
    local gap_y=10
    --prefab1
    self.root.prefab1 = self.root:AddChild(RecipeImage(NEWFONT))
    local width_prefab1,height_prefab1=self.root.prefab1:GetSize()
    self.root.prefab1:SetPosition(-self.w*.5+width_prefab1*.5,0)
    --print("recipe.lua:self.root.prefab1:size:"..tostring(width_prefab1)..","..tostring(height_prefab1))
    --prefab2
    self.root.prefab2 = self.root:AddChild(RecipeImage(NEWFONT))
    local width_prefab2,height_prefab2=self.root.prefab2:GetSize()
    self.root.prefab2:SetPosition(-self.w*.25+width_prefab2*.5,0)
    --prefab3
    self.root.prefab3 = self.root:AddChild(RecipeImage(NEWFONT))
    local width_prefab3,height_prefab3=self.root.prefab3:GetSize()
    self.root.prefab3:SetPosition(width_prefab3*.5,0)
    --prefab4
    self.root.prefab4 = self.root:AddChild(RecipeImage(NEWFONT))
    local width_prefab4,height_prefab4=self.root.prefab4:GetSize()
    self.root.prefab4:SetPosition(self.w*.25+width_prefab4*.5,0)
end)

function Recipe:GetSize()
    return self.w,self.h
end

function Recipe:SetPosition(x,y)
    self.root:SetPosition(x,y)
end

function Recipe:SetAttribute(index,name,alts,tex)
    if index==1 then
        self.root.prefab1:SetTexture(alts,tex)
        self.root.prefab1:SetString(name)
    elseif index==2 then
        self.root.prefab2:SetTexture(alts,tex)
        self.root.prefab2:SetString(name)
    elseif index==3 then
        self.root.prefab3:SetTexture(alts,tex)
        self.root.prefab3:SetString(name)
    elseif index==4 then
        self.root.prefab4:SetTexture(alts,tex)
        self.root.prefab4:SetString(name)
    end    
end

function Recipe:SetDefaultAttribute()

    local name=""
    local alts="images/quagmire_recipebook.xml"
    local tex="blank.tex"
    self.root.prefab1:SetTexture(alts,tex)
    self.root.prefab1:SetString(name)

    self.root.prefab2:SetTexture(alts,tex)
    self.root.prefab2:SetString(name)

    self.root.prefab3:SetTexture(alts,tex)
    self.root.prefab3:SetString(name)

    self.root.prefab4:SetTexture(alts,tex)
    self.root.prefab4:SetString(name)

end

function Recipe:SetTexture(alts,tex)
    self.root.prefab.img:SetTexture(alts,tex)
end

function Recipe:SetHealthValue(value)
    self.root.health:SetString(value)
end

function Recipe:SetHealthColour(colour)
    self.root.health:SetColour(colour)
end

function Recipe:SetHungerValue(value)
    self.root.hunger:SetString(value)
end

function Recipe:SetHungerColour(colour)
    self.root.hunger:SetColour(colour)
end

function Recipe:SetSanityValue(value)
    self.root.sanity:SetString(value)
end

function Recipe:SetSanityColour(colour)
    self.root.sanity:SetColour(colour)
end

function Recipe:SetScale(scale)
    self.root.prefab.img:SetScale(scale,scale)
end

function Recipe:SetAttribute(attribute)
    self.root.attribute:SetDownText(attribute)
end

return Recipe