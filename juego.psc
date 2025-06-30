//##############################################################
//  TRES EN RAYA – v0.1.0                                     //
//  Autor: @ccisnedev                                         //
//##############################################################

Proceso TresEnRaya
    // 1. DECLARACIONES
    Dimensionar tablero[3,3]
    Dimensionar filasHum[3], columnasHum[3], diagHum[2]
    Dimensionar filasBot[3], columnasBot[3], diagBot[2]
    
    Definir nivel, turno, jugadas, fila, col, tipoLinea, indLinea, turnoBotNum Como Entero
    Definir fichaTurno, ganador Como Caracter
    Definir hayGanador, juegoTerminado Como Logico
    Definir coord, letra, num, tipoTurno Como Cadena
    
    // 2. PANTALLA DE INICIO
    nivel <- PRESENTACION
    
    // 3. INICIALIZAR JUEGO
    INICIALIZAR_JUEGO(tablero, filasHum, columnasHum, diagHum, filasBot, columnasBot, diagBot, jugadas)
    
    // 4. DETERMINAR QUIÉN INICIA
    Si nivel = 1 Entonces
        turno <- 1        // 1 = humano
    SiNo
        turno <- 2        // 2 = bot
    FinSi
    fichaTurno <- "X"
    turnoBotNum <- 0
    ganador <- " "
    juegoTerminado <- Falso
    
    // 5. BUCLE PRINCIPAL
    IMPRIMIR_TABLERO(tablero)
    Repetir
        
        Si turno = 1 Entonces
            tipoTurno <- "humano"
        SiNo
            tipoTurno <- "bot"
        FinSi
        
        Escribir "Turno de ", fichaTurno, " [", tipoTurno, "]"
        
        Si turno = 1 Entonces
            LEER_JUGADA_HUMANO(tablero, fila, col)
        SiNo
            PAUSA_BOT
            turnoBotNum <- turnoBotNum + 1
            ELEGIR_JUGADA_BOT(tablero, nivel, turnoBotNum, filasHum, columnasHum, diagHum, filasBot, columnasBot, diagBot, fila, col)
        FinSi
        
        // Colocar ficha
        tablero[fila,col] <- fichaTurno
        IMPRIMIR_TABLERO(tablero)
        
        ACTUALIZAR_CONTADORES(turno, fila, col, filasHum, columnasHum, diagHum, filasBot, columnasBot, diagBot)
        
        jugadas <- jugadas + 1
        
        // Verificar ganador
        VERIFICAR_GANADOR(turno, filasHum, columnasHum, diagHum, filasBot, columnasBot, diagBot, hayGanador, tipoLinea, indLinea)
        Si hayGanador Entonces
            ganador <- fichaTurno
            Esperar 1 Segundos
            DIBUJAR_LINEA_GANADORA(tablero, tipoLinea, indLinea)
            juegoTerminado <- Verdadero
        FinSi
        
        // Verificar empate
        Si jugadas = 9 Entonces
            juegoTerminado <- Verdadero
        FinSi
        
        // Cambiar turno y ficha solo si el juego no ha terminado
        Si No juegoTerminado Entonces
            Si turno = 1 Entonces
                turno <- 2
            SiNo
                turno <- 1
            FinSi
            
            Si fichaTurno = "X" Entonces
                fichaTurno <- "O"
            SiNo
                fichaTurno <- "X"
            FinSi
        FinSi
        
    Hasta Que juegoTerminado
    
    // 6. PANTALLA FINAL
    IMPRIMIR_TABLERO(tablero)
    
    Si ganador = "X" Entonces
        Si turno = 1 Entonces
            tipoTurno <- "humano"
        SiNo
            tipoTurno <- "bot"
        FinSi
        Escribir "¡Ganó ", tipoTurno, " con X!"
    SiNo
        Si ganador = "O" Entonces
            Si turno = 1 Entonces
                tipoTurno <- "humano"
            SiNo
                tipoTurno <- "bot"
            FinSi
            Escribir "¡Ganó ", tipoTurno, " con O!"
        SiNo
            Escribir "Empate. ¡Bien jugado!"
        FinSi
    FinSi

    // Creditos
    Escribir "@ccisnedev"
                            
FinProceso


