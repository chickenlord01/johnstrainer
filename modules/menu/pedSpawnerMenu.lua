local Menu = require("modules.menu.menuObject")

constants.peds = lib.callback.await("johnstrainer:ped:getPedList",false)
constants.pedCategories = {}
customCategories = require("utils.configuration.shared").pedCategories

for _,v in pairs(constants.peds) do
    if not lib.table.contains(constants.pedCategories,v.type) then
        table.insert(constants.pedCategories,v.type)
    end
end

local subMenus = require("modules.menu.pedSpawnerSubMenu")

local SpawnPedMenu = Menu:new("johnstrainer:spawnped","Spawn Ped",{
    parent = "johnstrainer:playerappearance",
    position = 'top-right',
    onPressed = function(selected, scrollIndex, args)
        subMenus[args.category]:showMenu(args)
    end,
    onShow = function(args)
        generatePedSpawnOptions()
    end
})

local function generatePedDataTable()
    local tempData = {}
    for k,v in pairs(constants.peds) do
        if not tempData[v.type] then
            tempData[v.type] = {}
        end
        table.insert(tempData[v.type],v)
    end
    return tempData
end

function generatePedSpawnOptions()
    local options = {}
    local categories = generatePedDataTable()
    for category,pedData in pairs(categories) do
        table.insert(options,{
            label = category,
            args = {category = category,peds = pedData}
        })
    end
    table.sort(options,function(a,b)
        return a.label < b.label
    end)
    for k,v in pairs(customCategories) do
        table.insert(options,1,{
            label = k,
            args = {category = k,peds = v}
        })
    end
    SpawnPedMenu:setOptions(options)
    return options
end

return SpawnPedMenu