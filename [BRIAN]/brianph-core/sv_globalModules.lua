BRIANPH = BRIANPH or {}
BRIANPH.globalModules = BRIANPH.globalModules or {}

-- ? Utilities

function BRIANPH.globalModules.GetSteamIdentifier(src)

    local getIdentifier = GetPlayerIdentifiers(src)
    local steam

    for _, data in pairs(getIdentifier) do

        if string.match(data, 'steam:') then

            steam = data
            break

        end

    end

    print(steam)
    return steam

end

function BRIANPH.globalModules.GetLicenseIdentifier(src)

    -- ? Grabs the user's FiveM license identifier and returns the result.

    local getIdentifier = GetPlayerIdentifiers(src)
    local license
    
    for _, data in pairs(getIdentifier) do
    
        if string.match(data, 'license:') then

            license = data
            break

        end

    end

    return license

end

function BRIANPH.globalModules.GetNameIdentifier(src)

    -- ? Grabs the user's Steam username identifier and returns the result.

    username = GetPlayerName(src)

    return username

end

-- ? Database Logging

function BRIANPH.globalModules.GenerateLogsBanned(steam)

    local a = [[INSERT INTO core_logs (type, log, identifier) VALUES (@type, @log, @identifier)]]
    local b = {

        ['@type']       = 'Banned player attempt',
        ['@log']        = 'A banned player is attempting to connect to the server.',
        ['@identifier'] = steam

    }

    MySQL.insert(a, b)

end

function BRIANPH.globalModules.GenerateLogsConnected(steam)

    local a = [[INSERT INTO core_logs (type, log, identifier) VALUES (@type, @log, @identifier)]]
    local b = {

        ['@type']       = 'Player connected',
        ['@log']        = 'A player had successfully connected to the server.',
        ['@identifier'] = steam

    }

    MySQL.insert(a, b)

end

function BRIANPH.globalModules.GenerateLogsDisconnected(steam)

    local a = [[INSERT INTO core_logs (type, log, identifier) VALUES (@type, @log, @identifier)]]
    local b = {

        ['@type']       = 'Player disconnected',
        ['@log']        = 'A player had dropped their connection from the server.',
        ['@identifier'] = steam

    }

    MySQL.insert(a, b)

end

function BRIANPH.globalModules.GenerateDatabaseLogs(logType, steam)

    -- ? Log categories:
    -- * Banned player attempt to join
    -- * Player Disconnected
    -- * Player Connected

    if logType == 'bannedPlayer' then

        BRIANPH.globalModules.GenerateLogsBanned(steam)

    elseif logType == 'playerDisconnected' then

        BRIANPH.globalModules.GenerateLogsDisconnected(steam)

    elseif logType == 'playerConnected' then

        BRIANPH.globalModules.GenerateLogsConnected(steam)

    end

end