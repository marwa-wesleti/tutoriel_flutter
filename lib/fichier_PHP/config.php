<?php
$host="localhost";
$userName = "root";
$db_name="testdatabase"; //change databasename

$connect=mysqli_connect($host,$userName,"",$db_name);

if(!$connect)
{
	echo json_encode("Connection Failed");
}

?>