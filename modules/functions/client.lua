Trainer.Functions = {}


Trainer.Functions.ped = {}

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
                    textures = GetNumberOfPedCollectionTextureVariations(ped,v,collection,drawable),
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
                    textures = GetNumberOfPedCollectionPropTextureVariations(ped,v,collection,prop),
                    anchor = v
                })
            end
            table.insert(tempData[collection].props,k,propData)
        end
    end
    --print(json.encode(tempData,{indent=true}))
    return tempData
end
Trainer.Functions.ped.generateCollectionsTable = generateCollectionsTable

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