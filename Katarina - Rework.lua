if myHero.charName ~= 'Katarina' then return end
-- http://bol-tools.com/ tracker
assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("FTqjCPEE6ycKT2fq")

--local KatarinaVersion = 3.36

--- Starting AutoUpdate
local version = "3.38"
local author = "Skeem & Jaikor"
local SCRIPT_NAME = "Katarina - Rework"
local AUTOUPDATE = true
local UPDATE_HOST = "raw.githubusercontent.com"
local UPDATE_PATH = "/Jaikor/BoL/master/Katarina%20-%20Rework.lua".."?rand="..math.random(1,10000)
local UPDATE_FILE_PATH = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH
local whatsnew = 0

function KataUpdate()
if AUTOUPDATE then
	local ServerData = GetWebResult(UPDATE_HOST, "/Jaikor/BoL/master/Versions/Katarina.Version")
	if ServerData then
		ServerVersion = type(tonumber(ServerData)) == "number" and tonumber(ServerData) or nil
		if ServerVersion then
			if tonumber(version) < ServerVersion then
				EnvoiMessage("New version available "..ServerVersion)
				EnvoiMessage(">>Updating, please don't press F9<<")
				DelayAction(function() DownloadFile(UPDATE_URL, UPDATE_FILE_PATH, function () EnvoiMessage("Successfully updated. ("..version.." => "..ServerVersion.."), press F9 twice to load the updated version.") end) end, 3)
				whatsnew = 1
			else
				DelayAction(function() EnvoiMessage("Hello, "..GetUser()..". You got the latest version! :) ("..ServerVersion..")") end, 3)
			end
		end
		else
			EnvoiMessage("Error downloading version info")
	end
end
end
 --- End Of AutoUpdate





--|> Cuz superx is the only lua bender
require 'SxOrbWalk'

