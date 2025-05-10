-- main.lua (server-side logic)

-- Exemple : enregistrer un nouvel utilisateur Twitter
RegisterServerEvent('myPhone:createTwitterAccount')
AddEventHandler('myPhone:createTwitterAccount', function(username, password, avatar, identifier)
    local src = source
    MySQL.Async.execute('INSERT INTO twitter_accounts (username, password, avatar_url, identifier) VALUES (@username, @password, @avatar, @identifier)', {
        ['@username'] = username,
        ['@password'] = password,
        ['@avatar'] = avatar,
        ['@identifier'] = identifier
    }, function(rowsChanged)
        if rowsChanged > 0 then
            TriggerClientEvent('myPhone:twitterAccountCreated', src, true)
        else
            TriggerClientEvent('myPhone:twitterAccountCreated', src, false)
        end
    end)
end)

-- Exemple : publier un tweet
RegisterServerEvent('myPhone:postTweet')
AddEventHandler('myPhone:postTweet', function(authorId, realUser, message, image)
    local src = source
    MySQL.Async.execute('INSERT INTO twitter_tweets (authorId, realUser, message, image) VALUES (@authorId, @realUser, @message, @image)', {
        ['@authorId'] = authorId,
        ['@realUser'] = realUser,
        ['@message'] = message,
        ['@image'] = image
    }, function()
        TriggerClientEvent('myPhone:newTweet', -1, authorId, realUser, message, image)
    end)
end)

-- Exemple : récupérer les derniers tweets
RegisterServerEvent('myPhone:getTweets')
AddEventHandler('myPhone:getTweets', function()
    local src = source
    MySQL.Async.fetchAll('SELECT t.*, a.username, a.avatar_url FROM twitter_tweets t JOIN twitter_accounts a ON a.id = t.authorId ORDER BY t.time DESC LIMIT 50', {}, function(tweets)
        TriggerClientEvent('myPhone:receiveTweets', src, tweets)
    end)
end)
