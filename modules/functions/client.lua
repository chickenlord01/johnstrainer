Trainer.Functions = {}
while not Trainer.Ped do Wait(0) end

Trainer.Functions.ped = {}

-- Generate full list of collection data
local function generateCollectionsTable(ped)
    if not ped then ped = cache.ped end
    local tempData = {}
    for index = 0, GetPedCollectionsCount(ped)-1 do
        local collection = GetPedCollectionName(ped,index)
        tempData[collection] = {
            id = collection,
            collectionIndex = index,
            components = {},
            props = {}
        }
        for k,v in pairs(constants.pedComponents) do
            local componentData = {}
            for drawable = 0, GetNumberOfPedCollectionDrawableVariations(ped,v,collection)-1 do
                table.insert(componentData,drawable+1,{
                    localIndex = drawable,
                    globalIndex = GetPedDrawableGlobalIndexFromCollection(ped,v,collection,drawable),
                    collection = collection,
                    textures = GetNumberOfPedCollectionTextureVariations(ped,v,collection,drawable) -1,
                    component = v
                })
            end
            table.insert(tempData[collection].components,k,componentData)
        end
        
        for k,v in pairs(constants.pedProps) do
            local propData = {}
            for prop = 0, GetNumberOfPedCollectionPropDrawableVariations(ped,v,collection)-1 do
                table.insert(propData,prop+1,{
                    localIndex = prop,
                    globalIndex = GetPedPropGlobalIndexFromCollection(ped,v,collection,prop),
                    collection = collection,
                    textures = GetNumberOfPedCollectionPropTextureVariations(ped,v,collection,prop) -1,
                    anchor = v
                })
            end
            table.insert(tempData[collection].props,k,propData)
        end
    end
    --print(json.encode(tempData[""].props,{indent=true}))
    return tempData
end
Trainer.Functions.ped.generateCollectionsTable = generateCollectionsTable

local function generateDrawableTables(ped)
    if not ped then ped = cache.ped end
    --local loadOrder = Trainer.Ped.loadOrder[GetEntityModel(ped)]
    local collectionTable = generateCollectionsTable(ped)
    local componentTable = {}
    local propTable = {}
    for index,_ in pairs(constants.pedComponents) do
        componentTable[index] = {}
    end
    for index,_ in pairs(constants.pedProps) do
        propTable[index] = {}
    end
    if not loadOrder then
        for _,collectionData in pairs(collectionTable) do
            --component drawables
            for index,_ in pairs(constants.pedComponents) do
                for _,v in pairs(collectionData.components[index]) do
                    table.insert(componentTable[index],v)
                end
            end
            --prop drawables
            for index,_ in pairs(constants.pedProps) do
                for _,v in pairs(collectionData.props[index]) do
                    table.insert(propTable[index],v)
                end
            end
        end
    end
    return componentTable,propTable
end
Trainer.Functions.ped.generateDrawableTables = generateDrawableTables

-- Generate current ped appearance data
local function generatePedDrawableTable(ped)
    if not ped then ped = cache.ped end
    local tempTable = {}
    for k,v in pairs(constants.pedComponents) do
        local collection = GetPedDrawableVariationCollectionName(ped,v)
        local localIndex = GetPedDrawableVariationCollectionLocalIndex(ped,v)
        if collection then
            table.insert(tempTable,k,{
                component = v,
                globalIndex = GetPedDrawableGlobalIndexFromCollection(ped,v,collection,localIndex),
                collection = collection,
                index = localIndex,
                texture = GetPedTextureVariation(ped,v)
            })
        else
            table.insert(tempTable,k,{
                component = v
            })
        end
    end
    return tempTable
end
Trainer.Functions.ped.generatePedDrawableTable = generatePedDrawableTable

