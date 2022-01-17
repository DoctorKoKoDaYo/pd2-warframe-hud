HUDPlayerPanel = class()

function HUDPlayerPanel:init(panel, main_player)
	self._is_main_player = main_player

	self._panel = panel:panel({
		w = 400
	})

	-- peer data (avatar + infamy)
	self._peer_info_panel = self._panel:panel({
		visible = not main_player,
		w = 32,
		h = 32
	})

	self._peer_avatar = self._peer_info_panel:bitmap({
		texture = "guis/textures/wfhud/avatar_placeholder",
		w = self._peer_info_panel:w(),
		h = self._peer_info_panel:h(),
		alpha = 0.75
	})

	self._peer_rank = self._peer_info_panel:text({
		align = "right",
		vertical = "bottom",
		text = "0",
		color = WFHud.colors.default,
		font = tweak_data.menu.medium_font,
		font_size = 20,
		layer = 1,
		w = self._peer_info_panel:w() - 4,
		h = self._peer_info_panel:h() + 2 -- font sizes be accurate for once smh
	})

	self._peer_info_panel:set_right(self._panel:w())


	-- healthbar
	local health_bar_w = main_player and 160 or 96
	self._health_bar = HUDHealthBar:new(self._panel, 0, 0, health_bar_w, main_player and 8 or 5, main_player and 40 or 16)
	self._health_bar._panel:set_right(main_player and self._panel:w() or self._peer_info_panel:x() - 4)


	-- level bar
	self._level_panel = self._panel:panel({
		visible = not main_player,
		x = self._health_bar._panel:x(),
		y = self._health_bar._panel:bottom() + 1,
		w = health_bar_w,
		h = main_player and 0 or 2,
		layer = -1
	})

	self._level_bar_bg = self._level_panel:bitmap({
		texture = "guis/textures/wfhud/bar",
		color = WFHud.colors.bg:with_alpha(0.5),
		w = self._level_panel:w(),
		h = self._level_panel:h(),
		layer = -1
	})

	self._level_bar = self._level_panel:bitmap({
		texture = "guis/textures/wfhud/bar",
		color = WFHud.colors.default,
		w = self._level_panel:w(),
		h = self._level_panel:h()
	})


	-- peer id
	self._peer_id_panel = self._panel:panel({
		x = self._level_panel:right() - 12,
		y = self._level_panel:bottom() + 3,
		w = 12,
		h = 12,
		layer = -1
	})

	self._peer_id_bg = self._peer_id_panel:bitmap({
		texture = "guis/textures/pd2/hud_progress_32px",
		w = self._peer_id_panel:h(),
		h = self._peer_id_panel:w()
	})

	self._peer_id_text = self._peer_id_panel:text({
		text = "0",
		font = tweak_data.menu.small_font_noshadow,
		font_size = 8,
		color = Color.black,
		align = "center",
		vertical = "center",
		layer = 1
	})


	-- name
	self._name_text = self._panel:text({
		text = "Player",
		font = tweak_data.menu.medium_font,
		font_size = 20,
		color = WFHud.colors.default,
		align = "right",
		y = self._level_panel:bottom(),
		w = self._level_panel:right() - (main_player and 20 or 16),
		layer = -1
	})

	self._panel:set_h(self._peer_id_panel:bottom())

	self._peer_info_panel:set_center_y(self._panel:h() * 0.5)
end

function HUDPlayerPanel:visible()
	return self._panel:visible()
end

function HUDPlayerPanel:set_visible(state)
	self._panel:set_visible(state)
end

function HUDPlayerPanel:set_peer_id(id)
	self._peer_id_text:set_text(id)

	if not id or self._is_main_player then
		return
	end

	local peer = managers.network:session():peer(id)
	if not peer then
		return
	end

	self._peer_rank:set_text(peer:rank())
	self._level_bar:set_w(self._level_bar_bg:w() * ((peer:level() or 0) / 100))

	local medium_res_done
	Steam:friend_avatar(Steam.SMALL_AVATAR, peer:user_id(), function (texture)
		if not medium_res_done then
			self._peer_avatar:set_image(texture)
		end
	end)
	Steam:friend_avatar(Steam.MEDIUM_AVATAR, peer:user_id(), function (texture)
		medium_res_done = true
		self._peer_avatar:set_image(texture)
	end)
end

function HUDPlayerPanel:set_name(name)
	self._name_text:set_text(name)
end

function HUDPlayerPanel:health_bar()
	return self._health_bar
end
