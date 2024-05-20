local Widget = require "widgets/widget"
local Image = require "widgets/image"
local Text = require "widgets/text"
local FoodInfoTitleWidget = Class(Widget, function(self, fonttype, scale)
    Widget._ctor(self, "FoodInfoTitleWidget")
    self.fonttype = fonttype
    self.scale = scale
    --self.x=0
    --self.y=0
    --画一个背景
    self.root = self:AddChild(Widget("ROOT"))
    --self.root:SetPosition(self.x,self.y)
    --title
    self.root.titlebg = self.root:AddChild(Image("images/quagmire_recipebook.xml", "cookbook_missing.tex"))
    local width_titlebg,height_titlebg=self.root.titlebg:GetSize()
    local x_title=0
    local y_title=0
    --print(x_title,y_title)
    self.root.titlebg:SetPosition(x_title,y_title)
    self.root.titlebg:SetScale(scale,scale)
        self.root.titlebg.text=self.root.titlebg:AddChild(Text(self.fonttype, height_titlebg, ""))
        self.root.titlebg.text:SetColour({255,255,255,255})
        self.root.titlebg.text:SetPosition(0,0)
        --self.root.titlebg.text:SetScale(.99,.99)
    --breakline
    self.root.breakline = self.root:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_line_break.tex"))
        local width_breakline,height_breakline=self.root.breakline:GetSize()
        local x_breakline=x_title
        local y_breakline=y_title-height_titlebg/2
        --print(x_breakline,y_breakline)
        self.root.breakline:SetPosition(x_breakline,y_breakline)
        self.root.breakline:SetRotation(180)
        self.root.breakline:SetScale(scale,scale)
end)

function FoodInfoTitleWidget:GetSize()
    local width_titlebg,height_titlebg=self.root.titlebg:GetSize()
    local width_breakline,height_breakline=self.root.breakline:GetSize()
    return math.max(width_titlebg,width_breakline), height_titlebg+height_breakline
end

function FoodInfoTitleWidget:SetPosition(x,y)
    self.root:SetPosition(x,y)
end

return FoodInfoTitleWidget