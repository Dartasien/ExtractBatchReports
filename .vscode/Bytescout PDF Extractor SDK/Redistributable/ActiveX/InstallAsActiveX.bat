@echo off

REM --------------------------------------------------------------------------------------
REM - This batch registers assemblies as ActiveX object using .NET 4.0 or 2.0            -
REM - for x86, x64 and x86 emulation modes.                                              -
REM - On Windows Vista and later this batch should be ran in "As Administrator" mode.    -
REM --------------------------------------------------------------------------------------

REM ! If you are getting error "System.IO.FileLoadException: Could not load file or 
REM ! assembly ‘file:///<filename>’ or one of its dependencies. Operation is not supported. 
REM ! (Exception from HRESULT: 0x80131515)." when executing this file, you have doubtless 
REM ! used Windows Explorer to extract files from the zip package and all files have been 
REM ! marked as blocked by security reason.
REM ! Solution:
REM ! - Use other application to unzip the package.
REM ! or
REM ! - Open properties of each extracted file, click `Unblock` and "Apply".


REM change current directory (required for Vista and higher)
@setlocal enableextensions
@cd /d "%~dp0"

SET DLLFILE=Bytescout.PDFExtractor.dll 
SET DLLFILE2=Bytescout.PDFExtractor.OCRExtension.dll 
SET TLBFILE=Bytescout.PDFExtractor.tlb

SET ERROR=0

echo ------------ x86 Windows installation ------------------------

IF NOT EXIST "%systemroot%\SYSWOW64\" (

    REM pure x86 mode 
    
    ECHO.
    ECHO Check if .NET 4.0 is available
    ECHO.

    IF EXIST "%windir%\Microsoft.NET\Framework\v4.0.30319\regasm.exe" (

        ECHO.
        ECHO Copying .NET 4.0 DLL and TLB files to 'System32'
        ECHO.

        copy "..\net4.00\%DLLFILE%" "%windir%\System32\%DLLFILE%"
        copy "..\net4.00\%DLLFILE2%" "%windir%\System32\%DLLFILE2%"
        copy "..\net4.00\%TLBFILE%" "%windir%\System32\%TLBFILE%"

        ECHO.
        ECHO Registering .NET 4.0 assembly as ActiveX
        ECHO.
        "%windir%\Microsoft.NET\Framework\v4.0.30319\regasm.exe" "%windir%\System32\%DLLFILE%" /tlb:"%windir%\System32\%TLBFILE%" /codebase

    REM Else try installing with .NET 2.0
    ) ELSE (

        ECHO.
        ECHO Check if .NET 2.0 is available 
        ECHO.

        IF EXIST "%windir%\Microsoft.NET\Framework\v2.0.50727\regasm.exe" (

            ECHO.
            ECHO Copying DLL and TLB files to 'System32'
            ECHO.

            copy "..\net2.00\%DLLFILE%" "%windir%\System32\%DLLFILE%"
            copy "..\net2.00\%DLLFILE2%" "%windir%\System32\%DLLFILE2%"
            copy "..\net2.00\%TLBFILE%" "%windir%\System32\%TLBFILE%"

            ECHO.
            ECHO Register .NET 2.0 assembly as ActiveX 
            ECHO.
            "%windir%\Microsoft.NET\Framework\v2.0.50727\regasm.exe" "%windir%\System32\%DLLFILE%" /tlb:"%windir%\System32\%TLBFILE%" /codebase

        REM Display error message
        ) ELSE (

            ECHO.
            ECHO ERROR: Could not find .NET 2.0 or .NET 4.0 framework installed.
            ECHO.
            
            ERROR = -1
            GOTO :SHOWERROR
        )

    )

)


echo ------------ x64 Windows installation ------------------------

