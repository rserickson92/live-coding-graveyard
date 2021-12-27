import java.util.*;

public class Spreadsheet {

  private final HashMap<String, String> cells;

  public Spreadsheet() {
    cells = new HashMap<>();
  }

  public void addValue(String cellName, String formula) {
    cells.put(cellName, formula);
  }

  public int getValue(String cellName) {
    String cellValue = cells.get(cellName);
    if ('=' == cellValue.charAt(0)) {
      int value = 0;
      // Only supported formula is addition for basic problem
      for (String token : cellValue.substring(1).split("\\+")) {
	value += getValue(token);
      }
      return value;
    } else {
      // Base case assumed to be parsable integer
      return Integer.parseInt(cells.get(cellName));
    }
  }

  private void checkValue(String cellName, int expectedValue) {
    System.out.println(String.format("%s = %d, should equal %d",
      cellName, getValue(cellName), expectedValue));
  }

  public static void main(String[] args) {
    Spreadsheet sheet = new Spreadsheet();
    sheet.addValue("A1", "3");
    sheet.addValue("A2", "4");
    sheet.addValue("A3", "5");
    sheet.addValue("B1", "=A1+A2");
    sheet.addValue("B2", "=A1+A2+A3");
    sheet.addValue("C1", "=B1");
    sheet.addValue("C2", "=B1+B2");
    sheet.addValue("C3", "=B1+A1");

    sheet.checkValue("A1", 3);
    sheet.checkValue("A2", 4);
    sheet.checkValue("A3", 5);
    sheet.checkValue("B1", 7);
    sheet.checkValue("B2", 12);
    sheet.checkValue("C1", 7);
    sheet.checkValue("C2", 19);
    sheet.checkValue("C3", 10);

    System.out.println("Modifying a cell:");
    sheet.addValue("A2", "-2");
    sheet.checkValue("A2", -2);
    sheet.checkValue("B1", 1);
    sheet.checkValue("B2", 6);
    sheet.checkValue("C1", 1);
    sheet.checkValue("C2", 7);
    sheet.checkValue("C3", 4);
  }
}

