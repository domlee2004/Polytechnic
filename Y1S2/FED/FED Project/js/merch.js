// JavaScript source code




function calculateTotal() {

    var shirt = document.getElementById('squantity').value * 20;
    var pants = document.getElementById('pquantity').value * 20;
    var protective = document.getElementById('pgquantity').value * 30;
    var skateboard = document.getElementById('skquantity').value * 150;
    var totalcost = shirt + pants + protective + skateboard;

    var divObj = document.getElementById("totalcost");
    divObj.style.display = "block";
    divObj.innerHTML = "Total price for your order is $" + totalcost;
}

function hideTotal() {
    var divobj = document.getElementById('totalPrice');
    divobj.style.display = 'none';
}

function submitForm() {
    var divObj = document.getElementById("finalMessage");
    divObj.style.display = "block";
    divObj.innerHTML = "Thank you for choosing us!";
}

function resetForm() {
    document.getElementById("pizzaform").reset();
    hideTotal();
    divobj = document.getElementById("finalMessage");
    divobj.style.display = 'none';
}

const rows = Array.from(document.querySelectorAll('tr'));


/* animation */
function slideOut(row) {
    row.classList.add('slide-out');
}

function slideIn(row, index) {
    setTimeout(function () {
        row.classList.remove('slide-out');
    }, (index + 5) * 200);
}

rows.forEach(slideOut);

rows.forEach(slideIn);

/*stuff i added */
$('.carousel').carousel({
    interval: 3500
})

