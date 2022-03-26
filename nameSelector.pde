import java.util.Map;


class letterVector { 
  
  float xpos, ypos, xspeed, yspeed; 
  Character letter;
  
  letterVector (Character l, float x, float y,float xs,float ys) {  
    xpos = x;
    ypos = y; 
    xspeed = xs;
    yspeed = ys;
    letter = l;
    
  } 
  
  Character getLetter(){
  return letter;
  }
  
  void move(){
  xpos = xpos + xspeed;
  ypos = ypos + yspeed;
  
  text(letter, xpos, ypos);
  
  }
  
  void detectEdge(){
    
  if(xpos> width || xpos < 0){
    xspeed = xspeed * -1;
  }
  
    if(ypos> width || ypos < 0){
    yspeed = yspeed * -1;
  }
  }
  
  float dist(float x,float y){
    float dist = abs(xpos-x)+abs(ypos-y);
    return dist;
  }
  
  
  
}

int dataSetSize;
JSONObject cand1;
String[] names;
PVector[] letterPos;
float[] distLetters;
letterVector[] letterVArray;
PFont f;
float record;
 float biggestScore;
 

HashMap<Character,PVector> vectors = new HashMap<Character,PVector>();

HashMap<Character,Float> scores = new HashMap<Character,Float>();

HashMap<String,Float> nameScores = new HashMap<String,Float>();



void setup(){
  
  
  size(700,600);

 dataSetSize = 200;
 letterVArray = new letterVector[26];
 names = new String[dataSetSize];
 letterPos = new PVector[26];
 distLetters = new float[26];
 record = 0;
 float biggestScore = 0; 
  
  //JSONObject cand1 = loadJSONObject("https://randomuser.me/api/");
  
  f = createFont("ZCOOLKuaiLe-Regular.ttf", 60);
  textFont(f);
  textAlign(CENTER, CENTER);
  
  for(int i=0; i<dataSetSize; i++){
  
   cand1 = loadJSONObject("https://randomuser.me/api/");
  JSONArray cand = cand1.getJSONArray("results");
  
  JSONObject name = cand.getJSONObject(0);
  
  JSONObject first  = name.getJSONObject("name");
  
  String fn  = first.getString("first");
  
  names[i] = fn;
 // println(fn);
  
  //if fn.is
  }
  
  
  background(0);

  // Set the left and top margin
  int margin = 100;
  translate(margin*4, margin*4);

  int gap = 100;
  int counter = 65;
  
  for (int y = 0; y < height-gap; y += gap) {
    for (int x = 0; x < width-gap; x += gap) {

      if(counter <91){
      Character letter = char(counter);
      
      if (letter == 'A' || letter == 'E' || letter == 'I' || letter == 'O' || letter == 'U') {
        fill(255, 204, 0);
      } 
      else {
        fill(255);
      }

      // Draw the letter to the screen
      text(letter, x, y);
      //IF FONT IS CHANGED 65 WILL NEED TO CHANGE 2
      PVector curLetter = new PVector(x+(gap/2),y+(gap/2));
      
      letterVector lv = new letterVector(letter,x,y,random(1),random(1));
      letterVArray[counter-65] = lv;
      
      letterPos[counter-65] = curLetter;
      vectors.put(letter,curLetter);
     
      

      // Increment the counter
      counter++;
    }
  }
  }
  
  
}

void draw(){
  
    background(0);
  for (letterVector lv : letterVArray){
    
    lv.detectEdge();
    lv.move();
    
    
    Character c = (Character) lv.getLetter();
    
    float dist = lv.dist(mouseX,mouseY);
    float score = 1/dist;
    
    scores.put(c,score);
    
  }
  
  
  
  
  //PVector mouse = new PVector(mouseX,mouseY);
  
//for (Map.Entry letter : vectors.entrySet()){
  
//  Character c = (Character) letter.getKey();
//  PVector LVector = (PVector) letter.getValue();
  
//    float dist = LVector.dist(mouse);
//    float score = 1/dist;
    
//    scores.put(c,score);
//}




for (String name : names){
  float scoreTotal = 0;
float letterScore = 0;

  
for(int i = 0 ; i < name.length()-1; i++){
  Character lettersInNames = Character.toUpperCase(name.charAt(i));
  
  //for (Map.Entry score : scores.entrySet()){
   // print(lettersInNames);
    
   if(lettersInNames == 'A'||lettersInNames == 'B'||lettersInNames == 'C'||lettersInNames == 'D'||lettersInNames == 'E'||lettersInNames == 'F'||lettersInNames == 'G'||lettersInNames == 'H'||lettersInNames == 'I'||lettersInNames == 'J'||lettersInNames == 'K'||lettersInNames == 'L'||lettersInNames == 'M'||lettersInNames == 'N'||lettersInNames == 'O'||lettersInNames == 'P'||lettersInNames == 'Q'||lettersInNames == 'R'||lettersInNames == 'S'||lettersInNames == 'T'||lettersInNames == 'U'||lettersInNames == 'V'||lettersInNames == 'W'||lettersInNames == 'X'||lettersInNames == 'Y'||lettersInNames == 'Z'){
  
     if (i == 0){
      letterScore = scores.get(lettersInNames)*2;
     }else if(i>4){
       letterScore = scores.get(lettersInNames)/(i-3);
     }else{
        letterScore = scores.get(lettersInNames);
     }
     scoreTotal = scoreTotal + letterScore;
   //print(letterScore);
 } 
}

nameScores.put(name, scoreTotal);



float record = 0;

if (scoreTotal>record){
record = scoreTotal;
//println(name + " is : " + scoreTotal + "Recorde was: "+ record);


}

}

float fstScore = nameScores.get(names[0]);
String fstName = names[0];

for (Map.Entry nameScore: nameScores.entrySet()){
  if((float)nameScore.getValue() > fstScore){
    fstScore = (float)nameScore.getValue();
    fstName = (String)nameScore.getKey();
  }
  
}
text(fstName,width/2, 20);




// float biggestScore = 0;
//for (Map.Entry scores : scores.entrySet()){
  
//  if(biggestScore < (float) scores.getValue()){
    
//    biggestScore = (float) scores.getValue();
    
//    println((Character) scores.getKey() + " has biggest Score of:" + (float) scores.getValue());
//  }
//}




 // theres an ARRAY of floats that hold score calculated by how close a letter is to the mouse with euc distance MAX 1.0
 
 //goes through name array and multiplies by the factors to  give a current score for each name.
 //displays name
 
 
}
