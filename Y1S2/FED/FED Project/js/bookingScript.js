// JS FOR ORDER FORM BOOKING

// function to set price for each configuration selected
function getPrice() {
    var studentLevel = document.getElementById("level").value;
    var studentPackage = document.getElementById("package").value;

    // sets price based on the package and level selected by the user
    var studentPrice;

    // price setting for beginners
    if (studentLevel == "beginner" && studentPackage == "a") {
        studentPrice = 20;
    }
    if (studentLevel == "beginner" && studentPackage == "b") {
        studentPrice = 30;
    }
    if (studentLevel == "beginner" && studentPackage == "c") {
        studentPrice = 15;
    }

    // price setting for amateurs
    if (studentLevel == "amateur" && studentPackage == "a") {
        studentPrice = 20;
    }
    if (studentLevel == "amateur" && studentPackage == "b") {
        studentPrice = 40;
    }
    if (studentLevel == "amateur" && studentPackage == "c") {
        studentPrice = 25;
    }
    
    // price setting for semi-pros
    if (studentLevel == "semipro" && studentPackage == "a") {
        studentPrice = 30
    }
    if (studentLevel == "semipro" && studentPackage == "b") {
        studentPrice = 40
    }
    if (studentLevel == "semipro" && studentPackage == "c") {
        studentPrice = 35
    }
    
    // price for pros
    if (studentLevel == "pro") {
        studentPrice = 100;
    }

    var noOfSessions = document.getElementById("sessions").value;
    var finalPrice = noOfSessions * studentPrice;

    return finalPrice;
}

// function that resets the form when the reset button is pressed
document.getElementById("reset").onclick = function () {
    document.getElementById("output1").innerHTML = "";
    document.getElementById("output2").innerHTML = "";
    form-part.reset();
}

// function that shows price and booking details when submit button is pressed 
function showFinalMessage() {
    var finalPrice = getPrice();
    var noOfSessions = document.getElementById("sessions").value;

    var divobj1 = document.getElementById("output1");
    divobj1.style.display = "block";
    divobj1.innerHTML = "You have selected " + noOfSessions + " session(s) for $" + finalPrice + ".";

    var userName = document.getElementById("name").value;
    var userDay = document.getElementById("day").value;
    var userTime = document.getElementById("time").value;

    // output for user confirmation
    var divobj2 = document.getElementById("output2");
    divobj2.style.display = "block";
    divobj2.innerHTML = "Thanks for booking, " + userName + ".";

    var divobj3 = document.getElementById("output3");
    divobj3.style.display = "block";
    divobj3.innerHTML = "Your sessions will take place every " + userDay + " at " + userTime + ".";
}