REM Check if we are on Windows x64 
IF EXIST "%systemroot%\SYSWOW64\" (

    ECHO.
    ECHO x64 native mode and x86 emulation modes installations
    ECHO.

    REM --- x86 on x64
    ECHO.
    ECHO 1. x86 emulation mode on x64
    ECHO.

    ECHO.
    ECHO Check if .NET 4.0 for x86 is installed
    ECHO.

    IF EXIST "%windir%\Microsoft.NET\Framework\v4.0.30319\regasm.exe" (

        ECHO.
        ECHO Copying .NET 4.0 DLL and TLB files to /System32/
        ECHO.

        copy "..\net4.00\%DLLFILE%" "%systemroot%\SYSWOW64\%DLLFILE%"
        copy "..\net4.00\%DLLFILE2%" "%systemroot%\SYSWOW64\%DLLFILE2%"
        copy "..\net4.00\%TLBFILE%" "%systemroot%\SYSWOW64\%TLBFILE%"

        ECHO.
        ECHO Registering .NET 4.0 assembly as ActiveX in .NET x86 on x64
        ECHO.
        "%windir%\Microsoft.NET\Framework\v4.0.30319\regasm.exe" "%systemroot%\SYSWOW64\%DLLFILE%" /tlb:"%systemroot%\SYSWOW64\%TLBFILE%" /codebase

    ) ELSE (

        ECHO.
        ECHO Check if .NET 2.0 for x86 is installed
        ECHO.

        IF EXIST "%windir%\Microsoft.NET\Framework\v2.0.50727\regasm.exe" (

            ECHO.
            ECHO Copying .NET 2.0 DLL and TLB files to /System32/
            ECHO.

            copy "..\net2.00\%DLLFILE%" "%systemroot%\SYSWOW64\%DLLFILE%"
            copy "..\net2.00\%DLLFILE2%" "%systemroot%\SYSWOW64\%DLLFILE2%"
            copy "..\net2.00\%TLBFILE%" "%systemroot%\SYSWOW64\%TLBFILE%"

            ECHO.
            ECHO Registering .NET 2.0 assembly as ActiveX in .NET x86 on x64
            ECHO.
            "%windir%\Microsoft.NET\Framework\v2.0.50727\regasm.exe" "%systemroot%\SYSWOW64\%DLLFILE%" /tlb:"%systemroot%\SYSWOW64\%TLBFILE%" /codebase
        
        REM Display error message
        ) ELSE  (

            ECHO.
            ECHO ERROR: Could not find .NET 2.0 or .NET 4.0 framework installed.
            ECHO.
            
            ERROR = -2
            GOTO :SHOWERROR

        )
    )


    REM --- x64 mode

    ECHO.
    ECHO 2. x64 native mode on x64
    ECHO.

    IF EXIST "%windir%\Microsoft.NET\Framework64\v4.0.30319\regasm.exe" (

        ECHO.
        ECHO Copying .NET 4.0 DLL and TLB files to 'System32'
        ECHO.

        IF EXIST "%systemroot%\sysnative\cmd.exe" (

            REM We call cmd.exe and regsvr32.exe from "sysnative" folder (special "alias" available when running x86 batch on x64).
            REM Although we call from "sysnative" folder, we should pass "system32" in command line parameters.

            ECHO Copying sysnative\%DLLFILE%"
            "%systemroot%\sysnative\cmd.exe" /c copy "..\net4.00\%DLLFILE%" "%systemroot%\system32\%DLLFILE%"
            ECHO copying sysnative\%DLLFILE2%"
            "%systemroot%\sysnative\cmd.exe" /c copy "..\net4.00\%DLLFILE2%" "%systemroot%\system32\%DLLFILE2%"
            ECHO Copying sysnative\%TLBFILE%"
            "%systemroot%\sysnative\cmd.exe" /c copy "..\net4.00\%TLBFILE%" "%systemroot%\system32\%TLBFILE%"

            ECHO.
            ECHO Registering .NET 4.0 assembly as ActiveX in .NET x64
            ECHO.
            "%windir%\Microsoft.NET\Framework64\v4.0.30319\regasm.exe" "%windir%\System32\%DLLFILE%" /tlb:"%windir%\System32\%TLBFILE%" /codebase

        ) ELSE (
            
            ECHO Copying system32\%DLLFILE%"
            copy "..\net4.00\%DLLFILE%" "%windir%\System32\%DLLFILE%"
            ECHO copying system32\%DLLFILE2%"
            copy "..\net4.00\%DLLFILE2%" "%windir%\System32\%DLLFILE2%"
            ECHO Copying system32\%TLBFILE%"
            copy "..\net4.00\%TLBFILE%" "%windir%\System32\%TLBFILE%"

            ECHO.
            ECHO Registering .NET 4.0 assembly as ActiveX in .NET x64
            ECHO.
            "%windir%\Microsoft.NET\Framework64\v4.0.30319\regasm.exe" "%windir%\System32\%DLLFILE%" /tlb:"%windir%\System32\%TLBFILE%" /codebase

        )

    ) ELSE (

        IF EXIST "%windir%\Microsoft.NET\Framework64\v2.0.50727\regasm.exe" (

            IF EXIST "%systemroot%\sysnative\cmd.exe" (

                REM We call cmd.exe and regsvr32.exe from "sysnative" folder (special "alias" available when running x86 batch on x64).
                REM Although we call from "sysnative" folder, we should pass "system32" in command line parameters.

                ECHO Copying sysnative\%DLLFILE%"
                "%systemroot%\sysnative\cmd.exe" /c copy "..\net2.00\%DLLFILE%" "%systemroot%\system32\%DLLFILE%"
                ECHO copying sysnative\%DLLFILE2%"
                "%systemroot%\sysnative\cmd.exe" /c copy "..\net2.00\%DLLFILE2%" "%systemroot%\system32\%DLLFILE2%"
                ECHO Copying sysnative\%TLBFILE%"
                "%systemroot%\sysnative\cmd.exe" /c copy "..\net2.00\%TLBFILE%" "%systemroot%\system32\%TLBFILE%"

                ECHO.
                ECHO Registering .NET 2.0 assembly as ActiveX in .NET x64
                ECHO.
                "%windir%\Microsoft.NET\Framework64\v2.0.50727\regasm.exe" "%windir%\system32\%DLLFILE%" /tlb:"%windir%\system32\%TLBFILE%" /codebase

            ) ELSE (

                ECHO Copying system32\%DLLFILE%"
                copy "..\net2.00\%DLLFILE%" "%windir%\System32\%DLLFILE%"
                ECHO copying system32\%DLLFILE2%"
                copy "..\net2.00\%DLLFILE2%" "%windir%\System32\%DLLFILE2%"
                ECHO Copying system32\%TLBFILE%"
                copy "..\net2.00\%TLBFILE%" "%windir%\System32\%TLBFILE%"

                ECHO.
                ECHO Registering .NET 2.0 assembly as ActiveX in .NET x64
                ECHO.
                "%windir%\Microsoft.NET\Framework64\v2.0.50727\regasm.exe" "%windir%\System32\%DLLFILE%" /tlb:"%windir%\System32\%TLBFILE%" /codebase

            )

        REM Display error message
        ) ELSE (

            ECHO.
            ECHO ERROR: Could not find .NET 2.0 or .NET 4.0 framework installed.
            ECHO.
            
            ERROR = -3
            GOTO :ERROR

        )

    )

)


if %ERROR% EQU 0 goto :EOF

:SHOWERROR

echo .
echo Could not register assemblies as ActiveX: %ERROR%
echo .

REM Exit %ERROR%

:EOF