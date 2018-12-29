using System.Data;
using ClosedXML.Excel;

public class ExcelService
{
    public void CreateAndSaveExcelFileFromDataTable(DataTable table, string filename)
    {
        var workbook = new XLWorkbook();
        workbook.Worksheets.Add(table, filename.Substring(0, filename.Length -4));
        workbook.SaveAs(filename.Substring(0, filename.Length -3) + "xlsx");
    }
}