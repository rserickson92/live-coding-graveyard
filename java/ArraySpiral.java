import java.util.*;

public class ArraySpiral {

  private static enum Direction {
    UP,
    DOWN,
    LEFT,
    RIGHT;
  }

  public static List<List<Integer>> generateSpiralLists(int rowCount, int colCount) {
    // Initialize grid
    List<List<Integer>> grid = new ArrayList<>(rowCount);
    for (int i = 0; i < rowCount; i++) {
      List<Integer> row = new ArrayList<>(colCount);
      for (int j = 0; j < colCount; j++) {
	row.add(0);
      }
      grid.add(row);
    }

    int x = 0;
    int y = 0;
    int xUpBound = colCount - 1;
    int yUpBound = rowCount - 1;
    int xLowBound = 0;
    int yLowBound = 0;
    int currentNumber = 1;
    Direction direction = Direction.RIGHT;
    while (currentNumber <= rowCount * colCount) {
      grid.get(y).set(x, currentNumber);

      if (direction == Direction.RIGHT && x == xUpBound) {
	direction = Direction.DOWN;
	yLowBound++;
      } else if (direction == Direction.DOWN && y == yUpBound) {
	direction = Direction.LEFT;
	xUpBound--;
      } else if (direction == Direction.LEFT && x == xLowBound) {
	direction = Direction.UP;
	yUpBound--;
      } else if (direction == Direction.UP && y == yLowBound) {
	direction = Direction.RIGHT;
	xLowBound++;
      }
     
      switch (direction) {
	case RIGHT:
	  x++;
	  break;
	case DOWN:
	  y++;
	  break;
	case LEFT:
	  x--;
	  break;
	case UP:
	  y--;
	  break;
      }
      currentNumber++;
    }

    return grid;
  }

  public static void printListGrid(List<List<Integer>> grid) {
    System.out.println("- - - - - - - - - -");
    for (List<Integer> row : grid) {
      for (Integer value : row) {
	System.out.print(value + "  ");
      }
      System.out.println();
    }
    System.out.println("- - - - - - - - - -");
  }

  public static void main(String[] args) {
    printListGrid(generateSpiralLists(1, 1));
    printListGrid(generateSpiralLists(2, 2));
    printListGrid(generateSpiralLists(3, 3));
    printListGrid(generateSpiralLists(4, 4));
    printListGrid(generateSpiralLists(5, 5));
    printListGrid(generateSpiralLists(3, 4));
    printListGrid(generateSpiralLists(4, 3));
    printListGrid(generateSpiralLists(1, 2));
    printListGrid(generateSpiralLists(2, 1));
    printListGrid(generateSpiralLists(10, 5));
    printListGrid(generateSpiralLists(5, 10));
    printListGrid(generateSpiralLists(10, 4));
    printListGrid(generateSpiralLists(100, 11));
  }
}

