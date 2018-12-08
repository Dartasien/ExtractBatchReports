using System;
using System.Data;
using System.IO;
using System.Threading.Tasks;
using GenericParsing;
using ClosedXML.Excel;

public class ReadCsv
{
    public DataTable ReadCsvAndConvertToDataTable(string filename)
    {
        var adapter = new GenericParsing.GenericParserAdapter(filename);
        var batchSummaryConverter = new BatchSummaryConverter();

        DataTable originalDataTable = adapter.GetDataTable();

        var newDataTable = batchSummaryConverter.Convert(originalDataTable);        

        return newDataTable;
    }
}
