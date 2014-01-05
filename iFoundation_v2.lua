require "AoE_Skillshot_Position"
require "Prodiction"
--LoadVIPScript('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')

function Deprecate(old, new) 
	PrintChat("[" .. old .. "] was deprecated, please use [" .. new .. "]")
end 

local SpellStrings = {
	[_Q] = "Q", 
	[_W] = "W",
	[_E] = "E",
	[_R] = "R"
}

local SpellString = {
	["Q"] = _Q, 
	["W"] = _W,
	["E"] = _E, 
	["R"] = _R 
}

function round(num)
		under = math.floor(num)
	    upper = math.floor(num) + 1
	    underV = -(under - num)
	    upperV = upper - num
	    if (upperV > underV) then
	        return under
	    else
	        return upper
	    end
	end	

class 'Menu' -- {

	Menu.instance = ""

	function Menu.Instance() 
		if Menu.instance == "" then Menu.instance = Menu() end return Menu.instance 
	end 

	local SPELL_MENUS = {
		[_Q] = function() return self.Config.Q end,
		[_W] = function() return self.Config.W end,
		[_E] = function() return self.Config.E end,
		[_R] = function() return self.Config.R end
	}
	
	function Menu:__init()
		self.Config = scriptConfig("iFoundation", "ifoundationmain" .. myHero.charName)
		self.Config:addSubMenu("Cast Settings: Q", "Q")
		self.Config:addSubMenu("Cast Settings: W", "W")
		self.Config:addSubMenu("Cast Settings: E", "E")
		self.Config:addSubMenu("Cast Settings: R", "R")
		self.Config:addSubMenu("Drawing", "Drawing")
		--self.Config:addSubMenu("Prediction", "Prediction")
		self.Config:addSubMenu("Potions", "Potions")
	end 

	function Menu:_Get(sub)
		return sub and self.Config[sub] or self.Config 
	end 

	function Menu.Get(sub)
		return Menu.Instance():_Get(sub)
	end 
-- }

--[[
	Class: Caster
	Author: Apple
	Constructors:
		- spell, range, spellType, [speed, delay, width, useCollisionLib]
	
	Methods: 
		- Cast(Target, [minHitChance])
			- Standard cast method, casts to target with prediction if needed 
		- CastMouse(spellPos, [nearestTarget])
			- Casts spell to mouse position, very useful for dashes and occasional free pokes
		- CastMec(Target, [minTargets])
			- Casts spell from rMEC, prioritizing target location 
--]]
class 'Caster' -- {

	local pManager = ProdictManager.GetInstance() 

	SPELL_TARGETED = 1
	SPELL_LINEAR = 2
	SPELL_CIRCLE = 3
	SPELL_CONE = 4
	SPELL_LINEAR_COL = 5
	SPELL_SELF = 6
	SPELL_TARGETED_FRIENDLY = 7 


	function Caster:__init(spell, range, spellType, speed, delay, width, useCollisionLib)
		--assert(spell and (range or spellType == SPELL_SELF), "Error: Caster:__init(spell, range, spellType, [speed, delay, width, useCollisionLib]), invalid arguments.")
		self.spell = spell
		self.range = range or 0
		self.spellType = spellType or SPELL_SELF
		self.speed = speed or math.huge
		self.delay = delay or 0
		self.width = width or 100
		self.spellData = myHero:GetSpellData(spell)
		if range ~= math.huge and range > 0 then
			Drawing.AddSkill(self.spell, self.range)
		end 
		if spellType == SPELL_LINEAR or spellType == SPELL_CIRCLE or spellType == SPELL_LINEAR_COL then
			--if type(range) == "number" and (not speed or type(speed) == "number") and (not delay type(delay) == "number" and (type(width) == "number" or not width) then
				--assert(type(range) == "number" and type(speed) == "number" and type(delay) == "number" and (type(width) == "number" or not width), "Error: Caster:__init(spell, range, [spellType, speed, delay, width, useCollisionLib]), invalid arguments for skillshot-type.")
				self.pred = pManager:AddProdictionObject(self.spell, self.range, self.speed, self.delay, self.width, myHero, 
					function(unit, pos, castspell)
						if GetDistance(unit) < self.range then 
							if spellType == SPELL_LINEAR_COL then 
								local collition = Collision(self.range, self.speed, self.delay, self.width + 10) 
								if not collition:GetMinionCollision(pos, myHero) then
									CastSpell(castspell.Name, pos.x, pos.z) 
								end 
							else 
								CastSpell(castspell.Name, pos.x, pos.z)
							end 
						end 
					end)

				if spellType == SPELL_LINEAR_COL then
					self.coll = VIP_USER and useCollisionLib ~= false and Collision(range, (speed or math.huge), delay, width) or nil
				end
			--end
		end
		--self.str = SpellStrings[self.spell]
		--Menu.Get(self.str):addParam("spellds1","-- Prodiction Options --", SCRIPT_PARAM_INFO, "")
		--Menu.Get(self.str):addParam("musthit" .. myHero.charName, "Use Must-Hit Mode", SCRIPT_PARAM_ONOFF, false)
	end

	function Caster:__type()
		return "Caster"
	end

	function Caster:Cast(target, minHitChance)
		if myHero:CanUseSpell(self.spell) ~= READY then return false end
		if self.spellType == SPELL_SELF then
			CastSpell(self.spell)
			return true
		elseif self.spellType == SPELL_TARGETED then
			if ValidTarget(target, self.range) then
				CastSpell(self.spell, target)
				return true
			end
		elseif self.spellType == SPELL_TARGETED_FRIENDLY then
			if target ~= nil and not target.dead and GetDistance(target) < self.range and target.team == myHero.team then
				CastSpell(self.spell, target)
				return true
			end
		elseif self.spellType == SPELL_CONE then
			if ValidTarget(target, self.range) then
				CastSpell(self.spell, target.x, target.z)
				return true
			end
		elseif self.spellType == SPELL_LINEAR or self.spellType == SPELL_CIRCLE or self.spellType == SPELL_LINEAR_COL then
			if self.pred and ValidTarget(target) then
				self.pred:EnableTarget(target, true)
				return true
			elseif target.team == myHero.team then
				CastSpell(self.spell, target.x, target.z)
				return true
			end 
		end
		return false
	end

	function Caster:CastMouse(spellPos, nearestTarget)
		--assert(spellPos and spellPos.x and spellPos.z, "Error: iCaster:CastMouse(spellPos, nearestTarget), invalid spellPos.")
		--assert(self.spellType ~= SPELL_TARGETED or (nearestTarget == nil or type(nearestTarget) == "boolean"), "Error: iCaster:CastMouse(spellPos, nearestTarget), <boolean> or nil expected for nearestTarget.")
		if myHero:CanUseSpell(self.spell) ~= READY then return false end
		if self.spellType == SPELL_SELF then
			CastSpell(self.spell)
			return true
		elseif self.spellType == SPELL_TARGETED then
			if nearestTarget ~= false then
				local targetEnemy
				for _, enemy in ipairs(GetEnemyHeroes()) do
					if ValidTarget(targetEnemy, self.range) and (targetEnemy == nil or GetDistanceFromMouse(enemy) < GetDistanceFromMouse(targetEnemy)) then
						targetEnemy = enemy
					end
				end
				if targetEnemy then
					CastSpell(self.spell, targetEnemy)
					return true
				end
			end
		elseif self.spellType == SPELL_LINEAR_COL or self.spellType == SPELL_LINEAR or self.spellType == SPELL_CIRCLE or self.spellType == SPELL_CONE then
			CastSpell(self.spell, spellPos.x, spellPos.z)
			return true
		end
	end

	function Caster:CastMec(Target, minTargets)
		if not self:Ready() then return false end
		local min = minTargets or 1
		local point = GetAoESpellPosition(self.width, Target) 
		if GetDistance(point) <= self.range and Monitor.CountEnemies(point, self.width) >= min then
			CastSpell(self.spell, point.x, point.z)
			return true 
		end 
		return false 
	end 	

	function Caster:Ready()
		return myHero:CanUseSpell(self.spell) == READY
	end

	function Caster:GetPrediction(target)
		if self.pred and ValidTarget(target) then return self.pred:GetPrediction(target) end
	end

	function Caster:GetCollision(spellPos)
		if spellPos and spellPos.x and spellPos.z then
			if self.coll then
				return self.coll:GetMinionCollision(myHero, spellPos)
			else
				return iCollision(spellPos, self.width)
			end
		end
	end
-- }

--[[
	Class: Drawing
	Author: iuser99
	- Designed for purely drawing purposes for iFoundation_v2. It can be disabled in the caster instance 
--]]
class "Drawing" -- {

	Drawing.instance = ""

	function Drawing.Instance()
		if Drawing.instance == "" then Drawing.instance = Drawing() end return Drawing.instance
	end 

