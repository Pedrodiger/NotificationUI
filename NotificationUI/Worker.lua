local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NotificationRemoteEvent = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("Notification")
local ScreenGui = script.Parent
local Frame = ScreenGui.Main
local Title = Frame.Title
local Text = Frame.Text
local StartingPosition = UDim2.fromScale(1.5,Frame.Position.Y.Scale)
local EndPosition = Frame.Position
Frame.Position = StartingPosition
local isRunning = false
local tasks = {}

local function Display(Info)
	isRunning = true
	table.remove(tasks, table.find(tasks, Info))
	Title.Text = Info[1]
	Text.Text = Info[2]
	Frame:TweenPosition(EndPosition,Enum.EasingDirection.Out,Enum.EasingStyle.Sine,0.5,true)
	wait(2)
	Frame:TweenPosition(StartingPosition,Enum.EasingDirection.Out,Enum.EasingStyle.Sine,0.5,true)
	wait(0.5)

	if #tasks > 0 then
		Display(tasks[1])
	else
		isRunning = false
	end
end

spawn(function()
NotificationRemoteEvent.OnClientEvent:Connect(function(title,text)
	table.insert(tasks,{title,text})
	if not isRunning then
		Display(tasks[1])
	end
end)
end)
