-- ? Grabs user steam identifier
function getSteamIdentifier(playerSource)

    local steamIdentifier
    local getIdentifier = GetPlayerIdentifiers(playerSource)

    for _, data in pairs(getIdentifier) do

        if string.match(data, 'steam:') then

            steamIdentifier = data
            break

        end

    end

    return steamIdentifier

end

-- ? Grabs user FiveM license
function getLicenseIdentifier(playerSource)

    local licenseIdentifier
    local getIdentifier = GetPlayerIdentifiers(playerSource)

    for _, data in pairs(getIdentifier) do
    
        if string.match(data, 'license:') then

            licenseIdentifier = data
            break

        end

    end

    return licenseIdentifier

end

-- ? Grabs user steam name
function getNameIdentifier(playerSource)

    nameIdentifier = GetPlayerName(playerSource)

    return nameIdentifier

end

-- ? Grabs user position in queue
function getQueuePosition(tableItem, tableName)

    local queuePosition

    for i, data in ipairs(tableName) do

        if data == tableItem then

            queuePosition = i

        end

    end

    return queuePosition

end