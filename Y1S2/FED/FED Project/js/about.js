// JavaScript source code
function submit() {
    var nameOf = document.getElementById('name').value
    var username = document.getElementById('username').value
    var email = document.getElementById('email').value
    var number = document.getElementById('number').value
    var password = document.getElementById('password').value
    var cfmpassword = document.getElementById('cfmpassword').value

    if (nameOf === "" || username === "" || email === "" || number === "" || password === "" || cfmpassword === "")
    {
        document.getElementById('thank_you').innerHTML = "Please fill up all fields.";
    }
    else if (cfmpassword !== password)
    {
        document.getElementById('thank_you').innerHTML = "Passwords do not match please try again.";
    }
    else
    {
        document.getElementById('thank_you').innerHTML = "Thanks " + nameOf + " for joining us!";
    }
}


function resetForm() {
    var divobj = document.getElementById("thank_you");
    divobj.innerHTML = "";
    document.getElementById("form").reset();
    var divobj = document.getElementById("name");
    divobj.innerHTML = "";
    var divobj = document.getElementById("username");
    divobj.innerHTML = "";
    var divobj = document.getElementById("email");
    divobj.innerHTML = "";
    var divobj = document.getElementById("number");
    divobj.innerHTML = "";
    var divobj = document.getElementById("password");
    divobj.innerHTML = "";
    var divobj = document.getElementById("cfmpassword");
    divobj.innerHTML = "";
}