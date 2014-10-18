local version = 1.4
if not VIP_USER or myHero.charName ~= "Udyr" then return end
--{ Initiate Script (Checks for updates)
	function Initiate()
		local scriptName = "JKUdyr"
		printMessage = function(message) print("<font color=\"#690759\"><b>"..scriptName..":</b></font> <font color=\"#FFFFFF\">"..message.."</font>") end
		if FileExist(LIB_PATH.."SourceLib.lua") then
			require 'SourceLib'
		else
			printMessage("Downloading SourceLib, please wait whilst the required library is being downloaded.")
			DownloadFile("https://raw.githubusercontent.com/Dienofail/BoL/master/common/SourceLib.lua",LIB_PATH.."SourceLib.lua", function() printMessage("SourceLib successfully downloaded, please reload (double [F9]).") end)
			return true
		end
		local libDownloader = Require(scriptName)
		libDownloader:Add("VPrediction", "https://raw.githubusercontent.com/Hellsing/BoL/master/common/VPrediction.lua")
		libDownloader:Add("SOW",		 "https://raw.githubusercontent.com/Hellsing/BoL/master/common/SOW.lua")
		libDownloader:Check()
		if libDownloader.downloadNeeded then printMessage("Downloading required libraries, please wait whilst the required files are being downloaded.") return true end
	    SourceUpdater(scriptName, version, "raw.github.com", "/Jaikor/BoL/master/JKUdyr.lua", SCRIPT_PATH..GetCurrentEnv().FILE_NAME, "/Jaikor/BoL/master/Versions/JKudyr.version"):CheckUpdate()
		return false
	end


	
	if Initiate() then return end
	printMessage("Loaded")
--}

