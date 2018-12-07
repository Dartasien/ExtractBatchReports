using System.IO;
using System.Text;
using iTextSharp.text.pdf;

public class ReadPdf
{
    public void ReadPdfFile(string fileName)
    {
        StringBuilder text = new StringBuilder();

        if (File.Exists(fileName))
        {
            PdfReader reader = new PdfReader(fileName);



            reader.SelectPages("1-2"); //Work with only page# 1 & 2

            AcroFields form = reader.AcroFields;
            var fieldKeys = form.Fields.Keys;
            foreach (string fieldKey in fieldKeys)
            {
                //Replace Address Form field with my custom data
                if (fieldKey.Contains("Address"))
                {
                    form.SetField(fieldKey, "MyCustomAddress");
                }
            }

            reader.Close();

        }
    }

}