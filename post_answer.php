<?php
// Include the database configuration file
include 'connection.php';

// Receive test ID and question id
$attemptID = $_POST['attemptID'];
$questionID = $_POST['questionID'];
$answerID = $_POST['answerID'];

// Insert answer record
$sql = "INSERT INTO tbl_user_answer (attemptID, questionID, answerID) 
		VALUES ('".$attemptID."', '".$questionID."', '".$answerID."')";
$conn->query($sql);

exit;
?>