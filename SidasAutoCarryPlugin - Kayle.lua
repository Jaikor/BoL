--[[
	AutoCarry Plugin - Kayle The Judicator, Judgement Day Has Come !!! 1.2 by Jaikor 
	With Code from Skeem, thanks Skeem for teaching me the obj for free users
	Credtis to HeX Original Plugin and Pain for his work ( this is a improved version by me )
	Credtis to fbragequit for the AA idea. thanks 
	Special thanks to Felina, Chrisokgo and gespierd and all the others who help testing the script for me. 
	Credtis to RoachxD helping out fixing bugs ;)
	Copyright 2013
	Changelog :
   1.0 - Initial Release
   1.1 - Bug fixes, ult fixed, reborn & revamp compatible
   1.2 - Bug Fixes, should work for free users, revamp and reborn, new ult logic it should only cast R on % hp if detects enemy in range
 ]] --

if myHero.charName ~= "Kayle" then return end
local rRange = 900

--[Function When Plugin Loads]--
function PluginOnLoad()
	mainLoad() -- Loads our Variable Function
	mainMenu() -- Loads our Menu function
end

--[OnTick]--
function PluginOnTick()
	if Recall then return end
	if IsSACReborn then
		AutoCarry.Crosshair:SetSkillCrosshairRange(1050)
	else
		AutoCarry.SkillsCrosshair.range = 1050
	end
	Checks()
	SmartKS()
	farmMinions:update()

	if Carry.AutoCarry then FullCombo() end
	if Carry.MixedMode and Target then 
		if Menu.qHarass and not IsMyManaLow() and GetDistance(Target) <= qRange then CastSpell(_Q, Target) end
	end
	if Carry.LaneClear or JungleClear() then
					for _, minion in pairs(AutoCarry.EnemyMinions().objects) do
					if ValidTarget(minion) and GetDistance(minion) <= eRange and Extras.useEclear and EREADY then
						CastSpell(_E)
					end
				end
		end
	
	local RREADY = myHero:CanUseSpell(_R) == READY
	if Menu.useR and RREADY then 
		for i, ally in ipairs(GetAllyHeroes()) do 
			if ally and not ally.dead and ally.visible and GetDistance(ally) <= rRange then 
				UltManagement(ally) 
			end
		end
		UltManagement(myHero)
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


if VIP_USER and IsSACReborn then
	function OnGainBuff(unit, buff)
		if unit.isMe and buff.name == eBuff then
			AutoCarry.MyHero.IsMelee = false
			EM.range = 625.5
			eFlag = true
		end
	end

	function OnLoseBuff(unit, buff)
		if unit.isMe and buff.name == eBuff then
			AutoCarry.MyHero.IsMelee = true
			EM.range = 255.5
			eFlag = false
		end 
	end
end

function BonusDamage()
	if eFlag then
		return (myHero:GetSpellData(_E).level * 10 + 10) + myHero.ap * 0.4
	end
	return 0
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
	if obj.name:find("RighteousFuryHalo_buff.troy") then
		if GetDistance(obj, myHero) <= 70 then
			eBuff = true
			eFlag = true
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
		if obj.name:find("RighteousFuryHalo_buff.troy") then
		if GetDistance(obj, myHero) <= 70 then
			eBuff = false
			eFlag = false
		end
	end
end

function OnAttacked()
	if Target and Carry.AutoCarry then
		if QREADY and Menu.useQ and GetDistance(Target) <= qRange then CastSpell(_Q, Target) end
	end
end

--[Low Mana Function by Kain]--
function IsMyManaLow()
    if myHero.mana < (myHero.maxMana * ( Extras.MinMana / 100)) then
        return true
    else
        return false
    end
end

--[/Low Mana Function by Kain]--

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
                if myHero.team ~= enemyhero.team and ValidTarget(enemyhero, QRange) then
                        if GetDistance(enemyhero, point) <= range then
                                ChampCount = ChampCount + 1
                        end
                end
        end            
        return ChampCount
end

function Healing()
	if myHero.mana >= myHero.maxMana*Menu.HealMana then
		for i=1, heroManager.iCount do
			local allytarget = heroManager:GetHero(i)
			if allytarget.team == myHero.team and not allytarget.dead then 
				if GetDistance(allytarget) <= 900 and (allytarget.health / allytarget.maxHealth) < Menu.HealHealth then
					if myHero:CanUseSpell(_W) == READY then 
						CastSpell(_W, allytarget)
					    end
					end
				end
			end
		end
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
				if enemy.health <= (qDmg) and GetDistance(enemy) <= qRange and QREADY then
					if QREADY then CastSpell(_Q, enemy) end
				
				elseif enemy.health <= (eDmg) and GetDistance(enemy) <= eRange and EREADY then
					if EREADY then CastSpell(_E, enemy) end
				
				elseif enemy.health <= (qDmg + eDmg) and GetDistance(enemy) <= eRange and EREADY and QREADY then
					if QREADY then CastSpell(_Q, enemy)
					if EREADY then CastSpell(_E, enemy)end
									
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
					if EREADY then CastSpell(_E, enemy) end
				
				elseif enemy.health <= (qDmg + eDmg + itemsDmg) and GetDistance(enemy) <= eRange
					and EREADY and QREADY then
						if DFGREADY then CastSpell(dfgSlot, enemy) end
						if HXGREADY then CastSpell(hxgSlot, enemy) end
						if BWCREADY then CastSpell(bwcSlot, enemy) end
						if BRKREADY then CastSpell(brkSlot, enemy) end
						if QREADY then CastSpell(_Q, enemy) end
						if EREADY then CastSpell(_E, enemy) end
						
				
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



function UltManagement(unit)
	if unit.health <= unit.maxHealth*(Menu.PercentofHealth/100) and CountEnemyHeroInRange(650, unit) > 0 then CastSpell(_R, unit) end
