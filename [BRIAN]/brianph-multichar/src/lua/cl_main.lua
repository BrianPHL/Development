AddEventHandler('playerSpawned', function(isSpawned)

    if isSpawned then

        SendNUIMessage({type = 'stateObserver', isEnabled = true})
        print('Prompted character selection to player')

    end

end)