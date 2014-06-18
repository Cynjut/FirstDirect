<?php
function foo($arg_1, $arg_2, /* ..., */ $arg_n) {
    echo "Example function.\n";
    return $retval;
}

function open_db($host, $user, $pass) {

    $link = mysql_connect($host, $user, $pass)
        or die('Could not connect: ' .  mysql_error());

    mysql_select_db('firstdirect')
        or die('Could not select database');
        
    return $link;
}

?>
