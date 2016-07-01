function molotov(event)
    local caster = event.caster
    local item = event.ability
    local radius = item:GetLevelSpecialValueFor("radius", 1)
    local duration= item:GetLevelSpecialValueFor("duration_building", 1)
    --local aoeParticle = "particles/units/heroes/hero_meepo/meepo_earthbind_projectile_fx.vpcf"

    local teamNumber = caster:GetTeamNumber()
    local casterOrigin = caster:GetOrigin()
    local units = FindUnitsInRadius(teamNumber, casterOrigin, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false)
    
    --print("testing EMP, x: " .. casterOrigin.x .. " y: " .. casterOrigin.y .. " dur: " .. duration .. " radius " .. radius)

    for _,enemy in pairs(units) do
        enemy:EmitSound("molotov.hit")
        --print("found enemy: " .. enemy:GetUnitName())
         if string.find(enemy:GetUnitName(), "npc_building_")  then
            item:ApplyDataDrivenModifier(caster, enemy, "modifier_molotov_burn_building", {duration=25})
            enemy:EmitSound("molotov.burn")
             Timers:CreateTimer(25, function() enemy:StopSound("molotov.burn") end)
        end
    end

end