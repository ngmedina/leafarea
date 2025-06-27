# # Medición por lotes de área de la hoja – Macro de Fiji

Este tutorial te permite medir automáticamente el área de hojas en múltiples imágenes utilizando un único ROI (Región de Interés). Funciona correctamente **cuando hay una hoja por imagen**. Si hay más de una hoja por foto, puedes **recortarlas previamente** o ejecutar el macro tantas veces como hojas tengas cada vez con un roi diferente. Para ello emplea un macro en el programa **Fij**

## Requisitos

- **Fiji / ImageJ** instalado:  
  👉 [Descargar aquí](https://imagej.net/software/fiji/downloads)

## Preparación inicial

Organiza tu proyecto con las siguientes carpetas:

```
/images/   → Imágenes originales (una hoja por imagen)
/roi/      → ROI único (.roi o .zip) que delimite el área a analizar
/tif/      → Salida de imágenes procesadas
```

## Crear y guardar el ROI

### 1. **Abrir imagen** en Fiji  
### 2. Abrir el **ROI Manager**:
   
   ![ROI Manager](img/Imagen1.png?raw=true "Abrir ROI Manager")

### 3. Dibujar un recuadro (ROI) y hacer clic en **Add[]**:
    
   ![Add ROI](img/Imagen2.png?raw=true "Añadir ROI")

### 4. Seleccionar el ROI en el ROI Manager  
### 5. Guardar el ROI: `More > Save`
   
   ![Guardar ROI](img/Imagen3.png?raw=true "Guardar ROI")

### 6. Guardar el ROI en la carpeta `/roi/` con cualquier nombre (ej. `zona_cristal.roi`)
    
   ![Guardar ROI en carpeta](img/Imagen4.png?raw=true "Guardar en carpeta")

### 7. **Cerrar la imagen**  
   ![Cerrar imagen](img/Imagen5.png?raw=true "Cerrar imagen")

## 🧪 Ejecutar el macro

### 1. Descargar el macro:
    
   👉 [Descargar aquí](https://github.com/ngmedina/leafarea/blob/main/calculate%20area_Hoja_v5.ijm)

### 2. 🧪 Cambiar el valor de escala para usar el macro

El macro emplea una referencia para convertir los píxeles a unidades reales (como centímetros) usando esta función del macro:

```ijm
run("Set Scale...", "distance=66.0034 known=1 pixel=1 unit=cm");
```

En el ejmplo, la línea le dice a Fiji: “66.0034 píxeles equivalen a 1 cm”. Tienes que ajustar el valor de la escala antes de ejecutar el macro. Para ello:

---

#### 2.1. Abrir una imagen que tenga una escala (como una regla)
Asegúrate de que haya un segmento cuya longitud real conozcas (por ejemplo, 1 cm de una regla visible en la imagen).

---

#### 2.2. Usar la herramienta de línea recta
Selecciona la herramienta de línea (botón de línea en la barra de herramientas) y traza una línea exactamente sobre el segmento de longitud conocida (por ejemplo, de 0 a 1 cm en la regla).

---

#### 2.3. Medir la longitud en píxeles
Ve a `Analyze > Measure` o pulsa `Ctrl+M` para ver cuántos píxeles mide esa línea.  
→ Mira el valor de “Length” en la ventana de resultados.  
💡 Ejemplo: si mide **66.0034** píxeles y representa **1 cm**, ese es el valor que debes usar.

---

#### 2.4. Aplicar esa escala manualmente (opcional)
Puedes ir a `Analyze > Set Scale…` y rellenar así:

- **Distance in pixels**: 66.0034  
- **Known distance**: 1  
- **Unit of length**: cm  
- Marca “Global” si quieres que se aplique a todas las imágenes abiertas  
- Haz clic en “OK”

---

#### 2.5. Actualizar tu macro
Sustituye el valor en tu macro con el número de píxeles que has medido. Ejemplo:

```ijm
run("Set Scale...", "distance=66.0034 known=1 pixel=1 unit=cm");
```

⚠️ **Recuerda:** Este valor puede cambiar entre sesiones o cámaras, así que debes repetir este proceso cada vez que cambie la fuente de las imágenes.

### 🧪 Ejecutar el macro
### 1. Ir a: `File > Plugins > Macros > Run`  
   ![Run macro](img/Imagen8.png?raw=true "Ejecutar macro")

### 2. Seleccionar el archivo `.ijm` del macro  
   ![Seleccionar macro](img/Imagen9.png?raw=true "Seleccionar macro")

### 3. Aparecerán ventanas para elegir:
    - **Carpeta de imágenes** (`/images/`)
    - **Carpeta de ROI** (`/roi/`)
    - **Carpeta de salida** (`/tif/`)

## ¿Qué hace el macro?

- Carga el ROI una sola vez
- Aplica umbral automático (`Intermodes`) a la banda azul de la imagen
- Mide partículas dentro del ROI
- Guarda la imagen binaria umbralizada en `/tif/`
- Los resultados aparecen en la ventana `Results` (puedes guardarlos manualmente)

## Guardar resultados

- Ve a la ventana `Results`
- Haz clic en `File > Save As…` y guarda los resultados como `.csv` o `.xls`

## Notas adicionales

- Puedes cambiar el método de umbral (`Intermodes`) por otro como `Otsu`, `Yen`, etc.
- Asegúrate de ajustar la escala si usas otra regla de referencia.
- El macro funciona solo si hay una hoja por imagen. Si hay varias, córtalas primero.

