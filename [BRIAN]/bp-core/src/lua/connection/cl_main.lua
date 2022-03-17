Citizen.CreateThread(function()

    while true do

        Wait(0)
        local isConnected = NetworkIsSessionStarted()

        if isConnected then

            TriggerServerEvent('bp-core:connection:playerSpawned')

        end

    end

end)