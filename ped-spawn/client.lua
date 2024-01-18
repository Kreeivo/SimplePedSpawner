FeatherCore = exports['feather-core'].initiate()
FeatherMenu =  exports['feather-menu'].initiate()


--Registering our menu in feather menu
local pedSpawnerMenu = FeatherMenu:RegisterMenu('feather:character:menu', {
    top = '40%',
    left = '20%',
    ['720width'] = '500px',
    ['1080width'] = '600px',
    ['2kwidth'] = '700px',
    ['4kwidth'] = '900px',
    style = {},
    contentslot = {
        style = { --This style is what is currently making the content slot scoped and scrollable. If you delete this, it will make the content height dynamic to its inner content.
            ['height'] = '300px',
            ['min-height'] = '300px'
        }
    },
    draggable = true,
})



RegisterCommand("pedmenu", function()
    local playerCoords = GetEntityCoords(PlayerPedId())

    local pedSpawnerMenuPage = pedSpawnerMenu:RegisterPage("ped-spawn:pedSpawnerMenu")
    pedSpawnerMenuPage:RegisterElement("header", {
        value = "Ped Spawner",
        slot = "header",
        style = {}
    })
    for x, y in pairs(Config.pedBank) do
        pedSpawnerMenuPage:RegisterElement("button", {
            label = y,
            style = {}
        }, function()
            local playerCoords = GetEntityCoords(PlayerPedId())
            local ped = FeatherCore.Ped:Create(y, playerCoords.x, playerCoords.y, playerCoords.z, 0, 'world', false, true)
            Citizen.InvokeNative(0x283978A15512B2FE, ped:GetPed())
            TaskCombatPed( ped:GetPed(), PlayerPedId() )
            --print("Option Chosen")
            --print("This will run when the button is clicked")

            
        end)
    end

    pedSpawnerMenu:Open({
        startupPage = pedSpawnerMenuPage
    })
end)