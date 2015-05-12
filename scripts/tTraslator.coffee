# tTranslator.coffee
# returns the japanese word tagged word

module.exports = (robot) ->


  robot.hear /#(.*)/i, (res) ->
    word = res.match[1]
    lang = "en"
    url = "https://www.googleapis.com/language/translate/v2?key=AIzaSyBfy0SB_eRGbNC-0sVo6qTS9NGex8fo_2s&target=en&q=#{word}"
    console.log(url);
    robot.http(url)
      .get() (err, resp, body) ->
        if err
          res.send "Got stuck here : #{err} (areyoukiddingme)"
          return
        try  
          data = JSON.parse(body)
        catch error
          res.send "That went over my head: #{err} (jackie)"
          return 
        lang = data.data.translations[0].detectedSourceLanguage
        if lang is 'en'
          url = "https://www.googleapis.com/language/translate/v2?key=AIzaSyBfy0SB_eRGbNC-0sVo6qTS9NGex8fo_2s&source=en&target=ja&q=#{word}"
          console.log url
          robot.http(url)
          .get() (err, resp, body) ->
            if err
              res.send "Got stuck here : #{err} (areyoukiddingme)"
              return
            try  
              data = JSON.parse(body)
            catch error
              res.send "That went over my head: #{err} (jackie)"
              return 
            res.send "#{word} / #{data.data.translations[0].translatedText}"
        else
          res.send "#{word} / #{data.data.translations[0].translatedText}"
