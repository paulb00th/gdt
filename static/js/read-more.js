document.addEventListener("DOMContentLoaded", function () {
    var readMoreLinks = document.querySelectorAll(".read-more-link");

    readMoreLinks.forEach(function (link) {
        link.addEventListener("click", function () {
            var target = document.getElementById(link.id.replace("readMore", "hiddenText"));

            if (target.style.display === "none") {
                target.style.display = "block";
                link.textContent = "Read less...";
            } else {
                target.style.display = "none";
                link.textContent = "Read more...";
            }
        });
    });
});
  