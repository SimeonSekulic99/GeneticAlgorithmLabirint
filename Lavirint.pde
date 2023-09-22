Populacija provera;
PVector goal  = new PVector(50, 50);  //Pozicija cilja: Gore levo(50, 40) Levo(50,450) Dole(350,750) Gore(850,40) Gore desno(1350,40)
PFont f;
int p=0;
int br=0;
boolean rc=false;
int x=1400;
int y=800;

void setup(){
  frameRate(100); //Brzina u frejmovima
  size(1400,800); //Velicina prozora
  //surface.setResizable(true);
  provera = new Populacija(1000); //broj jedinki u populaciji
  f = createFont("Arial",16,true);
}

void draw(){
  //Lavirint
  background(100, 100, 100);
  fill(30,30,30);
  stroke(30,30,30);
      //obod
      rect(0, y-5, x, 5);//dole
      rect(0, 0, x, 5);//gore
      rect(0, 0, 5, y);//levo
      rect(x-5, 0, 5, y);//desno
      //prepreke (x,y,+x,+y)
      rect(0, 300, 400, 100);
      rect(0, 500, 300, 800);
      rect(400, 550, 400, 150);
      rect(500, 0, 300, 450);
      rect(900, 0, 400, 450);
      rect(900, 550, 400, 450);
      rect(100, 0, 500, 200);
  
  //Meta
  fill(0, 0, 255);
  ellipse(goal.x, goal.y, 45, 45);
  fill(255, 0, 0);
  ellipse(goal.x, goal.y, 30, 30);
  fill(255, 255, 0);
  ellipse(goal.x, goal.y, 15, 15);
  
  
  //Brojac generacije i koraka do cilja
  fill(5, 82, 240);
  textFont(f,36);
  text("Generacija - "+(br+1),150,40);
  
  if(provera.pc && !rc){
  fill(255,0,0);
  text("Meta nije pogodjena",150,80);
  p=br;
  rc=true;}else if(p==0){
  fill(255,0,0);
  text("Meta nije pogodjena",150,80);}else{
  fill(0,255,0);
  text("Meta pogodjena u generaciji - "+p,150,80);
  }
  
  if(provera.pc){
  fill(0,255,0);
  text("Najmanji broj koraka do cilja - "+provera.najmanjeInstrukcija,150,120);
  }    
  
  if (provera.SveJedinkeNeaktivne()) {
    //Podesavanje genetskog algoritama ako nema vise aktivnih jedinki
    provera.racunanjeFitnesa();
    provera.prirodnaSelekcija();
    provera.mutacijaPotomaka();
    br=br+1;
  } else {
    //Azurira poziciju aktivnih jedinki ako ih idalje ima
    provera.azuriranje();
    provera.prikaz();
  }
}
