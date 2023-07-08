
function dropdownMenu() {
    var x = document.getElementById("dropdownClick");
    if (x.className === "topnav") {
        x.className += " responsive";
        /* Space in front of responsive is important*/
        /* topnavresponsive != topnav responsive*/
        /*change topnav to topnav.responsive*/
    } else {
        x.className = "topnav";
    }
}
