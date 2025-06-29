<div align="center">
  <h1>Tres en Raya en PSeInt</h1>
</div>

## Descripción General

Este repositorio contiene una implementación del clásico juego "Tres en Raya" (Tic-Tac-Toe) desarrollada en PSeInt. El proyecto está diseñado con fines educativos, demostrando el uso de estructuras de control, arreglos y funciones para crear un juego simple pero funcional. Permite a un jugador humano competir contra un bot con dos niveles de dificultad.

## Stack Tecnológico

- **Lenguaje**: PSeInt

## Setup

1.  Descarga e instala el intérprete de PSeInt desde su [sitio web oficial](http://pseint.sourceforge.net/).
2.  Clona este repositorio en tu máquina local:
    ```bash
    git clone <URL-DEL-REPOSITORIO>
    ```
3.  Abre el archivo `juego.psc` con PSeInt.
4.  Ejecuta el programa para comenzar a jugar.

## Características

- **Juego Clásico**: Implementación completa de las reglas del Tres en Raya.
- **Jugador vs. Bot**: Compite contra una inteligencia artificial simple.
- **Niveles de Dificultad**:
  - **Fácil**: El bot elige sus movimientos de forma aleatoria.
  - **Difícil**: El bot aplica una estrategia básica para intentar ganar o bloquear al jugador.
- **Interfaz de Texto**: Interacción a través de la consola con un tablero visualmente claro.
- **Código Modular**: El programa está estructurado en funciones para facilitar su lectura y mantenimiento.

## Filosofía

El código busca ser lo más explícito y didáctico posible. Se prioriza la claridad sobre la optimización, con el objetivo de que sirva como material de aprendizaje para quienes se inician en el mundo de la programación y los algoritmos.

## Ejemplo Representativo

La lógica para leer la jugada del usuario valida que la coordenada sea correcta y que la casilla esté libre.

```pseudocode
Funcion LEER_JUGADA_HUMANO(tablero, fila Por Referencia, col Por Referencia)
    Definir ok, libre Como Logico
    Definir coord, letra, num Como Cadena
    Repetir
        Escribir "Ingresa coordenada (a1..c3): " Sin Saltar
        Leer coord
        ok <- Falso
		
        Si Longitud(coord) = 2 Entonces
            // ... validación de formato ...
            Si fila >= 1 Y fila <= 3 Y col >= 1 Y col <= 3 Entonces
                ok <- Verdadero
            FinSi
        FinSi
		
        Si No ok Entonces
            Escribir "Formato inválido. Usa a1..c3."
		SiNo
			libre <- (tablero[fila,col] = " ")
			Si No libre Entonces
				Escribir "Casilla ocupada. Elige otra."
			FinSi
		FinSi
	Hasta Que ok Y libre
FinFuncion
```

## Changelog

Las actualizaciones y cambios en el proyecto se documentan en el archivo `CHANGELOG.md`.

## Contribuciones

Este es un proyecto de código abierto. Las contribuciones son bienvenidas. Si deseas mejorar el juego, siéntete libre de hacer un _fork_ y enviar una _Pull Request_.

## Licencia

MIT
