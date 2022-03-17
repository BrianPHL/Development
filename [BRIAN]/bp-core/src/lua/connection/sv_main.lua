local playerCount = 0

local establishingConnection = false
local inQueue                = false
local establishingConnList   = {}
local queueList              = {}

RegisterServerEvent('bp-core:connection:playerSpawned')
AddEventHandler('bp-core:connection:playerSpawned', function() 
    
    playerCount = playerCount + 1
    print(
        'Triggered server event:', 'bp-core:connection:playerSpawned'
    ) 

end)

AddEventHandler('playerDropped', function()

    playerCount = playerCount - 1
    print(
        'Triggered event handler:', 'playerDropped'
    )

end)


AddEventHandler('playerConnecting', function(playerName, kickReason, deferrals)

end)

Citizen.CreateThread(function()

    while true do

        Citizen.Wait(5000)

        local establishingConn = 'establishingConnection: ' .. json.encode(establishingConnList), establishingConnection
        local playerQueueing   = 'playerQueueing: ' .. json.encode(queueList), inQueue

        print(establishingConn)
        print(playerQueueing)

    end

end)