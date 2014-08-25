if player == nil then player = GetMyHero() end
LIB_PATH = package.path:gsub("?.lua", "") -- spudgy, look at that, and correct please
SCRIPT_PATH = LIB_PATH:gsub("Common\\", "")
SPRITE_PATH = SCRIPT_PATH:gsub("Scripts", "Sprites")

TEAM_ENEMY = (player.team == TEAM_BLUE and TEAM_RED or TEAM_BLUE)

function GetDistance(p1, p2)
	if p2 == nil then p2 = player end
    if p1.z == nil or p2.z == nil then return math.sqrt((p1.x-p2.x)^2+(p1.y-p2.y)^2)
	else return math.sqrt((p1.x-p2.x)^2+(p1.z-p2.z)^2) end
end
-- for compat
GetDistance2D = GetDistance

function ValidTarget(object, distance, enemyTeam)
	local enemyTeam = (enemyTeam ~= false)
    return object ~= nil and (object.team ~= player.team) == enemyTeam and object.visible and not object.dead and object.bTargetable and (enemyTeam == false or object.bInvulnerable == 0) and (distance == nil or GetDistance(object) <= distance)
end

function ValidTargetNear(object, distance, target)
   return object ~= nil and object.team == target.team and object.networkID ~= target.networkID and object.visible and not object.dead and object.bTargetable and GetDistance(target, object) <= distance
end

function GetDistanceFromMouse(object)
	if object ~= nil and VectorType(object) then return GetDistance(object, mousePos) end
	return 100000
end

-- Round a number corrected by surface
function math.round(num, idp)
	assert(type(num) == "number", "math.round: wrong argument types (<number> expected for num)")
	assert(type(idp) == "number" or idp == nil, "math.round: wrong argument types (<integer> expected for idp)")
	local mult = math.floor(10^(idp or 0))
	local value = (num >= 0 and math.floor(num * mult + 0.5) / mult or math.ceil(num * mult - 0.5) / mult)
	return tonumber(string.format("%." .. (idp or 0) .. "f", value))
end

if math.close == nil then
	function math.close(a,b,eps)
		assert(type(a) == "number" and type(b) == "number", "math.close: wrong argument types (at least 2 <number> expected)")
		eps = eps or 1e-9
		return math.abs(a - b) <= eps
	end
end

-- return true if file exist
function file_exists(name)
	assert(type(name) == "string", "file_exists: wrong argument types (<string> expected for name)")
	local f=io.open(name,"r")
	if f~=nil then io.close(f) return true else return false end
end

-- return if cursor is under a rectangle
function CursorIsUnder(x, y, sizeX, sizeY)
	assert(type(x) == "number" and type(y) == "number" and type(sizeX) == "number", "CursorIsUnder: wrong argument types (at least 3 <number> expected)")
	local posX, posY = GetCursorPos().x, GetCursorPos().y
	if sizeY == nil then sizeY = sizeX end
	if sizeX < 0 then
		x = x + sizeX
		sizeX = - sizeX
	end
	if sizeY < 0 then
		y = y + sizeY
		sizeY = - sizeY
	end
	return (posX >= x and posX <= x + sizeX and posY >= y and posY <= y + sizeY)
end

--return texted version of a timer
function TimerText(seconds, len)
	if type(seconds) ~= "number" or seconds > 100000 or seconds < 0 then return " ? " end
	local minutes = seconds / 60
	local returnText
	if minutes >= 60 then
		returnText = string.format("%i:%02i:%02i", minutes / 60, minutes, seconds % 60)
	elseif minutes >= 1 then
		returnText = string.format("%i:%02i", minutes, seconds % 60)
	else
		returnText = string.format(":%02i", seconds % 60)
	end
	if len ~= nil then
		while string.len(returnText) < len do
			returnText = " "..returnText.." "
		end
	end
	return returnText
end
-- for compat
timerText = TimerText

-- return sprite
function GetSprite(file, altFile)
	assert(type(file) == "string", "GetSprite: wrong argument types (<string> expected for file)")
	if file_exists(SPRITE_PATH..file) == true then
		return createSprite(file)
	else
		if altFile ~= nil and file_exists(SPRITE_PATH..altFile) == true then
			return createSprite(altFile)
		else
			PrintChat(file.." not found (sprites installed ?)")
			return createSprite("empty.dds")
		end
	end
end
returnSprite = GetSprite

-- return real hero leveled
function GetHeroLeveled()
	return player:GetSpellData(SPELL_1).level + player:GetSpellData(SPELL_2).level + player:GetSpellData(SPELL_3).level + player:GetSpellData(SPELL_4).level
end

-- return if target have particule
function TargetHaveParticle(particle, target, range)
	assert(type(particle) == "string", "TargetHaveParticule: wrong argument types (<string> expected for particle)")
	local target = target or player
	local range = range or 50
	for i = 1, objManager.maxObjects do
		local object = objManager:GetObject(i)
		if object ~= nil and object.name == particle and GetDistance(target,object) < range then return true end
	end
	return false
end

-- return if target have buff
function TargetHaveBuff(buffName, target)
	assert(type(buffName) == "string" or type(buffName) == "table", "TargetHaveBuff: wrong argument types (<string> or <table of string> expected for buffName)")
	local target = target or player
	for i = 1, target.buffCount do
		local tBuff = target:getBuff(i)
		if type(tBuff) ~= "nil" then
			if type(buffName) == "string" then
				if type(tBuff) == "string" then 
					if tBuff == buffName then return true end
				else
					if (tBuff.name == buffName and tBuff.valid) then return true end
				end
			else
				for j,sBuff in ipairs(buffName) do
					if type(tBuff) == "string" then 
						if tBuff == sBuff then return true end
					else
						if (tBuff.name == sBuff and tBuff.valid) then return true end
					end
				end
			end
		end
	end
	return false
end

-- return number of enemy in range
function CountEnemyHeroInRange(range)
	local enemyInRange = 0
	for i = 1, heroManager.iCount, 1 do
		local hero = heroManager:getHero(i)
		if ValidTarget(hero,range) then
			enemyInRange = enemyInRange + 1
		end
	end
	return enemyInRange
end

--[[
        Class: Vector

		API :
		---- functions ----
		VectorType(v)							-- return if as vector
		VectorIntersection(a1,b1,a2,b2)			-- return the Intersection of 2 lines
		VectorDirection(v1,v2,v)
		VectorPointProjectionOnLine(v1, v2, v)  -- return a vector on line v1-v2 closest to v
		Vector(a,b,c)							-- return a vector from x,y,z pos or from another vector
		
		---- Vector Members ----
		x
		y
		z
		
		---- Vector Functions ----
		vector:clone()							-- return a new Vector from vector
		vector:unpack()							-- x, z
		vector:len2()							-- return vector^2
		vector:len2(v)							-- return vector^v
		vector:len()							-- return vector length
		vector:dist(v)							-- distance between 2 vectors (v and vector)
		vector:normalize()						-- normalize vector
		vector:normalized()						-- return a new Vector normalize from vector
		vector:rotate(phiX, phiY, phiZ)			-- rotate the vector by phi angle
		vector:rotated(phiX, phiY, phiZ)		-- return a new Vector rotate from vector by phi angle
		vector:projectOn(v)						-- return a new Vector from vector projected on v
		vector:mirrorOn(v)						-- return a new Vector from vector mirrored on v
		vector:center(v)						-- return center between vector and v

		vector:polar()							-- return the angle from axe
		vector:angleBetween(v1, v2)				-- return the angle formed from vector to v1,v2
		vector:compare(v)						-- compare vector and v
		vector:perpendicular()					-- return new Vector rotated 90° rigth
		vector:perpendicular2()					-- return new Vector rotated 90° left
]]

-- STAND ALONE FUNCTIONS
function VectorType(v)
	return (v ~= nil and (type(v) == "Vector" or (type(v.x) == "number" and (type(v.y) == "number" or type(v.z) == "number"))))
end

function VectorIntersection(a1,b1,a2,b2)
	assert(VectorType(a1) and VectorType(b1) and VectorType(a2) and VectorType(b2), "VectorIntersection: wrong argument types (4 <Vector> expected)")
	if math.close(b1.x, 0) and math.close(b2.z, 0) then return Vector(a1.x, a2.z) end
	if math.close(b1.z, 0) and math.close(b2.x, 0) then return Vector(a2.x, a1.z) end
	local m1 = (not math.close(b1.x, 0)) and b1.z / b1.x or 0
	local m2 = (not math.close(b2.x, 0)) and b2.z / b2.x or 0
	if math.close(m1, m2) then return nil end
	local c1 = a1.z - m1 * a1.x
	local c2 = a2.z - m2 * a2.x
	local ix = (c2 - c1) / (m1 - m2)
	local iy = m1 * ix + c1
	if math.close(b1.x, 0) then return Vector(a1.x, a1.x * m2 + c2) end
	if math.close(b2.x, 0) then return Vector(a2.x, a2.x * m1 + c1) end
	return Vector(ix, iy)
end

function VectorDirection(v1,v2,v)
	assert(VectorType(v1) and VectorType(v2) and VectorType(v), "VectorDirection: wrong argument types (3 <Vector> expected)")
	return (v1.x - v2.x) * (v.z - v2.z) - (v.x - v2.x) * (v1.z - v2.z)
end

function VectorPointProjectionOnLine(v1, v2, v)
	assert(VectorType(v1) and VectorType(v2) and VectorType(v), "VectorPointProjectionOnLine: wrong argument types (3 <Vector> expected)")
	local line = Vector(v2) - v1
	local t = ((-(v1.x * line.x - line.x * v.x + (v1.z - v.z) * line.z)) / line:len2())
	return (line * t) + v1
end

class 'Vector'
-- INSTANCED FUNCTIONS
function Vector:__init(a,b,c)
	if a == nil then
		self.x, self.y, self.z = 0.0, 0.0, 0.0
	elseif b == nil then
		assert(VectorType(a), "Vector: wrong argument types (expected nil or <Vector> or 2 <number> or 3 <number>)")
		self.x, self.y, self.z = a.x, a.y or 0.0, a.z or 0.0
	elseif c == nil then
		assert(type(a) == "number" and type(b) == "number", "Vector: wrong argument types (expected nil or <Vector> or 2 <number> or 3 <number>)")
		-- TODO !! set y, not z !!! Only there because we were wrong first !
		self.x, self.y, self.z = a, 0.0, b
	else
		assert(type(a) == "number" and type(b) == "number" and type(c) == "number", "Vector: wrong argument types (expected nil or <Vector> or 2 <number> or 3 <number>)")
		self.x, self.y, self.z = a, b, c
	end
end

function Vector:__type()
	return "Vector"
end

function Vector:__add(v)
	assert(VectorType(v), "add: wrong argument types (<Vector> expected)")
	return Vector(self.x + v.x, self.y + (v.y or 0), self.z + (v.z or 0))
end

function Vector:__sub(v)
	assert(VectorType(v), "Sub: wrong argument types (<Vector> expected)")
	return Vector(self.x - v.x, self.y - (v.y or 0), self.z - (v.z or 0))
end

function Vector:__mul(v)
	if type(v) == "number" then
		return Vector(self.x * v, self.y * v, self.z * v)
	else
		assert(VectorType(v), "Mul: wrong argument types (<Vector> or <number> expected)")
		return Vector(self.x * v.x, self.y * (v.y ~= nil and v.y or 1), self.z * (v.z ~= nil and v.z or 1))
	end
end

function Vector:__div(v)
	if type(v) == "number" then
		return Vector(self.x / (v or 1), self.y / (v or 1), self.z / (v or 1))
	else
		assert(VectorType(v), "Div: wrong argument types (<Vector> or <number> expected)")
		return Vector(self.x / (v.x or 1), self.y / (v.y or 1), self.z / (v.z or 1))
	end
end
-- TODO
function Vector:__lt(v)
	assert(VectorType(v), "__lt: wrong argument types (<Vector> expected)")
	if self.x < v.x then return true end
	if (v.y ~= nil and self.y < v.y) then return true end
	if (v.z ~= nil and self.z < v.z) then return true end
	return false
end
-- TODO
function Vector:__le(v)
	assert(VectorType(v), "__le: wrong argument types (<Vector> expected)")
	return self.x <= v.x and (v.y == nil or self.y <= v.y) and (v.z == nil or self.z <= v.z)
end

function Vector:__eq(v)
	assert(VectorType(v), "__eq: wrong argument types (<Vector> expected)")
	return self.x == v.x  and self.y == (v.y or 0) and self.z == (v.z or 0)
end

function Vector:__unm()
	return Vector(-self.x, -self.y, -self.z)
end

function Vector:__vector(v)
	assert(VectorType(v), "__vector: wrong argument types (<Vector> expected)")
	local x = self.y * (v.z or 1) - self.z * (v.y or 1)
	local y = self.z * v.x - self.x * (v.z or 1)
	local z = self.x * (v.y or 1) - self.y * v.x
	return Vector(self.y * (v.z or 1) - self.z * (v.y or 1), self.z * v.x - self.x * (v.z or 1), self.x * (v.y or 1) - self.y * v.x)
end

function Vector:__tostring()
	return "("..tostring(self.x)..","..tostring(self.y)..","..tostring(self.z)..")"
end

function Vector:clone()
	return Vector(self)
end

function Vector:unpack()
	return self.x, self.y, self.z
end

function Vector:len2(v)
	assert(v == nil or VectorType(v), "dist: wrong argument types (<Vector> expected)")
	local v = v and Vector(v) or self
	return self.x * v.x + self.y * v.y + self.z * v.z
end
function Vector:len()
	return math.sqrt(self:len2())
end

function Vector:dist(v)
	assert(VectorType(v), "dist: wrong argument types (<Vector> expected)")
	local a = self - v
	return a:len()
end

function Vector:normalize()
	self = self / self:len()
end

function Vector:normalized()
	local a = self:clone()
	a:normalize()
	return a
end

function Vector:center(v)
	assert(VectorType(v), "center: wrong argument types (<Vector> expected)")
	return Vector((self + v) / 2)
end

function Vector:projectOn(v)
	assert(VectorType(v), "projectOn: invalid argument: cannot project Vector on " .. type(v))
	if type(v) ~= "Vector" then v = Vector(v) end
	local s = self:len2(v) / v:len2()
	return Vector(v * s)
end

function Vector:mirrorOn(v)
	assert(VectorType(v), "mirrorOn: invalid argument: cannot mirror Vector on " .. type(v))
	return self:projectOn(v) * 2
end

function Vector:sin(v)
	assert(VectorType(v), "sin: wrong argument types (<Vector> expected)")
	if type(v) ~= "Vector" then v = Vector(v) end
	local a = self:__vector(v)
	return math.sqrt(a:len2() / (self:len2() * v:len2()))
end

function Vector:cos(v)
	assert(VectorType(v), "cos: wrong argument types (<Vector> expected)")
	if type(v) ~= "Vector" then v = Vector(v) end
	return self:len2(v) / math.sqrt(self:len2() * v:len2())
