local Menu = require("modules.menu.menuObject")
local PedPropMenu = Menu:new("johnstrainer:customizeped:prop","Props",{
    parent = "johnstrainer:customizeped",
    position = 'top-right',
    onScroll = function(selected, scrollIndex, args)
        HandlePedPropUpdate(cache.ped,{
            selected = selected,
            scrollIndex = scrollIndex,
            args = args
        })
    end,
    onPressed = function(selected, scrollIndex, args)
        args.scrollIndex = scrollIndex
        HandlePedPropUpdate(cache.ped,{
            selected = selected,
            args = args
        })
    end,
    onShow = function(args)
        GeneratePedPropOptions()
    end
})

HandlePedPropUpdate = function(ped,data)
    local drawable = {}
    if #data.args.drawables <= 1 or data.scrollIndex == 1 or data.args.scrollIndex == 1 then return end
    if data.scrollIndex then
        drawable = data.args.drawables[data.scrollIndex]
        if not drawable.collection then
            ClearPedProp(ped,drawable.anchor)
        else
            SetPedCollectionPropIndex(cache.ped,drawable.anchor,drawable.collection,drawable.localIndex,drawable.texture or 0,true)
        end
    else
        if not data.args.values then return end

        drawable = data.args.drawables[data.args.scrollIndex]
        local texture = GetPedPropTextureIndex(ped,drawable.anchor)
        if texture < drawable.textures then
            texture += 1
        else
            texture = 0
        end
        SetPedCollectionPropIndex(cache.ped,drawable.anchor,drawable.collection,drawable.localIndex,texture,true)

        PedPropMenu:showMenu()
    end
end

GeneratePedPropOptions = function(ped,isFreemode,propData,currentProp)
    if not ped then ped = cache.ped end
    if isFreemode == nil then isFreemode = Trainer.Functions.ped.isPedFreemode(ped) end
    
    if not propData then
        propData = Trainer.Functions.ped.generatePedPropTable(ped)
    end
    if not currentProp then
        currentProp = Trainer.Functions.ped.generatePedCurrentPropTable(ped)
    end

    local propOptions = {}
    for index,drawables in pairs(propData) do
        if #drawables >= 1 then
            local values = {}
            for menuIndex,drawable in pairs(drawables) do
                local label = "Textures: "..(currentProp[index].texture or 0).."/"..drawable.textures
                if not drawable.collection then
                    label = "No "..constants.pedPropNames[index]
                end
                table.insert(values,menuIndex,{
                    label = label,
                    globalIndex = drawable.globalIndex
                })
            end
            
            table.insert(propOptions,{
                label = constants.pedPropNames[index],
                values = values,
                args = {values = values, drawables = drawables},
                defaultIndex = currentProp[index].menuIndex,
                close = false
            })
        else
            table.insert(propOptions,{
                label = constants.pedPropNames[index],
                args = {drawables = drawables},
                description = "No props",
                close = false
            })
        end
    end
    PedPropMenu:setOptions(propOptions)
    return propOptions
end

return PedPropMenu