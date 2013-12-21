--[[
	AutoCarry Plugin - Shen Eye of Twilight 2.0 by Jaikor 
	With Code from Skeem
	Credtis to HeX helping me allot with the Ulti of shen
	Auto Level from Dekaron.
	Credits BotHappy helping me with PROdiction
	Credits pqmailer ult breaker mode
	Thanks to Roachxd for the tip on the E prediction for free users

	Copyright 2013
	Changelog :
   1.0 - Initial Release
 ]] --

 if myHero.charName ~= "Shen" then return end
require 'Prodiction'
local rRange = 18500

--[Function When Plugin Loads]--
function PluginOnLoad()
	mainLoad() -- Loads our Variable Function
	mainMenu() -- Loads our Menu function
   if IsSACReborn and VIP_USER then
   SkillE = AutoCarry.Skills:NewSkill(false, _E, 600, "Shadow Dash", AutoCarry.SPELL_LINEAR, 0, false, false, 0.3, 800, 50, true)
else
 	SkillE = {spellKey = _E, range = 600, speed = 800, delay = 0.3}
end
end

--[OnTick]--
function PluginOnTick()
	if Recall then return end
	if IsSACReborn then
		AutoCarry.Crosshair:SetSkillCrosshairRange(25000)
	else
		AutoCarry.SkillsCrosshair.range = 25000
	end
	Checks()
	SmartKS()
	farmMinions:update()
	
	if Carry.AutoCarry then FullCombo() end
	if Carry.MixedMode and Target then 
		if Menu.qHarass and not IsMyManaLow() and GetDistance(Target) <= qRange then CastSpell(_Q, Target) end
	end
	if Carry.LaneClear then JungleClear() end
	
	local RREADY = myHero:CanUseSpell(_R) == READY
	if Menu.useR and RREADY then 
		for i, ally in ipairs(GetAllyHeroes()) do 
			if ally and not ally.dead and ally.visible and GetDistance(ally) <= rRange then 
				UltManagement(ally) 
			end
		end
	end
	
	if Extras.ZWItems and IsMyHealthLow() and Target and (ZNAREADY or WGTREADY) then CastSpell((wgtSlot or znaSlot)) end
	if Extras.aHP and NeedHP() and not (UsingHPot or UsingFlask) and (HPREADY or FSKREADY) then CastSpell((hpSlot or fskSlot)) end
	if Extras.aMP and IsMyManaLow() and not (UsingMPot or UsingFlask) and(MPREADY or FSKREADY) then CastSpell((mpSlot or fskSlot)) end
	if Extras.AutoLevelSkills then autoLevelSetSequence(levelSequence) end
	if Extras.qFarm and Carry.LastHit then
	  for _, minion in pairs(farmMinions.objects) do
			if minion and ValidTarget(minion) and QREADY and GetDistance(minion) <= qRange then
				if minion.health < qDmg then CastSpell(_Q, minion) end
            end 
		end
	end
end

--[Drawing our Range/Killable Enemies]--
function PluginOnDraw()
	if not myHero.dead then
		if QREADY and Menu.qDraw then 
			DrawCircle(myHero.x, myHero.y, myHero.z, qRange, 0x191970)
		end
	end
end


--[Object Detection]--
function PluginOnCreateObj(obj)
	if obj.name:find("TeleportHome.troy") then
		if GetDistance(obj, myHero) <= 70 then
			Recall = true
		end
	end
	if obj.name:find("Regenerationpotion_itm.troy") then
		if GetDistance(obj, myHero) <= 70 then
			UsingHPot = true
		end
	end
	if obj.name:find("Global_Item_HealthPotion.troy") then
		if GetDistance(obj, myHero) <= 70 then
			UsingHPot = true
			UsingFlask = true
		end
	end
	if obj.name:find("Global_Item_ManaPotion.troy") then
		if GetDistance(obj, myHero) <= 70 then
			UsingFlask = true
			UsingMPot = true
		end
	end
end

function PluginOnDeleteObj(obj)
	if obj.name:find("TeleportHome.troy") then
		Recall = false
	end
	if obj.name:find("Regenerationpotion_itm.troy") then
		UsingHPot = false
	end
	if obj.name:find("Global_Item_HealthPotion.troy") then
		UsingHPot = false
		UsingFlask = false
	end
	if obj.name:find("Global_Item_ManaPotion.troy") then
		UsingMPot = false
		UsingFlask = false
	end
end

function OnAttacked()
	if Target and Carry.AutoCarry then
		if QREADY and Menu.useQ and GetDistance(Target) <= qRange then CastSpell(_Q, Target) end
	end
end


--[Low Health Function Trololz]--
function IsMyHealthLow()
	if myHero.health < (myHero.maxHealth * ( Extras.ZWHealth / 100)) then
		return true
	else
		return false
	end
