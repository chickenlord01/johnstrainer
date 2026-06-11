local Menu = require("modules.menu.menuObject")
local PlayerRelatedMenu,PlayerOptionsMenu,PlayerAppearanceMenu,PlayerCharactersMenu = require("modules.menu.playerRelatedMenu")

local PedCustomizeMenu = Menu:new("johnstrainer:customizeped","Customize Ped",{
    parent = "johnstrainer:playerappearance",
    position = 'top-right',
    onShow = function(args)
        GeneratePedCustomizationOptions()
    end
})
local PedPropMenu = Menu:new("johnstrainer:customizeped:prop","Props",{
    parent = "johnstrainer:customizeped",
    position = 'top-right',
    onShow = function(args)
    end
})
local PedClothingMenu = Menu:new("johnstrainer:customizeped:clothing","Clothing",{
    parent = "johnstrainer:customizeped",
    position = 'top-right',
    onShow = function(args)
        
    end
})
local PedInheritanceMenu = Menu:new("johnstrainer:customizeped:inheritance","Inheritance",{
    parent = "johnstrainer:customizeped",
    position = 'top-right',
    onShow = function(args)
    end
})
local PedAppearanceMenu = Menu:new("johnstrainer:customizeped:appearance","Appearance",{
    parent = "johnstrainer:customizeped",
    position = 'top-right',
    onShow = function(args)
    end
})
local PedFaceMenu = Menu:new("johnstrainer:customizeped:face","Face",{
    parent = "johnstrainer:customizeped",
    position = 'top-right',
    onShow = function(args)
    end
})
local PedTattoosMenu = Menu:new("johnstrainer:customizeped:tattoos","Tattoos",{
    parent = "johnstrainer:customizeped",
    position = 'top-right',
    onShow = function(args)
    end
})

GeneratePedClothingOptions = function(ped,isFreemode,componentData,currentComponent)
    if not ped then ped = cache.ped end
    if isFreemode == nil then isFreemode = Trainer.Functions.ped.isPedFreemode(ped) end

    local clothingOptions = {}
    for index,drawables in pairs(componentData) do
        if not isFreemode or (index ~= 1 or index ~= 3) then
            if #drawables >= 1 then
                local values = Trainer.Functions.generateValuesTable(drawables)
                table.insert(clothingOptions,{
                    label = constants.pedComponentNames[index],
                    values = values,
                    args = {drawables = drawables},
                    defaultIndex = Trainer.Functions.generateDefaultValuesIndex(values,currentComponent),
                    close = false
                })
            else
                table.insert(clothingOptions,{
                    label = constants.pedComponentNames[index],
                    args = {drawables = drawables},
                    description = "No drawables",
                    close = false
                })
            end
        end
    end
    return clothingOptions
end
GeneratePedPropOptions = function(ped,isFreemode,propData,currentProp)
    if not ped then ped = cache.ped end
    if isFreemode == nil then isFreemode = Trainer.Functions.ped.isPedFreemode(ped) end

    local propOptions = {}
    for index,drawables in pairs(propData) do
        if not isFreemode or (index ~= 1 or index ~= 3) then
            if #drawables >= 1 then
                local values = Trainer.Functions.generateValuesTable(drawables)
                table.insert(propOptions,{
                    title = constants.pedPropNames[index],
                    values = values,
                    args = {drawables = drawables},
                    defaultIndex = Trainer.Functions.generateDefaultValuesIndex(values,currentProp),
                    close = false
                })
            else
                table.insert(propOptions,{
                    label = constants.pedPropNames[index],
                    args = {drawables = drawables},
                    description = "No props",
                    close = false
                })
            end
        end
    end
    return propOptions
end

GeneratePedCustomizationOptions = function()
    if not ped then ped = cache.ped end
    local isFreemode = Trainer.Functions.ped.isPedFreemode(ped)
    local componentData,propData = Trainer.Functions.ped.generateDrawableTables(ped)
    local currentComponent, currentProp = Trainer.Functions.ped.generatePedDrawableTable(ped), Trainer.Functions.ped.generatePedPropTable(ped)
    local clothingOptions = GeneratePedClothingOptions(ped,isFreemode,componentData,currentComponent)
    local propOptions = GeneratePedPropOptions(ped,isFreemode,propData,currentProp)

    local options = {}
    if isFreemode then
        options = {
            {label = "Inheritance", args = {"johnstrainer:customizeped:inheritance"}},
            {label = "Appearance", args = {"johnstrainer:customizeped:appearance"}},
            {label = "Face shape", args = {"johnstrainer:customizeped:face"}},
            {label = "Tattoos", args = {"johnstrainer:customizeped:tattoos"}},
            {label = "Clothing", args = {"johnstrainer:customizeped:clothing"}},
            {label = "Props", args = {"johnstrainer:customizeped:props"}}
        }
        if #clothingOptions < 1 then
            table.remove(options,5)
        else
            PedClothingMenu:setOptions(clothingOptions)
        end
        if #propOptions < 1 then
            table.remove(options,6)
        else
            PedPropMenu:setOptions(propOptions)
        end
    else
        options = {
            {label = "Clothing", args = {"johnstrainer:customizeped:clothing"}},
            {label = "Props", args = {"johnstrainer:customizeped:props"}}
        }
        if #clothingOptions < 1 then
            table.remove(options,1)
        else
            PedClothingMenu:setOptions(clothingOptions)
        end
        if #propOptions < 1 then
            table.remove(options,2)
        else
            PedPropMenu:setOptions(propOptions)
        end
    end
    PedCustomizeMenu:setOptions(options)
end

return PedCustomizeMenu,PedPropMenu,PedClothingMenu,PedInheritanceMenu,PedAppearanceMenu,PedFaceMenu,PedTattoosMenu