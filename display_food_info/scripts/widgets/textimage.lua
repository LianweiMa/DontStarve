local Widget = require "widgets/widget"
local Image = require "widgets/image"
local Text = require "widgets/text"
local TextImage = Class(Widget, function(self, fonttype, text, alts, tex)
    Widget._ctor(self, "TextImage")
    self.fonttype = fonttype
    self.text = text or ""
    self.alts = alts or "images/global_redux.xml"
    self.tex = tex or "value_gold.tex"
    self.scale = 1
    self.colour = {0,0,0,1}
    
    self.root = self:AddChild(Widget("ROOT"))
    self:Init()
    
end)

function TextImage:Init()
    self.root:KillAllChildren()

    self.root.textbg = self.root:AddChild(Image(self.alts, self.tex))
    local width_textbg,height_textbg=self.root.textbg:GetSize()
    self.root.textbg:SetSize(width_textbg*self.scale,height_textbg*self.scale)
    self.root.textbg.text=self.root.textbg:AddChild(Text(self.fonttype, height_textbg*self.scale*.9, self.text ))       
    self.root.textbg.text:SetColour(self.colour)
end

function TextImage:SetSize(w,h)
    self.root.textbg:SetSize(w,h)
end

function TextImage:GetSize()
    local w,h=self.root.textbg:GetSize()
    return w,h
end

function TextImage:GetScaledSize()
    local w,h=self.root.textbg:GetScaledSize()
    return w,h
end

function TextImage:SetPosition(x,y)
    self.root:SetPosition(x,y)
end

function TextImage:SetScale(scale)
    self.scale=scale
    self:Init()
end

function TextImage:SetString(text)
    self.text=text
    self.root.textbg.text:SetString(text)
end

function TextImage:SetColour(colour)
    self.colour=colour
    self.root.textbg.text:SetColour(colour)
end

function TextImage:SetTexture(alts,tex)
    self.alts = alts
    self.tex = tex
    self.root.textbg:SetTexture(alts,tex)
end

return TextImage