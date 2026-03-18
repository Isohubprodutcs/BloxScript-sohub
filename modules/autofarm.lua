local AutoFarm = {}

local QuestData = {
    {
        Min = 1, Max = 10,
        Monster = "Bandit",
        QuestName = "BanditQuest1",
        Level = 1,
        QuestPos = CFrame.new(1060, 16, 1547)
    },
    {
        Min = 10, Max = 30,
        Monster = "Monkey",
        QuestName = "JungleQuest",
        Level = 1,
        QuestPos = CFrame.new(-1600, 36, 150)
    }
}

-- Level al
local function GetLevel(Core)
    return Core.Player.Data.Level.Value
end

-- Quest bul
local function GetQuest(Core)
    local level = GetLevel(Core)

    for _, q in pairs(QuestData) do
        if level >= q.Min and level <= q.Max then
            return q
        end
    end
end

-- Quest al
local function TakeQuest(Core, quest)
    local npc = workspace.NPCs:FindFirstChild(quest.QuestName)

    if npc then
        Core.Modules.Tween.MoveTo(Core, quest.QuestPos.Position)
        task.wait(1)

        -- Remote (oyuna göre değişebilir)
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", quest.QuestName, quest.Level)
    end
end

-- Enemy bul
local function GetEnemy(Core, name)
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v.Name == name and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
            return v
        end
    end
end

-- Attack (basit)
local function Attack(Core)
    local tool = Core.Character:FindFirstChildOfClass("Tool")
    if tool then
        tool:Activate()
    end
end

-- MAIN
function AutoFarm.Start(Core)

    Core.CreateLoop("AutoFarm", function()

        if not Core.Config.AutoFarm then return end

        local quest = GetQuest(Core)
        if not quest then return end

        -- Quest kontrol
        if not Core.Player.PlayerGui:FindFirstChild("Quest") then
            TakeQuest(Core, quest)
            return
        end

        -- Enemy bul
        local enemy = GetEnemy(Core, quest.Monster)

        if enemy then
            local pos = enemy.HumanoidRootPart.Position + Vector3.new(0, 5, 0)

            Core.Modules.Tween.MoveTo(Core, pos)

            -- Yakınsa vur
            if (Core.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude < 10 then
                Attack(Core)
            end
        else
            -- Enemy yoksa quest yerine git
            Core.Modules.Tween.MoveTo(Core, quest.QuestPos.Position)
        end

    end)
end

function AutoFarm.Stop(Core)
    Core.StopLoop("AutoFarm")
end

return AutoFarm