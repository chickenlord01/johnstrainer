lib.callback.register('johnstrainer:getPlayerCoords', function(source,targetPlayer)
    if not targetPlayer then return GetEntityCoords(GetPlayerPed(source)) end
    return GetEntityCoords(GetPlayerPed(targetPlayer))
end)