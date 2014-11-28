"use strict";

function init() {
    var gs = document.getElementsByClassName("info");
    for (var i = 0; i < gs.length; i++) {
        gs[i].addEventListener('click', popup, false);
    }
}

function popup(e) {
    if (! this.id) {
        var overlay = document.createElement("div");
        var XMousePos = e.clientX;
        var Ypos = e.clientY + 20;
        var windowWidth = window.innerWidth;
        if (windowWidth - XMousePos > 300) {
            var Xpos = XMousePos;
        } else {
            var Xpos = windowWidth - 330;
        };
        var random = "n" + Math.random();
        
        this.id = random;
        overlay.innerHTML = this.firstElementChild.textContent;
        overlay.style.backgroundColor = "black";
        overlay.style.position = "absolute";
        overlay.style.left = Xpos + "px";
        overlay.style.top = Ypos + "px";
        overlay.style.border = "1px #D45710";
        overlay.style.width = "120px";
        overlay.style.color = "white";
        overlay.style.margin = "0";
        overlay.style.padding = ".5em";
        overlay.dataset.pointer = random;
        overlay.addEventListener('click', destroy, false);
        document.body.appendChild(overlay);
    }
}

function destroy() {
    var tooltip = document.getElementById(this.dataset.pointer);
    tooltip.removeAttribute("id");
    document.body.removeChild(this);
}

window.onload = init;