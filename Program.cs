using System.IO;
using Microsoft.Extensions.Configuration;

namespace testproject
{
    class Program
    {
        static void Main(string[] args)
        {
            var builder = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);

            IConfigurationRoot configuration = builder.Build();

            var registrationKey = configuration["pdfRegistration:registrationKey"];
            var registrationName = configuration["pdfRegistration:registrationName"];

            var ConvertPdftoCsv = new ConvertPdftoCsv(registrationKey, registrationName);
            ConvertPdftoCsv.OpenFiles();
            var readCsv = new ReadCsv();


            // String filename = (@"C:\Users\dabos\Downloads\Batch Reports\");
            // String filename2 = ("*.csv");
            // String fullfilename = filename + filename2;

            var filename = "20181204B0C_BatchSummary.csv";
            var table = readCsv.ReadCsvAndConvertToDataTable(filename);

            var excelService = new ExcelService();
            excelService.CreateAndSaveExcelFileFromDataTable(table, filename);
        }
    }
}