//##############################################################
//  FUNCIONES
//##############################################################

Funcion LIMPIAR_PANTALLA
    Limpiar Pantalla
FinFuncion

Funcion nivel <- PRESENTACION
    Definir opcion Como Cadena
    Definir opcionValida Como Logico
    Repetir
        LIMPIAR_PANTALLA
        Escribir "╔══════════════════════╗"
        Escribir "║ Tres en Raya v0.1.0  ║"
        Escribir "╠══════════════════════╣"
        Escribir "║ 1.Fácil   2.Difícil  ║"
        Escribir "╚══════════════════════╝"
        Escribir ""
        Escribir "Opción: " Sin Saltar
        Leer opcion
        
        opcionValida <- (opcion = "1" O opcion = "2")
        
    Hasta Que opcionValida
    
    nivel <- ConvertirANumero(opcion)
FinFuncion

Funcion INICIALIZAR_JUEGO(tablero Por Referencia, filasHum Por Referencia, columnasHum Por Referencia, diagHum Por Referencia, filasBot Por Referencia, columnasBot Por Referencia, diagBot Por Referencia, jugadas Por Referencia)
    Definir i, j Como Entero
    
    // Vaciar tablero
    Para i <- 1 Hasta 3 Hacer
        Para j <- 1 Hasta 3 Hacer
            tablero[i,j] <- " "
        FinPara
    FinPara
    
    // Reset contadores
    Para i <- 1 Hasta 3 Hacer
        filasHum[i]    <- 0
        columnasHum[i] <- 0
        filasBot[i]    <- 0
        columnasBot[i] <- 0
    FinPara
    diagHum[1] <- 0 
    diagHum[2] <- 0
    diagBot[1] <- 0 
    diagBot[2] <- 0
    
    jugadas <- 0
FinFuncion

Funcion IMPRIMIR_TABLERO(tablero)
    LIMPIAR_PANTALLA

    Definir i, j Como Entero
    Escribir ""
    Escribir "      a   b   c"
    Escribir ""
    Para i <- 3 Hasta 1 Con Paso -1 Hacer
    Escribir Sin Saltar " ", i, "   "
    Para j <- 1 Hasta 3 Hacer
    Escribir Sin Saltar " ", tablero[i,j], " "
    Si j <> 3 Entonces
    Escribir Sin Saltar "│"
    FinSi
    FinPara
    Escribir "   ", i
    Si i <> 1 Entonces
    Escribir "     ───┼───┼───"
    FinSi
    FinPara
    Escribir ""
    Escribir "      a   b   c"
    Escribir ""
FinFuncion

Funcion LEER_JUGADA_HUMANO(tablero, fila Por Referencia, col Por Referencia)
    Definir ok, libre Como Logico
    Definir coord, letra, num Como Cadena
    Repetir
        Escribir "Ingresa coordenada (a1..c3): " Sin Saltar
        Leer coord
        ok <- Falso
        
        Si Longitud(coord) = 2 Entonces
            letra <- Mayusculas(Subcadena(coord,1,1))
            num   <- Subcadena(coord,2,2)
            
            Segun letra Hacer
                "A": col <- 1
                "B": col <- 2
                "C": col <- 3
                De Otro Modo: col <- 0
            FinSegun
            
            Segun num Hacer
                "1": fila <- 1
                "2": fila <- 2
                "3": fila <- 3
                De Otro Modo: fila <- 0
            FinSegun
            
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

Funcion BOT_ALEATORIO(tablero, fila Por Referencia, col Por Referencia)
    Repetir
        fila <- Aleatorio(1,3)
        col  <- Aleatorio(1,3)
    Hasta Que tablero[fila,col] = " "
FinFuncion

Funcion BOT_PRIMERA_ESQUINA(tablero, fila Por Referencia, col Por Referencia)
    Definir rnd Como Entero
    Repetir
        rnd <- Aleatorio(1,4)
        Segun rnd Hacer
            1: fila <- 1 
               col <- 1
            2: fila <- 1 
               col <- 3
            3: fila <- 3 
               col <- 1
            4: fila <- 3 
               col <- 3
        FinSegun
    Hasta Que tablero[fila,col] = " "
FinFuncion

