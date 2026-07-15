local Utils = {}
Utils.GenerateValuesTable = function(data,settings)
    local temp = {}
    for k, v in pairs(data) do
        if type(v) == "string" then
            temp[k] = {label = v}
        elseif type(v) == "table" then
            temp[k] = {label = v.id or v.name or v.label}
        else
            temp[k] = {label = tostring(v)}
        end
    end
    return temp
end

return Utils