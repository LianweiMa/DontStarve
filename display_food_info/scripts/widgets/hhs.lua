local Widget = require "widgets/widget"
local Image = require "widgets/image"
local Text = require "widgets/text"
local TextImage = require("widgets/textimage")
local HHSWidget = Class(Widget, function(self, fonttype, alts, tex)
    Widget._ctor(self, "HHSWidget")
    self.fonttype = fonttype
    self.alts = alts
    self.tex = tex
    self.scale = 1
    --self.x=0
    --self.y=0
    --画一个背景
    self.root = self:AddChild(Widget("ROOT"))
    --self.root:SetPosition(self.x,self.y)
    self:Init()
end)

function HHSWidget:Init()
    self.root:KillAllChildren()
    --hhs            
    self.root.hhs = self.root:AddChild(Image(self.alts, self.tex))--"images/global_redux.xml", "status_hunger.tex"
    --local att_gap=10
    --local hhs_fontsize=48
    local width_hhs,height_hhs=self.root.hhs:GetSize()
    print("hhs.lua:self.root.hhs:src_wh:"..tostring(width_hhs)..","..tostring(height_hhs))
    --local scale = math.min(1, (width_foodinfo-width_prefab)*.6 / ((width_hhs-att_gap)*3))
    self.root.hhs:SetSize(self.scale*width_hhs, self.scale*height_hhs)
    print("hhs.lua:scale:"..tostring(self.scale))
    --self.root.hhs:SetScale(self.scale, self.scale)
    width_hhs,height_hhs=self.root.hhs:GetSize()
    print("hhs.lua:self.root.hhs:scale_wh:"..tostring(width_hhs)..","..tostring(height_hhs))
    --width_hhs,height_hhs=self.root.hhs:GetSize()
    --print("scale:"..tostring(scale).."hhs:"..tostring(width_hhs)..tostring(height_hhs))
    local x_hhs = 0
    local y_hhs = 0
    --print(x_hhs,y_hhs)
    self.root.hhs:SetPosition(x_hhs,y_hhs)

    self.root.hhs.textbg = self.root.hhs:AddChild(TextImage(self.fonttype, "?"))
    local width_textbg,height_textbg=self.root.hhs.textbg:GetSize()
    local scale_textbg = math.min(1, width_hhs*.8 / width_textbg)
    self.root.hhs.textbg:SetScale(scale_textbg)
    width_textbg,height_textbg=self.root.hhs.textbg:GetSize()
    self.root.hhs.textbg:SetPosition(0,-height_hhs*.5-height_textbg*.5)

    --[[添加一个背景
    self.root.bg = self.root:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_menu_block.tex")) 
    self.root.bg:SetSize(width_hhs,height_hhs)
    self.root.bg:SetPosition(0,0)]]

    --[[self.root.hhs:SetScale(scale,scale) 
        self.root.hhs.textbg = self.root.hhs:AddChild(Image("images/global_redux.xml", "value_gold.tex"))
        local width_textbg,height_textbg=self.root.hhs.textbg:GetSize()
        print("hhs.lua:self.root.hhs.textbg:src_wh:"..tostring(width_textbg)..","..tostring(height_textbg))
        local scale_textbg = math.min(1, width_hhs*.8 / width_textbg)
        print("hhs.lua:self.root.hhs.textbg:scale:"..tostring(scale_textbg))
        --self.root.hhs.textbg:SetScale(scale_textbg,scale_textbg)
        self.root.hhs.textbg:SetSize(scale_textbg*width_textbg,scale_textbg*height_textbg)
        width_textbg,height_textbg=self.root.hhs.textbg:GetSize()]]

        --[[添加一个背景
        self.root.hhs.textbg.bg = self.root.hhs.textbg:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_menu_block.tex")) 
        self.root.hhs.textbg.bg:SetSize(width_textbg,height_textbg)
        self.root.hhs.textbg.bg:SetPosition(0,0)]]
        --[[
        self.root.hhs.textbg:SetPosition(0,-height_hhs*.5-height_textbg*.5)
        print("hhs.lua:self.root.hhs.textbg:scale_wh:"..tostring(width_textbg)..","..tostring(height_textbg))
        self.root.hhs.textbg.text=self.root.hhs.textbg:AddChild(Text(self.fonttype, height_textbg, "?"))
        self.root.hhs.textbg.text:SetColour({0,0,0,1})]]
end

function HHSWidget:GetSize()
    local width_hhs,height_hhs=self.root.hhs:GetSize()
    local width_textbg,height_textbg=self.root.hhs.textbg:GetSize()
    return math.max(width_hhs,width_textbg), height_hhs+height_textbg
end

function HHSWidget:GetScaledSize()
    local width_hhs,height_hhs=self.root.hhs:GetScaledSize()
    local width_textbg,height_textbg=self.root.hhs.textbg:GetScaledSize()
    return math.max(width_hhs,width_textbg), height_hhs+height_textbg
end

function HHSWidget:SetPosition(x,y)
    self.root:SetPosition(x,y)
end

function HHSWidget:SetScale(scale)
    self.scale=scale
    self:Init()
end

function HHSWidget:SetString(str)
    self.root.hhs.textbg:SetString(str)
end

function HHSWidget:SetColour(colour)
    self.root.hhs.textbg:SetColour(colour)
end

return HHSWidget