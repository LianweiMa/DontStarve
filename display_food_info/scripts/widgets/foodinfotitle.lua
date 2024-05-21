local Widget = require "widgets/widget"
local Image = require "widgets/image"
local Text = require "widgets/text"
local FoodInfoTitleWidget = Class(Widget, function(self, range, fonttype, scale)
    Widget._ctor(self, "FoodInfoTitleWidget")
    self.w=range.w
    self.h=range.h
    self.fonttype = fonttype
    self.scale = scale
    --print("foodinfotitle.lua:scale:"..tostring(self.scale))
    --self.x=0
    --self.y=0
    --画一个背景
    self.root = self:AddChild(Widget("ROOT"))
    --self.root:SetPosition(self.x,self.y)
    --title
    self.root.titlebg = self.root:AddChild(Image("images/quagmire_recipebook.xml", "cookbook_missing.tex"))
    self.root.titlebg:SetScale(self.scale*.5,self.scale*.5)
    local width_titlebg,height_titlebg=self.root.titlebg:GetScaledSize()
    --print("foodinfotitle.lua:self.root.titlebg:size:"..tostring(width_titlebg)..","..tostring(height_titlebg))
    local x_title=0
    local y_title=0
    --print(x_title,y_title)
    self.root.titlebg:SetPosition(x_title,y_title)  

    --[[添加一个背景
    self.root.titlebg.bg = self.root.titlebg:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_menu_block.tex")) 
    self.root.titlebg.bg:SetSize(width_titlebg,height_titlebg)
    self.root.titlebg.bg:SetPosition(0,0)]]

        self.root.titlebg.text=self.root.titlebg:AddChild(Text(self.fonttype, height_titlebg, ""))
        self.root.titlebg.text:SetColour({255,255,255,255})
        self.root.titlebg.text:SetPosition(0,0)
        --self.root.titlebg.text:SetScale(.99,.99)
    --breakline
    self.root.breakline = self.root:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_line_break.tex"))
        local width_breakline,height_breakline=self.root.breakline:GetSize()
        local scale_breakline=1
        if width_breakline>self.w then
            scale_breakline=self.w/width
        end
        self.root.breakline:SetScale(scale_breakline,scale_breakline)
        --local width_breakline,height_breakline=self.root.breakline:GetScaledSize()
        local x_breakline=x_title
        local y_breakline=y_title-height_titlebg*.5-height_titlebg*.5
        --print(x_breakline,y_breakline)
        self.root.breakline:SetPosition(x_breakline,y_breakline)
        self.root.breakline:SetRotation(180)
        
end)

function FoodInfoTitleWidget:GetSize()
    local width_titlebg,height_titlebg=self.root.titlebg:GetSize()
    local width_breakline,height_breakline=self.root.breakline:GetSize()
    return math.max(width_titlebg,width_breakline), height_titlebg+height_breakline
end

function FoodInfoTitleWidget:GetScaledSize()
    local width_titlebg,height_titlebg=self.root.titlebg:GetScaledSize()
    local width_breakline,height_breakline=self.root.breakline:GetScaledSize()
    local _,titlebgy,_=self.root.titlebg:GetPositionXYZ()
    local _,breakliney,_=self.root.breakline:GetPositionXYZ()
    return math.max(width_titlebg,width_breakline), height_titlebg*.5+height_breakline*.5+titlebgy-breakliney
end

function FoodInfoTitleWidget:SetPosition(x,y)
    self.root:SetPosition(x,y)
end

function FoodInfoTitleWidget:SetString(str)
    self.root.titlebg.text:SetString(str)
end

function FoodInfoTitleWidget:SetTexture(alts,tex)
    self.root.titlebg:SetTexture(alts,tex)
end

return FoodInfoTitleWidget