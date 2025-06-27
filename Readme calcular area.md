# 📐 Batch Measure DTI – Fiji Macro

Este tutorial te permite medir automáticamente el área de hojas en múltiples imágenes utilizando un único ROI (Región de Interés). Funciona correctamente **cuando hay una hoja por imagen**. Si hay más de una hoja por foto, puedes **recortarlas previamente** o ejecutar el macro tantas veces como hojas tengas cada vez con un roi diferente.

## 🧩 Requisitos

- **Fiji / ImageJ** instalado:  
  👉 [Descargar aquí](https://imagej.net/software/fiji/downloads)

## 🧰 Preparación inicial

Organiza tu proyecto con las siguientes carpetas:

```
/images/   → Imágenes originales (una hoja por imagen)
/roi/      → ROI único (.roi o .zip) que delimite el área a analizar
/tif/      → Salida de imágenes procesadas
```

## 🖼️ Crear y guardar el ROI

1. **Abrir imagen** en Fiji  
2. Abrir el **ROI Manager**:  
   ![ROI Manager](img/Imagen1.png?raw=true "Abrir ROI Manager")

3. Dibujar un recuadro (ROI) y hacer clic en **Add[]**:  
   ![Add ROI](img/Imagen2.png?raw=true "Añadir ROI")

4. Seleccionar el ROI en el ROI Manager  
5. Guardar el ROI: `More > Save`  
   ![Guardar ROI](img/Imagen3.png?raw=true "Guardar ROI")

6. Guardar el ROI en la carpeta `/roi/` con cualquier nombre (ej. `zona_cristal.roi`)  
   ![Guardar ROI en carpeta](img/Imagen4.png?raw=true "Guardar en carpeta")

7. **Cerrar la imagen**  
   ![Cerrar imagen](img/Imagen5.png?raw=true "Cerrar imagen")

## 🧪 Ejecutar el macro

8. Ir a: `File > Plugins > Macros > Run`  
   ![Run macro](img/Imagen8.png?raw=true "Ejecutar macro")

9. Seleccionar el archivo `.ijm` del macro  
   ![Seleccionar macro](img/Imagen9.png?raw=true "Seleccionar macro")

10. Aparecerán ventanas para elegir:
    - **Carpeta de imágenes** (`/images/`)
    - **Carpeta de ROI** (`/roi/`)
    - **Carpeta de salida** (`/tif/`)

## 🧠 ¿Qué hace el macro?

- Carga el ROI una sola vez
- Aplica umbral automático (`Intermodes`) a la banda azul de la imagen
- Mide partículas dentro del ROI
- Guarda la imagen binaria umbralizada en `/tif/`
- Los resultados aparecen en la ventana `Results` (puedes guardarlos manualmente)

## 🧬 Código del macro

```java
macro "Batch Measure DTI [F6]" {
    run("Set Measurements...", "area mean standard limit display redirect=None decimal=3");

    dir1 = getDirectory("Choose Source Directory");  // imágenes
    dir2 = getDirectory("Choose ROI Directory");     // ROI
    dir3 = getDirectory("Choose Output Directory");  // salida

    setBatchMode(false);

    list = getFileList(dir1);
    list2 = getFileList(dir2);

    // Cargar ROI una sola vez
    roiPath = dir2 + list2[0];
    if (!endsWith(roiPath, "/")) {
        roiManager("reset");
        roiManager("Open", roiPath);
    }

    for (i = 0; i < list.length; i++) {
        path = dir1 + list[i];
        showProgress(i, list.length);
        if (!endsWith(path, "/")) open(path);

        if (nImages >= 1) {
            run("Set Scale...", "distance=66.0034 known=1 pixel=1 unit=cm");

            run("RGB Color");
            run("RGB Stack");
            run("Stack to Images");
            selectWindow("Green"); close();
            selectWindow("Red"); close();
            selectWindow("Blue");
            rename(list[i]);

            run("Auto Threshold", "method=Intermodes white");
            setAutoThreshold("Default");

            for (j = 0; j < roiManager("count"); j++) {
                roiManager("select", j);
                run("Analyze Particles...", "size=1-Infinity clear summarize");
            }

            roiManager("deselect");

            selectWindow(list[i]);
            saveAs("Tiff", dir3 + list[i]);
            close();

            if (isOpen("Exception")) {
                selectWindow("Exception");
                run("Close");
            }
        }
    }
}
```

## 📊 Guardar resultados

- Ve a la ventana `Results`
- Haz clic en `File > Save As…` y guarda los resultados como `.csv` o `.xls`

## ✅ Notas adicionales

- Puedes cambiar el método de umbral (`Intermodes`) por otro como `Otsu`, `Yen`, etc.
- Asegúrate de ajustar la escala si usas otra regla de referencia.
- El macro funciona solo si hay una hoja por imagen. Si hay varias, córtalas primero.

