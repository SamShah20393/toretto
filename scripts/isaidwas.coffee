module.exports = (robot) ->

  time_quotes = /// (hour|day|week|minute|months|moment|year)(s)* ///
  trigger_quotes = /// (remember|think|guess|dicuss)(ed)* ///
  important_quotes = /// (important|need|required|should|check|remember|keep|mind|like|great|reference|refer|idea)(ed)* ///
  
  class impTalk
  constructor: (name,) ->
    @name = name

  robot.hear /(.*)(good|better|important|need|required|should|check|remember|keep|mind|like|great)(ed)*(.*)/i, (res) ->
    res.reply("I hear you!")

  robot.hear /\?\?\?(.*)/i, (res) ->
    historyfor = res.message.room;
    room_id = robot.brain.get historyfor
    if !room_id
      url = "https://api.hipchat.com/v2/room?auth_token=1coJkivHvITLQx343j75ziWKvjZX5VHG1Faus4hz"
      robot.http(url)
        .get() (err, resp, body) ->
          if err
            res.send "(areyoukiddingme) I just wanted the rooms and I got stuck here : #{err} "
            return
          try  
            data = JSON.parse(body)
            makeroom room.name,room.id for room in data.items        
          catch error
            res.send "That went over my head: #{error} (jackie)"
            return
    else
      url = "https://api.hipchat.com/v2/room/#{room_id}/history?date=2015-05-12&timezone=Asia/Tokyo&format=json&auth_token=1coJkivHvITLQx343j75ziWKvjZX5VHG1Faus4hz"
      robot.http(url)
        .get() (err, resp, body) ->
          if err
            res.send "(areyoukiddingme) I just wanted the chat history and I got stuck here : #{err} "
            return
          try  
            data = JSON.parse(body)

            console.log data;        
          catch error
            res.send "That went over my head: #{error} (jackie)"
            return
      
  makeroom = (name, id) ->
    robot.brain.set 'rooms',true
    robot.brain.set name.toLowerCase(), id
    console.log "made room for #{name.toLowerCase()} at #{id}"

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