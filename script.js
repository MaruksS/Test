/* 
 * script.js file
 */

// Declaring used variables
var userID;
var attemptID;
var question_count;
var answered_question_count;
var question_list;
var name;
var testID;

// Get question and answer list
function getQuestion() {
  $.ajax({
    type: "GET",
    url: "get_question.php",             
    dataType: "json",    
    data: ({test_id: testID,
    question_ID : question_list[answered_question_count].questionID}),  
    success: function(response){
      var question = response.question;
      var array = JSON.parse(response.answers);
      // Create radio group with received answer list
      createRadioGroup(array);

      displayQuestion(question);
    }
  });
}

// Create user and attempt if not exist yet
function getAttempt() {
  $.ajax({
    type: "GET",
    url: "get_attempt.php",             
    dataType: "json",    
    data: ({name: name, test_id : testID}),  
    success: function(response){
      userID = response.userID;
      attemptID = response.attemptID;
      question_count = Number(response.question_count);
      answered_question_count = Number(response.answered_question_count);
      question_list = JSON.parse(response.question_array);
      
      // use received info to update view
      updateProgressBar();
      getQuestion();
    }
  });
}

// Insert user answer in the database
function postAnswer() {
	var nodeSelected = getSelectedNode("answer");
	if (nodeSelected==null){
    alert("Please select answer");
	}else{
    $.ajax({
    type: "POST",
    url: "post_answer.php", 
    data: ({answerID : nodeSelected.value,
            questionID : question_list[answered_question_count].questionID,
            attemptID:attemptID}),  
    success: function(){
      answered_question_count++;
      // If test is complete redirect to result page
      if (answered_question_count>=question_count) {
          completeTest();
      }
      // Continue test
      else{
        updateProgressBar();
        getQuestion();
      }
    }
  });
	}
}

// Redirect to result page
function completeTest(){
  document.location = "result.php?attemptID="+attemptID;
}

// Update progress bar max and value attributes
function updateProgressBar(){
  var progressBar = document.getElementById("Progress");
  progressBar.max = question_count;
  progressBar.value = answered_question_count;
}

// Create question label
function displayQuestion(question) {
    var objDiv = document.getElementById("question");
    objDiv.innerHTML="";
    var h1 = document.createElement("H1");
    var text = document.createTextNode(question);
    h1.appendChild(text);
    objDiv.appendChild(h1);
}

// Creates radio group for answer options
function createRadioGroup(array) {
  var objDiv = document.getElementById("answers");
  objDiv.innerHTML="";
  for (var i = 0; i < array.length; i++) {
    objDiv.appendChild(createRadioButtonWithLabel(array[i].answer, array[i].answerID));
  }
}

// Creates label for each answer option
function createRadioButtonWithLabel(label, value) {
  var objTextNode = document.createTextNode(label);
  var objLabel = document.createElement("label");
  var objSpan = document.createElement("span");
  var objRadioButton = createRadioButton(value);
  objLabel.htmlFor = value;
  objSpan.appendChild(objRadioButton);
  objLabel.appendChild(objTextNode);
  objSpan.appendChild(objLabel);
  return objSpan;
}

// Creates radio button for each answer
function createRadioButton(value) {
  var radioItem = document.createElement("input");
  radioItem.type = "radio";
  radioItem.name = "answer";
  radioItem.value = value;
  radioItem.id = value;
  return radioItem;
}

// Identify which radio button was selected
function getSelectedNode(groupname) {
	var nodes = document.getElementById("answers").childNodes;
	for (var i = 0; i < nodes.length; i++) {
    	var radiobutton=nodes[i].firstChild;
    	if (radiobutton.checked) return radiobutton;
    }
  return null;
}