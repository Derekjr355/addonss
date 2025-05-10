Config                            = {}
Config.DrawDistance               = 100.0

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableVaultManagement      = true
Config.EnableMoneyWash            = true
Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.MissCraft                  = 10 -- %

Config.AuthorizedVehicles = {
    { name = 'Mule3',  label = 'Camion entreprise' },
}

Config.Blips = {
    
    Blip = {
      Pos     = { x = 342.008, y = -884.447, z = 13.799719810486 },
      Sprite  = 206,
      Display = 4,
      Scale   = 0.9,
      Colour  = 1,
    },
}

Config.Zones = {

    Cloakrooms = {
        Pos   = { x = 338.403, y = -896.509, z = 29.339 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 255, g = 187, b = 255 },
        Name  = "Vestiaire",
        Type  = 0
    },

    Vaults = {
        Pos   = { x = 348.233, y = -888.271, z = 29.339 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 248, g = 248, b = 255 },
        Name  = "Coffre",
        Type  = 0
    },

    Fridge = {
        Pos   = { x = 347.347, y = -893.761, z = 29.3399 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 248, g = 248, b = 255 },
        Name  = "Frigo",
        Type  = 0
    },

    PreparationSteak = {
        Pos   = { x = 346.539, y = -897.890, z = 29.33 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 248, g = 248, b = 255 },
        Name  = "Cuire steak",
        Type  = 0
    },

    Vehicles = {
        Pos          = { x = 329.271, y = -871.101, z = 29.29 },
        SpawnPoint   = { x = 339.102, y = -866.115, z = 29.247 },
        Size         = { x = 1.8, y = 1.8, z = 1.0 },
        Color        = { r = 255, g = 255, b = 0 },
        Name  = "Garage véhicule",
        Type  = 0,
        Heading      = 207.43,
    },

    VehicleDeleters = {
        Pos   = { x = 354.228, y = -871.565, z = 29.00 },
        Size  = { x = 3.0, y = 3.0, z = 0.2 },
        Color = { r = 255, g = 255, b = 0 },
        Name  = "Ranger le vehicule",
        Type  = 0
    },

    BossActions = {
        Pos   = { x = 334.102, y = -885.4431, z = 29.339 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 100, b = 0 },
       Name  = "Menu patron",
        Type  = 0
    },

    KetchupFarm = {
        Pos   = { x = 1190.064, y = -3106.073, z = 4.160 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 255, g = 187, b = 255 },
        Name  = "Récupérer marchandises",
        Type  = 1
    },

    SachetKetchup = {
        Pos   = { x = 2461.572, y = 1589.279, z = 32.000 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 248, g = 248, b = 255 },
        Name  = "Mise en sachet",
        Type  = 1
    },

    SellFarm = {
        Pos   = { x = 1719.426, y = 4759.067, z = 40.940 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 248, g = 248, b = 255 },
        Name  = "Vente",
        Type  = 1
    },


    Alim = {
        Pos   = { x = -1179.884765625, y = -902.48187255859, z = 12.549982070922 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 238, g = 0, b = 0 },
        Name = "Boutique",
        Type  = 0,
        Items = {
            { name = 'salads',      label = _U('salads'),   price = 3 },
            { name = 'tomater',      label = _U('tomater'),   price = 2 },
            { name = 'steakc',       label = _U('steakc'),    price = 7 },
            { name = 'bread',     label = _U('bread'),  price = 2 },
            { name = 'fromage',    label = _U('fromage'), price = 3 },
            { name = 'patate',    label = _U('patate'), price = 3 },
            { name = 'soda',        label = _U('soda'),     price = 4 },
            { name = 'jusfruit',    label = _U('jusfruit'), price = 3 },
            { name = 'icetea',      label = _U('icetea'),   price = 4 },
            { name = 'energy',      label = _U('energy'),   price = 7 },
            { name = 'drpepper',    label = _U('drpepper'), price = 2 },
            { name = 'limonade',    label = _U('limonade'), price = 1 }
        },
    },

}


Config.Uniforms = {
  kfc_outfit = {
   male = {
        ['tshirt_1'] = 6,  ['tshirt_2'] = 0,
        ['torso_1'] = 11,   ['torso_2'] = 1,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 11,
        ['pants_1'] = 19,   ['pants_2'] = 0,
        ['shoes_1'] = 8,    ['shoes_2'] = 2,
        ['chain_1'] = 0,    ['chain_2'] = 0
    },
        female = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 281,   ['torso_2'] = 1,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 24,
        ['pants_1'] = 35,   ['pants_2'] = 0,
        ['shoes_1'] = 26,    ['shoes_2'] = 1,
        ['chain_1'] = 0,    ['chain_2'] = 0
    }
  }
}

