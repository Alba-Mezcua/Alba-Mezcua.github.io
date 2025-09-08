import { Component, signal } from '@angular/core';
import { LineaTiempo } from "./components/linea-tiempo/linea-tiempo";
import { DatosPersonales } from "./components/datos-personales/datos-personales";

@Component({
  selector: 'app-root',
  imports: [LineaTiempo, DatosPersonales],
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App {
  protected readonly title = signal('portfolio');
}
