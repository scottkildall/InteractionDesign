/*******************************************************************************************************************
//
//  Class: Timer
//
//  Written by Scott Kildall
//
//------------------------------------------------------------------------------------------------------------------
// - Very simple but incredibly useful timer class
// - Call start() whenever it expires to reset the time
// - Call expired() to check to see if timer is still active
//
*********************************************************************************************************************/

public class Timer {
  //-------- PUBLIC VARIABLES --------/
  public Timer( long _duration ) {
      setTimer(_duration);
  }
  
  public void start() { 
    startTime = millis();
  }
  
  public void setTimer(long _duration) {
    duration = _duration;
  }
  
  public Boolean expired() {
    return ((startTime + duration) < millis());
  }
 
  public long getRemainingTime() {
    if( expired() )
      return 0;
      
    return  (startTime + duration) - millis();
  }
  
  public float getPercentageRemaining() {
    if( expired() )
     return 1.0;
      
    return (float)getRemainingTime()/(float)duration;
  }
  
   public float getPercentageElapsed() {
    if( expired() )
     return 0.0;
      
    return 1 - ((float)getRemainingTime()/(float)duration);
  }
  
  //-------- PRIVATE VARIABLES --------/
  private long duration;
  private long startTime = 0;	 	
}
