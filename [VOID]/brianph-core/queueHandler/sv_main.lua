BRIANPH = BRIANPH or {}
BRIANPH.globalModules = BRIANPH.globalModules or {}

local elapsedTime = '00:00:00'
local userCount = 0 
local userList  = {}

RegisterServerEvent('brianph-core:queueHandler:playerSpawned')
AddEventHandler('brianph-core:queueHandler:playerSpawned', function()

    local src         = source
    local steam       = BRIANPH.globalModules.GetSteamIdentifier(src)

    userCount         = userCount + 1
    userList[source]  = true

    BRIANPH.globalModules.GenerateDatabaseLogs('playerConnected', steam)

end)

AddEventHandler('playerDropped', function()

    local src        = source
    local steam      = BRIANPH.globalModules.GetSteamIdentifier(src)

    userCount        = userCount - 1
    userList[source] = nil

    BRIANPH.globalModules.GenerateDatabaseLogs('playerDisconnected', steam)

end)

local attemptingConnectionList   = {}
local establishingConnectionList = {}
local queueList                  = {}

local attemptingConnection       = false
local establishingConnection     = false
local inQueue                    = false

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)

    local src                    = source 
    local steam                  = BRIANPH.globalModules.GetSteamIdentifier(src)
    
    local maxClients             = GetConvarInt('sv_maxclients', 1)

    deferrals.defer()

    attemptingConnection = true

    if attemptingConnection then

        -- ? Force players, that are attempting to connect, into a table.
        local steamName = BRIANPH.globalModules.GetNameIdentifier(src)
        table.insert(attemptingConnectionList, steamName)

        while attemptingConnection do

            Wait(1)

            local steamName = BRIANPH.globalModules.GetNameIdentifier(src)
            
            if steamName == nil then

                table.remove(attemptingConnectionList, steamName)
                attemptingConnection = false

            end

            print(userCount)
            
            if userCount >= maxClients then

                Wait(1000)

                attemptingConnection = false
                inQueue = true

                local steamName = BRIANPH.globalModules.GetNameIdentifier(src)
                local tablePos  = BRIANPH.globalModules.GetQueuePosition(steamName, attemptingConnectionList)

                table.remove(attemptingConnectionList, tablePos)
                table.insert(queueList, steamName)

                while inQueue do

                    Wait(1)

                    local steamName = BRIANPH.globalModules.GetNameIdentifier(src)
                    local tablePos  = BRIANPH.globalModules.GetQueuePosition(steamName, queueList)

                    if steamName == nil then

                        table.remove(queueList, tablePos)
                        inQueue = false
                        return

                    end

                    if userCount < maxClients then

                        Wait(1000)
        
                        inQueue                = false
                        establishingConnection = true
        
                        local steamName = BRIANPH.globalModules.GetNameIdentifier(src)
                        local tablePos  = BRIANPH.globalModules.GetQueuePosition(steamName, queueList)
        
                        table.remove(queueList, tablePos)
                        table.insert(establishingConnectionList, steamName)
        
                        local connectTimeout = 50
        
                        while establishingConnection do
        
                            Wait(1)
        
                            local steamName = BRIANPH.globalModules.GetNameIdentifier(src)
        
                            if steamName == nil then
        
                                establishingConnection = false
        
                                local tablePos = BRIANPH.globalModules.GetQueuePosition(steamName, establishingConnectionList)
                                table.remove(establishingConnectionList, tablePos)
        
                            end
        
                            connectTimeout = connectTimeout - 1
                            if connectTimeout < 0 then connectTimeout = 0 end
        
                            if connectTimeout == 0 then
        
                                establishingConnection = false
        
                                local tablePos = BRIANPH.globalModules.GetQueuePosition(steamName, establishingConnectionList)
                                table.remove(establishingConnectionList, tablePos)
                                
                                TriggerEvent('brianph-core:deferralsHandler:executeDeferrals', src, playerName, setKickReason, deferrals)
                                return
        
                            end
        
                        end
        
                    end

                end

            end

            if userCount < maxClients then

                Wait(1000)

                attemptingConnection   = false
                establishingConnection = true

                local steamName = BRIANPH.globalModules.GetNameIdentifier(src)
                local tablePos  = BRIANPH.globalModules.GetQueuePosition(steamName, attemptingConnectionList)

                table.remove(attemptingConnectionList, tablePos)
                table.insert(establishingConnectionList, steamName)

                local connectTimeout = 50

                while establishingConnection do

                    Wait(1)

                    local steamName = BRIANPH.globalModules.GetNameIdentifier(src)

                    if steamName == nil then

                        establishingConnection = false

                        local tablePos = BRIANPH.globalModules.GetQueuePosition(steamName, establishingConnectionList)
                        table.remove(establishingConnectionList, tablePos)

                    end

                    connectTimeout = connectTimeout - 1
                    if connectTimeout < 0 then connectTimeout = 0 end

                    if connectTimeout == 0 then

                        establishingConnection = false

                        local tablePos = BRIANPH.globalModules.GetQueuePosition(steamName, establishingConnectionList)
                        table.remove(establishingConnectionList, tablePos)
                        
                        TriggerEvent('brianph-core:deferralsHandler:executeDeferrals', src, playerName, setKickReason, deferrals)
                        return

                    end

                end

            end

        end

    end

end)

Citizen.CreateThread(function()

    while true do
        
        Wait(1000) 
        print('attemptingConnectionList:' .. json.encode(attemptingConnectionList), attemptingConnection)
        print('establishingConnectionList:' .. json.encode(establishingConnectionList), establishingConnection)
        print('queueList:' .. json.encode(queueList), inQueue)

    end

end)
