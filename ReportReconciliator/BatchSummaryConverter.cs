using System;
using System.Data;

public class BatchSummaryConverter
{
    public DataTable Convert(DataTable originalDataTable)
    {
        DataTable newDataTable = new DataTable();

        newDataTable.Columns.Add(new DataColumn("Job"));
        newDataTable.Columns.Add(new DataColumn("Delivery Type"));
        newDataTable.Columns.Add(new DataColumn("TNT"));
        newDataTable.Columns.Add(new DataColumn("Comingle Info"));
        newDataTable.Columns.Add(new DataColumn("Paper"));
        newDataTable.Columns.Add(new DataColumn("Intended Ship Date"));
        newDataTable.Columns.Add(new DataColumn("Total Pages"));
        newDataTable.Columns.Add(new DataColumn("Total Envelopes"));
        newDataTable.Columns.Add(new DataColumn("5 Digit"));


        for (var rowIndex = 5; rowIndex < originalDataTable.Rows.Count - 3; rowIndex++)
        {
            if (rowIndex % 2 != 0)
            {
                var newRow = newDataTable.NewRow();
                for (var columnIndex = 0; columnIndex < newDataTable.Columns.Count; columnIndex++)
                {
                    newRow[columnIndex] = originalDataTable.Rows[rowIndex][columnIndex];
                    if (originalDataTable.Rows[rowIndex + 1] != null && originalDataTable.Rows[rowIndex + 1][columnIndex] != null)
                    {
                        AddMissingInformationFromNextRow(originalDataTable, newRow, rowIndex, columnIndex);
                    }
                }

                newRow = OnlyUseTheLastWordInTheDeliveryTypeColumn(newRow);
                newRow = RenameRowItemToCheckOrLetter(newRow);

                newDataTable.Rows.Add(newRow);
            }
        }

        //This is for comparing, don't use all the time!
        WriteDataRowsToConsole(originalDataTable, newDataTable);

        return newDataTable;
    }

    private void WriteDataRowsToConsole(DataTable originalDataTable, DataTable newDataTable)
    {
        foreach (var item in originalDataTable.Rows[13].ItemArray)
        {
            Console.Write(item + ", ");
        }
        Console.WriteLine();
        foreach (var item in newDataTable.Rows[4].ItemArray)
        {
            Console.Write(item + ", ");
        }   
    }

    private DataRow RenameRowItemToCheckOrLetter(DataRow row)
    {
        if (row.ItemArray[4].ToString().ToLowerInvariant().Contains("check"))
        {
            row[4] = "Check";
        }
        else if (row.ItemArray[4].ToString().ToLowerInvariant().Contains("letter"))
        {
            row[4] = "Letter";
        }

        return row;
    }

    private DataRow OnlyUseTheLastWordInTheDeliveryTypeColumn(DataRow row)
    {
        var columnSplitBySpaces = row.ItemArray[1].ToString().Split(' ');
        row[1] = columnSplitBySpaces[columnSplitBySpaces.Length - 1];

        return row;
    }

    private DataRow AddMissingInformationFromNextRow(DataTable table, DataRow row, int rowIndex, int columnIndex)
    {
        if (!string.IsNullOrEmpty(table.Rows[rowIndex + 1].ItemArray.GetValue(columnIndex).ToString()))
        {
            row[columnIndex] += " " + table.Rows[rowIndex + 1].ItemArray.GetValue(columnIndex);
        }
        return row;
    }
}