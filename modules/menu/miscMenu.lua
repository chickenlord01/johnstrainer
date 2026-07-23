local Menu = require("modules.menu.menuObject")
local MainMenu = require("modules.menu.mainMenu")

local MiscMenu = Menu:new("johnstrainer:misc","Misc",{
    parent = "johnstrainer:main",
    position = 'top-right',
    onShow = function(args)
    GenerateMiscMenuOptions()    
    end
})

GenerateMiscMenuOptions = function()
    local options = lib.callback.await("johnstrainer:permissions:getMenuOptionPermissions",false,"Misc")
    if #options == 0 then return end
    MiscMenu:setOptions(options)
end