end
--[/Low Health Function Trololz]--

--[Health Pots Function]--
function NeedHP()
	if myHero.health < (myHero.maxHealth * ( Extras.HPHealth / 100)) then
		return true
	else
		return false
	end
end



function CountEnemies(point, range)
        local ChampCount = 0
        for j = 1, heroManager.iCount, 1 do
                local enemyhero = heroManager:getHero(j)
                if myHero.team ~= enemyhero.team and ValidTarget(enemyhero, qRange) then
                        if GetDistance(enemyhero, point) <= range then
                                ChampCount = ChampCount + 1
                        end
                end
        end            
        return ChampCount
end



--[Smart KS Function]--
function SmartKS()
	for i=1, heroManager.iCount do
	 local enemy = heroManager:GetHero(i)
	    if ValidTarget(enemy) then
			dfgDmg, hxgDmg, bwcDmg, iDmg  = 0, 0, 0, 0
			qDmg = getDmg("Q",enemy,myHero)
            eDmg = getDmg("E",enemy,myHero)
			wDmg = getDmg("W",enemy,myHero)
			if DFGREADY then dfgDmg = (dfgSlot and getDmg("DFG",enemy,myHero) or 0)	end
            if HXGREADY then hxgDmg = (hxgSlot and getDmg("HXG",enemy,myHero) or 0) end
            if BWCREADY then bwcDmg = (bwcSlot and getDmg("BWC",enemy,myHero) or 0) end
            if IREADY then iDmg = (ignite and getDmg("IGNITE",enemy,myHero) or 0) end
            onspellDmg = (liandrysSlot and getDmg("LIANDRYS",enemy,myHero) or 0)+(blackfireSlot and getDmg("BLACKFIRE",enemy,myHero) or 0)
            itemsDmg = dfgDmg + hxgDmg + bwcDmg + iDmg + onspellDmg
			if Menu.sKS then
				if enemy.health <= (eDmg) and GetDistance(enemy) <= eRange and EREADY then
					if EREADY then CastE(enemy) end
				
				elseif enemy.health <= (qDmg) and GetDistance(enemy) <= qRange and QREADY then
					if QREADY then CastSpell(_Q, enemy) end
				
				elseif enemy.health <= (qDmg + eDmg) and GetDistance(enemy) <= eRange and EREADY and QREADY then
					if QREADY then CastSpell(_Q, enemy)
					if EREADY then CastE(enemy) end
									
				elseif enemy.health <= (qDmg + itemsDmg) and GetDistance(enemy) <= qRange and QREADY then
					if DFGREADY then CastSpell(dfgSlot, enemy) end
					if HXGREADY then CastSpell(hxgSlot, enemy) end
					if BWCREADY then CastSpell(bwcSlot, enemy) end
					if BRKREADY then CastSpell(brkSlot, enemy) end
					if QREADY then CastSpell(_Q, enemy) end
				
				elseif enemy.health <= (eDmg + itemsDmg) and GetDistance(enemy) <= eRange and EREADY then
					if DFGREADY then CastSpell(dfgSlot, enemy) end
					if HXGREADY then CastSpell(hxgSlot, enemy) end
					if BWCREADY then CastSpell(bwcSlot, enemy) end
					if BRKREADY then CastSpell(brkSlot, enemy) end
					if EREADY then CastE(enemy) end
				
				elseif enemy.health <= (qDmg + eDmg + itemsDmg) and GetDistance(enemy) <= eRange
					and EREADY and QREADY then
						if DFGREADY then CastSpell(dfgSlot, enemy) end
						if HXGREADY then CastSpell(hxgSlot, enemy) end
						if BWCREADY then CastSpell(bwcSlot, enemy) end
						if BRKREADY then CastSpell(brkSlot, enemy) end
						if EREADY then CastE(enemy) end
						if QREADY then CastSpell(_Q, Target) end
						
				
				end
								
				if enemy.health <= iDmg and GetDistance(enemy) <= 600 then
					if IREADY then CastSpell(ignite, enemy) end
				end
			end
			KillText[i] = 1 
			if enemy.health <= (qDmg + eDmg + itemsDmg) and QREADY and EREADY then
			KillText[i] = 2
			end
		end
	end
end
end

function CountEnemies(point, range)
        local ChampCount = 0
        for i = 1, heroManager.iCount, 1 do
                local enemyhero = heroManager:getHero(i)
                if myHero.team ~= enemyhero.team then
                        if GetDistance(enemyhero, point) <= range then
                                ChampCount = ChampCount + 1
                        end
                end
        end            
end


function OnAttacked()
   if Target ~= nil and AutoCarry.AutoCarry then CastSpell(_W) end
end

