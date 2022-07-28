function enlargeImage(img_id) {
    // Get the image that is to be enlarged.
    var img = document.getElementById(img_id);
    // Get the modal, modal image and modal caption.
    var mod = document.getElementById("postModal");
    var modImg = document.getElementById("modalImg");
    var modCaption = document.getElementById("modalCaption");
    // Set the modal properties: display, image source & image caption.
    modImg.src = img.src;
    mod.style.display = "block";
}

function closeMod() {
    document.getElementById("postModal").setAttribute("style", "display:none");
}
