local StarterGui = game:GetService("StarterGui")

StarterGui:SetCore("SendNotification", {
	Title = "shaders by luay(joaopk)",
	Text = "aproveite o shaders e de uma olhada em mais scripts mais tarde!",
	Duration = 5
})

task.wait(5)
loadstring(game:HttpGet("https://raw.githubusercontent.com/higuysdorobloxjoaopk-maker/shaders/refs/heads/main/data/script/Shaders.luau"))()

loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"))()

loadstring(game:HttpGet("https://raw.githubusercontent.com/higuysdorobloxjoaopk-maker/shaders/refs/heads/main/data/script/ant-fling.lua"))()