end

function Vector:angle(v)
	assert(VectorType(v), "angle: wrong argument types (<Vector> expected)")
	return math.acos(self:cos(v))
end

function Vector:affineArea(v)
	assert(VectorType(v), "affineArea: wrong argument types (<Vector> expected)")
	if type(v) ~= "Vector" then v = Vector(v) end
	local a = self:__vector(v)
	return math.sqrt(a:len2())
end

function Vector:triangleArea(v)
	assert(VectorType(v), "triangleArea: wrong argument types (<Vector> expected)")
	return self:affineArea(v) / 2
end

function Vector:rotateXaxis(phi)
	assert(type(phi) == "number", "Rotate: wrong argument types (expected <number> for phi)")
	local c, s = math.cos(phi), math.sin(phi)
	self.y, self.z = self.y * c - self.z * s, self.z * c + self.y * s
end

function Vector:rotateYaxis(phi)
	assert(type(phi) == "number", "Rotate: wrong argument types (expected <number> for phi)")
	local c, s = math.cos(phi), math.sin(phi)
	self.x, self.z = self.x * c + self.z * s, self.z * c - self.x * s
end

function Vector:rotateZaxis(phi)
	assert(type(phi) == "number", "Rotate: wrong argument types (expected <number> for phi)")
	local c, s = math.cos(phi), math.sin(phi)
	self.x, self.y = self.x * c - self.z * s, self.y * c + self.x * s
end

-- TODO
function Vector:rotate(phiX, phiY, phiZ)
	assert(type(phiX) == "number" and type(phiY) == "number" and type(phiZ) == "number", "Rotate: wrong argument types (expected <number> for phi)")
	if phiX ~= 0 then self:rotateXaxis(phiX) end
	if phiY ~= 0 then self:rotateYaxis(phiY) end
	if phiZ ~= 0 then self:rotateZaxis(phiZ) end
end

function Vector:rotated(phiX, phiY, phiZ)
	assert(type(phiX) == "number" and type(phiY) == "number" and type(phiZ) == "number", "Rotated: wrong argument types (expected <number> for phi)")
	local a = self:clone()
	a:rotate(phiX, phiY, phiZ)
	return a
end




-- not yet full 3D functions

function Vector:polar()
	if math.close(self.x, 0) then
		if self.z > 0 then return 90
		elseif self.z < 0 then return 270
		else return 0
		end
	else
		local theta = math.deg(math.atan(self.z / self.x))
		if self.x < 0 then theta = theta + 180 end
		if theta < 0 then theta = theta + 360 end
		return theta
	end
end

function Vector:angleBetween(v1, v2)
	assert(VectorType(v1) and VectorType(v2), "angleBetween: wrong argument types (2 <Vector> expected)")
	local p1, p2 = (-self + v1), (-self + v2)
	local theta = p1:polar() - p2:polar()
	if theta < 0 then theta = theta + 360 end
	if theta > 180 then theta = 360 - theta end
	return theta
end

function Vector:compare(v)
	assert(VectorType(v), "compare: wrong argument types (<Vector> expected)")
	local ret = self.x - v.x
	if ret == 0 then ret = self.z - v.z	end
	return ret
end

function Vector:perpendicular()
	return Vector(-self.z, self.y, self.x)
end

function Vector:perpendicular2()
	return Vector(self.z, self.y, -self.x)
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Circle Class

--[[
Circle Class :
Methods:
circle = Circle(center (opt),radius (opt))

Function :
circle:Contains(v)		-- return if Vector point v is in the circle

Members :
circle.center		-- Vector point for circle's center
circle.radius			-- radius of the circle
]]

class 'Circle'

function Circle:__init(center,radius)
	assert((VectorType(center) or center == nil) and (type(radius) == "number" or radius == nil), "Circle: wrong argument types (expected <Vector> or nil, <number> or nil)")
	self.center = Vector(center) or Vector()
	self.radius = radius or 0
end

function Circle:Contains(v)
	assert(VectorType(v), "Contains: wrong argument types (expected <Vector>)")
	return math.close(self.center:dist(v),self.radius)
end

function Circle:__tostring()
	return "{center: " .. tostring(self.center) .. ", radius: " .. tostring(self.radius) .. "}"
end


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Minimum Enclosing Circle class
--[[
Global function ;
GetMEC(R, range) 					-- Find Group Center From Nearest Enemies
GetMEC(R, range, target) 			-- Find Group Center Near Target

MEC Class :
Methods:
mec = MEC(points (opt))

Function :
mec:SetPoints(points)
mec:HalfHull(left, right, pointTable, factor)		-- return table
mec:ConvexHull()						-- return table
mec:Compute()

Members :
mec.circle
mec.points
]]

class 'MEC'

function MEC:__init(points)
	self.circle = Circle()
	self.points = {}
	if points then
		self:SetPoints(points)
	end
end

function MEC:SetPoints(points)
	-- Set the points
	self.points = {}
	for i, p in ipairs(points) do
		table.insert(self.points, Vector(p))
	end
end

