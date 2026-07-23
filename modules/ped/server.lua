--Eventually adding a load order setting to fix the "clothing movement" after upgrading game build
lib.callback.register('johnstrainer:ped:getCollectionLoadOrder', function(source,model)
    return {}
end)

lib.callback.register('johnstrainer:ped:getPedList',function(source)
    return constants.peds
end)