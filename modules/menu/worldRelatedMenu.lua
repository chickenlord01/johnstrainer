local Menu = require("modules.menu.menuObject")
local MainMenu = require("modules.menu.mainMenu")

local WorldMenu = Menu:new("johnstrainer:world","World",{
    parent = "johnstrainer:main",
    position = 'top-right',
    onShow = function(args)
        
    end
})