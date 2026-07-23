local Menu = require("modules.menu.menuObject")
local MainMenu = require("modules.menu.mainMenu")

local RecordingMenu = Menu:new("johnstrainer:recording","Recording",{
    parent = "johnstrainer:main",
    position = 'top-right',
    onShow = function(args)
        
    end
})

GenerateRecordingMenuOptions = function()
    local options = lib.callback.await("johnstrainer:permissions:getMenuOptionPermissions",false,"Recording")
    if #options == 0 then return end
    MiscMenu:setOptions(options)
end