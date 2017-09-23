static class Constants{
    static final int width = 400;
    static final int height = 400;
    
    static final int popSize = 75;
    static final int pathSize = 10;
    static final int pathRange = 50; //Distance range from previous point for random calculation.
    static final float mutationRate = 0.05; //For each gene
    static final int exponential = 4; //For calculating fitness
    
    static final PVector target = new PVector(Constants.width - 50, Constants.height -50);
    static final PVector start = new PVector(50, 50);
}