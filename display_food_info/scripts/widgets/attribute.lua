local Widget = require "widgets/widget"
local Text = require "widgets/text"
local AttributeWidget = Class(Widget, function(self, font, size, upstring, downstring)
    Widget._ctor(self, "AttributeWidget")
    self.fontsize = size
    self.font = font
    self.upstring = upstring
    self.downstring = downstring
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
    self.root.splitline = self.root:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_line_veryshort.tex"))
    local _,h_splitline = self.root.splitline:GetSize()
    self.root.splitline:SetPosition(0,0)
    self.root.uptext = self.root:AddChild(Text(self.font, self.fontsize, self.upstring,{0,0,0,1}))
    self.root.uptext:SetPosition(0,(self.fontsize)*.5)
    self.root.downtext = self.root:AddChild(Text(self.font, self.fontsize, self.downstring,{0,0,0,1}))
    self.root.downtext:SetPosition(0,-(self.fontsize)*.5)
end

function AttributeWidget:SetUpText(str)
    self.root.uptext:SetText(str)
end

function AttributeWidget:SetDownText(str)
    self.root.downtext:SetText(str)
end

function AttributeWidget:GetSize()
    local w, h = self.root.splitline:GetSize()
    return w, h+self.fontsize*2
end

function AttributeWidget:GetScaledSize()
    local w, h = self.root.splitline:GetScaledSize()
    return w, h+self.fontsize*2
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


return AttributeWidget