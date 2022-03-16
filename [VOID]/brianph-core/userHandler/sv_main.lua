BRIANPH = BRIANPH or {}
BRIANPH.globalModules = BRIANPH.globalModules or {}

RegisterServerEvent('brianph-core:userHandler:checkDatabase')
AddEventHandler('brianph-core:userHandler:checkDatabase', function(src)

    local userSteam   = BRIANPH.globalModules.GetSteamIdentifier(src)
    local userLicense = BRIANPH.globalModules.GetLicenseIdentifier(src)
    local userName    = BRIANPH.globalModules.GetNameIdentifier(src)
        
    local function InsertDatabase()

        local a = [[INSERT INTO core_users (username, steam, license) VALUES (@username, @steam, @license)]]
        local b = {

            ['@username'] = userName,
            ['@steam']    = userSteam,
            ['@license']  = userLicense

        }

        MySQL.insert(a, b)
    
    end

    local function CheckDatabase()

        local a = [[SELECT * FROM core_users WHERE username = @username]]
        local b = {
            
            ['@username'] = userName

        }

        MySQL.query(a, b, function(queryResult)

            if not queryResult then InsertDatabase() end

        end)

    end

    CheckDatabase()

end)

