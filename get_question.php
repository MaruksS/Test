<?php
// Include the database configuration file
include 'connection.php';

// Receive test ID and question id
$testID = $_GET['test_id'];
$questionID = $_GET['question_ID'];

// Get question
$question = getQuestion($testID, $questionID, $conn);

// Get answer JSON list
$answers = getAnswers($questionID, $conn);
$answers_array=json_encode($answers);

// JSON Row 
$json = array("answers"=>$answers_array,
			"question" => $question);

// Send as JSON
header("Content-Type: application/json", true);

// Return JSON 
echo json_encode($json);

/*
 * Query function list
 */

// Get question
function getQuestion($testID, $questionID, $conn){
	$sql = "SELECT question FROM tbl_question WHERE testID ='".$testID."' AND questionID ='".$questionID."'";
	$result = $conn->query($sql);
	$question = $result->fetch_object()->question;
	return $question;
}

// Get answer list
function getAnswers($questionID, $conn){
	$sql = "SELECT * FROM tbl_answer WHERE questionID ='".$questionID."'"  ;
	$a_result = $conn->query($sql);
	$answers =array();
	while($row = $a_result->fetch_assoc())
	{
		array_push($answers, $row);
	}
	return $answers;
}

exit;
?>