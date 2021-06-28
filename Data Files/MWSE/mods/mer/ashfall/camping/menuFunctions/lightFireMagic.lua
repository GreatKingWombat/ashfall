local common = require ("mer.ashfall.common.common")

return {
    text = "Light Fire With Magic",
    showRequirements = function(campfire)
        return (
            not campfire.data.isLit and
            campfire.data.fuelLevel and
            campfire.data.fuelLevel > 0.5
        )
    end, 
    callback = function(campfire)
        tes3.playSound{ reference = tes3.player, sound = "mysticism area"  }
        common.log:debug("Lighting Fire %s", campfire.object.id)
        tes3.playSound{ sound = "Fire", reference = campfire, loop = true }
        event.trigger("Ashfall:Campfire_Enablelight", { campfire = campfire})
        campfire.data.fuelLevel = campfire.data.fuelLevel - 0.5
        tes3.mobilePlayer:exerciseSkill(tes3.skill.destruction, 5)
        campfire.data.isLit = true
        event.trigger("Ashfall:Campfire_Update_Visuals", { campfire = campfire, nodes = true, fire = true, lighting = true})
    end,
}
