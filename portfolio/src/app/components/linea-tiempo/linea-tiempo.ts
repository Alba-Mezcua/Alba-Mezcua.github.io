import { Component } from '@angular/core';
import { Actividad } from '../../interfaces/actividad';

@Component({
  selector: 'app-linea-tiempo',
  imports: [],
  templateUrl: './linea-tiempo.html',
  styleUrl: './linea-tiempo.css'
})

export class LineaTiempo {
  public actividades: Actividad[] = [
    {
      inicio: 2025,
      fin: null,
      nombre: 'Certificado de profesionalidad IFCD0112: Programación con Lenguajes Orientados a Objetos y Bases de Datos Relacionales',
      localizacion: 'Copermática Centro de Formación',
      descripcion: ''
    },
    {
      inicio: 2022,
      fin: 2023,
      nombre: 'Curso de especialización en ciberseguridad en entornos de las tecnologías de la información',
      localizacion: 'IES Juan Bosco de Alcázar de San Juan',
      descripcion: ''
    },
    {
      inicio: 2017,
      fin: 2017,
      nombre: 'Inglés B2',
      localizacion: 'Escuela Oficial de Idiomas',
      descripcion: ''
    },
    {
      inicio: 2016,
      fin: 2018,
      nombre: 'Grado superior de Administración de Sistemas Operativos en Red',
      localizacion: 'IES Juan Bosco de Alcázar de San Juan',
      descripcion: ''
    }
  ]
}
