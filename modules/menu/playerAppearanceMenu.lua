local Menu = require("modules.menu.menuObject")
local PlayerRelatedMenu,PlayerOptionsMenu,PlayerAppearanceMenu,PlayerCharactersMenu = require("modules.menu.playerRelatedMenu")
require("modules.menu.pedInheritanceMenu")
require("modules.menu.pedClothingMenu")
require("modules.menu.pedPropMenu")
require("modules.menu.pedSpawnerMenu")

local PedCustomizeMenu = Menu:new("johnstrainer:customizeped","Customize Ped",{
    parent = "johnstrainer:playerappearance",
    position = 'top-right',
    onShow = function(args)
        GeneratePedCustomizationOptions()
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

GeneratePedCustomizationOptions = function(ped)
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
        end
        if #propOptions < 1 then
            table.remove(options,6)
        end
    else
        options = {
            {label = "Clothing", args = {"johnstrainer:customizeped:clothing"}},
            {label = "Props", args = {"johnstrainer:customizeped:prop"}}
        }
        if #clothingOptions < 1 then
            table.remove(options,1)
        end
        if #propOptions < 1 then
            table.remove(options,2)
        end
    end
    PedCustomizeMenu:setOptions(options)
end

return PedCustomizeMenu,PedAppearanceMenu,PedFaceMenu,PedTattoosMenu