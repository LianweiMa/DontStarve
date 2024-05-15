--modmain.lua
GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})	
PrefabFiles = {     --scripts/prefabs文件夹下面我们自己的文件名，没有后缀
    "myfood"
}
--全部大写，最后面对应我们的预设物名
STRINGS.NAMES.MYFOOD = "myfood"    --显示的名字
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MYFOOD = "你好，坤莉！这不是给你吃的，是给宠物吃的！"    --人物检查时说的话

--[[
xxx.lua 预设物中记得加载贴图
local assets = {
	Asset( "IMAGE", "images/inventoryimages/xxx.tex" ),	
	Asset( "ATLAS", "images/inventoryimages/xxx.xml" ),
}
--]]
AddRecipe2("myfood", {Ingredient("cutgrass", 2), Ingredient("twigs", 2)}, TECH.NONE, {atlas = "images/inventoryimages/myfood.xml"})