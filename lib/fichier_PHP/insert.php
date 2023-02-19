<?php
include "config.php";
// REGISTER USER

    $firstName = mysqli_real_escape_string($connect, $_POST['firstName']);
    $lastName = mysqli_real_escape_string($connect, $_POST['lastName']);
    $email = mysqli_real_escape_string($connect, $_POST['email']);
    $mobile = mysqli_real_escape_string($connect, $_POST['mobile']);
    $password = mysqli_real_escape_string($connect, $_POST['password']);

    $qEmail = "select * from register where email='$email'";
    $resEmail=mysqli_query($connect,$qEmail);
    if(mysqli_num_rows($resEmail)>0){
    echo  json_encode("user exist"); 
    }
    else{
    
        $query = "INSERT INTO register VALUES(Null,'$firstName','$lastName', '$email','$mobile','$password')";
    $results = mysqli_query($connect, $query);
    if($results>0)
    {
        echo  json_encode("successfull");
    }
}
?>