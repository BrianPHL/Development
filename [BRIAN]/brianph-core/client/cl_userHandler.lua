-- TODO: Make a function that runs the server event once 
-- TODO: the player starts connecting to the server.

RegisterCommand('1', function()

    TriggerServerEvent('brianph-core:userHandler:CheckDatabase')

end)