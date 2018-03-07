<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" type="text/css" href="style.css">
	<?php
	// Include the database configuration file
	include 'connection.php';

	// Get attemptID, if not ser or null - redirect to home page
	if( isset( $_GET["attemptID"] ) &&  strlen( $_GET["attemptID"] ))
	{
		$attemptID = $_GET["attemptID"];
	}
	else
	{
	    header("Location: http://localhost/testa_lapa"); 
		exit();
	}

	// Get total user answers count
	$user_answers = getUserAnswers($attemptID, $conn);

	// Get earned points
	$points = getPoints($user_answers, $conn);

	// Post test results
	finishAttempt($attemptID, $points, $conn);

	//Get user name
	$name = getUserName($attemptID, $conn);

	// Compare user answers to correct answers
	function getPoints($user_answers, $conn){
		$points=0;
		foreach ($user_answers as $id => $value) {
			$correct_answer = getCorrectAnswer($value["questionID"],$conn);
			if ($value["answerID"]==$correct_answer){
				$points++;
			}
		}
		return $points;
	}

	// Get user answers list
	function getUserAnswers($attemptID, $conn){
		// Single question-answer line
		$answer = array();
		// All question-answers
		$answers = array();

		$sql = "SELECT questionID, answerID FROM tbl_user_answer WHERE attemptID ='".$attemptID."'"  ;
		$result = $conn->query($sql);
		while($row = $result->fetch_assoc())
		{
			$answer = array("answerID"=>$row['answerID'],"questionID"=>$row['questionID']);
			array_push($answers,$answer);
		}
		return $answers;
	}

	// Get correct answer
	function getCorrectAnswer($questionID, $conn){
		$sql = "SELECT answerID FROM tbl_correct_answer WHERE questionID ='".$questionID."'";
		$result = $conn->query($sql);
		$answer = $result->fetch_object()->answerID;
		return $answer;
	}

	// Finish attempt and save points
	function finishAttempt($attemptID, $points, $conn){
		$sql = "UPDATE tbl_test_attempt SET points='".$points."', finished='1' WHERE attemptID='".$attemptID."'";
		$conn->query($sql);
	}

	// Get user name
	function getUserName($attemptID, $conn){
		$sql = "SELECT userID FROM tbl_test_attempt WHERE attemptID ='".$attemptID."'";
		$result = $conn->query($sql);
		$userID = $result->fetch_object()->userID;

		$sql = "SELECT name FROM tbl_user WHERE userID ='".$userID."'";
		$result = $conn->query($sql);
		$name = $result->fetch_object()->name;

		return $name;
	}
	?>

	</head>
	<body>
		<div class="background">
			<div class="container">
				<h1> Paldies, <?= $name ?>!</h1>
				<h2>Tu atbildēji pareizi uz <?= $points ?> no <?= sizeof($user_answers) ?> jautājumiem.</h2>
			</div>
		</div>
	</body>
</html>