RegisterServerEvent('brianph-core:userHandler:userCheckDatabase')
AddEventHandler('brianph-core:userHandler:userCheckDatabase', function()

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

    local function userDropConnection()

        DropPlayer(src, 'You have been banned! Please file a ticket in the Discord to appeal your ban.')

    end

    local function userCheckDatabase()

        local a = [[SELECT * FROM core_users WHERE username = @username]]
        local b = {
            ['@username'] = username
        }

        MySQL.query(a, b, function(queryResult)
        
            if next(queryResult) ~= nil then

                local function userCheckStatus()

                    local c = [[SELECT status FROM core_users WHERE username = @username]]
                    local d = {

                        ['@username'] = username

                    }

                    MySQL.query(c, d, function(queryResult2)
                
                        for _, v in pairs(queryResult2) do

                            local status = v.status

                            if status == 'banned' then

                                userDropConnection()

                            else

                                -- TODO: Create a character creation / selection function

                                print(username.. ' successfully logged in with steam identifier:' ..steam)
                                userCharacterSelection()

                            end

                        end

                    end)

                end

                userCheckStatus()

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