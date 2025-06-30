**Algoritmo TRES EN RAYA**
Autor: @ccisnedev • Versión v 0.1.2

---

## Abstract

Este documento describe el diseño y la implementación de un programa en **PSeInt** que juega *Tres en Raya* (Tic‑Tac‑Toe) tanto en modo *fácil* (Ganar → Bloquear → Aleatorio) como en modo *difícil* (algoritmo heurístico). El algoritmo sigue una jerarquía de decisiones:

- **Nivel fácil:** Ganar → Bloquear → Aleatorio
- **Nivel difícil:** Ganar → Bloquear → Esquina ganadora → Esquina táctica

Esto es suficiente para garantizar la victoria (o al menos el empate) contra un oponente humano que cometa cualquier error estratégico. El texto explica la arquitectura general, las estructuras de datos y cada módulo de decisión para que cualquier programador principiante pueda comprender, mantener o extender el código.

---

## Keywords

PSeInt, Algorithm, Heuristic, Fork, Corner Strategy, Tic-Tac-Toe

---

## I. Introduction

El código enseña dos ideas fundamentales de la programación algorítmica para juegos de suma cero:

1. **Búsqueda de corto alcance**: detectar jugadas ganadoras o de bloqueo inmediato.
2. **Heurística de *corner fork***: crear amenazas dobles que el rival no pueda cubrir a la vez.

Se eligió PSeInt para demostrar que, incluso en un pseudolenguaje educativo sin entrada en tiempo real ni recursión avanzada, es posible construir un algoritmo sólido mediante matrices simples, condicionales y bucles.

---

## II. Board Representation

| Componente                   | Tipo/Dimensión | Propósito                              |
| ---------------------------- | -------------- | -------------------------------------- |
| `tablero[3,3]`               | `Cadena`       | Contiene `" "` / `"X"` / `"O"`.        |
| `filasHum`, `filasBot`       | `Entero[3]`    | Nº de fichas por fila de cada jugador. |
| `columnasHum`, `columnasBot` | `Entero[3]`    | Nº de fichas por columna.              |
| `diagHum[2]`, `diagBot[2]`   | `Entero[2]`    | Nº de fichas en diagonales \ y /.      |

Con solo actualizar estos contadores tras cada movimiento se pueden verificar victorias y amenazas en **O(1)**.

---

## III. Main Game Loop

```
INICIALIZAR_JUEGO()           // limpia tablero y contadores
repeat
    mostrar tablero
    si turno=humano entonces
        LEER_JUGADA_HUMANO()
    sino
        ELEGIR_JUGADA_BOT()   // algoritmo
    fin si
    colocar ficha + actualizar contadores
    verificar GANAR o EMPATE
    alternar turno/ficha
hasta juegoTerminado
```

El bucle es secuencial; cada paso entra en la lógica del algoritmo solo **cuando el turno es del bot**.

---


## IV. Decision Pipeline por Nivel

### Nivel Fácil

El bot sigue la siguiente prioridad descendente:

1. **Ganar:** Si puede ganar en este turno, lo hace.
2. **Bloquear:** Si el humano puede ganar en el siguiente turno, lo bloquea.
3. **Aleatorio:** Si no puede ganar ni bloquear, elige una casilla libre al azar.

Esto hace que el bot fácil sea más desafiante que una simple jugada aleatoria, pero sigue siendo vencible.

### Nivel Difícil

En el **primer turno del bot** coloca `"X"` en una esquina libre aleatoria (`a1, c1, a3, c3`).
Objetivo: maximizar líneas potenciales y preparar un *fork*.

**Prioridad descendente:**

1. **Ganar:** Si existe fila/col/diag con 2 X y 1 vacía, juega en la casilla vacía → victoria inmediata.
2. **Bloquear:** Si el rival tiene fila/col/diag con 2 O y 1 vacía, juega en la casilla vacía → evita derrota.
3. **Esquina ganadora:** Busca una **esquina libre** que, al jugarse, complete **dos líneas a la vez** (p.e. fila + columna). Si la halla, la partida termina de inmediato porque el rival solo podría bloquear una.
4. **Esquina táctica:** Si las estrategias anteriores no aplican, el bot elige la esquina libre que forme pareja con su primera esquina (misma fila, columna o diagonal) para preparar un *fork* en el siguiente turno.

Al siguiente turno, cualquier respuesta humana deja al bot con al menos una victoria forzada.

---

## V. Function Interfaces

| Función                  | Devuelve                  | Breve descripción              |
| ------------------------ | ------------------------- | ------------------------------ |
| `BOT_PRIMERA_ESQUINA()`  | `(fila,col)`              | Escoge esquina inicial.        |
| `BOT_GANAR()`            | `Booleano` + `(fila,col)` | Identifica victoria inmediata. |
| `BOT_BLOQUEAR()`         | `Booleano` + `(fila,col)` | Bloquea amenaza humana.        |
| `BOT_ESQUINA_GANADORA()` | `Booleano` + `(fila,col)` | Cierra dos líneas a la vez.    |
| `BOT_ESQUINA_TACTICA()`  | `Booleano` + `(fila,col)` | Prepara *fork* para turno 3.   |

Las cuatro funciones comparten una estrategia: **examinar sólo las esquinas**.
Esto reduce la complejidad y se ajusta al patrón óptimo conocido para Tic‑Tac‑Toe.

---

## VII. Conclusion

La combinación de **contadores O(1)** (operaciones de complejidad algorítmica constante, O(1)) para filas, columnas y diagonales y una **heurística de máximo 5 pasos** (un método práctico, basado en reglas sencillas) permite implementar un algoritmo sólido y muy didáctico en PSeInt. El enfoque demuestra que, sin necesidad de algoritmos exhaustivos como Minimax, el juego puede resolverse eficazmente mediante:

* **Reglas de corto alcance** (Ganar → Bloquear)
* **Heurística de esquinas** para generar *forks* inevitables

El código final (≈ 700 líneas) es **auto-contenible** — es decir, no depende de librerías externas, servicios en la nube u otros componentes ajenos — y utiliza únicamente construcciones básicas de pseudocódigo. Esto lo convierte en una plantilla ideal para un **primer curso de algoritmos**, donde los estudiantes pueden ver de forma clara cómo aplicar complejidad constante, heurísticas y modularidad en un problema real.

---

## Acknowledgment

Desarrollado y documentado por **@ccisnedev** con el objetivo de implementar un algoritmo heurístico simple en un entorno educativo de pseudocódigo.