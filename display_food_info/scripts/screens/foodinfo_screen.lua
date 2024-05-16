local Screen = require "widgets/screen" -- 引入"widgets/screen"模块
local Widget = require "widgets/widget"
local Image = require "widgets/image"
local Menu = require "widgets/menu"
local Text = require "widgets/text"
local ImageButton = require "widgets/imagebutton"
local TextEdit = require "widgets/textedit"
local TextButton = require "widgets/textbutton"
local FoodInfoScreen = Class(Screen, function(self, ower)
    Screen._ctor(self, "FoodInfoScreen") -- 构造函数，创建一个名为"FoodInfoScreen"的屏幕
    self.ower = ower 
    self.numpage = 1
    self.title = "ingredient"
    self.prefab = ""
    --画一个背景
     self.root = self:AddChild(Widget("ROOT"))
        self.root:SetVAnchor(ANCHOR_MIDDLE)
        self.root:SetHAnchor(ANCHOR_MIDDLE)
     --添加一个背景
     local w_hud, h_hud = TheSim:GetScreenSize()
     print("TheSim:GetScreenSize():"..tostring(w_hud)..","..tostring(h_hud))
     self.root.bg = self.root:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_menu_bg.tex"))
        self.root.bg:SetPosition(0, 0)
        local width, height = self.root.bg:GetSize()
        local scale_x = math.min(1, w_hud*.75 / (width-100))
        local scale_y = math.min(1, h_hud*.75 / (height-50))
        self.root.bg:SetSize(scale_x*width, scale_y*height)
        width, height = self.root.bg:GetSize()
        print("self.root.bg:GetSize():"..tostring(width)..","..tostring(height))
        local x=0
        local y=height/2-10  
    --添加imagebutton，用来显示食材
    self.root.bg.buttoningredient = self.root.bg:AddChild(ImageButton("images/quagmire_recipebook.xml", "quagmire_recipe_tab_active.tex"))
        local width_btingredient,height_btingredient = self.root.bg.buttoningredient:GetSize()
        --self.root.bg.buttoningredient:SetSize(scale_x*width_btingredient, scale_y*height_btingredient)
        --width_btingredient,height_btingredient = self.root.bg.buttoningredient:GetSize()
        self.root.bg.buttoningredient:SetPosition(x-width_btingredient/2,y+height_btingredient/2)
        self.root.bg.buttoningredient:SetNormalScale(1,1,1)
        self.root.bg.buttoningredient:SetFocusScale(1,1,1)
        self.root.bg.buttoningredient:SetOnGainFocus(function() self.root.bg.buttoningredient:ScaleTo(1,1.15,.125) end)
        self.root.bg.buttoningredient:SetOnLoseFocus(function() self.root.bg.buttoningredient:ScaleTo(1.15,1,.25) end)
        self.root.bg.buttoningredient:SetOnClick(function()
            self.numpage = 1
            self.title="ingredient"
            self:buildlist("ingredient")
        end) 
            self.root.bg.buttoningredient.text=self.root.bg.buttoningredient:AddChild(Text(NEWFONT, 48, "食材"))
            self.root.bg.buttoningredient.text:SetPosition(0,-10)
            self.root.bg.buttoningredient.text:SetScale(.99,.99)
    --添加imagebutton，用来显示料理
    self.root.bg.buttonfood = self.root.bg:AddChild(ImageButton("images/quagmire_recipebook.xml", "quagmire_recipe_tab_inactive.tex"))
        local width_btfood,height_btfood = self.root.bg.buttonfood:GetSize()
        --self.root.bg.buttonfood:SetSize(scale_x*width_btfood, scale_y*height_btfood)
        --width_btfood,height_btfood = self.root.bg.buttonfood:GetSize()
        self.root.bg.buttonfood:SetPosition(x+width_btfood/2, y+height_btfood/2)
        self.root.bg.buttonfood:SetNormalScale(1,1,1)
        self.root.bg.buttonfood:SetFocusScale(1,1,1)
        self.root.bg.buttonfood:SetOnGainFocus(function() self.root.bg.buttonfood:ScaleTo(1,1.15,.125) end)
        self.root.bg.buttonfood:SetOnLoseFocus(function() self.root.bg.buttonfood:ScaleTo(1.15,1,.25) end)
        self.root.bg.buttonfood:SetOnClick(function()
            self.numpage = 1
            self.title="food"
            self:buildlist("food")
        end)  
            self.root.bg.buttonfood.text=self.root.bg.buttonfood:AddChild(Text(NEWFONT, 48, "料理"))
            self.root.bg.buttonfood.text:SetPosition(0,-10)
            self.root.bg.buttonfood.text:SetScale(.99,.99)
    -- 添加一个imagebutton，用来显示上/下一页
    self.root.nextpage = self.root:AddChild(ImageButton("images/inventoryimages/next.xml", "next.tex"))      
        self.root.nextpage:SetPosition(width/2, 0)
        self.root.nextpage:SetNormalScale(1,1,1)
        self.root.nextpage:SetFocusScale(1,1,1)
        self.root.nextpage:SetHoverText("下一页")
        self.root.nextpage.image:SetTint(1,1,1,1)
        self.root.nextpage:SetOnGainFocus(function() self.root.nextpage:ScaleTo(1,1.15,.125) end)
        self.root.nextpage:SetOnLoseFocus(function() self.root.nextpage:ScaleTo(1.15,1,.25) end)
        self.root.nextpage:SetOnClick(function()
            if self.numpage < self.maxpage then
                self.numpage = self.numpage + 1
                self:buildlist(self.title)
                self.root.backpage.image:SetTint(1,1,1,1)
                if self.numpage >= self.maxpage then
                    self.root.nextpage.image:SetTint(1,1,1,.5)
                end
            end
        end)
    self.root.backpage = self.root:AddChild(ImageButton("images/inventoryimages/back.xml", "back.tex"))
        self.root.backpage:SetPosition(-width/2, 0)
        self.root.backpage:SetNormalScale(1,1,1)
        self.root.backpage:SetFocusScale(1,1,1)
        self.root.backpage:SetHoverText("上一页")
        self.root.backpage.image:SetTint(1,1,1,.5)
        self.root.backpage:SetOnGainFocus(function() self.root.backpage:ScaleTo(1,1.15,.125) end)
        self.root.backpage:SetOnLoseFocus(function() self.root.backpage:ScaleTo(1.15,1,.25) end)
        self.root.backpage:SetOnClick(function()
            if self.numpage > 1 then
                self.numpage = self.numpage - 1
                self:buildlist(self.title)
                self.root.nextpage.image:SetTint(1,1,1,1)
                if self.numpage <= 1 then
                    self.root.backpage.image:SetTint(1,1,1,.5)
                end
            end
        end)
    -- 添加一个背景，用来显示食物信息（右）
    self.root.bg.foodinfo = self.root.bg:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_menu_block.tex")) 
        --local width_foodinfo,height_foodinfo=self.root.bg.foodinfo:GetSize()
        local interval_left = 60
        local interval_bottom = 40  
        local width_foodinfo=width/2-2*interval_left
        local height_foodinfo=height-2*interval_bottom
        self.root.bg.foodinfo:SetSize(width_foodinfo,height_foodinfo) 
        self.root.bg.foodinfo:SetPosition(width/4, 0)
        self.root.bg.foodinfo:SetScale(.99,.99)
        local x_gap = 10    
        local y_gap = 40
        local fontsize = 72
            --title
            self.root.bg.foodinfo.title = self.root.bg.foodinfo:AddChild(Image("images/quagmire_recipebook.xml", "cookbook_missing.tex"))
                local x_title =0
                local y_title=height_foodinfo/2-y_gap-10
                --print(x_title,y_title)
                self.root.bg.foodinfo.title:SetPosition(x_title,y_title)
                self.root.bg.foodinfo.title:SetScale(.8,.8)
                    self.root.bg.foodinfo.title.text=self.root.bg.foodinfo.title:AddChild(Text(NEWFONT, fontsize, ""))
                    self.root.bg.foodinfo.title.text:SetColour({87,62,32,255})
                    self.root.bg.foodinfo.title.text:SetPosition(0,0)
                    self.root.bg.foodinfo.title.text:SetScale(.99,.99)
            --breakline
            self.root.bg.foodinfo.breakline = self.root.bg.foodinfo:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_line_break.tex"))
                local width_breakline,height_breakline=self.root.bg.foodinfo.breakline:GetSize()
                local x_breakline=0
                local y_breakline=y_title-fontsize/2-y_gap
                --print(x_breakline,y_breakline)
                self.root.bg.foodinfo.breakline:SetPosition(x_breakline,y_breakline)
                self.root.bg.foodinfo.breakline:SetRotation(180)
            --prefab
            self.root.bg.foodinfo.prefab = self.root.bg.foodinfo:AddChild(Image("images/quagmire_recipebook.xml", "cookbook_known.tex"))
                local width_prefab,height_prefab=self.root.bg.foodinfo.prefab:GetSize()         
                local x_prefab = -width_foodinfo/2+width_prefab/2+y_gap-10
                local y_prefab=y_breakline-height_prefab/2-height_breakline/2-y_gap
                --print(x_prefab,y_prefab)
                self.root.bg.foodinfo.prefab:SetPosition(x_prefab,y_prefab)
                    self.root.bg.foodinfo.prefab.unkown=self.root.bg.foodinfo.prefab:AddChild(Image("images/quagmire_recipebook.xml", "cookbook_missing.tex"))
            --health            
            self.root.bg.foodinfo.health = self.root.bg.foodinfo:AddChild(Image("images/global_redux.xml", "status_health.tex"))
                local health_fontsize=48
                local scale=.5
                local width_health,height_health=self.root.bg.foodinfo.health:GetSize()
                width_health=width_health*scale
                height_health=height_health*scale
                local x_health = x_prefab+width_prefab/2+y_gap+x_gap
                local y_health = y_prefab+height_prefab/2-height_health/2
                --print(x_health,y_health)
                self.root.bg.foodinfo.health:SetPosition(x_health,y_health)  
                self.root.bg.foodinfo.health:SetScale(scale,scale) 
                    self.root.bg.foodinfo.health.value = self.root.bg.foodinfo.health:AddChild(Image("images/global_redux.xml", "value_gold.tex"))
                    self.root.bg.foodinfo.health.value:SetScale(0.99,0.99)
                    self.root.bg.foodinfo.health.value:SetPosition(0,-height_health/2-x_gap-10)
                    self.root.bg.foodinfo.health.value.text=self.root.bg.foodinfo.health.value:AddChild(Text(NEWFONT, health_fontsize, ""))
                    self.root.bg.foodinfo.health.value.text:SetColour({255,255,255,255})
            --hunger
            self.root.bg.foodinfo.hunger = self.root.bg.foodinfo:AddChild(Image("images/global_redux.xml", "status_hunger.tex"))
                local width_hunger,height_hunger=self.root.bg.foodinfo.hunger:GetSize()
                width_hunger=width_hunger*scale
                height_hunger=height_hunger*scale
                local x_hunger=x_health+width_health/2+width_hunger/2+x_gap
                local y_hunger = y_health
                --print(x_hunger,y_hunger)
                self.root.bg.foodinfo.hunger:SetPosition(x_hunger,y_hunger)
                self.root.bg.foodinfo.hunger:SetScale(scale,scale)
                    self.root.bg.foodinfo.hunger.value = self.root.bg.foodinfo.hunger:AddChild(Image("images/global_redux.xml", "value_gold.tex"))
                    self.root.bg.foodinfo.hunger.value:SetPosition(0,-height_hunger/2-x_gap-10)
                    self.root.bg.foodinfo.hunger.value.text=self.root.bg.foodinfo.hunger.value:AddChild(Text(NEWFONT, health_fontsize, ""))
                    --self.root.bg.foodinfo.hunger.value.text:SetColour({87,62,32,255})
            --sanity
            self.root.bg.foodinfo.sanity = self.root.bg.foodinfo:AddChild(Image("images/global_redux.xml", "status_sanity.tex"))
                local width_sanity,height_sanity=self.root.bg.foodinfo.sanity:GetSize()
                width_sanity=width_sanity*scale
                height_sanity=height_sanity*scale
                local x_sanity=x_hunger+width_hunger/2+width_sanity/2+x_gap
                local y_sanity=y_health
                --print(x_sanity,y_sanity)
                self.root.bg.foodinfo.sanity:SetPosition(x_sanity,y_sanity)
                self.root.bg.foodinfo.sanity:SetScale(scale,scale)
                    self.root.bg.foodinfo.sanity.value = self.root.bg.foodinfo.sanity:AddChild(Image("images/global_redux.xml", "value_gold.tex"))
                    self.root.bg.foodinfo.sanity.value:SetPosition(0,-height_sanity/2-x_gap-10)
                    self.root.bg.foodinfo.sanity.value.text=self.root.bg.foodinfo.sanity.value:AddChild(Text(NEWFONT, health_fontsize, ""))
                    --self.root.bg.foodinfo.sanity.value.text:SetColour({87,62,32,255})
            --shortline
            self.root.bg.foodinfo.shortline = self.root.bg.foodinfo:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_line_short.tex"))
                local width_shortline,height_shortline=self.root.bg.foodinfo.shortline:GetSize()
                local x_shortline=x_hunger
                local y_shortline=y_sanity-height_sanity/2-height_shortline/2-y_gap
                self.root.bg.foodinfo.shortline:SetPosition(x_shortline,y_shortline)
                self.root.bg.foodinfo.shortline:SetScale(.8)
            --veryshortline1
            self.root.bg.foodinfo.veryshortline1 = self.root.bg.foodinfo:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_line_veryshort.tex"))
                local width_veryshortline1,height_veryshortline1=self.root.bg.foodinfo.veryshortline1:GetSize()
                local x_veryshortline1=-width_foodinfo/4
                local y_veryshortline1=y_prefab-height_prefab/2-height_veryshortline1/2-y_gap
                self.root.bg.foodinfo.veryshortline1:SetPosition(x_veryshortline1,y_veryshortline1)
                self.root.bg.foodinfo.veryshortline1:SetScale(.8)
            --veryshortline2
            self.root.bg.foodinfo.veryshortline2 = self.root.bg.foodinfo:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_line_veryshort.tex"))
                local x_veryshortline2=width_foodinfo/4
                local y_veryshortline2=y_veryshortline1
                self.root.bg.foodinfo.veryshortline2:SetPosition(x_veryshortline2,y_veryshortline2)
                self.root.bg.foodinfo.veryshortline2:SetScale(.8)
            --line1
            self.root.bg.foodinfo.line1 = self.root.bg.foodinfo:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_line_short.tex"))
                local width_line1,height_line1=self.root.bg.foodinfo.line1:GetSize()
                local x_line1=0
                local y_line1=x_veryshortline1-height_veryshortline1/2-height_line1/2
                self.root.bg.foodinfo.line1:SetPosition(x_line1,y_line1)
            --line2
            self.root.bg.foodinfo.line2 = self.root.bg.foodinfo:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_line_short.tex"))
                local width_line2,height_line2=self.root.bg.foodinfo.line2:GetSize()
                local x_line2=0
                local y_line2=y_line1-height_line1/2-height_line2/2-y_gap
                self.root.bg.foodinfo.line2:SetPosition(x_line2,y_line2)
            --corner1
            self.root.bg.foodinfo.corner1 = self.root.bg.foodinfo:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_corner_decoration.tex"))
                local width_corner1,height_corner1=self.root.bg.foodinfo.corner1:GetSize()
                local x_corner1=-width_foodinfo/2+width_corner1/2
                local y_corner1=-height_foodinfo/2+height_corner1/2
                self.root.bg.foodinfo.corner1:SetScale(.8,.8)
                self.root.bg.foodinfo.corner1:SetPosition(x_corner1,y_corner1)
            --corner2
            self.root.bg.foodinfo.corner2 = self.root.bg.foodinfo:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_corner_decoration.tex"))
                local width_corner2,height_corner2=self.root.bg.foodinfo.corner2:GetSize()
                local x_corner2=width_foodinfo/2-width_corner1/2
                local y_corner2=y_corner1
                self.root.bg.foodinfo.corner2:SetScale(.8,.8)
                self.root.bg.foodinfo.corner2:SetPosition(x_corner2,y_corner2)
                self.root.bg.foodinfo.corner2:SetRotation(-90)
    -- 添加一个image，用来显示食物列表（左）
    self.root.bg.prefabbg = self.root.bg:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_menu_block.tex"))  
        local width_prefabbg=width/2-2*interval_left
        local height_prefabbg=height-2*interval_bottom
        self.root.bg.prefabbg:SetSize(width_prefabbg,height_prefabbg)    
        local x_prefabbg=-width/4
        local y_prefabbg=0
        --local x_prefabbg=-width/4+interval_left
        --local y_prefabbg=-height/8+interval_bottom
        self.root.bg.prefabbg:SetPosition(x_prefabbg, y_prefabbg)
        print("self.root.bg.prefabbg:SetPosition:"..tostring(x_prefabbg)..","..tostring(y_prefabbg))
            --添加搜索框
            self.root.bg.prefabbg.searchbg=self.root.bg.prefabbg:AddChild(Image("images/global_redux.xml", "menu_focus.tex"))
                local width_searchbg,height_searchbg=self.root.bg.prefabbg.searchbg:GetSize()
                local scale_x = math.min(1, width_prefabbg*.75 / width_searchbg)
                local scale_y = math.min(1, height_prefabbg*.75 / height_searchbg)
                self.root.bg.prefabbg.searchbg:SetSize(scale_x*width_searchbg, scale_y*height_searchbg)
                width_searchbg,height_searchbg=self.root.bg.prefabbg.searchbg:GetSize()
                local x_searchbg=-width_prefabbg/2+width_searchbg/2
                local y_searchbg=height_prefabbg/2-height_searchbg/2
                self.root.bg.prefabbg.searchbg:SetPosition(x_searchbg, y_searchbg)
                    local x_searchtext=x_searchbg
                    local y_searchtext=y_searchbg
                    self.root.bg.prefabbg.searchbg.searchtext = self.root.bg.prefabbg:AddChild( TextEdit( NEWFONT, 48, "" ) )
                    self.root.bg.prefabbg.searchbg.searchtext:SetPosition(x_searchtext, y_searchtext)
                    self.root.bg.prefabbg.searchbg.searchtext:SetRegionSize( width_searchbg,height_searchbg )--width_prefablist-width_searchbt, height_searchbt
                    self.root.bg.prefabbg.searchbg.searchtext.OnTextEntered = function()               
                        self.prefab=self.root.bg.prefabbg.searchbg.searchtext:GetString()
                        print("self.root.bg.searchbg.searchtext.OnTextEntered: "..self.prefab)
                    end
                    self.root.bg.prefabbg.searchbg.searchtext:SetPassControlToScreen(CONTROL_CANCEL, true)
                    self.root.bg.prefabbg.searchbg.searchtext:SetPassControlToScreen(CONTROL_MENU_MISC_2, true)
                    self.root.bg.prefabbg.searchbg.searchtext:SetEditing(true)
                    self.root.bg.prefabbg.searchbg.searchtext:SetForceEdit(true)
            --添加搜索按钮
            self.root.bg.prefabbg.searchbt = self.root.bg.prefabbg:AddChild(TextButton())
                local width_searchbt,height_searchbt=self.root.bg.prefabbg.searchbt:GetSize()
                local x_searchbt=x_searchbg+width_searchbg/2+width_searchbt/2+40
                local y_searchbt=y_searchbg
                --self.searchbarbutton_width = self.searchbarbutton.text:GetRegionSize()
                --self.searchbarbutton.image:SetSize(self.searchbarbutton_width * .9, self.search_fontsize)
                --self.searchbarbutton_posx = self.searchbar_width * .5 - self.searchbarbutton_width * .5 + 10
                self.root.bg.prefabbg.searchbt:SetPosition(x_searchbt, y_searchbt)    
                self.root.bg.prefabbg.searchbt:SetFont(NEWFONT)
                self.root.bg.prefabbg.searchbt:SetTextSize(48)
                self.root.bg.prefabbg.searchbt:SetColour(0,0,0,1)
                self.root.bg.prefabbg.searchbt:SetText("搜索")
                self.root.bg.prefabbg.searchbt:SetTooltip("点击搜索！")
                self.root.bg.prefabbg.searchbt:SetOnClick( function()
                    print("self.root.bg.searchbt:SetOnClick"..self.prefab)
                    self.title="searchprefab"
                    self.buildlist(self.title)
                    end)
            --添加
            self.root.bg.prefabbg.prefablist = self.root.bg.prefabbg:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_menu_block.tex"))        
                local width_prefablist=width_prefabbg
                local height_prefablist=height_prefabbg*3/4    
                self.root.bg.prefabbg.prefablist:SetSize(width_prefablist,height_prefablist)
                local x_prefablist=0
                local y_prefablist=-height_prefabbg/8
                self.root.bg.prefabbg.prefablist:SetPosition(x_prefablist, y_prefablist)
                print("self.root.bg.prefabbg.prefablist:SetPosition:"..tostring(0)..","..tostring(0))
                self.root.bg.prefabbg.prefablist:SetScale(.99,.99)
                self.root.bg.prefabbg.prefablist.listslot = {}
                self:buildlist("ingredient") 
                --print(width_prefablist,height_prefablist)       
            --添加line1(左)
            self.root.bg.prefabbg.line1 = self.root.bg.prefabbg:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_line.tex"))
                local width_bgline1,height_bgline1=self.root.bg.prefabbg.line1:GetSize()
                local x_bgline1=x_prefablist
                local y_bgline1=y_prefablist+height_prefablist/2
                self.root.bg.prefabbg.line1:SetPosition(x_bgline1,y_bgline1)
            --添加line2(左)
            self.root.bg.prefabbg.line2 = self.root.bg.prefabbg:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_line.tex"))
                local width_bgline2,height_bgline2=self.root.bg.prefabbg.line2:GetSize()
                local x_bgline2=x_bgline1
                local y_bgline2=y_prefablist-height_prefablist/2
                self.root.bg.prefabbg.line2:SetPosition(x_bgline2,y_bgline2)
                self.root.bg.prefabbg.line2:SetRotation(180)                   
end)

