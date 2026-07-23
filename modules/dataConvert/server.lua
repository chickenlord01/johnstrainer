require("modules.database.server")
Trainer.DataConversion = {}
local function convertPeds()
    local pedData = lib.loadJson("dataConvert.peds")
    local tempData = {}
    for index,pedModel in pairs(pedData) do
        tempData[index] = {
            label = pedModel.TranslatedDirectorName?.English or pedModel.Name,
            model = pedModel.Name,
            dlc = pedModel.DlcName,
            type = string.lower(pedModel.Pedtype)
        }
    end
    return tempData
end
Trainer.DataConversion.convertPeds = convertPeds

constants.peds = Trainer.DataConversion.convertPeds()