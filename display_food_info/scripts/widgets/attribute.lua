local Widget = require "widgets/widget"
local Text = require "widgets/text"
local AttributeWidget = Class(Widget, function(self, font, size, upstring, downstring, alts, tex)
    Widget._ctor(self, "AttributeWidget")
    self.fontsize = size
    self.font = font
    self.upstring = upstring
    self.downstring = downstring
    self.alts = alts or "images/quagmire_recipebook.xml"
    self.tex = tex or "quagmire_recipe_line_veryshort.tex"
    self.x=0
    self.y=0
    self:Init()
end)

function AttributeWidget:Init()
    self:KillAllChildren()
    --画一个背景
    self.root = self:AddChild(Widget("ROOT"))
    --self.root:SetVAnchor(ANCHOR_MIDDLE)
    --self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(self.x,self.y)
    --splitline
    self.root.splitline = self.root:AddChild(Image(self.alts, self.tex))
    local w_splitline,h_splitline = self.root.splitline:GetSize()
    self.root.splitline:SetPosition(0,0)
    self.root.uptext = self.root:AddChild(Text(self.font, self.fontsize, self.upstring,{0,0,0,1}))
    local w_uptext,h_uptext=self.root.uptext:GetRegionSize()
    self.root.uptext:SetPosition(0,h_uptext*.5)
    self.root.downtext = self.root:AddChild(Text(self.font, self.fontsize, self.downstring,{0,0,0,1}))
    local w_downtext,h_downtext=self.root.downtext:GetRegionSize()
    self.root.downtext:SetPosition(0,-h_downtext*.5)

    --[[添加一个背景
        self.root.bg = self.root:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_menu_block.tex")) 
        self.root.bg:SetSize(w_splitline,h_splitline)
        self.root.bg:SetPosition(0,0)]]
end

function AttributeWidget:SetUpText(str)
    self.root.uptext:SetString(str)
end

function AttributeWidget:SetDownText(str)
    self.root.downtext:SetString(str)
end

function AttributeWidget:GetSize()
    local w, h = self.root.splitline:GetSize()
    return w, h
end

function AttributeWidget:GetScaledSize()
    local w, h = self.root.splitline:GetScaledSize()
    return w, h
end

function AttributeWidget:SetSize(w,h)
    self.root.splitline:SetSize(w,h)
end

function AttributeWidget:SetPosition(x,y)
    self.root:SetPosition(x,y)
end

function AttributeWidget:SetScale(scale)
    self.root.splitline:SetScale(scale,scale)
end

function AttributeWidget:SetColour(colour)
    self.root.downtext:SetColour(colour)
end

return AttributeWidget