	function Drawing:__init()
		self.queue = {}
		Menu.Get("Drawing"):addParam("drawPlayers", "Draw Players", SCRIPT_PARAM_ONOFF, false)
		Menu.Get("Drawing"):addParam("drawTarget", "Draw Target", SCRIPT_PARAM_ONOFF, true)
		Menu.Get("Drawing"):addParam("drawLines", "Draw Lines to Players", SCRIPT_PARAM_ONOFF, false)
		Menu.Get("Drawing"):addParam("playerDistance", "Max distance to draw players",SCRIPT_PARAM_SLICE, 1600, 0, 3000, 0)
		AddDrawCallback(function(obj) self:OnDraw() end)
	end 

	function Drawing.AddSkill(spell, range)
		return Drawing.Instance():_AddSkill(spell, range)
	end  

	function Drawing:_AddSkill(sspell, rrange)
		local tempSpell = SpellStrings[sspell]
		if self.queue["Skill" .. tempSpell] ~= nil then return end 
		Menu.Get("Drawing"):addParam("draw" .. tempSpell, "Draw " .. tempSpell .. " range", SCRIPT_PARAM_ONOFF, false)
		Menu.Get("Drawing"):addParam("colorReady" .. tempSpell, "Ready " .. tempSpell .. " Color", SCRIPT_PARAM_COLOR, {40, 71,149,38})
		Menu.Get("Drawing"):addParam("colorNotReady" .. tempSpell, "Not Ready " .. tempSpell .. " Color", SCRIPT_PARAM_COLOR, {40, 177, 0, 0})
		self.queue["Skill" .. tempSpell] = {spell = sspell, range = rrange, spellString = tempSpell, aTimer = 0}
	end 

	function Drawing:OnDraw()
		for name,d in pairs(self.queue) do 
			if string.find(name, "Skill") and Menu.Get("Drawing")["draw" .. d.spellString] then
				local tempColor = _ColorARGB.FromTable(Menu.Get("Drawing")["colorNotReady" .. d.spellString])
				if myHero:CanUseSpell(d.spell) == READY then 
					tempColor = _ColorARGB.FromTable(Menu.Get("Drawing")["colorReady" .. d.spellString])
				end
				DrawCircle(myHero.x, myHero.y, myHero.z, d.range, tempColor)
			end 
		end 

		if Menu.Get("Drawing").drawPlayers then 
			for i = 1, heroManager.iCount, 1 do 
				local target = heroManager:getHero(i)
				if ValidTarget(target) and target.dead ~= true and target ~= myHero and target.team == TEAM_ENEMY and GetDistance(target) <= Menu.Get("Drawing").playerDistance then 
					self:DrawTarget(target)
				end 
			end 
		end 

		if Menu.Get("Drawing").drawTarget then 
			local target = AutoCarry.Crosshair:GetTarget()
			if ValidTarget(target) and target.dead ~= true and target ~= myHero and target.team == TEAM_ENEMY and GetDistance(target) <= Menu.Get("Drawing").playerDistance then 
				self:DrawTarget(target)
			end 
		end 
	end 

	function Drawing:DrawTarget(Target) 
		if myHero.dead or not myHero.valid then return false end 
		local totalDamage = DamageCalculation.CalculateBurstDamage(Target)
		local realDamage = DamageCalculation.CalculateRealDamage(Target) 
		local dps = myHero:CalcDamage(Target, myHero.damage) * myHero.attackSpeed
		local ttk = (Target.health - realDamage) / dps 
		local tempColor = _ColorARGB.Red 
		local tempText = "Not Ready"
		if Target.health <= realDamage then
			tempColor = _ColorARGB.Green
			tempText = "KILL HIM"
		elseif Target.health > realDamage and Target.health <= totalDamage then 
			tempColor = _ColorARGB.Yellow 
			tempText = "Wait for cooldowns"
		end  
		for w = 0, 15 do 
			DrawCircle(Target.x, Target.y, Target.z, 40 + w * 1.5, tempColor:ToARGB())
		end 
		PrintFloatText(Target, 0, tempText .. " DMG: " .. round(realDamage) .. " (" .. string.format("%4.1f", ttk) .. "s)")
		if GetDistance(Target) <= Menu.Get("Drawing").playerDistance and Menu.Get("Drawing").drawLines then 
			DrawArrows(myHero, Target, 30, 0x099B2299, 50)
		end 
	end 
-- }

--[[
	Class: Combat
	Author: iuser99
	- Combat functions, mostly just for organization and lack of a better location 

	Methods:
		- GetTrueRange()
			- Champion true range
		- KillSteal(Caster, range)
			- Finds lowest health champion and attempts to kill them with the specified caster instance
		- LastHit(Caster, range)
			- Finds the lowest minion and kills them with the specified caster
		- CastLowest(Caster, percentage) 
			- Casts the specified caster to the lowest percentage ALLY, or none if not under the threshold percentage
		- GetNearestEnemy(range)
		- GetNearestMinion(range)
--]]
class 'Combat' -- {

	function Combat.GetTrueRange()

	    return myHero.range + GetDistance(myHero.minBBox)

	end
 
 	function Combat.KillSteal(Spell, range) 
		if not Spell:Ready() then return end 
		for i, enemy in pairs(_Heroes.GetObjects(ENEMY, range)) do 
			if enemy and ValidTarget(enemy) and not enemy.dead then 
				if enemy.health <= getDmg(SpellToString(Spell.spell), enemy, myHero) then
					Spell:Cast(enemy) 
				end 
			end 
		end 
	end 

	function Combat.LastHit(Spell, range) 
		if not Spell:Ready() then return end 
		for _, minion in pairs(AutoCarry.EnemyMinions().objects) do
			if ValidTarget(minion, range) and getDmg(SpellStrings[Spell.spell], minion, myHero) >= minion.health then 
				Spell:Cast(minion)
				myHero:Attack(minion)
			end 
		end 
	end 

	function Combat.CastLowest(Spell, percentage) 
		if not Spell:Ready() then return end 
		for _, player in pairs(_Heroes.GetObjects(ALLY, Spell.range)) do 
			if player and not player.dead and GetDistance(player) < Spell.range and player.health <= player.maxHealth * (percentage / 100) then
				Spell:Cast(player)
			end 
		end 
	end 

	function Combat.GetNearestEnemy(range)
		local distance = math.huge
		local best = nil
		for index, player in pairs(_Heroes.GetObjects(ENEMY, range)) do 
			if player and not player.dead then 
				if GetDistance(player) < distance then 
					best = player
					distance = GetDistance(player)
				end 
			end 
		end 
		return best
	end 

	function Combat.GetNearestMinion(range) 
		local distance = math.huge
		local best = nil 
		for index, minion in pairs(AutoCarry.EnemyMinions().objects) do
			if minion and not minion.dead then 
				if GetDistance(minion) < distance then 
					best = minion 
					distance = GetDistance(minion)
				end 
			end  
		end 
		return best
	end 

	function Combat.InRange(source, teamFlag, destination) 
		if not destination then 
			destination = {}
			for i=1, heroManager.iCount do 
				local p = heroManager:GetHero(i)
				if p and not p.dead and ((teamFlag and p.team == teamFlag) or true) then 
					if GetDistance(source, p) <= p.range then 
						table.insert(destination, p)
					end 
				end 
			end 
			if #destination > 1 then 
				return true, destination 
			end 
		else 
			if GetDistance(source, destination) <= destination then 
				return true, destination 
			end 
		end 
	end 

	function Combat.GetSurroundingAllies(Range)
		local result = {}
		for i=1, heroManager.iCount do 
			local p = heroManager:GetHero(i)
			if p and not p.dead and p.team == myHero.team and GetDistance(p) <= Range then 
				table.insert(result, p) 
			end 
		end 
		return result 
	end 

	function Combat.GetNearestAllyToEnemy(range) 
		local distance = math.huge
		local best = nil 
		for _, ally in pairs(GetSurroundingAllies(range)) do 
			if ally and not ally.dead then 
				for i=1, heroManager.iCount do 
					local p = heroManager:GetHero(i)
					if p and not p.dead and p.team ~= myHero.team then 
						if GetDistance(ally, p) <= distance then 
							best = ally 
							distance = GetDistance(ally, p)
						end 
					end 
				end 
			end 
		end 
		return best 
	end 
-- }

--[[
	Class: ComboLibrary
	Author: iuser99
	- A library designed for minimizing overkills often found in common STBW combos. It has 
	  several casting options and is extremely flexiable featuring customized cast conditions
	  and casting methods.

	Constructor: 
		- nil
	
	Methods:
		- AddCasters(table)
			- Adds the table of casters to the current combo instance (ONLY ADD ONCE)
		- UpdateCaster(spell, caster)
			- Updates caster instance (ie. From HumanQ -> SpiderQ (Elise))
		- AddCastCondition(spell, function)
			- Adds condition for cast in combo (no matter which combo) 
		- AddCast(spell, function)
			- Adds custom cast to the caster (useful for something such as Varus Q, or Ezreal E)
		- CastCombo(Target)
			- Casts combo in priority of damage 
		- CastSequenced(Target)
			- Casts combo in order of instanced (added) to table
		- CastWeaved(Target, attacked)
			- Weaves combo (AA > Q > AA); recommended to not call this initially, but instead
			  call SetWeave
		- SetWeave(boolean)
			- Sets weave to en/disabled (true/false); registers OnAttacked with SAC
--]]
class 'ComboLibrary' -- {
	
