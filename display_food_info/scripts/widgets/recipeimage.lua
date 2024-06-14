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
    self.root.bg:SetPosition(0,0)
    local width_bg,height_bg=self.root.bg:GetSize()
    --print("recipeimage.lua:self.root.bg:"..tostring(width_bg)..","..tostring(height_bg))
    --self.root.textbg:SetSize(width_textbg*self.scale,height_textbg*self.scale)
    self.root.bg.img=self.root.bg:AddChild(Image(self.alts, self.tex))
    self.root.bg.img:SetPosition(0,0)
    self.root.text=self.root:AddChild(Text(self.fonttype, 30, self.text ))
    local _,height_text=self.root.text:GetRegionSize()     
    self.root.text:SetColour(self.colour)
    self.root.text:SetPosition(0,-height_bg*.5-height_text*.5)
    --print("recipeimage.lua"..tostring(-height_bg*.5-height_text*.5))
end)

function RecipeImage:GetSize()
    local w1,h1=self.root.bg:GetSize()
    local _,h2=self.root.text:GetRegionSize()
    return w1,h1+h2
end

function RecipeImage:SetScale(scale)
    self.root.bg:SetScale(scale)
    local width_bg,height_bg=self.root.bg:GetScaledSize()
    local _,height_text=self.root.text:GetRegionSize()
    self.root.text:SetPosition(0,-height_bg*.5-height_text*.5)
end

function RecipeImage:SetPosition(x,y)
    self.root:SetPosition(x,y)
end


function RecipeImage:SetString(text)
    self.text=text
    self.root.text:SetString(text)
end

function RecipeImage:SetColour(colour)
    self.colour=colour
    self.root.text:SetColour(colour)
end

function RecipeImage:SetTexture(alts,tex)
    self.alts = alts
    self.tex = tex
    self.root.bg.img:SetTexture(alts,tex)
end

return RecipeImage