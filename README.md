# Introducción a la Programación con Godot

El código que hay en el repo es siguiendo un ejercicio que resolvimos en clase, podés ver el enunciado completo y una resolución paso a paso en [ejercicio-pepita.md](ejercicio-pepita.md).

---

## 1. Primeros pasos: Hola Mundo

### ¿Qué es un script?

Un script es un archivo de texto donde escribimos instrucciones para que la computadora las ejecute. En Godot, usamos un lenguaje llamado **GDScript**. Cada script se asocia a un **nodo** de la escena, y la primera línea indica de qué tipo es ese nodo:

```gdscript
extends Node2D
```

### Comentarios

Si una línea empieza con `#`, esa línea **no se ejecuta**. Se llama **comentario** y sirve para dejar notas o explicaciones en el código.

```gdscript
# Esto es un comentario, la computadora lo ignora
```

### Sintaxis

La **sintaxis** son las reglas que definen cómo se escribe código válido. Si no las respetamos, el programa nos va a dar un error. Por ejemplo, después de los `:` siempre hay que usar un **TAB** (sangría) en la línea siguiente.

### Valores y tipos

Un **valor** es un dato dentro de nuestro programa. Existen distintos **tipos** de valores:

- **String**: texto, se escribe entre comillas. Ejemplo: `"Hola mundo"`
- **Números**: valores numéricos como `100`, `0`, `-400.0`
- **Booleanos**: solo pueden ser `true` (verdadero) o `false` (falso)
- **Vector2**: un par de números que representa una posición en 2D, este valor a su vez tiene 2 valores numéricos `x` e `y`. Ejemplo: `Vector2(0, 0)`.

### Variables

Las **variables** son como cajitas con nombre donde guardamos valores. Ese valor puede ir cambiando a lo largo del programa.

```gdscript
var energia = 100
var posicion_x = 0
```

Para cambiar el valor de una variable, le asignamos uno nuevo. Por ejemplo, si queremos restarle 10 a la energía:

```gdscript
energia = energia - 10
```

Esto calcula `energia - 10` y guarda el resultado de vuelta en `energia`.

### Funciones

Una **función** es un comando que le damos a la computadora. Godot trae funciones ya definidas, como `print()`, que muestra un mensaje en la consola:

```gdscript
print("Hola mundo")
print("Tengo de energia ", energia)
```

Si queremos pasar varios valores a `print`, los separamos con coma.

La sintaxis para *usar* una función es el nombre de la función seguido de paréntesis y, si le tuviesemos que proveer valores, los valores separados por coma.


### Definir nuestras propias funciones

También podemos crear nuestras propias funciones:

```gdscript
func mover_arriba():
    if energia > 0:
        energia = energia - 10
        posicion_y = posicion_y - 100
```

Para definir una función se escribe `func`, luego el nombre, luego `():` y adentro (recordar usar TAB) las instrucciones que queremos que ejecute.

### La función `_ready()`

Es una función especial de Godot que se ejecuta **una sola vez** cuando el nodo entra a la escena.

```gdscript
func _ready() -> void:
    print("Hola mundo")
```

### `if`

El `if` nos permite ejecutar código **solo si una condición es verdadera**:

```gdscript
if energia > 0:
    energia = energia - 10
```

Si `energia` no es mayor a 0, esas líneas no se ejecutan.

---

## 2. Movimiento Top-Down (vista desde arriba)

### `CharacterBody2D`

Cuando queremos un personaje que se mueva y choque con cosas, usamos un nodo de tipo **CharacterBody2D**.
Este nodo ya viene con algunas cosas definidas:

- La variable `velocity`: la velocidad del personaje (cuánto se mueve en pixeles por segundo).
- La función `move_and_slide()`: que mueve al personaje según su `velocity` y lo frena si choca con algo.
- ...y más que seguiremos viendo durante las otras clases.

### La función `_physics_process(delta)`

A diferencia de `_ready()` que se ejecuta una sola vez, **`_physics_process()` se ejecuta en cada frame** (muchas veces por segundo). Acá es donde ponemos la lógica de movimiento.

### Leer el teclado con `Input`

Para saber si el jugador está apretando una tecla usamos:

```gdscript
Input.is_action_pressed("mover_abajo")
```

Esto devuelve `true` si la tecla está presionada, o `false` si no. Las acciones como `"mover_abajo"` se configuran en Godot.

### `if`, `elif` y `else`

Podemos encadenar varias condiciones:

```gdscript
if Input.is_action_pressed("mover_abajo"):
    velocity.y = rapidez          # Si aprieta abajo la velocidad vertical es rapidez
elif Input.is_action_pressed("mover_arriba"):
    velocity.y = -rapidez         # Si no aprieta abajo pero sí aprieta arriba, la velocidad vertical es -rapidez
else:
    velocity.y = 0                # Si no aprieta ninguna, la velocidad vertical es 0
```

- **`if`**: "si esto es verdad, hacé esto"
- **`elif`**: "si no, pero si esto otro es verdad, hacé esto"
- **`else`**: "si ninguna de las anteriores fue verdad, hacé esto"