Funcion encontrado <- BOT_GANAR(tablero, filasBot, columnasBot, diagBot, fila Por Referencia, col Por Referencia)
    Definir i, filaAux, colAux Como Entero
    encontrado <- Falso
    
    // Filas
    i <- 1
    Mientras i <= 3 Y No encontrado Hacer
        Si filasBot[i] = 2 Entonces
            colAux <- 1
            Mientras colAux <= 3 Y No encontrado Hacer
                Si tablero[i,colAux] = " " Entonces
                    fila <- i 
                    col <- colAux
                    encontrado <- Verdadero
                FinSi
                colAux <- colAux + 1
            FinMientras
        FinSi
        i <- i + 1
    FinMientras
    
    // Columnas
    Si No encontrado Entonces
        i <- 1
        Mientras i <= 3 Y No encontrado Hacer
            Si columnasBot[i] = 2 Entonces
                filaAux <- 1
                Mientras filaAux <= 3 Y No encontrado Hacer
                    Si tablero[filaAux,i] = " " Entonces
                        fila <- filaAux 
                        col <- i
                        encontrado <- Verdadero
                    FinSi
                    filaAux <- filaAux + 1
                FinMientras
            FinSi
            i <- i + 1
        FinMientras
    FinSi
    
    // Diagonal /
    Si No encontrado Y diagBot[1] = 2 Entonces
        i <- 1
        Mientras i <= 3 Y No encontrado Hacer
            Si tablero[i,i] = " " Entonces
                fila <- i 
                col <- i
                encontrado <- Verdadero
            FinSi
            i <- i + 1
        FinMientras
    FinSi
    
    // Diagonal \
    Si No encontrado Y diagBot[2] = 2 Entonces
        i <- 1
        Mientras i <= 3 Y No encontrado Hacer
            Si tablero[i,4-i] = " " Entonces
                fila <- i 
                col <- 4 - i
                encontrado <- Verdadero
            FinSi
            i <- i + 1
        FinMientras
    FinSi
FinFuncion

Funcion encontrado <- BOT_BLOQUEAR(tablero, filasHum, columnasHum, diagHum, fila Por Referencia, col Por Referencia)
    Definir i, filaAux, colAux Como Entero
    encontrado <- Falso
    
    // Filas
    i <- 1
    Mientras i <= 3 Y No encontrado Hacer
        Si filasHum[i] = 2 Entonces
            colAux <- 1
            Mientras colAux <= 3 Y No encontrado Hacer
                Si tablero[i,colAux] = " " Entonces
                    fila <- i 
                    col <- colAux
                    encontrado <- Verdadero
                FinSi
                colAux <- colAux + 1
            FinMientras
        FinSi
        i <- i + 1
    FinMientras
    
    // Columnas
    Si No encontrado Entonces
        i <- 1
        Mientras i <= 3 Y No encontrado Hacer
            Si columnasHum[i] = 2 Entonces
                filaAux <- 1
                Mientras filaAux <= 3 Y No encontrado Hacer
                    Si tablero[filaAux,i] = " " Entonces
                        fila <- filaAux 
                        col <- i
                        encontrado <- Verdadero
                    FinSi
                    filaAux <- filaAux + 1
                FinMientras
            FinSi
            i <- i + 1
        FinMientras
    FinSi
    
    // Diagonal /
    Si No encontrado Y diagHum[1] = 2 Entonces
        i <- 1
        Mientras i <= 3 Y No encontrado Hacer
            Si tablero[i,i] = " " Entonces
                fila <- i 
                col <- i
                encontrado <- Verdadero
            FinSi
            i <- i + 1
        FinMientras
    FinSi
    
    // Diagonal \
    Si No encontrado Y diagHum[2] = 2 Entonces
        i <- 1
        Mientras i <= 3 Y No encontrado Hacer
            Si tablero[i,4-i] = " " Entonces
                fila <- i 
                col <- 4 - i
                encontrado <- Verdadero
            FinSi
            i <- i + 1
        FinMientras
    FinSi
FinFuncion

