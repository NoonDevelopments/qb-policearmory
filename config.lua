Config = {}

Config.Armories = {
    [1] = {
        ped = "s_m_y_cop_01", -- Ped choice
        pedlocation = vector3(452.6, -980.0, 30.6), -- Ped location
        pedheading = 90.0, -- Ped heading (the way the ped is looking.)
        pedanim = {
            dict = 'amb@world_human_cop_idles@male@base',
            anim = 'base'
        },
        pedSettings = {
            SetEntityInvincible = true,
            SetBlockingOfNonTemporaryEvents = true,
            FreezeEntityPosition = true
        },
        ArmoryItems = {
            ArmoryItems = {
                ['police'] = {
                    [0] = {
                        {name = 'WEAPON_PISTOL', label = 'Pistol', price = 100},
                        {name = 'WEAPON_STUNGUN', label = 'Stun Gun', price = 50},
                        {name = 'ARMOR', label = 'Body Armor', price = 50}
                    },
                    [1] = {
                        {name = 'WEAPON_PISTOL', label = 'Pistol', price = 100},
                        {name = 'WEAPON_SMG', label = 'SMG', price = 250},
                        {name = 'ARMOR', label = 'Body Armor', price = 50}
                    }
                    -- Add more grades as needed
                }
        } }
    } -- comma here if you add another (Do not add a comma after your new armory unless you have more)
}
