BP.getSteamIdentifier = function(src)

    local getIdentifier = GetPlayerIdentifiers(src)
    local steam

    for _, data in pairs(getIdentifier) do
        if string.match(data, 'steam:') then
            steam = data
            break
        end
    end
    return steam
end

BP.getLicenseIdentifier = function(src)

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

BP.getNameIdentifier = function(src)
    print('name identifier triggered')
    local username = GetPlayerName(src)
    return username
end

-- ? Queue functions

BP.getQueuePosition = function(userName, queueList)

    local queuePosition

    for index, values in ipairs(queueList) do
        if values == userName then
            queuePosition = index
        end
    end
    return queuePosition
end

BP.getQueueLength = function(queueList)

    local queueLength = #queueList
    return queueLength
    
end