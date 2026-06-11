local Menu = require("modules.menu.menuObject")

local MainMenu = Menu:new("johnstrainer:main","Main Menu",{
    position = 'top-right',
    onShow = function()
        GenerateMainMenuOptions()
    end
})

GenerateMainMenuOptions = function()
    local options = lib.callback.await("johnstrainer:permissions:getMenuOptionPermissions",false,"main")
    if #options == 0 then return end
    MainMenu:setOptions(options)
end

RegisterCommand('opentrainer', function()
    MainMenu:showMenu()
end,false)

RegisterNetEvent('johnstrainer:menu:openMainMenu', function()
    if GetInvokingResource() ~= GetCurrentResourceName() then return end
    MainMenu:showMenu()
end)
return MainMenu