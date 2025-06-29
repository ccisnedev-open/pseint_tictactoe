// Pruebas de simulación de pantalla en Pseint
// Autor: @ccisnedev

Proceso SimulacionPantalla
    // Se dimensiona la "pantalla" como un arreglo de 10x30 (índices del 1 al 10 y del 1 al 30)
	// (fila, columna)
    Dimensionar pantalla[10,30];
    
    // Inicializar la pantalla con espacios en blanco
    InicializarPantalla(pantalla);
	
    // Ejemplo de uso: Actualizamos y mostramos la pantalla con diferentes caracteres
    PrintXY(pantalla, "*", 1, 1);   // Coloca '*' en la fila 1, columna 1.
    esperaTecla("J");
	PrintXY(pantalla, "#", 1, 30);    // Coloca '#' en la fila 1, columna 30.
    esperaTecla("K");
	PrintXY(pantalla, "@", 10, 1);  // Coloca '@' en la fila 10, columna 1.
	esperaTecla("n");
	PrintXY(pantalla, "$", 10, 30);  // Coloca '$' en la fila 10, columna 30.
	
    Escribir "Presiona Enter para finalizar..."
    Esperar Tecla;
FinProceso




// Función para inicializar la pantalla (matriz) con espacios en blanco.
Funcion InicializarPantalla(pant)
    Para i <- 1 Hasta 10
        Para j <- 1 Hasta 30
            pant[i, j] <- " "  // Se asigna espacio vacío a cada celda.
        FinPara
    FinPara
FinFuncion

// Función PrintXY: Actualiza la celda (x,y) con un carácter y vuelve a imprimir toda la pantalla.
Funcion PrintXY(pant, car, xi, yi)
    Definir linea Como Cadena
	
    // Actualiza la posici�n especificada sin modificar el resto
    pant[xi, yi] <- car;
	
	Limpiar Pantalla;
	
    // Recorre la matriz y construye cada línea de la "pantalla".
    Para i <- 1 Hasta 10
        linea <- ""
        Para j <- 1 Hasta 30
            linea <- linea + pant[i, j]
        FinPara
        Escribir linea
    FinPara
FinFuncion

Funcion esperaTecla(key)
	Definir _key Como Caracter
	Repetir
		Leer _key
	Hasta Que key = _key
FinFuncion
