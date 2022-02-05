AddEventHandler('playerSpawned', function(hasSpawned)

    if not hasSpawned then

        return

    elseif hasSpawned then

        TriggerServerEvent('brianph-core:database:userCheckDatabase')

    end

end)