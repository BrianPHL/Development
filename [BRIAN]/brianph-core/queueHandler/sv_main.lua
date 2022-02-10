BRIANPH = BRIANPH or {}
BRIANPH.globalModules = BRIANPH.globalModules or {}

-- TODO: completely rework the entire server cap system as the source code from hardcap is complete dogwater

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

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)

    local src        = source 
    local maxClients = GetConvarInt('sv_maxclients', 1)

    deferrals.defer()

    local connectingMessage = '[queueHandler] Initializing queue handlers...'
    deferrals.update(connectingMessage)

    Wait(3000)

    if userCount >= maxClients then

        -- TODO: Create a queueing system with priority integration
        deferrals.done('SAGAD NA BOBO')

    elseif userCount <= maxClients then

        local transferMessage = '[queueHandler] No queue found. Transferring to deferralsHandler...'
        deferrals.update(transferMessage)

        Wait(3000)

        TriggerEvent('brianph-core:deferralsHandler:executeDeferrals', src, playerName, setKickReason, deferrals)

    end

end)