Funcion ganado <- BOT_ESQUINA_GANADORA(tablero, filasBot, columnasBot, diagBot,   fila Por Referencia, col Por Referencia)
    Definir i, f, c, lineas Como Entero
    ganado <- Falso
    
    i <- 1
    Mientras i <= 4 Y No ganado Hacer
        // Mapear i a cada esquina
        Segun i Hacer
            1: f <- 1; c <- 1   // a1
            2: f <- 1; c <- 3   // c1
            3: f <- 3; c <- 1   // a3
            4: f <- 3; c <- 3   // c3
        FinSegun
        
        Si tablero[f,c] = " " Entonces          // esquina libre
            lineas <- 0
            Si filasBot[f] = 2 Entonces
                lineas <- lineas + 1
            FinSi
            Si columnasBot[c] = 2 Entonces
                lineas <- lineas + 1
            FinSi
            Si f = c Y diagBot[1] = 2 Entonces
                lineas <- lineas + 1
            FinSi
            Si f + c = 4 Y diagBot[2] = 2 Entonces
                lineas <- lineas + 1
            FinSi
            
            Si lineas >= 2 Entonces
                fila   <- f
                col    <- c
                ganado <- Verdadero // Esquina doble‑línea encontrada
            FinSi
        FinSi
        
        i <- i + 1
    FinMientras
FinFuncion

Funcion tactica <- BOT_ESQUINA_TACTICA(tablero,   fila Por Referencia, col Por Referencia)
    Definir i, f, c, prFila, prCol Como Entero
    tactica <- Falso
    
    // 1) localizar la esquina ya ocupada por el bot
    prFila <- 0
    prCol  <- 0
    Para i <- 1 Hasta 4 Hacer
        Segun i Hacer
            1: f <- 1; c <- 1
            2: f <- 1; c <- 3
            3: f <- 3; c <- 1
            4: f <- 3; c <- 3
        FinSegun
        Si tablero[f,c] = "X" Entonces
            prFila <- f
            prCol  <- c
        FinSi
    FinPara
    
    // 2) buscar esquina vacía aliada
    i <- 1
    Mientras i <= 4 Y No tactica Hacer
        Segun i Hacer
            1: f <- 1; c <- 1
            2: f <- 1; c <- 3
            3: f <- 3; c <- 1
            4: f <- 3; c <- 3
        FinSegun
        
        Si tablero[f,c] = " " Entonces
            Si f = prFila Entonces // misma fila
                fila <- f
                col <- c
                tactica <- Verdadero
            SiNo
                Si c = prCol Entonces // misma columna
                    fila <- f
                    col <- c
                    tactica <- Verdadero
                SiNo
                    Si (f = c Y prFila = prCol) Entonces // misma diagonal /
                        fila <- f
                        col <- c
                        tactica <- Verdadero
                    SiNo
                        Si (f + c = 4 Y prFila + prCol = 4) Entonces // misma diagonal \
                            fila <- f
                            col <- c
                            tactica <- Verdadero
                        FinSi
                    FinSi
                FinSi
            FinSi
        FinSi
        
        i <- i + 1
    FinMientras
FinFuncion

Funcion ELEGIR_JUGADA_BOT(tablero, nivel, turnoBotNum, filasHum, columnasHum, diagHum, filasBot, columnasBot, diagBot, fila Por Referencia, col Por Referencia)
    Definir encontrado Como Logico
    
    Si nivel = 1 Entonces                              // ——— MODO FÁCIL
        BOT_ALEATORIO(tablero, fila, col)
    SiNo                                               // ——— MODO DIFÍCIL
        // 1) Ganar de inmediato
        encontrado <- BOT_GANAR(tablero, filasBot, columnasBot, diagBot, fila, col)
        
        // 2) Bloquear derrota inminente
        Si No encontrado Entonces
            encontrado <- BOT_BLOQUEAR(tablero, filasHum, columnasHum, diagHum, fila, col)
        FinSi
        
        // 3) Jugada 1: elegir esquina inicial
        Si No encontrado Entonces
            Si turnoBotNum = 1 Entonces
                BOT_PRIMERA_ESQUINA(tablero, fila, col)
                encontrado <- Verdadero
            FinSi
        FinSi
        
        // 4) Esquina que cierra dos líneas YA
        Si No encontrado Entonces
            encontrado <- BOT_ESQUINA_GANADORA(tablero, filasBot, columnasBot, diagBot, fila, col)
        FinSi
        
        // 5) Esquina que prepara el fork
        Si No encontrado Entonces
            encontrado <- BOT_ESQUINA_TACTICA(tablero, fila, col)
        FinSi
    FinSi
