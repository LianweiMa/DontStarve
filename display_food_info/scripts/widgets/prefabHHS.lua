local Widget = require "widgets/widget"
local Image = require "widgets/image"
local Text = require "widgets/text"
local HHS = require("widgets/hhs")
local Attribute = require("widgets/attribute")
local PrefabHHSWidget = Class(Widget, function(self, range, fonttype, fontsize)
    Widget._ctor(self, "PrefabHHSWidget")
    self.w=range.w
    self.h=range.h
    --print("prefabHHS.lua:range:"..tostring(self.w)..","..tostring(self.h))
    self.fonttype = fonttype
    self.fontsize = fontsize
    --self.x=0`
    --self.y=0
    --画一个背景
    self.root = self:AddChild(Widget("ROOT"))
    --self.root:SetPosition(self.x,self.y)
    --[[添加一个背景
    self.root.bg = self.root:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_menu_block.tex")) 
    self.root.bg:SetSize(self.w,self.h)
    self.root.bg:SetPosition(0,0)]]
    local gap_x=10
    local gap_y=10
    --prefab
    self.root.prefab = self.root:AddChild(Image("images/quagmire_recipebook.xml", "cookbook_known.tex"))
    local width_prefab,height_prefab=self.root.prefab:GetSize()
    --print("prefabHHS.lua:self.root.prefab:size:"..tostring(width_prefab)..","..tostring(height_prefab))
    --health
    self.root.health = self.root:AddChild(HHS(NEWFONT,"images/global_redux.xml", "status_health.tex"))
    local width_health,height_health=self.root.health:GetSize()
    --print("prefabHHS.lua:self.root.health:size:"..tostring(width_health)..","..tostring(height_health))
    --hunger
    self.root.hunger = self.root:AddChild(HHS(NEWFONT,"images/global_redux.xml", "status_hunger.tex"))
    local width_hunger,height_hunger=self.root.hunger:GetSize()
    --sanity
    self.root.sanity = self.root:AddChild(HHS(NEWFONT,"images/global_redux.xml", "status_sanity.tex"))
    local width_sanity,height_sanity=self.root.sanity:GetSize()
    --attribute
    self.root.attribute = self.root:AddChild(Attribute(self.fonttype, self.fontsize, "type", "?"))
    local width_attribute,height_attribute=self.root.attribute:GetSize()
    --print("prefabHHS.lua:self.root.attribute:size:"..tostring(width_attribute)..","..tostring(height_attribute))
    local width=gap_x+width_prefab+gap_x+math.max((width_health+gap_x+width_hunger+gap_x+width_sanity+gap_x),width_attribute)
    --local height=math.max(height_prefab,math.max(math.max(height_health,height_hunger),height_sanity)+height_attribute+gap_y)
    --print("prefabHHS.lua:wh:"..tostring(width)..","..tostring(height))
    
    
    local scale_prefab=math.min(self.w/width,1)
    local scale_health=math.min(height_prefab/(height_health+height_attribute),1)  


    --print("prefabHHS.lua:scale_prefab:"..tostring(scale_prefab))
    --print("prefabHHS.lua:scale_health:"..tostring(scale_health))
    width=gap_x+width_prefab*scale_prefab+gap_x+math.max((width_health*scale_health+gap_x+width_hunger*scale_health+gap_x+width_sanity*scale_health+gap_x),width_attribute*scale_health)
    --prefab
        self.root.prefab:SetScale(scale_prefab,scale_prefab)--Image
        width_prefab,height_prefab=self.root.prefab:GetScaledSize()
        local x_prefab = (self.w-width)*.5-self.w*.5+width_prefab*.5
        local y_prefab=0
        local scaleinprefab=.8
        --print(x_prefab,y_prefab)
        self.root.prefab:SetPosition(x_prefab,y_prefab)
            self.root.prefab.img=self.root.prefab:AddChild(Image("images/quagmire_recipebook.xml", "cookbook_missing.tex"))
            local width_prefabimg,height_prefabimg=self.root.prefab.img:GetSize()
            local scale_prefabimg=math.min(width_prefab*scaleinprefab/width_prefabimg,1)
            self.root.prefab.img:SetScale(scale_prefabimg,scale_prefabimg)
    --health
        --[[self.root.health = self.root:AddChild(Image("images/global_redux.xml", "status_health.tex"))
            local att_gap=10
            local health_fontsize=48                
            local width_health,height_health=self.root.health:GetSize()
            local scale = math.min(1, (width_foodinfo-width_prefab)*.6 / ((width_health-att_gap)*3))
            self.root.health:SetSize(scale*width_health, scale*height_health)
            width_health=width_health*scale
            height_health=height_health*scale]]
            --width_health,height_health=self.root.health:GetSize()
            --print("scale:"..tostring(scale).."health:"..tostring(width_health)..tostring(height_health))
            self.root.health:SetScale(scale_health)
            width_health,height_health=self.root.health:GetSize()
            --width_health=width_health*scale_health
            --height_health=height_health*scale_health
            --print("prefabHHS.lua:self.root.health:scaledsize:"..tostring(width_health)..","..tostring(height_health))
            local x_health = x_prefab+width_prefab/2+width_health/2+gap_x*2
            local y_health = height_prefab*.5-height_health*.5
            --print(x_health,y_health)
            self.root.health:SetPosition(x_health,y_health)        
                --[[self.root.health.textbg = self.root.health:AddChild(Image("images/global_redux.xml", "value_gold.tex"))
                local width_textbg,height_textbg=self.root.health.textbg:GetSize()
                local scale_textbg = math.min(1, width_health*.9 / width_textbg)
                self.root.health.textbg:SetSize(scale_textbg*width_textbg,scale_textbg*height_textbg)
                width_textbg,height_textbg=self.root.health.textbg:GetSize()
                self.root.health.textbg:SetPosition(0,-height_health/2-height_textbg/2)
                self.root.health.textbg.text=self.root.health.textbg:AddChild(Text(NEWFONT, health_fontsize, ""))
                self.root.health.textbg.text:SetColour({0,0,0,1})]]
    --hunger
        --[[self.root.hunger = self.root:AddChild(Image("images/global_redux.xml", "status_hunger.tex"))
            --local width_hunger,height_hunger=self.root.hunger:GetSize()
            local width_hunger=width_health
            local height_hunger=height_health
            self.root.hunger:SetSize(width_hunger, height_hunger)
            --width_hunger,height_hunger=self.root.hunger:GetSize()
            --print("scale:"..tostring(scale).."hunger:"..tostring(width_hunger)..tostring(height_hunger))]]
            self.root.hunger:SetScale(scale_health)
            width_hunger,height_hunger=self.root.hunger:GetSize()
            local x_hunger=x_health+width_health/2+width_hunger/2+gap_x
            local y_hunger = y_health
            --print(x_hunger,y_hunger)
            self.root.hunger:SetPosition(x_hunger,y_hunger)
            
                --[[self.root.hunger.textbg = self.root.hunger:AddChild(Image("images/global_redux.xml", "value_gold.tex"))
                self.root.hunger.textbg:SetPosition(0,-height_hunger/2-height_textbg/2)
                local width_textbg2,height_textbg2=self.root.hunger.textbg:GetSize()
                self.root.hunger.textbg:SetSize(scale_textbg*width_textbg2,scale_textbg*height_textbg2)
                width_textbg2,height_textbg2=self.root.hunger.textbg:GetSize()
                self.root.hunger.textbg.text=self.root.hunger.textbg:AddChild(Text(NEWFONT, health_fontsize, ""))
                self.root.hunger.textbg.text:SetColour({0,0,0,1})]]
    --sanity
        --[[self.root.sanity = self.root:AddChild(Image("images/global_redux.xml", "status_sanity.tex"))
            --local width_sanity,height_sanity=self.root.sanity:GetSize()
            local width_sanity=width_health
            local height_sanity=height_health
            self.root.sanity:SetSize(width_sanity, height_sanity)]]
            self.root.sanity:SetScale(scale_health)
            width_sanity,height_sanity=self.root.sanity:GetSize()
            local x_sanity=x_hunger+width_hunger/2+width_sanity/2+gap_x
            local y_sanity=y_health
            --print(x_sanity,y_sanity)
            self.root.sanity:SetPosition(x_sanity,y_sanity)
            
                --[[self.root.sanity.textbg = self.root.sanity:AddChild(Image("images/global_redux.xml", "value_gold.tex"))
                self.root.sanity.textbg:SetPosition(0,-height_sanity/2-height_textbg/2)
                local width_textbg3,height_textbg3=self.root.sanity.textbg:GetSize()
                self.root.sanity.textbg:SetSize(scale_textbg*width_textbg3,scale_textbg*height_textbg3)
                width_textbg3,height_textbg3=self.root.sanity.textbg:GetSize()
                self.root.sanity.textbg.text=self.root.sanity.textbg:AddChild(Text(NEWFONT, health_fontsize, ""))
                self.root.sanity.textbg.text:SetColour({0,0,0,1})]]
    --attribute
        self.root.attribute:SetScale(scale_health*.8)
        width_attribute,height_attribute=self.root.attribute:GetScaledSize()
        --print("prefabHHS.lua:self.root.attribute:scaledsize:"..tostring(width_attribute)..","..tostring(height_attribute))
        local x_attribute=x_hunger
        local y_attribute=y_health-height_health*.5-height_attribute*.5-------------------------------------------------------------------
        --print(x_sanity,y_sanity)
        self.root.attribute:SetPosition(x_attribute,y_attribute)
        
        --[[local line_fontsize=health_fontsize+8
        self.root.shortline = self.root:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_line_short.tex"))
            local width_shortline,height_shortline=self.root.shortline:GetSize()              
            local scale_x = math.min(1, (width_foodinfo-width_prefab)*.9 / width_shortline)
            local scale_y = math.min(1, (height_foodinfo-height_prefab)*.9 / height_shortline)
            self.root.shortline:SetSize(scale_x*width_shortline, scale_y*height_shortline)
            width_shortline,height_shortline=self.root.shortline:GetSize()
            local x_shortline=x_hunger
            local y_shortline=y_hunger-height_hunger/2-height_textbg/2-height_shortline/2
            self.root.shortline:SetPosition(x_shortline,y_shortline)
            --self.root.shortline:SetScale(.8)]]
end)

function PrefabHHSWidget:GetSize()
    return self.w,self.h
end

function PrefabHHSWidget:SetPosition(x,y)
    self.root:SetPosition(x,y)
end

function PrefabHHSWidget:SetTexture(alts,tex)
    self.root.prefab.img:SetTexture(alts,tex)
end

function PrefabHHSWidget:SetHealthValue(value)
    self.root.health:SetString(value)
end

function PrefabHHSWidget:SetHealthColour(colour)
    self.root.health:SetColour(colour)
end

function PrefabHHSWidget:SetHungerValue(value)
    self.root.hunger:SetString(value)
end

function PrefabHHSWidget:SetHungerColour(colour)
    self.root.hunger:SetColour(colour)
end

function PrefabHHSWidget:SetSanityValue(value)
    self.root.sanity:SetString(value)
end

function PrefabHHSWidget:SetSanityColour(colour)
    self.root.sanity:SetColour(colour)
end

function PrefabHHSWidget:SetScale(scale)
    self.root.prefab.img:SetScale(scale,scale)
end

function PrefabHHSWidget:SetAttribute(attribute)
    self.root.attribute:SetDownText(attribute)
end

return PrefabHHSWidget