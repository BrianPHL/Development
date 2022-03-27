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
    local username = GetPlayerName(src)
    return username
end

-- ? Queue functions

BP.getTablePosition = function(givenTable, givenValue)

    local tablePosition

    for index, values in ipairs(givenTable) do
        if values == givenValue then
            tablePosition = index
        end
    end
    return tablePosition
end

BP.getTableLength = function(givenTable)

    local tableLength = #givenTable
    return tableLength

end