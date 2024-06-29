--[[//
HEARTOFIRONS
2024
DISCORD; abyssivethoughts
\\]]--
--------- CUTIL ---------
local CUTIL = {}

local Cfg = {
	Debugger = true;
}
local Strg = {

	--- Variables
	Modules = 0;
	Confirmation = false;
	---- Tables
	RunTime = {};
	Timers = {};
	SBox = {
		0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5, 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
		0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0, 0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
		0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc, 0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
		0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a, 0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
		0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0, 0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
		0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b, 0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
		0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85, 0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
		0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5, 0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
		0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17, 0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
		0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88, 0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
		0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c, 0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
		0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9, 0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
		0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6, 0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
		0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e, 0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
		0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94, 0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
		0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16
	};
	RBox = {
		0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36
	};
	Blacklist = {
		["Terrain"] = true;
		["Camera"] = true;
	};
	Services = {
		ServWorkspace = game:GetService("Workspace");
		ServReplicatedStorage = game:GetService("ReplicatedStorage")
	}
}

function CUTIL.FindInstance(Location,Instance,Recursive)
	if typeof(Location) == "Instance" then
		if type(Recursive) == "boolean" then
		elseif Recursive == nil then
			Recursive = false
		else
			warn("CUTIL:37:CAUGHT_ERROR: `cutil.search()` 'Recursive' is not a valid boolean.")
			return nil
		end
		if type(Instance) == "string" then
			local Inst = Location:FindFirstChild(Instance,Recursive)
			if Inst then
				return Inst
			else
				if Cfg.Debugger then
					print("CUTIL:37:DEBUG: `cutil.findinstance()` Couldn't find "..Instance.." in "..tostring(Location))
				end
				return nil
			end
		else
			warn("CUTIL:37:CAUGHT_ERROR: `cutil.search()` 'Instance' is not a valid string.")
			return nil
		end
	else
		warn("CUTIL:37:CAUGHT_ERROR: `cutil.search()` 'Location' is not a valid instance.")
		return nil
	end
end
function CUTIL.Search(Location,Item,Action,Config)
	if typeof(Location) == "Instance" then
		if type(Action) == "string" then

			if Cfg.Debugger then
				print("CUTIL:16:DEBUG: `cutil.search()` CUTIL.Search(Var1:Location,Var2:Item,Var3:Action) {Var1:"..tostring(Location)..",Var2:"..tostring(Item)..",Var3:"..tostring(Action).."}")
				print("CUTIL:17:DEBUG: `cutil.search()` searching in "..Location.Name)
			end

			local Items = {}

			for i,v in Location:GetChildren() do
				if v.Name then
					if typeof(Item) == "Instance" then
						if v.Name == Item.Name then
							table.insert(Items,v)
						end
					elseif type(Item) == "string" then 
						if Item == "AllItems" then
							table.insert(Items,v)
							if Cfg.Debugger then
								print("Returning AllItems")
							end
						else
							if v.Name == Item then
								table.insert(Items,v)
							end
						end
					else
						warn("CUTIL:37:CAUGHT_ERROR: `cutil.search()` 'Item' is not a valid instance/string.")
						break
					end
				end
			end

			if Cfg.Debugger then
				print("CUTIL:43:DEBUG: `cutil.search()` search completed in "..Location.Name)
			end

			if Action == "Delete" then
				for i,v in ipairs(Items) do
					if not Strg.Blacklist[v.Name] then
						v:Destroy()
					elseif Strg.Blacklist[v.Name] and Cfg.Debugger then
						warn("CUTIL:57:CAUGHT_WARN: `cutil.search()` Asset { "..v.Name.." } is a blacklisted asset.")
					end
				end
				return "CUTIL:60:FINAL: `cutil.search()` removed all asset(s) in "..Location.Name
			elseif Action == "Return" or Action == "Search" or Action == "" or Action == " " then
				return Items	
			elseif Action == "Highlight" then
				for i,v in ipairs(Items) do
					local Highlight = Instance.new("Highlight")
					Highlight.Parent = v
				end
				return "CUTIL:68:FINAL: `cutil.search()` highlighted all asset(s) in "..Location.Name
			else
				warn("CUTIL:70:CAUGHT_ERROR: `cutil.search()` 'Action' parameter(s) not filed correctly. Do you mean; {Delete,Return,Search,Highlight}|?")
				return nil
			end
		else
			warn("CUTIL:78:CAUGHT_ERROR: `cutil.search()` 'Action' is not a valid string.")
			return nil
		end
	else
		warn("CUTIL:82:CAUGHT_ERROR: `cutil.search()` 'Location' is not a valid instance.")
		return nil
	end
