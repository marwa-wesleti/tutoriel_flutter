<?php
include("config.php");

$userName = $_POST['userName'];
$password = $_POST['password'];

$req = "select * from register where email='$userName' and pass='$password'";
$result = mysqli_query($connect, $req);
$data = array();
if(mysqli_num_rows($result)>0){
    while($row=mysqli_fetch_assoc($result)){
        $data[] = array(
            "id" =>$row["id"],
            "firstName" =>$row["firstName"],
            "lastName" =>$row["lastName"],
            "email" =>$row["email"],
            "mobile" =>$row["mobile"],
            "pass" =>$row["pass"],

        );
    }
    
    echo json_encode($data);
    mysqli_close($connect);
}
else{
    echo "user inexistant";
}
?>