class Jedinka {
  PVector pozicija;
  PVector brzina;
  PVector ubrzanje;
  boolean neaktivna = false;
  boolean pogodjenaMeta = false;
  boolean najboljaJedinka = false;
  float fitnes = 0;
  Kontroler kontroler;

  Jedinka() {
    kontroler = new Kontroler(1000);//Kontroler dobija 1000 novih instrukcija
    pozicija = new PVector(1350,750, height- 50); //Pocetna pozicija populacije Gore(1350,30) Dole(50,50)
    brzina = new PVector(0, 0); //Pocetna brzina
    ubrzanje = new PVector(0, 0); //pocetno ubrzanje
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////Prikazivanje jedinki u prozoru////////////////////////////////////////////////////////////////////
  void prikaz() {
    //Prikazivanje jedinke sa najboljim fitnesom
    if (najboljaJedinka) {
      fill(255, 255, 0);
      ellipse(pozicija.x, pozicija.y, 10, 10);
    }
    //prikazivanje ostalih jedinki
    else {
      fill(0, 200, 0);
      stroke(0, 150, 0);
      ellipse(pozicija.x, pozicija.y, 5, 5);
    }
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////Pokrece tacku u smeru koji mu da kontroler//////////////////////////////////////////////////
  void kretanje() {
    if (kontroler.geni.length > kontroler.instrukcija) {//Ako ima jos instrukcija postavlja ubrzanje u geniu koji mu daje kontroler
      ubrzanje = kontroler.geni[kontroler.instrukcija];
      kontroler.instrukcija++;
    } 
    else {//Ako nema vise instrukcija jedinka postaje neaktivna
      neaktivna = true;
    }
    brzina.add(ubrzanje);
    brzina.limit(5);//
    pozicija.add(brzina);
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////Poziva kretanje i provera sudaranja/////////////////////////////////////////////////////
  void azuriranje() {
    if (!neaktivna && !pogodjenaMeta) {
      kretanje();
      if (pozicija.x< 5|| pozicija.y<5 || pozicija.x>width-5 || pozicija.y>height -5) {neaktivna = true;} //Deaktivira jedinke koje udare u zid
      else if (dist(pozicija.x, pozicija.y, goal.x, goal.y) < 5) {pogodjenaMeta = true;}//pogodjena meta 
      else if (pozicija.x< 400 && pozicija.y < 402 && pozicija.x > 0 && pozicija.y > 300) {neaktivna = true;} 
      else if (pozicija.x< 800 && pozicija.y < 700 && pozicija.x > 400 && pozicija.y > 550) {neaktivna = true;} 
      else if (pozicija.x< 300 && pozicija.y < 800 && pozicija.x > 0 && pozicija.y > 500) {neaktivna = true;} 
      else if (pozicija.x< 800 && pozicija.y < 450 && pozicija.x > 500 && pozicija.y > 0) {neaktivna = true;} 
      else if (pozicija.x< 800 && pozicija.y < 200 && pozicija.x > 100 && pozicija.y > 0) {neaktivna = true;} //gore levo
      else if (pozicija.x< 1300 && pozicija.y < 450 && pozicija.x > 900 && pozicija.y > 0) {neaktivna = true;} //gore sredina
      else if (pozicija.x< 1300 && pozicija.y < 800 && pozicija.x > 900 && pozicija.y > 550) {neaktivna = true;}
    }
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////Racunamo fitnes jedinki///////////////////////////////////////////////////////////////
  void racunanjeFitnesa() {
    if (pogodjenaMeta) {//Ako je meta pogodjena fitnes se racuna u zavisnosti od broja instrukcija iskoriscenih do mete
      fitnes = 1.0/16.0 + 10000.0/(float)(kontroler.instrukcija * kontroler.instrukcija);
    }
    else {//Ako jedinka nije pogodila metu fitnes se racuna na osnovu odaljenosti od mete
      float distanceToGoal = dist(pozicija.x, pozicija.y, goal.x, goal.y);
      fitnes = 1.0/(distanceToGoal * distanceToGoal);
    }
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////Kopira kontroler roditelja za najbolju jedinku iz predhodne generacije///////////////////////////////////
  Jedinka potomakNajboljeJedinke() {
    Jedinka potomak = new Jedinka();
    potomak.kontroler = kontroler.kopija();
    return potomak;
    }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////Pokretanje crosover funkcije za potomke///////////////////////////////////////////////////////
  Jedinka crosover(Jedinka partner) {
    Jedinka potomak = new Jedinka();
    potomak.kontroler = kontroler.crossover(partner.kontroler);//Potomci dobijaju gene od oba roditelja ukrstanjem
    return potomak;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
