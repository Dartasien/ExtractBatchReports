using System.IO;
using Bytescout.PDFExtractor;

public class ConvertPdftoCsv
{
    private string RegistrationKey { get; set; }
    private string RegistrationName { get; set; }

    public ConvertPdftoCsv(string registrationKey, string registrationName)
    {
        RegistrationKey = registrationKey;
        RegistrationName = registrationName;
    }
    public void OpenFiles()
    {
         string[] files = Directory.GetFiles(@"C:\Users\dabos\Downloads\Batch Reports", "*.pdf");
         // Array of events to wait


         for (int i = 0; i < files.Length; i++)
         {
             Convert(files[i]);
         }
        //Convert("20181204B0C_BatchSummary.pdf");
    }

    private void Convert(string filename)
    {
        // Create Bytescout.PDFExtractor.CSVExtractor instance

        CSVExtractor extractor = new CSVExtractor();
        extractor.RegistrationName = RegistrationName;
        extractor.RegistrationKey = RegistrationKey;


        // Load sample PDF document
        extractor.LoadDocumentFromFile(filename);
        //extractor.CSVSeparatorSymbol = ","; // you can change CSV separator symbol (if needed) from "," symbol to another if needed for non-US locales

        extractor.SaveCSVToFile(filename.Replace(".pdf", ".csv"));
        
    }
}