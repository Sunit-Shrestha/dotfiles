-- Meant to run at async context. (yazi system-clipboard)

local selected_or_hovered = ya.sync(function()
	local tab, paths = cx.active, {}
	for _, u in pairs(tab.selected) do
		paths[#paths + 1] = tostring(u)
	end
	if #paths == 0 and tab.current.hovered then
		paths[1] = tostring(tab.current.hovered.url)
	end
	return paths
end)

return {
	entry = function(self, job)
		ya.dbg("Clipboard", "args", job.args)
		self.notify_unknown_display_server = job.args.notify_unknown_display_server or false

		local action = job.args[1]

		if action == "copy" then
			return self:copy()
		elseif action == "cut" then
			return self:cut()
		else
			return self:notify_error("Unknown action: " .. tostring(job.args.action))
		end
	end,
	copy = function()
		ya.mgr_emit("escape", { visual = true })

		local urls = selected_or_hovered()

		if #urls == 0 then
			return ya.notify({ title = "System Clipboard", content = "No file selected", level = "warn", timeout = 5 })
		end

		-- ya.notify({ title = #urls, content = table.concat(urls, " "), level = "info", timeout = 5 })
		local clear = Command("cb"):arg("clear")
		local _, _ = clear:spawn():wait()

		local cmd = Command("cb"):arg("copy")
		for _, url in ipairs(urls) do
			cmd = cmd:arg(url)
		end

		local status, err = cmd:spawn():wait()

		if status and status.success then
			ya.notify({
				title = "System Clipboard",
				content = "Successfully copied the file(s) to system clipboard",
				level = "info",
				timeout = 5,
			})
		end

		if not status or not status.success then
			ya.notify({
				title = "System Clipboard",
				content = string.format(
					"Could not copy selected file(s): %s",
					status and tostring(status.code) or tostring(err)
				),
				level = "error",
				timeout = 5,
			})
		end
	end,
	cut = function()
		ya.mgr_emit("escape", { visual = true })

		local urls = selected_or_hovered()

		if #urls == 0 then
			return ya.notify({ title = "System Clipboard", content = "No file selected", level = "warn", timeout = 5 })
		end

		-- ya.notify({ title = #urls, content = table.concat(urls, " "), level = "info", timeout = 5 })
		local clear = Command("cb"):arg("clear")
		local _, _ = clear:spawn():wait()

		local cmd = Command("cb"):arg("cut")
		for _, url in ipairs(urls) do
			cmd = cmd:arg(url)
		end

		local status, err = cmd:spawn():wait()

		if status and status.success then
			ya.notify({
				title = "System Clipboard",
				content = "Successfully cut the file(s) to system clipboard",
				level = "info",
				timeout = 5,
			})
		end

		if not status or not status.success then
			ya.notify({
				title = "System Clipboard",
				content = string.format(
					"Could not cut selected file(s): %s",
					status and tostring(status.code) or tostring(err)
				),
				level = "error",
				timeout = 5,
			})
		end
	end,
}
