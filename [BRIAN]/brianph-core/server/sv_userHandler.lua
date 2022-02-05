RegisterServerEvent('brianph-core:database:userCheckDatabase')
AddEventHandler('brianph-core:database:userCheckDatabase', function()

    local src     = source
    local steam   = nil
    local license = nil

    local function GetPlayerIdentifiers()

        for _, v in ipairs(GetPlayerIdentifiers(src)) do

            if string.match(v, 'steam:') then
                
                steam = v
                
            end
            
            if string.match(v, 'license:') then
            
                license = v
            
            end
                
        end

        if steam and license then

            userCheckDatabase()

        elseif not steam and not license then

            return

        end

    end

    local function userCheckDatabase()

        local a = [[SELECT * FROM core_users WHERE steam = @steam]]
        local b = {
            ['@steam'] = steam
        }

        MySQL.query(a, b, function(queryResult)
        
            if next(queryResult) ~= nil then
            
                -- TODO: Trigger character selection

            elseif next(queryResult) == nil then

                userInsertDatabase()

            end

        end)

    end

    local function userInsertDatabase()

        local a = [[INSERT INTO core_users (steam, license) VALUES (@steam, @license)]]
        local b = {
            ['@steam']   = steam
            ['@license'] = license
        }

        MySQL.insert(a, b)
    
    end

end)
