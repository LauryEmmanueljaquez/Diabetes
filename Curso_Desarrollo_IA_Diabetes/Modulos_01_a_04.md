# Capítulo 1: Fundamentos de IA y Regresión para Desarrolladores

## Objetivo
Entender qué es la regresión lineal y por qué es el algoritmo adecuado para nuestro problema de diabetes antes de escribir una sola línea de código.

## 1.1 ¿Clasificación o Regresión?
Muchos estudiantes confunden estos términos. 
*   **Clasificación**: Es predecir una categoría (ej. ¿Es un gato o un perro? ¿Tiene diabetes: SÍ o NO?).
*   **Regresión**: Es predecir un **valor continuo** (ej. ¿Cuál será el precio de esta casa? ¿Cuánto progresará la enfermedad: 15.4 o 98.2?).

En este curso, usamos **Regresión** porque el *Diabetes Dataset* de la Universidad de Carolina del Norte nos da una medida cuantitativa de progresión, no una etiqueta binaria.

## 1.2 La Matemática Simplificada
Imagina que quieres dibujar una línea recta que pase lo más cerca posible de todos los puntos en un gráfico.
*   **La Ecuación**: `y = mx + b` (donde 'y' es la progresión de la enfermedad y 'x' son las variables como IMC o edad).
*   **El Entrenamiento**: Es el proceso donde la computadora ajusta 'm' (la pendiente) y 'b' (la intersección) miles de veces hasta minimizar el error.

---

# Capítulo 2: Configuración del Entorno de Desarrollo (Setup)

## Objetivo
Preparar nuestra máquina como la de un Ingeniero de ML profesional, evitando los típicos errores de "no funciona en mi máquina".

## 2.1 Instalación de Python y Node.js
Necesitamos dos motores:
1.  **Python 3.10+**: El cerebro matemático.
2.  **Node.js 18+ y npm**: El motor de la interfaz web.

## 2.2 Estructura del Proyecto
Vamos a crear una arquitectura "Monorepo" simple:
```
/diabetes-project
  /backend  (Aquí vive la IA)
  /frontend (Aquí vive la web)
```
*Ejercicio Práctico*: Abran su terminal. Ejecuten `python --version` y `node -v`. Si obtienen error, deténganse y revisen las variables de entorno del sistema (PATH).

---

# Capítulo 3: Análisis del Dataset de Diabetes

## Objetivo
Explorar los datos crudos. Un modelo de IA es tan bueno como los datos que lo alimentan (Garbage In, Garbage Out).

## 3.1 Origen de los Datos
Usaremos el dataset nativo de `scikit-learn`, originalmente publicado por Efron et al. (2004). Contiene 442 pacientes y 10 variables base.

## 3.2 Las Variables Clínicas (Features)
Es vital entender qué estamos analizando:
1.  **Age**: Edad.
2.  **Sex**: Sexo biológico.
3.  **BMI**: Índice de masa corporal.
4.  **BP**: Presión arterial media.
5.  **S1-S6**: Seis mediciones de suero sanguíneo (incluyendo TC, LDL, HDL, TCH, LTG, GLU).

*Visualización Mental*: Imaginen una hoja de Excel gigante. Nuestro trabajo es encontrar patrones ocultos en esas filas numéricas que un médico humano tardaría horas en correlacionar.

---

# Capítulo 4: Construcción del Backend con FastAPI

## Objetivo
Crear el "esqueleto" del servidor que alojará nuestra inteligencia artificial.

## 4.1 ¿Por qué FastAPI y no Flask/Django?
Para IA, la velocidad es crítica. FastAPI:
*   Es **asíncrono** (puede manejar múltiples peticiones a la vez).
*   Valida datos automáticamente con **Pydantic** (evita que enviemos texto donde va un número).
*   Genera documentación automática (Swagger UI).

## 4.2 "Hello World" Clínico
Crearemos nuestro archivo `main.py`. Importaremos `FastAPI` y levantaremos un servidor local.
```python
from fastapi import FastAPI
app = FastAPI()

@app.get("/")
def home():
    return {"status": "Sistema de IA Online"}
```
Al ejecutar esto con `uvicorn`, tendremos un servidor vivo esperando instrucciones.
