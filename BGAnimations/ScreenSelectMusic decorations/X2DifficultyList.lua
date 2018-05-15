local function LoadMetric(name, isBoolean)
	local metricValue = THEME:GetMetric("X2DifficultyList", name)
	assert(metricValue, "X2DifficultyList: can't load metric "..name)
	--only numbers and booleans are supported right now
	if isBoolean then
		return (metricValue == "true") or (metricValue=="1")
	else
		local n =tonumber(metricValue)
		assert(n, "SNDifficultyList: metric "..name.." must be a number")
		return n
	end
end

local hardColor = color "#FF0000"

local function DiffToColor(diff, dark)
	local color = CustomDifficultyToColor(ToEnumShortString(diff))
	if dark then
		return ColorDarkTone(color)
	else
		return color
	end
end

local function DiffBG( pn )
	if pn == PLAYER_1 then return color("#000058") end
	if pn == PLAYER_2 then return color("#580000") end
	return color("1,1,1,1")
end

--we need this function because we need to get the current Steps for non-human players.
--however, non-human players don't actually have a current Steps.
local function GetCurrentSteps(pn)
	if not GAMESTATE:IsHumanPlayer(pn) then
		return GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber())
	end
	return GAMESTATE:GetCurrentSteps(pn)
end

--returns true if any player has selected this difficulty.
local function AnyPlayerThisDiff(diff)
    for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
        if GetCurrentSteps(pn):GetDifficulty()==diff then return true end
    end
    return false
end

local function BothPlayersThisDiff(diff,self)
	if GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty()==diff and GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty()==diff then return true end
	return false
end

--this isn't really that useful for Extreme US, which doesn't hide charts.
--It is, however, useful for some later DDR games.
local difficultiesToDraw = {
    'Difficulty_Beginner',
    'Difficulty_Easy',
    'Difficulty_Medium',
    'Difficulty_Hard',
    'Difficulty_Challenge'
}

--if invDifficultiesToDraw[diff] exists, that difficulty
--should be drawn. for speeding up something down the line
local invDifficultiesToDraw = {}
for k, v in pairs(difficultiesToDraw) do
    invDifficultiesToDraw[v] = k
end

local function PlayerLabelName(pn)
	local name = GAMESTATE:IsHumanPlayer(pn) and string.lower(ToEnumShortString(pn)) or "cpu"
	return 'Badges/'..name
end

--the vertical position where items should start to be drawn
local startPos = LoadMetric "StartPositionY"
--the distance between items
local itemSpacingY = LoadMetric "ItemSpacingY"
--offsets for various other things.
local scorePos = LoadMetric "ScorePositionX"
local tickPos = LoadMetric "TickPositionX"
local plabelX = LoadMetric "PlayerLabelXOffset"

local lastSong = nil
local lastSteps = {PlayerNumber_P1=nil, PlayerNumber_P2=nil}

--calculates the Y position for the pill corresponding to the given difficulty
local function DiffToYPos(diff)
	if invDifficultiesToDraw[diff] == nil then return nil end
	return startPos + ( itemSpacingY*( invDifficultiesToDraw[diff]-1) )
end

local function SetXFromPlayerNumber(that, pn)
	if pn == 'PlayerNumber_P1' then
		that:x(-plabelX)
	elseif pn =='PlayerNumber_P2' then
		that:x(plabelX)
	end
end

local function SetXFromPlayerNumberScore(that, pn)
	if pn == 'PlayerNumber_P1' then
		that:x(-scorePos)
	elseif pn =='PlayerNumber_P2' then
		that:x(scorePos)
	end
end

--This is an update function and runs every frame.
--Check to see if either player has changed steps or the current song has changed.
--If so, some items probably need to be updated, so broadcast the SNDLUpdate message
--so they can update themselves if needed.
--SNDL stands for "SuperNOVA Difficulty List", which is where this code came from.
local function Update(self, _)
	if GAMESTATE then
		local song = GAMESTATE:GetCurrentSong()
		local steps = {}
		local anyStepsChanged = false
		for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
			steps[pn] = GetCurrentSteps(pn)
			if steps[pn] ~= lastSteps[pn] then anyStepsChanged = true break end
		end
		local songChanged = song~=lastSong
		if songChanged or anyStepsChanged then
			MESSAGEMAN:Broadcast("SNDLUpdate", {SongChanged=songChanged, StepsChanged=anyStepsChanged})
		end
		lastSong = song
		lastSteps = steps
	end
