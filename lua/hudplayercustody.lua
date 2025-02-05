Hooks:PostHook(HUDPlayerCustody, "init", "init_wfhud", function (self)
	local custody_panel = self._hud_panel:child("custody_panel")
	local timer_msg = custody_panel:child("timer_msg")

	timer_msg:set_font(WFHud.font_ids.default)
	timer_msg:set_font_size(WFHud.font_sizes.default)
	timer_msg:set_h(WFHud.font_sizes.default)
	timer_msg:set_top(custody_panel:h() * 0.15)

	self._timer:set_font(WFHud.font_ids.bold)
	self._timer:set_font_size(WFHud.font_sizes.default)
	self._timer:set_h(WFHud.font_sizes.default)
	self._timer:set_top(timer_msg:bottom())
end)
