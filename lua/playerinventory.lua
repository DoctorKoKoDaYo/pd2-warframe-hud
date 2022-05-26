Hooks:PostHook(PlayerInventory, "_start_jammer_effect", "_start_jammer_effect_wfhud", function (self)
	WFHud:add_buff("player", "pocket_ecm_jammer_base", nil, self._jammer_data.t - TimerManager:game():time())
end)

Hooks:PostHook(PlayerInventory, "_stop_jammer_effect", "_stop_jammer_effect_wfhud", function (self)
	WFHud:remove_buff("player", "pocket_ecm_jammer_base")
end)

Hooks:PostHook(PlayerInventory, "_start_feedback_effect", "_start_feedback_effect_wfhud", function (self)
	WFHud:add_buff("player", "pocket_ecm_jammer_base", nil, self._jammer_data.t - TimerManager:game():time())
end)

Hooks:PostHook(PlayerInventory, "_stop_feedback_effect", "_stop_feedback_effect_wfhud", function (self)
	WFHud:remove_buff("player", "pocket_ecm_jammer_base")
end)
