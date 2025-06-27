macro "Batch Measure DTI [F6]" {
    run("Set Measurements...", "area mean standard limit display redirect=None decimal=3");

    // Directorios
    dir1 = getDirectory("/images/"); // imágenes
    dir2 = getDirectory("/roi/");    // solo 1 ROI
    dir3 = getDirectory("/tif");     // salida

    setBatchMode(false);

    // Obtener listas de archivos
    list = getFileList(dir1);
    list2 = getFileList(dir2);

    // Abrir el ROI una vez y guardarlo en el ROI Manager
    roiPath = dir2 + list2[0];
    if (!endsWith(roiPath, "/")) {
        roiManager("reset");
        roiManager("Open", roiPath);
    }

    // Procesar todas las imágenes
    for (i = 0; i < list.length; i++) {
        path = dir1 + list[i];
        showProgress(i, list.length);
        if (!endsWith(path, "/")) open(path);

        if (nImages >= 1) {
            // Escala
            run("Set Scale...", "distance=66.0034 known=1 pixel=1 unit=cm");

            // Convertir a canal azul
            run("RGB Color");
            run("RGB Stack");
            run("Stack to Images");
            selectWindow("Green");
            close();
            selectWindow("Red");
            close();
            selectWindow("Blue");
            rename(list[i]);

            // Aplicar umbral
            run("Auto Threshold", "method=Intermodes white");
            setAutoThreshold("Default");

            // Medir usando el ROI cargado previamente
            for (j = 0; j < roiManager("count"); j++) {
                roiManager("select", j);
                run("Analyze Particles...", "size=1-Infinity clear summarize");
            }

            roiManager("deselect");

            // Guardar imagen
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
