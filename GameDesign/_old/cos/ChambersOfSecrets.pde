int w=30;//16
int h=12;//12
byte tsize=64;
int telaw=25, telah=13;

boolean hide = false;

String savePath;

byte tipotile;//tipo de fase
PImage terreno [] = new PImage [16*16];
int sprite []= new int[128*128];

PImage tileset;
int select;
byte menu=0;

int tipofase;
int scroll;
int scrollv;

boolean control;
boolean p;
PImage arrow;

void setup(){
  addMouseWheelListener(new java.awt.event.MouseWheelListener() { 
    public void mouseWheelMoved(java.awt.event.MouseWheelEvent evt) { 
      mouseWheel(evt.getWheelRotation());
    }
  }
  ); 
  background(150);
  size (telaw*tsize,telah*tsize+tsize*4+4);
  smooth();
  tipotile=1;
  tileset=loadImage(tipotile+".png");
  pushMatrix();
  scale(1,1);
  image (tileset,0,0);
  popMatrix();
  for (int i = 0; i<16; i++) for (int j = 0; j< 16; j++){
    terreno[i+j*16]=get(i*tsize,j*tsize,tsize,tsize);
  }
  arrow = loadImage("cursor.png");
  noStroke();
  p = false;
}

void draw(){
  if (p==true) noCursor();
  else cursor();
  pushMatrix();
    translate(scroll, scrollv - h*tsize + telah*tsize);
    background(0);
    fill(150);
    rect (0,0,tsize*w,tsize*h);
    for (int i = 0; i<w;i++) for (int j = 0; j<h;j++){
      if (sprite[i+j*w]==0) tint(255, 20);
      else tint (255);
      image(terreno[sprite[i+j*w]],i*tsize,j*tsize);
    }
    tint(255);
  popMatrix();
  if (!hide)
  {
    for (int i = 0; i<16;i++)for (int j = 0; j<4;j++){
      image(terreno[i+(j+4*menu)*16],i*tsize,j*tsize+4+telah*tsize);
      if (mousePressed && mouseX>=i*tsize && mouseX<(i+1)*tsize && mouseY>=j*tsize+4+telah*tsize && mouseY<(j+1)*tsize+4+telah*tsize) {
        select = int(i+(j+4*menu)*16);
        //if (mouseButton==CENTER) for (int k = 0; k<sprite.length;k++) sprite[k] = select;
      }
    }
  
    noFill();
    strokeWeight(2);
    stroke(255,0,0);
    if (select/(16*4)==menu){
      rect ((select%16)*tsize,tsize*telah+4+((select/16)%4)*tsize,tsize,tsize);
    }
    noStroke();
    
  }

  if (mousePressed == true) clique();
  if (p==true) image (arrow, mouseX,mouseY-4);
}

void keyPressed(){
  if (key == 'h') hide = true;
  if (key == 's') salva();
  if (key == 'l') carrega();
  if (control== false){
    if (keyCode == UP) scrollv+=tsize/2;
    if (keyCode == DOWN) scrollv-=tsize/2;
    if (keyCode == LEFT) scroll+=tsize/2;
    if (keyCode == RIGHT) scroll-=tsize/2;
  }
  else{
    if (keyCode == UP&& h>telah) dimAlt();
    if (keyCode == DOWN&& h<127) aumAlt();
    if (keyCode == LEFT&& w>telaw) dimLar();
    if (keyCode == RIGHT&& w<127) aumLar();
  }
  if (key=='1') menu=0;
  if (key=='2') menu=1;
  if (key=='3') menu=2;
  if (key=='4') menu=3;
  if (key == 'p') {
    if (p==true) p=false;
    else p=true;
  }
  if (keyCode == CONTROL) control=true;
}

void keyReleased(){
  if (keyCode==CONTROL) control=false;
  if (key == 'h') hide = false;
}

void dimAlt(){
  h--;
}

void aumAlt(){
  h++;
}

void dimLar(){ //problema na coluna da esquerda
  for (int j = 0; j<h;j++) for (int i = 0; i<w*h;i++) {
    if (i>=j*w-j+w)sprite[i]=sprite[i+1];
  }
  w--;
}

void aumLar(){
  for (int j = 0; j<h;j++) for (int i = w*h; i>0;i--) {
    if (i>=j*w-j+w)sprite[i]=sprite[i-1];
  }
  w++;
  for(int i =0;i<h;i++){
    sprite[w-1+w*i]=0;
  }
}

void clique(){
  if (mouseX>0 && mouseX-scroll<w*tsize && mouseY>0 && mouseY-(scrollv - h*tsize + telah*tsize)<h*tsize){
    if (mouseButton==LEFT && mouseY<telah*tsize){
      sprite[(mouseX-scroll)/tsize+((mouseY-(scrollv - h*tsize + telah*tsize))/tsize)*w]=select;
    }
    else if (mouseButton==RIGHT)select=sprite[(mouseX-scroll)/tsize+((mouseY-(scrollv - h*tsize + telah*tsize))/tsize)*w];
  }
}

void mouseWheel(int delta) {
  menu+=delta;
  if (menu>3) menu = 0;
  if (menu<0) menu = 3; 
}


