function CancelBuilding( event )
    local building = event.caster
    local unitName = building:GetUnitName()
    local buildingName = string.gsub(unitName, "npc_building_", "")
    local itemName = "item_building_kit_"..buildingName
    local position = building:GetAbsOrigin()
    
    building.deleted = true
    building:ForceKill(true)
    building:AddNoDraw()
    building:SetAbsOrigin(Vector(position.x, position.y, position.z+3000)) --hides in case of particles (fire)

    if building.skip_kit_creation then
        return
    end

    print("Packing up "..buildingName.." into "..itemName)
    
    local itemKit = CreateItem(itemName, nil, nil)
    local drop = CreateItemOnPositionSync( position, itemKit )
    if not itemKit then
        print("Item Kit "..itemName.." couldn't be created, item is invalid")
        return
    end

    itemKit:LaunchLoot(false, 400, 1, position)
end