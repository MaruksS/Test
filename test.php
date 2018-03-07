<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" type="text/css" href="style.css">
		<?php
	    // Include the database configuration file
	    include 'connection.php';

	    // Get user name and Test number if isset
	    if( isset($_POST["name"]) && isset($_POST["Test_id"]))
		{
		    $name = $_POST["name"];
		    $testID = $_POST["Test_id"];
		}
		else
		{
		    header("Location: http://localhost/testa_lapa"); 
  			exit();
		}

	    ?>
	</head>
	<body>
		<div class="background">
			<div class="container">
				<div id="question"></div>
				<div id="answers" class="answers"></div>

				<input class="button" type="button" id="next" value="Nākamais jautājums">
				<progress id="Progress" value="0" max="100"></progress>
			</div>
		</div>

	</body>
</html>

<script type="text/javascript" src="jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="script.js"></script>

<script type="text/javascript">

name = "<?php echo $name; ?>";
testID = <?php echo $testID; ?>;

$(document).ready(function() {
    getAttempt();
});

$("#next").click(function() {
	postAnswer();
});

</script>