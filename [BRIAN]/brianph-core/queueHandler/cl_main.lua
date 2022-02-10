-- ? Executes queueHandler:playerSpawned once player secures their connection with the server.

Citizen.CreateThread(function()

    while true do

        Wait(0)

        local isConnected = NetworkIsSessionStarted()

        if isConnected then

            TriggerServerEvent('brianph-core:queueHandler:playerSpawned')
            return

        end

    end

end)