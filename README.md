# keep-gunrack converted for ox_inventory

Allows police to add and open gun racks.
Gun racks are hidden from other non-police players.

- After deactivation of job check, the radial menu will be deactivated and you can only open gunracks.

# Dependencies

- qb-core
- progressbar
- qb-radialmenu
- ox_inventory

# How to Install

- step0: Add `images/policegunrack.png` to `ox_inventory/web/images`
- step1: Add Below code to `qb-core/shared/items.lua`

```lua
["policegunrack"] = {
     ["name"] = "policegunrack",
     ["label"] = "Police Gun Rack",
     ["weight"] = 15000,
     ["type"] = "item",
     ["image"] = "policegunrack.png",
     ["unique"] = false,
     ["useable"] = true,
     ["shouldClose"] = true,
     ["combinable"] = nil,
     ["description"] = "Gun rack for police vehicles"
},



- last step: ensure script after all dependencies `ensure keep-gunrack` (server.cfg)


```lua
     disable_job_check = true, -- <--- this value will disable job check
     use_keys_to_unlock_gunrack = false, --<--- dose not work with ox_inventory
```

# Config

- Add vehicle's models or classes you want to get whitelisted
- Customize rack size and durations

``` lua
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
```

```sql
CREATE TABLE IF NOT EXISTS `gunrack` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stash` varchar(255) NOT NULL DEFAULT '[]',
  PRIMARY KEY (`stash`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
```