local Menu = require("modules.menu.menuObject")
local MainMenu = require("modules.menu.mainMenu")

local VehicleRelatedMenu = Menu:new("johnstrainer:vehicle","Vehicle",{
    parent = "johnstrainer:main",
    position = 'top-right',
    onShow = function(args)
        
    end
})