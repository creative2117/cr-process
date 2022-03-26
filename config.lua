Config = {}

Config.Key = 47 -- G

Config.Locations = {
    ['example1'] = { -- Just an example, edit to your liking
        coords = { -- The coords to have the process
            ['1'] = vector3(-580.94, 22.65, 43.99),
        },
        items = { -- What items you need to do it
            ['1'] = {
                name = "water_bottle", -- The name of the item
                amount = 3, -- How many of the item you need
            },
            ['2'] = {
                name = "cokebaggy", -- The name of the item
                amount = 3, -- How many of the item you need
            }
        },
        miniGame = true, -- if you want to have a minigame (skillchecks) before the progressbar starts
        text = "[G] Start processing", -- What 3dtext to display
        skillBar = "easy", -- How hard the minigame should be, can be "easy", "medium" of "hard" (can be ignored if you have miniGame set to false)
        notifyDontHaveItems = "You dont have the requierd items to do this!", -- What to notify when you dont have the items requierd
        notifyMinigameFail = "You faild the skillchecks", -- What to notify when you fail the skillchecks (can be ingored if you have miniGame set to false)
        notifyMinigameSuccess = "You are now starting to process", -- What to notify when you sucessfully made the skillchecks (can be ingored if you have miniGame set to false)
        notifyProgressbar = "You successfully processed", -- What to notify when the progressbar is done
        textProgressBar = "processing..", -- What the progressbar should say
        progressbar = math.random(1000, 2000), -- How long the progressbar should be, could be math.random or a set number
        animDict = "anim@amb@clubhouse@mini@darts@", -- The animation dictionary
        anim = "enter_throw_a", -- The animation in the animation dictionary
        itemToGet = {
            name = "phone", -- The name of the item to get when you are done processing
            amount = 2, -- How many of the item to get
        },
    },
    ['example2'] = { -- Just an example, edit to your liking
        coords = { -- The coords to have the process
            ['1'] = vector3(-567.88, 22.33, 44.27),
        },
        items = { -- What items you need to do it
            ['1'] = {
                name = "water_bottle", -- The name of the item
                amount = 3, -- How many of the item you need
            },
            ['2'] = {
                name = "cokebaggy", -- The name of the item
                amount = 3, -- How many of the item you need
            }
        },
        miniGame = true, -- if you want to have a minigame (skillchecks) before the progressbar starts
        text = "[G] Start processing", -- What 3dtext to display
        skillBar = "medium", -- How hard the minigame should be, can be "easy", "medium" of "hard" (can be ignored if you have miniGame set to false)
        notifyDontHaveItems = "You dont have the requierd items to do this!", -- What to notify when you dont have the items requierd
        notifyMinigameFail = "You faild the skillchecks", -- What to notify when you fail the skillchecks (can be ingored if you have miniGame set to false)
        notifyMinigameSuccess = "You are now starting to process", -- What to notify when you sucessfully made the skillchecks (can be ingored if you have miniGame set to false)
        notifyProgressbar = "You successfully processed", -- What to notify when the progressbar is done
        textProgressBar = "processing..", -- What the progressbar should say
        progressbar = math.random(1000, 2000), -- How long the progressbar should be, could be math.random or a set number
        animDict = "anim@amb@clubhouse@mini@darts@", -- The animation dictionary
        anim = "enter_throw_a", -- The animation in the animation dictionary
        itemToGet = {
            name = "phone", -- The name of the item to get when you are done processing
            amount = 2, -- How many of the item to get
        },
    },
}