	function ComboLibrary:__init()
		self.casters = {}
		self.lastCast = 0 
		self.registeredWeave = false
	end 

	function ComboLibrary:AddCasters(table)
		for _, v in pairs(table) do 
			self:AddCaster(v)
			AutoKS.AddCaster(v)
			AutoFarm.AddCaster(v) 
		end 
	end 

	function ComboLibrary:AddCaster(caster)
		local tempSpell = SpellStrings[caster.spell]
		Menu.Get(tempSpell):addParam("cblb1","-- ComboLibrary Options --", SCRIPT_PARAM_INFO, "")
		Menu.Get(tempSpell):addParam("use" .. myHero.charName, "Use in smart combo", SCRIPT_PARAM_ONOFF, true)
		Menu.Get(tempSpell):addParam("distance" .. myHero.charName, "Required distance",SCRIPT_PARAM_SLICE, caster.range, 0, caster.range, 0)
		table.insert(self.casters, {spellVar = caster.spell, casterInstance = caster, damage = 0, customCastCondition = nil, mana = 0, customCast = nil})
	end 

	function ComboLibrary:UpdateCaster(spellVar, caster) 
		for k, v in pairs(self.casters) do 
			if v.spellVar == sepllVar then
				self.casters[k].casterInstance = caster 
				break 
			end 
		end 
	end 

	function ComboLibrary:AddCastCondition(spellVar, funct) 
		for k, v in pairs(self.casters) do 
			if v.spellVar == spellVar then
				self.casters[k].customCastCondition = funct
				break 
			end 
		end 
	end 

	function ComboLibrary:AddCustomCast(spellVar, funct)
		--Deprecate("ComboLibrary:AddCustomCast", "ComboLibrary:AddCastCondition")
		self:AddCastCondition(spellVar, funct)
	end 

	function ComboLibrary:AddCast(spellVar, funct) 
		for k, v in pairs(self.casters) do 
			if v.spellVar == spellVar then
				self.casters[k].customCast = funct
				break 
			end 
		end 
	end 

	function ComboLibrary:CheckMana(currentCombo) 
		local totalCost = 0
		for v, caster in pairs(currentCombo) do 
			totalCost = totalCost + myHero:GetSpellData(caster.spellVar).mana 
		end 
		return totalCost <= myHero.mana 
	end 

	function ComboLibrary:UpdateDamages(target) 
		for k, caster in pairs(self.casters) do 
			self.casters[k].damage = getDmg(SpellStrings[caster.spellVar], target, myHero)
			self.casters[k].mana = myHero:GetSpellData(caster.spellVar).mana 
		end 
	end

	function ComboLibrary:Sort() 
		table.sort(self.casters, function(a,b) 
			if a.damage == b.damage then 
				return a.mana < b.mana 
			end 
			return a.damage > b.damage
		 end)
	end 

	function ComboLibrary:GetCombo(target, asCaster) 
		local damage = 0
		local currentCombo = {}
		self:UpdateDamages(target)
		self:Sort()
		damage = damage + getDmg("AD", target, myHero)
		for k, v in ipairs(self.casters) do 
			if damage >= target.health then
				break 
			end 
			if v.casterInstance:Ready() then
				damage = damage + v.damage 
				table.insert(currentCombo, v)
			end 
		end 
		if self:CheckMana(currentCombo) and asCaster then
			return self:ToCasters(currentCombo)
		end
		return currentCombo
	end 

	function ComboLibrary:ToCasters(combo) 
		local localCasters = {}
		for k, v in pairs(combo) do 
			table.insert(localCasters, v.casterInstance)
		end 
		return localCasters
	end 

	function ComboLibrary:CastCombo(target) 
		if target == nil or target.dead then return false end 
		local combo = self:GetCombo(target, false) 
		for k, caster in ipairs(combo) do 
			if not target or target.dead then return true end 
			if Menu.Get(SpellStrings[caster.spellVar])["use" .. myHero.charName] then
				if caster.casterInstance:Ready() and ValidTarget(target, Menu.Get(SpellStrings[caster.spellVar])["distance" .. myHero.charName]) and (caster.customCastCondition == nil or caster.customCastCondition(target)) then
					if caster.customCast ~= nil then
						caster.customCast(target) 
					else 
						caster.casterInstance:Cast(target)
					end 
				end 
			end 
		end 
	end 

	function ComboLibrary:CastSequenced(target)
		self:CastSequenced(Target, false) 
	end 

	function ComboLibrary:CastSequenced(target, override) 
		if target == nil or target.dead then return false end 
		for k, caster in ipairs(self.casters) do 
			if Menu.Get(SpellStrings[caster.spellVar])["use" .. myHero.charName] or override then
				if caster.casterInstance:Ready() and ValidTarget(target, Menu.Get(SpellStrings[caster.spellVar])["distance" .. myHero.charName]) and (caster.customCastCondition == nil or caster.customCastCondition(target)) then
					if caster.customCast ~= nil then
						caster.customCast(target) 
					else 
						caster.casterInstance:Cast(target)
					end 
				end 
			end 
		end 
	end 

	function ComboLibrary:CastSpecific(target, spells) 
		if target == nil or target.dead then return false end 
		for k, caster in ipairs(self.casters) do 
			for spell, v in pairs(spells) do 
				if caster.spellVar == v then 
					if Menu.Get(SpellStrings[caster.spellVar])["use" .. myHero.charName] then
						if caster.casterInstance:Ready() and ValidTarget(target, Menu.Get(SpellStrings[caster.spellVar])["distance" .. myHero.charName]) and (caster.customCastCondition == nil or caster.customCastCondition(target)) then
							if caster.customCast ~= nil then
								caster.customCast(target) 
							else 
								caster.casterInstance:Cast(target)
							end 
						end 
					end 
				end 
			end 
		end 
	end 

	function ComboLibrary:CastWeaved(target, attacked) 
		if target == nil or target.dead or not self.weave then return false end 
		if attacked or GetTickCount() - self.lastCast > 3000 then
			if AutoCarry.Keys.AutoCarry then  
				for k, caster in ipairs(self.casters) do 
					if Menu.Get(SpellStrings[caster.spellVar])["use" .. myHero.charName] then
						if caster.casterInstance:Ready() and ValidTarget(target, Menu.Get(SpellStrings[caster.spellVar])["distance" .. myHero.charName]) and (caster.customCastCondition == nil or caster.customCastCondition(target)) then
							if caster.customCast ~= nil then
								self.lastCast = GetTickCount()
								return caster.customCast(target) 
							else 
								self.lastCast = GetTickCount()
								return caster.casterInstance:Cast(target)
							end 
						end 
					end 
				end 
			end 
		end 
	end 

	function ComboLibrary:OnAttacked()
		local target = AutoCarry.Crosshair:GetTarget()
		if target then 
			self:CastWeaved(target, true)
		end 
	end 

	function ComboLibrary:RegisterWeave() 
		AutoCarry.Plugins:RegisterOnAttacked(function() self:OnAttacked() end)
		self.registeredWeave = true
	end 

	function ComboLibrary:SetWeave(bool) 
		self.weave = bool 
		if bool then 
			if not self.registeredWeave then 
				self:RegisterWeave()
			end 
		end 
	end 

	function ComboLibrary.KillableCast(Target, spellName) 
		return getDmg(spellName, Target, myHero) > Target.health
	end 
-- }

--[[
	Class: AutoKS
	Author: iuser99
	- Mainly for iFoundation_v2 with ComboLibrary, simply a kill steal class for any 
	  caster added to the foundation, with menu support. Not particularily useful for 
	  sole instancing. 
--]]
class 'AutoKS' -- {
	
	AutoKS.instance = ""

	function AutoKS.Instance()
		if AutoKS.instance == "" then AutoKS.instance = AutoKS() end return AutoKS.instance 
	end 

	function AutoKS:__init()
		self.casters = {}
		self.target = nil
		self.caster = nil
		Menu.Get():addSubMenu("KillSteal", "KillSteal")
		Menu.Get("KillSteal"):addParam("hotkey", "KS HotKey", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("T"))
		Menu.Get("KillSteal"):addParam("useIgnite", "Ignite killable target", SCRIPT_PARAM_ONOFF, true)
		AddTickCallback(function(obj) self:OnTick() end)
	end 

	function AutoKS.AddCaster(caster)
		AutoKS.Instance():_AddCaster(caster)
	end 

	function AutoKS:_AddCaster(caster)
		local tempSpell = SpellStrings[caster.spell]
		Menu.Get(tempSpell):addParam("ks1","-- KS Options --", SCRIPT_PARAM_INFO, "")
		Menu.Get(tempSpell):addParam("ks" .. tempSpell, "Use for KillSteal", SCRIPT_PARAM_ONOFF, false)
		Menu.Get(tempSpell):addParam("message" .. tempSpell, "Message for KillSteal", SCRIPT_PARAM_ONOFF, false)
		--self.Menu:addParam("color" .. tempSpell, tempSpell .. " Color", SCRIPT_PARAM_COLOR, {0, 200, 150, 255})
		table.insert(self.casters, {casterInstance = caster, string = tempSpell})
	end 

