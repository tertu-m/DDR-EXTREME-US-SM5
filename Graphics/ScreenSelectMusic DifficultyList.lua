-- todo: make the bar show top half of P1 and bottom half of P2 if both occupy
-- the same location.

return Def.StepsDisplayList {
	Name="StepsDisplayListRow";
	CurrentSongChangedMessageCommand=function(self)
		self:visible(GAMESTATE:GetCurrentSong() ~= nil);
	end;
	CursorP1 = Def.ActorFrame {
		InitCommand=cmd(player,PLAYER_1);
		OnCommand=cmd(addx,58;addy,9);
		OffCommand=cmd();
		HideCommand=cmd(linear,.1;zoomy,1);
		ShowCommand=cmd(linear,.1;zoomy,1);
		ChangeCommand=cmd(stoptweening;linear,0);
		MoveCommand=cmd(glow,color("1,1,1,1");linear,.1;glow,color("1,1,1,0"));
		PlayerJoinedMessageCommand=function(self,param)
			if param.Player == PLAYER_1 then
				self:player(PLAYER_1);
				self:playcommand("Show");
			end;
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"PositionCheck");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"PositionCheck");

		LoadActor( THEME:GetPathG("DifficultyList", "cursor") )..{
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"PositionCheck");
			CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"PositionCheck");
			PositionCheckCommand=function(self)
				-- only bother if > 1p
				if GAMESTATE:GetNumPlayersEnabled() > 1 then
					if GAMESTATE:GetCurrentSong() then
						local p1Steps = GAMESTATE:GetCurrentSteps(PLAYER_1);
						local p2Steps = GAMESTATE:GetCurrentSteps(PLAYER_2);
						if p1Steps:GetDifficulty() == p2Steps:GetDifficulty() then
							-- crops
							self:linear(0.25);
							self:cropbottom(0.5);
						else
							-- no crops
							self:linear(0.25);
							self:cropbottom(0);
						end;
					end;
				end;
			end;
		};
	};
	CursorP2 = Def.ActorFrame {
		InitCommand=cmd(player,PLAYER_2);
		OnCommand=cmd(addx,58;addy,9);
		OffCommand=cmd();
		HideCommand=cmd(linear,.1;zoomy,0);
		ShowCommand=cmd(linear,.1;zoomy,1);
		ChangeCommand=cmd(stoptweening;linear,0);
		MoveCommand=cmd(glow,color("1,1,1,1");linear,.1;glow,color("1,1,1,0"));
		PlayerJoinedMessageCommand=function(self,param)
			if param.Player == PLAYER_2 then
				self:player(PLAYER_2);
				self:playcommand("Show");
			end;
		end;

		LoadActor( THEME:GetPathG("DifficultyList", "cursor") )..{
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"PositionCheck");
			CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"PositionCheck");
			PositionCheckCommand=function(self)
				-- only bother if > 1p
				if GAMESTATE:GetNumPlayersEnabled() > 1 then
					if GAMESTATE:GetCurrentSong() then
						local p1Steps = GAMESTATE:GetCurrentSteps(PLAYER_1);
						local p2Steps = GAMESTATE:GetCurrentSteps(PLAYER_2);
						if p1Steps:GetDifficulty() == p2Steps:GetDifficulty() then
							-- croptops
							self:linear(0.25);
							self:croptop(0.5);
						else
							-- no crops
							self:linear(0.25);
							self:croptop(0);
						end;
					end;
				end;
			end;
		};
	};
	CursorP1Frame = Def.Actor{
		ChangeCommand=cmd(stoptweening;decelerate,0.125);
	};
	CursorP2Frame = Def.Actor{
		ChangeCommand=cmd(stoptweening;decelerate,0.125);
	};
};
