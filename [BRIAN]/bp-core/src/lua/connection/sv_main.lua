local attemptingList        = {}

local attemptingCount       = 0
local playerCount           = 0

local canAttemptConnection  = false
local attemptConnection     = false
local canConnect            = true
local canAttemptConnection2 = true

RegisterServerEvent('bp-core:connection:playerSpawned')
AddEventHandler('bp-core:connection:playerSpawned', function() 
    
    canConnect = true
    playerCount  = playerCount + 1
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

function userRemoveTable()

    table.remove(attemptingList, 1)

end

AddEventHandler('playerConnecting', function(playerName, kickReason, deferrals)

    deferrals.defer()

    local src             = source
    local steamIdentifier = getSteamIdentifier(src)
    local nameIdentifier  = getNameIdentifier(src)

    Citizen.Wait(1)

    deferrals.update('👋 Welcome ' .. nameIdentifier .. ' [' .. steamIdentifier .. ']')

    table.insert(attemptingList, nameIdentifier)

    attemptingCount   = attemptingCount + 1
    attemptConnection = true

    while not canAttemptConnection do

        Wait(1)

    end

    while canAttemptConnection do

        Citizen.Wait(1)
    
        local nameIdentifier = getNameIdentifier(src)

        local inList = checkTableContent(nameIdentifier, attemptingList)  
        print(inList)
        while inList do Citizen.Wait(1) end

        if not inList then
            
            Citizen.Wait(1)
            deferrals.done('CONNECTION ESTABLISHED')

        end

    end

end)

Citizen.CreateThread(function()

    local attemptTimeout = 50

    while true do

        Citizen.Wait(1)

        while attemptConnection do

            Citizen.Wait(1)

            attemptTimeout = attemptTimeout - 1

            if attemptTimeout < 0 then 
                attemptTimeout = 0 
            end

            if attemptTimeout == 0 then

                attemptTimeout = 50

                if attemptingCount >= 1 then

                    attemptingCount = attemptingCount - 1 
                    canAttemptConnection = true
                    attemptConnection = true

                    userRemoveTable()

                elseif attemptingCount == 0 then

                    canAttemptConnection = false
                    attemptConnection = false
        
                end

            end

        end

    end

end)

Citizen.CreateThread(function()

    while true do

        Citizen.Wait(500)

        print('attemptingCount: ' .. attemptingCount)
        print('attemptingList: ' .. json.encode(attemptingList))
        print('attemptConnection: ', attemptConnection)
        print('canAttemptConnection: ', canAttemptConnection)
        print('canAttemptConnection2: ', canAttemptConnection2)

    end

end)
