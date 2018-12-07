using System;
using iTextSharp.text.pdf;
using System.IO;
using System.Text;

namespace testproject
{
    class Program
    {
        static void Main(string[] args)
        {
            var ConvertPdftoCsv = new ConvertPdftoCsv();
            ConvertPdftoCsv.openFiles();
            var readPdf = new ReadPdf();
            readPdf.ReadPdfFile("20181204B0C_BatchSummary.pdf"); 
        }
        
    }
}

