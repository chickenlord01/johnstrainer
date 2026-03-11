local Database = {}

function Database:updateData(data,key)
    if data ~= nil then
        data = json.encode(data)
        SetResourceKvp(key,data)
        return GetResourceKvpString(key) == data
    else
        DeleteResourceKvp(key)
        return GetResourceKvpString(key) == nil
    end
end

function Database:getData(key)
    if not key then
        local tempData = {
            characters = {},
            vehicles = {},
            settings = Database:getData("johnstrainer_settings") or {}
        }
        local tempKey = StartFindKvp("johnstrainer_character_")
        while true do
            local kvpKey = FindKvp(tempKey)
            if kvpKey ~= nil then
                tempData.characters[kvpKey] = json.decode(GetResourceKvpString(kvpKey))
            else
                EndFindKvp(tempKey)
                break
            end
            Wait(0)
        end
        tempKey = StartFindKvp("johnstrainer_vehicle_")
        while true do
            local kvpKey = FindKvp(tempKey)
            if kvpKey ~= nil then
                tempData.vehicles[kvpKey] = json.decode(GetResourceKvpString(kvpKey))
            else
                EndFindKvp(tempKey)
                break
            end
            Wait(0)
        end
        return tempData
    else
        return json.decode(GetResourceKvpString(key))
    end
end