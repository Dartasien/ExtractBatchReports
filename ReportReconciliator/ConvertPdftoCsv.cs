using System.Configuration;
using System.IO;
using Bytescout.PDFExtractor;

public class ConvertPdftoCsv
{
    private string RegistrationKey { get; set; }
    private string RegistrationName { get; set; }
    private CSVExtractor CsvExtractor;


    public ConvertPdftoCsv()
    {
        RegistrationKey = ConfigurationManager.AppSettings["registrationKey"];
        RegistrationName = ConfigurationManager.AppSettings["registrationName"];
        CsvExtractor = new CSVExtractor();
        CsvExtractor.RegistrationName = RegistrationName;
        CsvExtractor.RegistrationKey = RegistrationKey;
    }
    public void OpenFiles()
    {
         string[] files = Directory.GetFiles(@"C:\Users\dabos\Downloads\Batch Reports\NewFolder", "*.pdf");
         // Array of events to wait


         for (int i = 0; i < files.Length; i++)
         {
            if (files[i].ToLowerInvariant().Contains("presort_combined") || files[i].ToLowerInvariant().Contains("batchsummary"))
            {
                Convert(files[i]);
            }
         }
        //Convert("20181204B0C_BatchSummary.pdf");
    }

    public void Convert(string filename)
    {
        // Create Bytescout.PDFExtractor.CSVExtractor instance
        // Load sample PDF document
        CsvExtractor.LoadDocumentFromFile(filename);
        //extractor.CSVSeparatorSymbol = ","; // you can change CSV separator symbol (if needed) from "," symbol to another if needed for non-US locales

        CsvExtractor.SaveCSVToFile(filename.Replace(".pdf", ".csv"));
        
    }
}