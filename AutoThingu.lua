while wait(1) do
	game:GetService("ReplicatedStorage").RemoteEvents.Notification:FireAllClients("Warning!", "Core is offline and about to explode!")
end
