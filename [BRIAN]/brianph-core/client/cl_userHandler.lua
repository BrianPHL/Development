AddEventHandler('playerSpawned', function(hasSpawned)

    if not hasSpawned then

        return

    elseif hasSpawned then

        TriggerServerEvent('brianph-core:userHandler:userCheckDatabase')

    end

end)
