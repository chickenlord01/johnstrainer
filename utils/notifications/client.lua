while not Trainer do Wait(0) end
Trainer.Notification = {}

Trainer.Notification.SendNotification = function(data)
    if not data.title then data.title = "Admin" end
    lib.notify(data)
end