-- made by joaopk
local StarterGui = game:GetService("StarterGui")

StarterGui:SetCore("SendNotification", {
	Title = "shaders by luay(joaopk)",
	Text = "aproveite o shaders e de uma olhada em mais scripts mais tarde!",
	Duration = 5
})

task.wait(1)

local function SafeLoad(url, name)
	local success, err = pcall(function()
		loadstring(game:HttpGet(url))()
	end)
	if success then
		warn("✔ Carregado:", name)
	else
		warn("✖ Erro ao carregar:", name, err)
	end
end

SafeLoad("https://raw.githubusercontent.com/higuysdorobloxjoaopk-maker/shaders/refs/heads/main/data/script/ShadersV2.luau", "Shaders")
task.wait(1)

SafeLoad("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua", "Emotes GUI")
task.wait(1)

SafeLoad("https://raw.githubusercontent.com/higuysdorobloxjoaopk-maker/shaders/refs/heads/main/data/script/Part%20control.luau", "Control parts")