	function AutoKS:GetTable(Target)
		local t = {}
		for k, cast in pairs(self.casters) do 
			if cast.casterInstance:Ready() then
				table.insert(t, {damage = getDmg(cast.string, Target, myHero), caster = cast})
			end 
		end 
		table.sort(t, function(a, b) return a.damage < b.damage end)
		return t 
	end 

	function AutoKS:Find()
		for _, enemy in pairs(GetEnemyHeroes()) do
			if enemy and not enemy.dead then
				for k, item in pairs(self:GetTable(enemy)) do 
					if GetDistance(enemy) <= item.caster.casterInstance.range and item.damage > enemy.health then 
						return enemy, item.caster
					end 
				end 
			end 
		end 
	end 

	function AutoKS:OnTick() 
		self.target, self.caster = self:Find()
		if self.target and not self.target.dead then
			if Menu.Get(self.caster.string)["message" .. self.caster.string] then
				local message = "Performing!"
				if not Menu.Get(tempSpell)["ks" .. self.caster.string] then
					message = "Available! Press hotkey!"
				end 
				_Message.AddMessage("AutoKS: " .. message, _ColorARGB.Green)
			end 
			if Menu.Get(self.caster.string)["ks" .. self.caster.string] or Menu.Get("KillSteal").hotkey then
				local c = self.caster.casterInstance 
				if c:Ready() then c:Cast(self.target) end 
			end 
		end 
	end 
-- }

class 'AutoFarm' -- {
	
	AutoFarm.instance = ""

	function AutoFarm.Instance() 
		if AutoFarm.instance == "" then AutoFarm.instance = AutoFarm() end return AutoFarm.instance 
	end 

	function AutoFarm:__init() 
		self.casters = {}
		self.lastEnabled = nil 

		AddTickCallback(function(obj) self:OnTick() end)
	end 

	function AutoFarm.AddCaster(caster) 
		AutoFarm.Instance():_AddCaster(caster) 
	end 

	function AutoFarm:_AddCaster(caster) 
		local tempSpell = SpellStrings[caster.spell]
		Menu.Get(tempSpell):addParam("sepfrm" .. tempSpell, "-- LastHit Options --", SCRIPT_PARAM_INFO, "")
		Menu.Get(tempSpell):addParam("lh" .. tempSpell, "Use for LastHit", SCRIPT_PARAM_ONOFF, false)
		table.insert(self.casters, {casterInstance = caster, string = tempSpell})
	end 

	function AutoFarm:OnTick() 
		self:UpdateMenu()
		local caster = self:GetCaster() 
		if caster and (AutoCarry.Keys.LastHit or AutoCarry.Keys.LaneClear) then 
			Combat.LastHit(caster, caster.range) 
		end 
	end 

	function AutoFarm:GetCaster() 
		for _, caster in pairs(self.casters) do  
			if Menu.Get(caster.string)["lh" .. caster.string] then 
				return caster.casterInstance 
			end 
		end 
	end 

	function AutoFarm:UpdateMenu()
		for _, caster in pairs(self.casters) do 
			if Menu.Get(caster.string)["lh" .. caster.string] then 
				if self.lastEnabled ~= caster.string then 
					self:DisableOptions(caster.string) 
					self.lastEnabled = caster.string 
				end 
			end 
		end 
	end 

	function AutoFarm:DisableOptions(except)
		for _, caster in pairs(self.casters) do 
			if Menu.Get(caster.string)["lh" .. caster.string] and caster.string ~= except then 
				Menu.Get(caster.string)["lh" .. caster.string] = false 
			end 
		end 
	end 
-- }

class "DamageCalculation" -- {
	local items = { -- Item Aliases for spellDmg lib, including their corresponding itemID's.
		{ name = "DFG", id = 3128},
		{ name = "HXG", id = 3146},
		{ name = "BWC", id = 3144},
		{ name = "HYDRA", id = 3074},
		{ name = "SHEEN", id = 3057},
		{ name = "KITAES", id = 3186},
		{ name = "TIAMAT", id = 3077},
		{ name = "NTOOTH", id = 3115},
		{ name = "SUNFIRE", id = 3068},
		{ name = "WITSEND", id = 3091},
		{ name = "TRINITY", id = 3078},
		{ name = "STATIKK", id = 3087},
		{ name = "ICEBORN", id = 3025},
		{ name = "MURAMANA", id = 3042},
		{ name = "LICHBANE", id = 3100},
		{ name = "LIANDRYS", id = 3151},
		{ name = "BLACKFIRE", id = 3188},
		{ name = "HURRICANE", id = 3085},
		{ name = "RUINEDKING", id= 3153},
		{ name = "LIGHTBRINGER", id = 3185},
		{ name = "SPIRITLIZARD", id = 3209},
		--["ENTROPY"] = 3184,
	}

	DamageCalculation.instance = ""

	function DamageCalculation.Instance()
		if DamageCalculation.instance == "" then DamageCalculation.instance = DamageCalculation() end return DamageCalculation.instance
	end  

	function DamageCalculation:__init()
		self.addItems = true
		self.spells = {}
		self.spellTable = {"Q", "W", "E", "R"}
		for _, spellName in pairs(self.spellTable) do
			self.spells[spellName] = {name = spellName, spell = SpellString[spellName]}
		end 

		self.ignite = nil
		if myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot") then 
			self.ignite = SUMMONER_1
		elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot") then
			self.ignite = SUMMONER_2
		else 
			self.ignite = nil
	  	end
	end

	function DamageCalculation.GetDamage(spell, Target)
		return DamageCalculation.Instance():_GetDamage(spell, Target) 
	end 

	function DamageCalculation:_GetDamage(spell, Target, player)
		self.player = player or myHero 
		return getDmg(spell, Target, self.player)
	end 

	function DamageCalculation.CalculateItemDamage(Target)
		return DamageCalculation.Instance():_CalculateItemDamage(Target) 
	end 

	function DamageCalculation:_CalculateItemDamage(Target, player)
		self.player = player or myHero 
		self.itemTotalDamage = 0
		for _, item in pairs(items) do 
			-- On hit items
			self.itemTotalDamage = self.itemTotalDamage + (GetInventoryHaveItem(item.id, self.player) and getDmg(item.name, Target, self.player) or 0)
		end
	end

	function DamageCalculation.CalculateRealDamage(Target) 
		return DamageCalculation.CalculateRealDamage(Target, myHero)
	end 

	function DamageCalculation.CalculateRealDamage(Target, player) 
		return DamageCalculation.Instance():_CalculateRealDamage(Target, player) 
	end 

	function DamageCalculation:_CalculateRealDamage(Target, player)
	 	self.player = player or myHero 
		local total = 0
		for _, spell in pairs(self.spells) do 
			if self.player:CanUseSpell(spell.spell) == READY and self.player:GetSpellData(spell.spell).mana <= self.player.mana then
				total = total + self:_GetDamage(spell.name, Target, self.player)
			end 
		end
		if self.addItems then
			self:_CalculateItemDamage(Target, self.player) 
			total = total + self.itemTotalDamage 
		end
		if ignite ~= nil and myHero:CanUseSpell(self.ignite) == READY then 
			total = total + self:_GetDamage("IGNITE", Target)
		end 
		total = total + self:_GetDamage("AD", Target, self.player)
		total = total + self:_GetDamage("P", Target, self.player)
		return total 
	end

	function DamageCalculation.CalculateBurstDamage(Target)
		return DamageCalculation.Instance():_CalculateBurstDamage(Target) 
	end 

	function DamageCalculation:_CalculateBurstDamage(Target)
		local localSpells = self.spells
		local total = 0 
		for _, spell in pairs(localSpells) do
			if myHero:CanUseSpell(spell.spell) == READY then
				total = total + self:_GetDamage(spell.name, Target)
			end
		end 
		if self.addItems then
			self:_CalculateItemDamage(Target) 
			total = total + self.itemTotalDamage 
		end
		if self.ignite ~= nil then 
			total = total + self:_GetDamage("IGNITE", Target)
		end 
		total = total + self:_GetDamage("AD", Target)
		total = total + self:_GetDamage("P", Target, self.player)
		return total 
	end 
-- }

class 'AutoPotion' -- {

	local PotionTable = {
		fortitude = {
			tick = 0,
			slot = nil,
			itemID = 2037,
			compareValue = function() return (myHero.health / myHero.maxHealth) end,
			buff = "PotionOfGiantStrengt",
		},
		flask = {
			tick = 0,
			slot = nil,
			itemID	= 2041,		-- item ID of Crystaline Flask (2041)
			compareValue = function() return math.min(myHero.mana / myHero.maxMana,myHero.health / myHero.maxHealth) end,
			buff = "ItemCrystalFlask",
		},
		biscuit = {	
			tick = 0,
			slot = nil, 
			itemID	= 2009,		-- item ID of Total Biscuit of Rejuvenation (2009)
			compareValue = function() return math.min(myHero.mana / myHero.maxMana,myHero.health / myHero.maxHealth) end,
			buff = "ItemMiniRegenPotion",
		},
		hp = {
			tick = 0,
			slot = nil, 
			itemID	= 2003,		-- item ID of health potion (2003)
			compareValue = function() return (myHero.health / myHero.maxHealth) end,
			buff = "RegenerationPotion",
		},
		mp = {
			tick = 0,
			slot = nil,
			itemID	= 2004,		-- item ID of mana potion (2004)
			compareValue = function() return (myHero.mana / myHero.maxMana) end,
			buff = "FlaskOfCrystalWater",
		}
	}

