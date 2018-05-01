local beginTime = GetTimeSinceStart()
local lastSeenTime = beginTime
local flickerState = false
local FlickerLog = nil
local FlickerPrint = nil
if SN3Debug then
    local flickerRecord = {}
    FlickerLog = function()
        table.insert(flickerRecord, true)
    end
    local oldDiff = 0
    FlickerPrint = function()
        local diff = math.floor(lastSeenTime-beginTime)
        if (diff % 15 == 0) and (diff ~= oldDiff) then
            oldDiff = diff
            SCREENMAN:SystemMessage("flicker debug: flickered avg "..tostring((#flickerRecord)/15).."Hz over last 15 sec")
            flickerRecord = {}
        end
    end
end

local targetDelta = 1/60

local timer = GetUpdateTimer(targetDelta)
local function FlickerUpdate(self, _)
    lastSeenTime = GetTimeSinceStart()
    if FlickerPrint then FlickerPrint() end
    if not timer() then return end
    if FlickerLog then FlickerLog() end
    flickerState = not flickerState

    for pn, item in pairs(self:GetChildren()) do
        item:visible((GAMESTATE:GetPlayerState(pn):GetHealthState() == 'HealthState_Hot')
            and flickerState)
    end

end

if light then FlickerUpdate = nil end

local host = Def.ActorFrame{
    Name = "HotLifeFlicker",
    --don't use this flicker method in light mode
    InitCommand = function(self) self:SetUpdateFunction(FlickerUpdate) end;
    OffCommand = function(self) self:sleep(0.792):queuecommand("Terminate") end;
    TerminateCommand = function(self) self:SetUpdateFunction(nil) end;
}

local xPosPlayer = {
    P1 = SCREEN_CENTER_X-172,
    P2 = SCREEN_CENTER_X+172
}

local LifeChangedHandler
if light then
    LifeChangedHandler = function(s, params)
        if params.LifeMeter:IsHot() then
            s:visible(true):diffuseblink():effectcolor1{0,0,0,0.5}:effectcolor2(0,0,0,0):effectperiod(targetDelta)
        else
            s:stopeffect():visible(false)
        end
    end
else
    LifeChangedHandler=function() end
end

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
    table.insert(host,LoadActor("FrameFlash_"..pn)..{
        Name = pn,
        InitCommand=function(self)
            local short = ToEnumShortString(pn)
            self:visible(false):x(xPosPlayer[short])
        end,
		OnCommand=function(self)
		if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then
			self:zoomy(-1)
		else
			self:zoomy(1)
		end;
	end;
        LifeChangedMessageCommand=LifeChangedHandler,
        OffCommand=function(s) s:sleep(0.792):visible(false) end
    })
end
return host
