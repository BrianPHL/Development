function BP.getSteamIdentifier(src)

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

function BP.getLicenseIdentifier(src)

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

function BP.getNameIdentifier(src)
    username = GetPlayerName(src)
    return username
end

-- ? Queue functions

function BP.getQueuePosition(userName, queueList)

    local queuePosition

    for index, values in ipairs(queueList) do
        if values == userName then
            queuePosition = index
        end
    end
    return queuePosition
end

function BP.getQueueLength(queueList)

    local queueLength = #queueList

    return queueLength
end