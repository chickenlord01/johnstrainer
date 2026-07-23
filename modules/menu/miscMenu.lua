local Menu = require("modules.menu.menuObject")
local MainMenu = require("modules.menu.mainMenu")

local MiscMenu = Menu:new("johnstrainer:misc","Misc",{
    parent = "johnstrainer:main",
    position = 'top-right',
    onShow = function(args)
        
    end
})