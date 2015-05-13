# Description
#   List all torreto can do
#
# Commands
#   torreto help

module.exports = (robot) ->
                 
  robot.respond /help/i, (msg) ->
    help_options["pull_requests"] = "\nPull Requests: I can list pull requests on your github repo for you. Just say \"list pull requests on <you_repo_name> of <your_name>\""
    help_options["branches"] = "\nBranches: I can list branches of your github repo for you. Just say \"list branches on <you_repo_name> of <your_name>\""
                    
    for option, desc of help_options
      msg.send desc
      
    msg.send "That's all I can do for you."
