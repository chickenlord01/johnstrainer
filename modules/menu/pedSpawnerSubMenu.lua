local Menu = require("modules.menu.menuObject")

local pedSubMenus = {}

for _,category in pairs(constants.pedCategories) do
    pedSubMenus[category] = Menu:new("johnstrainer:spawnped:"..category,category,{
        parent = "johnstrainer:spawnped",
        position = 'top-right'
    })
end

return pedSubMenus