	function AutoPotion:__init()
		Menu.Get("Potions"):addParam("usePotions", "Use Auto-Potions", SCRIPT_PARAM_ONOFF, true)
		Menu.Get("Potions"):addParam("notify", "Notify on Auto-Potions", SCRIPT_PARAM_ONOFF, true)
		Menu.Get("Potions"):addParam("percentage", "Usage percentage",SCRIPT_PARAM_SLICE, 60, 0, 100, 0)
		AddTickCallback(function(obj) self:OnTick() end)
	end 

	function AutoPotion:OnTick() 
		if not Menu.Get("Potions").usePotions or myHero.dead or ((GetGame().map.index ~= 7 and GetGame().map.index ~= 12) and InFountain()) then return end 
		for name,potion in pairs(PotionTable) do 
			if potion.tick == 0 or (GetTickCount() - potion.tick > 1000) then 
				potion.slot = GetInventorySlotItem(potion.itemID) 
				if potion.slot ~= nil and self:CheckBuffs() then
					if potion.compareValue() < (Menu.Get("Potions").percentage / 100) then
						if Menu.Get("Potions").notify then 
							_Message.AddMessage("AutoPotion: Used Potion", _ColorARGB.Green)
						end
						CastSpell(potion.slot)
						potion.tick = GetTickCount()
					end 
				end 
			end 
		end 
	end 

	function AutoPotion:CheckBuffs() 
		for name, potion in pairs(PotionTable) do 
			if TargetHaveBuff(potion.buff) then
				return false
			end 
		end 
		return true 
	end 
-- }

class "Priority" -- {

	local priorityTable = {
		AP = {
			"Ahri", "Akali", "Anivia", "Annie", "Brand", "Cassiopeia", "Diana", "Evelynn", "FiddleSticks", "Fizz", "Gragas", "Heimerdinger", "Karthus",
			"Kassadin", "Katarina", "Kayle", "Kennen", "Leblanc", "Lissandra", "Lux", "Malzahar", "Mordekaiser", "Morgana", "Nidalee", "Orianna",
			"Rumble", "Ryze", "Sion", "Swain", "Syndra", "Teemo", "TwistedFate", "Veigar", "Viktor", "Vladimir", "Xerath", "Ziggs", "Zyra", "MasterYi",
		},
		Support = {
			"Blitzcrank", "Janna", "Karma", "Leona", "Lulu", "Nami", "Sona", "Soraka", "Thresh", "Zilean",
		},
		Tank = {
			"Amumu", "Chogath", "DrMundo", "Galio", "Hecarim", "Malphite", "Maokai", "Nasus", "Rammus", "Sejuani", "Shen", "Singed", "Skarner", "Volibear",
			"Warwick", "Yorick", "Zac", "Nunu", "Taric", "Alistar",
		},
		AD_Carry = {
			"Ashe", "Caitlyn", "Corki", "Draven", "Ezreal", "Graves", "Jayce", "KogMaw", "MissFortune", "Pantheon", "Quinn", "Shaco", "Sivir",
			"Talon", "Tristana", "Twitch", "Urgot", "Varus", "Vayne", "Zed", "Jinx"
		},
		Bruiser = {
			"Darius", "Elise", "Fiora", "Gangplank", "Garen", "Irelia", "JarvanIV", "Jax", "Khazix", "LeeSin", "Nautilus", "Nocturne", "Olaf", "Poppy",
			"Renekton", "Rengar", "Riven", "Shyvana", "Trundle", "Tryndamere", "Udyr", "Vi", "MonkeyKing", "XinZhao", "Aatrox"
		},
	}

	local SupportTable = {
		AD_Carry = {
			"Ashe", "Caitlyn", "Corki", "Draven", "Ezreal", "Graves", "Jayce", "KogMaw", "MissFortune", "Pantheon", "Quinn", "Shaco", "Sivir",
			"Talon", "Tristana", "Twitch", "Urgot", "Varus", "Vayne", "Zed", "Jinx"
		},
		Bruiser = {
			"Darius", "Elise", "Fiora", "Gangplank", "Garen", "Irelia", "JarvanIV", "Jax", "Khazix", "LeeSin", "Nautilus", "Nocturne", "Olaf", "Poppy",
			"Renekton", "Rengar", "Riven", "Shyvana", "Trundle", "Tryndamere", "Udyr", "Vi", "MonkeyKing", "XinZhao", "Aatrox"
		},
		Tank = {
			"Amumu", "Chogath", "DrMundo", "Galio", "Hecarim", "Malphite", "Maokai", "Nasus", "Rammus", "Sejuani", "Shen", "Singed", "Skarner", "Volibear",
			"Warwick", "Yorick", "Zac", "Nunu", "Taric", "Alistar",
		},
		AP = {
			"Ahri", "Akali", "Anivia", "Annie", "Brand", "Cassiopeia", "Diana", "Evelynn", "FiddleSticks", "Fizz", "Gragas", "Heimerdinger", "Karthus",
			"Kassadin", "Katarina", "Kayle", "Kennen", "Leblanc", "Lissandra", "Lux", "Malzahar", "Mordekaiser", "Morgana", "Nidalee", "Orianna",
			"Rumble", "Ryze", "Sion", "Swain", "Syndra", "Teemo", "TwistedFate", "Veigar", "Viktor", "Vladimir", "Xerath", "Ziggs", "Zyra", "MasterYi",
		},
		Support = {
			"Blitzcrank", "Janna", "Karma", "Leona", "Lulu", "Nami", "Sona", "Soraka", "Thresh", "Zilean",
		},	
	}

	Priority.instance = ""

	function Priority.Instance(bool) 
		if Priority.instance == "" then Priority.instance = Priority(bool) end return Priority.instance
 	end 

	function Priority:__init(support)
		if support then
			priorityTable = SupportTable 
		end 
		if #GetEnemyHeroes() > 1 then
			TargetSelector(TARGET_LESS_CAST_PRIORITY, 0)
			self:arrangePrioritys(#GetEnemyHeroes())
		end
	end

	function Priority:SetPriority(table, hero, priority)
		for i=1, #table, 1 do
			if hero.charName:find(table[i]) ~= nil then
				TS_SetHeroPriority(priority, hero.charName)
			end
		end
	end

	function Priority:arrangePrioritys(enemies)
		local priorityOrder = {
			[2] = {1,1,2,2,2},
			[3] = {1,1,2,3,3},
			[4] = {1,2,3,4,4},
			[5] = {1,2,3,4,5},
		}
		for i, enemy in ipairs(GetEnemyHeroes()) do
			self:SetPriority(priorityTable.AD_Carry, enemy, priorityOrder[enemies][1])
			self:SetPriority(priorityTable.AP,       enemy, priorityOrder[enemies][2])
			self:SetPriority(priorityTable.Support,  enemy, priorityOrder[enemies][3])
			self:SetPriority(priorityTable.Bruiser,  enemy, priorityOrder[enemies][4])
			self:SetPriority(priorityTable.Tank,     enemy, priorityOrder[enemies][5])
		end
	end
-- }

class "Monitor" -- {

	Monitor.instance = ""

	function Monitor.Instance() 
		if Monitor.instance == "" then Monitor.instance = Monitor() end return Monitor.instance 
	end 

	function Monitor:__init() 
		self.FriendlyTable = {}

		self.monitorTable = {}

		self.teleporting = false
		AddCreateObjCallback(function(object) self:OnCreateObj(object) end)
		AddDeleteObjCallback(function(object) self:OnDeleteObj(object) end)
	end 

	function Monitor.IsTeleporting() 
		return Monitor.Instance():_IsTeleporting() 
	end 

	function Monitor:_IsTeleporting() 
		return self.teleporting 
	end 

	function Monitor:OnCreateObj(object)
		if object and (object.name == "TeleportHomeImproved.troy" or object.name == "TeleportHome.troy") then
			self.teleporting = true
		end 
	end 

	function Monitor:OnDeleteObj(object) 
		if object and (object.name == "TeleportHomeImproved.troy" or object.name == "TeleportHome.troy") then
			self.teleporting = false
		end 
	end 
	function Monitor.GetLowAlly()
		return Monitor.Instance():_GetLowAlly()
	end 

	function Monitor:_GetLowAlly()	
		for i, target in pairs(_Heroes.GetObjects(ALLY, math.huge)) do 
			if target.health / target.maxHealth <= (50 / 100) then 
				return target 
			end 
		end 
	end 

	function Monitor.GetAllyWithMostEnemies(range) 
		return Monitor.Instance():_GetAllyWithMostEnemies(range) 
	end 

