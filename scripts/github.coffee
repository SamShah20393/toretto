# Descriptions:
#   Lazy to open github to see pull requets?
#
# Dependencies:
#   None
#
# Configuration:
#   Map names and github usernames in gihub_users hash
#
# Commands:
#   torreto list pull requests on <repo_name> of <name_mapped>
#   torreto list branches on <repo_name> of <name_mapped>
#
# Author:
#   avellable

module.exports = (robot) ->
  github_users = {"samkit": "SamShah20393", "mahesh": "avellable", "amit": "amiit-github"}

  robot.respond /pull requests on (.*) of (.*)/i, (res) ->
    user = github_users[escape(res.match[2])]
    repo_name = escape(res.match[1])
    res.http("https://api.github.com/repos/#{user}/#{repo_name}/pulls")
      .get() (err, resp, body) ->
        try
          json = JSON.parse(body)          
          if json.length == 0
            res.send "No pull requests found on #{repo_name}"
          else
            res.send "There are #{json.length} pull requests on repo #{repo_name}"
            str = ""
            str += "\n#{pull_request.id} -> #{pull_request.title} is [#{pull_request.state}] -> link: #{pull_request.url}" for pull_request in json
            res.send str
        catch err
          res.send "Something went wrong! "
          
  robot.respond /list branches on (.*) of (.*)/i, (res) ->
    user = github_users[escape(res.match[2])]
    repo_name = escape(res.match[1])
    res.http("https://api.github.com/repos/#{user}/#{repo_name}/branches")
      .get() (err, resp, body) ->
        try
          json = JSON.parse(body)
          if json.length == 0
            res.send "No branches found on #{repo_name}"
          else
            res.send "There are #{json.length} branches of #{repo_name}"
            str = ""
            str += "\n#{branch.name}" for branch in json 
            res.send str
        catch err
          res.send "Something went wrong!"
