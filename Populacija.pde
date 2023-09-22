class Populacija {
  Jedinka[] tacke;

  float sumafitnesa;
  int gen = 1;
  boolean pc= false;
  int najboljaJedinka = 0;//Indeks najbolje tacke u generaciji
  int najmanjeInstrukcija = 9999;

  Populacija(int size) {
    tacke = new Jedinka[size];
    for (int i = 0; i< size; i++) {
      tacke[i] = new Jedinka();
    }
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////Prikazuje jedinke/////////////////////////////////////////////////////////////////////
  void prikaz() {
    for (int i = 1; i< tacke.length; i++) {
      tacke[i].prikaz();
    }
    tacke[0].prikaz();
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////Azuriranje pozicije svih jedinki///////////////////////////////////////////////////////////
  void azuriranje() {
    for (int i = 0; i< tacke.length; i++) {
      if (tacke[i].kontroler.instrukcija > najmanjeInstrukcija) {//Ako je jedinka iskoristila vise instrukcija do cilja od najbolje jedinke postaje neaktivna
        tacke[i].neaktivna = true;
      } else {
        tacke[i].azuriranje();
      }
    }
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////Racuna fitnes jedinki///////////////////////////////////////////////////////////////
  void racunanjeFitnesa() {
    for (int i = 0; i< tacke.length; i++) {
      tacke[i].racunanjeFitnesa();
    }
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////Vraca da li su sve tacke dosle do cilja ili neaktivne///////////////////////////////////////////
  boolean SveJedinkeNeaktivne() {
    for (int i = 0; i< tacke.length; i++) {
      if (!tacke[i].neaktivna && !tacke[i].pogodjenaMeta) { 
        return false;
      }
    }
    return true;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////Pravi novu generaciju jedinki/////////////////////////////////////////////////////////////
  void prirodnaSelekcija() {
    Jedinka[] newJedinke = new Jedinka[tacke.length];//next gen
    setBestJedinka();
    racunanjeFitnesaSum();

    newJedinke[0] = tacke[najboljaJedinka].potomakNajboljeJedinke();
    newJedinke[0].najboljaJedinka = true;
    for (int i = 1; i< newJedinke.length; i++) {
      Jedinka roditeljA = selectRoditelj(); //Bira roditelja u zavisnosti od fitnesa
      Jedinka roditeljB = selectRoditelj();
      newJedinke[i] = roditeljA.crosover(roditeljB); //Pravi potomka od roditelja
    }
    tacke = newJedinke.clone();
    gen ++;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////Sumiranje fitnesa///////////////////////////////////////////////////////////////////////
  void racunanjeFitnesaSum() {
    sumafitnesa = 0;
    for (int i = 0; i< tacke.length; i++) {
      sumafitnesa += tacke[i].fitnes;
    }
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////Nasumicno bira roditelja u opsegu fitnesa/////////////////////////////////////////////////////////
  Jedinka selectRoditelj() {
    float rand = random(sumafitnesa);
    float runningSum = 0;
    for (int i = 0; i< tacke.length; i++) {
      runningSum+= tacke[i].fitnes;
      if (runningSum > rand) {
        return tacke[i];
      }
    }
    return null;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////Mutacija potomaka////////////////////////////////////////////////////////////////////////
  void mutacijaPotomaka() {
    for (int i = 1; i< tacke.length; i++) {
      tacke[i].kontroler.mutate();
    }
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////Nalazi najbolju jedinku u generacuiji////////////////////////////////////////////////////////
  void setBestJedinka() {
    float max = 0;
    int maxIndex = 0;
    for (int i = 0; i< tacke.length; i++) {
      if (tacke[i].fitnes > max) {
        max = tacke[i].fitnes;
        maxIndex = i;
      }
    }
    najboljaJedinka = maxIndex;
    if (tacke[najboljaJedinka].pogodjenaMeta) {
      najmanjeInstrukcija = tacke[najboljaJedinka].kontroler.instrukcija;
    }
    if (tacke[najboljaJedinka].pogodjenaMeta && !pc){
      pc=true;
    }
  }
}
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
