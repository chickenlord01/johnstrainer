local Menu = require("modules.menu.menuObject")
local MainMenu = require("modules.menu.mainMenu")

local RecordingMenu = Menu:new("johnstrainer:recording","Recording",{
    parent = "johnstrainer:main",
    position = 'top-right',
    onShow = function(args)
        
    end
})