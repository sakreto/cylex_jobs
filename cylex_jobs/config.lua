setLocale = 'es' --set your own language (make sure the table is made on shared/locales.lua)

Jobs = {
    ["Slaughterer"] = {
        jobRequired = false,
        jobName = "slaughterer",
        location = { 
            [1] = { --collect
                coords = vector3(-66.64,6247.8,31.09),
                blip = {
                    showBlip = true,
                    blipName = "Gallinero",
                    sprite = 605,
                    color = 8,
                    scale = 1.0,
                },
                marker = {
                    enable = true,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 255, g = 0, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = (messages[setLocale]['pressToInteract']..messages[setLocale]['jobAction1']..'gallina'),
                },
                item = {
                    process = "pickup", --dont touch

                    itemName = "alive_chicken",
                    addCount = 2,
                },                
                animation = {
                    enable = false,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function() 
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end 
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = false,
                    progText = "Collecting...", 
                    duration = 10000 
                }
            },
            [2] = { --process
                coords = vector3(-85.31,6233.87,31.03), 
                blip = {
                    showBlip = false,
                    blipName = "Proceso Gallinero",
                    sprite = 475, 
                    color = 8,
                    scale = 0.65,
                },
                marker = {
                    enable = true,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = (messages[setLocale]['pressToInteract']..messages[setLocale]['jobAction2']..'gallina'),
                },
                item = {
                    process = "exchange", --dont touch
                    
                    addCount = 1,
                    itemName = "slaughtered_chicken",
                    
                    removeCount = 1,
                    requiredItem = "alive_chicken",
                },
                animation = {
                    enable = false,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = false,
                    progText = "Processing...",
                    duration = 5000
                }
            },
            [3] = { --package
                coords = vector3(-104.12,6206.33,31.0), 
                blip = {
                    showBlip = false,
                    blipName = "Slaughterer package",
                    sprite = 475, 
                    color = 8,
                    scale = 0.65,
                },
                marker = {
                    enable = true,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = (messages[setLocale]['pressToInteract']..messages[setLocale]['jobAction3']..'gallinas'),
                },
                item = {
                    process = "package", --dont touch

                    addCount = 1,
                    itemName = "packaged_chicken",

                    removeCount = 1,
                    requiredItem = "slaughtered_chicken", 
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = false,
                    progText = "Packaging...",
                    duration = 5000
                }
            },

            [4] = { --sell
                coords = vector3(846.39,-1992.85,29.6), 
                blip = {
                    showBlip = true,
                    blipName = "Comprador de Gallinas",
                    sprite = 365, 
                    color = 8,
                    scale = 1.0,
                },
                marker = {
                    enable = true,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = (messages[setLocale]['pressToInteract']..messages[setLocale]['jobAction4']..'gallina empacada'),
                },
                item = {
                    process = "sell", --dont touch

                    removeCount = 1,
                    requiredItem = "packaged_chicken",
                    price = 14 --250 por carro 1000 por truck
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = false,
                    progText = "Selling...",
                    duration = 5000
                }
            }
        },
    },
}