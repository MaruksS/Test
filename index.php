<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" type="text/css" href="style.css">
		<?php
		    // Include the database configuration file
		    include 'connection.php';
	    ?>
	</head>
	<body>
		<div class="background">
			<div class="container">
				<h1>Testa uzdevums</h1>

				<form class="input_form" action="test.php" method="POST">
					<input class="input" placeholder="Vārds" name="name" id="userName" maxlength="20" required></input>


					<select class="input" name="Test_id" id="testSelect">
						<?php 

						$sql = "SELECT testID, name FROM tbl_test";
						$result = $conn->query($sql);

						while ($row = $result->fetch_assoc()){
							echo "<option value=\"".$row['testID']."\">".
							$row['name'] . "</option>";
						}
						?>
					</select>

					<button class="button" type="submit">Sākt</button>
				</form>
			</div>
		</div> 
	</body>
</html>
