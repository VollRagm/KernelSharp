using System.Runtime;
using static KernelSharp.WDK; // equivalent to #include <wdk.h> :^)

public unsafe class Program
{
    //Dummy main method to satisfy the compiler
    static void Main() {}

    [RuntimeExport("DriverEntry")]
    static NTSTATUS DriverEntry()
    {
        var pool = ExAllocatePool(PoolType.NonPagedPool, 0x1000);

        //.NET strings are wide strings, DbgPrintEx wants a Multibyte char
        DbgPrintEx(0, 0, "Allocated Pool: %p | cr3: %p".c_str(), pool, __readcr3());

        ExFreePool(pool);

        return NTSTATUS.Success;
    }
}
