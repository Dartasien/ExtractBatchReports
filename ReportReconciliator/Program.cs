using ConsoleApplication;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReportReconciliator
{
    class Program
    {
        static void Main(string[] args)
        {
            var extractZips = new ExtractZip();
            extractZips.OpenZip();
            var ConvertPdftoCsv = new ConvertPdftoCsv();
            ConvertPdftoCsv.OpenFiles();
            var readCsv = new ReadCsv();
           
            var filename = (@"C:\Users\dabos\Downloads\Batch Reports\NewFolder\");
            var fname2 = ("*.csv");
            var fullfname = filename + fname2;
            var table = readCsv.ReadCsvAndConvertToDataTable(filename);

            var excelService = new ExcelService();
            excelService.CreateAndSaveExcelFileFromDataTable(table, filename);
        }
    }
}
