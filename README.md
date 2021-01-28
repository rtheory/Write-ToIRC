# Write-ToIRC
Powershell method of sending simple text data to an IRC server and channel

This is a PoC for an extremely light-weight and minimalized way of sending a message to an IRC channel via Powershell. It is not intended to offer any client interactions or bot functionality. If you need a more fully-featured client/bot, take a look at projects like [Run-IrcBot](https://github.com/alejandro5042/Run-IrcBot).

Simply change the parameters for your needs. You can verify it works by visiting the server and channel on another IRC client, and then running the line: 

`WriteToIRC -server "open.ircnet.net" -port "6667" -channel "#testchannel567" -nick "testnick123" -msg "testing 1 2 3"`

This was tested on open.ircnet.net. If you use another server and the message does not arrive, you may need to customize the "wait" section based on how that server responds. 
