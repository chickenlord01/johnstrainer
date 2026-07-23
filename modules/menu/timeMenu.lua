local Menu = require("modules.menu.menuObject")
local MainMenu = require("modules.menu.mainMenu")

local timeMenu = Menu:new("johnstrainer:time","TimeOptions",{
    parent = "johnstrainer:worldRelatedMenu",
    position = 'top-right',
    onShow = function(args)
    GeneratetimeMenuOptions()    
    end
})

GeneratetimeMenuOptions = function()
    local options = lib.callback.await("johnstrainer:permissions:getMenuOptionPermissions",false,"TimeOptions")
    if #options == 0 then return end
    MiscMenu:setOptions(options)
end