	function Monitor:_GetAllyWithMostEnemies(range)
		local best = nil
		local enemies = math.huge
		for i, target in pairs(_Heroes.GetObjects(ALLY, range)) do
			if target and not target.dead then
				if best == nil then
					best = target 
					enemies = self:_CountEnemies(target, range)
				elseif self:_CountEnemies(target, range) > enemies then
					best = target
					enemies = self:_CountEnemies(target, range)
				end 
			end 
		end 
		return best 
	end 

	function Monitor.CountEnemies(point, range)
		return Monitor.Instance():_CountEnemies(point, range) 
	end 

	function Monitor:_CountEnemies(point, range) 
		local count = 0
		for i, target in pairs(GetEnemyHeroes()) do 
			if target and not target.dead and GetDistance(target, point) < range then
				count = count + 1
			end 
		end 
		return count 
	end 

	function Monitor.GetHighestDamageAlly() 
		local bestChamp = nil 
		local damage = math.huge
		for _, player in pairs(_Heroes.GetObjects(1, 1000)) do 
			if not player.dead and not player.isMe then
				if bestChamp == nil then
					bestChamp = player
					damage = DamageCalculation.CalculateRealDamage(Target, player)
				elseif DamageCalculation.CalculateRealDamage(Target, player) > damage then
					bestChamp = player
					damage = DamageCalculation.CalculateRealDamage(Target, player) > Target
				end 
			end 
		end 
		return bestChamp, damage
	end 
-- }

class 'AutoShield' -- {

	AvoidList = {
	-- AOE
		["UFSlash"] = 300,
		["GragasExplosiveCask"] = 400,
		["CurseoftheSadMummy"] = 550,
		["LeonaSolarFlare"] = 400,
		["InfernalGuardian"] = 250,
		["DianaVortex"] = 300,
		["RivenMartyr"] = 200,
		["OrianaDetonateCommand"] = 400,
		["DariusAxeGrabCone"] = 200,
		["LeonaZenithBladeMissile"] = 200,
		["ReapTheWhirlwind"] = 600,
		["ShenShadowDash"] = 350,
		["GalioIdolOfDurand"] = 600,
		["XenZhaoParry"] = 200,
		["EvelynnR"] = 400,
		["Pulverize"] = 250,
		["VladimirHemoplague"] = 200,
	-- Target
		["Headbutt"] = 0,
		["Dazzle"] = 0,
		["CrypticGaze"] = 0,
		["Pantheon_LeapBash"] = 0,
		["RenektonPreExecute"] = 0,
		["IreliaEquilibriumStrike"] = 0,
		["MaokaiUnstableGrowth"] = 0,
		["BusterShot"] = 0,
		["BlindMonkRKick"] = 0,
		["VayneCondemn"] = 0,
		["SkarnerImpale"] = 0,
		["ViR"] = 0,
		["Terrify"] = 0,
		["IceBlast"] = 0,
		["NullLance"] = 0,
		["PuncturingTaunt"] = 0,
		["BlindingDart"] = 0,
		["VeigarPrimordialBurst"] = 0,
		["DeathfireGrasp"] = 0,
		["GarenJustice"] = 0,
		["DariusExecute"] = 0,
		["ZedUlt"] = 0,
		["PickaCard_yellow_mis.troy"] = 0,
		["RunePrison"] = 0,
		["PoppyHeroicCharge"] = 0,
		["AlZaharNetherGrasp"] = 0,
		["InfiniteDuress"] = 0,
		["UrgotSwap2"] = 0,
		["TalonCutthroat"] = 0,
		["LeonaShieldOfDaybreakAttack"] = 0,
	}

	local PlayerSkills = {
		"Q", "W", "E", "R", "P", "QM", "WM", "EM"
	}

	local OnHitItems = {
		["KITAES"] = 3186,
		["MALADY"] = 3114,
		["WITSEND"] = 3091,
		["SHEEN"] = 3057,
		["TRINITY"] = 3078,
		["LICHBANE"] = 3100,
		["ICEBORN"] = 3025,
		["STATIKK"] = 3087,
		["RUINEDKING"] = 3153,
		["SPIRITLIZARD"] = 3209
	}

	local SkillOnHitItems = {
		["LIANDRYS"] = 3151,
		["BLACKFIRE"] = 3188,
		["SPIRITLIZARD"] = 3209
	}
	
	AutoShield.instance = ""

	AutoShield.selfOverride = false

	function AutoShield.Instance(range, ShieldSpell) 
		if AutoShield.instance == "" then AutoShield.instance = AutoShield(range, ShieldSpell) end return AutoShield.instance
	end 

	function AutoShield:__init(range, ShieldSpell)
		self.range = range or math.huge 
		if ShieldSpell then
			self.ShieldSpell = ShieldSpell 
			Menu.Get(SpellStrings[ShieldSpell.spell]):addParam("desc1","-- Auto-Shield Options --", SCRIPT_PARAM_INFO, "")
			Menu.Get(SpellStrings[ShieldSpell.spell]):addParam("selfShield", "Use auto-shield for myself", SCRIPT_PARAM_ONOFF, false)
			Menu.Get(SpellStrings[ShieldSpell.spell]):addParam("selfPercentage", "Health percentage for self",SCRIPT_PARAM_SLICE, 5, 0, 100, 0)
			if self.ShieldSpell.spellType ~= SPELL_SELF or AutoShield.selfOverride then 
				Menu.Get(SpellStrings[ShieldSpell.spell]):addParam("allyShield", "Use auto-shield for allies", SCRIPT_PARAM_ONOFF, false)
				Menu.Get(SpellStrings[ShieldSpell.spell]):addParam("allyPercentage", "Health percentage for allies",SCRIPT_PARAM_SLICE, 20, 0, 100, 0)
			end 
			AddProcessSpellCallback(function(obj, spell) self:OnProcessSpell(obj, spell) end)	
		end 
	end

	function AutoShield:OnProcessSpell(object, spell) 
		if (object == nil or spell == nil) or not self.ShieldSpell:Ready() then return end 
		if object.team ~= myHero.team then
			self.spellType, self.castType = getSpellType(object, spell.name)
			if Menu.Get(SpellStrings[self.ShieldSpell.spell]).selfShield then
				if self:SpellWillHit(object, spell, myHero) then
					local damagePercent = self:GetSpellDamage(object, spell, myHero) * 100 / myHero.health
					if Menu.Get(SpellStrings[self.ShieldSpell.spell]).selfPercentage == 0 or damagePercent > Menu.Get(SpellStrings[self.ShieldSpell.spell]).selfPercentage then
						_Message.AddMessage("AutoShield: Shielded you from " .. round(damagePercent) .. "% of damage", _ColorARGB.Green)
						self.ShieldSpell:Cast(myHero)
					end 
				end 
			end 
			if (self.ShieldSpell.spellType ~= SPELL_SELF or AutoShield.selfOverride) and Menu.Get(SpellStrings[self.ShieldSpell.spell]).allyShield then
				for i, player in pairs(_Heroes.GetObjects(ALLY, self.range)) do 
					if not player.dead and self:SpellWillHit(object, spell, player) then 
						local damagePercent = self:GetSpellDamage(object, spell, player) * 100 / player.health
						if damagePercent > Menu.Get(SpellStrings[self.ShieldSpell.spell]).allyPercentage then 
							self.ShieldSpell:Cast(player)
							_Message.AddMessage("AutoShield: Shielded " .. player.charName .. " from " .. round(damagePercent) .. "% of damage", _ColorARGB.Green)
						end 
					end 
				end 
			end 
		end 
	end 

	function AutoShield:GetSpellDamage(object, spell, target) 
		if object == nil or spell == nil or target == nil then return 0 end 
		local attackDamage = object:CalcDamage(target, object.totalDamage)
		if object.type ~= "obj_AI_Hero" then
			if spell.name:find("BasicAttack") then
				return attackDamage 
			elseif spell.name:find("CritAttack") then 
				return attackDamage * 2 
			end 
		else
			local itemDamage = 0
			for name, id in pairs(OnHitItems) do 
				if GetInventoryHaveItem(id, object) then
					itemDamage = itemDamage + getDmg(name, target, object)
				end 
			end 
			if self.spellType == "BAttack" then
				return (attackDamage + itemDamage) * 1.07
			elseif self.spellType == "CAttack" then 
				local ie = 0
				if GetInventoryHaveItem(3031,object) then ie = .5 end 
				return (attackDamage * (2.1 + ie) + itemDamage) * 1.07
			elseif PlayerSkills[self.spellType] ~= nil then
				local skillDamage, skillType = 0, 0
				local skillItemDamage = 0
				for name, id in pairs(SkillOnHitItems) do 
					if GetInventoryHaveItem(id, object) then 
						skillItemDamage = skillItemDamage + getDmg(name, target, object)
					end 
				end 

				skillDamage, skillType = getDmg(self.spellType, target, object, self.castType, spell.level)

				if skillType ~= 2 then
					return (skillDamage + skillItemDamage) * 1.07
				end 
				return (skillDamage + attackDamage + itemDamage + skillItemDamage) * 1.07
			end 						
		end
		return attackDamage 
	end 

