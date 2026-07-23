local Menu = require("modules.menu.menuObject")

local PedInheritanceMenu = Menu:new("johnstrainer:customizeped:inheritance","Inheritance",{
    parent = "johnstrainer:customizeped",
    position = 'top-right',
    onShow = function(args)
        GenerateInheritanceOptions()
    end
})

GenerateInheritanceOptions = function()
    local headList = GenerateHeadBlendList()
    local heads = Utils.GenerateValuesTable(headList.heads)
    local skins = Utils.GenerateValuesTable(headList.skins)
    local blends = Utils.GenerateValuesTable(constants.blendValues)

    local options = {
        {label = "Parent #1", values = heads, args = {heads = heads}},
        {label = "Parent #2", values = heads, args = {heads = heads}},
        {label = "Head Blend Mix", values = blends, args = {blends = blends}},
        {label = "Parent #1 Skin", values = skins, args = {skins = skins}},
        {label = "Parent #2 Skin", values = skins, args = {skins = skins}},
        {label = "Skin Mix", values = blends, args = {blends = blends}},
    }
    PedInheritanceMenu:setOptions(options)
end

GenerateHeadBlendList = function()
    local temp = {
        skins = {},
        heads = {}
    }
    for k,v in pairs(constants.headBlends) do
        local male = (string.find(v,"Male"))
        for i=0, GetPedHeadBlendNumHeads(k) do
            local headLabel = GetFilenameForAudioConversation(tostring(v..i))
            if male then
                headlabel = headLabel.." Male"
            else
                headlabel = headLabel.." Female"
            end
                
            table.insert(temp.faces,headLabel)
            table.insert(temp.heads,headLabel)
        end
    end
    return temp
end

return PedInheritanceMenu