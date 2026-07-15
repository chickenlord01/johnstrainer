local Menu = require("modules.menu.menuObject")
local PedClothingMenu = Menu:new("johnstrainer:customizeped:clothing","Clothing",{
    parent = "johnstrainer:customizeped",
    position = 'top-right',
    onScroll = function(selected, scrollIndex, args)
        HandlePedClothingUpdate(cache.ped,{
            selected = selected,
            scrollIndex = scrollIndex,
            args = args
        })
    end,
    onPressed = function(selected, scrollIndex, args)
        args.scrollIndex = scrollIndex
        HandlePedClothingUpdate(cache.ped,{
            selected = selected,
            args = args
        })
    end,
    onShow = function(args)
        GeneratePedClothingOptions()
    end
})

HandlePedClothingUpdate = function(ped,data)
    local drawable = {}
    if data.scrollIndex then
        drawable = data.args.drawables[data.scrollIndex]
        SetPedCollectionComponentVariation(cache.ped,drawable.component,drawable.collection,drawable.localIndex,drawable.texture or 0,0)
    else
        if not data.args.values then return end

        drawable = data.args.drawables[data.args.scrollIndex]
        local texture = GetPedTextureVariation(ped,drawable.component)
        if texture < drawable.textures then
            texture = texture + 1
        elseif texture == drawable.textures then
            texture = 0
        end
        SetPedCollectionComponentVariation(cache.ped,drawable.component,drawable.collection,drawable.localIndex,texture,0)

        PedClothingMenu:showMenu()
    end
end

GeneratePedClothingOptions = function(ped,isFreemode,componentData,currentComponent)
    if not ped then ped = cache.ped end
    if isFreemode == nil then isFreemode = Trainer.Functions.ped.isPedFreemode(ped) end
    
    if not componentData then
        componentData = Trainer.Functions.ped.generateDrawableTables(ped)
    end
    if not currentComponent then
        currentComponent = Trainer.Functions.ped.generatePedDrawableTable(ped)
    end

    local clothingOptions = {}
    for index,drawables in pairs(componentData) do
        if not isFreemode or (index ~= 1 or index ~= 3) then
            if #drawables >= 1 then
                local values = {}
                for k,v in pairs(drawables) do
                    table.insert(values,k,{
                        label = "Textures: "..(currentComponent[index].texture or 0).."/"..v.textures,
                        --description = "Textures: "..(currentComponent[index].texture or 0).."/"..v.textures,
                        globalIndex = v.globalIndex
                    })
                end

                table.insert(clothingOptions,{
                    label = constants.pedComponentNames[index],
                    values = values,
                    args = {values = values, drawables = drawables},
                    defaultIndex = currentComponent[index].globalIndex+1,
                    close = false
                })
            else
                table.insert(clothingOptions,{
                    label = constants.pedComponentNames[index],
                    args = {drawables = drawables},
                    description = "No drawables",
                    close = false
                })
            end
        end
    end
    PedClothingMenu:setOptions(clothingOptions)
    return clothingOptions
end

return PedClothingMenu