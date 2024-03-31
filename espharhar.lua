local function randomString(amoutOfSymbols)
	local symbols = string.split("qSEPwSEPeSEPrSEPtSEPySEPuSEPiSEPoSEPpSEPaSEPsSEPdSEPfSEPgSEPhSEPjSEPkSEPlSEPzSEPxSEPcSEPvSEPbSEPnSEPmSEP1SEP2SEP3SEP4SEP5SEP6SEP7SEP8SEP9SEP0SEP-SEP=SEP`SEP/SEP.SEP,SEP+SEP_SEP*SEP;SEP:SEP'SEP"..'"'.."SEP]SEP[SEP SEP|SEP!SEP@SEP#SEP$SEP%SEP^SEP&SEP&SEP(SEP)SEP?SEP".."\10".."SEP	SEP😎SEP😈SEP💀SEPSepSEPSЕРSEPSeparatorSEPXDSEPLOLSEPXDSEPOOF","SEP")
	local context = ""
	amoutOfSymbols = amoutOfSymbols or math.random(1, 250)
	if amoutOfSymbols == 0 or amoutOfSymbols <= 0 or amoutOfSymbols == nil then
		amoutOfSymbols = math.random(1,250)
	end
	for i=1,amoutOfSymbols do
		local uorl = false
		if math.random(1,2) == 1 then
			uorl = true
		end
		local addSymbol = symbols[math.random(1,#symbols)]
		if uorl then
			addSymbol = string.upper(addSymbol)
		else
			addSymbol = string.lower(addSymbol)
		end
		context = context..addSymbol
	end
	return context
end

local function rs(times)
    local val = 0
    local times = math.max(tonumber(times) or 1, 1)
    
    for i=1, times do
        val = val +  game["Run Service"].Heartbeat:Wait()
    end
    
    return val / times
end

function esp(target,text,color)
	if target then
		text = text.Name:gsub("Moving", ""):gsub("OnTheWall", ""):gsub("Obtain", ""):gsub("Electrical", ""):gsub("Live", ""):gsub("PolePickup", ""):gsub("Setup", "") or target.Name
	end
    local function tracer(target)
        local Vector, OnScreen = cam:WorldToViewportPoint(target)
        local line = Drawing.new("Line")
        line.From = Vector2.new(0,0)
        line.To = Vector2.new(Vector.X,Vector.Y - 5)
        line.Color = color
        line.Thickness = 2
        line.Transparency = 0.2
        pcall(function()
            while task.wait() do
                line.Visible = (OnScreen and Toggles.tracer.Value)
            end
        end)
    end
	local function esp(target)
		local espDetected = false
		local fldr = nil
		if target and target.Parent then
			for i,v in pairs(target:GetChildren()) do
				if v and v.Parent and v:IsA("Folder") and string.match(string.lower(v:GetFullName()),"esp") then
					espDetected = true
					fldr = v
				end
			end
		end
		if target and target.Parent and not espDetected then
			local folder = Instance.new("Folder",target)
			folder.Name = "esp"..randomString()
			local esp = Instance.new("Highlight",folder)
			esp.OutlineColor = color
			esp.FillColor = color
			esp.Adornee = target
			esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			esp.OutlineTransparency = 0.75
			esp.OutlineTransparency = 0
			local bg = Instance.new("BillboardGui",folder)
			bg.Size = UDim2.fromOffset(100,100)
			bg.Brightness = 1
			bg.AlwaysOnTop = true
			bg.MaxDistance = 1000
			bg.Adornee = target
			local txt = Instance.new("TextLabel",bg)
			txt.Text = text
			txt.BackgroundTransparency = 1
			txt.Size = UDim2.fromScale(1,0.3)
			txt.AnchorPoint = Vector2.new(0.5,0.5)
			txt.Position = UDim2.fromScale(0.5,0.7)
			txt.FontFace = Font.new("rbxasset://fonts/families/Oswald.json")
			txt.TextScaled = true
			txt.TextColor3 = color - Color3.fromRGB(19, 15, 15)
			for i,v in pairs(folder:GetDescendants()) do
				if v then
					v.Name = randomString()
				end
			end
			coroutine.wrap(function()
				repeat
					esp.Adornee = nil
					esp.Adornee = target
					bg.Adornee = nil
					bg.Adornee = target
					if target and target.Parent then
						if Toggles.esp.Value then
							esp.Enabled = Toggles.esp.Value
							bg.Enabled = esp.Enabled
						else
							esp.Enabled = false
							bg.Enabled = esp.Enabled
						end
					end
                    esp.OutlineColor = color
                    esp.FillColor = color
                    txt.TextColor3 = color
					rs(1)
				until not target or not target:IsDescendantOf(workspace)
				rs(5)
				if target and target.Parent then
					if Toggles.esp.Value then
						esp.Enabled = Toggles.esp.Value
						bg.Enabled = esp.Enabled
					else
						esp.Enabled = false
						bg.Enabled = esp.Enabled
					end
				end
			end)()
		elseif target and target.Parent and espDetected and fldr then
			local esp =  fldr:FindFirstChildOfClass("Highlight")
			local bg = fldr:FindFirstChildOfClass("BillboardGui")
			local txt = fldr:FindFirstChildOfClass("BillboardGui"):FindFirstChildOfClass("TextLabel")
			esp.OutlineColor = color
			esp.FillColor = color
			txt.Text = text
			txt.TextColor3 = color
			coroutine.wrap(function()
				repeat
					esp.Adornee = nil
					esp.Adornee = target
					bg.Adornee = nil
					bg.Adornee = target
					if target and target.Parent then
						if Toggles.esp.Value then
							esp.Enabled = Toggles.esp.Value
							bg.Enabled = esp.Enabled
						else
							esp.Enabled = false
							bg.Enabled = esp.Enabled
						end
					end
                    esp.OutlineColor = color
                    esp.FillColor = color
                    txt.TextColor3 = color
					rs(1)
				until not target or not target:IsDescendantOf(workspace)
				rs(5)
				if target and target.Parent then
					if Toggles.esp.Value then
						esp.Enabled = Toggles.esp.Value
						bg.Enabled = esp.Enabled
					else
						esp.Enabled = false
						bg.Enabled = esp.Enabled
					end
				end
			end)()
		end
	end
	if not target:IsA("Instance") then return end
    tracer(target)
    esp(target)
end

-- remove esp
--[[
	function remove_esp()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Folder") and string.match(string.lower(v:GetFullName()),"esp") then v:Destroy() end
    end
	end
]]