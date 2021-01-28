# Sends a message to an IRC channel on a given server
Function WriteToIRC ($server, $port, $channel, $nick, $msg){
    # Connect
    $connection = New-Object Net.Sockets.TcpClient($server, $port)
    $stream = $connection.GetStream()
    $reader = New-Object IO.StreamReader($stream, [Text.Encoding]::ASCII)
    $writer = New-Object IO.StreamWriter($stream, [Text.Encoding]::ASCII)

    # Login
    $writer.WriteLine("NICK $nick"); $writer.Flush()
    $writer.WriteLine("USER $nick 0 * :..."); $writer.Flush()

    # Wait (may need adjustment if using a server other than open.ircnet.net)
    $reader.ReadLine() # Get the "please wait while we process your connection..."
    $reader.ReadLine() # Once the server responds a second time, it's ready for us to send commands

    # Write the message
    $writer.WriteLine("PRIVMSG $channel :$msg"); $writer.Flush()
    $reader.ReadLine() 

    # Logout
    $writer.WriteLine("QUIT"); $writer.Flush()
    $reader.ReadLine() 
    $connection.Close()
    $connection.Dispose()
}

# Test it out 
WriteToIRC -server "open.ircnet.net" -port "6667" -channel "#testchannel567" -nick "testnick123" -msg "testing 1 2 3"