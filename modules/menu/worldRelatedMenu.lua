local Menu = require("modules.menu.menuObject")
local MainMenu = require("modules.menu.mainMenu")

local WorldMenu = Menu:new("johnstrainer:world","World",{
    parent = "johnstrainer:main",
    position = 'top-right',
    onShow = function(args)
        
    end
})
GenerateWorldMenuOptions = function()
    local options = lib.callback.await("johnstrainer:permissions:getMenuOptionPermissions",false,"World")
    if #options == 0 then return end
    MiscMenu:setOptions(options)
end