FinFuncion

Funcion ACTUALIZAR_CONTADORES(turno, fila, col, filasHum Por Referencia, columnasHum Por Referencia, diagHum Por Referencia, filasBot Por Referencia, columnasBot Por Referencia, diagBot Por Referencia)
    // turno: 1=humano, 2=bot
    Si turno = 1 Entonces
        filasHum[fila] <- filasHum[fila] + 1
        columnasHum[col] <- columnasHum[col] + 1
        Si fila = col Entonces 
            diagHum[1] <- diagHum[1] + 1 
        FinSi
        Si fila + col = 4 Entonces 
            diagHum[2] <- diagHum[2] + 1 
        FinSi
    SiNo
        filasBot[fila] <- filasBot[fila] + 1
        columnasBot[col] <- columnasBot[col] + 1
        Si fila = col Entonces 
            diagBot[1] <- diagBot[1] + 1 
        FinSi
        Si fila + col = 4 Entonces 
            diagBot[2] <- diagBot[2] + 1 
        FinSi
    FinSi
FinFuncion

Funcion VERIFICAR_GANADOR(turno, filasHum, columnasHum, diagHum, filasBot, columnasBot, diagBot, hayGanador Por Referencia, tipoLinea Por Referencia, indLinea Por Referencia)
    Definir i Como Entero
    hayGanador <- Falso
    i <- 1
    
    Si turno = 1 Entonces
        // Filas y Columnas
        Mientras i <= 3 Y No hayGanador Hacer
            Si filasHum[i] = 3 Entonces 
                tipoLinea <- 1 
                indLinea <- i 
                hayGanador <- Verdadero 
            SiNo
                Si columnasHum[i] = 3 Entonces 
                    tipoLinea <- 2 
                    indLinea <- i 
                    hayGanador <- Verdadero 
                FinSi
            FinSi
            i <- i + 1
        FinMientras

        // Diagonales
        Si No hayGanador Entonces
            Si diagHum[1] = 3 Entonces
                tipoLinea <- 3
                indLinea <- 1
                hayGanador <- Verdadero
            SiNo
                Si diagHum[2] = 3 Entonces
                    tipoLinea <- 4
                    indLinea <- 1
                    hayGanador <- Verdadero
                FinSi
            FinSi
        FinSi
    SiNo // turno = 2 (BOT)
        i <- 1
        // Filas y Columnas
        Mientras i <= 3 Y No hayGanador Hacer
            Si filasBot[i] = 3 Entonces
                tipoLinea <- 1
                indLinea <- i
                hayGanador <- Verdadero
            SiNo
                Si columnasBot[i] = 3 Entonces
                    tipoLinea <- 2
                    indLinea <- i
                    hayGanador <- Verdadero
                FinSi
            FinSi
            i <- i + 1
        FinMientras

        // Diagonales
        Si No hayGanador Entonces
            Si diagBot[1] = 3 Entonces
                tipoLinea <- 3
                indLinea <- 1
                hayGanador <- Verdadero
            SiNo
                Si diagBot[2] = 3 Entonces
                    tipoLinea <- 4
                    indLinea <- 1
                    hayGanador <- Verdadero
                FinSi
            FinSi
        FinSi
    FinSi
FinFuncion

Funcion DIBUJAR_LINEA_GANADORA(tablero Por Referencia, tipoLinea, indLinea)
    Definir i Como Entero
    Segun tipoLinea Hacer
        1: // fila
            Para i <- 1 Hasta 3 Hacer 
                tablero[indLinea,i] <- '─'
            FinPara
        2: // columna
            Para i <- 1 Hasta 3 Hacer 
                tablero[i,indLinea] <- '│' 
            FinPara
        3: // diagonal /
            Para i <- 1 Hasta 3 Hacer 
                tablero[i,i] <- '/'
            FinPara
        4: // diagonal \
            Para i <- 1 Hasta 3 Hacer 
                tablero[i,4-i] <- '\' 
            FinPara
    FinSegun
FinFuncion

Funcion PAUSA_BOT
    Esperar 1 Segundos
FinFuncion
