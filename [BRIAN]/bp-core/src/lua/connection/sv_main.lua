-- local canConnect             = false
-- local connectingCount        = 0
-- local playerCount            = 0

-- local bataPaAkoKul           = true

-- local attemptingConnection   = false
-- local establishingConnection = false
-- local inQueue                = false
-- local attemptingConnList     = {}
-- local establishingConnList   = {}
-- local queueList              = {}

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

        while not canAttemptConnection2 do

            Citizen.Wait(1)

        end

        Citizen.Wait(1)

        canAttemptConnection2 = false
    
        local nameIdentifier = getNameIdentifier(src)
        table.remove(attemptingList, 1)
            
        local inList = checkTableContent(nameIdentifier, attemptingList)
                    
        while inList do
            
            Wait(1)
            
        end
            
        Citizen.Wait(1)
            
        canAttemptConnection2 = true
        deferrals.done()

    end

end)

Citizen.CreateThread(function()

    local attemptTimeout = 10

    while true do

        Citizen.Wait(1)

        while attemptConnection do

            Citizen.Wait(500)

            attemptTimeout = attemptTimeout - 1

            if attemptTimeout < 0 then 
                attemptTimeout = 0 
            end

            if attemptTimeout == 0 then

                attemptTimeout = 10

                if attemptingCount >= 1 then

                    attemptingCount = attemptingCount - 1 
                    canAttemptConnection = true
                    attemptConnection = true
                    
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

-- Citizen.CreateThread(function()

--     while attemptConnection do

--         Citizen.Wait(10000)

--         print('attemptConnection completed')

--         local nameIdentifier = getNameIdentifier(src)
--         local tablePos       = getTablePosition

--     end

-- end)
 
-- AddEventHandler('playerConnecting', function(playerName, kickReason, deferrals)

--     local src             = source
--     local steamIdentifier = getSteamIdentifier(src)
--     local maxPlayers      = 64
--     -- local maxPlayers      = GetConvarInt('sv_maxclients')

--     deferrals.defer()

--     connectingCount = connectingCount + 1

--     local function userEstablishConnection()

--         while not bataPaAkoKul do

--             Wait(1)

--         end

--         Citizen.Wait(1)

--         bataPaAkoKul = false
--         deferrals.done()

--     end

--     local function userWaitQueue()

--         print('a queue?!?! LOL')

--     end

--     local function userAttemptConnection()

--         attemptingConnection = true
--         canConnect           = true

--         if attemptingConnection then

--             Citizen.Wait(1)

--             local steamIdentifier = getSteamIdentifier(src)
--             local nameIdentifier = getNameIdentifier(src)

--             local function userWelcomeMsg()

--                 local splashWelcomeMsg = '👋 Welcome ' .. nameIdentifier .. ' [' .. steamIdentifier .. ']'
--                 deferrals.update(splashWelcomeMsg)

--             end

--             userWelcomeMsg()

--             Citizen.Wait(1500)

--             local function userAttemptMsg()

--                 local attemptConnMsg = 'Attempting to establish a connection'
--                 deferrals.update(attemptConnMsg)

--             end

--             userAttemptMsg()


--             table.insert(attemptingConnList, nameIdentifier)
    
--             while attemptingConnection do
    
--                 Wait(1)
    
--                 local nameIdentifier = getNameIdentifier(src)
--                 local tablePos       = getTablePosition(nameIdentifier, attemptingConnList)
    
--                 if not nameIdentifier then
    
--                     table.remove(attemptingConnList, tablePos)
    
--                 end

--                 function connectionTransitionHandler()

--                     connectingCount = connectingCount - 1

--                     canConnect           = true

--                     local nameIdentifier = getNameIdentifier(src)
--                     local tablePos       = getTablePosition(nameIdentifier, attemptingConnList)
--                     table.remove(attemptingConnList, 1)
        
--                     local isInList = checkTableContent(nameIdentifier, attemptingConnList)

--                     while isInList do
    
--                         Wait(2500)

--                     end

--                     while playerCount >= maxPlayers do

--                         Citizen.Wait(1)

--                         userWaitQueue()

--                     end
                    
--                     userEstablishConnection()

--                 end
    
--             end
    
--         end

--     end

--     local function userInsertDatabase(src)

--         local steamIdentifier = getSteamIdentifier(src)
--         local steamUsername   = getNameIdentifier(src)
--         local fivemLicense    = getLicenseIdentifier(src)

--         local args   = [[INSERT INTO core_users (steamUsername, steamIdentifier, fivemLicense) VALUES (@steamUsername, @steamIdentifier, @fivemLicense)]]
--         local params = {

--             ['@steamIdentifier'] = steamIdentifier,
--             ['@steamUsername']   = steamUsername,
--             ['@fivemLicense']    = fivemLicense

--         }

--         MySQL.insert(args, params)

--     end

--     local function checkUserStatus(steamIdentifier)

--         if not steamIdentifier then

--             Citizen.Wait(1)

--             local function missingSteamIdentifier()

--                 local missingIdentifierMsg = 'Unfortunately, you have no steam identifier or an error has occured. Please be sure to have your Steam client open or online when connecting. Steam authentication is a requirement in order for you to connect.' 
--                 deferrals.done(missingIdentifierMsg)

--             end

--             missingSteamIdentifier()

--             return

--         end

--         local args   = [[SELECT userStatus FROM core_users WHERE steamIdentifier = @steamIdentifier]]
--         local params = {['@steamIdentifier'] = steamIdentifier }

--         MySQL.query(args, params, function(queryResult)

--             if not next(queryResult) then 
            
--                 userInsertDatabase(src)
            
--             end
        
--             if next(queryResult) then 
                
--                 for _, data in pairs(queryResult) do

--                     local userStatus = data.userStatus

--                     if userStatus ~= 'banned' then

--                         userAttemptConnection()

--                     else

--                         -- TODO: In the future, make a temporary ban handler
--                         deferrals.done('You are banned from joining the server')

--                     end

--                 end
            
--             end

--         end)

--     end

--     checkUserStatus(steamIdentifier)

-- end)

-- Citizen.CreateThread(function()

--     local connectTimeout = 100

--     while true do

--         Citizen.Wait(1)

--         while canConnect do
        
--             Citizen.Wait(1)

--             connectTimeout = connectTimeout - 1
--             if connectTimeout <= 0 then connectTimeout = 0 end

--             if connectTimeout == 0 then

--                 connectionTransitionHandler()
--                 connectTimeout = 200
                
--                 if connectingCount > 0 then

--                     canConnect = true

--                 elseif connectingCount == 0 then

--                     canConnect = false

--                 end

--             end

--         end

--     end

-- end)

-- Citizen.CreateThread(function()
    
--     while true do

--         Citizen.Wait(500)

--         print(bataPaAkoKul)
--         -- print('Is player allowed to connect: ', canConnect)
--         -- print('Attempting connection: ' .. json.encode(attemptingConnList))
--         -- print('Establishing connection: ' .. json.encode(establishingConnList))
--         -- print('Player queueing: ' .. json.encode(queueList))

--     end

-- end)