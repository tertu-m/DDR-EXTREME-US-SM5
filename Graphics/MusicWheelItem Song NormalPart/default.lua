local t = Def.ActorFrame {};


t[#t+1] = Def.ActorFrame{
	CurrentSongChangedMessageCommand=cmd(queuecommand,"SetMessage");
	--Title/Subtitle
	Def.BitmapText{
		Font="_eurostilet Bold 30px";
		InitCommand=cmd(maxwidth,200;wrapwidthpixels,2^24;strokecolor,color("#010f8c"));
		SetMessageCommand=function(self, param)
			local Song = param.Song;
			local Course = param.Course;
			if Song then
				self:zoomx(0.9)
				self:zoomy(0.9)
				self:settext(Song:GetDisplayMainTitle());
				--local color_grp= group_colors[Song:GetGroupName()] or "FFFFFF"
				--self:diffuse(color(color_grp));
				if param.HasFocus then
					self:x(2);
					self:y(-20);
				else
					self:x(0);
					self:y(-6.4)
				end;
			end;
		end;
	};
	Def.BitmapText{
		Font="_eurostilet Bold 30px";
		InitCommand=cmd(zoom,0.5;maxwidth,200;wrapwidthpixels,2^24;strokecolor,color("#010f8c"));
		SetMessageCommand=function(self, param)
			local Song = param.Song;
			local Course = param.Course;
			if Song then
				self:zoomx(0.5)
				self:zoomy(0.5)
				self:settext(Song:GetDisplaySubTitle());
				--local color_grp= group_colors[Song:GetGroupName()] or "FFFFFF"
				--self:diffuse(color(color_grp));
				if param.HasFocus then
					self:finishtweening()
					self:x(2);
					self:y(-5);
				else
					self:finishtweening()
					self:x(0);
					self:y(10)
				end;
			end;
		end;
	};
};

return t;
