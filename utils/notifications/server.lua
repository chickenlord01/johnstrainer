while not Trainer do Wait(0) end
Trainer.Notification = {}

Trainer.Notification.SendNotification = function(source,data)
    if not data.title then data.title = "Admin" end
    TriggerClientEvent("ox_lib:notify",source,data)
end