function MEC:HalfHull(left, right, pointTable, factor)
	-- Computes the half hull of a set of points
	local input = pointTable
	table.insert(input, right)
	local half = {}
	table.insert(half, left)
	for i,p in ipairs(input) do
		table.insert(half, p)
		while #half >= 3 do
			local dir = factor * VectorDirection(half[(#half+1)-3], half[(#half+1)-1], half[(#half+1)-2])
			if dir <= 0 then
				table.remove(half,#half-1)
			else
				break
			end
		end
	end
	return half
end

function MEC:ConvexHull()
	-- Computes the set of points that represent the convex hull of the set of points
	local left, right = self.points[1], self.points[#self.points]
	local upper, lower, ret = {}, {}, {}
	-- Partition remaining points into upper and lower buckets.
	for i = 2, #self.points-1 do
		if VectorType(self.points[i]) == false then PrintChat("self.points[i]") end
		table.insert((VectorDirection(left, right, self.points[i]) < 0 and upper or lower), self.points[i])
	end
	local upperHull = self:HalfHull(left, right, upper, -1)
	local lowerHull = self:HalfHull(left, right, lower, 1)
	local unique = {}
	for i,p in ipairs(upperHull) do
		unique["x" .. p.x .. "z" .. p.z] = p 
	end
	for i,p in ipairs(lowerHull) do
		unique["x" .. p.x .. "z" .. p.z] = p
	end
	for i,p in pairs(unique) do
		table.insert(ret, p)
	end
	return ret
end

function MEC:Compute()
	-- Compute the MEC.
	-- Make sure there are some points.
	if #self.points == 0 then return nil end
	-- Handle degenerate cases first
	if #self.points == 1 then
		self.circle.center = self.points[1]
		self.circle.radius = 0
		self.circle.radiusPoint = self.points[1]
	elseif #self.points == 2 then
		local a = self.points
		self.circle.center = a[1]:center(a[2])
		self.circle.radius = a[1]:dist(self.circle.center)
		self.circle.radiusPoint = a[1]
	else
		local a = self:ConvexHull()
		local point_a = a[1]
		local point_b = nil
		local point_c = a[2]
		if not point_c then
			self.circle.center = point_a
			self.circle.radius = 0
			self.circle.radiusPoint = point_a
			return self.circle
		end
		-- Loop until we get appropriate values for point_a and point_c
		while true do
			point_b = nil
			local best_theta = 180.0
			-- Search for the point "b" which subtends the smallest angle a-b-c. 
			for i,point in ipairs(self.points) do
				if (not point == point_a) and (not point == point_c) then
					local theta_abc = point:angleBetween(point_a, point_c)
					if theta_abc < best_theta then
						point_b = point
						best_theta = theta_abc
					end                             
				end
			end
			-- If the angle is obtuse, then line a-c is the diameter of the circle,
			-- so we can return.
			if best_theta >= 90.0 or (not point_b) then
				self.circle.center = point_a:center(point_c)
				self.circle.radius = point_a:dist(self.circle.center)
				self.circle.radiusPoint = point_a
				return self.circle
			end
			local ang_bca = point_c:angleBetween(point_b, point_a)
			local ang_cab = point_a:angleBetween(point_c, point_b)
			if ang_bca > 90.0 then
				point_c = point_b
			elseif ang_cab <= 90.0 then
				break
			else
				point_a = point_b
			end
		end
		local ch1 = (point_b - point_a) * 0.5
		local ch2 = (point_c - point_a) * 0.5
		local n1 = ch1:perpendicular2()
		local n2 = ch2:perpendicular2()
		ch1 = point_a + ch1
		ch2 = point_a + ch2
		self.circle.center = VectorIntersection(ch1, n1, ch2, n2)
		self.circle.radius = self.circle.center:dist(point_a)
		self.circle.radiusPoint = point_a
	end
	return self.circle
end

function GetMEC(radius, range, target)
    assert(type(radius) == "number" and type(range) == "number" and (target == nil or target.team ~= nil), "GetMEC: wrong argument types (expected <number>, <number>, <object> or nil)")
	local points = {}
    for i = 1, heroManager.iCount do
        local object = heroManager:GetHero(i)
		if (target == nil and ValidTarget(object,(range + radius))) or (target and ValidTarget(object,(range + radius), (target.team~=player.team)) and (ValidTargetNear(object,radius*2,target) or object.networkID == target.networkID)) then
			table.insert(points, Vector(object))
		end
    end
    return _CalcSpellPosForGroup(radius,range,points)
end

function _CalcSpellPosForGroup(radius, range, points)
    if #points == 0 then
		return nil
	elseif #points == 1 then
        return Circle(Vector(points[1]))
    end
	local mec = MEC()
	local combos = {}
    for j = #points,2,-1 do
		local spellPos = nil
		combos[j] = {}
        _CalcCombos(j,points,combos[j])
        for i,v in ipairs(combos[j]) do
			mec:SetPoints(v)
            local c = mec:Compute()
            if c~= nil and c.radius <= radius and c.center:dist(player) <= range and (spellPos == nil or c.radius < spellPos.radius) then
                spellPos = Circle(c.center, c.radius)
            end
        end
        if spellPos ~= nil then return spellPos end
    end
end

function _CalcCombos(comboSize,targetsTable,comboTableToFill,comboString,index_number)
    local comboString = comboString or ""
	local index_number = index_number or 1
	if string.len(comboString) == comboSize then
        local b = {}
        for i=1,string.len(comboString),1 do
            local ai = tonumber(string.sub(comboString,i,i))
            table.insert(b,targetsTable[ai])
        end
        return table.insert(comboTableToFill,b)
    end
    for i = index_number, #targetsTable, 1 do
        _CalcCombos(comboSize,targetsTable,comboTableToFill, comboString..i, i+1)
    end
end

-- for compat
FindGroupCenterFromNearestEnemies = GetMEC
function FindGroupCenterNearTarget(target,radius,range)
	return GetMEC(radius, range, target)
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TargetSelector Class

--[[
TargetSelector Class :
Methods:
ts = TargetSelector(mode, range, damageType (opt), targetSelected (opt), enemyTeam (opt))

Goblal Functions :
TS_Print(enemyTeam (opt))			-> print Priority (global)

TS_SetFocus() 			-> set priority to the selected champion (you need to use PRIORITY modes to use it) (global)
TS_SetFocus(id)			-> set priority to the championID (you need to use PRIORITY modes to use it) (global)
TS_SetFocus(charName, enemyTeam (opt))	-> set priority to the champion charName (you need to use PRIORITY modes to use it) (global)
TS_SetFocus(hero) 		-> set priority to the hero object (you need to use PRIORITY modes to use it) (global)

TS_SetHeroPriority(priority, target, enemyTeam (opt))					-> set the priority to target
TS_SetPriority(target1, target2, target3, target4, target5) 	-> set priority in order to enemy targets
TS_SetPriorityA(target1, target2, target3, target4, target5) 	-> set priority in order to ally targets

TS_GetPriority(target, enemyTeam)		-> return the current priority, and the max allowed

TargetSelector__OnSendChat(msg) 			-- to add to OnSendChat(msg) function if you want the chat command

Functions :
ts:update() 											-- update the instance target
ts:SetDamages(magicDmgBase, physicalDmgBase, trueDmg)	

ts:SetPrediction()							-- prediction off
ts:SetPrediction(delay)						-- predict movement for champs (need Prediction__OnTick())
ts:SetMinionCollision()						-- minion colission off
ts:SetMinionCollision(spellWidth)			-- avoid champ if minion between player
ts:SetConditional()							-- erase external function use
ts:SetConditional(func)						-- set external function that return true/false to allow filter -- function(hero, index (opt))
ts:SetProjectileSpeed(pSpeed)				-- set projectile speed (need Prediction__OnTick())

Members:
ts.mode 					-> TARGET_LOW_HP, TARGET_MOST_AP, TARGET_MOST_AD, TARGET_PRIORITY, TARGET_NEAR_MOUSE, TARGET_LOW_HP_PRIORITY, TARGET_LESS_CAST, TARGET_LESS_CAST_PRIORITY
ts.range 					-> number > 0
ts.targetSelected 		-> true/false
ts.target 					-> return the target (object or nil)
ts.index 		-> index of target (if hero)
ts.nextPosition -> nextPosition predicted
ts.nextHealth 		-> nextHealth predicted

Usage :
variable = TargetSelector(mode, range, damageType (opt), targetSelected (opt), enemyTeam (opt))
targetSelected is set to true if not filled
Damages are set as default to magic 100 if none is set
enemyTeam is false if ally, nil or true if enemy

when you want to update, call variable:update()

Values you can change on instance :
variable.mode -> TARGET_LOW_HP, TARGET_MOST_AP, TARGET_PRIORITY, TARGET_NEAR_MOUSE, TARGET_LOW_HP_PRIORITY, TARGET_LESS_CAST, TARGET_LESS_CAST_PRIORITY
variable.range -> number > 0
variable.targetSelected -> true/false (if you clicked on a champ)


ex :
function OnLoad()
	ts = TargetSelector(TARGET_LESS_CAST, 600, DAMAGE_MAGIC, true)
end

function OnTick()
	ts:update()
	if ts.target ~= nil then
		PrintChat(ts.target.charName)
		ts:SetDamages((player.ap * 10), 0, 0)
	end
end

function OnSendChat(msg)
	TargetSelector__OnSendChat(msg)
end

]]

-- Class related constants
TARGET_LOW_HP = 1
TARGET_MOST_AP = 2
TARGET_MOST_AD = 3
TARGET_LESS_CAST = 4
TARGET_NEAR_MOUSE = 5
TARGET_PRIORITY = 6
TARGET_LOW_HP_PRIORITY = 7
TARGET_LESS_CAST_PRIORITY = 8
DAMAGE_MAGIC = 1
DAMAGE_PHYSICAL = 2

-- Class related global
_gameHeros, _gameAllyCount, _gameEnemyCount = {}, 0, 0
_TargetSelector__texted = {"LowHP", "MostAP", "MostAD", "LessCast", "NearMouse", "Priority", "LowHPPriority", "LessCastPriority"}

-- Class related function
function _gameHeros__init()
	if #_gameHeros == 0 then
		_gameAllyCount, _gameEnemyCount = 0, 0
		for i = 1, heroManager.iCount do
			local hero = heroManager:getHero(i)
			if hero ~= nil then
				if hero.team == player.team then
					_gameAllyCount = _gameAllyCount + 1
					table.insert(_gameHeros, {hero = hero, index = i, tIndex = _gameAllyCount, ignore = false, priority = 1, enemy = false})
				else
					_gameEnemyCount = _gameEnemyCount + 1
					table.insert(_gameHeros, {hero = hero, index = i, tIndex = _gameEnemyCount, ignore = false, priority = 1, enemy = true})
				end
			end
		end
	end
end

function _gameHeros__extended(target, assertText)
	local assertText = assertText or ""
	if type(target) == "number" then
		return _gameHeros[target]
	elseif target ~= nil then
		assert(type(target.networkID) == "number", assertText..": wrong argument types (<charName> or <heroIndex> or <hero> expected)")
		for index,_gameHero in ipairs(_gameHeros) do
			if _gameHero.hero.networkID == target.networkID then
				return _gameHero
			end
		end 
	end
end

function _gameHeros__hero(target, assertText, enemyTeam)
	local assertText = assertText or ""
	enemyTeam = (enemyTeam ~= false)
	if type(target) == "string" then
		for index,_gameHero in ipairs(_gameHeros) do
			if _gameHero.hero.charName == target and (_gameHero.hero.team ~= player.team) == enemyTeam then
				return _gameHero.hero
			end
		end
	elseif type(target) == "number" then
		return heroManager:getHero(target)
	elseif target == nil then
		return GetTarget()
	else
		assert(type(target.networkID) == "number", assertText..": wrong argument types (<charName> or <heroIndex> or <hero> or nil expected)")
		return target
	end
end

function _gameHeros__index(target, assertText, enemyTeam)
	local assertText = assertText or ""
	local enemyTeam = (enemyTeam ~= false)
	if type(target) == "string" then
		for index,_gameHero in ipairs(_gameHeros) do
			if _gameHero.hero.charName == target and (_gameHero.hero.team ~= player.team) == enemyTeam then
				return _gameHero.index
			end
		end
	elseif type(target) == "number" then
		return target
	else
		assert(type(target.networkID) == "number", assertText..": wrong argument types (<charName> or <heroIndex> or <hero> or nil expected)")
		return _gameHeros__index(target.charName, assertText, (target.team ~= player.team))
	end
end

function TS_Print(enemyTeam)
	local enemyTeam = (enemyTeam ~= false)
	for i, target in ipairs(_gameHeros) do
        if target.hero ~= nil and target.enemy == enemyTeam then
            PrintChat("[TS] "..(enemyTeam and "Enemy " or "Ally ")..target.tIndex.." ("..target.index..") : " .. target.hero.charName .. " Mode=" .. (target.ignore and "ignore" or "target") .." Priority=" .. target.priority)
        end
    end
end

function TS_SetFocus(target, enemyTeam)
	local enemyTeam = (enemyTeam ~= false)
	local selected = _gameHeros__hero(target, "TS_SetFocus")
	if selected ~= nil and selected.type == "obj_AI_Hero" and (selected.team ~= player.team) == enemyTeam then
		for index,_gameHero in ipairs(_gameHeros) do
			if _gameHero.enemy == enemyTeam then
				if _gameHero.hero.networkID == selected.networkID then
					_gameHero.priority = 1
					PrintChat("[TS] Focusing " .. _gameHero.hero.charName)
				else
					_gameHero.priority = (enemyTeam and _gameEnemyCount or _gameAllyCount)
				end
			end
		end
	end
end

function TS_SetHeroPriority(priority, target, enemyTeam)
	local enemyTeam = (enemyTeam ~= false)
	local heroCount = (enemyTeam and _gameEnemyCount or _gameAllyCount)
	assert(type(priority) == "number" and priority >= 0 and priority <= heroCount, "TS_SetHeroPriority: wrong argument types (<number> 1 to "..heroCount.." expected)")
	local selected = _gameHeros__index(target, "TS_SetHeroPriority: wrong argument types (<charName> or <heroIndex> or <hero> or nil expected)", enemyTeam)
	if selected ~= nil then
		local oldPriority = _gameHeros[selected].priority
		if oldPriority == nil or oldPriority == priority then return end
		for index,_gameHero in ipairs(_gameHeros) do
			if _gameHero.enemy == enemyTeam then
				if index == selected then
					_gameHero.priority = priority
					--PrintChat("[TS] "..(enemyTeam and "Enemy " or "Ally ").._gameHero.tIndex.." (".._gameHero.index..") : " .. _gameHero.hero.charName .. " Mode=" .. (_gameHero.ignore and "ignore" or "target") .." Priority=" .. _gameHero.priority)
				end
			end
		end
	end
end

function TS_SetPriority(target1, target2, target3, target4, target5)
	assert((target5 ~= nil and _gameEnemyCount == 5) or (target4 ~= nil and _gameEnemyCount < 5) or (target3 ~= nil and _gameEnemyCount == 3) or (target2 ~= nil and _gameEnemyCount == 2) or (target1 ~= nil and _gameEnemyCount == 1), "TS_SetPriority: wrong argument types (".._gameEnemyCount.." <target> expected)")
	TS_SetHeroPriority(1, target1)
	TS_SetHeroPriority(2, target2)
	TS_SetHeroPriority(3, target3)
	TS_SetHeroPriority(4, target4)
	TS_SetHeroPriority(5, target5)
end

function TS_SetPriorityA(target1, target2, target3, target4, target5)
	assert((target5 ~= nil and _gameAllyCount == 5) or (target4 ~= nil and _gameAllyCount < 5) or (target3 ~= nil and _gameAllyCount == 3) or (target2 ~= nil and _gameAllyCount == 2) or (target1 ~= nil and _gameAllyCount == 1), "TS_SetPriorityA: wrong argument types (".._gameAllyCount.." <target> expected)")
	TS_SetHeroPriority(1, target1, false)
	TS_SetHeroPriority(2, target2, false)
	TS_SetHeroPriority(3, target3, false)
	TS_SetHeroPriority(4, target4, false)
	TS_SetHeroPriority(5, target5, false)
end

function TS_GetPriority(target, enemyTeam)
	local enemyTeam = (enemyTeam ~= false)
	local index = _gameHeros__index(target, "TS_GetPriority", enemyTeam)
	return (index and _gameHeros[index].priority or nil), (enemyTeam and _gameEnemyCount or _gameAllyCount)
end

function TS_Ignore(target, enemyTeam)
	local enemyTeam = (enemyTeam ~= false)
	local selected = _gameHeros__hero(target, "TS_Ignore")
	if selected ~= nil and selected.type == "obj_AI_Hero" and (selected.team ~= player.team) == enemyTeam then
		for index,_gameHero in ipairs(_gameHeros) do
			if _gameHero.hero.networkID == selected.networkID and _gameHero.enemy == enemyTeam then
				_gameHero.ignore = not _gameHero.ignore
				--PrintChat("[TS] "..(_gameHero.ignore and "Ignoring " or "Re-targetting ").._gameHero.hero.charName)
				break
			end
		end
	end
end

function _TS_Draw_Init()
	if not _TS_Draw then
		UpdateWindow()
		_TS_Draw = {y1 = 0, heigth = 0, fontSize = WINDOW_H and math.round(WINDOW_H / 54) or 14, width = WINDOW_W and math.round(WINDOW_W / 4.8) or 213, border = 2, background = 1413167931, textColor = 4290427578, redColor = 1422721024, greenColor = 1409321728, blueColor = 2684354716}
		_TS_Draw.cellSize, _TS_Draw.midSize, _TS_Draw.row1, _TS_Draw.row2, _TS_Draw.row3, _TS_Draw.row4 = _TS_Draw.fontSize + _TS_Draw.border, _TS_Draw.fontSize / 2, _TS_Draw.width * 0.6, _TS_Draw.width * 0.7, _TS_Draw.width * 0.8, _TS_Draw.width * 0.9
	end
end

function TS__DrawMenu(x, y, enemyTeam)
	assert(type(x) == "number" and type(y) == "number", "TS__DrawMenu: wrong argument types (<number>, <number> expected)")
	_TS_Draw_Init()
	local enemyTeam = (enemyTeam ~= false)
	local y1 = y
	for index,_gameHero in ipairs(_gameHeros) do
		if _gameHero.enemy == enemyTeam then
			DrawLine(x - _TS_Draw.border, y1 + _TS_Draw.midSize, x + _TS_Draw.row1 - _TS_Draw.border, y1 + _TS_Draw.midSize, _TS_Draw.cellSize, (_gameHero.ignore and _TS_Draw.redColor or _TS_Draw.background))
			DrawText(_gameHero.hero.charName, _TS_Draw.fontSize, x, y1, _TS_Draw.textColor)
			DrawLine(x + _TS_Draw.row1, y1 + _TS_Draw.midSize, x + _TS_Draw.row2 - _TS_Draw.border, y1 + _TS_Draw.midSize, _TS_Draw.cellSize, _TS_Draw.background)
			DrawText("   "..(_gameHero.ignore and "-" or tostring(_gameHero.priority)), _TS_Draw.fontSize, x + _TS_Draw.row1, y1, _TS_Draw.textColor)
			DrawLine(x + _TS_Draw.row2, y1 + _TS_Draw.midSize, x + _TS_Draw.row3 - _TS_Draw.border, y1 + _TS_Draw.midSize, _TS_Draw.cellSize, _TS_Draw.blueColor)
			DrawText("   -", _TS_Draw.fontSize, x + _TS_Draw.row2, y1, _TS_Draw.textColor)
			DrawLine(x + _TS_Draw.row3, y1 + _TS_Draw.midSize, x + _TS_Draw.row4 - _TS_Draw.border, y1 + _TS_Draw.midSize, _TS_Draw.cellSize, _TS_Draw.blueColor)
			DrawText("   +", _TS_Draw.fontSize, x + _TS_Draw.row3, y1, _TS_Draw.textColor)
			DrawLine(x + _TS_Draw.row4, y1 + _TS_Draw.midSize, x + _TS_Draw.width, y1 + _TS_Draw.midSize, _TS_Draw.cellSize, _TS_Draw.redColor)
			DrawText("   X", _TS_Draw.fontSize, x + _TS_Draw.row4, y1, _TS_Draw.textColor)
			y1 = y1 + _TS_Draw.cellSize
		end
	end
	return y1
end

function TS_ClickMenu(x, y, enemyTeam)
	assert(type(x) == "number" and type(y) == "number", "TS__DrawMenu: wrong argument types (<number>, <number> expected)")
	_TS_Draw_Init()
	local enemyTeam = (enemyTeam ~= false)
	local y1 = y
	for index,_gameHero in ipairs(_gameHeros) do
		if _gameHero.enemy == enemyTeam then
			if CursorIsUnder(x + _TS_Draw.row2, y1, _TS_Draw.fontSize, _TS_Draw.fontSize) then
				TS_SetHeroPriority(math.max(1, _gameHero.priority - 1), index)
			elseif CursorIsUnder(x + _TS_Draw.row3, y1, _TS_Draw.fontSize, _TS_Draw.fontSize) then
				TS_SetHeroPriority(math.min((enemyTeam and _gameEnemyCount or _gameAllyCount), _gameHero.priority + 1), index)
			elseif CursorIsUnder(x + _TS_Draw.row4, y1, _TS_Draw.fontSize, _TS_Draw.fontSize) then TS_Ignore(index) end
			y1 = y1 + _TS_Draw.cellSize
		end
	end
	return y1
end

function TargetSelector__OnSendChat(msg)
    if msg:sub(1,3) ~= ".ts" then return end
	BlockChat()
	local args = {}
	while string.find(msg," ") do
		local index = string.find(msg," ")
		table.insert(args, msg:sub(1,index-1))
		msg = string.sub(msg,index+1)
	end
	table.insert(args, msg)
	local cmd = args[1]:lower()
	if cmd == ".tsprint" then
		TS_Print()
	elseif cmd == ".tsprinta" then
		TS_Print(false)
	elseif cmd == ".tsfocus" then
		PrintChat(cmd.." - "..args[2])
		TS_SetFocus(args[2])
	elseif cmd == ".tsfocusa" then
		TS_SetFocus(args[2], false)
	elseif cmd == ".tspriorityhero" then
		TS_SetHeroPriority(args[2], args[3])
	elseif cmd == ".tspriorityheroa" then
		TS_SetHeroPriority(args[2], args[3], false)
	elseif cmd == ".tspriority" then
		TS_SetPriority(args[2], args[3], args[4], args[5], args[6])
	elseif cmd == ".tsprioritya" then
		TS_SetPriorityA(args[2], args[3], args[4], args[5], args[6])
	elseif cmd == ".tsignore" then
		TS_Ignore(args[2])
	elseif cmd == ".tsignorea" then
		TS_Ignore(args[2], false)
	end
end

class 'TargetSelector'
function TargetSelector:__init(mode, range, damageType, targetSelected, enemyTeam)
	-- Init Global
	assert(type(mode) == "number" and type(range) == "number", "TargetSelector: wrong argument types (<mode>, <number> expected)")
	_gameHeros__init()
	self.mode = mode
	self.range = range
	self._mDmgBase, self._pDmgBase, self._tDmg = 0, 0, 0
	self._dmgType = damageType or DAMAGE_MAGIC
	if self._dmgType == DAMAGE_MAGIC then self._mDmgBase = 100 else self._tDmg = player.totalDamage end
	self.targetSelected = (targetSelected ~= false)
	self.enemyTeam = (enemyTeam ~= false)
	self.target = nil
	self._conditional = nil
	self._castWidth = nil
	self._pDelay = nil
end

function TargetSelector:printMode()
    PrintChat("[TS] Target mode: " .._TargetSelector__texted[self.mode])
end

function TargetSelector:SetDamages(magicDmgBase, physicalDmgBase, trueDmg)
	assert(magicDmgBase == nil or type(magicDmgBase) == "number", "SetDamages: wrong argument types (<number> or nil expected) for magicDmgBase")
	assert(physicalDmgBase == nil or type(physicalDmgBase) == "number", "SetDamages: wrong argument types (<number> or nil expected) for physicalDmgBase")
	assert(trueDmg == nil or type(trueDmg) == "number", "SetDamages: wrong argument types (<number> or nil expected) for trueDmg")
	self._dmgType = 0
	self._mDmgBase = magicDmgBase or 0
	self._pDmgBase = physicalDmgBase or 0
	self._tDmg = trueDmg or 0
end

function TargetSelector:SetMinionCollision(castWidth)
	assert(castWidth == nil or type(castWidth) == "number", "SetMinionCollision: wrong argument types (<number> or nil expected)")
	self._castWidth = ((castWidth ~= nil or castWidth > 0) and castWidth or nil)
end

function TargetSelector:SetPrediction(delay)
	assert(delay == nil or type(delay) == "number", "SetPrediction: wrong argument types (<number> or nil expected)")
	_Prediction__OnLoad()
	self._pDelay = ((delay ~= nil and delay > 0) and delay or nil)
end

function TargetSelector:SetProjectileSpeed(pSpeed)
	assert(delay == nil or type(delay) == "number", "SetProjectileSpeed: wrong argument types (<number> or nil expected)")
	_Prediction__OnLoad()
	self._pSpeed = ((pSpeed ~= nil and pSpeed > 0) and pSpeed or nil)
end

function TargetSelector:SetConditional(func)
	assert (func == nil or type(func) == "function", "SetConditional : wrong argument types (<function> or nil expected)")
	self._conditional = func
end

function TargetSelector:_targetSelectedByPlayer()
	if self.targetSelected then
		local currentTarget = GetTarget()
		if ValidTarget(currentTarget, self.range, self.enemyTeam) and (currentTarget.type == "obj_AI_Hero" or currentTarget.type == "obj_AI_Minion") and (self._conditional == nil or self._conditional(currentTarget)) then
			if self.target == nil or self.target.networkID ~= currentTarget.networkID then
				self.target = currentTarget
				self.index = _gameHeros__index(currentTarget, "_targetSelectedByPlayer")
			end
			local delay = 0
			if self._pDelay ~= nil and self._pDelay > 0 then
				delay = delay + self._pDelay
			end
			if self._pSpeed ~= nil and self._pSpeed > 0 then
				delay = delay + (GetDistance(currentTarget) / self._pSpeed)
			end
			if self.index and delay > 0 then
				self.nextPosition = _PredictionPosition(self.index, delay)
				self.nextHealth = _PredictionHealth(self.index, delay)
			else
				self.nextPosition = Vector(currentTarget)
				self.nextHealth = currentTarget.health
			end
			return true
		end
	end
	return false
end

function TargetSelector:update()
    -- Resets the target if player died
    if player.dead then
        self.target = nil
		return
	end
	-- Get current selected target (by player) if needed
    if self:_targetSelectedByPlayer() then return end
	local selected, index, value, nextPosition, nextHealth
	local range = (self.mode == TARGET_NEAR_MOUSE and 2000 or self.range)
    for i, _gameHero in ipairs(_gameHeros) do
        local hero = _gameHero.hero
        if ValidTarget(hero, range, self.enemyTeam) and not _gameHero.ignore and (self._conditional == nil or self._conditional(hero, i)) then
			local minionCollision = false
			local delay = 0
			if self._pDelay ~= nil and self._pDelay > 0 then
				delay = delay + self._pDelay
			end
			if self._pSpeed ~= nil and self._pSpeed > 0 then
				delay = delay + (GetDistance(hero) / self._pSpeed)
			end
			if delay > 0 then
				nextPosition = _PredictionPosition(i, delay)
				nextHealth = _PredictionHealth(i, delay)
			else
				nextPosition, nextHealth = Vector(hero), hero.health
			end
			if self._castWidth then minionCollision = GetMinionCollision(player, nextPosition, self._castWidth) end
			if GetDistance(nextPosition) <= range and minionCollision == false then
				if self.mode == TARGET_LOW_HP or self.mode == TARGET_LOW_HP_PRIORITY or self.mode == TARGET_LESS_CAST or self.mode == TARGET_LESS_CAST_PRIORITY then
				-- Returns lowest effective HP target that is in range
				-- Or lowest cast to kill target that is in range
					if self._dmgType == DAMAGE_PHYSICAL then self._pDmgBase = player.totalDamage end
					local mDmg = (self._mDmgBase > 0 and player:CalcMagicDamage(hero, self._mDmgBase) or 0)
					local pDmg = (self._pDmgBase > 0 and player:CalcDamage(hero, self._pDmgBase) or 0)
					local totalDmg = mDmg + pDmg + self._tDmg
					-- priority mode
					if self.mode == TARGET_LOW_HP_PRIORITY or self.mode == TARGET_LESS_CAST_PRIORITY then
						totalDmg = totalDmg / _gameHero.priority
					end
					local heroValue
					if self.mode == TARGET_LOW_HP or self.mode == TARGET_LOW_HP_PRIORITY then
						heroValue = hero.health - totalDmg
					else
						heroValue = hero.health / totalDmg
					end
					if not selected or heroValue < value then selected, index, value = hero, i, heroValue end
				elseif self.mode == TARGET_MOST_AP then
				-- Returns target that has highest AP that is in range
					if not selected or hero.ap > selected.ap then selected, index = hero, i end
				elseif self.mode == TARGET_MOST_AD then
				-- Returns target that has highest AD that is in range
					if not selected or hero.totalDamage > selected.totalDamage then selected, index = hero, i end
				elseif self.mode == TARGET_PRIORITY then
				-- Returns target with highest priority # that is in range
					if not selected or _gameHero.priority < value then selected, index, value = hero, i, _gameHero.priority end
				elseif self.mode == TARGET_NEAR_MOUSE then
				-- Returns target that is the closest to the mouse cursor.
					local distance = GetDistance(mousePos, hero)
					if not selected or distance < value then selected, index, value = hero, i, distance end
				end
			end
        end
    end
	self.index = index
    self.target = selected
	self.nextPosition = nextPosition
	self.nextHealth = nextHealth
end

function TargetSelector:OnSendChat(msg, prefix)
	assert(type(prefix) == "string" and prefix ~= "" and prefix:lower() ~= "ts", "TS OnSendChat: wrong argument types (<string> (not TS) expected for prefix)")
    if msg:sub(1,1) ~= "." then return end
	local prefix = prefix:lower()
	local length = prefix:len() + 1
	if msg:sub(1,length) ~= "."..prefix then return end
	BlockChat()
	local args = {}
	while string.find(msg," ") do
		local index = string.find(msg," ")
		table.insert(args, msg:sub(1,index-1))
		msg = msg:sub(index+1)
	end
	table.insert(args, msg)
	local cmd = args[1]:lower()
	if cmd == "."..prefix.."mode" then
		assert(args[2] ~= nil, "TS OnSendChat: wrong argument types (LowHP, MostAP, MostAD, LessCast, NearMouse, Priority, LowHPPriority, LessCastPriority expected)")
		local index = 0
		for i, mode in ipairs({"LowHP", "MostAP", "MostAD", "LessCast", "NearMouse", "Priority", "LowHPPriority", "LessCastPriority"}) do
			if mode:lower() == args[2]:lower() then
				index = i
				break
			end
		end
		assert(index ~= 0, "TS OnSendChat: wrong argument types (LowHP, MostAP, MostAD, LessCast, NearMouse, Priority, LowHPPriority, LessCastPriority expected)")
		self.mode = index
		self:printMode()
    end
end

function TargetSelector:DrawMenu(x, y)
	assert(type(x) == "number" and type(y) == "number", "ts:DrawMenu: wrong argument types (<number>, <number> expected)")
	_TS_Draw_Init()
	DrawLine(x - _TS_Draw.border, y + _TS_Draw.midSize, x + _TS_Draw.row3 - _TS_Draw.border, y + _TS_Draw.midSize, _TS_Draw.cellSize, _TS_Draw.background)
	DrawText((self.name or "ts").." Mode : ".._TargetSelector__texted[self.mode], _TS_Draw.fontSize, x, y, _TS_Draw.textColor)
	DrawLine(x + _TS_Draw.row3, y + _TS_Draw.midSize, x + _TS_Draw.row4 - _TS_Draw.border, y + _TS_Draw.midSize, _TS_Draw.cellSize, _TS_Draw.blueColor)
	DrawText( "   <", _TS_Draw.fontSize, x + _TS_Draw.row3, y, _TS_Draw.textColor)
	DrawLine(x + _TS_Draw.row4, y + _TS_Draw.midSize, x + _TS_Draw.width, y + _TS_Draw.midSize, _TS_Draw.cellSize, _TS_Draw.blueColor)
	DrawText( "   >", _TS_Draw.fontSize, x + _TS_Draw.row4, y, _TS_Draw.textColor)
	return y + _TS_Draw.cellSize
end

function TargetSelector:ClickMenu(x, y)
	assert(type(x) == "number" and type(y) == "number", "ts:ClickMenu: wrong argument types (<number>, <number>, <string> expected)")
	_TS_Draw_Init()
	if CursorIsUnder(x + _TS_Draw.row3, y, _TS_Draw.fontSize, _TS_Draw.fontSize) then
		self.mode = (self.mode == 1 and #_TargetSelector__texted or self.mode - 1)
	elseif CursorIsUnder(x + _TS_Draw.row4, y, _TS_Draw.fontSize, _TS_Draw.fontSize) then
		self.mode = (self.mode == #_TargetSelector__texted and 1 or self.mode + 1)
	end
	return y + _TS_Draw.cellSize
end

-- Prediction Functions
--[[
Globals Functions
Prediction__OnTick()			-- OnTick()
GetPredictionPos(iHero, delay)				-- return nextPosition in delay (ms) for iHero (index)
GetPredictionPos(Hero, delay)				-- return nextPosition in delay (ms) for Hero
GetPredictionPos(charName, delay, enemyTeam)		-- return nextPosition in delay (ms) for charName in enemyTeam (true/false, default true) 
GetPredictionHealth(iHero, delay)			-- return next Health in delay (ms) for iHero (index)
GetPredictionHealth(Hero, delay)			-- return next Health in delay (ms) for Hero
GetPredictionHealth(charName, delay, enemyTeam)	-- return next Health in delay (ms) for charName in enemyTeam (true/false, default true) 

]]
_Prediction = {init = true, delta = 1}

function _Prediction__OnLoad()
	if _Prediction.init then
		_gameHeros__init()
		_Prediction.tick = GetTickCount()
		for i, _gameHero in ipairs(_gameHeros) do
			if _gameHero.hero ~= nil then
				_gameHero.pVector = Vector()
				_gameHero.lastPos = Vector(_gameHero.hero)
				_gameHero.pHealth = 0
				_gameHero.lastHealth = _gameHero.hero.health
			end
		end
		_Prediction.init = nil
	end
end

function _PredictionPosition(iHero, delay)
	local _gameHero = _gameHeros[iHero]
	if _gameHero and VectorType(_gameHero.pVector) and VectorType(_gameHero.lastPos) then
		local heroPosition = _gameHero.lastPos + (_gameHero.pVector * (_Prediction.delta * delay))
		heroPosition.y = _gameHero.hero.y
		return heroPosition
	end
end

function _PredictionHealth(iHero, delay)
	local _gameHero = _gameHeros[iHero]
	if _gameHero and _gameHero.pHealth ~= nil and _gameHero.lastHealth ~= nil then
		return _gameHero.lastHealth + (_gameHero.pHealth * (_Prediction.delta * delay))
	end
end

function Prediction__OnTick()
	_Prediction__OnLoad()
	local tick = GetTickCount()
	_Prediction.delta = 1 / (tick - _Prediction.tick)
	_Prediction.tick = tick
	for i, _gameHero in ipairs(_gameHeros) do
		if _gameHero.hero ~= nil and _gameHero.hero.dead == false and _gameHero.hero.visible then
			_gameHero.pVector = ( Vector(_gameHero.hero) - _gameHero.lastPos )
			_gameHero.lastPos = Vector(_gameHero.hero)
			_gameHero.pHealth = _gameHero.hero.health - _gameHero.lastHealth
			_gameHero.lastHealth = _gameHero.hero.health
		end
	end
end

function GetPredictionPos(target, delay, enemyTeam)
	local enemyTeam = (enemyTeam ~= false)
	local iHero = _gameHeros__index(target, "GetPredictionPos", enemyTeam)
	return _PredictionPosition(iHero, delay)
end

function GetPredictionHealth(target, delay, enemyTeam)
	local enemyTeam = (enemyTeam ~= false)
	local iHero = _gameHeros__index(target, "GetPredictionHealth", enemyTeam)
	return _PredictionHealth(iHero, delay)
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GetMinionCollision
--[[
	Goblal Function :
	GetMinionCollision(posEnd, spellWidth)			-> return true/false if collision with minion from player to posEnd with spellWidth.
]]
function GetMinionCollision(posStart, posEnd, spellWidth)
	assert(VectorType(posStart) and VectorType(posEnd) and type(spellWidth) == "number", "GetMinionCollision: wrong argument types (<Vector>, <Vector>, <number> expected)")
	local distance = GetDistance(posStart, posEnd)
	for i = 0, objManager.maxObjects, 1 do
		local object = objManager:getObject(i)
		if object and object.team ~= player.team and object.type == "obj_AI_Minion" and not object.dead and object.visible and object.bTargetable then
			if GetDistance(object, posStart) < distance and GetDistance(object, posEnd) < distance then
				local closestPoint = VectorPointProjectionOnLine(posStart, posEnd, object)
				if GetDistance(closestPoint, object) <= spellWidth / 2 then return true end
			end
		end
	end
	return false
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TargetPrediction Class
--[[
Globals Functions
TargetPrediction__OnTick()			-- OnTick()

Methods:
tp = TargetPrediction(range, proj_speed, delay, widthCollision, smoothness)

Functions :
tp:GetPrediction(target)			-- return nextPosition, minionCollision, nextHealth

members :
tp.nextPosition						-- vector pos
tp.minions
tp.nextHealth
tp.range
tp.proj_speed
tp.delay
tp.width
tp.smoothness
]]

-- use _gameHeros with TargetSelector
_TargetPrediction__tick = 0

-- should be place on OnTick()
function TargetPrediction__OnTick()
    local osTime = os.clock()
    if osTime - _TargetPrediction__tick > 0.35 then
        _TargetPrediction__tick = osTime
		for i, _enemyHero in ipairs(_gameHeros) do
			local hero = _enemyHero.hero
			if hero.dead then
				_enemyHero.prediction = nil
			elseif hero.visible then
				if _enemyHero.prediction then
					local deltaTime = osTime - _enemyHero.prediction.lastUpdate
					_enemyHero.prediction.movement = (Vector(hero) - _enemyHero.prediction.position) / deltaTime
					_enemyHero.prediction.healthDifference = (hero.health - _enemyHero.prediction.health) / deltaTime
					_enemyHero.prediction.health = hero.health
					_enemyHero.prediction.position = Vector(hero)
					_enemyHero.prediction.lastUpdate = osTime
				else
					_enemyHero.prediction = { position = Vector(hero), lastUpdate = osTime, minions = false, health = hero.health }
				end
			end
        end
    end
end

class 'TargetPrediction'

function TargetPrediction:__init(range, proj_speed, delay, widthCollision, smoothness)
	assert(type(range) == "number", "TargetPrediction: wrong argument types (<number> expected for range)")
	_gameHeros__init()
	self.range = range
	self.proj_speed = proj_speed
	self.delay = delay or 0
	self.width = widthCollision
	self.smoothness = smoothness
end

function TargetPrediction:GetPrediction(target)
    assert(target ~= nil, "GetPrediction: wrong argument types (<target> expected)")
	local index = _gameHeros__index(target, "GetPrediction")
	if not index then return end
	local selected = _gameHeros[index].hero
    if _gameHeros[index].prediction and _gameHeros[index].prediction.movement then
		if index ~= self.target then
			self.nextPosition = nil
			self.target = index
		end
		local osTime = os.clock()
        local delay = self.delay / 1000
		local proj_speed = self.proj_speed and self.proj_speed * 1000
        if GetDistance(selected) < self.range + 300 then
            if osTime - (_gameHeros[index].prediction.calculateTime or 0) > 0 then
                local latency = (GetLatency() / 1000) or 0
                local PositionPrediction
                if selected.visible then
					PositionPrediction = (_gameHeros[index].prediction.movement * (delay + latency)) + selected
                elseif osTime - _gameHeros[index].prediction.lastUpdate < 3 then
					PositionPrediction = (_gameHeros[index].prediction.movement * (delay + latency + osTime - _gameHeros[index].prediction.lastUpdate)) + _gameHeros[index].prediction.position
                else _gameHeros[index].prediction = nil return
                end
				local t = 0
				if proj_speed and proj_speed > 0 then
					local a, b, c = PositionPrediction, _gameHeros[index].prediction.movement, Vector(player)
                    local d, e, f, g, h, i, j, k, l = (-a.x + c.x), (-a.z + c.z), b.x * b.x, b.z * b.z, proj_speed * proj_speed, a.x * a.x, a.z * a.z, c.x * c.x, c.z * c.z
                    local t = (-(math.sqrt(-f * (l - 2 * c.z * a.z + j) + 2 * b.x * b.z * d * e - g * (k - 2 * c.x * a.x + i) + (k - 2 * c.x * a.x + l - 2 * c.z * a.z + i + j) * h) - b.x * d - b.z * e)) / (f + g - h)
					PositionPrediction = (_gameHeros[index].prediction.movement * t) + PositionPrediction
                end
                if self.smoothness and self.smoothness < 100 and self.nextPosition then
                    self.nextPosition = (PositionPrediction * ((100 - self.smoothness) / 100)) + (self.nextPosition * (self.smoothness / 100))
                else
                    self.nextPosition = PositionPrediction:clone()
                end
                if GetDistance(PositionPrediction) < self.range then
					--update next Health
                    self.nextHealth = selected.health + (_gameHeros[index].prediction.healthDifference or selected.health) * (t + self.delay + latency)
                    --update minions collision
					self.minions = false
					if self.width then
						self.minions = GetMinionCollision(player, PositionPrediction, self.width)
                    end
                else return
                end
            end
            return self.nextPosition, self.minions, self.nextHealth
        end
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MAP
--[[
Goblal Function :
GetMap()			-> return map

Members :
	map.index = 1-4 (0 mean not found)
	map.name -> return the full map name
	map.shortName -> return the shorted map name (usefull for using it in table)
	map.min {x, y} -> return min map x, y
	map.max{x, y} -> return max map x, y
	map{x, y} -> return map size x, y
]]


-- map 1 = summonerRift

-- map 4 = twistedTreeline
-- map 10 = twistedTreelineBeta

-- map 8 = odin unranked

-- map 7 = The Proving Grounds

_gameMap = {index = 0, name = "unknown", shortName = "unknown", min = {x = 0, y = 0}, max = {x = 0, y = 0}, x = 0, y = 0}
function GetMap()
	if _gameMap.index == 0 then
		for i = 1, objManager.maxObjects do
			local object = objManager:getObject(i)
			if object ~= nil then
				if object.type == "obj_Shop" and object.team == TEAM_BLUE then
					if math.floor(object.x) == -175 and math.floor(object.y) == 163 and math.floor(object.z) == 1056 then
						_gameMap = {index = 1, name = "Summoner's Rift", shortName = "summonerRift", min = {x = -538, y = -165}, max = {x = 14279, y = 14527}, x = 14817, y = 14692}
						break
					elseif math.floor(object.x) == -217 and math.floor(object.y) == 276 and math.floor(object.z) == 7039 then
						_gameMap = {index = 4, name = "The Twisted Treeline", shortName = "twistedTreeline", min = {x = -996, y = -1239}, max = {x = 14120, y = 13877}, x = 15116, y = 15116}
						break
					elseif math.floor(object.x) == 556 and math.floor(object.y) == 191 and math.floor(object.z) == 1887 then
						_gameMap = {index = 7, name = "The Proving Grounds", shortName = "provingGrounds", min = {x = -56, y = -38}, max = {x = 12820, y = 12839}, x = 12876, y = 12877}
						break
					elseif math.floor(object.x) == 16 and math.floor(object.y) == 168 and math.floor(object.z) == 4452 then
						_gameMap = {index = 8, name = "The Crystal Scar", shortName = "crystalScar", min = {x = -15, y = 0}, max = {x = 13911, y = 13703}, x = 13926, y = 13703}
						break
					elseif math.floor(object.x) == -217 and math.floor(object.y) == 276 and math.floor(object.z) == 7039 then
						_gameMap = {index = 10, name = "The Twisted Treeline Beta", shortName = "twistedTreelineBeta", min = {x = -996, y = -1239}, max = {x = 14120, y = 13877}, x = 15116, y = 15116}
						break
					end
				end
			end
		end
	end
	return _gameMap
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GameState Class
--[[
GameState Class :
Methods:
gameState = GameState()				--return a gameState instance

Functions :
gameState:gameIsOver()				-- update the gameIsOver state

Members:
gameState.winner			-> TEAM_BLUE / TEAM_RED winner
gameState.loser 			-> TEAM_BLUE / TEAM_RED loser

Usage :
ex :
function OnLoad()
	gameState = GameState()
end

function OnTick()
	if gameState:gameIsOver() then
		if gameState.winner == player.team then PrintChat("you are the best !") end
		return
	end
end

]]

_gameState = {objects = {}, isOver = false, needCheck = false, nextUpdate = 0, tickUpdate = 500}

class 'GameState'

function GameState:__init()
	if (# _gameState.objects == 0) then
		local mapIndex = GetMap().index
		if (mapIndex == 1 or mapIndex == 2 or mapIndex == 3) then
			for i = 1, objManager.maxObjects, 1 do
				local object = objManager:getObject(i)
				if object ~= nil and object.type == "obj_HQ" then 
					table.insert(_gameState.objects, { object = object, team = object.team })
				end
			end
			_gameState.needCheck = (# _gameState.objects > 0)
		end
	end
	self.loser = 0
	self.winner = 0
end

function GameState:gameIsOver()
	if _gameState.needCheck then
		local tick = GetTickCount()
		if _gameState.nextUpdate > tick then return end
		_gameState.nextUpdate = tick + _gameState.tickUpdate
		for i, objectCheck in pairs(_gameState.objects) do
			if objectCheck.object == nil or objectCheck.object.dead or objectCheck.object.health == 0 then
				_gameState.isOver = true
				_gameState.loser = objectCheck.team
				_gameState.winner = (objectCheck.team == TEAM_BLUE and TEAM_RED or TEAM_BLUE)
				_gameState.needCheck = false
				break
			end
		end
	end
	if _gameState.isOver and self.loser == 0 and self.winner == 0 then
		self.loser = _gameState.loser
		self.winner = _gameState.winner
	end
	return _gameState.isOver
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Start Saved Values
--[[
Goblal Function :
GetStart()			-> return start

Members :
	start.tick			-- return saved GetTickCount() at start
	start.osTime		-- return saved os.time at start
	start.WINDOW_W		-- return saved WINDOW_W
	start.WINDOW_H		-- return saved WINDOW_H
]]

_gameStart = {configFile = LIB_PATH.."gameStart.cfg", init = true}

function GetStart()
	if _gameStart.init then
		-- init values
		UpdateWindow()
		_gameStart.WINDOW_W = tonumber(WINDOW_W ~= nil and WINDOW_W or 0)
		_gameStart.WINDOW_H = tonumber(WINDOW_H ~= nil and WINDOW_H or 0)
		_gameStart.tick = tonumber(GetTickCount())
		_gameStart.osTime = os.time(t)
		_gameStart.save = {}
		if file_exists(_gameStart.configFile) then dofile(_gameStart.configFile) end
		local gameStarted = false
		for i = 1, objManager.maxObjects, 1 do
			local object = objManager:getObject(i)
			if object ~= nil and object.type == "obj_AI_Minion" and string.find(object.name,"Minion_T") then 
				gameStarted = true
				break
			end
		end
		if _gameStart.save.osTime ~= nil and (_gameStart.save.osTime > (_gameStart.osTime - 120) or gameStarted) then
			_gameStart.WINDOW_W = _gameStart.save.WINDOW_W
			_gameStart.WINDOW_H = _gameStart.save.WINDOW_H
			_gameStart.tick = _gameStart.save.tick
			_gameStart.osTime = _gameStart.save.osTime
		else
			local file = io.open(_gameStart.configFile, "w")
			if file then
				file:write("_gameStart.save.osTime = ".._gameStart.osTime.."\n")
				file:write("_gameStart.save.WINDOW_W = ".._gameStart.WINDOW_W.."\n")
				file:write("_gameStart.save.WINDOW_H = ".._gameStart.WINDOW_H.."\n")
				file:write("_gameStart.save.tick = ".._gameStart.tick.."\n")
				file:close()
			end
			file = nil
		end
		--clean
		_gameStart.save = nil
		_gameStart.configFile = nil
		_gameStart.init = nil
	end
	return _gameStart
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--minionManager
--[[
Goblal Functions :
minionManager__OnCreateObj(object)			-- OnCreateObj
minionManager__OnDeleteObj(object)			-- OnDeleteObj
minionManager__OnLoad()						-- onLoad()

minionManager Class :

Methods:
minionArray = minionManager(mode, range, fromPos, sortMode)		--return a minionArray instance

Functions :
minionArray:update()				-- update the minionArray instance

Members:
minionArray.objects					-- minionArray objects table
minionArray.iCount					-- minionArray objects count
minionArray.mode					-- minionArray instance mode (MINION_ALL, etc)
minionArray.range					-- minionArray instance range
minionArray.fromPos					-- minionArray instance x, z from wich the range is based (player by default)
minionArray.sortMode				-- minionArray instance sort mode (MINION_SORT_HEALTH_ASC, etc... or nil if no sorted)

Usage :
ex :
function OnLoad()
	enemyMinions = minionManager(MINION_ENEMY, 600, player, MINION_SORT_HEALTH_ASC)
	allyMinions = minionManager(MINION_ALLY, 300, player, MINION_SORT_HEALTH_DES)
end

function OnTick()
	allyMinions:update()
	enemyMinions:update()
	for index, minion in pairs(enemyMinions.objects) do
		-- what you want
	end
	-- ex changing range
	enemyMinions.range = 250
	enemyMinions:update()
end

function OnCreateObj()
	minionManager__OnCreateObj(object)
end

function OnDeleteObj()
	minionManager__OnDeleteObj(object)
end

]]

_minionTable = {{}, {}, {}, {}, {}}
_minionManager = {init = true, ally = "##", enemy ="##", jungle ="##",}
-- Class related constants
MINION_ALL = 1
MINION_ENEMY = 2
MINION_ALLY = 3
MINION_JUNGLE = 4
MINION_OTHER = 5
MINION_SORT_HEALTH_ASC = 1
MINION_SORT_HEALTH_DEC = 2
MINION_SORT_MAXHEALTH_ASC = 3
MINION_SORT_MAXHEALTH_DEC = 4
MINION_SORT_AD_ASC = 5
MINION_SORT_AD_DEC = 6

function minionManager__OnCreateObj(object)
	if object ~= nil and object.type == "obj_AI_Minion" and object.name ~= nil and not object.dead then
		local name = object.name
		for index, minionTable in pairs(_minionTable) do
			if minionTable[name] ~= nil then return end
		end
		_minionTable[MINION_ALL][name] = object
		if string.find(name,_minionManager.ally) then _minionTable[MINION_ALLY][name] = object
		elseif string.find(name,_minionManager.enemy) then _minionTable[MINION_ENEMY][name] = object
		elseif string.find(_minionManager.jungle, object.charName) then _minionTable[MINION_JUNGLE][name] = object
		else _minionTable[MINION_OTHER][name] = object
		end
	end
end

function minionManager__OnDeleteObj(object)
	if object ~= nil and object.type == "obj_AI_Minion" and object.name ~= nil then
		for index, minionTable in pairs(_minionTable) do
			if minionTable[object.name] ~= nil then minionTable[object.name] = nil end
		end
	end
end

function minionManager__OnLoad()
	if _minionManager.init then
		local mapIndex = GetMap().index
		if mapIndex ~= 4 then
			_minionManager.ally = "Minion_T"..player.team
			_minionManager.enemy = "Minion_T"..TEAM_ENEMY
			if mapIndex == 1 then
				_minionManager.jungle = "Worm,Dragon,AncientGolem,LizardElder,GiantWolf,wolf,YoungLizard,SmallGolem,LesserWraith"
			elseif mapIndex == 2 then
				_minionManager.jungle = "blueDragon,TwistedLizardElder,Ghast,RabidWolf,TwistedBlueWraith,TwistedGiantWolf,TwistedGolem,TwistedYoungLizard,TwistedTinyWraith,TwistedSmallWolf"
			end
		else
			_minionManager.ally = (player.team == TEAM_BLUE and "Blue" or "Red")
			_minionManager.enemy = (player.team == TEAM_BLUE and "Red" or "Blue")
		end
		for i = 1, objManager.maxObjects do
			local object = objManager:getObject(i)
			minionManager__OnCreateObj(object)
		end
		_minionManager.init = nil
	end
end

class 'minionManager'

function minionManager:__init(mode, range, fromPos, sortMode)
	assert(type(mode) == "number" and type(range) == "number", "minionManager: wrong argument types (<mode>, <number> expected)")
	minionManager__OnLoad()
	self.mode = mode
	self.range = range
	self.fromPos = fromPos or player
	self.sortMode = sortMode
	self.objects = {}
	self.iCount = 0
	self:update()
end

function minionManager:update()
	self.objects = {}
	for name,object in pairs(_minionTable[self.mode]) do
		if object ~= nil and object.dead == false and object.visible and GetDistance(self.fromPos,object) <= self.range then
			table.insert(self.objects, object)
		end
	end
	if self.sortMode ~= nil then
		if self.sortMode == MINION_SORT_HEALTH_ASC then
			table.sort(self.objects, function(a,b) return a.health<b.health end)
		elseif self.sortMode == MINION_SORT_HEALTH_DEC then
			table.sort(self.objects, function(a,b) return a.health>b.health end)
		elseif self.sortMode == MINION_SORT_MAXHEALTH_ASC then
			table.sort(self.objects, function(a,b) return a.maxHealth<b.maxHealth end)
		elseif self.sortMode == MINION_SORT_MAXHEALTH_DEC then
			table.sort(self.objects, function(a,b) return a.maxHealth>b.maxHealth end)
		elseif self.sortMode == MINION_SORT_AD_ASC then
			table.sort(self.objects, function(a,b) return a.ad<b.ad end)
		elseif self.sortMode == MINION_SORT_AD_DEC then
			table.sort(self.objects, function(a,b) return a.ad>b.ad end)
		end
	end
	self.iCount = # self.objects
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Inventory
--[[
Goblal Function :
CastItem(itemID) 					-- Cast item
CastItem(itemID, hero) 				-- Cast item on hero
CastItem(itemID, x, z) 				-- Cast item on pos x,z

GetInventorySlotItem(itemID)		-- return the slot or nil
GetInventoryHaveItem(itemID)		-- return true/false
GetInventorySlotIsEmpty(slot)		-- return true/false
GetInventoryItemIsCastable(itemID)	-- return true/false
]]

function GetInventorySlotItem(itemID, target)
	assert(type(itemID) == "number", "GetInventorySlotItem: wrong argument types (<number> expected)")
	local target = target or player
    for i,j in pairs({ITEM_1,ITEM_2,ITEM_3,ITEM_4,ITEM_5,ITEM_6}) do
        if target:getInventorySlot(j) == itemID then return j end
    end
	return nil
end

function GetInventoryHaveItem(itemID, target)
	assert(type(itemID) == "number", "GetInventoryHaveItem: wrong argument types (<number> expected)")
	local target = target or player
	return (GetInventorySlotItem(itemID, target) ~= nil)
end

function GetInventorySlotIsEmpty(slot, target)
	local target = target or player
    return (target:getInventorySlot(slot) == 0)
end

function GetInventoryItemIsCastable(itemID, target)
	assert(type(itemID) == "number", "GetInventoryItemIsCastable: wrong argument types (<number> expected)")
	local target = target or player
	local slot = GetInventorySlotItem(itemID, target)
	if slot == nil then return false end
	return (target:CanUseSpell(slot) == READY)
end

function CastItem(itemID, var1, var2)
	assert(type(itemID) == "number", "CastItem: wrong argument types (<number> expected)")
	local slot = GetInventorySlotItem(itemID)
	if slot == nil then return false end
	if (player:CanUseSpell(slot) == READY) then
		if (var2 ~= nil) then CastSpell(slot, var1, var2)
		elseif (var1 ~= nil) then CastSpell(slot, var1)
		else CastSpell(slot)
		end
		return true
	end
	return false
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Class : ChampionLane
--[[
Goblal Function :
_ChampionLane__OnLoad() 		-- OnLoad()
ChampionLane__OnTick()			-- OnTick()

Method :
CL = ChampionLane()

Functions :
CL:GetMyLane()			-- return lane name
CL:GetPoint(lane)			-- return the 3D point of the center of the lane
CL:GetHeroCount(lane)		-- return number of enemy hero in lane
CL:GetHeroCount(lane, team)	-- return number of team hero in lane ("ally", "enemy")
CL:GetHeroArray(lane)	-- return the array of enemy hero objects in lane
CL:GetHeroArray(lane, team)	-- return the array of team hero objects in lane
CL:GetCarryAD()			-- return the object of the enemy Carry Ad or nil
CL:GetCarryAD(team)		-- return the object of the team Carry Ad or nil
CL:GetSupport()			-- return the object of the enemy support or nil
CL:GetSupport(team)		-- return the object of the team support or nil
CL:GetJungler()			-- return the object of the enemy jungler or nil
CL:GetJungler(team)		-- return the object of the team jungler or nil
]]

_championLane = {savedFile = LIB_PATH.."championLane.cfg", init = true, enemy = { champions = {}, top = {}, mid = {}, bot = {}, jungle = {}, unknow = {} }, ally = { champions = {}, top = {}, mid = {}, bot = {}, jungle = {}, unknow = {} }, myLane = "unknow", nextUpdate = 0, tickUpdate = 250}

-- init values
function _ChampionLane__OnLoad()
	if _championLane.init then
		_championLane.init = nil
		_championLane.mapIndex = GetMap().index
		local start = GetStart()
		for i = 1, heroManager.iCount, 1 do
			local hero = heroManager:getHero(i) 
			if hero ~= nil then
				local isJungler = (string.find(hero:GetSpellData(SUMMONER_1).name..hero:GetSpellData(SUMMONER_2).name, "Smite") and true or false)
				table.insert(_championLane[(hero.team == player.team and "ally" or "enemy")].champions, {hero = hero, top = 0, mid = 0, bot = 0, jungle = 0, isJungler = isJungler})
				if isJungler then
					_championLane[(hero.team == player.team and "ally" or "enemy")].jungler = hero
				end
			end
		end
		if _championLane.mapIndex == 1 or _championLane.mapIndex == 2 then
			_championLane.startTime = start.tick + 120000 --2 min from start
			_championLane.stopTime = start.tick + 600000 --10 min from start
			_championLane.nextSave = start.tick + 150000 --2 min 30 from start
			if _championLane.mapIndex == 1 then
				_championLane.top = {point = {x = 1900, y = 0, z = 12600} }
				_championLane.mid = {point = {x = 7100, y = 0, z = 7100} }
				_championLane.bot = {point = {x = 12100, y = 0, z = 2100} }
			elseif _championLane.mapIndex == 2 then
				_championLane.top = {point = {x = 6700, y = 0, z = 7100} }
				_championLane.bot = {point = {x = 6700, y = 0, z = 3100} }
			end
		end
		-- reload saved value if exist
		_championLane.save = {}
		if file_exists(_championLane.savedFile) then dofile(_championLane.savedFile) end
		if _championLane.save.startTime ~= nil and _championLane.startTime == _championLane.save.startTime then
			for j, team in pairs({"ally", "enemy"}) do
				for i, champion in pairs(_championLane.save[team]) do
					_championLane[team].champions[i].top = champion.top
					_championLane[team].champions[i].mid = champion.mid
					_championLane[team].champions[i].bot = champion.bot
					_championLane[team].champions[i].jungle = champion.jungle
				end
			end
			_championLane.nextSave = GetTickCount() + 30000
		end
		--clean
		_championLane.save = nil
	end
end

function _ChampionLane__Save()
	_championLane.nextSave = GetTickCount() + 30000
	local file = io.open(_championLane.savedFile, "w")
	if file then
		file:write("_championLane.save.startTime = ".._championLane.startTime.."\n")
		for j, team in pairs({"ally", "enemy"}) do
			file:write("_championLane.save.".. team .." = {}\n")
			for i, champion in pairs(_championLane[team].champions) do
				file:write("_championLane.save.".. team .."["..i.."] = {top = ".._championLane[team].champions[i].top..", mid = ".._championLane[team].champions[i].mid..", bot = ".._championLane[team].champions[i].bot..", jungle = ".._championLane[team].champions[i].jungle.." }\n")
			end
		end
		file:close()
	end
	file = nil
end

function ChampionLane__OnTick()
	if not _championLane.startTime then return end
	local tick = GetTickCount()
	if tick < _championLane.startTime or tick < _championLane.nextUpdate then return end
	if tick > _championLane.stopTime then _championLane.startTime = nil return end
	if tick > _championLane.nextSave then _ChampionLane__Save() end
	_championLane.nextUpdate = tick + _championLane.tickUpdate
	-- team update
	for j, team in pairs({"ally", "enemy"}) do
		local update = {top = {}, mid = {}, bot = {}, jungle = {}, unknow = {} }
		for i, champion in pairs(_championLane[team].champions) do
			-- update champ pos
			if champion.hero.dead == false then
				if champion.hero.visible then
					if GetDistance(_championLane.top.point, champion.hero) < 2000 then champion.top = champion.top + 10 end
					if _championLane.mid ~= nil and GetDistance(_championLane.mid.point, champion.hero) < 2000 then champion.mid = champion.mid + 10 end
					if GetDistance(_championLane.bot.point, champion.hero) < 2000 then champion.bot = champion.bot + 10 end
				else
					champion.jungle = champion.jungle + 1
				end
				if champion.isJungler then champion.jungle = champion.jungle + 5 end
			end
			local lane
			if champion.top > champion.mid and champion.top > champion.bot and champion.top > champion.jungle then lane = "top"
			elseif champion.mid > champion.bot and champion.mid > champion.jungle then lane = "mid"
			elseif champion.bot > champion.jungle then lane = "bot"
			elseif champion.jungle > 0 then lane = "jungle"
			else lane = "unknow"
			end
			table.insert(update[lane], champion.hero)
			if champion.hero.networkID == player.networkID then
				_championLane.myLane = lane
			end
		end
		_championLane[team].top = update.top
		_championLane[team].mid = update.mid
		_championLane[team].bot = update.bot
		_championLane[team].jungle = update.jungle
		-- update jungler if needed
		if _championLane[team].jungler == nil and #_championLane[team].jungle == 1 then
			_championLane[team].jungler = _championLane[team].jungle[1]
		end
		if _championLane.mapIndex == 1 then
			-- update carry / support
			local carryAD = nil
			local support = nil
			for i, hero in pairs(_championLane[team].bot) do
				if carryAD == nil or hero.totalDamage > carryAD.totalDamage then carryAD = hero end
				if support == nil or hero.totalDamage < support.totalDamage then support = hero end
			end
			_championLane[team].carryAD = carryAD
			_championLane[team].support = support
		end
	end
end

class 'ChampionLane'

function ChampionLane:__init()
	_ChampionLane__OnLoad()
end

function ChampionLane:GetPoint(lane)
	assert(type(lane) == "string" and (lane == "top" or lane == "bot" or lane == "mid"), "GetPoint: wrong argument types (<lane> expected)")
	return _championLane[lane].point
end

function ChampionLane:GetMyLane()
	return _championLane.myLane
end

function ChampionLane:GetHeroCount(lane, team)
	local team = team or "enemy"
	assert(type(lane) == "string" and (lane == "top" or lane == "bot" or lane == "mid" or lane == "jungle") and type(team) == "string" and (team == "enemy" or team == "ally"), "GetHeroCount: wrong argument types (<lane>, <team> expected)")
	return # _championLane[team][lane]
end

function ChampionLane:GetHeroArray(lane, team)
	local team = team or "enemy"
	assert(type(lane) == "string" and (lane == "top" or lane == "bot" or lane == "mid" or lane == "jungle") and type(team) == "string" and (team == "enemy" or team == "ally"), "GetHeroArray: wrong argument types (<lane>, <team> expected)")
	return _championLane[team][lane]
end

function ChampionLane:GetCarryAD(team)
	local team = team or "enemy"
	assert(type(team) == "string" and (team == "enemy" or team == "ally"), "GetCarryAD: wrong argument types (<team> or nil expected)")
	return _championLane[team].carryAD
end

function ChampionLane:GetSupport(team)
	local team = team or "enemy"
	assert(type(team) == "string" and (team == "enemy" or team == "ally"), "GetSupport: wrong argument types (<team> or nil expected)")
	return _championLane[team].support
end

function ChampionLane:GetJungler(team)
	local team = team or "enemy"
	assert(type(team) == "string" and (team == "enemy" or team == "ally"), "GetJungler: wrong argument types (<team> or nil expected)")
	return _championLane[team].jungler
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- minimap
--[[
Goblal Function :
GetMinimapX(x) 					-- Return x minimap value
GetMinimapY(y)					-- Return y minimap value
GetMinimap(v)					-- Get minimap point {x, y} from object
GetMinimap(x, y)					-- Get minimap point {x, y}
]]

_miniMap = { init = true }

function GetMinimapX(x)
	assert(type(x) == "number", "GetMinimapX: wrong argument types (<number> expected for x)")
	return (_miniMap__OnLoad() and -100 or _miniMap.x + _miniMap.step.x * x)
end

function GetMinimapY(y)
	assert(type(y) == "number", "GetMinimapY: wrong argument types (<number> expected for y)")
	return (_miniMap__OnLoad() and -100 or _miniMap.y + _miniMap.step.y * y)
end

function GetMinimap(a,b)
	local x,y
	if b == nil then
		if VectorType(a) then
			x, y = a.x, a.z
		else
			assert(type(a.x) == "number" and type(a.y) == "number", "GetMinimap: wrong argument types (<vector> expected, or <number>, <number>)")
			x, y = a.x, a.y
		end
	else
		assert(type(a) == "number" and type(b) == "number", "GetMinimap: wrong argument types (<vector> expected, or <number>, <number> for x, y)")
		x, y = a, b
	end
	return { x = GetMinimapX(x), y = GetMinimapY(y) }
end

function _miniMap__OnLoad()
	if _miniMap.init then
		local map = GetMap()
		UpdateWindow()
		if WINDOW_H < 500 or WINDOW_W < 500 then return true end
		local percent = math.max(WINDOW_W/1920, WINDOW_H/1080)
		_miniMap.step = {x = 290*percent/map.x, y = -290*percent/map.y}
		_miniMap.x = WINDOW_W-300*percent - _miniMap.step.x * map.min.x
		_miniMap.y = WINDOW_H-10*percent - _miniMap.step.y * map.min.y
		_miniMap.init = nil
	end
	return _miniMap.init
end

--	autoLevel
--[[
autoLevel__OnTick()			--OnTick()
autoLevelSetSequence(sequence)	-- set the sequence
autoLevelSetFunction(func)		-- set the function used if sequence level == 0
	Usage :
		On your script :
		Set the levelSequence :
			local levelSequence = {1,nil,0,1,1,4,1,nil,1,nil,4,nil,nil,nil,nil,4,nil,nil}
			autoLevelSetSequence(levelSequence)
				The levelSequence is table of 18 fields
				1-4 = spell 1 to 4
				nil = will not auto level on this one
				0 = will use your own function for this one, that return a number between 1-4
			
		Set the function if you use 0, example :
			local onChoiceFunction = function()
				if player:GetSpellData(SPELL_2).level < player:GetSpellData(SPELL_3).level then
					return 2
				else
					return 3
				end
			end
			autoLevelSetFunction(onChoiceFunction)
			
		Call the main function on your tick :
			autoLevel__OnTick()
]]

_autoLevel = {spellsSlots = {SPELL_1, SPELL_2, SPELL_3, SPELL_4}, levelSequence = {}, nextUpdate = 0, tickUpdate = 500}

function autoLevel__OnTick()
	local tick = GetTickCount()
	if _autoLevel.nextUpdate > tick then return end
	_autoLevel.nextUpdate = tick + _autoLevel.tickUpdate
	local realLevel = GetHeroLeveled()
	if player.level > realLevel and _autoLevel.levelSequence[realLevel + 1] ~= nil then
		local splell = _autoLevel.levelSequence[realLevel + 1]
		if splell == 0 and type(_autoLevel.onChoiceFunction) == "function" then splell = _autoLevel.onChoiceFunction() end
		if type(splell) == "number" and splell >= 1 and splell <= 4 then LevelSpell(_autoLevel.spellsSlots[splell]) end
	end
end

function autoLevelSetSequence(sequence)
	assert (sequence == nil or type(sequence) == "table", "autoLevelSetSequence : wrong argument types (<table> or nil expected)")
	local sequence = sequence or {}
	for i = 1, 18 do
		local spell = sequence[i]
		if type(spell) == "number" and spell >= 0 and spell <= 4 then
			_autoLevel.levelSequence[i] = spell
		else
			_autoLevel.levelSequence[i] = nil
		end
	end
end

function autoLevelSetFunction(func)
	assert (func == nil or type(func) == "function", "autoLevelSetFunction : wrong argument types (<function> or nil expected)")
	_autoLevel.onChoiceFunction = func
end

--	scriptConfig
--[[

myConfig = scriptConfig("My Script Config Header", "thisScript")

myConfig:addParam(pVar, pText, SCRIPT_PARAM_ONOFF, defaultValue)
myConfig:addParam(pVar, pText, SCRIPT_PARAM_ONKEYDOWN, defaultValue, key)
myConfig:addParam(pVar, pText, SCRIPT_PARAM_ONKEYTOGGLE, defaultValue, key)
myConfig:addParam(pVar, pText, SCRIPT_PARAM_SLICE, defaultValue, minValue, maxValue, decimalPlace)

myConfig:permaShow(pvar)	-- show this var in perma menu

myConfig:addTS(ts)			-- add a ts instance


var are myConfig.var

function OnLoad()
	myConfig = scriptConfig("My Script Config", "thisScript.cfg")
	myConfig:addParam("combo", "Combo mode", SCRIPT_PARAM_ONKEYDOWN, false, 32)
	myConfig:addParam("harass", "Harass mode", SCRIPT_PARAM_ONKEYTOGGLE, false, 78)
	myConfig:addParam("harassMana", "Harass Min Mana", SCRIPT_PARAM_SLICE, 0.2, 0, 1, 2)
	myConfig:addParam("drawCircle", "Draw Circle", SCRIPT_PARAM_ONOFF, false)
	myConfig:permaShow("harass")
	myConfig:permaShow("combo")
	ts = TargetSelector(TARGET_LOW_HP,500,DAMAGE_MAGIC,false)
	ts.name = "Q" -- set a name if you want to recognize it, otherwize, will show "ts"
	myConfig:addTS(ts)
end

function OnTick()
	if myConfig.combo == true then
		-- bla
	elseif myConfig.harass then
		-- bla
	end
end

function OnDraw()
	SC__OnDraw()
end

function OnWndMsg(msg,key)
	SC__OnWndMsg(msg,key)
end

]]

SCRIPT_PARAM_ONOFF = 1
SCRIPT_PARAM_ONKEYDOWN = 2
SCRIPT_PARAM_ONKEYTOGGLE = 3
SCRIPT_PARAM_SLICE = 4
SCRIPT_PARAM_INFO = 5

_SC = {init = true, initDraw = true, menuKey = 16, configFile = LIB_PATH.."scripts.cfg", useTS = false, menuIndex = -1, instances = {}, _changeKey = false, _slice = false}

class 'scriptConfig'

function __SC__remove(name)
	local file = io.open(_SC.configFile, "a+")
	local nameFound, keepLine, content = false, true, {}
	for line in file:lines() do
		if not keepLine and string.find(line, "%[") then keepLine = true end
		if keepLine and string.find(line, "%["..name.."%]") then keepLine, nameFound = false, true end
		if keepLine then table.insert(content, line) end
	end
	file:close()
	if nameFound then
		file = io.open(_SC.configFile, "w+")
		for i = 1, #content do
			file:write(string.format("%s\n", content[i]))
		end
		file:close()
	end
end

function __SC__load(name)
	local keepLine, config = false, {}
	local file = io.open(_SC.configFile, "a+")
	for line in file:lines() do
		if keepLine and string.find(line, "%[") then keepLine = false end
		if not keepLine and string.find(line, "%["..name.."%]") then keepLine = true
		elseif keepLine then
			local key, value = line:match("(.-)="), line:match("=(.+)")
			key = key:find('^%s*$') and '' or key:match('^%s*(.*%S)')
			value = value:find('^%s*$') and '' or value:match('^%s*(.*%S)')
			if value == "false" or value == "true" then value = (value == "true") 
			elseif string.gsub(value,"%d+", ""):gsub("%-", ""):gsub("%.", "") == "" then
				value = tonumber(value)
			end
			if name ~= "Master" then config[key..'.'] = value else config[key] = value end
		end
	end
	return config
end

function __SC__save(name, content)
	__SC__remove(name)
	local file = io.open(_SC.configFile, "a")
	file:write("["..name.."]\n")
	for i = 1, #content do
		file:write(string.format("%s\n", content[i]))
	end
	file:close()
end

function __SC__saveMenu()
	__SC__save("Menu", {"menuKey = "..tostring(_SC.menuKey), "draw.x = "..tostring(_SC.draw.x), "draw.y = "..tostring(_SC.draw.y), "pDraw.x = "..tostring(_SC.pDraw.x), "pDraw.y = "..tostring(_SC.pDraw.y)})
	_SC.master.x = _SC.draw.x
	_SC.master.y = _SC.draw.y
	_SC.master.px = _SC.pDraw.x
	_SC.master.py = _SC.pDraw.y
	__SC__saveMaster()
end

function __SC__saveMaster()
	local config = {}
	local P, PS, I = 0, 0, 0
	for index, instance in pairs(_SC.instances) do
		I = I + 1
		P = P + #instance._param
		PS = PS + #instance._permaShow
	end
	_SC.master["I".._SC.masterIndex] = I
	_SC.master["P".._SC.masterIndex] = P
	_SC.master["PS".._SC.masterIndex] = PS
	if not _SC.master.useTS and _SC.useTS then _SC.master.useTS = true end
	for var, value in pairs(_SC.master) do
		table.insert(config, tostring(var).." = "..tostring(value))
	end
	__SC__save("Master", config)
end

function __SC__updateMaster()
	_SC.master = __SC__load("Master")
	_SC.masterY, _SC.masterYp = 1, 0
	_SC.masterY = (_SC.master.useTS and 1 or 0)
	for i = 1, _SC.masterIndex - 1 do
		_SC.masterY = _SC.masterY + _SC.master["I"..i]
		_SC.masterYp = _SC.masterYp + _SC.master["PS"..i]
	end
	local size, sizep = (_SC.master.useTS and 2 or 1), 0
	for i = 1, _SC.master.iCount do
		size = size + _SC.master["I"..i]
		sizep = sizep + _SC.master["PS"..i]
	end
	_SC.draw.heigth = size * _SC.draw.cellSize
	_SC.pDraw.heigth = sizep * _SC.pDraw.cellSize
	_SC.draw.x = _SC.master.x
	_SC.draw.y = _SC.master.y
	_SC.pDraw.x = _SC.master.px
	_SC.pDraw.y = _SC.master.py
	_SC._Idraw.x = _SC.draw.x + _SC.draw.width + _SC.draw.border * 2
end

function __SC__init_draw()
	if _SC.initDraw then
		UpdateWindow()
		_SC.draw = {x = WINDOW_W and math.floor(WINDOW_W / 50) or 20, y = WINDOW_H and math.floor(WINDOW_H / 4) or 190, y1 = 0, heigth = 0, fontSize = WINDOW_H and math.round(WINDOW_H / 54) or 14, width = WINDOW_W and math.round(WINDOW_W / 4.8) or 213, border = 2, background = 1413167931, textColor = 4290427578, trueColor = 1422721024, falseColor = 1409321728, move = false}
		_SC.pDraw = {x = WINDOW_W and math.floor(WINDOW_W * 0.66) or 675, y = WINDOW_H and math.floor(WINDOW_H * 0.8) or 608, y1 = 0, heigth = 0, fontSize = WINDOW_H and math.round(WINDOW_H / 72) or 10, width = WINDOW_W and math.round(WINDOW_W / 6.4) or 160, border = 1, background = 1413167931, textColor = 4290427578, trueColor = 1422721024, falseColor = 1409321728, move = false}
		local menuConfig = __SC__load("Menu")
		for var, value in pairs(menuConfig) do
			vars = {var:match((var:gsub("[^%.]*%.", "([^.]*).")))}
			if #vars == 1 then
				_SC[vars[1]] = value
			elseif #vars == 2 then
				_SC[vars[1]][vars[2]] = value
			end
		end
		_SC.color = {lgrey = 1413167931, grey = 4290427578, red = 1422721024, green = 1409321728, ivory = 4294967280}
		_SC.draw.cellSize, _SC.draw.midSize, _SC.draw.row4, _SC.draw.row3, _SC.draw.row2, _SC.draw.row1 = _SC.draw.fontSize + _SC.draw.border, _SC.draw.fontSize / 2, _SC.draw.width * 0.9, _SC.draw.width * 0.8, _SC.draw.width * 0.7, _SC.draw.width * 0.6
		_SC.pDraw.cellSize, _SC.pDraw.midSize, _SC.pDraw.row = _SC.pDraw.fontSize + _SC.pDraw.border, _SC.pDraw.fontSize / 2, _SC.pDraw.width * 0.7
		_SC._Idraw = {x = _SC.draw.x + _SC.draw.width + _SC.draw.border * 2 ,y = _SC.draw.y, heigth = 0}
		if WINDOW_H < 500 or WINDOW_W < 500 then return true end
		_SC.initDraw = nil
	end
	return _SC.initDraw
end

function __SC__init(name)
	if name == nil then
		return (_SC.init or __SC__init_draw())
	end
	if _SC.init then
		_SC.init = nil
		__SC__init_draw()
		local gameStart = GetStart()
		_SC.master = __SC__load("Master")
		if _SC.master.osTime ~= nil and _SC.master.osTime == gameStart.osTime then
			for i = 1, _SC.master.iCount do
				if _SC.master["name"..i] == name then _SC.masterIndex = i end
			end
			if _SC.masterIndex == nil then
				_SC.masterIndex = _SC.master.iCount + 1
				_SC.master["name".._SC.masterIndex] = name
				_SC.master.iCount = _SC.masterIndex
				__SC__saveMaster()
			end
		else
			__SC__remove("Master")
			_SC.masterIndex = 1
			_SC.master.useTS = false
			_SC.master.x = _SC.draw.x
			_SC.master.y = _SC.draw.y
			_SC.master.px = _SC.pDraw.x
			_SC.master.py = _SC.pDraw.y
			_SC.master.osTime = gameStart.osTime
			_SC.master.name1 = name
			_SC.master.iCount = 1
			__SC__saveMaster()
		end
	end
	__SC__updateMaster()
end

function __SC__txtKey(key)
	return (key > 32 and key < 96 and " "..string.char(key).." " or "("..tostring(key)..")")
end

function SC__OnDraw()
	if __SC__init() then return end
	if IsKeyDown(_SC.menuKey) or _SC._changeKey then
		if _SC.draw.move then
			local cursor = GetCursorPos()
			_SC.draw.x = cursor.x - _SC.draw.offset.x
			_SC.draw.y = cursor.y - _SC.draw.offset.y
			_SC._Idraw.x = _SC.draw.x + _SC.draw.width + _SC.draw.border * 2
		elseif _SC.pDraw.move then
			local cursor = GetCursorPos()
			_SC.pDraw.x = cursor.x - _SC.pDraw.offset.x
			_SC.pDraw.y = cursor.y - _SC.pDraw.offset.y
		end
		if _SC.masterIndex == 1 then
			DrawLine(_SC.draw.x + _SC.draw.width / 2, _SC.draw.y, _SC.draw.x + _SC.draw.width / 2, _SC.draw.y + _SC.draw.heigth, _SC.draw.width + _SC.draw.border * 2, 1414812756) -- grey
			_SC.draw.y1 = _SC.draw.y
			local menuText = _SC._changeKey and not _SC._changeKeyVar and "press key for Menu" or "Menu"
			DrawText(menuText, _SC.draw.fontSize, _SC.draw.x, _SC.draw.y1, _SC.color.ivory) -- ivory
			DrawText(__SC__txtKey(_SC.menuKey), _SC.draw.fontSize, _SC.draw.x + _SC.draw.width * 0.9, _SC.draw.y1, _SC.color.grey)
		end
		_SC.draw.y1 = _SC.draw.y + _SC.draw.cellSize
		if _SC.useTS then
			__SC__DrawInstance("Target Selector", (_SC.menuIndex == 0))
			if _SC.menuIndex == 0 then
				DrawLine(_SC._Idraw.x + _SC.draw.width / 2, _SC.draw.y, _SC._Idraw.x + _SC.draw.width / 2, _SC.draw.y + _SC._Idraw.heigth, _SC.draw.width + _SC.draw.border * 2, 1414812756) -- grey
				DrawText("Target Selector", _SC.draw.fontSize, _SC._Idraw.x, _SC.draw.y, _SC.color.ivory)
				_SC._Idraw.y = TS__DrawMenu(_SC._Idraw.x, _SC.draw.y + _SC.draw.cellSize)
				_SC._Idraw.heigth = _SC._Idraw.y - _SC.draw.y
			end
		end
		_SC.draw.y1 = _SC.draw.y + _SC.draw.cellSize + (_SC.draw.cellSize * _SC.masterY)
		for index,instance in ipairs(_SC.instances) do
			__SC__DrawInstance(instance.header, (_SC.menuIndex == index))
			if _SC.menuIndex == index then instance:OnDraw() end
		end
	end
	local y1 = _SC.pDraw.y + (_SC.pDraw.cellSize * _SC.masterYp)
	for index,instance in ipairs(_SC.instances) do
		if #instance._permaShow > 0 then
			for i,varIndex in ipairs(instance._permaShow) do
				local pVar = instance._param[varIndex].var
				DrawLine(_SC.pDraw.x - _SC.pDraw.border, y1 + _SC.pDraw.midSize, _SC.pDraw.x + _SC.pDraw.row - _SC.pDraw.border, y1 + _SC.pDraw.midSize, _SC.pDraw.cellSize, _SC.color.lgrey)
				DrawText(instance._param[varIndex].text, _SC.pDraw.fontSize, _SC.pDraw.x, y1, _SC.color.grey)
				if instance._param[varIndex].pType == SCRIPT_PARAM_SLICE or instance._param[varIndex].pType == SCRIPT_PARAM_INFO then
					DrawLine(_SC.pDraw.x + _SC.pDraw.row, y1 + _SC.pDraw.midSize, _SC.pDraw.x + _SC.pDraw.width + _SC.pDraw.border, y1 + _SC.pDraw.midSize, _SC.pDraw.cellSize, _SC.color.lgrey)
					DrawText(tostring(instance[pVar]), _SC.pDraw.fontSize, _SC.pDraw.x + _SC.pDraw.row + _SC.pDraw.border, y1, _SC.color.grey)
				else
					DrawLine(_SC.pDraw.x + _SC.pDraw.row, y1 + _SC.pDraw.midSize, _SC.pDraw.x + _SC.pDraw.width + _SC.pDraw.border, y1 + _SC.pDraw.midSize, _SC.pDraw.cellSize, (instance[pVar] and _SC.color.green or _SC.color.lgrey))
					DrawText((instance[pVar] and "      ON" or "      OFF"), _SC.pDraw.fontSize, _SC.pDraw.x + _SC.pDraw.row + _SC.pDraw.border, y1, _SC.color.grey)
				end
				y1 = y1 + _SC.pDraw.cellSize
			end
		end
	end
end

function __SC__DrawInstance(header, selected)
	DrawLine(_SC.draw.x + _SC.draw.width / 2, _SC.draw.y1, _SC.draw.x + _SC.draw.width / 2, _SC.draw.y1 + _SC.draw.cellSize, _SC.draw.width + _SC.draw.border * 2, (selected and _SC.color.red or _SC.color.lgrey))
	DrawText(header, _SC.draw.fontSize, _SC.draw.x, _SC.draw.y1, (selected and _SC.color.ivory or _SC.color.grey))
	_SC.draw.y1 = _SC.draw.y1 + _SC.draw.cellSize
end

function SC__OnWndMsg(msg,key)
	if __SC__init() then return end
	local msg, key = msg, key
	if key == _SC.menuKey and _SC.lastKeyState ~= msg then
		_SC.lastKeyState = msg
		__SC__updateMaster()
	end
	if _SC._changeKey then
		if msg == KEY_DOWN then
			if _SC._changeKeyMenu then return end
			_SC._changeKey = false
			if _SC._changeKeyVar == nil then
				_SC.menuKey = key
				if _SC.masterIndex == 1 then __SC__saveMenu() end
			else
				_SC.instances[_SC.menuIndex]._param[_SC._changeKeyVar].key = key
				_SC.instances[_SC.menuIndex]:save()
			end
			return
		else
			if _SC._changeKeyMenu and key == _SC.menuKey then _SC._changeKeyMenu = false end
		end
	end
	if msg == WM_LBUTTONDOWN and IsKeyDown(_SC.menuKey) then
		if CursorIsUnder(_SC.draw.x, _SC.draw.y, _SC.draw.width, _SC.draw.heigth) then
			_SC.menuIndex = -1
			if CursorIsUnder(_SC.draw.x + _SC.draw.width - _SC.draw.fontSize * 1.5, _SC.draw.y, _SC.draw.fontSize, _SC.draw.cellSize) then
				_SC._changeKey, _SC._changeKeyVar, _SC._changeKeyMenu = true, nil, true
				return
			elseif CursorIsUnder(_SC.draw.x, _SC.draw.y, _SC.draw.width, _SC.draw.cellSize) then
				_SC.draw.offset = Vector(GetCursorPos()) - _SC.draw
				_SC.draw.move = true
				return
			else
				if _SC.useTS and CursorIsUnder(_SC.draw.x, _SC.draw.y + _SC.draw.cellSize, _SC.draw.width, _SC.draw.cellSize) then _SC.menuIndex = 0 end
				local y1 = _SC.draw.y + _SC.draw.cellSize + (_SC.draw.cellSize * _SC.masterY)
				for index,instance in ipairs(_SC.instances) do
					if CursorIsUnder(_SC.draw.x, y1, _SC.draw.width, _SC.draw.cellSize) then _SC.menuIndex = index end
					y1 = y1 + _SC.draw.cellSize
				end
			end
		elseif CursorIsUnder(_SC.pDraw.x, _SC.pDraw.y, _SC.pDraw.width, _SC.pDraw.heigth) then
			_SC.pDraw.offset = Vector(GetCursorPos()) - _SC.pDraw
			_SC.pDraw.move = true
		elseif _SC.menuIndex == 0 then
			TS_ClickMenu(_SC._Idraw.x, _SC.draw.y + _SC.draw.cellSize)
		elseif _SC.menuIndex > 0 and CursorIsUnder(_SC._Idraw.x, _SC.draw.y, _SC.draw.width, _SC._Idraw.heigth) then
			_SC.instances[_SC.menuIndex]:OnWndMsg()
		end
	elseif msg == WM_LBUTTONUP then
		if _SC.draw.move or _SC.pDraw.move then
			_SC.draw.move = false
			_SC.pDraw.move = false
			if _SC.masterIndex == 1 then __SC__saveMenu() end
			return
		elseif _SC._slice then
			_SC._slice = false
			_SC.instances[_SC.menuIndex]:save()
			return
		end
	else
		for index,instance in ipairs(_SC.instances) do
			for i,param in ipairs(instance._param) do
				if param.pType == SCRIPT_PARAM_ONKEYTOGGLE and key == param.key and msg == KEY_DOWN then
					instance[param.var] = not instance[param.var]
				elseif param.pType == SCRIPT_PARAM_ONKEYDOWN and key == param.key then
					instance[param.var] = (msg == KEY_DOWN)
				end
			end
		end
	end
end

function scriptConfig:__init(header, name)
	assert((type(header) == "string") and (type(name) == "string"), "scriptConfig: expected <string>, <string>)")
	__SC__init(name)
	self.header = header
	self.name = name
	self._tsInstances = {}
	self._param = {}
	self._permaShow = {}
	table.insert(_SC.instances, self)
end

function scriptConfig:addParam(pVar, pText, pType, defaultValue, a, b, c)
	assert(type(pVar) == "string" and type(pText) == "string" and type(pType) == "number", "addParam: wrong argument types (<string>, <string>, <pType> expected)")
	assert(string.find(pVar,"[^%a%d]") == nil, "addParam: pVar should contain only char and number")
	assert(self[pVar] == nil, "addParam: pVar should be unique, already existing "..pVar)
	local newParam = {var = pVar, text = pText, pType = pType}
	if pType == SCRIPT_PARAM_ONOFF then
		assert(type(defaultValue) == "boolean", "addParam: wrong argument types (<boolean> expected)")
	elseif pType == SCRIPT_PARAM_ONKEYDOWN or pType == SCRIPT_PARAM_ONKEYTOGGLE then
		assert(type(defaultValue) == "boolean" and type(a) == "number", "addParam: wrong argument types (<boolean> <number> expected)")
		newParam.key = a
	elseif pType == SCRIPT_PARAM_SLICE then
		assert(type(defaultValue) == "number" and type(a) == "number" and type(b) == "number" and (type(c) == "number" or c == nil), "addParam: wrong argument types (pVar, pText, pType, defaultValue, valMin, valMax, decimal) expected")
		newParam.min = a
		newParam.max = b
		newParam.idc = c or 0
		newParam.cursor = 0
	end
	self[pVar] = defaultValue
	table.insert(self._param, newParam)
	__SC__saveMaster()
	self:load()
end

function scriptConfig:addTS(tsInstance)
	assert(type(tsInstance.mode) == "number", "addTS: expected TargetSelector)")
	_SC.useTS = true
	table.insert(self._tsInstances, tsInstance)
	__SC__saveMaster()
	self:load()
end

function scriptConfig:permaShow(pVar)
	assert(type(pVar) == "string" and self[pVar] ~= nil, "permaShow: existing pVar expected)")
	for index,param in ipairs(self._param) do
		if param.var == pVar then
			table.insert(self._permaShow, index)
		end
	end
	__SC__saveMaster()
end

function scriptConfig:_txtKey(key)
	return (key > 32 and key < 96 and " "..string.char(key).." " or "("..tostring(key)..")")
end

function scriptConfig:OnDraw()
	if _SC._slice then
		local cursorX = math.min(math.max(0, GetCursorPos().x - _SC._Idraw.x - _SC.draw.row3), _SC.draw.width - _SC.draw.row3)
		self[self._param[_SC._slice].var] = math.round(cursorX / (_SC.draw.width - _SC.draw.row3) * (self._param[_SC._slice].max - self._param[_SC._slice].min),self._param[_SC._slice].idc)
	end
	_SC._Idraw.y = _SC.draw.y
	DrawLine(_SC._Idraw.x + _SC.draw.width / 2, _SC._Idraw.y, _SC._Idraw.x + _SC.draw.width / 2, _SC._Idraw.y + _SC._Idraw.heigth, _SC.draw.width + _SC.draw.border * 2, 1414812756) -- grey
	local menuText = _SC._changeKey and _SC._changeKeyVar and "press key for ".._SC.instances[_SC.menuIndex]._param[_SC._changeKeyVar].var or self.header
	DrawText(menuText, _SC.draw.fontSize, _SC._Idraw.x, _SC._Idraw.y, 4294967280) -- ivory
	_SC._Idraw.y = _SC._Idraw.y + _SC.draw.cellSize
	if # self._tsInstances > 0 then
		--_SC._Idraw.y = TS__DrawMenu(_SC._Idraw.x, _SC._Idraw.y)
		for i,tsInstance in ipairs(self._tsInstances) do
			_SC._Idraw.y = tsInstance:DrawMenu(_SC._Idraw.x, _SC._Idraw.y)
		end
	end
	for index,param in ipairs(self._param) do
		self:_DrawParam(index)
	end
	_SC._Idraw.heigth = _SC._Idraw.y - _SC.draw.y
end

function scriptConfig:_DrawParam(varIndex)
	local pVar = self._param[varIndex].var
	DrawLine(_SC._Idraw.x - _SC.draw.border, _SC._Idraw.y + _SC.draw.midSize, _SC._Idraw.x + _SC.draw.row3 - _SC.draw.border, _SC._Idraw.y + _SC.draw.midSize, _SC.draw.cellSize, _SC.color.lgrey)
	DrawText(self._param[varIndex].text, _SC.draw.fontSize, _SC._Idraw.x, _SC._Idraw.y, _SC.color.grey)
	if self._param[varIndex].pType == SCRIPT_PARAM_SLICE then
		DrawText(tostring(self[pVar]), _SC.draw.fontSize, _SC._Idraw.x + _SC.draw.row2, _SC._Idraw.y, _SC.color.grey)
		DrawLine(_SC._Idraw.x + _SC.draw.row3, _SC._Idraw.y + _SC.draw.midSize, _SC._Idraw.x + _SC.draw.width + _SC.draw.border, _SC._Idraw.y + _SC.draw.midSize, _SC.draw.cellSize, _SC.color.lgrey)
		-- cursor
		self._param[varIndex].cursor =  self[pVar] / (self._param[varIndex].max - self._param[varIndex].min) * (_SC.draw.width - _SC.draw.row3)
		DrawLine(_SC._Idraw.x + _SC.draw.row3 + self._param[varIndex].cursor - _SC.draw.border, _SC._Idraw.y + _SC.draw.midSize, _SC._Idraw.x + _SC.draw.row3 + self._param[varIndex].cursor + _SC.draw.border, _SC._Idraw.y + _SC.draw.midSize, _SC.draw.cellSize, 4292598640)
	elseif self._param[varIndex].pType == SCRIPT_PARAM_INFO then
		DrawText(tostring(self[pVar]), _SC.draw.fontSize, _SC._Idraw.x + _SC.draw.row3 + _SC.draw.border, _SC._Idraw.y, _SC.color.grey)
	else
		if (self._param[varIndex].pType == SCRIPT_PARAM_ONKEYDOWN or self._param[varIndex].pType == SCRIPT_PARAM_ONKEYTOGGLE) then
			DrawText(self:_txtKey(self._param[varIndex].key), _SC.draw.fontSize, _SC._Idraw.x + _SC.draw.row2, _SC._Idraw.y, _SC.color.grey)
		end
		DrawLine(_SC._Idraw.x + _SC.draw.row3, _SC._Idraw.y + _SC.draw.midSize, _SC._Idraw.x + _SC.draw.width + _SC.draw.border, _SC._Idraw.y + _SC.draw.midSize, _SC.draw.cellSize, (self[pVar] and _SC.color.green or _SC.color.lgrey))
		DrawText((self[pVar] and "        ON" or "        OFF"), _SC.draw.fontSize, _SC._Idraw.x + _SC.draw.row3 + _SC.draw.border, _SC._Idraw.y, _SC.color.grey)
	end
	_SC._Idraw.y = _SC._Idraw.y + _SC.draw.cellSize
end

function scriptConfig:load()
	local config = __SC__load(self.name)
	for var, value in pairs(config) do
		vars = {var:match((var:gsub("[^%.]*%.", "([^.]*).")))}
		if #vars == 1 then
			if self[vars[1]] ~= nil then self[vars[1]] = value end
		elseif #vars == 2 then
			if self[vars[1]] ~= nil and self[vars[1]][vars[2]] ~= nil then self[vars[1]][vars[2]] = value end
		elseif #vars == 3 then
			if self[vars[1]] ~= nil and self[vars[1]][vars[2]] ~= nil and self[vars[1]][vars[2]][vars[3]] ~= nil then self[vars[1]][vars[2]][vars[3]] = value end
		end
	end
end

function scriptConfig:save()
	local content = {}
	for var,param in pairs(self._param) do
		if param.pType ~= SCRIPT_PARAM_INFO then
			table.insert (content, param.var.."="..tostring(self[param.var]))
			if param.pType == SCRIPT_PARAM_ONKEYDOWN or param.pType == SCRIPT_PARAM_ONKEYTOGGLE then
				table.insert (content, "_param."..var..".key="..tostring(param.key))
			end
		end
	end
	for i,ts in pairs(self._tsInstances) do
		table.insert (content, "_tsInstances."..i..".mode="..tostring(ts.mode))
	end
	-- for i,pShow in pairs(self._permaShow) do
		-- table.insert (content, "_permaShow."..i.."="..tostring(pShow))
	-- end
	__SC__save(self.name, content)
end

function scriptConfig:OnWndMsg()
	local y1 = _SC.draw.y + _SC.draw.cellSize
	if # self._tsInstances > 0 then
		for i,tsInstance in ipairs(self._tsInstances) do
			y1 = tsInstance:ClickMenu(_SC._Idraw.x, y1)
		end
	end
	for i,param in ipairs(self._param) do
		if param.pType == SCRIPT_PARAM_ONKEYDOWN or param.pType == SCRIPT_PARAM_ONKEYTOGGLE then
			if CursorIsUnder(_SC._Idraw.x + _SC.draw.row2, y1, _SC.draw.fontSize, _SC.draw.fontSize) then
				_SC._changeKey, _SC._changeKeyVar, _SC._changeKeyMenu = true, i, true
				return
			end
		end
		if param.pType == SCRIPT_PARAM_ONOFF or param.pType == SCRIPT_PARAM_ONKEYTOGGLE then
			if CursorIsUnder(_SC._Idraw.x + _SC.draw.row3, y1, _SC.draw.width - _SC.draw.row3, _SC.draw.fontSize) then
				self[param.var] = not self[param.var]
				self:save()
				return
			end
		end
		if param.pType == SCRIPT_PARAM_SLICE then
			if CursorIsUnder(_SC._Idraw.x + _SC.draw.row3 + param.cursor - _SC.draw.border, y1, _SC.draw.border * 2, _SC.draw.fontSize) then
				_SC._slice = i
				return
			end
		end
		y1 = y1 + _SC.draw.cellSize
	end
end
