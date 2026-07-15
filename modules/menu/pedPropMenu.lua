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
    if data.scrollIndex then
        drawable = data.args.drawables[data.scrollIndex]
        SetPedCollectionPropIndex(cache.ped,drawable.anchor,drawable.collection,drawable.localIndex,drawable.texture or 0,true)
    else
        if not data.args.values then return end

        drawable = data.args.drawables[data.args.scrollIndex]
        local texture = GetPedPropTextureIndex(ped,drawable.component)
        if texture < drawable.textures then
            texture = texture + 1
        elseif texture == drawable.textures then
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
        _,propData = Trainer.Functions.ped.generateDrawableTables(ped)
        --print(json.encode(propData))
    end
    if not currentProp then
        currentProp = Trainer.Functions.ped.generatePedPropTable(ped)
    end

    local propOptions = {}
    for index,drawables in pairs(propData) do
        --if not isFreemode then
            if #drawables >= 1 then
                local values = {}
                for k,v in pairs(drawables) do
                    table.insert(values,k,{
                        label = "Textures: "..(currentProp[index].texture or 0).."/"..v.textures,
                        globalIndex = v.globalIndex
                    })
                end
                --print(json.encode(index))
                --print(json.encode(drawables))
                --print(json.encode(values))
                --print(json.encode(currentProp))
                table.insert(propOptions,{
                    label = constants.pedPropNames[index],
                    values = values,
                    args = {values = values, drawables = drawables},
                    defaultIndex = currentProp,
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
        --end
    end
    PedPropMenu:setOptions(propOptions)
    return propOptions
end

return PedPropMenu