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