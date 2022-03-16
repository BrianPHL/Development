local isOpen = false

function closeMDB()

    SendNUIMessage({
        type   = 'MDBstate',
        isOpen = false
    })

    SetNuiFocus(false, false)
    isOpen = false

end

RegisterCommand('mdb', function()

    if isOpen == false then

        local function openMDB()

            SendNUIMessage({
                type   = 'MDBstate',
                isOpen = true
            })
    
            SetNuiFocus(true, true)
            isOpen = true

        end
        openMDB()

        else

        closeMDB()

    end

end)

RegisterNUICallback('bp-mdb:closeMDB', function()
    closeMDB()
end)

Citizen.CreateThread(function()

    local entity = PlayerPedId()
    SetEntityVisible(entity, true)

    while true do

        Wait(0)
        SetEntityLocallyVisible(entity)

    end

end)