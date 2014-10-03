void salva(){
  savePath=selectOutput();
  int[] b= new int[w*h+2];
  b[0]=w;
  b[1]=h;
  for (int i = 0; i< b.length-2; i++){
    b[i+2]=sprite[i];
  }
  if (savePath!=null){
    String saveMe[] = new String [128*128+2];
    for (int i = 0; i < 128*128; i++)
    {
      saveMe[i+2] = str(sprite[i]);
    }
    saveMe[0]=str(w);
    saveMe[1]=str(h);
    saveStrings(savePath+".cos", saveMe);
  }
  PImage screenshot;
  screenshot = get (0,0,w*tsize,h*tsize);
  if (savePath!=null)screenshot.save(savePath+".jpg");
  if (savePath!=null)salvaBinario();
}

void carrega(){
  String loadPath=selectInput();
  if (loadPath!=null){
    String loadMe[] = new String [128*128+2];
    loadMe=loadStrings(loadPath);
    w=int(loadMe[0]);
    h=int(loadMe[1]);
    for (int i = 0; i< loadMe.length-2; i++){
      sprite[i]=int(loadMe[i+2]);
    }
  }
}

void salvaXml(){
  int q=0;
  for (int i =0; i< w*h;i++){
    if (sprite[i]!=0) q++;
  }
  int a = 2;
  String xml[] = new String [q+2];//quantidade de objetos+2
  xml[0]= "largura:"+w*64+" altura:"+h*64;
  for (int i =0; i< h;i++){
    for (int j =0; j< w;j++){
      if (sprite[i+w*j]!=0){
        if (sprite[i+w*j]==1)xml[a]= "<object posx=\""+i*64+"\" posy=\""+(j*64-32)+"\" w=\"64\" h=\"96\" resourceID=\""+(sprite[i+w*j])+"\" animspeed=\"0\" visible=\"true\" colorkey=\"false\"></object>";
        if (sprite[i+w*j]==2)xml[a]= "<object posx=\""+i*64+"\" posy=\""+j*64+"\" w=\"64\" h=\"64\" resourceID=\""+(sprite[i+w*j])+"\" animspeed=\"0\" visible=\"true\" colorkey=\"false\"></object>";
        if (sprite[i+w*j]>2 && sprite[i+w*j]<128)xml[a]= "<object posx=\""+i*64+"\" posy=\""+j*64+"\" w=\"64\" h=\"64\" resourceID=\""+(sprite[i+w*j]+2000-2)+"\" animspeed=\"0\" visible=\"true\" colorkey=\"false\"></object>";
        if (sprite[i+w*j]>=128 && sprite[i+w*j]<128+64)xml[a]= "<object posx=\""+i*64+"\" posy=\""+j*64+"\" w=\"64\" h=\"64\" resourceID=\""+(sprite[i+w*j]+1000)+"\" animspeed=\"0\" visible=\"true\" colorkey=\"false\"></object>";
        if (sprite[i+w*j]==144)xml[a]= "<object posx=\""+i*64+"\" posy=\""+(j*64-32)+"\" w=\"64\" h=\"96\" resourceID=\""+(sprite[i+w*j]+1000)+"\" animspeed=\"0\" visible=\"true\" colorkey=\"false\"></object>";
        if (sprite[i+w*j]==161)xml[a]= "<object posx=\""+i*64+"\" posy=\""+(j*64-32)+"\" w=\"64\" h=\"96\" resourceID=\""+(sprite[i+w*j]+1000)+"\" animspeed=\"0\" visible=\"true\" colorkey=\"false\"></object>";
        a++;
      }
    }

  }
  saveStrings (savePath+".txt",xml);
}

void salvaBinario (){
  int a = 0;
  String bin[] = new String [h];
  for (int i = 0; i < h; i++) bin [i] = new String ();
  for (int i =0; i< h;i++){
    for (int j =0; j< w;j++){
      bin [a] += (j < w-1) ? ((sprite[j+w*i]!=0) ? sprite[j+w*i] + "," : "0,") : ((sprite[j+w*i]!=0) ? sprite[j+w*i] : "0");
    }
    a++;
  }

  saveStrings (savePath+".txt",bin);
}


