//TODO: arreglar al flash blanco al cargar una página en modo noche
function detectarModoPreferido() {
  const darkThemeMq = window.matchMedia("(prefers-color-scheme: dark)");
  if (darkThemeMq.matches) {
    return "noche"
  } else {
    return "dia"
  }
}

function cambiarModo(modo) {                          // Cambia de noche a día y viceversa
  const otromodo = modo == "dia" ? "noche" : "dia";   // Guardamos el otro modo

  const body = document.body;                         // En el cuerpo del documento
  body.classList.remove(`modo-${otromodo}`);          // si ya tiene un modo lo quitamos
  body.classList.add(`modo-${modo}`);              // y ponemos el modo seleccionado

  const boton = document.getElementById("modo");      // En el botón de cambiar modo
  boton.innerText = modo;                             // cambiamos el texto de modo seleccionado
  boton.onclick = function() {cambiarModo(otromodo)}; // y cambiamos la función del botón. Si se hace con boton.onclick = cambiarModo(otromodo) se genera un bucle infinito.
}

const modopreferido = detectarModoPreferido()
document.addEventListener("DOMContentLoaded", function(){
cambiarModo(modopreferido)
});