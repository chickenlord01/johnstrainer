local Menu = require("modules.menu.menuObject")

local pedSubMenus = {}

for _,category in pairs(constants.pedCategories) do
    pedSubMenus[category] = Menu:new("johnstrainer:spawnped:"..category,category,{
        parent = "johnstrainer:spawnped",
        position = 'top-right',
        onShow = function(args)
            if args.peds then
                GeneratePedCategoryOptions(args)
            end
        end
    })
end
for category,v in pairs(customCategories) do
    pedSubMenus[category] = Menu:new("johnstrainer:spawnped:"..category,category,{
        parent = "johnstrainer:spawnped",
        position = 'top-right',
        onShow = function(args)
            if args.peds then
                GeneratePedCategoryOptions(args)
            end
        end
    })
end

GeneratePedCategoryOptions = function(args)
    local options = {}
    for _,pedData in pairs(args.peds) do
        table.insert(options,{
            label = pedData.label,
            description = pedData.model,
            args = {pedData = pedData}
        })
    end
    table.sort(options,function(a,b)
        return a.label < b.label
    end)
    pedSubMenus[args.category]:setOptions(options)
    return options
end

return pedSubMenus