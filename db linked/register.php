<?php
include_once 'ddr.php';


$id = $_POST['id'];
$name = $_POST['name'];
$age = $_POST['age'];
$email = $_POST['email'];

$sql = "INSERT INTO mydata (id,name,age,email) VALUES('$id','$name','$age','$email');";

$result = mysqli_query($connect , $sql);

header("location:form.php?signup=sucess");

?>