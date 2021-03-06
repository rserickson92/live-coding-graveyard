import java.util.*;

public class MeetingAvailability {

  static int[][] MEETINGS = new int[][] {
    {1000, 1100},
    {1400, 1500},
    {1600, 1630}
  };

  static int[][] NO_MEETINGS = new int[0][0]; 

  static boolean isAvailable(int[][] meetings, int availableStart, int availableEnd) {
    for (int[] meeting : meetings) {
      int meetingStart = meeting[0];
      int meetingEnd = meeting[1];
      for (int minute = availableStart; minute < availableEnd; minute++) {
	if (minute >= meetingStart && minute < meetingEnd) {
	  return false;
	}
      }
    }

    return true;
  }

  static void runIsAvailable(int[][] meetings, int availableStart, int availableEnd, boolean expected) {
    System.out.println(String.format("Available from %d to %d? Expected=%s Actual=%s",
      availableStart, availableEnd, expected, isAvailable(meetings, availableStart, availableEnd)));
    System.out.println();
  }

  static void printMeetings(int[][] meetings) {
    for (int[] meeting : meetings) {
      System.out.print(String.format("[%d, %d] ", meeting[0], meeting[1]));
    }
    System.out.println();
  }

  public static void main(String[] args) {
    printMeetings(MEETINGS);
    runIsAvailable(MEETINGS, 900, 930, true);
    runIsAvailable(MEETINGS, 900, 1030, false);
    runIsAvailable(MEETINGS, 900, 1400, false);
    runIsAvailable(MEETINGS, 1500, 1600, true);
    runIsAvailable(MEETINGS, 1359, 1600, false);
    runIsAvailable(MEETINGS, 1400, 1430, false);
    runIsAvailable(MEETINGS, 1415, 1445, false);
    runIsAvailable(MEETINGS, 1500, 1630, false);
    runIsAvailable(MEETINGS, 1000, 1100, false);

    System.out.println("Empty schedule, all should be true:");
    runIsAvailable(NO_MEETINGS, 900, 500, true);
    runIsAvailable(NO_MEETINGS, 0, 2359, true);
  }
}

