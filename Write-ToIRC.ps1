# Write a raw message to the socket
Function WriteToSocket ($msg) {
    $writer = New-Object IO.StreamWriter($conn.GetStream(), [Text.Encoding]::ASCII)
    $writer.WriteLine($msg)
    $writer.Flush()
    Sleep 2
}

# Handles cases where a server sends a PING challenge before allowing login
Function HandlePING {
    $reader = New-Object IO.StreamReader($conn.GetStream(), [Text.Encoding]::ASCII)
    do {
        $data = $reader.ReadLine()
        Sleep 1
    } while ($data -notlike 'PING *' -and $data -notlike '*MOTD*')
    
    if ($data -like 'PING *'){
        $pingChallenge = ($data -split ':')[1]
        WriteToSocket "PONG :$pingChallenge"
    }
}

# Gracefully log out of the IRC server
Function LogOutIRC {
    WriteToSocket "QUIT"
    $conn.Close()
    $conn.Dispose()
}

# Main function for the user that wraps everything above
Function WriteToIRC ($server, $port, $nick, $chan, $msg) {
    Sleep 1
    WriteToSocket "NICK $nick"
    WriteToSocket "USER $nick 0 * :..."
    HandlePING
    WriteToSocket "JOIN $chan"
    WriteToSocket "PRIVMSG $chan :$msg"
    LogOutIRC
}

# User-changeable values
$serv = "irc.irc4fun.net"
$port = "6667"
$nick = "testnick123"
$chan = "#testchannel567"
$msg  = "testing 1 2 3"

# Send the message
$conn = New-Object Net.Sockets.TcpClient($serv, $port)
WriteToIRC -nick $nick -chan $chan -msg $msg