	function AutoShield:SpellWillHit(object, spell, target) 
		if object == nil then return false end 
		local hitchampion = false
		if object.type == "obj_AI_Hero" and (self.spellType == "BAttack" or self.spellType == "CAttack") then
			hitchampion = GetDistance(target, spell.endPos) < 80 
		elseif self.spellType == "Q" or self.spellType == "W" or self.spellType == "E" or self.spellType =="R" then
			local shottype = skillData[object.charName][self.spellType]["type"]
			local radius = skillData[object.charName][self.spellType]["radius"]
			local maxdistance = skillData[object.charName][self.spellType]["maxdistance"]
			local P2 = spell.endPos 
			if shottype == 0 then hitchampion = checkhitaoe(object, P2, 80, target, 0)
			elseif shottype == 1 then hitchampion = checkhitlinepass(object, P2, radius, maxdistance, target, 50)
			elseif shottype == 2 then hitchampion = checkhitlinepoint(object, P2, radius, maxdistance, target, 50)
			elseif shottype == 3 then hitchampion = checkhitaoe(object, P2, radius, maxdistance, target, 50)
			elseif shottype == 4 then hitchampion = checkhitcone(object, P2, radius, maxdistance, target, 50)
			elseif shottype == 5 then hitchampion = checkhitwall(object, P2, radius, maxdistance, target, 50)
			elseif shottype == 6 then hitchampion = checkhitlinepass(object, P2, radius, maxdistance, target, 50) or checkhitlinepass(object, Vector(object)*2-P2, radius, maxdistance, target, 50)
			elseif shottype == 7 then hitchampion = checkhitcone(P2, object, radius, maxdistance, target, 50)
			end
		end  
		return hitchampion
	end 

	function AutoShield.SpellHit(object, spell, target)
		AutoShield.Instance().spellType, AutoShield.Instance().castType = getSpellType(object, spell.name)
		return AutoShield.Instance():SpellWillHit(object, spell, target)
	end 
-- }

class 'AutoBuff' -- {
	
	AutoBuff.instance = ""

	function AutoBuff.Instance(BuffSpell) 
		if AutoBuff.instance == "" then AutoBuff.instance = AutoBuff(BuffSpell) end return AutoBuff.instance
	end 

	function AutoBuff:__init(BuffSpell) 
		self.BuffSpell = BuffSpell
		Menu.Get(SpellStrings[BuffSpell.spell]):addParam("desc1","-- Auto-Buff Options --", SCRIPT_PARAM_INFO, "")
		Menu.Get(SpellStrings[BuffSpell.spell]):addParam("enabled", "Auto-Buff AA", SCRIPT_PARAM_ONOFF, false)
		AddProcessSpellCallback(function(obj, spell) self:OnProcessSpell(obj, spell) end)
	end

	function AutoBuff:OnProcessSpell(object, spellProc) 
		if object == nil or spellProc == nil or not self.BuffSpell:Ready() or not Menu.Get(SpellStrings[self.BuffSpell.spell]).enabled then return end 
		if object and spellProc and object.type == "obj_AI_Hero" and GetDistance(object) <= self.BuffSpell.range then
			spellType, castType = getSpellType(object, spellProc.name)
			if spellType == "CAttack" or spellType == "BAttack" then 
				for i, player in pairs(GetEnemyHeroes()) do 
					if not player.dead and GetDistance(player, spellProc.endPos) < 80 then
						--_Message.AddMessage("AutoBuff: Buffed player", _ColorARGB.Green)
						if self.BuffSpell.type == SPELL_SELF and object.isMe then
							self.BuffSpell:Cast(myHero)  
						else 
							self.BuffSpell:Cast(object) 
						end 
					end  
				end  	
			end 		
		end 
	end 
-- }

class 'MovementPrediction' -- {

	DIRECTION_AWAY = 0 
	DIRECTION_TOWARDS = 1
	DIRECTION_UNKNOWN = 2
	
	MovementPrediction.instance = ""

	function MovementPrediction.Instance() 
		if MovementPrediction.instance == "" then MovementPrediction.instance = MovementPrediction() end return MovementPrediction.instance 
	end 

	function MovementPrediction:__init() 
		self.wp = WayPointManager()
	end 

	function MovementPrediction.GetDirection(Target)
		return MovementPrediction.Instance():_GetDirection(Target)
	end 

	function MovementPrediction:_GetDirection(Target)
		if Target and not Target.dead then 
			local points = self.wp:GetWayPoints(Target)
			if points[1] == nil or points[2] == nil then return DIRECTION_UNKNOWN end 
			local d1 = GetDistanceSqr(points[1]) 
			local d2 = GetDistanceSqr(points[2]) 
			if d1 < d2 then 
				return DIRECTION_AWAY
			elseif d1 > d2 then 
				return DIRECTION_TOWARDS
			end 
		end 
	end 

	function MovementPrediction.Place(Skill, Target) 
		MovementPrediction.Instance():_Place(Skill, Target)
	end 

	function MovementPrediction:_Place(Skill, Target)
		local direction = self:_GetDirection(Target)
		if direction == DIRECTION_TOWARDS then 
			--PrintChat("TOWARDS")
			self.PlaceInfront(Skill, Target)
		elseif direction == DIRECTION_AWAY then 
			--PrintChat("AWAY")
			self.PlaceBehind(Skill, Target)
		end 
	end 

	function MovementPrediction.PlaceBehind(Skill, enemy) 
		if Skill:Ready() and GetDistance(enemy) <= Skill.range then
			local TargetPosition = Vector(enemy.x, enemy.y, enemy.z)
			local MyPosition = Vector(myHero.x, myHero.y, myHero.z)		
			local WallPosition = TargetPosition + (TargetPosition - MyPosition)*((150/GetDistance(enemy)))
			CastSpell(Skill.spell, WallPosition.x, WallPosition.z)
		end
	end

	function MovementPrediction.PlaceInfront(Skill, enemy) 
		if Skill:Ready() and GetDistance(enemy) <= Skill.range then 
			local TargetPosition = Vector(enemy.x, enemy.y, enemy.z)
      		local MyPosition = Vector(myHero.x, myHero.y, myHero.z)
        	local SpellPosition = TargetPosition + (TargetPosition - MyPosition) * (-250 / GetDistance(enemy))
        	CastSpell(Skill.spell, SpellPosition.x, SpellPosition.z) 
		end 
	end 
-- }

class 'BuffManager' -- {
	
	BuffManager.instance = ""

	function BuffManager.Instance() 
		if BuffManager.instance == "" then BuffManager.instance = BuffManager() end return BuffManager.instance 
	end 

	function BuffManager:__init()
		self.enemies = {}
		AdvancedCallback:bind('OnGainBuff', function(unit, buff) self:OnGainBuff(unit, buff) end)
		AdvancedCallback:bind('OnLoseBuff', function(unit, buff) self:OnLoseBuff(unit, buff) end)
		AdvancedCallback:bind('OnUpdateBuff', function(unit, buff) self:OnUpdateBuff(unit, buff) end)
		for i=0, heroManager.iCount, 1 do
	        local player = heroManager:GetHero(i)
	        if player and player.team ~= myHero.team then
	        	self.enemies[player.networkID] = {}
	        end 
		end
	end 

	function BuffManager.TargetHaveBuff(target, buffName, stacks)
		return BuffManager.Instance():_TargetHaveBuff(target, buffName, stacks) 
	end 

	function BuffManager:_TargetHaveBuff(target, buffName, stacks)
		self.stacks = stacks or 0
		if self.enemies[target.networkID] ~= nil then
			for _, buff in pairs(self.enemies[target.networkID]) do 
				if buff.name == buffName and buff.stack >= self.stacks then
					return true
				end  
			end 
		end 
	end 

	function BuffManager:OnGainBuff(unit, buff) 
		if unit == nil or buff == nil then return end 
		if unit.team ~= myHero.team then 
			if self.enemies[unit.networkID] ~= nil then
				table.insert(self.enemies[unit.networkID], buff)
			else 
				self.enemies[unit.networkID] = {}
				table.insert(self.enemies[unit.networkID], buff)
			end 
		end 
	end 

	function BuffManager:OnLoseBuff(unit, buff) 
		if unit == nil or buff == nil then return end 
		if unit.team ~= myHero.team then 
			if self.enemies[unit.networkID] ~= nil then 
				for i=1, #self.enemies[unit.networkID], 1 do 
					if self.enemies[unit.networkID][i].name == buff.name then
						table.remove(self.enemies[unit.networkID], i)
						break 
					end 
				end 
			end 
		end 
	end 

	function BuffManager:OnUpdateBuff(unit, buff) 
		if unit == nil or buff == nil then return end 
		if unit.team ~= myHero.team then 
			if self.enemies[unit.networkID] ~= nil then 
				for i=1, #self.enemies[unit.networkID], 1 do 
					if self.enemies[unit.networkID][i] == buff then
						table.remove(self.enemies[unit.networkID], i)
						break 
					end 
				end 
				table.insert(self.enemies[unit.networkID], buff)
			end 
		end 
	end 
-- }

class '_ColorARGB' -- {

