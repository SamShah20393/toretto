module.exports = (robot) ->

  robot.hear /pull requests (.*)/i, (res) ->
    repo_name = escape(res.match[1])
    res.http("https://api.github.com/repos/SamShah20393/#{repo_name}/pulls")
      .get() (err, resp, body) ->
        try
          json = JSON.parse(body)          
          res.send "There are #{json.length} pull requests on repo #{repo_name}"
          str = ""
          str += "\n#{pull_request.id} -> #{pull_request.title} is [#{pull_request.state}] -> link: #{pull_request.url}" for pull_request in json
          res.send str
        catch error
          res.send "No pull requests found on #{repo_name}"
