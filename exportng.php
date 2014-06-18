<TITLE>
Extract and Download program
</TITLE>
<HEAD>
Welcome to the First Direct Marketing Extract Program<BR>

</HEAD>
<BODY>

<?php

$cid = $_POST['cid'];
$subcode = $_POST['subcode'];
$sttdate = $_POST['sttdate'];	
$enddate = $_POST['enddate'];
$reptype = $_POST['reptype'];

$host = '192.168.3.10';
$user = 'firstdirect';
$pass = 'FirstDirect01234';

$link = mysql_connect($host,$user,$pass);

mysql_select_db('services')
    or die('Could not select database');

print "<FORM METHOD='POST' ACTION='" . $_SERVER['PHP_SELF'] . "'>";

if (strlen($cid) < 1) {
    $link = mysql_connect($host,$user$pass);
    mysql_select_db('services')
        or die('Could not select cid database');
    $btop = "Select Campaign";
    print "<B>Select cid for extract:</B><BR>";
    print "<SELECT name='cid' SIZE=19>";

    $query = "SELECT DISTINCT cid FROM report,cid WHERE cid != 'Test' AND cid.abbr = report.abbr ORDER BY cid";
    $result = mysql_query($query)
	or die('SELECT cid Query failed: ' .  mysql_error());
    while ($cidlist = mysql_fetch_assoc($result)) {
	$cid = $cidlist['cid'];
        print "<OPTION value='$cid'>$cid</OPTION>";
    }
    print "<INPUT TYPE='HIDDEN' NAME='subcode' VALUE=''>";
    print "<INPUT TYPE='HIDDEN' NAME='reptype' VALUE=''>";
    print "<INPUT TYPE='HIDDEN' NAME='sttdate' VALUE=''>";
    print "<INPUT TYPE='HIDDEN' NAME='enddate' VALUE=''>";
    print "</SELECT><BR>\n";
} else if (strlen($subcode) == 0) {
    $btop = 'Select Effort Code';
    print "<B>Select Effort Code for $cid:</B><BR>";
    print "<SELECT name='subcode' SIZE=13>";
    $query = "SELECT DISTINCT subcode FROM contact WHERE cid = '$cid' AND reason = 'complete' ORDER BY subcode";
    $result = mysql_query($query)
	or die('SELECT code Query failed: ' .  mysql_error());
    while ($codelist = mysql_fetch_assoc($result)) {
	$subcode = $codelist['subcode'];
        print "<OPTION value='$subcode'>$subcode</OPTION>";
    }
    print "<OPTION value='ALL'>ALL</OPTION>";
    print "</SELECT><BR>\n";
    print "<INPUT TYPE='HIDDEN' NAME='cid' VALUE='$cid'>";
    print "<INPUT TYPE='HIDDEN' NAME='reptype' VALUE=''>";
    print "<INPUT TYPE='HIDDEN' NAME='sttdate' VALUE=''>";
    print "<INPUT TYPE='HIDDEN' NAME='enddate' VALUE=''>";
} else {
    $btop = 'Return to Campaign Selector';
    $query = "SELECT DISTINCT abbr FROM cid WHERE cid = '$cid'";
    $result = mysql_query($query)
	or die('SELECT date Query failed: ' .  mysql_error());
    if ($abbrlist = mysql_fetch_assoc($result)) {
		$abbr = $abbrlist['abbr'];
    } else {
		$abbr = 'CSV';
    }
#    print "cid = $cid<BR>";
#    print "Subcode = $subcode<BR>";
#    print "Extract date = $sttdate<BR>";

    $filename = "export$abbr-$subcode";

    $fullpath = "/usr/share/httpd/ets/exportfiles/$filename";
    $program = "/var/html/export '$abbr' '$cid' '$fullpath'";

#    print "File = $fullpath<BR>";
    print "<HR>";
    print "$program<BR>";
    $status = exec ($program);
    print "$status<BR>";
    print "<HR>";
    print "Download extract:<BR>";
    if (is_file($fullpath . '.dat')) {
        print "<A HREF='/exportfiles/$filename.dat'>$filename Data File</A><BR>";
    }
    if (is_file($fullpath . '.csv')) {
        print "<A HREF='/exportfiles/$filename.csv'>$filename CSV  File</A><BR>";
    }
    if (is_file($fullpath . '.xml')) {
        print "<A HREF='/exportfiles/$filename.xml'>$filename XML  File</A><BR>";
    }
    if (is_file($fullpath . '.zip')) {
        print "<A HREF='/exportfiles/$filename-".$enddate.".zip'>$filename ZIP  File</A><BR>";
    }
    if (is_file($fullpath . '-add.txt')) {
        print "<A HREF='/exportfiles/$filename-add.txt'>$filename Add File</A><BR>";
    }
    if (is_file($fullpath . '-inf.txt')) {
        print "<A HREF='/exportfiles/$filename-inf.txt'>$filename Error File</A><BR>";
    }
    if (is_file($fullpath . '-req.txt')) {
        print "<A HREF='/exportfiles/$filename-req.txt'>$filename Requal File</A><BR>";
    }
}
if (strlen($btop) == 0) {
    $btop = 'Option Selected';
}
print "<BR><INPUT TYPE='SUBMIT' VALUE='$btop'>";
print "</FORM>";

?>

</BODY>