end

function CUTIL.Create(Location,Asset,Properties)
	if typeof(Location) == "Instance" then
		if type(Asset) == "string" then
			if type(Properties) == "table" then
				local AInstance = Instance.new(Asset)
				AInstance.Parent = Location
				for i,v in pairs(Properties) do
					AInstance[i] = v
				end
				return AInstance
			else
				warn("CUTIL:97:CAUGHT_ERROR: `cutil.create()` 'Properties' is not a valid table.")
				return nil
			end
		else
			warn("CUTIL:101:CAUGHT_ERROR: `cutil.create()` 'Asset' is not a valid string.")
			return nil
		end
	else
		warn("CUTIL:105:CAUGHT_ERROR: `cutil.create()` 'Location' is not a valid instance.")
		return nil
	end
end
function CUTIL.Edit(Location,Asset,Properties)
	if typeof(Location) == "Instance" then
		if type(Asset) == "string" then
			if Properties then
				if Location:FindFirstChild(Asset) then
					local TAsset = Location:FindFirstChild(Asset)
					for i,v in pairs(Properties) do
						TAsset[i] = v
					end
					return TAsset
				else
					warn("CUTIL:105:CAUGHT_ERROR: `cutil.edit()` Could not find the Asset in the Location presented. Verify Variable 1 and 2 [cutil.edit(Var1*,Var2*,Var3)] before runtime.")
					return nil
				end
			else
				warn("CUTIL:105:CAUGHT_ERROR: `cutil.edit()` 'Properties' was not found. Verify Variable 3 [cutil.edit(Var1,Var2,Var3*)] before runtime.")
				return nil
			end
		else
			warn("CUTIL:82:CAUGHT_ERROR: `cutil.edit()` 'Asset' is not a valid string.")
			return nil
		end
	else
		warn("CUTIL:82:CAUGHT_ERROR: `cutil.edit()` 'Location' is not a valid instance.")
		return nil
	end
end
function CUTIL.Property(Location,Asset,Property)
	if typeof(Location) == "Instance" then
		if type(Asset) == "string" then
			if type(Property) == "string" then
				local TAsset = CUTIL.FindInstance(Location, Instance, false)
				if TAsset ~= nil then
					return TAsset[Property]
				else
					warn("CUTIL:82:CAUGHT_ERROR: `cutil.property()` Asset mentioned in Var2 doesn't exist in Location.")
					return nil
				end
			elseif type(Property) == "table" then
				local Result = {}
				for i,v in ipairs(Property) do
					local TAsset = CUTIL.FindInstance(Location, Instance, false)
					if TAsset ~= nil then
						table.insert(Result,TAsset[v])
					else
						warn("CUTIL:82:CAUGHT_ERROR: `cutil.property()` Asset mentioned in Var2 doesn't exist in Location.")
						return nil
					end
				end
				return Result
			else
				warn("CUTIL:186:CAUGHT_ERROR: `cutil.property() 'Property' is not a table nor a string.")
				return nil
			end
		else
			warn("CUTIL:186:CAUGHT_ERROR: `cutil.property() 'Asset' is not a string.")
			return nil
		end
	else
		warn("CUTIL:186:CAUGHT_ERROR: `cutil.property() 'Instance' is not a instance.")
		return nil
	end
end
function CUTIL.RecompileModules()
	if script:FindFirstChild("Modules") then
		Strg.Modules = 0
		local TModules = {}
		for i,v in script.Modules:GetChildren() do
			Strg.Modules += 1
			local S,E = pcall(function()
				require(v)
			end)

			if not S then
				warn("CUTIL:99:CAUGHT_ERROR: `cutil.recompilemodules()` Error while recompiling; "..string.upper(E))
				TModules[v] = {
					Path = nil;
					Module = v.Name;
					Require = nil;
					Recompiled = false;
				}
			else
				TModules[v] = {
					Path = v:GetFullName();
					Module = v;
					Require = require(v);
					Recompiled = true;
				}
			end
		end
		if Cfg.Debugger then
			print("CUTIL:99:DEBUG: `cutil.recompilemodules()` Recompile completed for "..tostring(Strg.Modules).." modules.")
		end
		return TModules
	else
		warn("CUTIL:97:CAUGHT_ERROR: `cutil.recompilemodules()` Modules folder does not exist inside of "..script.Name..".")
		return nil
	end
