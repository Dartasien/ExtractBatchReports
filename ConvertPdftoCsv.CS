
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Threading;
using Bytescout.PDFExtractor;

public class ConvertPdftoCsv{
    public void openFiles(){
        string[] files = Directory.GetFiles(@"C:\Users\dabos\Downloads\Batch Reports", "*.pdf");
            // Array of events to wait
            

            for (int i = 0; i < files.Length; i++)
            {
                convert(files[i]);
            }

         
    }
    public void convert(string filename){
    // Create Bytescout.PDFExtractor.CSVExtractor instance
           CSVExtractor extractor = new CSVExtractor();
           extractor.RegistrationName = "demo";
           extractor.RegistrationKey = "demo";
           
 
           // Load sample PDF document
           extractor.LoadDocumentFromFile(filename);
 
           //extractor.CSVSeparatorSymbol = ","; // you can change CSV separator symbol (if needed) from "," symbol to another if needed for non-US locales
 
           extractor.SaveCSVToFile(filename.Replace(".pdf",".csv"));
    }

}
