lib.callback.register('johnstrainer:keymap:getDefaultSettings', function(source)
    if IsPlayerAceAllowed(source,"command.opentrainer") then
        return {
            key = GetConvar("johnstrainer.defaultKey","M"),
            keyMapper = GetConvar("johnstrainer.defaultKeyMapper","keyboard")
        }
    end
    return false
end)