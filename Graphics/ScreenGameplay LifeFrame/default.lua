-- gameplay life frame
local lifeFrame = "normal"

-- todo: show oni on life meter battery as well
if GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
	lifeFrame = "oni"
end

if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then lifeFrame = "rave" end
if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then lifeFrame = "extra" end

local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(x,SCREEN_CENTER_X-172);
	OnCommand=function(self)
		if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then
			self:zoomy(-1)
		else
			self:zoomy(1)
		end;
	end;
	LoadActor("Frame_PlayerNumber_P1")..{
		OnCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
				self:diffuse(color("1,1,1,1"));
			else
				self:diffuse(color("0.5,0.5,0.5,1"));
			end;
		end;
	};
	LoadActor("Highlight")..{
		InitCommand=cmd(blend,Blend.Add;cropright,1;diffusealpha,0.5;queuecommand,"Anim";player,PLAYER_1);
		AnimCommand=cmd(diffusealpha,0.5;cropright,1;sleep,0.2;linear,1;cropright,0;diffusealpha,0;sleep,0.2;queuecommand,"Anim");
	};
};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(x,SCREEN_CENTER_X+172);
	OnCommand=function(self)
		if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then
			self:zoomy(-1)
		else
			self:zoomy(1)
		end;
	end;
	LoadActor("Frame_PlayerNumber_P2")..{
		OnCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
				self:diffuse(color("1,1,1,1"));
			else
				self:diffuse(color("0.5,0.5,0.5,1"));
			end;
		end;
	};
	LoadActor("Highlight")..{
		InitCommand=cmd(blend,Blend.Add;cropleft,1;diffusealpha,0.5;queuecommand,"Anim";player,PLAYER_2);
		AnimCommand=cmd(diffusealpha,0.5;cropleft,1;sleep,0.2;linear,1;cropleft,0;diffusealpha,0;sleep,0.2;queuecommand,"Anim");
	};
};

t[#t+1] = LoadActor("flicker")

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(x,SCREEN_CENTER_X-172);
	Def.ActorFrame{
		InitCommand=cmd(x,-126);
		LoadActor("Badge_1P");
		LoadActor("Anim_Off_1P.png")..{
			OnCommand=function(self)
				if GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
					self:visible(false)
				else
					self:visible(true)
					self:diffuse(color("0.5,0.5,0.5,1"))
				end;
			end;
		};
		Def.Sprite{
			Texture="Anim_Normal_1P 8x1.png";
			InitCommand=function(self, params)
				self:SetAllStateDelays(0.05)
				if GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
					self:visible(true)
				else
					self:visible(false)
				end;
			end;
			HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == PLAYER_1 then
					if param.HealthState == "HealthState_Hot" then
						self:Load(THEME:GetPathG("","ScreenGameplay LifeFrame/Anim_Hot_1P 3x1.png"))
						self:SetAllStateDelays(0.1)
					else
						self:Load(THEME:GetPathG("","ScreenGameplay LifeFrame/Anim_Normal_1P 8x1.png"))
						self:SetAllStateDelays(0.05)
					end
				end
			end;
		};
	};
};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(x,SCREEN_CENTER_X+172);
	Def.ActorFrame{
		InitCommand=cmd(x,126);
		LoadActor("Badge_2P");
		LoadActor("Anim_Off_2P.png")..{
			OnCommand=function(self)
				if GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
					self:visible(false)
				else
					self:visible(true)
					self:diffuse(color("0.5,0.5,0.5,1"))
				end;
			end;
		};
		Def.Sprite{
			Texture="Anim_Normal_2P 8x1.png";
			InitCommand=function(self, params)
				self:SetAllStateDelays(0.05)
				if GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
					self:visible(true)
				else
					self:visible(false)
				end;
			end;
			HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == PLAYER_2 then
					if param.HealthState == "HealthState_Hot" then
						self:Load(THEME:GetPathG("","ScreenGameplay LifeFrame/Anim_Hot_2P 3x1.png"))
						self:SetAllStateDelays(0.1)
					else
						self:Load(THEME:GetPathG("","ScreenGameplay LifeFrame/Anim_Normal_2P 8x1.png"))
						self:SetAllStateDelays(0.05)
					end
				end
			end;
		};
	};
};

return t;
