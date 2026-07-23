local Menu = require("modules.menu.menuObject")
local MainMenu = require("modules.menu.mainMenu")

local weatherMenu = Menu:new("johnstrainer:weather","WeatherOptions",{
    parent = "johnstrainer:worldRelatedMenu",
    position = 'top-right',
    onShow = function(args)
    GenerateweatherMenuOptions()    
    end
})

GenerateweatherMenuOptions = function()
    local options = lib.callback.await("johnstrainer:permissions:getMenuOptionPermissions",false,"WeatherOptions")
    if #options == 0 then return end
    MiscMenu:setOptions(options)
end