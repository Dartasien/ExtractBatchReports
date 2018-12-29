using System.IO;
using System.IO.Compression;

namespace ConsoleApplication
{
    public class ExtractZip
    {
        public void ExtractZips(string filenameWwithPath)
        {
            string extractPath = @"c:\users\dabos\downloads\Batch Reports\NewFolder\";
            ZipFile.ExtractToDirectory(filenameWwithPath, extractPath);
        }        

        public void OpenZip()
        {
            string[] files = Directory.GetFiles(@"C:\Users\dabos\Downloads\Batch Reports", "*.zip");
            // Array of events to wait
            
            for (int i = 0; i < 2; i++)
            {
                ExtractZips(files[i]);
            }
        }
    }
}