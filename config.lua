Config = Config or {}

local whitelist = {
     models = {
          -- if a vehicle model exist in models script will skip class check!
          -- 'police',
          -- 'police2'
     },
     classes = {
          -- https://docs.fivem.net/natives/?_0x29439776AAA00A62
          -- 0, -- Compacts  
          -- 1, -- Sedans  
          -- 2, -- SUVs  
          -- 3, -- Coupes  
          -- 4, -- Muscle  
          -- 5, -- Sports Classics  
          -- 6, -- Sports  
          -- 7, -- Super  
          -- 8, -- Motorcycles  
          -- 9, -- Off-road  
          -- 10, -- Industrial  
          -- 11, -- Utility  
          -- 12, -- Vans  
          -- 13, -- Cycles  
          -- 14, -- Boats  
          -- 15, -- Helicopters  
          -- 16, -- Planes  
          -- 17, -- Service  
          18, -- Emergency  
          -- 19, -- Military  
          -- 20, -- Commercial  
          -- 21, -- Trains  
          -- 22, -- Open Wheel
     },
     jobs = { 'police' },
}

-- items added only after gun rack installation
Config.InitialItems = {
}

Config.gunrack = {
     install_duration = 3, --sec
     opening_duration = 3, --sec
     while_open_animation = true, -- while inventory screen is on
     whitelist = whitelist,
     disable_job_check = false, -- make sure it's fakse if your not using keys or everybody can unlock gunracks
     -- optional make sure you did optional part of installation
     use_keys_to_unlock_gunrack = false, -- do not use with ox_inventory
     stash_prefix = 'Gunrack_',
     -- initial setup do not edit after or you will have to delete the data out of the ox_inventory and gunrack tables 
     slots = 10,
     size = 100000,
}