end


function OnProcessSpell(unit, spell)
	if Menu.useR and unit.team ~= myHero.team and spell.name == "zedult" then UltManagement(spell.target) end
end


--[Full Combo with Items]--
function FullCombo()
	if Target then
		if AutoCarry.MainMenu.AutoCarry then
			if GetDistance(Target) <= qRange then CastSpell(_Q, Target) end
			if GetDistance(Target) <= eRange then CastSpell(_E) end
		    if Menu.useW and WREADY and GetDistance(Target) > wBuffer then CastSpell(_W, myHero) end
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
		if Extras.JungleE and GetDistance(JungleMob) <= eRange then CastSpell(_E, JungleMob) end
	end
end


--[Variables Load]--
function mainLoad()
	if AutoCarry.Skills then IsSACReborn = true else IsSACReborn = false end
	if IsSACReborn then AutoCarry.Skills:DisableAll() end
	Carry = AutoCarry.MainMenu
	qRange,wRange,eRange,rRange = 650, 900, 525, 900
	QREADY, WREADY, EREADY, RREADY = false, false, false, false
	qName, wName, eName, rName = "Reckoning", "Devine Blessing", "Righteous Fury", "Intervention"
	HK1, HK2, HK3 = string.byte("Z"), string.byte("K"), string.byte("G")
	Menu = AutoCarry.PluginMenu
	UsingHPot, UsingMPot, UsingFlask = false, false, false
	Recall = false, false, false
	TextList = {"Harass him!!", "FULL COMBO KILL!"}
	KillText = {}
	waittxt = {} -- prevents UI lags, all credits to Dekaron
	for i=1, heroManager.iCount do waittxt[i] = i*3 end -- All credits to Dekaron
	farmMinions = minionManager(MINION_ENEMY, qRange+200, player)
	if VIP_USER and IsSACReborn then
		EM = AutoCarry.EnemyMinions()
		AdvancedCallback:bind('OnGainBuff', function(unit, buff) OnGainBuff(unit, buff) end)
		AdvancedCallback:bind('OnLoseBuff', function(unit, buff) OnLoseBuff(unit, buff) end)
		eBuff = "JudicatorRighteousFury"
	end
	wBuffer = 400 --Wont use W unless they are this far away. 400 by default.
	GetEnemyHeroes()
    GetAllyHeroes()
end 


--[Main Menu & Extras Menu]--
function mainMenu()
	Menu:addParam("sep1", "-- Full Combo Options --", SCRIPT_PARAM_INFO, "")
	Menu:addParam("useQ", "Use "..qName.." (Q)", SCRIPT_PARAM_ONOFF, true)
	Menu:addParam("useW", "Use "..wName.." (W)", SCRIPT_PARAM_ONOFF, true)
	Menu:addParam("useE", "Use "..eName.." (E)", SCRIPT_PARAM_ONOFF, true)
	Menu:addParam("HealAll", "Heals Allies if below X Health", SCRIPT_PARAM_ONKEYTOGGLE, true, string.byte("K"))
	Menu:addParam("HealHealth", "X Amount of Health to heal", SCRIPT_PARAM_SLICE, 0.6, 0.1, 0.9, 1)
	Menu:addParam("HealMana", "X Amount of Mana to heal", SCRIPT_PARAM_SLICE, 0.4, 0.1, 1, 1)	
	Menu:addParam("sep2", "-- Mixed Mode Options --", SCRIPT_PARAM_INFO, "")
	Menu:addParam("qHarass", "Use "..qName.." (Q)", SCRIPT_PARAM_ONOFF, true)
	Menu:addParam("sep3", "-- Draw Options --", SCRIPT_PARAM_INFO, "")
	Menu:addParam("qDraw", "Draw "..qName.." (Q)", SCRIPT_PARAM_ONOFF, true)
	Menu:addParam("cDraw", "Draw Enemy Text", SCRIPT_PARAM_ONOFF, true)
	Menu:addParam("sep4", "-- ULT Options --", SCRIPT_PARAM_INFO, "")
	Menu:addParam("useR", "Auto Ult "..rName.." (R)", SCRIPT_PARAM_ONOFF, true)
	Menu:addParam("PercentofHealth", "PercentofHealth",SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
	Extras = scriptConfig("Sida's Auto Carry Plugin: "..myHero.charName..": Extras", myHero.charName)
	Extras:addParam("sep5", "-- Misc --", SCRIPT_PARAM_INFO, "")
	Extras:addParam("qFarm", "Last Hit with "..qName.." (Q)", SCRIPT_PARAM_ONOFF, true)	
	Extras:addParam("JungleE", "Jungle with "..eName.." (E)", SCRIPT_PARAM_ONOFF, true)
	Extras:addParam("useEclear", "Lane Clear with E "..eName.." (E)", SCRIPT_PARAM_ONOFF, true)
	Extras:addParam("MinMana", "Minimum Mana for Jungle/Harass %", SCRIPT_PARAM_SLICE, 50, 0, 100, -1)
	Extras:addParam("ZWItems", "Auto Zhonyas/Wooglets", SCRIPT_PARAM_ONOFF, true)
	Extras:addParam("ZWHealth", "Min Health % for Zhonyas/Wooglets", SCRIPT_PARAM_SLICE, 15, 0, 100, -1)
	Extras:addParam("aHP", "Auto Health Pots", SCRIPT_PARAM_ONOFF, true)
	Extras:addParam("aMP", "Auto Auto Mana Pots", SCRIPT_PARAM_ONOFF, true)
	Extras:addParam("HPHealth", "Min % for Health Pots", SCRIPT_PARAM_SLICE, 50, 0, 100, -1)
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
