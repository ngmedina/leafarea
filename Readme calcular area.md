# Batch Measure DTI – Fiji Macro

Este tutorial te permite medir automáticamente el área de hojas en múltiples imágenes utilizando un único ROI (Región de Interés). Funciona correctamente **cuando hay una hoja por imagen**. Si hay más de una hoja por foto, puedes **recortarlas previamente** o ejecutar el macro tantas veces como hojas tengas cada vez con un roi diferente.

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

1. **Abrir imagen** en Fiji  
2. Abrir el **ROI Manager**:
   
   ![ROI Manager](img/Imagen1.png?raw=true "Abrir ROI Manager")

4. Dibujar un recuadro (ROI) y hacer clic en **Add[]**:
    
   ![Add ROI](img/Imagen2.png?raw=true "Añadir ROI")

6. Seleccionar el ROI en el ROI Manager  
7. Guardar el ROI: `More > Save`
   
   ![Guardar ROI](img/Imagen3.png?raw=true "Guardar ROI")

9. Guardar el ROI en la carpeta `/roi/` con cualquier nombre (ej. `zona_cristal.roi`)
    
   ![Guardar ROI en carpeta](img/Imagen4.png?raw=true "Guardar en carpeta")

11. **Cerrar la imagen**  
   ![Cerrar imagen](img/Imagen5.png?raw=true "Cerrar imagen")

## 🧪 Ejecutar el macro

12. Descargar el macro:
   👉 [Descargar aquí](https://github.com/ngmedina/leafarea/blob/main/calculate%20area_Hoja_v5.ijm)

13. Ir a: `File > Plugins > Macros > Run`  
   ![Run macro](img/Imagen8.png?raw=true "Ejecutar macro")

14. Seleccionar el archivo `.ijm` del macro  
   ![Seleccionar macro](img/Imagen9.png?raw=true "Seleccionar macro")

15. Aparecerán ventanas para elegir:
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