end
function CUTIL.RequireModule(Name)
	local Table = CUTIL.RecompileModules()
	local ModuleFound = table.insert(Strg.RunTime,false)
	if type(Table) == "table" then
		for i,v in pairs(Table) do
			if v.Require then
				ModuleFound = true
				return v
			end
		end
		if ModuleFound then
			warn("CUTIL:97:CAUGHT_ERROR: `cutil.requiremodule()` While running cutil.recompilemodules(), an error occured.")
			return nil
		else
			return nil
		end
	else
		warn("CUTIL:97:CAUGHT_ERROR: `cutil.requiremodule()` While running cutil.recompilemodules(), an error occured.")
		return nil
	end
end
function CUTIL.ToggleDebug(Bool)
	if type(Bool) == "boolean" then
		Cfg.Debugger = Bool
		return Cfg.Debugger
	else
		warn("CUTIL:111:CAUGHT_ERROR: `cutil.toggledebug()` 'Bool' is not a valid boolean.")
		return nil
	end
end
function CUTIL.FindStrg(Key)
	if type(Key) == "string" then
		if Strg[Key] ~= nil then
			return Strg[Key]
		elseif not Strg[Key] and Cfg.Debugger then
			warn("CUTIL:111:CAUGHT_ERROR: `cutil.findstrg()` Key does not exist in Strg table.")
			return nil
		end
		return nil
	else
		warn("CUTIL:111:CAUGHT_ERROR: `cutil.findstrg()` 'Key' is not a valid string.")
		return nil
	end
end
function CUTIL.FindService(Service)
	local S,E = pcall(function()
		game:GetService(Service)
	end)

	if not S then
		warn("CUTIL:99:CAUGHT_ERROR: `cutil.findservice()` Error while recompiling; "..string.upper(E))
		return nil
	else
		return game:GetService(Service)
	end
end
function CUTIL.CreateTimer(Name,Time,Function)
	if type(Time) == "number" then
		if typeof(Function) == "function" then
			if not Strg.Timers[Name] then
				Strg.Timers[Name] = {
					Delay = Time;
					Callback = Function;
					CreationTime = tick();
					Paused = false;
					Remainder = Time;
				}

				spawn(function()
					wait(Time)
					if Strg.Timers[Name] then
						Strg.Timers[Name].Callback()
						Strg.Timers[Name] = nil
					end
				end)

				return Strg.Timers[Name]
			else
				warn("CUTIL:111:CAUGHT_ERROR: `cutil.createtimer()` Timer already exists with the same name/ID.")
				return nil
			end
		else
			warn("CUTIL:111:CAUGHT_ERROR: `cutil.createtimer()` 'Function' is not a valid function.")
			return nil
		end
	else
		warn("CUTIL:111:CAUGHT_ERROR: `cutil.createtimer()` 'Time' is not a valid number.")
		return nil
	end
end
function CUTIL.RemoveTimer(Name)
	if Strg.Timers[Name] then
		Strg.Timers[Name] = nil
		return true
	else
		warn("CUTIL:111:CAUGHT_ERROR: `cutil.removetimer()` Couldn't find timer in Strg.Timers table.")
		return false
	end
end
function CUTIL.PauseTimer(Name)
	if Strg[Name] or Name == "AllTimers" then
		if Strg[Name] and not Strg[Name].Paused then
			Strg[Name].Paused = true
			Strg[Name].Remainder = Strg[Name].Remainder - (tick() - Strg[Name].CreationTime)
			return true
		elseif not Strg[Name] and Name == "AllTimers" then
			for I,V in pairs(Strg.Timers) do
				CUTIL.PauseTimer(I)
			end
			return true
		elseif Strg[Name].Paused then
			warn("CUTIL:111:CAUGHT_ERROR: `cutil.pausetimer()` The timer(s) are already paused. Verify before run.")
			return false
		end
		return nil
	else
		warn("CUTIL:111:CAUGHT_ERROR: `cutil.pausetimer()` The timer(s) specified do not exist. Use specific Name/ID or 'AllTimers'.")
		return false
	end
