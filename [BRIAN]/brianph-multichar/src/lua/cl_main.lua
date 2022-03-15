RegisterCommand('test', function()

    SendNUIMessage({type = 'stateObserver', isEnabled = true})
    SetNuiFocus(true, true)

    print('Prompted character selection to player')

end)

AddEventHandler('playerSpawned', function(isSpawned)

    if isSpawned then

        SendNUIMessage({type = 'stateObserver', isEnabled = true})
        SetNuiFocus(true, true)

        print('Prompted character selection to player')
        
    end

end)