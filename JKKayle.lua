require "VPrediction"
require "SOW"
if myHero.charName ~= "Kayle" then return end
--scriptstatus.net
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("VILJNIINJLO") 

local version = 2.2
local autoUpdate   = true
local scriptName = "JKKayle"
local sourceLibFound = true
local VP = VPrediction()	
if FileExist(LIB_PATH .. "SourceLib.lua") then
    require "SourceLib"
else
    sourceLibFound = false
    DownloadFile("https://raw.github.com/TheRealSource/public/master/common/SourceLib.lua", LIB_PATH .. "SourceLib.lua", function() print("<font color=\"#6699ff\"><b>" .. scriptName .. ":</b></font> <font color=\"#FFFFFF\">SourceLib downloaded! Please reload!</font>") end)
end
if not sourceLibFound then return end

-- Updater
if autoUpdate then
    SourceUpdater(scriptName, version, "raw.github.com", "/Jaikor/BoL/master/JKKayle.lua", SCRIPT_PATH .. GetCurrentEnv().FILE_NAME, "/Jaikor/BoL/master/Versions/JKkayle.version"):SetSilent(silentUpdate):CheckUpdate()
end

function OnLoad()
	VP = VPrediction()
	qRng, wRng, eRng, rRng = 650, 900, 525, 900
	wBuffer = 400
	EnemyMinions = minionManager(MINION_ENEMY, eRng, myHero, MINION_SORT_MAXHEALTH_DEC)
	JungleMinions = minionManager(MINION_JUNGLE, eRng, myHero, MINION_SORT_MAXHEALTH_DEC)
	Q = Spell(_Q, qRng)
	W = Spell(_W, wRng)
	E = Spell(_E, eRng)
	R = Spell(_R, rRng)
    DLib = DamageLib()
	--DamageLib:RegisterDamageSource(spellId, damagetype, basedamage, perlevel, scalingtype, scalingstat, percentscaling, condition, extra)
	DLib:RegisterDamageSource(_Q, _MAGIC, 60, 50, _MAGIC, _AP, 0.60, function() return (player:CanUseSpell(_Q) == READY)end)
	DLib:RegisterDamageSource(_E, _MAGIC, 20, 10, _MAGIC, _AP, 0.40, function() return (player:CanUseSpell(_E) == READY)end)
	DFG = Item(3128,750)
	Menu = scriptConfig("JKKayle","JKKayle")
	-- Key Binds
	Menu:addSubMenu("Key Bindings","bind")
	Menu.bind:addParam("active", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, 32)
	Menu.bind:addParam("harass", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
	Menu.bind:addParam("auto", "Auto Spell", SCRIPT_PARAM_ONKEYTOGGLE, true, string.byte("N"))
	-- Farming Options
	Menu:addSubMenu("Farming","farm")
	Menu.farm:addParam("JungleFarm", "JungleFarm", SCRIPT_PARAM_ONKEYDOWN, false,string.byte("G"))
	Menu.farm:addParam("LaneClear", "LaneClear", SCRIPT_PARAM_ONKEYDOWN, false,string.byte("V"))
	
	-- Options
	Menu:addSubMenu("Configurations","options")
	Menu.options:addParam("useW", "Use W", SCRIPT_PARAM_ONOFF, true)
	Menu.options:addParam("HealHealth", "X Amount of Health to heal", SCRIPT_PARAM_SLICE, 0.6, 0.1, 0.9, 1)
	Menu.options:addParam("HealMana", "X Amount of Mana to heal", SCRIPT_PARAM_SLICE, 0.4, 0.1, 1, 1)
	Menu.options:addParam("useUlt", "Use Ult", SCRIPT_PARAM_ONOFF, true)
	Menu.options:addParam("PercentofHealth", "PercentofHealth",SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
	-- Draw
	Menu:addSubMenu("Draw","Draw")
	Menu.Draw:addParam("drawq", "Draw Q", SCRIPT_PARAM_ONOFF, true)
	Menu.Draw:addParam("draww", "Draw W", SCRIPT_PARAM_ONOFF, true)
	Menu.Draw:addParam("drawe", "Draw E", SCRIPT_PARAM_ONOFF, true)
	Menu.Draw:addParam("drawr", "Draw R", SCRIPT_PARAM_ONOFF, true)
	Menu.Draw:addParam("drawtext", "Draw Text", SCRIPT_PARAM_ONOFF, true)
	Orbwalker = SOW(VP)
	Menu:addSubMenu("Orbwalker", "SOWorb")
	Orbwalker:LoadToMenu(Menu.SOWorb)
	Combo = {_Q, _E,}
	DLib:AddToMenu(Menu.Draw,Combo)
	ts = TargetSelector(TARGET_LESS_CAST,eRng,DAMAGE_MAGIC,false)
	ts.name = "Kayle"
	Menu:addTS(ts)
	PrintChat("<font color='#690759'> >> JKKayle Loaded!</font>")
end

function OnTick()
	ts:update()
	if Menu.bind.active then 
		fullCombo()
	end
	if Menu.bind.harass then
		harass()
	end
	if Menu.bind.auto then
		Auto()
	end
	if Menu.farm.JungleFarm then
	    JungleFarm()
	end
	if Menu.farm.LaneClear then
	    farm()
	end
end

function Auto()
	if ts.target then
		if Q:IsReady() and Q:IsInRange(ts.target,myHero) then
			CastSpell(_Q,ts.target)
		end
		if E:IsReady() and E:IsInRange(ts.target, myHero) then
            CastSpell(_E)
			myHero:Attack(ts.target)
	end
end
end

function JungleFarm()
				JungleMinions:update()
					JungleCreep = JungleMinions.objects[1]
					if ValidTarget(JungleCreep) then
						if E:IsReady() and E:IsInRange(JungleCreep, myHero) then 
							CastSpell(_E,JungleCreep)
						elseif Q:IsReady() and Q:IsInRange(JungleCreep, myHero) then
							CastSpell(_Q,JungleCreep)
						end
					end
				end
				
				
					

					
function harass()
	if ts.target then
		if Q:IsReady() and Q:IsInRange(ts.target,myHero) then
			CastSpell(_Q,ts.target)
		end
		end
end

function fullCombo()
	if ts.target then
		-- Casting DFG
		if DFG:IsReady() and DFG:InRange(ts.target) then
			DFG:Cast(ts.target)
		end	
		-- Casting Q
		if Q:IsReady() and Q:IsInRange(ts.target,myHero) then
			CastSpell(_Q,ts.target)
		end
		-- Casting W
		                if W:IsReady() and W:IsInRange(ts.target,myHero) then
						if (myHero.health / myHero.maxHealth) < Menu.options.HealHealth then
							CastSpell(_W)
						end
                end
				if W:IsReady() and Menu.options.useW and GetDistance(ts.target)  > wBuffer then
					CastSpell(_W,myHero)
				end
				-- Casting E
		if E:IsReady() and E:IsInRange(ts.target, myHero) then
				if GetDistance(ts.target) < 525 then
             CastSpell(_E)
			 myHero:Attack(ts.target)
		end
		end
		-- Casting R
			if R:IsReady() and R:IsInRange(ts.target,myHero) and Menu.options.useUlt  then 
		for i, ally in ipairs(GetAllyHeroes()) do 
			if ally and not ally.dead and ally.visible and GetDistance(ally) <= rRng then 
				UltManagement(ally) 
			end
		end
		UltManagement(myHero)
	end
	end
end

function UltManagement(unit)
	if unit.health <= unit.maxHealth*(Menu.options.PercentofHealth/100) and CountEnemyHeroInRange(650, unit) > 0 then CastSpell(_R, unit) end
end

function Healing()
	if myHero.mana >= myHero.maxMana*Menu.options.HealMana then
		for i=1, heroManager.iCount do
			local allytarget = heroManager:GetHero(i)
			if allytarget.team == myHero.team and not allytarget.dead then 
				if GetDistance(allytarget) <= 900 and (allytarget.health / allytarget.maxHealth) < Menu.options.HealHealth then
					if W:IsReady() and W:IsInRange() then 
						CastSpell(_W, allytarget)
							end
					end
				end
			end
		end
	end
		


function Damage(target)
  if target then
    local qDmg = getDmg("Q", target, myHero)
    local eDmg = getDmg("E", target, myHero)
    local dfgDmg = (GetInventorySlotItem(3128) ~= nil and getDmg("DFG", target, myHero)) or 0
    local damageAmp = (GetInventorySlotItem(3128) ~= nil and 1.2) or 1
		local currentDamage = 0
    
    if Q:IsReady() then
     currentDamage = currentDamage + qDmg
    end
   
    if W:IsReady() then
     currentDamage = currentDamage + wDmg
    end
  
	if R:IsReady() then
		currentDamage = currentDamage + rDmg
	end
	 
    if DFG:IsReady() then
     currentDamage = (currentDamage * damageAmp) + dfgDmg
    end
		return currentDamage
  end
	
end

local eWidth = 150

function countminionshitE(pos, width)
	local n = 0
	for i, minion in ipairs(EnemyMinions.objects) do
		if GetDistance(minion, pos) < width and minion.health <= getDmg("E", minion, myHero) then
			n = n +1
		end
	end
	return n
end

function GetBestEPositionFarm()
	local MaxE = 0 
	local MaxEPos 
	for i, minion in pairs(EnemyMinions.objects) do
		local hitE = countminionshitE(minion, eWidth)
		if hitE > MaxE or MaxEPos == nil then
			MaxEPos = minion
			MaxE = hitE
		end
	end

	if MaxEPos and MaxE then return MaxEPos, maxE end
end

function farm()
	local minion, count = GetBestEPositionFarm()
	if minion and count > 0 then 
		CastSpell(_E)
		myHero:Attack(minion)
	end
end

function OnDraw()
	if Menu.Draw.drawq then
		DrawCircle(myHero.x,myHero.y,myHero.z,qRng,0xFFFF0000)
	end 
	if Menu.Draw.draww then
		DrawCircle(myHero.x,myHero.y,myHero.z,wRng,0xFFFF0000)
	end
	if Menu.Draw.drawe then
		DrawCircle(myHero.x,myHero.y,myHero.z,eRng,0xFFFF0000)
	end
	if Menu.Draw.drawr then
		DrawCircle(myHero.x,myHero.y,myHero.z,rRng,0xFFFF0000)
	end
	if Menu.drawtext then
		for i, target in ipairs(GetEnemyHeroes()) do
			if ValidTarget(target) and target.team ~= myHero.team and target.dead ~= true then
				if Damage(target) > target.health then
					PrintFloatText(target,0,"Killable")
				end
			end
		end
	end
end

UM = {
                { charName = "Katarina",        spellName = "KatarinaR" ,                  important = 0},
				{ charName = "Zed",             spellName = "zedult" ,                     important = 0},
                { charName = "Galio",           spellName = "GalioIdolOfDurand" ,          important = 0},
                { charName = "FiddleSticks",    spellName = "Crowstorm" ,                  important = 1},
                { charName = "FiddleSticks",    spellName = "DrainChannel" ,               important = 1},
                { charName = "Nunu",            spellName = "AbsoluteZero" ,               important = 0},
                { charName = "Shen",            spellName = "ShenStandUnited" ,            important = 0},
                { charName = "Urgot",           spellName = "UrgotSwap2" ,                 important = 0},
                { charName = "Malzahar",        spellName = "AlZaharNetherGrasp" ,         important = 0},
                { charName = "Karthus",         spellName = "FallenOne" ,                  important = 0},
                { charName = "Pantheon",        spellName = "Pantheon_GrandSkyfall_Jump" , important = 0},
                { charName = "Varus",           spellName = "VarusQ" ,                     important = 1},
                { charName = "Caitlyn",         spellName = "CaitlynAceintheHole" ,        important = 1},
                { charName = "MissFortune",     spellName = "MissFortuneBulletTime" ,      important = 1},
                { charName = "Warwick",         spellName = "InfiniteDuress" ,             important = 0}
}


function OnProcessSpell(unit, spell)	
	if Menu.options.useUlt then
		if unit.type == 'obj_AI_Hero' and unit.team == TEAM_ENEMY and GetDistance(unit) < rRng then
		   	local spellName = spell.name
			for i = 1, #UM do
				if unit.charName == UM[i].charName and spellName == UM[i].spellName then
					if UM[i].important == 0 then
						if Menu.options.useUlt and R:IsReady() and rRng then
							CastSpell(_R, unit)
						end
					end
				end
			end
		end
	end	
end
