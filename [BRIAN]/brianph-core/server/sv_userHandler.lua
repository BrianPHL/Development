BRIANPH = BRIANPH or {}
BRIANPH.UserHandler = BRIANPH.userHandler or {}
BRIANPH.UserHandler.Utilities = BRIANPH.UserHandler.Utilities or {}

RegisterServerEvent('brianph-core:userHandler:CheckDatabase')
AddEventHandler('brianph-core:userHandler:CheckDatabase', function(src)

    local userSteam   = BRIANPH.UserHandler.Utilities.GetSteamIdentifier(src)
    local userLicense = BRIANPH.UserHandler.Utilities.GetLicenseIdentifier(src)
    local userName    = BRIANPH.UserHandler.Utilities.GetNameIdentifier(src)

    local function userDropConnection()

        local message = 'You have been banned from joining the server! File a ticket in the Discord to appeal your ban.'
        DropPlayer(src, message)

    end

    local function userCheckStatus()

        local a = [[SELECT status FROM core_users WHERE username = @username]]
        local b = {

            ['@username'] = userName

        }

        MySQL.query(a, b, function(queryResult)
        
            for _, data in pairs(queryResult) do

                local status = data.status

                if status ~= 'banned' then

                    -- CharacterSelection()

                else

                    userDropConnection()

                end

            end

        end)

    end
        
    local function userInsertDatabase()

        local a = [[INSERT INTO core_users (username, steam, license) VALUES (@username, @steam, @license)]]
        local b = {

            ['@username'] = userName,
            ['@steam'] = userSteam,
            ['@license'] = userLicense

        }

        MySQL.insert(a, b)
        userCheckStatus()
    
    end

    local function userCheckDatabase()

        local a = [[SELECT * FROM core_users WHERE username = @username]]
        local b = {
            
            ['@username'] = userName

        }

        MySQL.query(a, b, function(queryResult)

            if queryResult then userCheckStatus() end
            if not queryResult then userInsertDatabase() end

        end)

    end

    userCheckDatabase()

end)

local function onPlayerConnecting()

    local src = source
    
    TriggerEvent('brianph-core:userHandler:CheckDatabase', src)

end

AddEventHandler('playerConnecting', onPlayerConnecting)

