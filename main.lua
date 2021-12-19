local function httpGet(link)
	local studio = game:GetService("RunService"):IsStudio();
	if studio then
		return game.ReplicatedStorage.ReturnGames:InvokeServer(link)
	else
		return game:HttpGet(link)
	end
end

local loadstring = function(x)
	local studio = game:GetService("RunService"):IsStudio();
	if studio then
		return game.ReplicatedStorage.ReturnGames:InvokeServer(x)
	else
		return loadstring(x)
	end
end

local function search_for_Games()
	local games = httpGet("https://raw.githubusercontent.com/zxmp/surm/main/games/list.json")
	local decoded = game:GetService("HttpService"):JSONDecode(games)
	for i,v in paris(decoded) do
		if v.script and v.placeid == game.PlaceId then
			return i, true, v.script
		end
	end
	return "no game found", false, nil
end

local index, getstatus, scr = search_for_Games()

if getstatus then
	loadstring(httpGet(scr))
end
