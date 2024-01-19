macro "Batch Measure DTI [F6]" {
        run("Set Measurements...", "area mean standard limit display redirect=None decimal=3");
        // Se tienen que cambiar los directorios cuando se cambie de carpeta (estan clasificadas por dias)
        //  Etiquetar las fotos de esta forma: Poblacion(nº individuo)_Replica_Tipo de hoja : 27VV19(1)_1_VG
        // Primero correr el script con las ojas VG y obtener los resultados, después hacerlo con hojas RP
        dir1 = getDirectory("C:/Users/Usuario/Documents/2_MARINA/1_NiDEVA/3_OBJETIVO_3/2_SLA/prueba/images/"); // Aqui va el directorio que tenga las imagenes de las hojas
        dir2 = getDirectory("C:/Users/Usuario/Documents/2_MARINA/1_NiDEVA/3_OBJETIVO_3/2_SLA/prueba/roi/"); //Directorio de los rois (recuadros), en este caso solo habrá un roi que ocupe toda la zona del cristal
        dir3 = getDirectory("C:/Users/Usuario/Documents/2_MARINA/1_NiDEVA/3_OBJETIVO_3/2_SLA/prueba/tif"); // Directorio de las imagenes que se guardan al hacerl el autothreshold de las hojas
      
       setBatchMode(false);
        list = getFileList(dir1); // Lista de todas las fotos
        list2 = getFileList(dir2); // Lista de todos los rois
         for (i=0; i<list.length; i++) {
                path = dir1+list[i];
                showProgress(i, list.length);
               if (!endsWith(path,"/")) 
               open(path);
               if (nImages>=1) {
               	//loading ROIs here
               	path2 = dir2+list2[0];
               	if (!endsWith(path2,"/"))
               	
    // OJO!! cambiar la escala!!! Hay que cambiarla cada vez que se cambie de dia
    run("Set Scale...", "distance=66.0034 known=1 pixel=1 unit=cm"); // Cojo siempre el cm 19-20
	run("RGB Color");
    run("RGB Stack");
	run("Stack to Images");
	selectWindow("Green");
	close();
	selectWindow("Red");
	close();
	selectWindow("Blue"); // Asi se queda solo con la tercera imagen del Stack
	rename(list[i]);
	
	// roi 1 
	roiManager("Open", path2);
	
	// para cambiar el método
	run("Auto Threshold", "method=Intermodes white"); //  antes en method había minimun white pero quedaban partes en blanco
	setAutoThreshold("Default");
		
	for (j=0 ; j<roiManager("count"); j++) {
    	// selectImage(list[i]);
    	roiManager("select", j);
    	run("Analyze Particles...", "size=1-Infinity clear summarize");
	}
	roiManager("Delete");	
	
	//guardar las imagenes con los roi
	selectWindow(list[i]);
    saveAs("Tiff",dir3 +list[i]);
    close();
     //closes main image window
                                if (isOpen("Exception")) {
                                        selectWindow("Exception");
                                        run("Close");           //close error windows to avoid saving to results.
                                        }

                         }

        // if (isOpen("Results")) {
          //      selectWindow("Results");
            //    run("Close");
              //  }
        }
} 