function FoodInfoScreen:buildlist(title)
    self.root.bg.prefabbg.prefablist:KillAllChildren()
    local tools = require("lists/list_food")
    local list = {}
    if title=="ingredient"then
        list = tools.GetIngredientList()
    end
    if title=="food"then
        list=tools.GetFoodList()
    end  
    if title=="searchprefab"then
        local list_ingredient=tools.GetIngredientList()
        local list_food=tools.GetFoodList()
        local item = self.prefab
        for j = 1, list_ingredient.name:length() do
            if string.find(list_ingredient.name[j], item) then
                table.insert(list, list_ingredient[j])
            end
        end
        for j = 1, list_food.name:length() do
            if string.find(list_food.name[j], item) then
                table.insert(list, list_food[j])
            end
        end        
    end
    local listnums=list.name:length()
    local width, height = self.root.bg:GetSize()   
    local width_prefablist,height_prefablist=self.root.bg.prefabbg.prefablist:GetSize()
    local width_prefab,height_prefab=self.root.bg.foodinfo.prefab:GetSize()
    local numsperrow = math.ceil(width_prefablist/width_prefab)
    local numspercol = math.ceil(height_prefablist/height_prefab)
    local numsperpage = numsperrow*numspercol
    self.maxpage = math.ceil(listnums/numsperpage)
    print("self.root.bg.prefabbg.prefablist:GetSize():"..tostring(width_prefablist)..","..tostring(width_prefablist))
    print("row,col:"..tostring(numsperrow)..","..tostring(numspercol))
    local x = -width_prefablist/2
    local y = height_prefablist/2
    --print(x,y)
    for i = 1+numsperpage*(self.numpage-1), math.min(listnums, numsperpage*(1+self.numpage-1)) do
        if math.ceil((i-numsperpage*(self.numpage-1))/numsperrow) ~= math.ceil((i-numsperpage*(self.numpage-1)-1)/numsperrow) then 
            x = 0 
        else x = x + 100 
        end
        y = -100*(math.ceil((i-numsperpage*(self.numpage-1))/numsperrow)-1)
        self.root.bg.prefabbg.prefablist.listslot[i] = self.root.bg.prefabbg.prefablist:AddChild(ImageButton("images/quagmire_recipebook.xml", "cookbook_known.tex"))
            local width_listslot,height_listlot=self.root.bg.prefabbg.prefablist.listslot[i]:GetSize()
            self.root.bg.prefabbg.prefablist.listslot[i]:SetPosition(x-width_prefablist/2+width_listslot/2, y+height_prefablist/2-height_listlot/2)
	        self.root.bg.prefabbg.prefablist.listslot[i]:SetScale(.65,.65)
            --self.root.bg.prefabbg.prefablist.listslot[i]:SetNormalScale(.8,.8,1)
	        --self.root.bg.prefabbg.prefablist.listslot[i]:SetFocusScale(.8,.8,1)
            --self.root.bg.prefabbg.prefablist.listslot[i]:ScaleTo(.85,.85,1)
	        self.root.bg.prefabbg.prefablist.listslot[i]:SetOnGainFocus(function() self.root.bg.prefabbg.prefablist.listslot[i]:SetScale(.7,.7) end)
		    self.root.bg.prefabbg.prefablist.listslot[i]:SetOnLoseFocus(function() self.root.bg.prefabbg.prefablist.listslot[i]:SetScale(.65,.65) end)              
        self.root.bg.prefabbg.prefablist.listslot[i].im = self.root.bg.prefabbg.prefablist.listslot[i]:AddChild(Image("images/inventoryimages.xml",list.name[i]..".tex"))
		    self.root.bg.prefabbg.prefablist.listslot[i].im:SetPosition(0, 0, 0)
		    self.root.bg.prefabbg.prefablist.listslot[i].im:SetScale(.95,.95,1)      
        self.root.bg.prefabbg.prefablist.listslot[i].im = self.root.bg.prefabbg.prefablist.listslot[i]:AddChild(Image("images/inventoryimages1.xml",list.name[i]..".tex"))
		    self.root.bg.prefabbg.prefablist.listslot[i].im:SetPosition(0, 0, 0)
		    self.root.bg.prefabbg.prefablist.listslot[i].im:SetScale(.95,.95,1)
        self.root.bg.prefabbg.prefablist.listslot[i].im = self.root.bg.prefabbg.prefablist.listslot[i]:AddChild(Image("images/inventoryimages2.xml",list.name[i]..".tex"))
		    self.root.bg.prefabbg.prefablist.listslot[i].im:SetPosition(0, 0, 0)
		    self.root.bg.prefabbg.prefablist.listslot[i].im:SetScale(.95,.95,1)
        self.root.bg.prefabbg.prefablist.listslot[i].im = self.root.bg.prefabbg.prefablist.listslot[i]:AddChild(Image("images/inventoryimages3.xml",list.name[i]..".tex"))
		    self.root.bg.prefabbg.prefablist.listslot[i].im:SetPosition(0, 0, 0)
		    self.root.bg.prefabbg.prefablist.listslot[i].im:SetScale(.95,.95,1)
        local hovertext = STRINGS.NAMES[string.upper(list.name[i])] or list.name[i]-- .. "\n类型:" .. tostring(list.tag.type[i]) .. "/饥饿: ".. tostring(list.tag.hunger[i]) .."/".."精神: "..tostring(list.tag.sanity[i]) .."/".."生命: ".. tostring(list.tag.health[i])
        self.root.bg.prefabbg.prefablist.listslot[i]:SetHoverText(hovertext or "显示错误", {font_size=18})
        local p1 = self.root.bg.prefabbg.prefablist.listslot[i].hovertext:GetPosition()
		local p2 = self.root.bg.prefabbg.prefablist.listslot[i].hovertext_bg:GetPosition()
		self.root.bg.prefabbg.prefablist.listslot[i].hovertext:SetPosition(p1.x,p1.y+30,p1.z)
		self.root.bg.prefabbg.prefablist.listslot[i].hovertext_bg:SetPosition(p2.x,p2.y+30,p2.z)
        --self.root.bg.prefabbg.prefablist.listslot[i].text = self.root.bg.prefabbg.prefablist.listslot[i]:AddChild(Text(NEWFONT, 18, STRINGS.NAMES[string.upper(list.name[i])] or list.name[i]))
		--self.root.bg.prefabbg.prefablist.listslot[i].text:SetPosition(3, -33, 0)
		--self.root.bg.prefabbg.prefablist.listslot[i].text:SetScale(1.15, 1.15, 1)
        self.root.bg.prefabbg.prefablist.listslot[i]:SetOnClick(function()
            --local width_title,height_title=self.root.bg.foodinfo.title:GetSize()
            self.root.bg.foodinfo.title:SetTexture("images/quagmire_recipebook.xml", "blank.tex")
            --self.root.bg.foodinfo.title:SetSize(width_title,height_title)
            self.root.bg.foodinfo.title.text:SetString(STRINGS.NAMES[string.upper(list.name[i])])
            self.root.bg.foodinfo.prefab.unkown:SetTexture("images/inventoryimages.xml",list.name[i]..".tex")
            self.root.bg.foodinfo.health.value.text:SetString(tostring(list.tag.health[i]))
            self.root.bg.foodinfo.hunger.value.text:SetString(tostring(list.tag.hunger[i]))
            self.root.bg.foodinfo.sanity.value.text:SetString(tostring(list.tag.sanity[i]))
        end)
    end
end

function FoodInfoScreen:Close()
    TheFrontEnd:PopScreen(self) -- 当取消时，弹出当前屏幕
end

return FoodInfoScreen -- 返回FoodInfoScreen类


