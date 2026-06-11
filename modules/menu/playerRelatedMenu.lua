local Menu = require("modules.menu.menuObject")
local MainMenu = require("modules.menu.mainMenu")

local PlayerRelatedMenu = Menu:new("johnstrainer:playerrelated","Player Related",{
    parent = "johnstrainer:main",
    position = 'top-right',
    onShow = function(args)
        GeneratePlayerRelatedOptions()
    end
})
local PlayerOptionsMenu = Menu:new("johnstrainer:playeroptions","Player Related Options",{
    parent = "johnstrainer:playerrelated",
    position = 'top-right',
    onPressed = function(selected, scrollIndex, args)
        
    end,
    onShow = function(args)
        GeneratePlayerOptions()
    end
})
local PlayerAppearanceMenu = Menu:new("johnstrainer:playerappearance","Player Appearance",{
    parent = "johnstrainer:playerrelated",
    position = 'top-right',
    onShow = function(args)
        GeneratePlayerAppearanceOptions()
    end
})
local PlayerCharactersMenu = Menu:new("johnstrainer:playercharacters","Player Characters",{
    parent = "johnstrainer:playerrelated",
    position = 'top-right',
    onPressed = function(selected, scrollIndex, args)
        
    end,
    onShow = function(args)
        
    end
})

GeneratePlayerOptions = function()
    local options = lib.callback.await("johnstrainer:permissions:getMenuOptionPermissions",false,"player_options")
    if #options == 0 then return end

    PlayerOptionsMenu:setOptions(options)
end

GeneratePlayerRelatedOptions = function()
    local options = lib.callback.await("johnstrainer:permissions:getMenuOptionPermissions",false,"player_related")
    if #options == 0 then return end

    PlayerRelatedMenu:setOptions(options)
end

GeneratePlayerAppearanceOptions = function()
    local options = lib.callback.await("johnstrainer:permissions:getMenuOptionPermissions",false,"player_appearance")
    if #options == 0 then return end

    PlayerAppearanceMenu:setOptions(options)
end

return PlayerRelatedMenu,PlayerOptionsMenu,PlayerAppearanceMenu,PlayerCharactersMenu