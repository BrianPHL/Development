BRIANPH = BRIANPH or {}
BRIANPH.globalModules = BRIANPH.globalModules or {}

-- TODO: completely rework the entire server cap system as the source code from hardcap is complete dogwater

local elapsedTime = '00:00:00'
local userCount = 0 
local userList  = {}

local queueList = {}

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

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)

    local src        = source 
    local maxClients = GetConvarInt('sv_maxclients', 32)

    deferrals.defer()

    local connectingMessage = '[queueHandler] Initializing queue...'
    deferrals.update(connectingMessage)

    Wait(1)

    if userCount >= maxClients then

        local userName = BRIANPH.globalModules.GetNameIdentifier(src)
        table.insert(queueList, userName)

    end

    while userCount >= maxClients do

        Wait(1000)
        
        local userName      = BRIANPH.globalModules.GetNameIdentifier(src)
        local queuePosition = BRIANPH.globalModules.GetQueuePosition(userName, queueList)
        local queueLength   = BRIANPH.globalModules.GetQueueLength(queueList)
        local elapsedTime

        if userName == nil then 

            print('[queueHandler DEBUG] no username or player dropped from queue') 
            table.remove(queueList, userName)
            return 

        end

        local queueMessage = '[queueHandler] You are currently ' .. queuePosition .. '/' .. queueLength .. ' in the queue.'
        deferrals.update(queueMessage)
        

    end

    local transferMessage = '[queueHandler] No queue found. Transferring to deferralsHandler...'
    deferrals.update(transferMessage)

    Wait(3000)

    TriggerEvent('brianph-core:deferralsHandler:executeDeferrals', src, playerName, setKickReason, deferrals)

end)
