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
 )(...)
( function (...) StarterGui:SetCore("\083\101\110\100\078\111\116\105\102\105\099\097\116\105\111\110", { Title = "\109\097\100\101\032\098\121\032\108\117\097\117\032\083\099\114\105\112\116\115", Text = "\099\114\101\097\116\111\114\032\061\032\106\111\097\111\112\107", Duration = 0x5 }) end
 )(...)