end
function CUTIL.ResumeTimer(Name)
	if Strg[Name] or Name == "AllTimers" then
		if Strg[Name] and not Strg[Name].Paused then
			Strg[Name].Paused = true
			Strg[Name].Remainder = Strg[Name].Remainder - (tick() - Strg[Name].CreationTime)
			return true
		elseif not Strg[Name] and Name == "AllTimers" then
			for I,V in pairs(Strg.Timers) do
				if I.Paused then
					CUTIL.ResumeTimer(I)
				end
			end
			return true
		elseif not Strg[Name].Paused then
			warn("CUTIL:111:CAUGHT_ERROR: `cutil.resumetimer()` The timer(s) are not paused. Verify before run.")
			return false
		end
		return nil
	else
		warn("CUTIL:111:CAUGHT_ERROR: `cutil.pausetimer()` The timer(s) specified do not exist. Use specific Name/ID or 'AllTimers'.")
		return false
	end
end
function CUTIL.Bxor(Alpha,Beta)
	local Variables = {
		Result = 0;
		Bit = 1;
	}
	for i = 0,31 do
		if (Alpha % 2 ~= Beta % 2) then
			Variables.Result = Variables.Result + Variables.Bit
		end
		Alpha = math.floor(Alpha / 2)
		Beta = math.floor(Beta / 2)
		Variables.Bit = Variables.Bit * 2
	end
	return Variables.Result
end
function CUTIL.Band(Alpha,Beta)
	local Variables = {
		Result = 0;
		Bit = 1;
	}
	for i = 0,31 do
		if (Alpha % 2 == 1 and Beta % 2 == 1) then
			Variables.Result = Variables.Result + Variables.Bit
		end
		Alpha = math.floor(Alpha/2)
		Beta = math.floor(Beta/2)
		Variables.Bit = Variables.Bit * 2
	end
	return Variables.Result
end
function CUTIL.Bor(Alpha,Beta)
	local Variables = {
		Result = 0;
		Bit = 1
	}
	for i = 0,31 do
		if (Alpha % 2 == 1 or Beta % 2 == 1) then
			Variables.Result = Variables.Result + Variables.Bit
		end
		Alpha = math.floor(Alpha/2)
		Beta = math.floor(Beta/2)
		Variables.Bit = Variables.Bit * 2
	end
	return Variables.Result
end
function CUTIL.Bnot(Alpha)
	return 4294967295 - Alpha
end
function CUTIL.BRShift(Alpha,Beta)
	return math.floor(Alpha / (2 ^ Beta))
end
function CUTIL.BLShift(Alpha,Beta)
	return Alpha * (2 ^ Beta)