function UltManagement(unit)
	if unit.health <= unit.maxHealth*(Menu.PercentofHealth/100) then CastSpell(_R, unit) end
end


--[Casting our E into Enemies]--
function CastE(Target)
 if IsSACReborn and VIP_USER then
  if EREADY then
   SkillE:Cast(Target)
  end
 end
    if EREADY then 
  AutoCarry.CastSkillshot(SkillE, Target)
    end
end

--[Full Combo with Items]--
function FullCombo()
 if Target then
  if AutoCarry.MainMenu.AutoCarry then
   if QREADY and GetDistance(Target) <= qRange then 
    CastSpell(_Q, Target)
   elseif EREADY and GetDistance(Target) <= eRange then
    CastE(Target) 
   end
  end
 end
end

function JungleClear()
	if IsSACReborn then
		JungleMob = AutoCarry.Jungle:GetAttackableMonster()
	else
		JungleMob = AutoCarry.GetMinionTarget()
	end
	if JungleMob ~= nil and not IsMyManaLow() then
		if Extras.JungleQ and GetDistance(JungleMob) <= qRange then CastSpell(_Q, JungleMob) end
	end
end


--[Variables Load]--
function mainLoad()
	if AutoCarry.Skills then IsSACReborn = true else IsSACReborn = false end
	if IsSACReborn then AutoCarry.Skills:DisableAll() end
	Carry = AutoCarry.MainMenu
	qRange,wRange,eRange,rRange = 475, 600, 600, 18500
	QREADY, WREADY, EREADY, RREADY = false, false, false, false
	qName, wName, eName, rName = "Vorpal Blade", "Feint", "Shadow Dash", "Stand United"
	HK1, HK2, HK3 = string.byte("Z"), string.byte("K"), string.byte("G")
	Menu = AutoCarry.PluginMenu
	UsingHPot, UsingMPot, UsingFlask = false, false, false
	Recall = false, false, false
	TextList = {"Harass him!!", "FULL COMBO KILL!"}
	KillText = {}
	waittxt = {} -- prevents UI lags, all credits to Dekaron
	for i=1, heroManager.iCount do waittxt[i] = i*3 end -- All credits to Dekaron
	levelSequence = {nil, 2, 3, 1, 1, 4, 1, 1, 2, 2, 4, 2, 2, 3, 3, 4, 3, 3}
	SkillE = {spellKey = _E, range = rRange, speed = eSpeed, delay = eDelay, width = eWidth, configName = eName, displayName = "E "..eName.."", enabled = true, skillShot = true, minions = false, reset = false, reqTarget = false }
	farmMinions = minionManager(MINION_ENEMY, qRange+200, player)
	enemyHeroes = GetEnemyHeroes()
	GetEnemyHeroes()
    GetAllyHeroes()
	ToInterrupt = {}
	InterruptList = {
    { charName = "Caitlyn", spellName = "CaitlynAceintheHole"},
    { charName = "FiddleSticks", spellName = "Crowstorm"},
    { charName = "FiddleSticks", spellName = "DrainChannel"},
    { charName = "Galio", spellName = "GalioIdolOfDurand"},
    { charName = "Karthus", spellName = "FallenOne"},
    { charName = "Katarina", spellName = "KatarinaR"},
    { charName = "Malzahar", spellName = "AlZaharNetherGrasp"},
    { charName = "MissFortune", spellName = "MissFortuneBulletTime"},
    { charName = "Nunu", spellName = "AbsoluteZero"},
    { charName = "Pantheon", spellName = "Pantheon_GrandSkyfall_Jump"},
    { charName = "Shen", spellName = "ShenStandUnited"},
    { charName = "Urgot", spellName = "UrgotSwap2"},
    { charName = "Varus", spellName = "VarusQ"},
    { charName = "Warwick", spellName = "InfiniteDuress"}
}

	for _, enemy in pairs(enemyHeroes) do
		for _, champ in pairs(InterruptList) do
			if enemy.charName == champ.charName then
				table.insert(ToInterrupt, champ.spellName)
			end
		end
	end
end

function OnProcessSpell(unit, spell)
	if #ToInterrupt > 0 and Extras.interrupt and EREADY then
		for _, ability in pairs(ToInterrupt) do
			if spell.name == ability and unit.team ~= myHero.team then
				if eRange >= GetDistance(unit) then
					CastE(unit)
					if Config.printInterrupt then print("Tried to interrupt " .. spell.name) end
				end
			end
		end
	end
end

