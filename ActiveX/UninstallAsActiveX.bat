@echo off

REM --------------------------------------------------------------------------------------
REM - This batch uninstalls assemblies as ActiveX object using .NET 2.0 or 4.0           -
REM - for x86, x64 and x86 emulation modes.                                              -
REM - On Windows Vista and later this batch should be ran in "As Administrator" mode.    -
REM --------------------------------------------------------------------------------------

SET DLLFILE=Bytescout.PDFExtractor.dll
SET DLLFILE2=Bytescout.PDFExtractor.OCRExtension.dll
SET TLBFILE=Bytescout.PDFExtractor.tlb

SET ERROR=0


REM ------------ x86 Windows deinstallation ------------------------

IF NOT EXIST "%systemroot%\SYSWOW64\" (

    IF NOT "%DLLFILE%"=="" IF NOT "%DLLFILE2%"=="" IF NOT "%TLBFILE%"=="" IF EXIST "%windir%\system32\%DLLFILE%" (

        REM Unregister assembly as ActiveX
        IF EXIST "%windir%\Microsoft.NET\Framework\v4.0.30319\regasm.exe" "%windir%\Microsoft.NET\Framework\v4.0.30319\regasm.exe" "%windir%\System32\%DLLFILE%" /tlb:"%windir%\System32\%TLBFILE%" /unregister 
        IF EXIST "%windir%\Microsoft.NET\Framework\v2.0.50727\regasm.exe" "%windir%\Microsoft.NET\Framework\v2.0.50727\regasm.exe" "%windir%\System32\%DLLFILE%" /tlb:"%windir%\System32\%TLBFILE%" /unregister 

        REM Delete files
        DEL "%windir%\System32\%DLLFILE%"
        DEL "%windir%\System32\%DLLFILE2%"
        DEL "%windir%\System32\%TLBFILE%"

    ) ELSE (

        ECHO.
        ECHO %DLLFILE% not found so nothing to uninstall
        ECHO.
    )

) ELSE (

    REM ------------ x64 Windows deinstallation ------------------------

    REM check x86 emulation mode files

    IF NOT "%DLLFILE%"=="" IF NOT "%DLLFILE2%"=="" IF NOT "%TLBFILE%"=="" IF EXIST "%windir%\SYSWOW64\%DLLFILE%" (

        echo.
        echo Unregistering assembly as ActiveX from x86 emulation mode
        echo.
        IF EXIST "%windir%\Microsoft.NET\Framework\v4.0.30319\regasm.exe" "%windir%\Microsoft.NET\Framework\v4.0.30319\regasm.exe" "%windir%\SYSWOW64\%DLLFILE%" /tlb:"%windir%\SYSWOW64\%TLBFILE%" /unregister 
        IF EXIST "%windir%\Microsoft.NET\Framework\v2.0.50727\regasm.exe" "%windir%\Microsoft.NET\Framework\v2.0.50727\regasm.exe" "%windir%\SYSWOW64\%DLLFILE%" /tlb:"%windir%\SYSWOW64\%TLBFILE%" /unregister 

        echo.
        echo Delete files from x86 emulation mode
        echo.
        DEL "%windir%\SYSWOW64\%DLLFILE%"
        DEL "%windir%\SYSWOW64\%DLLFILE2%"
        DEL "%windir%\SYSWOW64\%TLBFILE%"

    ) ELSE (

        ECHO.
        ECHO x86 emulation mode on x64: %DLLFILE% not found so nothing to uninstall
        ECHO.	
    )

    IF NOT "%DLLFILE%"=="" IF NOT "%DLLFILE2%"=="" IF NOT "%TLBFILE%"=="" (

        REM case #1 (this batch runs from x86 console so should use "sysnative" alias to access x64 folders)
        IF EXIST "%windir%\sysnative\%DLLFILE%" (

            echo.
            echo Unregistering .NET 4.0 version if registered 
            echo.
            IF EXIST "%windir%\Microsoft.NET\Framework64\v4.0.30319\regasm.exe" "%windir%\Microsoft.NET\Framework64\v4.0.30319\regasm.exe" "%windir%\system32\%DLLFILE%" /tlb:"%windir%\system32\%TLBFILE%" /unregister 
            echo.
            echo Unregistering .net 2.0 version if registered 
            echo.
            IF EXIST "%windir%\Microsoft.NET\Framework64\v2.0.50727\regasm.exe" "%windir%\Microsoft.NET\Framework64\v2.0.50727\regasm.exe" "%windir%\system32\%DLLFILE%" /tlb:"%windir%\system32\%TLBFILE%" /unregister 

            echo.
            echo Delete sysnative\%DLLFILE%
            echo.
            DEL "%windir%\sysnative\%DLLFILE%"
            echo.
            echo Delete sysnative\%DLLFILE2%
            echo.
            DEL "%windir%\sysnative\%DLLFILE2%"
            echo.
            echo Delete sysnative\%TLBFILE%
            echo.
            DEL "%windir%\sysnative\%TLBFILE%"

        ) ELSE (

            ECHO.
            ECHO x64 native mode: sysnative\%DLLFILE% not found so nothing to deinstall
            ECHO.	
        )

        REM case #2 (this batch runs from x64 console)
        IF EXIST "%windir%\system32\%DLLFILE%" (

            echo.
            echo Unregistering .NET 4.0 version if registered 
            echo.
            IF EXIST "%windir%\Microsoft.NET\Framework64\v4.0.30319\regasm.exe" "%windir%\Microsoft.NET\Framework64\v4.0.30319\regasm.exe" "%windir%\system32\%DLLFILE%" /tlb:"%windir%\system32\%TLBFILE%" /unregister 
            echo.
            echo Unregistering .NET 2.0 version if registered 
            echo.
            IF EXIST "%windir%\Microsoft.NET\Framework64\v2.0.50727\regasm.exe" "%windir%\Microsoft.NET\Framework64\v2.0.50727\regasm.exe" "%windir%\system32\%DLLFILE%" /tlb:"%windir%\system32\%TLBFILE%" /unregister 

            echo Delete system32\%DLLFILE%
            DEL "%windir%\system32\%DLLFILE%"
            echo Delete system32\%DLLFILE2%
            DEL "%windir%\system32\%DLLFILE2%"
            echo Delete system32\%TLBFILE%
            DEL "%windir%\system32\%TLBFILE%"

        ) ELSE (

            ECHO.
            ECHO x64 native mode: system32\%DLLFILE% not found so nothing to deinstall
            ECHO.	
        )

    ) ELSE (

        ECHO.
        ECHO x64 native mode: %DLLFILE% not found so nothing to deinstall
        ECHO.	
    )

)
