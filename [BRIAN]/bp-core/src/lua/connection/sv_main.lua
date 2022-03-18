local playerCount = 0

local attemptingConnection   = false
local establishingConnection = false
local inQueue                = false
local attemptingConnList     = {}
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

    local src             = source
    local steamIdentifier = getSteamIdentifier(src)
    local maxPlayers      = GetConvarInt('sv_maxclients')

    deferrals.defer()

    local function checkUserStatus()

        local query  = [[SELECT userStatus FROM core_users WHERE steamIdentifier = @steamIdentifier]]
        local params = {['@steamIdentifier'] = steamIdentifier }

        MySQL.query(query, params, function(queryResult)
        
            if next(queryResult) then 
                
                print('not nil')
            
            end

            if not next(queryResult) then 
            
                print('is nil')
            
            end

        end)

    end

    checkUserStatus(steamName)

    attemptingConnection = true

    if attemptingConnection then

        local steamIdentifier = getSteamIdentifier(src)
        table.insert(attemptingConnList, steamIdentifier)

        local connectTimeout = 50

        while attemptingConnection do

            Wait(1)

            local steamIdentifier = getSteamIdentifier(src)
            local tablePos        = getTablePosition(steamIdentifier, attemptingConnList)

            if not steamIdentifier then

                table.remove(attemptingConnList, tablePos)
                attemptingConnection = false
                return

            end

            connectTimeout = connectTimeout - 1

            if connectTimeout < 0 then 
                connectTimeout = 0 
            end

            if connectTimeout == 0 then

                local steamIdentifier = getSteamIdentifier(src)
                local tablePos        = getTablePosition(steamIdentifier, attemptingConnList)
                table.remove(attemptingConnList, tablePos)

                local isInList = checkTableContent(steamIdentifier, attemptingConnList)

                if not isInList then

                    attemptingConnection = false

                end

            end

        end

    end

end)