AddEventHandler('playerSpawned', function(hasSpawned)

    local src = source

    if hasSpawned then

        TriggerServerEvent('brianph-core:queueHandler:playerSpawned', src)

    end

end)