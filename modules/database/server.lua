--Setup database usage
local dbType = GetConvar("johnstrainer.databaseType","kvp")
local dbLoc = GetConvar("johnstrainer.databaseLocation","local")
if Trainer.framework == "johnsframework" then dbType = "johnsframework" end

if dbLoc == "remote" then
    
end

function getFilesInDirectory(dir,fileName)
    if not dir then dir = "/data" end
    if not fileName then fileName = ".json" end
    local files,_ = lib.getFilesInDirectory(dir,fileName)
    local returnData = {}
    for k,v in pairs(files) do
        local tempVar = string.gsub(v,".json","")
        returnData[tempVar] = {
            index = k,
            fileName = v,
            fullLocation = dir.."/"..v
        }
    end
    return returnData
end

function saveDataJson(data,fileName)
    if not fileName then print("Failed to save data to json. No fileName...") return false end
    table.sort(data,function(a,b)
        return (a.name or a.id or a.model) < (b.name or b.id or b.model)
    end)
    SaveResourceFile(GetCurrentResourceName(),"data/"..fileName,json.encode(data,{indent=true}),-1)
    return true
end