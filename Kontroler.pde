class Kontroler {
  PVector[] geni;//Niz vektora koji usmeravaju jedinku 
  int instrukcija = 0;

  Kontroler(int size) {
    geni = new PVector[size];
    randomize();
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
  //////////////////////Postavlja sve vektore u genu na nasumican smer u duzini od 1///////////////////////////////////////
  void randomize() {
    for (int i = 0; i< geni.length; i++) {
      float randomUgao = random(2*PI);
      geni[i] = PVector.fromAngle(randomUgao);
    }
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////Vraca kopiju kontrolera jedinke///////////////////////////////////////////////////////////
  Kontroler kopija() {
    Kontroler kopija = new Kontroler(geni.length);
    for (int i = 0; i < geni.length; i++) {
      kopija.geni[i] = geni[i].copy();
    }
    return kopija;
  }
  Kontroler crossover(Kontroler partner){
    Kontroler dete = new Kontroler(geni.length);
    int rn = (int) random(geni.length);
    for(int i=0; i<geni.length; i++){
      if(i>rn){
        dete.geni[i] = geni[i].copy();
      } else {
        dete.geni[i] = partner.geni[i].copy();
      }
    }
    return dete;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////Mutira kontroler postavljajuci random vektore u neke gene//////////////////////////////////////////
  void mutate() {
    float mutationRate = 0.01;//Sansa da ce doci do mutacije
    for (int i =0; i< geni.length; i++) {
      float rand = random(1);
      if (rand < mutationRate) {
        //postavlja ovaj gen u random smer
        float randomUgao = random(2*PI);
        geni[i] = PVector.fromAngle(randomUgao);
      }
    }
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
