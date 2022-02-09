BRIANPH = BRIANPH or {}
BRIANPH.UserHandler = BRIANPH.userHandler or {}
BRIANPH.UserHandler.Utilities = BRIANPH.UserHandler.Utilities or {}

RegisterServerEvent('brianph-core:userHandler:checkDatabase')
AddEventHandler('brianph-core:userHandler:checkDatabase', function(src)

    local pSrc = src

    local userSteam   = BRIANPH.UserHandler.Utilities.GetSteamIdentifier(pSrc)
    local userLicense = BRIANPH.UserHandler.Utilities.GetLicenseIdentifier(pSrc)
    local userName    = BRIANPH.UserHandler.Utilities.GetNameIdentifier(pSrc)

        
    local function InsertDatabase()

        local a = [[INSERT INTO core_users (username, steam, license) VALUES (@username, @steam, @license)]]
        local b = {

            ['@username'] = userName,
            ['@steam'] = userSteam,
            ['@license'] = userLicense

        }

        MySQL.insert(a, b)
    
    end

    local function CheckDatabase()

        local a = [[SELECT * FROM core_users WHERE username = @username]]
        local b = {
            
            ['@username'] = userName

        }

        MySQL.query(a, b, function(queryResult)

            if not queryResult then print('A user logged in to the server.') InsertDatabase() end

        end)

    end

    CheckDatabase()

end)