end

--This is the final actor frame everything ends up in.
local ret = Def.ActorFrame{InitCommand=function(self) self:xy(SCREEN_CENTER_X+4,SCREEN_CENTER_Y+100):draworder(2):queuecommand("On"):SetUpdateFunction(Update) end,
    }

--This updates the position of each player's currently selected item indicator.
--It is called in the SNDL update handlers for each of the badges.
local function IndicatorUpdate(self, pn)
    if not GAMESTATE:IsPlayerEnabled(pn) then return end
    self:finishtweening()
    local currentlyVisible = self:GetVisible()
    local steps = GetCurrentSteps(pn)
    if steps and GAMESTATE:GetCurrentSong() then
        if currentlyVisible then
            self:linear(0.1)
        end
        local yPos = DiffToYPos(steps:GetDifficulty())
        if yPos then
            self:visible(true)
            self:y(yPos-12)
						self:diffuse(color("1,1,1,1"))
            return
        end
    end
    --the current difficulty isn't visible, dim it
    self:visible(true)
		self:diffuse(color("0.5,0.5,0.5,1"))
end

--Creating a bunch of ActorFrames makes getting children harder, which was a
--concern when this code was originally being written. I still think they don't
--need to be there.
local function AddContentsToOutput(tbl)
    for _, e in pairs(tbl) do
        table.insert(ret, e)
    end
end

--create the player difficulty labels.
--(the do blocks are there so these chunks of code can have their own local variables)
do
    local indicatorBackgrounds = {}
    local indicatorLabels = {}
    for _, pn in pairs(PlayerNumber) do
        table.insert(indicatorLabels, LoadActor(PlayerLabelName(pn))..{
            Name='PlayerLabel',
            InitCommand=function(self) SetXFromPlayerNumber(self:visible(false), pn) self:zoom(1) end,
            SNDLUpdateMessageCommand=function(self) return IndicatorUpdate(self, pn) end,
            --ResolveRelativePath converts a local path into an absolute path
            --Sprite:Load does not work on local paths.
            --Also the function of this message is to replace a CPU label
            --with the appropriate player label for Battle
            PlayerJoinedMessageCommand=function(self,p)
                if p.Player==pn then self:Load(ResolveRelativePath(PlayerLabelName(pn),1)) end
            end
        })
    end
    AddContentsToOutput(indicatorBackgrounds)
    AddContentsToOutput(indicatorLabels)
end