--{ Initiate Data Load
	local Udyr = {
		Q = {range = 600, speed = math.huge, delay = 0.5, DamageType = _PHYSICAL, BaseDamage = 30, DamagePerLevel = 50, ScalingStat = _PHYSICAL, PercentScaling = _AD, Condition = 0.15, Extra = function() return (myHero:CanUseSpell(_Q) == READY) end},
		W = {range = 600, speed = math.huge, delay = 0.5, DamageType = _PHYSICAL, BaseDamage = 0, DamagePerLevel = 0, ScalingStat = _MAGIC, PercentScaling = _AP, Condition = 0.0, Extra = function() return (myHero:CanUseSpell(_W) == READY) end},
		E = {range = 600, speed = math.huge, delay = 0.5, DamageType = _PHYSICAL, BaseDamage = 30, DamagePerLevel = 20, ScalingStat = _MAGIC, PercentScaling = _AP, Condition = 0.2, Extra = function() return (myHero:CanUseSpell(_E) == READY) end},
		R = {range = 600, speed = math.huge, delay = 0.5, DamageType = _MAGIC, BaseDamage = 75, DamagePerLevel = 50, ScalingStat = _MAGIC, PercentScaling = _AP, Condition = 1.25, Extra = function() return (myHero:CanUseSpell(_R) == READY) end}
	}
	
local qLevel = myHero:GetSpellData(_Q).level
local rLevel = myHero:GetSpellData(_R).level
--}
--{ Script Load
	function OnLoad()
	    PrintChat("<font color='#690759'> >> JKUdyr Imba Shit V1.4!! <<</font>")
		--{ Variables
			VP = VPrediction(true)
			OW = SOW(VP)
			OW:RegisterAfterAttackCallback(AutoAttackReset)
			TS = SimpleTS(STS_LESS_CAST_MAGIC)
			SpellQ = Spell(_Q, Udyr.Q["range"])
			SpellW = Spell(_W, Udyr.W["range"])
			SpellE = Spell(_E, Udyr.E["range"])
			SpellR = Spell(_R, Udyr.R["range"])
			EnemyMinions = minionManager(MINION_ENEMY, Udyr.Q["range"], myHero, MINION_SORT_MAXHEALTH_DEC)
			JungleMinions = minionManager(MINION_JUNGLE, Udyr.R["range"], myHero, MINION_SORT_MAXHEALTH_DEC)
		--}
		--{ DamageCalculator
			DamageCalculator = DamageLib()
			DamageCalculator:RegisterDamageSource(_Q, Udyr.Q["DamageType"], Udyr.Q["BaseDamage"], Udyr.Q["DamagePerLevel"], Udyr.Q["ScalingStat"], Udyr.Q["PercentScaling"], Udyr.Q["Condition"], Udyr.Q["Extra"])
			DamageCalculator:RegisterDamageSource(_W, Udyr.W["DamageType"], Udyr.W["BaseDamage"], Udyr.W["DamagePerLevel"], Udyr.W["ScalingStat"], Udyr.W["PercentScaling"], Udyr.W["Condition"], Udyr.W["Extra"])
			DamageCalculator:RegisterDamageSource(_E, Udyr.E["DamageType"], Udyr.E["BaseDamage"], Udyr.E["DamagePerLevel"], Udyr.E["ScalingStat"], Udyr.E["PercentScaling"], Udyr.E["Condition"], Udyr.E["Extra"])
			DamageCalculator:RegisterDamageSource(_R, Udyr.R["DamageType"], Udyr.R["BaseDamage"], Udyr.R["DamagePerLevel"], Udyr.R["ScalingStat"], Udyr.R["PercentScaling"], Udyr.R["Condition"], Udyr.R["Extra"])
		--}
				--{ Initiate Menu
			Menu = scriptConfig("Udyr","ImbaUdyr")
			Menu:addParam("Author","Author: Jaikor",5,"")
			Menu:addParam("Version","Version: "..version,5,"")
			--{ General/Key Bindings
				Menu:addSubMenu("Udyr: General","General")
				Menu.General:addParam("Combo","Combo",2,false,32)
				Menu.General:addParam("LaneClear","Lane Clear",2,false,string.byte("V"))
				Menu.General:addParam("JungleFarm","Jungle Farm",2,false,string.byte("G"))
				Menu.General:addParam("Flee","Ferrari Mode",2,false,string.byte("X"))
			--}
			--{ Target Selector			
				Menu:addSubMenu("Udyr: Target Selector","TS")
				Menu.TS:addParam("TS","Target Selector",7,2,{ "AllClass", "SourceLib", "Selector", "SAC:Reborn", "MMA" })
				ts = TargetSelector(8,Udyr.Q["range"],1,false)
				ts.name = "AllClass TS"
				Menu.TS:addTS(ts)				
			--}
			--{ Orbwalking
				Menu:addSubMenu("Udyr: Orbwalking","Orbwalking")
				OW:LoadToMenu(Menu.Orbwalking)
				Menu.Orbwalking.Mode0 = false
			--}
			--{	Combo Settings
				Menu:addSubMenu("Udyr: Combo","Combo")
				Menu.Combo:addParam("Q","Use Q in 'Combo'",1,true)
				Menu.Combo:addParam("W","Use W in 'Combo'",1,true)
				Menu.Combo:addParam("E","Use E in 'Combo'",1,true)
				Menu.Combo:addParam("R", "Use R in'Combo'",3, true, GetKey("G"))
			--}
			--{ Farm Settings
				Menu:addSubMenu("Udyr: Farm","Farm")
				Menu.Farm:addParam("Mana","Minimum Mana Percentage",4,70,0,100,0)
				Menu.Farm:addParam("Q","Use Q in 'Farm'",1,true)
				Menu.Farm:addParam("Qclear","Use Q in 'Lane Clear'",1,true)
				Menu.Farm:addParam("R","Use R in 'Farm'",1,true)
				Menu.Farm:addParam("Rclear","Use R in 'Lane Clear'",1,true)
			--}
			--{ Jungle Farm Settings
				Menu:addSubMenu("Udyr: JungleFarm","JungleFarm")
	    	    Menu.JungleFarm:addParam("JungleQ", "Jungle Q", SCRIPT_PARAM_ONOFF, true)
	        	Menu.JungleFarm:addParam("JungleR", "Jungle R", SCRIPT_PARAM_ONOFF, true)
	        	--}
			--{ Draw Settings
				Menu:addSubMenu("Udyr: Draw","Draw")
				DrawHandler = DrawManager()
				DrawHandler:CreateCircle(myHero,Udyr.Q["range"],1,{255, 255, 255, 255}):AddToMenu(Menu.Draw, "Q Range", true, true, true):LinkWithSpell(SpellQ, true)
				DrawHandler:CreateCircle(myHero,Udyr.W["range"],1,{255, 255, 255, 255}):AddToMenu(Menu.Draw, "W Range", true, true, true):LinkWithSpell(SpellW, true)
				DrawHandler:CreateCircle(myHero,Udyr.E["range"],1,{255, 255, 255, 255}):AddToMenu(Menu.Draw, "E Range", true, true, true):LinkWithSpell(SpellE, true)
				DrawHandler:CreateCircle(myHero,Udyr.R["range"],1,{255, 255, 255, 255}):AddToMenu(Menu.Draw, "E Range", true, true, true):LinkWithSpell(SpellR, true)
				DamageCalculator:AddToMenu(Menu.Draw,{_Q,_W,_E,_R,_AA})
			--}
			--{ Perma Show Settings
				Menu:addSubMenu("Udyr: Perma Show","Perma")
				Menu.Perma:addParam("INFO","The following options require a restart [F9 x2] to take effect",5,"")
				Menu.Perma:addParam("GC","Perma Show 'General > Combo'",1,true)				
				Menu.Perma:addParam("GF","Perma Show 'General > Farm'",1,true)
				if Menu.Perma.GC then Menu.General:permaShow("Combo") end
				Menu.Perma:addParam("CQ","Perma Show 'Combo > Q'",1,false)
				Menu.Perma:addParam("CW","Perma Show 'Combo > W'",1,false)
				Menu.Perma:addParam("CE","Perma Show 'Combo > E'",1,false)
				Menu.Perma:addParam("CR","Perma Show 'Combo > R'",1,false)
				if Menu.Perma.CQ then Menu.Combo:permaShow("Q") end
				if Menu.Perma.CW then Menu.Combo:permaShow("W") end
				if Menu.Perma.CE then Menu.Combo:permaShow("E") end
				if Menu.Perma.CR then Menu.Combo:permaShow("R") end
				Menu.Perma:addParam("FQ","Perma Show 'Farm > Q'",1,false)
				Menu.Perma:addParam("FC","Perma Show 'Farm > Qclear'",1,false)
				if Menu.Perma.FQ then Menu.Farm:permaShow("Q") end
				if Menu.Perma.FC then Menu.Farm:permaShow("Qclear") end
				Menu.Perma:addParam("JQ","Perma Show 'JungleFarm > JungleQ'",1,false)
				Menu.Perma:addParam("JR","Perma Show 'JungleFarm > JungleR'",1,false)
				if Menu.Perma.JQ then Menu.JungleFarm:permaShow("JungleQ") end
				if Menu.Perma.JR then Menu.JungleFarm:permaShow("JungleR") end
			--}
		--}
	end
--}
--{ Script Loop
	function OnTick()
		--{ Variables
			QMANA = GetSpellData(_Q).mana
			WMANA = GetSpellData(_W).mana
			EMANA = GetSpellData(_E).mana
			RMANA = GetSpellData(_R).mana
			Farm = Menu.General.LaneClear and Menu.Farm.Mana <= myHero.mana / myHero.maxMana * 100
			JungleFarm = Menu.General.JungleFarm
			Combat = Menu.General.Combo
			Flee = Menu.General.Flee
			QREADY = (SpellQ:IsReady() and ((Menu.General.Combo and Menu.Combo.Q) or (Menu.General.JungleFarm and Menu.JungleFarm.JungleQ) or (Farm and (Menu.Farm.Q or Menu.Farm.Qclear)) ))
			WREADY = (SpellW:IsReady() and ((Menu.General.Combo and Menu.Combo.W) ))
			EREADY = (SpellE:IsReady() and ((Menu.General.Combo and Menu.Combo.E) ))
			RREADY = (SpellR:IsReady() and ((Menu.General.Combo and Menu.Combo.R) or (Menu.General.JungleFarm and Menu.JungleFarm.JungleR) or (Farm and (Menu.Farm.R or Menu.Farm.Rclear)) ))
			Target = GrabTarget()
		--}	
		--{ Combo and Harass
			if Combat then
			if Target and not Target.dead then
		       if EREADY and not TargetHaveBuff("udyrbearstuncheck", Target) then
			   CastSpell(_E)
			   myHero:Attack(Target)
		       end
		    if (TargetHaveBuff("udyrbearstuncheck", Target) and myHero:GetSpellData(_E).level > 0 and GetDistance(Target) <= 400) or (myHero:GetSpellData(_E).level == 0 and GetDistance(Target) <= 400) then
			if QREADY then
				CastSpell(_Q)
				myHero:Attack(Target)
			end
			if RREADY and myHero:GetSpellData(_Q).level >= 1 and Tiger and (AttackCount >= 2 or TigerProc == true) then
				CastSpell(_R)
				myHero:Attack(Target)
			elseif myHero:GetSpellData(_Q).level == 0 then
				CastSpell(_R)
				myHero:Attack(Target)
			end
			if Phoenix == true and (AttackCount >= 3 or FlameBreath == true) then
				CastSpell(_W)
				myHero:Attack(Target)
			elseif Tiger == true and (AttackCount >= 2 or TigerProc == true) then
				CastSpell(_W)
				myHero:Attack(Target)
			elseif myHero:GetSpellData(_Q).level == 0 and myHero:GetSpellData(_R).level == 0 then
				CastSpell(_W)
				myHero:Attack(Target)
			end
					if Menu.Orbwalking.Enabled and (Menu.Orbwalking.Mode0 or Menu.Orbwalking.Mode1) then
						OW:ForceTarget(Target)
					end
		end
		end
		end
		--}	
		--{ Farming
			if Farm then
				EnemyMinions:update()
				for i, Minion in pairs(EnemyMinions.objects) do
					if ValidTarget(Minion) then
						if QREADY and (DamageCalculator:IsKillable(Minion,{_Q}) or Menu.General.LaneClear) then
							SpellQ:Cast(Minion)
							   myHero:Attack(Minion)
						end
						if RREADY and (DamageCalculator:IsKillable(Minion,{_R}) or Menu.General.LaneClear) then
							SpellR:Cast(Minion)
							   myHero:Attack(Minion)
						end
					end
				end
			end
		--}
		--{ Jungle Farming
			if JungleFarm then
				JungleMinions:update()
					JungleCreep = JungleMinions.objects[1]
					if ValidTarget(JungleCreep) then
                    if QREADY then 
                    SpellQ:Cast(JungleCreep)
					myHero:Attack(JungleCreep)
                    elseif RREADY and (not QREADY or myHero:GetSpellData(_Q).level < 1) then
                    SpellR:Cast(JungleCreep)
					myHero:Attack(JungleCreep)
                    end
					end
				end
		--}	
--}
end