class 'Katarina'
--class 'Download'

	function Katarina:__init()
         --|> Version checker and updater
        self.Version = 3.37
        self:CheckUpdates()
		KataUpdate()
		--|> Spell Information
		self.spells = {
			Q = Spells(_Q, 675, 'Bouncing Blades', 'targeted', ARGB(255,178, 0 , 0 )),
			W =	Spells(_W, 375, 'Sinister Steel',  'notarget', ARGB(255, 32,178,170)),
			E =	Spells(_E, 700, 'Shunpo',          'targeted', ARGB(255,128, 0 ,128)),
			R =	Spells(_R, 550, 'Death Lotus',     'notarget')
		}
		--|> Tracks When Throwing Q
		self.Q = {throwing = false, last = 0}
		self.targetsWithQ = {}

		--|> Tracks E for Humanizer
		self.E = {last = 0, delay = 0, canuse = true}

		--|> Tracks When Using R
		self.R = {using  = false, last = 0}

		--|> Tracks Ward Jumpings
		self.lastJump = 0

		--|> Ward Names (bye bye Ids)
		self.wards = {SightStone = 'itemghostward', SightWard = 'sightward', VisionWard = 'visionward', Trinket1 = 'trinkettotemlvl1', Trinket2 = 'trinkettotemlvl2', Trinket3 = 'trinkettotemlvl3', Trinket4 = 'trinkettotemlvl3b'}

		--|> Starts Menu
		self:Menu()

		--|> Ignite Slot
		--self.ignite = myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") and SUMMONER_1 or myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") and SUMMONER_2 or nil
        self.ignite =  myHero:GetSpellData(SUMMONER_1).name:lower() == "summonerdot"  and SUMMONER_1 or myHero:GetSpellData(SUMMONER_2).name:lower() == "summonerdot" and SUMMONER_2 or nil
        

		--|> SAC & MMA Combability
		self.comp = false

		--|> Target tracking
		self.target = nil

		--|> Items Table
		self:LoadItemsTable()

		--|> Wards Table
		self.wardsTable = {}
		for i = 0, objManager.maxObjects do
			local obj = objManager:getObject(i)
			if obj and obj.valid and (string.find(obj.name, "Ward") ~= nil or string.find(obj.name, "Wriggle") ~= nil or string.find(obj.name, "Trinket")) then
				table.insert(self.wardsTable, obj)
			end
		end

		--|> Minion Managers
		self.enemyMinions   = minionManager(MINION_ENEMY,   self.spells.E:Range(), myHero, MINION_SORT_MAXHEALTH_DEC)
		self.allyMinions    = minionManager(MINION_ALLY,    self.spells.E:Range(), myHero, MINION_SORT_MAXHEALTH_DEC)
		self.jungleMinions  = minionManager(MINION_JUNGLE,  self.spells.E:Range(), myHero, MINION_SORT_MAXHEALTH_DEC)
		self.otherMinions   = minionManager(MINION_OTHER,   self.spells.E:Range(), myHero, MINION_SORT_MAXHEALTH_DEC)

		--|> Override Globals Credits to Aroc :3
		_G.myHero.SaveMove = _G.myHero.MoveTo
		_G.myHero.SaveAttack = _G.myHero.Attack
		_G.myHero.MoveTo = function(...) if not self.R.using then _G.myHero.SaveMove(...) end end
		_G.myHero.Attack = function(...) if not self.R.using then _G.myHero.SaveAttack(...) end end

		--|> Callback Binds
		AddTickCallback(function() self:Tick() end)
		AddDrawCallback(function() self:Draw() end)
		AddMsgCallback(function (msg, key) self:WndMsg(msg, key) end)
		AddProcessSpellCallback(function(unit, spell) self:Spells(unit, spell)	end)
		AddApplyBuffCallback(function(unit, source, buff) self:OnApplyBuff(unit, source, buff) end)
		AddRemoveBuffCallback(function(unit, buff) self:OnRemoveBuff(unit, buff) end)
		AddCastSpellCallback(function(iSpell, startPos, endPos, targetUnit) self:OnCastSpell(iSpell,startPos,endPos,targetUnit) end)
		AddCreateObjCallback(function(obj) self:ObjCreate(obj) end)
		AddDeleteObjCallback(function(obj) self:ObjDelete(obj) end)

		--|> Prints Loaded
		print("<font color=\"#FF0000\">[Nintendo Katarina]:</font> <font color=\"#FFFFFF\">Loaded Version: "..self.Version.."</font>")
	end


	function Katarina:Menu()
		---|> Initiates scriptConfig instance
		self.menu = scriptConfig('Nintendo Katarina', 'NintendoKatarina')
			--|> Skills Settings Menu
			self.menu:addSubMenu('-~=[Skill Settings]=~- ', 'skills')
				self.menu.skills:addSubMenu('Q - ['..self.spells.Q.name..']', 'Q')
					self.menu.skills.Q:addParam('autoQ',   'Auto Harass Enemies', SCRIPT_PARAM_ONOFF, true)
					self.menu.skills.Q:addParam('comboQ',  'Use in Combo',  SCRIPT_PARAM_ONOFF, true)
					self.menu.skills.Q:addParam('harassQ', 'Use in Harass', SCRIPT_PARAM_ONOFF, true)
					self.menu.skills.Q:addParam('clearQ',  'Use in Clear ', SCRIPT_PARAM_ONOFF, true)
					self.menu.skills.Q:addParam('drawQ',   'Draw Range ',   SCRIPT_PARAM_ONOFF, true)
				self.menu.skills:addSubMenu('W - ['..self.spells.W.name..']', 'W')
					self.menu.skills.W:addParam('autoW',   'Auto Harass Enemies', SCRIPT_PARAM_ONOFF, true)
					self.menu.skills.W:addParam('comboW',  'Use in Combo',  SCRIPT_PARAM_ONOFF, true)
					self.menu.skills.W:addParam('harassW', 'Use in Harass', SCRIPT_PARAM_ONOFF, true)
					self.menu.skills.W:addParam('clearW',  'Use in Clear ', SCRIPT_PARAM_ONOFF, true)
					self.menu.skills.W:addParam('drawW',   'Draw Range ',   SCRIPT_PARAM_ONOFF, true)
				self.menu.skills:addSubMenu('E - ['..self.spells.E.name..']', 'E')
					self.menu.skills.E:addParam('comboE',    'Use in Combo',  SCRIPT_PARAM_ONOFF, true)
					self.menu.skills.E:addParam('harassE',   'Use in Harass', SCRIPT_PARAM_ONOFF, false)
					self.menu.skills.E:addParam('clearE',    'Use in Clear ', SCRIPT_PARAM_ONOFF, true)
					self.menu.skills.E:addParam('drawE',     'Draw Range ',   SCRIPT_PARAM_ONOFF, true)			
					self.menu.skills.E:addParam('humanizer', 'Use Humanizer', SCRIPT_PARAM_ONOFF, false)
					self.menu.skills.E:addParam('maxdelay',  'Max Delay',     SCRIPT_PARAM_SLICE, 1.5, 0, 3, 1)
				self.menu.skills:addSubMenu('R - ['..self.spells.R.name..']', 'R')
					self.menu.skills.R:addParam('stopclick',  'Stop R With Right Click',      SCRIPT_PARAM_ONOFF, true)
					self.menu.skills.R:addParam('stopkill',   'Stop R if I Can Kill Target',  SCRIPT_PARAM_ONOFF, true)
			
			--|> Combo Settings Menu
			self.menu:addSubMenu('-~=[Combo Settings]=~-', 'combo')
				self.menu.combo:addParam('procQ',    'Detonate Q Mark', SCRIPT_PARAM_ONOFF, true)
				self.menu.combo:addParam('useItems', 'Use Items',       SCRIPT_PARAM_ONOFF, true)
			
			--|> Harrass Settings Menu
			self.menu:addSubMenu('-~=[Harass Settings]=~-', 'harass')
				self.menu.harass:addParam('procQ', 'Detonate Q Mark', SCRIPT_PARAM_ONOFF, true)
			
			--|> Orbwalk Settings Menu
			self.menu:addSubMenu('-~=[Orbwalk Settings]=~-', 'orbwalk')
				SxOrb:LoadToMenu(self.menu.orbwalk, true)
				SxOrb:RegisterHotKey('fight',     self.menu, 'comboKey')
				SxOrb:RegisterHotKey('harass',    self.menu, 'harassKey')
				SxOrb:RegisterHotKey('laneclear', self.menu, 'clearKey')
				SxOrb:RegisterHotKey('lasthit',   self.menu, 'lasthitKey')

			--|> KillSteal Settings Menu
			self.menu:addSubMenu('-~=[KillSteal Settings]=~-', 'killsteal')
				self.menu.killsteal:addParam('killswitch', 'Use KillSteal', SCRIPT_PARAM_ONOFF, true)
				self.menu.killsteal:addParam('ignite',     'Auto Ignite',   SCRIPT_PARAM_ONOFF, true)
				self.menu.killsteal:addParam('wards',      'Use Wards',     SCRIPT_PARAM_ONOFF, true)

			--|> Farming Settings Menu
			self.menu:addSubMenu('-~=[Farming Settings]=~-', 'farming')
				self.menu.farming:addParam('farmQToggle', 'Q Farm Always',     SCRIPT_PARAM_ONKEYTOGGLE , false, GetKey('Z'))
				self.menu.farming:addParam('farmQLast',   'Q Farm in LastHit', SCRIPT_PARAM_ONOFF, true)
				self.menu.farming:addParam('farmWToggle', 'W Farm Always',     SCRIPT_PARAM_ONOFF, true)

			--|> Other Settings
			self.menu:addSubMenu('-~=[Other Settings]=~-', 'other')
				self.menu.other:addParam('maxjump', 'Always Ward Jump at Max Range', SCRIPT_PARAM_ONOFF, true)
				self.menu.other:addParam('drawText', 'Draw Damage Text on Enemy', SCRIPT_PARAM_ONOFF, true)
                if VIP_USER then
                self.menu.other:addParam('skins', 'Skin Changer', SCRIPT_PARAM_LIST, 1,{"Classic", "Mercenary", "Red Card", "Bilgewater", "Kitty Cat", "High Command", "Sandstorm", "Slay Belle", "Warring Kingdoms"})
                end
                
			--|> Main Keys
			self.menu:addParam('comboKey',    'Full Combo Key', SCRIPT_PARAM_ONKEYDOWN, false, GetKey('X'))
			self.menu:addParam('harassKey',   'Harass Key',     SCRIPT_PARAM_ONKEYDOWN, false, GetKey('C'))
			self.menu:addParam('clearKey',    'Clear Key',      SCRIPT_PARAM_ONKEYDOWN, false, GetKey('V'))
			self.menu:addParam('lasthitKey',  'Last Hit Key',   SCRIPT_PARAM_ONKEYDOWN, false, GetKey('A'))
			self.menu:addParam('wardjumpKey', 'Ward Jump Key',  SCRIPT_PARAM_ONKEYDOWN, false, GetKey('G'))

			--|> Perma Shows
			self.menu:permaShow('comboKey')
			self.menu:permaShow('harassKey')
			self.menu:permaShow('clearKey')
			self.menu:permaShow('wardjumpKey')
			self.menu.farming:permaShow('farmQToggle')

			--|> Target Selector
			self.ts = TargetSelector(TARGET_LESS_CAST, self.spells.E.range, DAMAGE_MAGIC, true)
			self.ts.name = 'Katarina'
			self.menu:addTS(self.ts)

			--|> Loads Priority Table
			self:LoadPriorityTable()
			--|> Sets Prioties`
			self:SetTablePriorities()
	end

	function Katarina:Tick()
    if VIP_USER then
    SetSkin(myHero, self.menu.other.skins - 1)
    end
		self.target = self:GetTarget()
		if self.target  and not self.using then
			if self.menu.comboKey then
				self:Combo(self.target)
			elseif self.menu.harassKey then
				self:Harass(self.target)
			end
			if self.menu.skills.Q.autoQ then
				self.spells.Q:Cast(self.target)
			end
			if self.menu.skills.W.autoW then
				self.spells.W:Cast(self.target)
			end
		end
		if self.menu.clearKey then
			self:Clear()
		end
		if self.menu.killsteal.killswitch then
			self:KillSteal()
		end
		if self.menu.killsteal.ignite and self.ignite ~= nil then
			self:AutoIgnite()
		end
		if self.menu.wardjumpKey then
    		local WardPos = (GetDistanceSqr(mousePos) <= 600 * 600 and mousePos) or (self.menu.other.maxjump and myHero + (Vector(mousePos) - myHero):normalized()*590)
			if WardPos then
				self:WardJump(WardPos.x, WardPos.z)
			end
		end
		if not self.menu.comboKey then 
			self:Farm()
		end
		if self.Q.throwing then
			if (os.clock() - self.Q.last) > 0.5 then
				self.Q.throwing = false
			end
		end
		if self.R.using then
			if (os.clock() - self.R.last) > 2.5 then
				self.R.using = false
				self.R.last  = 0
			end
		end
		if not self.E.canuse then
			if (os.clock() - self.E.last) > self.E.delay then
				self.E.canuse = true
			end
		end
		if not self.comp then
			if _G.AutoCarry then
				print("<font color=\"#FF0000\">[Nintendo Katarina]:</font> <font color=\"#FFFFFF\">Found SAC Disabling SxOrb</font>")
				if self.menu.orbwalk.General.Enabled and self.menu.orbwalk.General.Enabled == true then
			 		self.menu.orbwalk.General.Enabled = true
			 	end
				self.comp = true
			 elseif _G.MMA_Loaded then
			 	print("<font color=\"#FF0000\">[Nintendo Katarina]:</font> <font color=\"#FFFFFF\">Found MMA Disabling SxOrb</font>")
			 	if self.menu.orbwalk.General.Enabled and self.menu.orbwalk.General.Enabled == true then
			 		self.menu.orbwalk.General.Enabled = true
			 	end
			 	self.comp = true
			 end
		end
	end

	function Katarina:random(min, max, precision)
   		local precision = precision or 0
   		local num = math.random()
   		local range = math.abs(max - min)
   		local offset = range * num
   		local randomnum = min + offset
   		return math.floor(randomnum * math.pow(10, precision) + 0.5) / math.pow(10, precision)
	end

	function Katarina:Draw()
		if self.menu.skills.Q.drawQ and self.spells.Q:Ready() then
			self:DrawCircle(myHero.x, myHero.y, myHero.z, self.spells.Q:Range(), self.spells.Q:Color())
		end
		if self.menu.skills.W.drawW and self.spells.W:Ready() then
			self:DrawCircle(myHero.x, myHero.y, myHero.z, self.spells.W:Range(), self.spells.W:Color())
		end
		if self.menu.skills.E.drawE and self.spells.E:Ready() then
			self:DrawCircle(myHero.x, myHero.y, myHero.z, self.spells.E:Range(), self.spells.E:Color())
		end
		if self.menu.other.drawText then
			for i, enemy in ipairs(GetEnemyHeroes()) do
				if ValidTarget(enemy) then
					local pos = WorldToScreen(D3DXVECTOR3(enemy.x, enemy.y, enemy.z))
					local enemyText, color =  self:GetDrawText(enemy)
					if enemyText ~= nil then
						DrawText(enemyText, 15, pos.x, pos.y, color)
					end
				end
			end
		end
	end

	function Katarina:GetDrawText(unit)
		local DmgTable = { Q = self.spells.Q:Damage(unit), W = self.spells.W:Damage(unit), E = self.spells.E:Damage(unit), R = self.spells.R:Damage(unit)}
		local ExtraDmg = 0
		if self.ignite ~= nil and myHero:CanUseSpell(self.ignite) == READY then
			ExtraDmg = ExtraDmg + getDmg('IGNITE', unit, myHero)
		end
		if DmgTable.W > unit.health then
			return 'W', RGBA(139, 0, 0, 255)
		elseif DmgTable.Q > unit.health then
			return 'Q', RGBA(139, 0, 0, 255)
		elseif DmgTable.E > unit.health then
			return 'E', RGBA(139, 0, 0, 255)
		elseif DmgTable.Q + DmgTable.W > unit.health then
			return 'W + Q', RGBA(139, 0, 0, 255)
		elseif DmgTable.E + DmgTable.W > unit.health then
			return 'E + W', RGBA(139, 0, 0, 255)
		elseif DmgTable.Q + DmgTable.W + DmgTable.E > unit.health then
			return 'Q + W + E', RGBA(255, 0, 0, 255)
		elseif DmgTable.Q + self:QBuffDmg(unit) + DmgTable.W + DmgTable.E > unit.health then
			return '(Q + Passive) + W +E', RGBA(255, 0, 0, 255)
		elseif ExtraDmg > 0 and ExtraDmg + DmgTable.Q + self:QBuffDmg(unit) + DmgTable.W + DmgTable.E > unit.health then
			return '(Q + Passive) + W + E + Ignite', RGBA(255, 0, 0, 255)
		elseif self.spells.R:Ready2() and DmgTable.Q + DmgTable.W + DmgTable.E + (DmgTable.R *10) > unit.health then
			return 'Q + W + E + Ult ('.. string.format('%4.1f', (unit.health -  DmgTable.Q + DmgTable.W + DmgTable.E) * (1/(DmgTable.R*10))) .. ' Secs)', RGBA(255, 69, 0, 255)
		else
			return 'Cant Kill Yet', RGBA(0, 255, 0, 255)
		end
	end

	function Katarina:Combo(target)
		if self.menu.combo.useItems then
			self:UseItems(target)
		end
		if self.menu.skills.Q.comboQ then
			self.spells.Q:Cast(target)
		end
		if self.menu.skills.W.comboW then
			self.spells.W:Cast(target)
		end
		if not self.spells.Q:Ready() and self.menu.skills.E.comboE then
			if self.menu.combo.procQ then
				if not self.Q.throwing then
					self.spells.E:Cast(target)
				end
			else
				self.spells.E:Cast(target)
			end
		end
		if not self.spells.Q:Ready() and not self.spells.W:Ready() and not self.spells.E:Ready() then
			self.spells.R:Cast(target)
		end
	end

	function Katarina:Harass(target)
		if self.menu.skills.Q.harassQ then
			self.spells.Q:Cast(target)
		end
		if self.menu.skills.W.harassW then
			self.spells.W:Cast(target)
		end
		if not self.spells.Q:Ready() and self.menu.skills.E.harassE then
			if self.menu.harass.procQ then
				if not self.Q.throwing then
					self.spells.E:Cast(target)
				end
			else
				self.spells.Q:Cast(target)
			end
		end
	end

	function Katarina:Farm()
		self.enemyMinions:update()
		for i, minion in ipairs(self.enemyMinions.objects) do
			if self.menu.farming.farmWToggle then
				if ValidTarget(minion) and minion.health <= self.spells.W:Damage(minion) then
					self.spells.W:Cast(minion)
				end
			end
			if self.menu.farming.farmQToggle or (self.menu.farming.farmQLast and self.menu.lasthitKey) then
				if ValidTarget(minion) and minion.health <= self.spells.Q:Damage(minion) then
					self.spells.Q:Cast(minion)
				end
			end
		end
	end

	function Katarina:Clear()
		local cleartarget = nil
		self.enemyMinions:update()
		self.otherMinions:update()
		self.jungleMinions:update()
		for i, minion in ipairs(self.enemyMinions.objects) do
			if ValidTarget(minion, 600) and (cleartarget == nil or not ValidTarget(cleartarget)) then
				cleartarget = minion
			end
		end
		for i, jungleminion in ipairs(self.jungleMinions.objects) do
			if ValidTarget(jungleminion, 600) and (cleartarget == nil or not ValidTarget(cleartarget)) then
				cleartarget = jungleminion
			end
		end
		for i, otherminion in ipairs(self.otherMinions.objects) do
			if ValidTarget(otherminion, 600) and (cleartarget == nil or not ValidTarget(cleartarget)) then
				cleartarget = otherminion
			end
		end
		if cleartarget ~= nil then
			if self.menu.skills.Q.clearQ then
				self.spells.Q:Cast(cleartarget)
			end
			if self.menu.skills.W.clearW then
				self.spells.W:Cast(cleartarget)
			end
			if self.menu.skills.E.clearE then
				self.spells.E:Cast(cleartarget)
			end
		end
	end

	function Katarina:KillSteal()
		for i, enemy in ipairs(GetEnemyHeroes()) do
			if ValidTarget(enemy, 700) then
				local DmgTable = { Q = self.spells.Q:Ready() and self.spells.Q:Damage(enemy) or 0, W = self.spells.W:Ready() and self.spells.W:Damage(enemy) or 0, E = self.spells.E:Ready() and self.spells.E:Damage(enemy) or 0}
				local ExtraDmg = 0
				if self.targetsWithQ[enemy.networkID] ~= nil then
					ExtraDmg = ExtraDmg + self:QBuffDmg(enemy)
				end
				if self.ignite ~= nil and myHero:CanUseSpell(self.ignite) == READY then
					ExtraDmg = ExtraDmg + getDmg('IGNITE', enemy, myHero)
				end
				if DmgTable.W > enemy.health + ExtraDmg then
					self.spells.W:Cast(enemy)
				elseif DmgTable.Q > enemy.health + ExtraDmg then
					self.spells.Q:Cast(enemy)
				elseif DmgTable.E > enemy.health + ExtraDmg then
					self.spells.E:Cast(enemy)
				elseif DmgTable.Q + DmgTable.W > enemy.health and GetDistance(enemy) <= self.spells.W:Range() + ExtraDmg then
					self.spells.W:Cast(enemy)
					self.spells.Q:Cast(enemy)
				elseif DmgTable.E + DmgTable.W > enemy.health + ExtraDmg then
					self.spells.E:Cast(enemy)
					self.spells.W:Cast(enemy)
				elseif DmgTable.Q + DmgTable.W + DmgTable.E > enemy.health + ExtraDmg then
					self.spells.E:Cast(enemy)
					self.spells.Q:Cast(enemy)
					self.spells.W:Cast(enemy)
				end
			elseif  self.menu.killsteal.wards and ValidTarget(enemy, self.spells.Q:Range() + 590) and (GetDistance(enemy) > self.spells.Q:Range()) then
				local ExtraDmg = 0
				if self.ignite ~= nil and myHero:CanUseSpell(self.ignite) == READY then
					ExtraDmg = ExtraDmg + getDmg('IGNITE', enemy, myHero)
				end
			 	if enemy.health <= (self.spells.Q:Damage(enemy) + ExtraDmg) then
					local WardPos = myHero + (Vector(enemy) - myHero):normalized()*590
					if WardPos then
						self:WardJump(WardPos.x, WardPos.z, enemy)
						self.spells.Q:Cast(enemy)
					end
				end
			end
		end
	end

	function Katarina:QBuffDmg(unit)
		return getDmg('Q', unit, myHero, 2) or 0
	end

	function Katarina:MaxDmg(unit)
		local DmgTable = { Q = self.spells.Q:Ready() and self.spells.Q:Damage(unit) or 0, W = self.spells.W:Ready() and self.spells.W:Damage(unit) or 0, E = self.spells.E:Ready() and self.spells.E:Damage(unit) or 0}
		local ExtraDmg = 0
		if self.targetsWithQ[unit.networkID] ~= nil then
			ExtraDmg = ExtraDmg + self:QBuffDmg(unit)
		end
		if self.ignite ~= nil and myHero:CanUseSpell(self.ignite) == READY then
			ExtraDmg = ExtraDmg + getDmg('IGNITE', unit, myHero)
		end
		return DmgTable.Q + DmgTable.W + DmgTable.E + ExtraDmg
	end

	function Katarina:OtherMovements(bool)
		if _G.AutoCarry then
			if _G.AutoCarry.MainMenu ~= nil then
				if _G.AutoCarry.CanAttack ~= nil then
					_G.AutoCarry.CanAttack = bool
					_G.AutoCarry.CanMove = bool
				end
			elseif _G.AutoCarry.Keys ~= nil then
					if _G.AutoCarry.MyHero ~= nil then
					_G.AutoCarry.MyHero:MovementEnabled(bool)
					_G.AutoCarry.MyHero:AttacksEnabled(bool)
				end
			end
		elseif _G.MMA_Loaded then
			_G.MMA_Orbwalker	= bool
			_G.MMA_HybridMode	= bool
			_G.MMA_LaneClear	= bool
			_G.MMA_LastHit		= bool
		end
	end

	function Katarina:DrawCircle(x, y, z, radius, color)
		local vPos1 = Vector(x, y, z)
		local vPos2 = Vector(cameraPos.x, cameraPos.y, cameraPos.z)
		local tPos = vPos1 - (vPos1 - vPos2):normalized() * radius
		local sPos = WorldToScreen(D3DXVECTOR3(tPos.x, tPos.y, tPos.z))
		
		if OnScreen({ x = sPos.x, y = sPos.y }, { x = sPos.x, y = sPos.y }) then
			self:DrawCircleNextLvl(x, y, z, radius, 1, color, 300) 
		end
	end

	function Katarina:DrawCircleNextLvl(x, y, z, radius, width, color, chordlength)
		radius = radius or 300
		quality = math.max(8, self:Round(180 / math.deg((math.asin((chordlength / (2 * radius)))))))
		quality = 2 * math.pi / quality
		radius = radius * .92
		local points = {}
		
		for theta = 0, 2 * math.pi + quality, quality do
			local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
			points[#points + 1] = D3DXVECTOR2(c.x, c.y)
		end
		DrawLines2(points, width or 1, color or 4294967295)
	end

	function Katarina:Round(number)
		if number >= 0 then 
			return math.floor(number+.5) 
		else 
			return math.ceil(number-.5) 
		end
	end


	function Katarina:UseItems(target)
		for i, Item in pairs(self.items) do
			local Item = self.items[i]
			if GetInventoryItemIsCastable(Item.id) and GetDistanceSqr(target) <= Item.range*Item.range then
				CastItem(Item.id, target)
			end
		end
	end


	function Katarina:WardJump(x, y, enemy)
		if GetDistance(mousePos) and not enemy then
			local moveToPos = myHero + (Vector(mousePos) - myHero):normalized()*300
			myHero:MoveTo(moveToPos.x, moveToPos.z)
		end	
		if self.spells.E:Ready() then
			local Jumped = false
			local WardDistance = 300
			for i, ally in ipairs(GetAllyHeroes()) do
				if ValidTarget(ally, self.spells.E:Range(), false) then
					if GetDistanceSqr(ally, mousePos) <= WardDistance*WardDistance then
						CastSpell(_E, ally)
						Jumped = true
						self.lastJump = GetTickCount() + 2000
					end
				end
			end
			self.allyMinions:update()
			for i, minion in pairs(self.allyMinions.objects) do
				if ValidTarget(minion, self.spells.E:Range(), false) then
					if GetDistanceSqr(minion, mousePos) <= WardDistance*WardDistance then
						CastSpell(_E, minion)
						Jumped = true
						self.lastJump = GetTickCount() + 2000
					end
				end
			end
			for i, Ward in pairs(self.wardsTable) do
				if GetDistanceSqr(mousePos) < 600 * 600 then
					if GetDistanceSqr(Ward, mousePos) < WardDistance*WardDistance then
					CastSpell(_E, Ward)
						Jumped = true
						self.lastJump = GetTickCount() + 2000
					end
				else
					if GetDistanceSqr(Ward) < self.spells.E:Range() * self.spells.E:Range() then
						CastSpell(_E, Ward)
					end
				end
			end

			if not Jumped and GetTickCount() >= self.lastJump then
				local Slot = self:GetWardSlot()
				if Slot ~= nil then
					CastSpell(Slot, x, y)
					Jumped = true
					self.lastJump = GetTickCount() + 2000
				end
			end
		end
	end
	function Katarina:GetWardSlot()
		-- Gets Slot of Available Wards --
		local function getReadySlot(itemName)
			for slot = 6, 12 do
				if string.lower(myHero:GetSpellData(slot).name) == itemName and myHero:CanUseSpell(slot) then
					return slot
				end
			end
			return nil
		end
		-- Ward Priorities --
		if getReadySlot(self.wards.Trinket1) ~= nil then
			return getReadySlot(self.wards.Trinket1)
		elseif getReadySlot(self.wards.Trinket2) ~= nil then
			return getReadySlot(self.wards.Trinket2)
		elseif getReadySlot(self.wards.Trinket3) ~= nil then
			return getReadySlot(self.wards.Trinket3)
		elseif getReadySlot(self.wards.Trinket4) ~= nil then
			return getReadySlot(self.wards.Trinket4)
		elseif getReadySlot(self.wards.SightWard) ~= nil then
			return getReadySlot(self.wards.SightWard)
		elseif getReadySlot(self.wards.VisionWard) ~= nil then
			return getReadySlot(self.wards.VisionWard)
		elseif getReadySlot(self.wards.SightStone) ~= nil then
			return getReadySlot(self.wards.SightStone)
		end
		return nil
	end

	function Katarina:AutoIgnite()
		if myHero:CanUseSpell(self.ignite) == READY then
			for i, enemy in ipairs(GetEnemyHeroes()) do
				if ValidTarget(enemy, 600) and enemy.health <= getDmg('IGNITE', enemy, myHero) then
					CastSpell(self.ignite, enemy)
				end
			end
		end
	end

	function Katarina:WndMsg(msg, key)
		if self.menu.skills.R.stopclick then
			if msg == WM_RBUTTONDOWN and self.R.using then 
				self.R.using = false
			end
		end
	end

	function Katarina:OnCastSpell(iSpell,startPos,endPos,targetUnit)
		if iSpell == 3 then
			self.R.using = true
			self.R.last  = os.clock()
		end
	end

	function Katarina:ObjCreate(obj)
		if obj.valid and (string.find(obj.name, "Ward") ~= nil or string.find(obj.name, "Wriggle") ~= nil or string.find(obj.name, "Trinket")) then
			table.insert(self.wardsTable, obj)
		end
	end

	function Katarina:ObjDelete(obj)
		if obj then
			for i, ward in pairs(self.wardsTable) do
				if not ward.valid or obj.name == ward.name then
					table.remove(self.wardsTable, i)
				end
			end
		end
	end

	function Katarina:OnApplyBuff(unit, source,  buff)
		if unit == myHero and buff.name == 'katarinaqmark' then
			self.targetsWithQ[source.networkID] = true
			if self.Q.throwing then
				self.Q.throwing = false
			end
		end
	end

	function Katarina:OnRemoveBuff(unit, buff)
		if buff.name == 'katarinaqmark' then
			self.targetsWithQ[unit.networkID] = nil
		end
		if unit.isMe and buff.name == "katarinarsound" then
			self.R.using = false
			self.R.last  = 0
		end
	end

	function Katarina:Spells(unit, spell)
		if unit.isMe then
			if spell.name == 'KatarinaQ' then
				self.Q.throwing = true
				self.Q.last     = os.clock()
			elseif  self.menu.skills.E.humanizer and spell.name == 'KatarinaE' then
				self.E.last   = os.clock()
				self.E.delay  = self:random(0, self.menu.skills.E.maxdelay, 2)
				self.E.canuse = false
			end
		end
	end

	function Katarina:GetTarget()
		self.ts:update()
        if _G.MMA_Target and _G.MMA_Target.type == myHero.type then 
        	return _G.MMA_Target 
	    elseif _G.AutoCarry and  _G.AutoCarry.Attack_Crosshair and _G.AutoCarry.Attack_Crosshair.target and _G.AutoCarry.Attack_Crosshair.target.type == myHero.type then 
	    	return _G.AutoCarry.Attack_Crosshair.target 
	    elseif self.ts.target and ValidTarget(self.ts.target) then
	    	return self.ts.target
	    end
	end

	function Katarina:LoadPriorityTable()
		--|> This bish is long for sake of cleaness is here
		self.priorityTable = {
			AP = {
				'Annie', 'Ahri', 'Akali', 'Anivia', 'Annie', 'Azir', 'Brand', 'Cassiopeia', 'Diana', 'Evelynn', 'FiddleSticks', 'Fizz', 'Gragas', 'Heimerdinger', 'Karthus',
				'Kassadin', 'Katarina', 'Kayle', 'Kennen', 'Leblanc', 'Lissandra', 'Lux', 'Malzahar', 'Mordekaiser', 'Morgana', 'Nidalee', 'Orianna',
				'Ryze', 'Sion', 'Swain', 'Syndra', 'Teemo', 'TwistedFate', 'Veigar', 'Viktor', 'Vladimir', 'Xerath', 'Ziggs', 'Zyra'
			},
			Support = {
				'Alistar', 'Blitzcrank', 'Braum', 'Janna', 'Karma', 'Leona', 'Lulu', 'Nami', 'Nunu', 'Sona', 'Soraka', 'Taric', 'Thresh', 'Zilean'
			},
			Tank = {
				'Amumu', 'Chogath', 'DrMundo', 'Galio', 'Hecarim', 'Malphite', 'Maokai', 'Nasus', 'Rammus', 'Sejuani', 'Nautilus', 'Shen', 'Singed', 'Skarner', 'Volibear',
				'Warwick', 'Yorick', 'Zac'
			},
			AD_Carry = {
				'Ashe', 'Caitlyn', 'Corki', 'Draven', 'Ezreal', 'Graves', 'Jayce', 'Jinx', 'Kalista', 'KogMaw', 'Lucian', 'MasterYi', 'MissFortune', 'Pantheon', 'Quinn', 'Shaco', 'Sivir',
				'Talon','Tryndamere', 'Tristana', 'Twitch', 'Urgot', 'Varus', 'Vayne', 'Yasuo','Zed'
			},
			Bruiser = {
				'Aatrox', 'Darius', 'Elise', 'Fiora', 'Gnar', 'Gangplank', 'Garen', 'Irelia', 'JarvanIV', 'Jax', 'Khazix', 'LeeSin', 'Nocturne', 'Olaf', 'Poppy',
				'Renekton', 'Rengar', 'Riven', 'RekSai', 'Rumble', 'Shyvana', 'Trundle', 'Udyr', 'Vi', 'MonkeyKing', 'XinZhao'
			}
		}
	end

   
	function Katarina:LoadItemsTable()
		self.items = {
			["BLACKFIRE"]	= { id = 3188, range = 750 },
			["BRK"]			= { id = 3153, range = 500 },
			["BWC"]			= { id = 3144, range = 450 },
			["DFG"]			= { id = 3128, range = 750 },
			["HXG"]			= { id = 3146, range = 700 },
			["ODYNVEIL"]	= { id = 3180, range = 525 },
			["DVN"]			= { id = 3131, range = 200 },
			["ENT"]			= { id = 3184, range = 350 },
			["HYDRA"]		= { id = 3074, range = 350 },
			["TIAMAT"]		= { id = 3077, range = 350 },
			["YGB"]			= { id = 3142, range = 350 }
		}
	end


	function Katarina:SetTablePriorities()
		local table = GetEnemyHeroes()
		if #table == 5 then
			for i, enemy in ipairs(table) do
				self:SetPriority(self.priorityTable.AD_Carry, enemy, 1)
				self:SetPriority(self.priorityTable.AP, enemy, 2)
				self:SetPriority(self.priorityTable.Support, enemy, 3)
				self:SetPriority(self.priorityTable.Bruiser, enemy, 4)
				self:SetPriority(self.priorityTable.Tank, enemy, 5)
			end
		elseif #table == 3 then
			for i, enemy in ipairs(table) do
				self:SetPriority(self.priorityTable.AD_Carry, enemy, 1)
				self:SetPriority(self.priorityTable.AP, enemy, 1)
				self:SetPriority(self.priorityTable.Support, enemy, 2)
				self:SetPriority(self.priorityTable.Bruiser, enemy, 2)
				self:SetPriority(self.priorityTable.Tank, enemy, 3)
			end
		else
			print('Too few champions to arrange priority!')
		end
	end

	function Katarina:SetPriority(table, hero, priority)
		for i = 1, #table do
			if hero.charName:find(table[i]) ~= nil then
				TS_SetHeroPriority(priority, hero.charName)
			end
		end
	end

--|> Spell Class cuz im lazy lul
class 'Spells'

	function Spells:__init(slot, range, name, type, color)
		self.slot   = slot
		self.range  = range
		self.name   = name
		self.type   = type
		self.string = self:SlotToString(slot)
		self.color  = color
	end

	function Spells:Cast(unit)
		if self:Ready() and GetDistance(unit) <= self.range then
			if self.type == 'targeted' then
				CastSpell(self.slot, unit)
			else
				CastSpell(self.slot)
			end
		end
	end

	function Spells:Color()
		return self.color
	end

	function Spells:Damage(target)
		return getDmg(self.string, target, myHero) or 0
	end

	function Spells:Data()
		return myHero:GetSpellData(self.slot)
	end

	function Spells:Range()
		return self.range
	end

	function Spells:Ready()
		return myHero:CanUseSpell(self.slot) == READY
	end

	function Spells:Ready2()
		return self:Data().level > 0 and self:Data().currentCd == 0
	end

	function Spells:Slot()
		return self.slot
	end

	function Spells:SlotToString(slot)
		local strings = { [_Q] = 'Q', [_W] = 'W', [_E] = 'E', [_R] = 'R'}
		return strings[slot]
	end

--[[
--|> Auto Updater
class 'Update'
	function Update:__init(version)
		--|> Script info
		self.version     = version
		self.scriptLink  = "https://raw.githubusercontent.com/SkeemBoL/BoL/master/Katarina%20Rework.lua"
		self.versionLink = "https://raw.githubusercontent.com/SkeemBoL/BoL/master/Katarina%20Rework.version"
		self.path        = SCRIPT_PATH .. _ENV.FILE_NAME

		--|> Variables
		self.needUpdate  = false
		self.ranUpdater  = false

		--|> Callbacks
		AddTickCallback(function () self:Tick() end)
	end

	function Update:Tick()
		if not self.ranUpdater then
			GetAsyncWebResult("raw.github.com" , self.versionLink, function(Data)
 	           local onlineVersion = tonumber(Data)
 	           if onlineVersion and onlineVersion > KatarinaVersion then
 	           		print("<font color=\"#FF0000\">[Nintendo Katarina]:</font> <font color=\"#FFFFFF\">Found Update: </font> <font color=\"#FF0000\">"..KatarinaVersion.." > "..onlineVersion.." Updating... Don't F9!!</font>")
 	           		self.needUpdate = true
 	           end
 	        end)
			self.ranUpdater = true
		end
		if self.needUpdate then
			DownloadFile(self.scriptLink, self.path, function()
                if FileExist(self.path) then
                    print("<font color=\"#FF0000\">[Nintendo Katarina]:</font> <font color=\"#FFFFFF\">updated! Double F9 to use new version!</font>")
                end
            end)
            self.needUpdate = false
		end
	end
]]--

--[[

function Katarina:CheckUpdates()
	host = "www.scarjit.de"
	file = "/Jaikor/BoL/Scripts/Katarina%20-%20Rework.lua"
	name = GetCurrentEnv().FILE_NAME
	versionfilepath = "/Jaikor/BoL/Versions/Katarina.version"
	path = SCRIPT_PATH
	DL = Download()
	DL:downloadUpdate(host, file, name, path, function ()
	print("Downloaded update, press F9 2x to reload")
	end, self.Version, versionfilepath)
end
    
class "Download"
function Download:__init()
	socket = require("socket")
	self.aktivedownloads = {}
	self.callbacks = {}

	AddTickCallback(function ()
		self:RemoveDone()
	end)

	class("Async")
	function Async:__init(host, filepath, localname, drawoffset, localpath)
		self.progress = 0
		self.host = host
		self.filepath = filepath
		self.localname = localname
		self.offset = drawoffset
		self.localpath = localpath
		self.CRLF = '\r\n'

		self.headsocket = socket.tcp()
		self.headsocket:settimeout(1)
		self.headsocket:connect(self.host, 80)
		self.headsocket:send('HEAD '..self.filepath..' HTTP/1.1'.. self.CRLF ..'Host: '..self.host.. self.CRLF ..'User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'.. self.CRLF .. self.CRLF)

		self.HEADdata = ""
		self.DLdata = ""
		self.StartedDownload = false
		self.canDL = true

		AddTickCallback(function ()
			self:tick()
		end)
		AddDrawCallback(function ()
			self:draw()
		end)
	end

	function Async:tick()
		if self.progress == 100 then return end
		if self.HEADcStatus ~= "timeout" and self.HEADcStatus ~= "closed" then
			self.HEADfString, self.HEADcStatus, self.HEADpString = self.headsocket:receive(16);
			if self.HEADfString then
				self.HEADdata = self.HEADdata..self.HEADfString
			elseif self.HEADpString and #self.HEADpString > 0 then
				self.HEADdata = self.HEADdata..self.HEADpString
			end
		elseif self.HEADcStatus == "timeout" then
			self.headsocket:close()
			--Find Lenght
			local begin = string.find(self.HEADdata, "Length: ")
			if begin then
				self.HEADdata = string.sub(self.HEADdata,begin+8)
				local n = 0
				local _break = false
				for i=1, #self.HEADdata do
					local c = tonumber(string.sub(self.HEADdata,i,i))
					if c and _break == false then
						n = n+1
					else
						_break = true
					end
				end
				self.HEADdata = string.sub(self.HEADdata,1,n)
				self.StartedDownload = true
				self.HEADcStatus = "closed"
			end
		end
		if self.HEADcStatus == "closed" and self.StartedDownload == true and self.canDL == true then --Double Check
			self.canDL = false
			self.DLsocket = socket.tcp()
			self.DLsocket:settimeout(1)
			self.DLsocket:connect(self.host, 80)
			--Start Main Download
			self.DLsocket:send('GET '..self.filepath..' HTTP/1.1'.. self.CRLF ..'Host: '..self.host.. self.CRLF ..'User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'.. self.CRLF .. self.CRLF)
		end
		
		if self.DLsocket and self.DLcStatus ~= "timeout" and self.DLcStatus ~= "closed" then
			self.DLfString, self.DLcStatus, self.DLpString = self.DLsocket:receive(1024);
			
			if ((self.DLfString) or (self.DLpString and #self.DLpString > 0)) then
				self.DLdata = self.DLdata .. (self.DLfString or self.DLpString)
			end

		elseif self.DLcStatus and self.DLcStatus == "timeout" then
			self.DLsocket:close()
			self.DLcStatus = "closed"
			self.DLdata = string.sub(self.DLdata,#self.DLdata-tonumber(self.HEADdata)+1)

			local file = io.open(self.localpath.."\\"..self.localname, "w+b")
			file:write(self.DLdata)
			file:close()
			self.progress = 100
		end

		if self.progress ~= 100 and self.DLdata and #self.DLdata > 0 then
			self.progress = (#self.DLdata/tonumber(self.HEADdata))*100
		end
	end

	function Async:draw()
		if self.progress < 100 then
			DrawTextA("Downloading: "..self.localname,15,50,35+self.offset)
			DrawRectangleOutline(49,50+self.offset,250,20, ARGB(255,255,255,255),1)
			if self.progress ~= 100 then
				DrawLine(50,60+self.offset,50+(2.5*self.progress),60+self.offset,18,ARGB(150,255-self.progress*2.5,self.progress*2.5,255-self.progress*2.5))
				DrawTextA(tostring(math.round(self.progress).." %"), 15,150,52+self.offset)
			end
		end
	end

end

function Download:newDL(host, file, name, path, callback)
	local offset = (#self.aktivedownloads+1)*40
	self.aktivedownloads[#self.aktivedownloads+1] = Async(host, file, name, offset-40, path)
	if not callback then
		callback = (function ()
		end)
	end

	self.callbacks[#self.callbacks+1] = callback

end

function Download:RemoveDone()
	if #self.aktivedownloads == 0 then return end
	local x = {}
	local c = {}
	for k, v in pairs(self.aktivedownloads) do
		if math.round(v.progress) < 100 then
			v.offset = k*40-40
			x[#x+1] = v
			c[#c+1] = self.callbacks[k]
		else
			self.callbacks[k]()
			self.callbacks[k] = function ()
				
			end
		end
	end
	self.callbacks = {}
	self.callbacks = c
	self.aktivedownloads = {}
	self.aktivedownloads = x
end

function Download:downloadUpdate(host, file, name, path, _callback,version, versionfilepath)
	function HasUpdate(name,cb)
		function _cb()
			cb()
			DeleteFile(name..".version")
		end
		DelayAction(function ()
			local v = ReadFile(name..".version")
			if v and tonumber(v) > tonumber(version) then
					self:newDL(host, file, name, path, cb)
			end
		end,0.25)
	end
	self:newDL(host,versionfilepath,name..".version",path,function ()
		HasUpdate(name,_callback)
	end)

end
]]--
    
--|> Self Initiation
function OnLoad()
	--|> Superx Said Load OnLoad so Load OnLoad
	--Update(KatarinaVersion)
	Katarina = Katarina()
end
