using System;
using iTextSharp.text.pdf;
using System.IO;
using System.Text;
using Microsoft.Extensions.Configuration;

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
            var readCsv = new ReadCsv();
            readCsv.Main();

        }

    }
}