--this is done once for each player to have separate full combo rings
for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
--draw the difficulty labels.
for idx, diff in pairs(difficultiesToDraw) do
	local element = Def.ActorFrame{
		OnCommand=cmd(diffusealpha,1);
		Name = "Row"..diff,
		--this is a leftover from long ago
		SNDLUpdateMessageCommand = function(self) for _, item in pairs(self:GetChildren()) do item:queuecommand("Update") end end,
		InitCommand=function(self) self:y(DiffToYPos(diff) ) end,
		Def.Sprite{
			Name = "Label",
			Texture = "Diff 1x5.png",
			InitCommand = function(self) self:setstate(idx-1):SetAllStateDelays(math.huge) end,
			SNDLUpdateMessageCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				if song then
					if AnyPlayerThisDiff(diff) then
						--difficulty currently selected. leftover from X2, where the item would
						--set a color in this case.
						self:setstate(idx-1):SetAllStateDelays(math.huge)
						self:diffuse(color("1,1,1,1"))
					elseif song:HasStepsTypeAndDifficulty(GAMESTATE:GetCurrentStyle():GetStepsType(), diff) then
						--difficulty present but not selected
						self:setstate(idx-1):SetAllStateDelays(math.huge)
						self:diffuse(color("1,1,1,1"))
					else
						--difficulty not present
						self:setstate(idx-1):SetAllStateDelays(math.huge)
						self:diffuse(color("0.5,0.5,0.5,1"))
					end
				else
					--no song selected, so act like there are no difficulties present
					self:setstate(idx-1):SetAllStateDelays(math.huge)
					self:diffuse(color("0.5,0.5,0.5,1"))
					self:diffusealpha(1)
				end
			end
		},
		Def.Sprite{
				Name = "TicksOver",
				Texture = "ticks",
				InitCommand = function(self) self:x(tickPos):y(-12):skewx(-0.9):diffuse(DiffToColor(diff)):halign(0):cropright(1):draworder(2) end,
				SNDLUpdateMessageCommand=function(self, params)
					--if there is a song and a chart for it, show the meter, otherwise show nothing
					local song = GAMESTATE:GetCurrentSong()
					if song then
						local steps = song:GetOneSteps(GAMESTATE:GetCurrentStyle():GetStepsType(), diff)
						if steps then
							local meter = steps:GetMeter()
							self:diffuse(DiffToColor(diff)):stopeffect():cropright(1-meter/10)
						else
							self:cropright(1)
						end
					else
						self:cropright(1)
					end
				end,
				CurrentSongChangedMessageCommand=function(self, params)
					--same as above
					local song = GAMESTATE:GetCurrentSong()
					if song then
						local steps = song:GetOneSteps(GAMESTATE:GetCurrentStyle():GetStepsType(), diff)
						if steps then
							local meter = steps:GetMeter()
							self:finishtweening()
							self:diffuse(DiffToColor(diff)):stopeffect():cropright(1):linear(0.2):cropright(1-meter/10)
						else
							self:cropright(1)
						end
					else
						self:cropright(1)
					end
				end,
		},
		--high score circle
		LoadActor("Grades/FC_Circle")..{
			InitCommand=function(self) SetXFromPlayerNumberScore(self:visible(false), pn) self:visible(false):xy(58,-2) end,
			SNDLUpdateMessageCommand=function(self, params)
				local song = GAMESTATE:GetCurrentSong()
				local st=GAMESTATE:GetCurrentStyle():GetStepsType()
				if song and song:HasStepsTypeAndDifficulty(st,diff) then
					local steps = song:GetOneSteps(st,diff)
					if PROFILEMAN:IsPersistentProfile(pn) then
						profile = PROFILEMAN:GetProfile(pn);
					else
						--fall back on the machine profile if there is no profile
						profile = PROFILEMAN:GetMachineProfile();
					end;
					scorelist = profile:GetHighScoreList(song,steps);
					assert(scorelist);
					local scores = scorelist:GetHighScores();
					assert(scores);
					local topscore=0;
					if scores[1] then
						topscore = scores[1]:GetScore();
					end
					assert(topscore);
					local topgrade;

					local temp=#scores;
					if scores[1] then
						--this skips blank high scores, but there won't be any
						--until after the last valid high score i think
						--only one score is actually checked
						for i=1, temp do
							if scores[i] then
								topscore = scores[i];
								assert(topscore);
								--even though in StepMania dropping holds/rolls 
								--doesn't break combo, we don't want to show the
								--FC badge unless the player didn't do that
								local misses = topscore:GetTapNoteScore("TapNoteScore_Miss")+topscore:GetTapNoteScore("TapNoteScore_CheckpointMiss")
												+topscore:GetTapNoteScore("TapNoteScore_HitMine")+topscore:GetHoldNoteScore("HoldNoteScore_LetGo")
								local boos = topscore:GetTapNoteScore("TapNoteScore_W5")
								local goods = topscore:GetTapNoteScore("TapNoteScore_W4")
								local greats = topscore:GetTapNoteScore("TapNoteScore_W3")
								local perfects = topscore:GetTapNoteScore("TapNoteScore_W2")
								local marvelous = topscore:GetTapNoteScore("TapNoteScore_W1")
								--filter out blank scores
								if (misses+boos+goods) == 0 and scores[i]:GetScore() > 0 and (marvelous+perfects+greats)>0 then
									self:visible(true)
									break;
								else
									self:visible(false)
									break;
								end;
							else
								self:visible(false)
								break
							end;
						end;
					else
						self:visible(false)
					end;
				else
					self:visible(false)
				end
			end;
		};
		--grade
		Def.Quad{
			InitCommand=function(self) SetXFromPlayerNumberScore(self:visible(false), pn) self:visible(false):xy(58,-2) end,
			SNDLUpdateMessageCommand=function(self, params)
				local song = GAMESTATE:GetCurrentSong()
				local st=GAMESTATE:GetCurrentStyle():GetStepsType()
				if song and song:HasStepsTypeAndDifficulty(st,diff) then
					local steps = song:GetOneSteps(st,diff)
					if PROFILEMAN:IsPersistentProfile(pn) then
						profile = PROFILEMAN:GetProfile(pn);
					else
						profile = PROFILEMAN:GetMachineProfile();
					end;
					scorelist = profile:GetHighScoreList(song,steps);
					assert(scorelist);
					local scores = scorelist:GetHighScores();
					assert(scores);
					local topscore=0;
					if scores[1] then
						topscore = scores[1]:GetScore();
					end
					assert(topscore);
					local topgrade;
					if scores[1] then
						topgrade = scores[1]:GetGrade();
						assert(topgrade);
						--show nothing unless points were actually earned
						if scores[1]:GetScore()>1 then
							--i don't think this condition will ever be true
							if scores[1]:GetScore()==1000000 and topgrade=="Grade_Tier07" then
								self:Load(THEME:GetPathB("","ScreenSelectMusic decorations/Grades/Diff Tier01"));
								self:visible(true)
							--show E for a very bad passing score
							elseif topgrade=="Grade_Tier07" or topgrade=="Grade_Failed" then
								self:visible(true)
								self:Load(THEME:GetPathB("","ScreenSelectMusic decorations/Grades/Diff Failed"));
							--hide grades this theme doesn't support
							elseif topgrade >= "Grade_Tier08" then
								self:visible(false)
							else
								self:Load(THEME:GetPathB("","ScreenSelectMusic decorations/Grades/Diff "..ToEnumShortString(topgrade)));
								self:visible(true)
							end;
						else
							self:Load(THEME:GetPathB("","ScreenSelectMusic decorations/Grades/Diff Failed"));
							self:visible(true)
						end;
					else
						self:Load(THEME:GetPathB("","ScreenSelectMusic decorations/Grades/Diff None"));
						self:visible(true)
					end;
					self:diffuse(color("1,1,1,1"))
				else
					self:Load(THEME:GetPathB("","ScreenSelectMusic decorations/Grades/Diff None"));
					self:visible(false)
					self:diffuse(color("0.5,0.5,0.5,1"))
				end
			end;
		},
		--high score star. code is identical to the high score circle
		Def.Sprite{
			Texture="Grades/FC_Star 4x1.png";
			InitCommand=function(self) SetXFromPlayerNumberScore(self:visible(false), pn) self:visible(false):xy(70,-10):SetAllStateDelays(0.4) end,
			SNDLUpdateMessageCommand=function(self, params)
				local song = GAMESTATE:GetCurrentSong()
				local st=GAMESTATE:GetCurrentStyle():GetStepsType()
				if song and song:HasStepsTypeAndDifficulty(st,diff) then
					local steps = song:GetOneSteps(st,diff)
					if PROFILEMAN:IsPersistentProfile(pn) then
						profile = PROFILEMAN:GetProfile(pn);
					else
						profile = PROFILEMAN:GetMachineProfile();
					end;
					scorelist = profile:GetHighScoreList(song,steps);
					assert(scorelist);
					local scores = scorelist:GetHighScores();
					assert(scores);
					local topscore=0;
					if scores[1] then
						topscore = scores[1]:GetScore();
					end
					assert(topscore);
					local topgrade;

					local temp=#scores;
					if scores[1] then
						for i=1, temp do

							if scores[i] then
								topscore = scores[i];
								assert(topscore);
								local misses = topscore:GetTapNoteScore("TapNoteScore_Miss")+topscore:GetTapNoteScore("TapNoteScore_CheckpointMiss")
												+topscore:GetTapNoteScore("TapNoteScore_HitMine")+topscore:GetHoldNoteScore("HoldNoteScore_LetGo")
								local boos = topscore:GetTapNoteScore("TapNoteScore_W5")
								local goods = topscore:GetTapNoteScore("TapNoteScore_W4")
								local greats = topscore:GetTapNoteScore("TapNoteScore_W3")
								local perfects = topscore:GetTapNoteScore("TapNoteScore_W2")
								local marvelous = topscore:GetTapNoteScore("TapNoteScore_W1")
								if (misses+boos+goods) == 0 and scores[i]:GetScore() > 0 and (marvelous+perfects+greats)>0 then
									self:visible(true)
									break;
								else
									self:visible(false)
									break;
								end;
							else
								self:visible(false)
								break
							end;
						end;
					else
						self:visible(false)
					end;
				else
					self:visible(false)
				end
			end;
		}
	}
	table.insert(ret, element)
end
end

return ret
