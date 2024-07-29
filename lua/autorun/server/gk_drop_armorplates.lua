-- [[ Armor Plates for ANPCs ]]

-- simple function to precache an entity
local function PrecacheEntity(ent)
	if ! ent then return end
	hook.Add("InitPostEntity", "PrecacheEntity_" .. ent, function()
		local a = ents.Create(ent)

		a:Spawn()
		a:Activate()

		a:Remove()
	end)
end

local PlateEntity = "armorplate_pickup" -- armorplate_pickup is Warzone 2.0 Armor Plates Mod
PrecacheEntity(PlateEntity)

local ServerDropChance = CreateConVar("gk_armor_drop_chance", 2, {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Chance of NPCs dropping armor plates on death. 1 - 100")
local On = CreateConVar("gk_armorplates_on", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Enable Armor Plates Support")

local SpawnPlate = function(npc)
	if ! npc then return end

	local ent = ents.Create(PlateEntity)
	if ! ent then return end

	ent:SetPos(npc:GetPos())
	ent:SetVelocity(Vector(0, 0, 500))

	ent:Spawn()
	ent:Activate()
end

-- drop plates on death
-- at a random chance
hook.Add("OnNPCKilled", "DropPlates", function(npc, _, _)
	if ! npc then return end
	if ! PlateEntity then return end
	if ! npc:GetNWInt("Armor") then return end -- we're not ArmoredNPC enabled, don't do anything
	if ! On:GetBool() then return end

	local Chance = math.random(1, math.Clamp(ServerDropChance:GetInt(), 1, 100))

	if ! Chance then return end -- shouldn't happen EVER, but just in case

	if Chance == 1 then
		SpawnPlate(npc)
	end
end)
