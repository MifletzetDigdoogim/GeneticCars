class GenAlg{
  
        ArrayList<Car> prev;
        ArrayList<Car> newPop;
        
        ArrayList<Car> genPop(ArrayList<Car> prev){
           //println("Creating new Generation");
           
           this.prev = prev;
           this.newPop = new ArrayList();
           
           
           if(prev.isEmpty()){
              // generate random population
              for(int i = 0; i< Constants.popSize; i++){
                
                  //Create Location
                  PVector sLoc = Constants.start.copy();
                  
                  //Create random Path
                  ArrayList<PVector> rPath = new ArrayList();
                  PVector pr = sLoc;
                  for(int k=0; k<Constants.pathSize; k++){
                      pr = new PVector(random(-Constants.pathRange, Constants.pathRange), random(-Constants.pathRange, Constants.pathRange));
                      rPath.add(pr);
                  }
                  
                  //Create random car
                  //println("New car");
                  Car r = new Car(sLoc, rPath);
                  newPop.add(r);
              }
          }
          else{
              calcFitness();
              //println("FITNESS: \n");
              for(int i=0; i<prev.size(); i++){
                //println(i+" : "+prev.get(i).getFitness());
              }
              mate();
          }
          return newPop;
      }
      
      void calcFitness(){
          //println("Calculating fitness");
          float sum = 0F;
          float sumDist = 0F;
          for(Car c: this.prev){
              c.setFitness(1/ (pow(c.loc.dist(Constants.target), Constants.exponential)));
              sum += c.getFitness();
              
              sumDist += c.loc.dist(Constants.target);
          }
          
          println("Average Distance from Target : "+sumDist / Constants.popSize);
          
          for(Car c: this.prev){
              c.setFitness(map(c.getFitness(), 0, sum, 0, 1));
          }
      }
      
      void mate(){
          //println("mate()");
          while(this.newPop.size() < Constants.popSize){
              //println("Adding car");
              Car p1 = getFitParent();
              //print(" <3 ");
              Car p2 = getFitParent();
              //println();
              if(p1.equals(p2)){
                  continue;
              }
              
              Car child = crossOver(p1, p2);
              
              if(/*random(1) < Constants.mutationRate*/ true){
                  
                  mutate(child);
              }
              
              this.newPop.add(child);
          }
      }
      
      Car getFitParent(){
          while(true){
              int index = int(random(this.prev.size()));
              float num = random(0, 1);
              if(this.prev.get(index).getFitness() > num){
                  //print(index);
                  return this.prev.get(index);
              }
          }
      }
      
      Car crossOver(Car p1, Car p2){
          ArrayList<PVector> path = new ArrayList();
          //int midPoint = int(random(Constants.pathSize)); //Not really the middle - just the place in which the genes are split.
          int midPoint = round(Constants.pathSize / 2);
          for(int i=0; i<midPoint; i++){
              path.add(p1.getPath().get(i).copy());
          }
          for(int k=midPoint; k<Constants.pathSize; k++){
              path.add(p2.getPath().get(k).copy());
          }
          
          //println("parent1: "+p1.targets);
          //println("parent2: "+p2.targets);
          //println("child: "+new Car(Constants.start.copy(), path).targets);
          return new Car(Constants.start.copy(), path);
      }
      
      void mutate(Car car){
          
          for(int j=0; j<car.getPath().size(); j++){
              if(random(1) < 0.1){
                  //println("Mutating child");
                  car.getPath().set(j, new PVector((int)random(-Constants.pathRange, Constants.pathRange), (int)random(-Constants.pathRange, Constants.pathRange)));
              }
          }
          car.targets = car.getTargets(Constants.start.copy());
          //println("After mutation: "+ car.targets);
      }
}