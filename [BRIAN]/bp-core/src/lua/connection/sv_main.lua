local playerCount = 1

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

    local function userAttemptConnection()

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

                        print(playerCount .. '/' .. maxPlayers)
    
                        attemptingConnection = false

                        if playerCount >= maxPlayers then

                            userWaitQueue()
                            print('has queue')

                        elseif playerCount <= maxPlayers then

                            userEstablishConnection()
                            print('no queue')

                        end
    
                    end
    
                end
    
            end
    
        end

    end

    local function userInsertDatabase(src)

        local steamIdentifier = getSteamIdentifier(src)
        local steamUsername   = getNameIdentifier(src)
        local fivemLicense    = getLicenseIdentifier(src)

        local args   = [[INSERT INTO core_users (steamUsername, steamIdentifier, fivemLicense) VALUES (@steamUsername, @steamIdentifier, @fivemLicense)]]
        local params = {

            ['@steamIdentifier'] = steamIdentifier,
            ['@steamUsername']   = steamUsername,
            ['@fivemLicense']    = fivemLicense

        }

        MySQL.insert(args, params)

    end

    local function checkUserStatus(steamIdentifier)

        local args   = [[SELECT userStatus FROM core_users WHERE steamIdentifier = @steamIdentifier]]
        local params = {['@steamIdentifier'] = steamIdentifier }

        MySQL.query(args, params, function(queryResult)

            if not next(queryResult) then 
            
                userInsertDatabase(src)
            
            end
        
            if next(queryResult) then 
                
                for _, data in pairs(queryResult) do

                    local userStatus = data.userStatus

                    if userStatus ~= 'banned' then

                        userAttemptConnection()

                    else

                        -- TODO: In the future, make a temporary ban handler
                        deferrals.done('You are banned from joining the server')

                    end

                end
            
            end

        end)

    end

    checkUserStatus(steamIdentifier)

end)