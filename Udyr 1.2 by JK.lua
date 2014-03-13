--[[
PQUdyr this is the PQUdyr version with orbwalk from MMA and SAC....
I just added the jungle clear for Q and R try it out 
tho with MMA or SAC it has a clear mode U can try that too and let me know on forum
Credits to BURN original combo and PQMailer for adding the MMA and SAC orbwalk 
]]--


if myHero.charName ~= "Udyr" then return end

local ts, Config

function OnLoad()
    enemyMinions = minionManager(MINION_ENEMY, 600, myHero)
    jungleMinions = minionManager(MINION_JUNGLE, 600, myHero)
	Config = scriptConfig("[PQ] Udyr", "pqudyr")
	Config:addParam("combo", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, 32)
	Config:addSubMenu("Farm", "Farm")
	Config.Farm:addParam("Farm", "Farm - Toggle[G]", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("G"))
	Config.Farm:addParam("qFarm", "Use - Tiger Stance", SCRIPT_PARAM_ONOFF, true)
	Config.Farm:addParam("rFarm", "Use - Phoenix Stance", SCRIPT_PARAM_ONOFF, true)
	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, myHero.range, DAMAGE_PHYSICAL)
	ts.name = "Udyr"
	Config:addTS(ts)
end

function OnTick()
	local Target = GetTarget()
	if Config.combo and Target ~= nil then
		--We have E-Q-R-W
		if myHero:GetSpellData(_Q).level >= 1 and myHero:GetSpellData(_W).level >= 1 and myHero:GetSpellData(_E).level >= 1 and myHero:GetSpellData(_R).level >= 1 then
			if myHero:CanUseSpell(_E) == READY and TargetHaveBuff("udyrbearstuncheck", Target) == false then
				CastSpell(_E)
				elseif TargetHaveBuff("udyrbearstuncheck", Target) == true and myHero:CanUseSpell(_Q) == READY then
				CastSpell(_Q)
				elseif TargetHaveBuff("udyrbearstuncheck", Target) == true and myHero:CanUseSpell(_R) == READY then
				CastSpell(_R)
				elseif TargetHaveBuff("udyrbearstuncheck", Target) == true and myHero:CanUseSpell(_W) == READY then
				CastSpell(_W)
			end
			--We have E-R-W
			elseif myHero:GetSpellData(_W).level >= 1 and myHero:GetSpellData(_E).level >= 1 and myHero:GetSpellData(_R).level >= 1 and myHero:GetSpellData(_Q).level == 0 then
			if myHero:CanUseSpell(_E) == READY and TargetHaveBuff("udyrbearstuncheck", Target) == false then
				CastSpell(_E)
				elseif TargetHaveBuff("udyrbearstuncheck", Target) == true and myHero:CanUseSpell(_R) == READY then
				CastSpell(_R)
				elseif TargetHaveBuff("udyrbearstuncheck", Target) == true and myHero:CanUseSpell(_W) == READY then
				CastSpell(_W)
			end
			--We have E-Q-W
			elseif myHero:GetSpellData(_W).level >= 1 and myHero:GetSpellData(_E).level >= 1 and myHero:GetSpellData(_Q).level >= 1 and myHero:GetSpellData(_R).level == 0 then
			if myHero:CanUseSpell(_E) == READY and TargetHaveBuff("udyrbearstuncheck", Target) == false then
				CastSpell(_E)
				elseif TargetHaveBuff("udyrbearstuncheck", Target) == true and myHero:CanUseSpell(_Q) == READY then
				CastSpell(_Q)
				elseif TargetHaveBuff("udyrbearstuncheck", Target) == true and myHero:CanUseSpell(_W) == READY then
				CastSpell(_W)
			end
			--We have Q-W-R
			elseif myHero:GetSpellData(_W).level >= 1 and myHero:GetSpellData(_E).level == 0 and myHero:GetSpellData(_Q).level >= 1 and myHero:GetSpellData(_R).level >= 1 then
			if myHero:CanUseSpell(_Q) == READY then
				CastSpell(_Q)
				elseif myHero:CanUseSpell(_W) == READY then
				CastSpell(_W)
				elseif myHero:CanUseSpell(_R) == READY then
				CastSpell(_R)
			end
			--We have E-Q-R
			elseif myHero:GetSpellData(_W).level == 0 and myHero:GetSpellData(_E).level >=1 and myHero:GetSpellData(_Q).level >= 1 and myHero:GetSpellData(_R).level >= 1 then
			if myHero:CanUseSpell(_E) == READY and TargetHaveBuff("udyrbearstuncheck", Target) == false then
				CastSpell(_E)
				elseif TargetHaveBuff("udyrbearstuncheck", Target) == true and myHero:CanUseSpell(_Q) == READY then
				CastSpell(_Q)
				elseif TargetHaveBuff("udyrbearstuncheck", Target) == true and myHero:CanUseSpell(_R) == READY then
				CastSpell(_R)
			end
			--We have R-W
			elseif myHero:GetSpellData(_W).level >= 1 and myHero:GetSpellData(_R).level >= 1 and myHero:GetSpellData(_Q).level == 0 and myHero:GetSpellData(_E).level == 0 then
			if myHero:CanUseSpell(_E) == READY then
				CastSpell(_R)
				elseif myHero:CanUseSpell(_W) == READY then
				CastSpell(_W)
			end
			--We have E-Q
			elseif myHero:GetSpellData(_W).level == 0 and myHero:GetSpellData(_R).level == 0 and myHero:GetSpellData(_Q).level >= 1 and myHero:GetSpellData(_E).level >= 1 then
			if myHero:CanUseSpell(_E) == READY and TargetHaveBuff("udyrbearstuncheck", Target) == false then
				CastSpell(_E)
				elseif TargetHaveBuff("udyrbearstuncheck", Target) == true and myHero:CanUseSpell(_Q) == READY then
				CastSpell(_Q)
			end
			--We have Q or R
			elseif (myHero:GetSpellData(_Q).level >= 1 or myHero:GetSpellData(_R).level >= 1) and myHero:GetSpellData(_W).level == 0 and myHero:GetSpellData(_E).level == 0 then
			if myHero:CanUseSpell(_Q) == READY then CastSpell(_Q) end
			if myHero:CanUseSpell(_R) == READY then CastSpell(_R) end
		end
	end
	
				--> Farm
	if not Config.combo then
		if Config.Farm.Farm then
			for i, minion in pairs(enemyMinions.objects) do
				if minion and minion.valid and not minion.dead and GetDistance(minion) <= 525 then
					if Config.Farm.qFarm and myHero:CanUseSpell(_Q) == READY then
						if minion.health < getDmg("Q", minion, myHero)+getDmg("AD", minion, myHero) then
							CastSpell(_Q)
							myHero:Attack(minion) 
						end
						elseif Config.Farm.rFarm and myHero:CanUseSpell(_R) == READY then
						if minion.health < getDmg("R", minion, myHero)+getDmg("AD", minion, myHero) then
							CastSpell(_R)
							myHero:Attack(minion) 
						end
				    end
				end
			end
			for i, minion in pairs(jungleMinions.objects) do
				if minion and minion.valid and not minion.dead and GetDistance(minion) <= 525 then
					if Config.Farm.qFarm and myHero:CanUseSpell(_Q) == READY then
						CastSpell(_Q) 
						myHero:Attack(minion)
					end
				end
			end
		end
	end
	
	
end

function GetTarget()
	if _G.MMA_Target ~= nil and _G.MMA_Target.type:lower() == "obj_ai_hero" then
		return _G.MMA_Target
	end

	if _G.AutoCarry and _G.AutoCarry.Crosshair and _G.AutoCarry.Crosshair.Attack_Crosshair.target ~= nil and _G.AutoCarry.Crosshair.Attack_Crosshair.target.type:lower() == "obj_ai_hero" then
		return _G.AutoCarry.Crosshair.Attack_Crosshair.target
	end

	ts:update()

	return ts.target
end
