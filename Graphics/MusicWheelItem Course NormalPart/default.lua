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
			if Course then
				self:zoomx(0.9)
				self:zoomy(0.9)
				self:settext(Course:GetDisplayFullTitle());
				--local color_grp= group_colors[Song:GetGroupName()] or "FFFFFF"
				--self:diffuse(color(color_grp));
			end;
		end;
	};
};

return t;