    function _ColorARGB:__init(red, green, blue, alpha)
        self.R = red or 255
        self.G = green or 255
        self.B = blue or 255
        self.A = alpha or 255
    end

    function _ColorARGB.FromArgb(red, green, blue, alpha)
        return Color(red,green,blue, alpha)
    end

    function _ColorARGB.FromTable(table) 
    	return ARGB(table[1], table[2], table[3], table[4])
    end 

    function _ColorARGB:ToARGB()
        return ARGB(self.A, self.R, self.G, self.B)
    end

    _ColorARGB.Red = _ColorARGB(255, 0, 0, 255)
    _ColorARGB.Yellow = _ColorARGB(255, 255, 0, 255)
    _ColorARGB.Green = _ColorARGB(0, 255, 0, 255)
    _ColorARGB.Aqua = _ColorARGB(0, 255, 255, 255)
    _ColorARGB.Blue = _ColorARGB(0, 0, 255, 255)
    _ColorARGB.Fuchsia = _ColorARGB(255, 0, 255, 255)
    _ColorARGB.Black = _ColorARGB(0, 0, 0, 255)
    _ColorARGB.White = _ColorARGB(255, 255, 255, 255)
-- }

class '_Message' -- {

    _Message.instance = ""

    function _Message:__init()
        self.notifys = {} 

        AddDrawCallback(function(obj) self:OnDraw() end)
    end

    function _Message.Instance()
        if _Message.instance == "" then _Message.instance = _Message() end return _Message.instance 
    end

    function _Message.AddMessage(text, color, target)
        return _Message.Instance():PAddMessage(text, color, target)
    end

    function _Message:PAddMessage(text, color, target)
        local x = 0
        local y = 200 
        local tempName = "Screen" 
        local tempcolor = color or _ColorARGB.Red

        if target then  
            tempName = target.networkID
        end

        self.notifys[tempName] = { text = text, color = tempcolor, duration = GetGameTimer() + 2, object = target}
    end

    function _Message:OnDraw()
        for i, notify in pairs(self.notifys) do
            if notify.duration < GetGameTimer() then notify = nil 
            else
                notify.color.A = math.floor((255/2)*(notify.duration - GetGameTimer()))

                if i == "Screen" then  
                    local x = 0
                    local y = 200
                    local gameSettings = GetGameSettings()
                    if gameSettings and gameSettings.General then 
                        if gameSettings.General.Width then x = gameSettings.General.Width/2 end 
                        if gameSettings.General.Height then y = gameSettings.General.Height/4 - 100 end
                    end  
                    --PrintChat(tostring(notify.color))
                    local p = GetTextArea(notify.text, 40).x 
                    self:DrawTextWithBorder(notify.text, 40, x - p/2, y, notify.color:ToARGB(), ARGB(notify.color.A, 0, 0, 0))
                else    
                    local pos = WorldToScreen(D3DXVECTOR3(notify.object.x, notify.object.y, notify.object.z))
                    local x = pos.x
                    local y = pos.y - 25
                    local p = GetTextArea(notify.text, 40).x 

                     self:DrawTextWithBorder(notify.text, 30, x- p/2, y, notify.color:ToARGB(), ARGB(notify.color.A, 0, 0, 0))
                end
            end
        end
    end 

    function _Message:DrawTextWithBorder(textToDraw, textSize, x, y, textColor, backgroundColor)
        DrawText(textToDraw, textSize, x + 1, y, backgroundColor)
        DrawText(textToDraw, textSize, x - 1, y, backgroundColor)
        DrawText(textToDraw, textSize, x, y - 1, backgroundColor)
        DrawText(textToDraw, textSize, x, y + 1, backgroundColor)
        DrawText(textToDraw, textSize, x , y, textColor)
    end
-- }

class '_Heroes' -- {

	NONE = 0
	ALLY = 1
	ENEMY = 2
	NEUTRAL = 4
	ALL = 7
    
    _Heroes.tables = {
        [ALLY] = {},
        [ENEMY] = {},
        [NEUTRAL] = {}
    }

    _Heroes.instance = ""

    function _Heroes:__init()
        self.modeCount = 3

        for i = 1, heroManager.iCount do
            local hero = heroManager:GetHero(i)
            self:AddObject(hero)
        end
    end

    function _Heroes.Instance()
        if _Heroes.instance == "" then _Heroes.instance = _Heroes() end return _Heroes.instance 
    end

    function _Heroes.GetObjects(mode, range, pFrom)
        return _Heroes.Instance():GetObjectsFromTable(mode, range, pFrom)
    end

    function _Heroes.GetAllObjects(mode)
        return _Heroes.Instance():GetAllObjectsFromTable(mode)
    end

    function _Heroes:AddObject(obj)
        DelayAction(function(obj)
                if obj.team == myHero.team then table.insert(_Heroes.tables[ALLY], obj) return end
                if obj.team == TEAM_ENEMY then table.insert(_Heroes.tables[ENEMY], obj) return end
                if obj.team == TEAM_NEUTRAL then table.insert(_Heroes.tables[NEUTRAL], obj) return end
            end, 0, {obj})
    end 

    function _Heroes.GetObjectByNetworkId(networkID)
         return _Heroes.Instance():PrivateGetObjectByNetworkId(networkID)
    end

    function _Heroes:PrivateGetObjectByNetworkId(networkID)
        for i, tableType in pairs(self.tables) do
            for k,v in pairs(tableType) do 
                if v.networkID == networkID then return v end 
            end 
        end
        return nil
    end 

    function _Heroes:GetAllObjectsFromTable(mode)
        if mode > self.modeCount then mode = self.modeCount end 

        tempTable = {}

        for i, tableType in pairs(self.tables) do
            if bit32.band(mode, i) == i then 
                for k,v in pairs(tableType) do 
                    if v ~= nil then 
                        table.insert(tempTable, v)
                    end
                end 
            end 
        end 
        return tempTable
    end 

    function _Heroes:GetObjectsFromTable(mode, range, pFrom)
        if mode > self.modeCount then mode = self.modeCount end 
        if range == nil or range < 0 then range = math.huge end
        if pFrom == nil then pFrom = myHero end
        tempTable = {}

        for i, tableType in pairs(self.tables) do
            if bit32.band(mode, i) == i then 
                for k,v in pairs(tableType) do 
                    if v ~= nil and v.valid and not v.dead and (v.team == myHero.team or v.bInvulnerable == 0) and v ~= myHero then 
                        if v.visible and v.bTargetable and GetDistance(v, pFrom) <= range then table.insert(tempTable, v) end
                    end
                end 
            end 
        end 
        return tempTable
    end
-- }

class 'iHealing' -- {
	
	iHealing.instance = ""

	function iHealing.Instance()
		if iHealing.instance == "" then iHealing.instance = iHealing() end return iHealing.instance
	end 

	function iHealing:__init()
		self.allies = {}
		for i=1, heroManager.iCount, 1 do 
			local player = heroManager:GetHero(i)
			if player and player.team == myHero.team then 
				table.insert(self.allies, player)
			end 
		end 
	end 

	function iHealing:Weigh(hero)
		local weight = 0 

		weight = weight + ((hero.maxHealth - hero.health) * 5) 
		weight = weight + (hero.totalDamage * 4)
		weight = weight - (GetDistance(hero) * 2) 

		for i=1, #SupportTable, 1 do 
			local sub = SupportTable[i]
			for _, h in pairs(sub) do 
				if hero.charName == h then 
					weight = weight * (10 - i)
					break
				end 
			end 
		end 

		return weight 
	end 

	function iHealing:Sorting(allies)
		table.sort(allies, function(a, b) 
				return self:Weigh(a) > self:Weigh(b)
			end)
		return allies
	end 

	function iHealing:GetTarget(range)
		local allies = {}
		for i, ally in pairs(self.allies) do 
			if ally and not ally.dead and GetDistance(ally) < range then 
				table.insert(allies, ally)
			end 
		end 
		self:Sorting(allies)
		for i, ally in pairs(allies) do 
			if ally and not ally.dead and GetDistance(ally) < range then 
				return ally 
			end 
		end 
	end 

-- }

class 'iTurret' -- {
	
	function iTurret:__init()
		self.turrets = {}

		for i=1, objManager.maxObjects do
			local obj = objManager:getObject(i) 
			if obj and obj.valid and obj.type == "obj_AI_Turret" then 
				table.insert(self.turrets, obj)
			end 
		end
	end 

	function iTurret:GetTurrets(flag, range)
		local result = {}
		for i, turret in pairs(self.turrets) do 
			if turret and not turret.dead and turret.team == flag and GetDistance(turret) < range then 
				table.insert(result, turret)
			end 
		end 
		return result 
	end 

	function iTurret:UnderTurret(target, flag) 
		local f = flag or TEAM_ENEMY
		for i, turret in pairs(self.turrets) do 
			if turret and not turret.dead and turret.team == f then 
				if GetDistance(target, turret) <= 775 then 
					return true 
				end 
			end 
		end 
		return false 
	end 

-- }

local AutoP = AutoPotion()


