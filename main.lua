local DiscordAPI = 'https://discord.com/api/v8/entitlements/gift-codes/'

function RequestAPIFunc(Code) 
    local Request = syn.request(
        {
            Url = DiscordAPI .. Code, 
            Method = 'GET',
            Headers = {
                ['Content-Type'] = 'application/json'
            },
        }
    )
    return Request
end 

local Letters = 'aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOqQpPrRsStTuUvVwWxXyYzZ'
local LettersConverted = Letters:split('')

function GenerateNitro()
    local Code = ''
    for i = 1, 24 do 
        Code = string.format('%s%s', Code, LettersConverted[math.random(1, #LettersConverted)])
    end 
    return Code
end 

local HttpService = game:GetService('HttpService')
local RequestJson 
local RequestGift 

local Code
while wait(5) do 
    Code = GenerateNitro()
    RequestJson = RequestAPIFunc(Code).Body
    RequestDecoded = HttpService:JSONDecode(RequestJson)
    if RequestDecoded.message ~= 'You are being rate limited.' then 
        if RequestDecoded.message == 'Unknown gift code.' then 
            print('[NOT WORKING] discord.gift/' .. Code .. ': ' .. RequestDecoded.message)
        else 
            print('[WORKING] discord.gift/' .. Code .. ': ' .. RequestDecoded.message)
        end
    else 
        print(RequestDecoded.retry_after)
    end 
end 
