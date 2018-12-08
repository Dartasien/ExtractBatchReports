using System;
using System.IO;
using System.Threading.Tasks;

class ReadCsv
{
    static async Task Main()
    {
        await ReadAndDisplayFilesAsync();
    }

    static async Task ReadAndDisplayFilesAsync()
    {
        String filename = (@"C:\Users\dabos\Downloads\Batch Reports\");
        String filename2 = ("*.csv");
        String fullfilename = filename + filename2;
        Char[] buffer;
        
        using (var sr = new StreamReader(fullfilename)) {
            buffer = new Char[(int)sr.BaseStream.Length];
            await sr.ReadAsync(buffer, 0, (int)sr.BaseStream.Length);
        }

        Console.WriteLine(new String(buffer));
    }
}