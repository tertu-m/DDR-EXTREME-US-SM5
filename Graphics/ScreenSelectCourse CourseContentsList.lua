local maxVisibleContents = 10 -- equivalent of MAX_VISIBLE_CONTENTS
local maxTotalContents = 56 -- equivalent of MAX_TOTAL_CONTENTS
local entryHeight = 40

return Def.ActorFrame{
	-- course contents list = rage
	Def.CourseContentsList{
		NumItemsToDraw=maxVisibleContents;
		MaxSongs=maxTotalContents;

		TransformFunction=function(self,offset,itemIndex,numItems)
			self:y(offset)
		end;

		BeginCommand=cmd(playcommand,"Set");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
		SetCommand=function(self)
			self:SetFromGameState()
			self:PositionItems()
			self:SetLoop(false)
		end;

		Display=Def.ActorFrame{
			InitCommand=cmd(setsize,280,40);

			-- entry number
			LoadFont("Common Course")..{
				InitCommand=cmd(x,-110);
				SetSongCommand=function(self,param)
					self:settext(param.Number)
				end;
			};

			-- textbanner
			Def.TextBanner{
				InitCommand=cmd(x,-89;y,4;zoom,0.9;Load,"TextBannerCourse";SetFromString,"","","","","","");
				SetSongCommand=function(self,param)
					if not param.Song or param.Secret then
						-- set fake ("??????????" with no artist)
						self:SetFromString("??????????","??????????", "","", "","")
					else
						-- set real
						self:SetFromSong(param.Song)
					end
				end;
			};

			-- if you can't do it the right way, do it the hacky way.
			LoadFont("Common Normal")..{
				Name="DifficultyMeter";
				InitCommand=cmd(x,100;y,12;zoom,0.8);
				SetSongCommand=function(self,param)
					self:settext(param.Meter)
					local difficulty = param.Difficulty
					local customDiff = GetCustomDifficulty(param.Steps:GetStepsType(),difficulty,nil)
					self:diffuse(CustomDifficultyToColor(customDiff))
				end;
			};
		};
	};
};
