RegisterServerEvent('brianph-core:database:userCheckDatabase')
AddEventHandler('brianph-core:database:userCheckDatabase', function()

    local username
    local license
    local steam   
    local src = source

    local function userInsertDatabase()

        local a = [[INSERT INTO core_users (username, steam, license) VALUES (@username, @steam, @license)]]
        local b = {

            ['@username'] = username,
            ['@steam']    = steam,
            ['@license']  = license

        }

        MySQL.insert(a, b)
    
    end

    local function userCheckDatabase()

        local a = [[SELECT * FROM core_users WHERE steam = @steam]]
        local b = {
            ['@steam'] = steam
        }

        MySQL.query(a, b, function(queryResult)
        
            if next(queryResult) ~= nil then
            
                print(username .. ' successfully joined the server with steam hex: ' .. steam)
                -- TODO: Trigger character selection

            elseif next(queryResult) == nil then

                userInsertDatabase()

            end

        end)

    end

    local function GetUserIdentifiers()

        username = GetPlayerName(src)

        for _, v in ipairs(GetPlayerIdentifiers(src)) do

            if string.match(v, 'steam:') then
                
                steam = v
                
            end
            
            if string.match(v, 'license:') then
            
                license = v
            
            end
                
        end

        userCheckDatabase()

    end

    GetUserIdentifiers()

end)

    


