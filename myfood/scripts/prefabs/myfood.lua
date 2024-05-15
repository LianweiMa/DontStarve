-- 创建一个可以吃的食物
local assets=
{
    Asset("ANIM", "anim/myfood.zip"), -- 加载动画资源
    Asset("ATLAS", "images/inventoryimages/myfood.xml"), -- 加载图像资源
}

local function fn(Sim)
    local inst = CreateEntity() -- 创建一个新的实体
    inst.entity:AddTransform() -- 添加变换组件
    inst.entity:AddAnimState() -- 添加动画状态组件
    
    MakeInventoryPhysics(inst) -- 为实体添加物理属性
    inst:AddComponent("edible") -- 添加可食用组件
    inst.components.edible.healthvalue = 150 -- 设置食物的健康值为20
    inst.components.edible.hungervalue = 150 -- 设置食物的饥饿值为20
    inst.components.edible.sanityvalue = 200 -- 设置食物的精神值为10
    
    inst:AddComponent("stackable") -- 添加可堆叠组件
    
    inst:AddComponent("inspectable") -- 添加可检查组件
    
    inst:AddComponent("inventoryitem") -- 添加库存物品组件

    --物品放在地上的时候播放idle 动画
    inst.AnimState:SetBank("myfood") -- 设置动画库
    inst.AnimState:SetBuild("myfood") -- 设置动画构建
    inst.AnimState:PlayAnimation("idle") -- 播放"idle"动画
    
    inst.components.inventoryitem.atlasname = "images/inventoryimages/myfood.xml" -- 设置在物品栏的图像

    inst:AddComponent("tradable") -- 添加可交易组件
    
    return inst -- 返回创建的实体
end

return Prefab( "myfood", fn, assets) -- 返回一个预制物品，这个预制物品使用了上面定义的函数和资产