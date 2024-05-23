local Screen = require "widgets/screen" -- 引入"widgets/screen"模块
local Widget = require "widgets/widget"
local Image = require "widgets/image"
local Menu = require "widgets/menu"
local Text = require "widgets/text"
local ImageButton = require "widgets/imagebutton"
local TextEdit = require "widgets/textedit"
local TextButton = require "widgets/textbutton"
local FoodInfoTitle = require("widgets/foodinfotitle")
local PrefabHHS = require("widgets/prefabHHS")
local PrefabAttribute = require("widgets/prefabattribute")
local FoodAttribute = require("widgets/foodattribute")
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
     --print("TheSim:GetScreenSize():"..tostring(w_hud)..","..tostring(h_hud))
     self.root.bg = self.root:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_menu_bg.tex"))
        self.root.bg:SetPosition(0, 0)
        local width, height = self.root.bg:GetSize()
        local scale_x = math.min(1, w_hud*.75 / (width-100))
        local scale_y = math.min(1, h_hud*.75 / (height-50))
        local scale = math.min(scale_x,scale_y)
        --print("foodinfo_screen.lua:scale:"..tostring(scale))
        self.root.bg:SetSize(scale_x*width, scale_y*height)
        width, height = self.root.bg:GetSize()
        --print("self.root.bg:GetSize():"..tostring(width)..","..tostring(height))
        local x=0
        local y=height/2-10    
    -- 添加一个背景，用来显示食物信息（右）
    self.root.bg.foodinfo = self.root.bg:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_menu_block.tex")) 
        --local width_foodinfo,height_foodinfo=self.root.bg.foodinfo:GetSize()
        local interval_left = 50
        local interval_bottom = 40  
        local width_foodinfo=width/2-2*interval_left
        local height_foodinfo=height-2*interval_bottom
        self.root.bg.foodinfo:SetSize(width_foodinfo,height_foodinfo) 
        self.root.bg.foodinfo:SetPosition(width/4, 0)
        self.root.bg.foodinfo:SetScale(.99,.99)
        local x_gap = 10    
        local y_gap = 40
        local fontsize = 30
            --title
            local title_range={w=width_foodinfo,h=nil}
            self.root.bg.foodinfo.title = self.root.bg.foodinfo:AddChild(FoodInfoTitle(title_range, NEWFONT, scale))
            local width_title,height_title=self.root.bg.foodinfo.title:GetScaledSize()
            local x_title=0
            local y_title=height_foodinfo/2-height_title/2--------------------------------------------------------------------------------------------
            --print(x_title,y_title)
            self.root.bg.foodinfo.title:SetPosition(x_title,y_title)
            --[[self.root.bg.foodinfo.title = self.root.bg.foodinfo:AddChild(Image("images/quagmire_recipebook.xml", "cookbook_missing.tex"))
                local width_title,height_title=self.root.bg.foodinfo.title:GetSize()
                local x_title=0
                local y_title=height_foodinfo/2-height_title/2
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
                local x_breakline=x_title
                local y_breakline=y_title-height_title/2
                --print(x_breakline,y_breakline)
                self.root.bg.foodinfo.breakline:SetPosition(x_breakline,y_breakline)
                self.root.bg.foodinfo.breakline:SetRotation(180)]]
            --prefab
            local prefab_range={w=width_foodinfo,h=height_foodinfo*.3}
            self.root.bg.foodinfo.prefab = self.root.bg.foodinfo:AddChild(PrefabHHS(prefab_range,NEWFONT,fontsize))
            local width_prefab,height_prefab=self.root.bg.foodinfo.prefab:GetSize()
            local x_prefab = 0
            local y_prefab=y_title-height_title*.5-height_prefab*.5-20-----------------------------------------------------------------------------------------------
            --print("pos_prefab:"..tostring(x_prefab)..","..tostring(y_prefab))
            self.root.bg.foodinfo.prefab:SetPosition(x_prefab,y_prefab)
            --[[self.root.bg.foodinfo.prefab = self.root.bg.foodinfo:AddChild(Image("images/quagmire_recipebook.xml", "cookbook_known.tex"))
                local width_prefab,height_prefab=self.root.bg.foodinfo.prefab:GetSize()         
                local x_prefab = -width_foodinfo/2+width_prefab/2
                local y_prefab=y_breakline-height_prefab/2-height_breakline/2
                --print(x_prefab,y_prefab)
                self.root.bg.foodinfo.prefab:SetPosition(x_prefab,y_prefab)
                    self.root.bg.foodinfo.prefab.img=self.root.bg.foodinfo.prefab:AddChild(Image("images/quagmire_recipebook.xml", "cookbook_missing.tex"))
            --health            
            self.root.bg.foodinfo.health = self.root.bg.foodinfo:AddChild(Image("images/global_redux.xml", "status_health.tex"))
                local att_gap=10
                local health_fontsize=48                
                local width_health,height_health=self.root.bg.foodinfo.health:GetSize()
                local scale = math.min(1, (width_foodinfo-width_prefab)*.6 / ((width_health-att_gap)*3))
                self.root.bg.foodinfo.health:SetSize(scale*width_health, scale*height_health)
                width_health=width_health*scale
                height_health=height_health*scale
                --width_health,height_health=self.root.bg.foodinfo.health:GetSize()
                --print("scale:"..tostring(scale).."health:"..tostring(width_health)..tostring(height_health))
                local x_health = x_prefab+width_prefab/2+width_health/2+att_gap
                local y_health = y_prefab+height_prefab/2-height_health/2
                --print(x_health,y_health)
                self.root.bg.foodinfo.health:SetPosition(x_health,y_health)  
                --self.root.bg.foodinfo.health:SetScale(scale,scale) 
                    self.root.bg.foodinfo.health.textbg = self.root.bg.foodinfo.health:AddChild(Image("images/global_redux.xml", "value_gold.tex"))
                    local width_textbg,height_textbg=self.root.bg.foodinfo.health.textbg:GetSize()
                    local scale_textbg = math.min(1, width_health*.9 / width_textbg)
                    self.root.bg.foodinfo.health.textbg:SetSize(scale_textbg*width_textbg,scale_textbg*height_textbg)
                    width_textbg,height_textbg=self.root.bg.foodinfo.health.textbg:GetSize()
                    self.root.bg.foodinfo.health.textbg:SetPosition(0,-height_health/2-height_textbg/2)
                    self.root.bg.foodinfo.health.textbg.text=self.root.bg.foodinfo.health.textbg:AddChild(Text(NEWFONT, health_fontsize, ""))
                    self.root.bg.foodinfo.health.textbg.text:SetColour({0,0,0,1})
            --hunger
            self.root.bg.foodinfo.hunger = self.root.bg.foodinfo:AddChild(Image("images/global_redux.xml", "status_hunger.tex"))
                --local width_hunger,height_hunger=self.root.bg.foodinfo.hunger:GetSize()
                local width_hunger=width_health
                local height_hunger=height_health
                self.root.bg.foodinfo.hunger:SetSize(width_hunger, height_hunger)
                --width_hunger,height_hunger=self.root.bg.foodinfo.hunger:GetSize()
                --print("scale:"..tostring(scale).."hunger:"..tostring(width_hunger)..tostring(height_hunger))
                local x_hunger=x_health+width_health/2+width_hunger/2+att_gap
                local y_hunger = y_health
                --print(x_hunger,y_hunger)
                self.root.bg.foodinfo.hunger:SetPosition(x_hunger,y_hunger)
                --self.root.bg.foodinfo.hunger:SetScale(scale,scale)
                    self.root.bg.foodinfo.hunger.textbg = self.root.bg.foodinfo.hunger:AddChild(Image("images/global_redux.xml", "value_gold.tex"))
                    self.root.bg.foodinfo.hunger.textbg:SetPosition(0,-height_hunger/2-height_textbg/2)
                    local width_textbg2,height_textbg2=self.root.bg.foodinfo.hunger.textbg:GetSize()
                    self.root.bg.foodinfo.hunger.textbg:SetSize(scale_textbg*width_textbg2,scale_textbg*height_textbg2)
                    width_textbg2,height_textbg2=self.root.bg.foodinfo.hunger.textbg:GetSize()
                    self.root.bg.foodinfo.hunger.textbg.text=self.root.bg.foodinfo.hunger.textbg:AddChild(Text(NEWFONT, health_fontsize, ""))
                    self.root.bg.foodinfo.hunger.textbg.text:SetColour({0,0,0,1})
            --sanity
            self.root.bg.foodinfo.sanity = self.root.bg.foodinfo:AddChild(Image("images/global_redux.xml", "status_sanity.tex"))
                --local width_sanity,height_sanity=self.root.bg.foodinfo.sanity:GetSize()
                local width_sanity=width_health
                local height_sanity=height_health
                self.root.bg.foodinfo.sanity:SetSize(width_sanity, height_sanity)
                local x_sanity=x_hunger+width_hunger/2+width_sanity/2+att_gap
                local y_sanity=y_health
                --print(x_sanity,y_sanity)
                self.root.bg.foodinfo.sanity:SetPosition(x_sanity,y_sanity)
                --self.root.bg.foodinfo.sanity:SetScale(scale,scale)
                    self.root.bg.foodinfo.sanity.textbg = self.root.bg.foodinfo.sanity:AddChild(Image("images/global_redux.xml", "value_gold.tex"))
                    self.root.bg.foodinfo.sanity.textbg:SetPosition(0,-height_sanity/2-height_textbg/2)
                    local width_textbg3,height_textbg3=self.root.bg.foodinfo.sanity.textbg:GetSize()
                    self.root.bg.foodinfo.sanity.textbg:SetSize(scale_textbg*width_textbg3,scale_textbg*height_textbg3)
                    width_textbg3,height_textbg3=self.root.bg.foodinfo.sanity.textbg:GetSize()
                    self.root.bg.foodinfo.sanity.textbg.text=self.root.bg.foodinfo.sanity.textbg:AddChild(Text(NEWFONT, health_fontsize, ""))
                    self.root.bg.foodinfo.sanity.textbg.text:SetColour({0,0,0,1})
            --shortline
            local line_fontsize=health_fontsize+8
            self.root.bg.foodinfo.shortline = self.root.bg.foodinfo:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_line_short.tex"))
                local width_shortline,height_shortline=self.root.bg.foodinfo.shortline:GetSize()              
                local scale_x = math.min(1, (width_foodinfo-width_prefab)*.9 / width_shortline)
                local scale_y = math.min(1, (height_foodinfo-height_prefab)*.9 / height_shortline)
                self.root.bg.foodinfo.shortline:SetSize(scale_x*width_shortline, scale_y*height_shortline)
                width_shortline,height_shortline=self.root.bg.foodinfo.shortline:GetSize()
                local x_shortline=x_hunger
                local y_shortline=y_hunger-height_hunger/2-height_textbg/2-height_shortline/2
                self.root.bg.foodinfo.shortline:SetPosition(x_shortline,y_shortline)
                --self.root.bg.foodinfo.shortline:SetScale(.8)]]
            --attribute
            local range_attribute={w=width_foodinfo,h=height_foodinfo-height_title-height_prefab}
            local pos={x=0,y=y_prefab-height_prefab*.5-range_attribute.h*.5}-----------------------------------------------------------------------------------------------------------
            local tags={
                fruit={name=nil,value=nil},
                precook={name=nil,value=nil},
                meat={name=nil,value=nil},
                fish={name=nil,value=nil},
                veggie={name=nil,value=nil},
                egg={name=nil,value=nil},
                monster={name=nil,value=nil},
                sweetener={name=nil,value=nil},
            }
            self.root.bg.foodinfo.attributebg = self.root.bg.foodinfo:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_menu_block.tex"))
            self.root.bg.foodinfo.attributebg:SetSize(range_attribute.w,range_attribute.h)
            self.root.bg.foodinfo.attributebg:SetPosition(pos.x,pos.y)
            self.root.bg.foodinfo.attributebg.attribute = self.root.bg.foodinfo.attributebg:AddChild(PrefabAttribute(range_attribute,{x=0,y=0},tags))
            --corner1
            self.root.bg.foodinfo.corner1 = self.root.bg.foodinfo:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_corner_decoration.tex"))
            self.root.bg.foodinfo.corner1:SetScale(scale*.8,scale*.8)    
            local width_corner1,height_corner1=self.root.bg.foodinfo.corner1:GetScaledSize()
                local x_corner1=-width_foodinfo/2+width_corner1/2
                local y_corner1=-height_foodinfo/2+height_corner1/2             
                self.root.bg.foodinfo.corner1:SetPosition(x_corner1,y_corner1)
            --corner2
            self.root.bg.foodinfo.corner2 = self.root.bg.foodinfo:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_corner_decoration.tex"))
                self.root.bg.foodinfo.corner2:SetScale(scale*.8,scale*.8)
                local width_corner2,height_corner2=self.root.bg.foodinfo.corner2:GetScaledSize()
                local x_corner2=width_foodinfo/2-width_corner1/2
                local y_corner2=y_corner1              
                self.root.bg.foodinfo.corner2:SetPosition(x_corner2,y_corner2)
                self.root.bg.foodinfo.corner2:SetRotation(-90)
    -- 添加一个image，用来显示食物列表（左）
    self.root.bg.prefabbg = self.root.bg:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_menu_block.tex"))  
        local width_prefabbg=width/2-2*interval_left
        local height_prefabbg=height-2*interval_bottom
        self.root.bg.prefabbg:SetSize(width_prefabbg,height_prefabbg)         
        --local x_prefabbg=-width/4+interval_left
        --local y_prefabbg=-height/8+interval_bottom        
        -- 添加一个imagebutton，用来显示上/下一页
        self.root.bg.prefabbg.nextpage = self.root.bg.prefabbg:AddChild(ImageButton("images/ui.xml", "arrow_right.tex"))      
            self.root.bg.prefabbg.nextpage:SetScale(.5,.5)
            local width_nextpage,height_nextpage=self.root.bg.prefabbg.nextpage:GetSize()
            self.root.bg.prefabbg.nextpage:SetPosition(width_prefabbg*.5+height_nextpage*.5, 0)
            --self.root.bg.prefabbg.nextpage:SetNormalScale(1,1,1)
            --self.root.bg.prefabbg.nextpage:SetFocusScale(1,1,1)
            self.root.bg.prefabbg.nextpage:SetHoverText("下一页")
            self.root.bg.prefabbg.nextpage.image:SetTint(1,1,1,1)
            self.root.bg.prefabbg.nextpage:SetOnGainFocus(function() self.root.bg.prefabbg.nextpage:SetScale(.6,.6) end)
            self.root.bg.prefabbg.nextpage:SetOnLoseFocus(function() self.root.bg.prefabbg.nextpage:SetScale(.5,.5) end)
            self.root.bg.prefabbg.nextpage:SetOnClick(function()
                if self.numpage < self.maxpage then
                    self.numpage = self.numpage + 1
                    self:buildlist(self.title)
                    self.root.bg.prefabbg.backpage.image:SetTint(1,1,1,1)
                    if self.numpage >= self.maxpage then
                        self.root.bg.prefabbg.nextpage.image:SetTint(1,1,1,.5)
                    end
                end
            end)
        self.root.bg.prefabbg.backpage = self.root.bg.prefabbg:AddChild(ImageButton("images/ui.xml", "arrow_left.tex"))
            self.root.bg.prefabbg.backpage:SetScale(.5,.5)
            local width_backpage,height_backpage=self.root.bg.prefabbg.backpage:GetSize()
            self.root.bg.prefabbg.backpage:SetPosition(-width_prefabbg*.5-width_backpage*.5, 0)
            --self.root.bg.prefabbg.backpage:SetNormalScale(1,1,1)
            --self.root.bg.prefabbg.backpage:SetFocusScale(1,1,1)
            self.root.bg.prefabbg.backpage:SetHoverText("上一页")
            self.root.bg.prefabbg.backpage.image:SetTint(1,1,1,.5)
            self.root.bg.prefabbg.backpage:SetOnGainFocus(function() self.root.bg.prefabbg.backpage:SetScale(.6,.6) end)
            self.root.bg.prefabbg.backpage:SetOnLoseFocus(function() self.root.bg.prefabbg.backpage:SetScale(.5,.5) end)
            self.root.bg.prefabbg.backpage:SetOnClick(function()
                if self.numpage > 1 then
                    self.numpage = self.numpage - 1
                    self:buildlist(self.title)
                    self.root.bg.prefabbg.nextpage.image:SetTint(1,1,1,1)
                    if self.numpage <= 1 then
                        self.root.bg.prefabbg.backpage.image:SetTint(1,1,1,.5)
                    end
                end
            end)
            local x_prefabbg=-width/4+width_nextpage/2
            local y_prefabbg=0
            self.root.bg.prefabbg:SetPosition(x_prefabbg, y_prefabbg)
            --print("self.root.bg.prefabbg:SetPosition:"..tostring(x_prefabbg)..","..tostring(y_prefabbg))
        --添加搜索框
        self.root.bg.prefabbg.searchbg=self.root.bg.prefabbg:AddChild(Image("images/textboxes.xml", "textbox2_gold.tex"))
            local width_searchbg,height_searchbg=self.root.bg.prefabbg.searchbg:GetSize()
            local scale_x = math.min(1, width_prefabbg*.75 / width_searchbg)
            local scale_y = math.min(1, height_prefabbg*.75 / height_searchbg)
            local scale_searchbg=math.min(scale_x,scale_y)
            self.root.bg.prefabbg.searchbg:SetSize(scale_searchbg*width_searchbg, scale_searchbg*height_searchbg)
            width_searchbg,height_searchbg=self.root.bg.prefabbg.searchbg:GetSize()
            local x_searchbg=-width_prefabbg/2+width_searchbg/2
            local y_searchbg=height_prefabbg/2-height_searchbg/2
            self.root.bg.prefabbg.searchbg:SetPosition(x_searchbg, y_searchbg)
                local x_searchtext=x_searchbg
                local y_searchtext=y_searchbg
                self.root.bg.prefabbg.searchbg.searchtext = self.root.bg.prefabbg:AddChild( TextEdit( NEWFONT, height_searchbg, "" ) )
                self.root.bg.prefabbg.searchbg.searchtext:SetPosition(x_searchtext, y_searchtext)
                self.root.bg.prefabbg.searchbg.searchtext:SetRegionSize( width_searchbg,height_searchbg )--width_prefablist-width_searchbt, height_searchbt
                self.root.bg.prefabbg.searchbg.searchtext.OnTextEntered = function()               
                    self.prefab=self.root.bg.prefabbg.searchbg.searchtext:GetString()
                    --print("self.root.bg.searchbg.searchtext.OnTextEntered: "..self.prefab)
                end
                self.root.bg.prefabbg.searchbg.searchtext:SetPassControlToScreen(CONTROL_CANCEL, true)
                self.root.bg.prefabbg.searchbg.searchtext:SetPassControlToScreen(CONTROL_MENU_MISC_2, true)
                self.root.bg.prefabbg.searchbg.searchtext:SetEditing(true)
                self.root.bg.prefabbg.searchbg.searchtext:SetForceEdit(true)
        --添加搜索按钮
        self.root.bg.prefabbg.searchbt = self.root.bg.prefabbg:AddChild(TextButton())
            self.root.bg.prefabbg.searchbt:SetFont(NEWFONT)
            self.root.bg.prefabbg.searchbt:SetTextSize(height_searchbg)
            self.root.bg.prefabbg.searchbt:SetColour(0,0,0,1)
            self.root.bg.prefabbg.searchbt:SetText("搜索")
            self.root.bg.prefabbg.searchbt:SetTooltip("点击搜索！")           
            --self.searchbarbutton_width = self.searchbarbutton.text:GetRegionSize()
            --self.searchbarbutton.image:SetSize(self.searchbarbutton_width * .9, self.search_fontsize)
            --local width_searchbt=self.root.bg.prefabbg.searchbt.text:GetRegionSize()
            --local height_searchbt=searchbt_fontsize
            --self.root.bg.prefabbg.searchbt.image:SetTexture("images/ui.xml", "button_large.tex")
            local width_searchbt,height_searchbt=self.root.bg.prefabbg.searchbt:GetSize()
            --local scale_searchbt = math.min(1, width_prefabbg*.25 / width_searchbt)
            --print("self.root.bg.prefabbg.searchbt:GetSize():"..tostring(width_searchbt)..","..tostring(height_searchbt))
            --self.root.bg.prefabbg.searchbt.image:SetSize(width_searchbt*scale_searchbt, height_searchbt*scale_searchbt)
            --print("self.root.bg.prefabbg.searchbt:GetSize():"..tostring(width_searchbt)..","..tostring(height_searchbt))
            --width_searchbt,height_searchbt=self.root.bg.prefabbg.searchbt:GetSize()
            --print("self.root.bg.prefabbg.searchbt:GetSize():"..tostring(width_searchbt)..","..tostring(height_searchbt))
            local x_searchbt=x_searchbg+width_searchbg/2+width_searchbt/2+10
            local y_searchbt=y_searchbg
            self.root.bg.prefabbg.searchbt:SetPosition(x_searchbt, y_searchbt)   
            --[[self.root.bg.prefabbg.searchbt:SetOnGainFocus(function(scale_searchbt)
                self.root.bg.prefabbg.searchbt.image:SetTexture("images/ui.xml", "button_large_over.tex")
                self.root.bg.prefabbg.searchbt.image:SetSize(width_searchbt*scale_searchbt, height_searchbt*scale_searchbt) 
            end)
            self.root.bg.prefabbg.searchbt:SetOnLoseFocus(function(scale_searchbt)
                self.root.bg.prefabbg.searchbt.image:SetTexture("images/ui.xml", "button_large_onclick.tex") 
                self.root.bg.prefabbg.searchbt.image:SetSize(width_searchbt*scale_searchbt, height_searchbt*scale_searchbt)
            end)]]  
            self.root.bg.prefabbg.searchbt:SetOnClick( function()
                self.prefab=self.root.bg.prefabbg.searchbg.searchtext:GetString()
                --print("self.root.bg.searchbt:SetOnClick"..self.prefab)
                self.title="searchprefab"
                self:buildlist(self.title)
                end)
        --添加line1(左)
        self.root.bg.prefabbg.line1 = self.root.bg.prefabbg:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_line.tex"))
            local width_bgline1,height_bgline1=self.root.bg.prefabbg.line1:GetSize()
            local scale_line = math.min(1, width_prefabbg / width_bgline1)
            self.root.bg.prefabbg.line1:SetSize(scale_line*width_bgline1, scale_line*height_bgline1)
            width_bgline1,height_bgline1=self.root.bg.prefabbg.line1:GetSize()
            local x_bgline1=0
            local y_bgline1=y_searchbg-height_searchbg/2-height_bgline1/2
            self.root.bg.prefabbg.line1:SetPosition(x_bgline1,y_bgline1)
        --添加line2(左)
        self.root.bg.prefabbg.line2 = self.root.bg.prefabbg:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_line.tex"))
            self.root.bg.prefabbg.line2:SetSize(width_bgline1, height_bgline1)
            local width_bgline2,height_bgline2=self.root.bg.prefabbg.line2:GetSize()
            local x_bgline2=x_bgline1
            local y_bgline2=-height_prefabbg/2+height_bgline2/2-10
            self.root.bg.prefabbg.line2:SetPosition(x_bgline2,y_bgline2)
            self.root.bg.prefabbg.line2:SetRotation(180) 
        --添加prefablist
        self.root.bg.prefabbg.prefablist = self.root.bg.prefabbg:AddChild(Image("images/quagmire_recipebook.xml", "quagmire_recipe_menu_block.tex"))        
            local width_prefablist=width_prefabbg
            local height_prefablist=math.ceil(y_bgline1-y_bgline2)
            self.root.bg.prefabbg.prefablist:SetSize(width_prefablist,height_prefablist)
            local x_prefablist=0
            local y_prefablist=(y_bgline1+y_bgline2)/2
            self.root.bg.prefabbg.prefablist:SetPosition(x_prefablist, y_prefablist)
            --print("self.root.bg.prefabbg.prefablist:SetPosition:"..tostring(0)..","..tostring(0))
            self.root.bg.prefabbg.prefablist:SetScale(.99,.99)
            self.root.bg.prefabbg.prefablist.listslot = {}
            self:buildlist("ingredient") 
            --print(width_prefablist,height_prefablist) 
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

            local w,h=self.root.bg.foodinfo.attributebg:GetSize()
            local tags={
                fruit={name=nil,value=nil},
                precook={name=nil,value=nil},
                meat={name=nil,value=nil},
                fish={name=nil,value=nil},
                veggie={name=nil,value=nil},
                egg={name=nil,value=nil},
                monster={name=nil,value=nil},
                sweetener={name=nil,value=nil},
            }
            self.root.bg.foodinfo.attributebg:KillAllChildren()
            self.root.bg.foodinfo.attributebg.attribute = self.root.bg.foodinfo.attributebg:AddChild(PrefabAttribute({w=w,h=h},{x=0,y=0},tags))
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

            local w,h=self.root.bg.foodinfo.attributebg:GetSize()
            local tags={
                foodtype={name=nil,value=nil},
                cooktime={name=nil,value=nil},
                perishtime={name=nil,value=nil},
                prohibit={name=nil,value=nil},
                recipe={name=nil,value=nil},
            }
            self.root.bg.foodinfo.attributebg:KillAllChildren()
            self.root.bg.foodinfo.attributebg.attribute = self.root.bg.foodinfo.attributebg:AddChild(FoodAttribute({w=w,h=h},{x=0,y=0},tags))
        end)  
            self.root.bg.buttonfood.text=self.root.bg.buttonfood:AddChild(Text(NEWFONT, 48, "料理"))
            self.root.bg.buttonfood.text:SetPosition(0,-10)
            self.root.bg.buttonfood.text:SetScale(.99,.99)                          
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
        list={name = {zh=List(),en=List()}, tag = {type=List(),hunger=List(),health=List(),sanity=List()}}
        local list_ingredient=tools.GetIngredientList()
        local list_food=tools.GetFoodList()
        local item = self.prefab
        if item~="" then
            --print("self.prefab:"..item)
            --print("list_ingredient.name:length():"..tostring(list_ingredient.name.en:length()))
            for j = 1, list_ingredient.name.en:length() do
                --print(tostring(j)..":list_ingredient.name[j]:"..list_ingredient.name.en[j])
                if string.find(list_ingredient.name.zh[j], item) or string.find(list_ingredient.name.en[j], item) then
                    list.name.zh:add(list_ingredient.name.zh[j])
                    list.name.en:add(list_ingredient.name.en[j])
                    list.tag.health:add(list_ingredient.tag.health[j])
                    list.tag.hunger:add(list_ingredient.tag.hunger[j])
                    list.tag.sanity:add(list_ingredient.tag.sanity[j])
                    list.tag.type:add(list_ingredient.tag.type[j])
                    --print(tostring(j)..":"..list_ingredient.name.en[j])
                end               
            end
            for j = 1, list_food.name.en:length() do
                if string.find(list_food.name.en[j], item) or string.find(list_food.name.zh[j], item) then
                    list.name.en:add(list_food.name.en[j])
                    list.name.zh:add(list_food.name.zh[j])
                    list.tag.health:add(list_food.tag.health[j])
                    list.tag.hunger:add(list_food.tag.hunger[j])
                    list.tag.sanity:add(list_food.tag.sanity[j])
                    list.tag.type:add(list_food.tag.type[j])
                    --print(tostring(j)..":"..list_food.name.en[j])
                end
            end    
        end 
        --print("self.prefab为空！")           
    end   
    local listnums=list.name.en:length()
    print("foodinfo_screen.lua:buildlist:listnums"..tostring(listnums))
    print("foodinfo_screen.lua:buildlist:list.attribute:length"..tostring(list.attribute:length()))
    local contet=""
    for ii=1,list.attribute:length() do      
        for kk,vv in pairs(list.attribute[ii]) do
            contet=contet..kk..":"..tostring(vv).."\t"
        end
        contet=contet.."\n"
    end
    TheSim:SetPersistentString("myfoodtag.txt",contet)
    local width, height = self.root.bg:GetSize()   
    local width_prefablist,height_prefablist=self.root.bg.prefabbg.prefablist:GetSize()
    local size_prefab=60
    local numsperrow = math.ceil(width_prefablist/size_prefab)-1
    local numspercol = math.ceil(height_prefablist/size_prefab)-1
    local numsperpage = numsperrow*numspercol
    self.maxpage = math.ceil(listnums/numsperpage)
    local gap_x=(width_prefablist-size_prefab*numsperrow)/numsperrow
    local gap_y=(height_prefablist-size_prefab*numspercol)/numspercol
    --print("self.root.bg.prefabbg.prefablist:GetSize():"..tostring(width_prefablist)..","..tostring(width_prefablist))
    --print("row,col:"..tostring(numsperrow)..","..tostring(numspercol))
    local x = -width_prefablist/2
    local y = height_prefablist/2
    --print(x,y)
    for i = 1+numsperpage*(self.numpage-1), math.min(listnums, numsperpage*(1+self.numpage-1)) do
        if math.ceil((i-numsperpage*(self.numpage-1))/numsperrow) ~= math.ceil((i-numsperpage*(self.numpage-1)-1)/numsperrow) then 
            x = 0 
        else x = x + gap_x+size_prefab
        end
        y = -size_prefab*(math.ceil((i-numsperpage*(self.numpage-1))/numsperrow)-1)-gap_y
        self.root.bg.prefabbg.prefablist.listslot[i] = self.root.bg.prefabbg.prefablist:AddChild(ImageButton("images/quagmire_recipebook.xml", "cookbook_known.tex"))
            local width_listslot,height_listlot=self.root.bg.prefabbg.prefablist.listslot[i]:GetSize()
            local scale_listlot=size_prefab/width_listslot
	        self.root.bg.prefabbg.prefablist.listslot[i]:SetScale(scale_listlot,scale_listlot)
            local gainfocus_scalex=(width_listslot*scale_listlot+2*gap_x)/width_listslot
            local gainfocus_scaley=(height_listlot*scale_listlot+2*gap_y)/height_listlot
            width_listslot=width_listslot*scale_listlot
            height_listlot=height_listlot*scale_listlot
            --(width_listslot+2*gap_x)/width_listslot
            --(height_listlot+2*gap_y)/height_listlot
            self.root.bg.prefabbg.prefablist.listslot[i]:SetPosition(x-width_prefablist/2+width_listslot/2, y+height_prefablist/2-height_listlot/2)
            --self.root.bg.prefabbg.prefablist.listslot[i]:SetNormalScale(.8,.8,1)
	        --self.root.bg.prefabbg.prefablist.listslot[i]:SetFocusScale(.8,.8,1)
            --self.root.bg.prefabbg.prefablist.listslot[i]:ScaleTo(.85,.85,1)
	        self.root.bg.prefabbg.prefablist.listslot[i]:SetOnGainFocus(function() self.root.bg.prefabbg.prefablist.listslot[i]:SetScale(gainfocus_scalex,gainfocus_scaley) end)
		    self.root.bg.prefabbg.prefablist.listslot[i]:SetOnLoseFocus(function() self.root.bg.prefabbg.prefablist.listslot[i]:SetScale(scale_listlot,scale_listlot) end)
        
        self.root.bg.prefabbg.prefablist.listslot[i].im = self.root.bg.prefabbg.prefablist.listslot[i]:AddChild(Image("images/inventoryimages.xml",list.name.en[i]..".tex"))    
        self.root.bg.prefabbg.prefablist.listslot[i].im = self.root.bg.prefabbg.prefablist.listslot[i]:AddChild(Image("images/inventoryimages1.xml",list.name.en[i]..".tex"))
        self.root.bg.prefabbg.prefablist.listslot[i].im = self.root.bg.prefabbg.prefablist.listslot[i]:AddChild(Image("images/inventoryimages2.xml",list.name.en[i]..".tex"))
        self.root.bg.prefabbg.prefablist.listslot[i].im = self.root.bg.prefabbg.prefablist.listslot[i]:AddChild(Image("images/inventoryimages3.xml",list.name.en[i]..".tex"))
		    self.root.bg.prefabbg.prefablist.listslot[i].im:SetPosition(0, 0, 0)
		    self.root.bg.prefabbg.prefablist.listslot[i].im:SetScale(1,1,1)
        local hovertext = list.name.zh[i] or list.name.en[i]-- .. "\n类型:" .. tostring(list.tag.type[i]) .. "/饥饿: ".. tostring(list.tag.hunger[i]) .."/".."精神: "..tostring(list.tag.sanity[i]) .."/".."生命: ".. tostring(list.tag.health[i])
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
            self.root.bg.foodinfo.title:SetString(list.name.zh[i] or list.name.en[i])
            self.root.bg.foodinfo.prefab:SetTexture("images/quagmire_recipebook.xml", "blank.tex")
            self.root.bg.foodinfo.prefab:SetTexture("images/inventoryimages.xml",list.name.en[i]..".tex")
            self.root.bg.foodinfo.prefab:SetTexture("images/inventoryimages1.xml",list.name.en[i]..".tex")
            self.root.bg.foodinfo.prefab:SetTexture("images/inventoryimages2.xml",list.name.en[i]..".tex")
            self.root.bg.foodinfo.prefab:SetTexture("images/inventoryimages3.xml",list.name.en[i]..".tex")
            self.root.bg.foodinfo.prefab:SetScale(1.25)
            self.root.bg.foodinfo.prefab:SetHealthValue(tostring(list.tag.health[i]))
            if(list.tag.health[i]<0) then
                self.root.bg.foodinfo.prefab:SetHealthColour({255,0,0,1})
            else
                self.root.bg.foodinfo.prefab:SetHealthColour({0,0,0,1})
            end
            self.root.bg.foodinfo.prefab:SetHungerValue(tostring(list.tag.hunger[i]))
            if(list.tag.hunger[i]<0) then
                self.root.bg.foodinfo.prefab:SetHungerColour({255,0,0,1})
            else
                self.root.bg.foodinfo.prefab:SetHungerColour({0,0,0,1})
            end
            self.root.bg.foodinfo.prefab:SetSanityValue(tostring(list.tag.sanity[i]))
            if(list.tag.sanity[i]<0) then
                self.root.bg.foodinfo.prefab:SetSanityColour({255,0,0,1})
            else
                self.root.bg.foodinfo.prefab:SetSanityColour({0,0,0,1})
            end
            self.root.bg.foodinfo.prefab:SetAttribute(self.title)
            if self.title=="ingredient" then
                self.root.bg.foodinfo.attributebg.attribute:SetAttribute(list.attribute[i])
            end
            if self.title=="food" then

            end
        end)
    end
end

function FoodInfoScreen:Close()
    TheFrontEnd:PopScreen(self) -- 当取消时，弹出当前屏幕
end

return FoodInfoScreen -- 返回FoodInfoScreen类


