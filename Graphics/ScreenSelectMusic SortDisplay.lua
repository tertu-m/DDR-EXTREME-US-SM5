local t = Def.ActorFrame {
	Def.Sprite{
		BeginCommand=cmd(playcommand,"SetGraphic");
		SetGraphicCommand=function(self)
			local so = GAMESTATE:GetSortOrder();
			if so ~= nil then
				local sort = ToEnumShortString(so)
				self:Load(THEME:GetPathG("","_sort/_"..sort));
			end;
		end;
		SortOrderChangedMessageCommand=function(self)
			self:finishtweening()
			self:halign(1)
			self:accelerate(0.18)
			self:addx(180)
			self:queuecommand("SetGraphic");
			self:sleep(0.2)
			self:decelerate(0.18)
			self:addx(-180)
		end;
	};
};

return t;