--{ Target Selector
	function GrabTarget()
		if _G.MMA_Loaded and Menu.TS.TS == 5 then
			return _G.MMA_ConsideredTarget(MaxRange()) 
		elseif _G.AutoCarry and Menu.TS.TS == 4 then
			return _G.AutoCarry.Crosshair:GetTarget()
		elseif _G.Selector_Enabled and Menu.TS.TS == 3 then
			return Selector.GetTarget(SelectorMenu.Get().mode, 'AD', {distance = MaxRange()})
		elseif Menu.TS.TS == 2 then
			return TS:GetTarget(MaxRange())
		elseif Menu.TS.TS == 1 then
			ts.range = MaxRange()
			ts:update()
			return ts.target
		end
	end
--}
--{ Target Selector Range
	function MaxRange()
		if WREADY then
			return Udyr.W["range"]
		end
		if QREADY then
			return Udyr.Q["range"]
		end
		if RREADY then
			return Udyr.R["range"]
		end	
		if EREADY then
			return Udyr.E["range"]
		end
		return myHero.range + 50
	end
--}


function OnProcessSpell(unit, spell)
  if unit.isMe then
		if spell and spell.name == myHero:GetSpellData(_Q).name then
			Tiger, Turtle, Bear, Phoenix = true, false, false, false
			AttackCount, TurtleCount = 0, 0
		end
		if spell and spell.name == myHero:GetSpellData(_W).name then
			Tiger, Turtle, Bear, Phoenix = false, true, false, false
			AttackCount, TurtleCount = 0, 0
		end
		if spell and spell.name == myHero:GetSpellData(_E).name then
			Tiger, Turtle, Bear, Phoenix = false, false, true, false
			AttackCount, TurtleCount = 0, 0
		end
		if spell and spell.name == myHero:GetSpellData(_R).name then     
			Tiger, Turtle, Bear, Phoenix = false, false, false, true
			AttackCount, TurtleCount = 0, 0
		end
		if spell.name:find("Attack") then
			if (Target and spell.target == Target) or (Minion and spell.target == Minion) then
				if Tiger == true or Phoenix == true then
					AttackCount = AttackCount + 1
				elseif Turtle == true then
					TurtleCount = TurtleCount + 1
				end
			end
		end
	end
end

function OnCreateObj(obj)
	if GetDistance(obj) <= 70 and (obj.name == "Udyr_PhoenixBreath_cas.troy" or obj.name == "Udyr_Spirit_Phoenix_Breath_cas.troy") then
		FlameBreath = true
	end
	if GetDistance(obj) <= 450 and (obj.name == "udyr_tiger_claw_tar.troy" or obj.name == "Udyr_Spirit_Tiger_Claw_tar.troy") then
		TigerProc = true
	end
end

function OnDeleteObj(obj)
	if GetDistance(obj) <= 70 and (obj.name == "Udyr_PhoenixBreath_cas.troy" or obj.name == "Udyr_Spirit_Phoenix_Breath_cas.troy") then
		FlameBreath = false
	end
	if GetDistance(obj) <= 450 and (obj.name == "udyr_tiger_claw_tar.troy" or obj.name == "Udyr_Spirit_Tiger_Claw_tar.troy") then
		TigerProc = false
	end
end
