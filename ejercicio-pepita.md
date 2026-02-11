# Ejercicio: Pepita la Golondrina

![Pepita](assets/pepita/pepita-volando.png)

## Enunciado

Sabemos que Pepita tiene una cantidad de **energía** que empieza en **100**.

También sabemos que puede volar hacia: **arriba, abajo, izquierda y derecha**.

Cada vez que vuela en una dirección, recorre **100** metros en esa dirección y gasta **10** de energía.

---

## Pregunta 1

Luego de volar una vez hacia **arriba**:
- ¿Cuánta energía le queda?
- ¿En qué ubicación se encuentra?

### Resolución

Arrancamos definiendo las variables y, dentro de `_ready()`, modificamos directamente la energía y la posición:

```gdscript
var energia = 100
var posicion_x = 0
var posicion_y = 0

func _ready() -> void:
    print("Volé una vez hacia arriba")
    energia = energia - 10
    posicion_y = posicion_y - 100

    print("Energía: ", energia)
    print("X: ", posicion_x)
    print("Y: ", posicion_y)
```

En la consola veríamos:
```
Volé una vez hacia arriba
Energía: 90
X: 0
Y: -100
```
---

## Pregunta 2

¿Con cuánta energía y en qué ubicación va a quedar si hace el siguiente recorrido?
- arriba
- abajo
- derecha
- derecha

### Resolución - primera versión

Podemos resolverlo igual que la pregunta 1, escribiendo cada operación a mano dentro de `_ready()`:

```gdscript
var energia = 100
var posicion_x = 0
var posicion_y = 0

func _ready() -> void:
    print("Me moví en este orden: arriba, abajo, derecha, derecha")
    # arriba
    energia = energia - 10
    posicion_y = posicion_y - 100
    # abajo
    energia = energia - 10
    posicion_y = posicion_y + 100
    # derecha
    energia = energia - 10
    posicion_x = posicion_x + 100
    # derecha
    energia = energia - 10
    posicion_x = posicion_x + 100

    print("Energía: ", energia)
    print("X: ", posicion_x)
    print("Y: ", posicion_y)
```

Funciona, pero se empieza a repetir mucho todo, estaría bueno poder escribir nuestros propios cómandos para darle a pepita. Es decir, ¡poder definir nuestras propias funciones!.

### Resolución - versión con funciones

Podemos **extraer** las líneas de código que se ejecutan cuando pepita se mueve en una función, y después podemos solo esas funciones nuestras:

```gdscript
var energia = 100
var posicion_x = 0
var posicion_y = 0

func _ready() -> void:
    print("Me moví en este orden: arriba, abajo, derecha, derecha")
    # arriba
    mover_arriba()
    # abajo
    mover_abajo()
    # derecha
    mover_derecha()
    # derecha
    mover_derecha()

    print("Energía: ", energia)
    print("X: ", posicion_x)
    print("Y: ", posicion_y)

func mover_arriba():
    energia = energia - 10
    posicion_y = posicion_y - 100

func mover_abajo():
    energia = energia - 10
    posicion_y = posicion_y + 100

func mover_derecha():
    energia = energia - 10
    posicion_x = posicion_x + 100

func mover_izquierda():
    energia = energia - 10
    posicion_x = posicion_x - 100
```

Las dos versiones dan el mismo resultado. En la consola veríamos:
```
Me moví en este orden: arriba, abajo, derecha, derecha
Energía: 60
X: 200
Y: 0
```

---

## Pregunta 3

Algo que no estábamos teniendo en cuenta es que si su energía llega a 0, ya está cansada por lo que no debería poder volver a moverse.

Entonces, ¿con qué energía y en qué posición debería quedar si se mueve:
- 6 veces para arriba
- 5 veces para la derecha
- 2 veces para abajo

### Resolución

Agregando un `if` dentro de cada función podemos hacer que pepita solamente se mueva si tiene energía:

```gdscript
func mover_arriba():
# Si pepita no tiene más de 0 de energía, las líneas que están "dentro" del if no se ejecutan
    if energia > 0:
        energia = energia - 10
        posicion_y = posicion_y - 100

func mover_abajo():
    if energia > 0:
        energia = energia - 10
        posicion_y = posicion_y + 100

func mover_derecha():
    if energia > 0:
        energia = energia - 10
        posicion_x = posicion_x + 100

func mover_izquierda():
    if energia > 0:
        energia = energia - 10
        posicion_x = posicion_x - 100
```

El resto del código nos queda similar a lo que veníamos haciendo:

```gdscript
var energia = 100
var posicion_x = 0
var posicion_y = 0

func _ready() -> void:
    print("Me intento mover: 6 veces para arriba, 5 para la derecha, 2 para abajo")
    mover_arriba()
    mover_arriba()
    mover_arriba()
    mover_arriba()
    mover_arriba()
    mover_arriba()
    mover_derecha()
    mover_derecha()
    mover_derecha()
    mover_derecha()
    mover_derecha()
    mover_abajo()
    mover_abajo()

    print("Energía: ", energia)
    print("X: ", posicion_x)
    print("Y: ", posicion_y)
```


Son 13 movimientos en total, pero Pepita solo tiene energía para 10 (100 / 10 = 10). Los últimos 3 movimientos no se ejecutan gracias al `if energia > 0`.

En la consola veríamos:
```
Me intento mover: 6 veces para arriba, 5 para la derecha, 2 para abajo
Energía: 0
X: 500
Y: -400
```

Los 10 movimientos que sí se ejecutan son: 6 arriba + 4 derecha. La 5ta derecha y las 2 de abajo se ignoran.