local function generatePedPropTable(ped)
    if not ped then ped = cache.ped end
    local tempTable = {}
    for k,v in pairs(constants.pedProps) do
        local collection = GetPedPropCollectionName(ped,v)
        print(json.encode(collection))
        local localIndex = GetPedPropCollectionLocalIndex(ped,v)
        if collection then
            table.insert(tempTable,k,{
                component = v,
                globalIndex = GetPedPropGlobalIndexFromCollection(ped,v,collection,localIndex),
                collection = collection,
                index = localIndex,
                texture = GetPedPropTextureIndex(ped,v)
            })
        else
            table.insert(tempTable,k,{
                component = v
            })
        end
    end
    return tempTable
end
Trainer.Functions.ped.generatePedPropTable = generatePedPropTable


--Decoration native https://docs.fivem.net/natives/?_0xFF56381874F82086
local function TattooBlobToTable(blob)
    local LockHash = string.unpack('<i4', blob, 1) & 0xFFFFFFFF -- uint (hash)
    local Index = string.unpack('<i4', blob, 9) -- int
    local Collection = string.unpack('<i4', blob, 17) & 0xFFFFFFFF -- uint (hash)
    local Preset = string.unpack('<i4', blob, 25) & 0xFFFFFFFF -- uint (hash)
    local Price = string.unpack('<i4', blob, 33) -- int
    local eFacing = string.unpack('<i4', blob, 41) -- TattooZoneData
    local UpdateGroup = string.unpack('<i4', blob, 49) -- uint (hash)
    local TextLabel = string.unpack('z', blob, 57) -- uint

    return {
        LockHash = LockHash,
        Index = Index,
        collection = Collection,
        preset = Preset,
        Price = Price,
        eFacing = eFacing,
        group = UpdateGroup,
        text = TextLabel
    }
end
local function GetTattooDlcItemDataTable(CharacterType, DecorationIndex)
	local blob = string.rep('\0\0\0\0\0\0\0\0', 7+16)
	if not Citizen.InvokeNative(0xFF56381874F82086, CharacterType, DecorationIndex, blob) then return nil end -- Data doesn't exist, return a nil

	return TattooBlobToTable(blob) -- Return the data table
end

local function generateDecorationsTable()
    local tempData = {
        male = {},
        female = {}
    }

    --Freemode Male
    local tattoNum = GetNumTattooShopDlcItems(3)
    for i = 0, tattoNum - 1 do
        local tattooData = GetTattooDlcItemDataTable(3,i)
        if tattooData then
            tempData.male[tattooData.collection] = {
                collection = tattooData.collection,
                zone = GetPedDecorationZoneFromHashes(tattooData.collection,tattooData.preset),
                overlay = tattooData.preset
            }
        end
    end
    --Freemode Female
    tattoNum = GetNumTattooShopDlcItems(4)
    for i = 0, tattoNum - 1 do
        local tattooData = GetTattooDlcItemDataTable(4,i)
        if tattooData then
            tempData.female[tattooData.collection] = {
                collection = tattooData.collection,
                zone = GetPedDecorationZoneFromHashes(tattooData.collection,tattooData.preset),
                overlay = tattooData.preset
            }
        end
    end
    return tempData
end
Trainer.Functions.ped.generateDecorationsTable = generateDecorationsTable

--Since tattoos don't change often, this generates the table on script start
Trainer.Ped.tattoos = generateDecorationsTable()

--Checks if ped is a freemode model, generally used for further customization options
local function isPedFreemode(ped)
    local modelHash = GetEntityModel(ped)
    if modelHash == `mp_m_freemode_01` or modelHash == `mp_f_freemode_01` then
        return true
    end
    return false
end
Trainer.Functions.ped.isPedFreemode = isPedFreemode

--Generates table used in ox_lib menu scroll index
--[[Trainer.Functions.generateDrawableValuesTable = function(values)
    local tempData = {}
    for k,v in pairs(values) do
        table.insert(tempData,k,{
            label = v.globalIndex,
            description = "Textures: /"..v.textures,
            globalIndex = v.globalIndex
        })
    end
    return tempData
end]]

Trainer.Functions.generateDefaultValuesIndex = function(values,currentData)
    if not currentData then return 1 end
    for k,value in pairs(values) do
        if value.globalIndex == currentData[value.globalIndex]?.globalIndex then
            return k
        end
    end
    return 1
end