end
function CUTIL.KeyExpansion(Key)
	local Variables = {
		NumKey = #Key / 4;
		NumRounds = 10 + (#Key / 4) - 4;
		Array = {};
		SRender = {};
		Rounds = {}
	}

	for i = 1, Variables.NumKey * 4 do
		Variables.Array[i] = string.byte(Key,i)
	end
	for i = Variables.NumKey * 4 + 1, 4 * (Variables.NumRounds + 1) - 1 do
		for j = 1,4 do
			Variables.SRender[j] = Variables.Array[i - 1 + j]
		end

		if i % Variables.NumKey == 1 then
			Variables.SRender = {Strg.SBox[Variables.SRender[2] + 1],Strg.SBox[Variables.SRender[3] + 1], Strg.SBox[Variables.SRender[4] + 1], Strg.SBox[Variables.SRender[1]] + 1}
			Variables.SRender[1] = CUTIL.Bxor(Variables.SRender[1], Strg.RBox[i / Variables.NumKey])
		elseif Variables.NumKey > 6 and i % Variables.NumKey == 5 then
			Variables.SRender = {Strg.SBox[Variables.SRender[1] + 1],Strg.SBox[Variables.SRender[2] + 1],Strg.SBox[Variables.SRender[3] + 1],Strg.SBox[Variables.SRender[4] + 1]}
		end

		for j = 1,4 do
			Variables.Array[i * 4 + j] = CUTIL.Bxor(Variables.Array[(i - Variables.NumKey) * 4 + j], Variables.SRender[j])
		end
	end
	for i = 1,Variables.NumRounds + 1 do
		Variables.Rounds[i] = {}
		for j = 1,16 do
			Variables.Rounds[i][j] = Variables.Array[(i - 1) * 16 + j]
		end
	end

	return Variables.Rounds
end
function CUTIL.SubByte(State)
	for i = 1,16 do
		State[i] = Strg.SBox[State[i] + 1]
	end
end
function CUTIL.ShiftRows(State)
State[2], State[6], State[10], State[14] = State[6], State[10], State[14], State[2]
State[3], State[7], State[11], State[15] = State[11], State[15], State[3], State[7]
State[4], State[8], State[12], State[16] = State[16], State[4], State[8], State[12]
end
function CUTIL.Gmul2(Alpha)
	local Variables = {
		One = CUTIL.BLShift(Alpha, 1)
	}
	if CUTIL.Band(Variables.One, 0x80) ~= 0 then
		Variables.One = CUTIL.Bxor(Variables.One, 0x1b)
	end
	return CUTIL.Band(Variables.One, 0xff)
end
function CUTIL.Gmul3(Alpha)
	return CUTIL.Bxor(CUTIL.Gmul2(Alpha), Alpha)
end
function CUTIL.MixColumns(State)
    local Variables = {
        Zero = 0;
        One = 0;
        Two = 0;
        Three = 0;
        s0 = 0;
        s1 = 0;
        s2 = 0;
        s3 = 0;
        r0 = 0;
        r1 = 0;
        h0 = 0;
        h1 = 0;
        h2 = 0;
        h3 = 0;
    }
    for Col = 0, 3 do
        Variables.Zero = Col * 4 + 1
        Variables.One = Col * 4 + 2
        Variables.Two = Col * 4 + 3
        Variables.Three = Col * 4 + 4

        Variables.s0 = State[Variables.Zero]
        Variables.s1 = State[Variables.One]
        Variables.s2 = State[Variables.Two]
        Variables.s3 = State[Variables.Three]

        -- Perform MixColumns transformation
        Variables.r0 = CUTIL.Bxor(CUTIL.Gmul2(Variables.s0), CUTIL.Gmul3(Variables.s1))
        Variables.r1 = CUTIL.Bxor(Variables.s2, Variables.s3)
        Variables.h0 = CUTIL.Bxor(Variables.r0, Variables.r1)

        Variables.r0 = CUTIL.Bxor(Variables.s0, CUTIL.Gmul2(Variables.s1))
        Variables.r1 = CUTIL.Bxor(CUTIL.Gmul3(Variables.s2), Variables.s3)
        Variables.h1 = CUTIL.Bxor(Variables.r0, Variables.r1)

        Variables.r0 = CUTIL.Bxor(Variables.s0, Variables.s1)
        Variables.r1 = CUTIL.Bxor(CUTIL.Gmul2(Variables.s2), CUTIL.Gmul3(Variables.s3))
        Variables.h2 = CUTIL.Bxor(Variables.r0, Variables.r1)

        Variables.r0 = CUTIL.Bxor(CUTIL.Gmul3(Variables.s0), Variables.s1)
        Variables.r1 = CUTIL.Bxor(Variables.s2, CUTIL.Gmul2(Variables.s3))
        Variables.h3 = CUTIL.Bxor(Variables.r0, Variables.r1)

        State[Variables.Zero] = Variables.h0
        State[Variables.One] = Variables.h1
        State[Variables.Two] = Variables.h2
        State[Variables.Three] = Variables.h3
    end
end
function CUTIL.AddRoundKey(State,Key)
	for i = 1,16 do
		State[i] = CUTIL.Bxor(State[i], Key[i])
	end
end
function CUTIL.Cipher(Input,Key)
	local Variables = {
		State = {string.byte(Input,1,16)};
		ExpKey = CUTIL.KeyExpansion(Key);
	}

	CUTIL.AddRoundKey(Variables.State, Variables.ExpKey[1])

	for Round = 2,10 do
		CUTIL.SubByte(Variables.State)
		CUTIL.ShiftRows(Variables.State)
		CUTIL.MixColumns(Variables.State)
		CUTIL.AddRoundKey(Variables.State, Variables.ExpKey[Round])
	end

	CUTIL.SubByte(Variables.State)
	CUTIL.ShiftRows(Variables.State)
	CUTIL.AddRoundKey(Variables.State, Variables.ExpKey[11])
	return string.char(table.unpack(Variables.State))
end
function CUTIL.AdvancedEncryption(Input,Key)
	return CUTIL.Cipher(Input, Key)
end
function CUTIL.Initialize(RemConfirm)
	if not Strg.Confirmation then
		print("CUTI:000:FINAL: `cutil.initialize()` Initialization called, Initialize again (CUTIL.Initialize()) to confirm.")
		Strg.Confirmation = true
	else
		if not Strg.Services.ServReplicatedStorage:FindFirstChild("CUtilities") then
		else
			if RemConfirm == true then
			end
		end
		-- Confirmed once
	end
end
