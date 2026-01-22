# Capítulo 5: Entrenamiento del Modelo (El "Cerebro")

## Objetivo
El corazón del curso. Escribiremos el código que "aprende".

## 5.1 Carga y División de Datos
No podemos usar todos los datos para entrenar; estaríamos haciendo trampa (overfitting).
Usaremos la técnica **Train/Test Split**:
*   **80% de datos** para entrenar (Estudiar).
*   **20% de datos** para validar (El examen final).

```python
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
```

## 5.2 El Algoritmo
Instanciaremos `LinearRegression`. Con una sola línea `.fit(X_train, y_train)`, ocurrirá la magia matemática. El sistema ajustará sus coeficientes internos para minimizar el error cuadrático medio.

## 5.3 Serialización con Joblib
Una vez entrenado, no queremos re-entrenar cada vez. Guardaremos el "cerebro" en un archivo `.pkl` (Pickle). Es como "guardar partida" en un videojuego para cargarla después.

---

# Capítulo 6: Creación de la API REST

## Objetivo
Permitir que el mundo exterior hable con nuestro cerebro de Python.

## 6.1 Definición del Modelo de Datos (DTO)
Usaremos Pydantic para definir estrictamente qué esperamos recibir. Si el frontend envía "Edad: 'veinte'", el sistema debe rechazarlo antes de que rompa el modelo matemático.

```python
class PacienteDTO(BaseModel):
    age: float
    bmi: float
    # ... resto de variables
```

## 6.2 El Endpoint `/predict`
Crearemos una ruta POST. ¿Por qué POST? Porque enviamos datos complejos y privados del paciente.
Esta función:
1.  Recibe el JSON del frontend.
2.  Lo convierte en un array de `numpy`.
3.  Llama a `model.predict()`.
4.  Devuelve el resultado JSON.

---

# Capítulo 7: Inicialización del Frontend (Vite + React)

## Objetivo
Salir de la consola negra y pasar al navegador visual.

## 7.1 Vite vs Create-React-App
Vite es el nuevo estándar. Es instantáneo. Usaremos la plantilla `react-ts` porque TypeScript nos ayuda a evitar errores médicos graves (como confundir miligramos con gramos en código).

## 7.2 Limpieza del Boilerplate
Instalamos, borramos los logos de React giratorios y dejamos un lienzo en blanco (`App.tsx` vacío y `index.css` limpio). Este es nuestro quirófano estéril listo para trabajar.

---

# Capítulo 8: Diseño de la Interfaz (UI/UX Médica)

## Objetivo
Crear una interfaz que inspire confianza y calma.

## 8.1 Psicología del Color y Glassmorphism
No usaremos un blanco aburrido. Implementaremos un diseño oscuro moderno con tonos índigo (tecnología) y verde (salud).
El **Glassmorphism** (efecto de vidrio esmerilado) se logra con `backdrop-filter: blur()`. Esto da una sensación de profundidad y tecnología avanzada.

## 8.2 Tipografía
Usaremos 'Outfit' de Google Fonts. Es limpia, geométrica y extremadamente legible en pantallas, crucial para leer datos médicos.