--[Main Menu & Extras Menu]--
function mainMenu()
	Menu:addParam("sep1", "-- Full Combo Options --", SCRIPT_PARAM_INFO, "")
	Menu:addParam("useQ", "Use "..qName.." (Q)", SCRIPT_PARAM_ONOFF, true)
	Menu:addParam("useW", "Use "..wName.." (W)", SCRIPT_PARAM_ONOFF, true)
	Menu:addParam("useE", "Use "..eName.." (E)", SCRIPT_PARAM_ONOFF, true)
	Menu:addParam("sep2", "-- Mixed Mode Options --", SCRIPT_PARAM_INFO, "")
	Menu:addParam("qHarass", "Use "..qName.." (Q)", SCRIPT_PARAM_ONOFF, true)
	Menu:addParam("sep3", "-- Draw Options --", SCRIPT_PARAM_INFO, "")
	Menu:addParam("qDraw", "Draw "..qName.." (Q)", SCRIPT_PARAM_ONOFF, true)
	Menu:addParam("cDraw", "Draw Enemy Text", SCRIPT_PARAM_ONOFF, true)
	Menu:addParam("sep4", "-- Ulti Options --", SCRIPT_PARAM_INFO, "")
	Menu:addParam("useR", "Use "..rName.." (R)", SCRIPT_PARAM_ONOFF, true)
	Menu:addParam("PercentofHealth", "Minimum Health %", SCRIPT_PARAM_SLICE, 50, 0, 100, -1)
	Extras = scriptConfig("Sida's Auto Carry Plugin: "..myHero.charName..": Extras", myHero.charName)
	Extras:addParam("sep5", "-- Misc --", SCRIPT_PARAM_INFO, "")
	Extras:addParam("qFarm", "Use Q LastHit "..qName.." (Q)", SCRIPT_PARAM_ONOFF, true)	
	Extras:addParam("JungleQ", "Jungle with "..qName.." (Q)", SCRIPT_PARAM_ONOFF, true)
	Extras:addParam("ZWItems", "Auto Zhonyas/Wooglets", SCRIPT_PARAM_ONOFF, true)
	Extras:addParam("ZWHealth", "Min Health % for Zhonyas/Wooglets", SCRIPT_PARAM_SLICE, 15, 0, 100, -1)
	Extras:addParam("aHP", "Auto Health Pots", SCRIPT_PARAM_ONOFF, true)
	Extras:addParam("HPHealth", "Min % for Health Pots", SCRIPT_PARAM_SLICE, 50, 0, 100, -1)
	Extras:addParam("AutoLevelSkills", "Auto Level Skills (Requires Reload)", SCRIPT_PARAM_ONOFF, true)
	Extras:addParam("sep6", "-- Ult Breaker --", SCRIPT_PARAM_INFO, "")
	Extras:addParam("interrupt", "Interrupt with E", SCRIPT_PARAM_ONOFF, true)
end

--[Certain Checks]--
function Checks()
	if myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot") then ignite = SUMMONER_1
	elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot") then ignite = SUMMONER_2 end
	if IsSACReborn then Target = AutoCarry.Crosshair:GetTarget() else Target = AutoCarry.GetAttackTarget() end
	dfgSlot, hxgSlot, bwcSlot = GetInventorySlotItem(3128), GetInventorySlotItem(3146), GetInventorySlotItem(3144)
	brkSlot = GetInventorySlotItem(3092),GetInventorySlotItem(3143),GetInventorySlotItem(3153)
	znaSlot, wgtSlot = GetInventorySlotItem(3157),GetInventorySlotItem(3090)
	hpSlot, mpSlot, fskSlot = GetInventorySlotItem(2003),GetInventorySlotItem(2004),GetInventorySlotItem(2041)
	QREADY = (myHero:CanUseSpell(_Q) == READY)
	WREADY = (myHero:CanUseSpell(_W) == READY)
	EREADY = (myHero:CanUseSpell(_E) == READY)
	RREADY = (myHero:CanUseSpell(_R) == READY)
	DFGREADY = (dfgSlot ~= nil and myHero:CanUseSpell(dfgSlot) == READY)
	HXGREADY = (hxgSlot ~= nil and myHero:CanUseSpell(hxgSlot) == READY)
	BWCREADY = (bwcSlot ~= nil and myHero:CanUseSpell(bwcSlot) == READY)
	BRKREADY = (brkSlot ~= nil and myHero:CanUseSpell(brkSlot) == READY)
	ZNAREADY = (znaSlot ~= nil and myHero:CanUseSpell(znaSlot) == READY)
	WGTREADY = (wgtSlot ~= nil and myHero:CanUseSpell(wgtSlot) == READY)
	IREADY = (ignite ~= nil and myHero:CanUseSpell(ignite) == READY)
	HPREADY = (hpSlot ~= nil and myHero:CanUseSpell(hpSlot) == READY)
	MPREADY =(mpSlot ~= nil and myHero:CanUseSpell(mpSlot) == READY)
	FSKREADY = (fskSlot ~= nil and myHero:CanUseSpell(fskSlot) == READY)
end
