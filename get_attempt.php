<?php
// Include the database configuration file
include 'connection.php';

// Receive user name and testID
$name = $_GET['name']; 
$testID = $_GET['test_id'];

// Get user ID
$userID=getUserID($name,$conn);

// Get attempt ID
$attemptID = getAttemptID($userID,$testID, $conn);

// Get total question count
$question_count = getQuestionCount($testID, $conn);

// Get answered question count
$answered_question_count = getAnsweredQuestionCount($attemptID, $conn);

// Get question IDs JSON list
$questions = getQuestionIDs($testID, $conn);
$question_array=json_encode($questions);

// JSON Row 
$json = array("answered_question_count" => $answered_question_count,
			"question_count" => $question_count,
			"attemptID" => $attemptID,
			"userID" => $userID,
			"question_array" => $question_array);

// Send as JSON
header("Content-Type: application/json", true);

// Return JSON 
echo json_encode($json);

/*
 * Query function list
 * 
 */

// Get User ID if already exist
function getUserID($user_name,$conn){
	$sql = "SELECT userID FROM tbl_user WHERE name ='".$user_name."'";
	$user_data = $conn->query($sql);
	if($user_data->num_rows == 0) {
		createUser($user_name,$conn);
		$user_data = $conn->query($sql);
	}
	$userID = $user_data->fetch_object()->userID;
	return $userID;
}

// Create new user
function createUser($user_name, $conn){
	$sql = "INSERT INTO tbl_user (name) VALUES ('".$user_name."')";
	$conn->query($sql);
}

// Get test attempt if already exist
function getAttemptID($user_id, $testID, $conn){
	$sql = "SELECT attemptID FROM tbl_test_attempt WHERE userID ='".$user_id."' AND testID ='".$testID."' AND finished ='0'";
	$attempt_data = $conn->query($sql);
	if($attempt_data->num_rows == 0) {
		createAttempt($user_id, $testID, $conn);
		$attempt_data = $conn->query($sql);
	}
	$attemptID = $attempt_data->fetch_object()->attemptID;
	return $attemptID;
}

// Create new test attempt
function createAttempt($user_id, $testID, $conn){
	$sql = "INSERT INTO tbl_test_attempt (userID, testID) VALUES ('".$user_id."','".$testID."')";
	$conn->query($sql);
}

// Get total question count
function getQuestionCount($testID, $conn){
	$count= 0 ;
	foreach($conn->query("SELECT COUNT(*) FROM tbl_question WHERE testID ='".$testID."'") as $row) {
		$count = $row['COUNT(*)'];
	}
	return $count;
}

// Get answered question count
function getAnsweredQuestionCount($attemptID, $conn){
	$count=0;
	foreach($conn->query("SELECT COUNT(*) FROM tbl_user_answer WHERE attemptID ='".$attemptID."'") as $row) {
		$count= $row['COUNT(*)'];
	}
	return $count;
}

// Get 	questions list
function getQuestionIDs($testID, $conn){
	$sql = "SELECT questionID FROM tbl_question WHERE testID ='".$testID."'"  ;
	$result = $conn->query($sql);
	$questions = array();
	while($row = $result->fetch_assoc())
	{
		array_push($questions, $row);
	}
	return $questions;
}

exit;
?>