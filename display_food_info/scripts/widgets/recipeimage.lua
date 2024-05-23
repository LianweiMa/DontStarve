local Widget = require "widgets/widget"
local Image = require "widgets/image"
local Text = require "widgets/text"
local RecipeImage = Class(Widget, function(self, fonttype, text, alts, tex)
    Widget._ctor(self, "RecipeImage")
    self.fonttype = fonttype
    self.text = text or ""
    self.alts = alts or "images/quagmire_recipebook.xml"
    self.tex = tex or "cookbook_missing.tex"
    self.scale = 1
    self.colour = {0,0,0,1}
    
    self.root=self:AddChild(Widget("ROOT"))
    self.root.bg=self.root:AddChild(Image("images/quagmire_recipebook.xml", "cookbook_known.tex"))
    local width_bg,height_bg=self.root.bg:GetSize()
    --self.root.textbg:SetSize(width_textbg*self.scale,height_textbg*self.scale)
    self.root.bg.img=self.root:AddChild(Image(self.alts, self.tex))
    self.root.bg.img:SetPosition(0,0)
    self.root.bg.text=self.root.bg:AddChild(Text(self.fonttype, 30, self.text ))       
    self.root.bg.text:SetColour(self.colour)
    
end)

function RecipeImage:SetSize(w,h)
    self.root.textbg:SetSize(w,h)
end

function RecipeImage:GetSize()
    local w1,h1=self.root.bg:GetSize()
    local w2,h2=self.root.bg.text:GetRegionSize()
    return w1+w2,h1+h2
end

function RecipeImage:GetScaledSize()
    local w,h=self.root.textbg:GetScaledSize()
    return w,h
end

function RecipeImage:SetPosition(x,y)
    self.root:SetPosition(x,y)
end

function RecipeImage:SetScale(scale)
    self.scale=scale
    self:Init()
end

function RecipeImage:SetString(text)
    self.text=text
    self.root.bg.text:SetString(text)
end

function RecipeImage:SetColour(colour)
    self.colour=colour
    self.root.bg.text:SetColour(colour)
end

function RecipeImage:SetTexture(alts,tex)
    self.alts = alts
    self.tex = tex
    self.root.bg.img:SetTexture(alts,tex)
end

return RecipeImage