module.exports = (robot) ->
  robot.brain.set 'totalSodas', 15
  console.log "@@@@@@@@@@@@@@@@@@@@@@@@@"
  robot.hear /\?\?\?(.*)/i, (res) ->
    url = "https://api.hipchat.com/v2/room?auth_token=1coJkivHvITLQx343j75ziWKvjZX5VHG1Faus4hz"
    robot.http(url)
      .get() (err, resp, body) ->
        if err
          res.send "(areyoukiddingme) I just wanted the rooms and I got stuck here : #{err} "
          return
        try  
          data = JSON.parse(body)
          makeroom room.name,room.id for room in data.items
          robot.brain.set data.items[0].name, data.items[0].id

          res.send " I am in #{data.items[0].name} #{data.items[0].id}"  
        catch error
          res.send "That went over my head: #{err} (jackie)"
          return 
        console.log data
        room = res.message.id
        console.log room
        room = res.message.room
        console.log room
        room = res.message.user.id       
        console.log room
        room = res.message.user.name       
        console.log room

  makeroom = (name, id) ->
    robot.brain.set name, id
    console.log "made room for #{name} at #{id}"

  robot.respond /have more soda/i, (res) ->
    # Get number of sodas had (coerced to a number).
    robot.brain.set 'totalSodas', 15
    sodasHad = robot.brain.get 'totalSodas'
    if sodasHad > 4
      res.reply "I'm too fizzy.."
    else
      res.reply 'Sure!'
    robot.brain.set 'totalSodas', sodasHad+1
    res.send "total #{sodasHad}"

  robot.respond /sleep it off/i, (res) ->
    robot.brain.set 'totalSodas', 0
    msg.reply 'zzzzz'