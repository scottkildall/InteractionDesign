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
 
  //-------- PRIVATE VARIABLES --------/
  private long duration;
  protected long startTime = 0;	 	
}
