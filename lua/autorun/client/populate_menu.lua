hook.Add( "AddToolMenuCategories", "CustomCategory", function()
	-- spawnmenu.AddToolCategory( "Utilities", "Armor Plates", "#Armor Plates" )
end )

hook.Add( "PopulateToolMenu", "CustomMenuSettings2", function()
	spawnmenu.AddToolMenuOption( "Utilities", "Armored NPCs", "ArmoredNPCSettings.ArmorPlates", "#Plates", "", "", function( panel )
		local super = LocalPlayer():IsSuperAdmin()

		panel:ClearControls()

		if not super then
			panel:Help( "Only super admins can change Armor Plate Settings." )
			return
		end

		panel:CheckBox( "Enabled", "gk_armorplates_on" )
		panel:NumSlider("Plate Drop Chance", "gk_armor_drop_chance", 1, 100, 0)
	end )
end )