ArrayList<Car> pop;
GenAlg ga;
int genCounter;

ArrayList<PVector> lines;
PVector lastClick;
boolean started;

boolean isOver;
void setup(){
    size(400, 400);
    
    pop  = new ArrayList();
    
    ga = new GenAlg();
    pop = ga.genPop(pop);
    
    started = false;
    getLines();
}
void draw(){
    background(255);
    
    show();
    if(isOver){
        pop = ga.genPop(pop);
        genCounter++;
        //for(Car c: pop){
        //    c.index = 0;
        //    c.setIsDone(false);
        //}
        isOver = false;
    }
}

void show(){
    //println("show()");
    if(started){
        if(isOver){
            return;
        }
        //println("Playing");
        isOver = true;
        for(Car c: pop){
            c.move();
            if(!c.getIsDone()){
                isOver = false;
            }
        }
    }
    drawMapObjects();
}

void getLines(){
  println("Getlines()");
  
  lines = new ArrayList();
  lastClick = null;
}

void drawMapObjects(){
    
    if(lastClick != null && !started){
        line(lastClick.x, lastClick.y, mouseX, mouseY);
    }
  
  
    //Obstacles
    for(int i = 0; i< lines.size(); i = i+2){
        line(lines.get(i).x, lines.get(i).y, lines.get(i+1).x, lines.get(i+1).y);
    }
    
    //Target
    ellipse(Constants.target.x, Constants.target.y, 12, 12);
    
    //Start point
    ellipse(Constants.start.x, Constants.start.y, 10, 10);
}

void mousePressed(){
    println("mousePressed()");
    if(lastClick != null){
        lines.add(lastClick);
        lines.add(new PVector(mouseX, mouseY));
        lastClick = null;
    }
    else{
        lastClick = new PVector(mouseX, mouseY);
    }
}

void keyPressed(){
    println("keyPressed()");
    if(keyCode == ENTER){
        started = true;
    }
}