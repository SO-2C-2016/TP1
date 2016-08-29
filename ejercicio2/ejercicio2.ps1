<#
    EJERCICIO 2 - Primera entrega
    Integrantes:


#>

[CmdletBinding()]
Param(
    [ValidateNotNullOrEmpty()] [Parameter(Mandatory=$true,HelpMessage="Ruta:")] [String] $ruta
)

# Declaramos primero las funciones para que se carguen en memoria antes de que comience el script.
function nonPrintableAsciiToStr ($char) {
    $nonPrintable = @('[NUL]', '[SOH]', '[STX]', '[ETX]', '[EOT]', '[ENQ]', '[ACK]',
                      '[BEL]', '[BS]', '[TAB]', '[LF]', '[VT]', '[FF]', '[CR]', '[SO]',
                      '[SI]', '[DLE]', '[DC1]', '[DC2]', '[DC3]', '[DC4]', '[NAK]', '[SYN]',
                      '[ETB]', '[CAN]', '[EM]', '[SUB]', '[ESC]', '[FS]', '[GS]', '[RS]', '[US]',
                      '[SPACE]')
    
    if (($char -ge 0) -and ($char -le 32)) {
        return $nonPrintable[$char]
    } else {
        return $char
    }
}
# verificamos que exista y no sea una carpeta.
$existe = Test-Path -Path $ruta -PathType Leaf
if ($existe -eq $true) {
    # obtenemos el archivo a partir de la ruta.
    $file = Get-Item -Path $ruta

    # Como windows basa el reconocimiento de archivos en el
    # uso de extensiones, exigimos al usuario un *.txt
    if ((echo $file.Extension.ToLower()) -eq ".txt") {

        # obtenemos el contenido y lo transformamos en un array de caracteres.
        $content = Get-content -Raw -Path $ruta
        $charArray = $content.ToCharArray()

        # creamos un hash-table y contabilizamos los caracteres.
        $cant=@{}
        foreach($char in $charArray) {
            $cant[$char]++
        }

        # Mostramos el reporte.
        $cant.GetEnumerator() | Sort-Object Name,Value |
                                Select-Object  @{Name="Char"; Expression={nonPrintableAsciiToStr($_.Name)}},
                                               @{Name="Percent"; Expression={"{0:N2}" -f (($_.Value / $charArray.Count) * 100)}},
                                               @{Name=""; Expression={'%'}} | 
                                Format-Table -AutoSize -HideTableHeaders
    } else {
        Write-Error 'El archivo ingresado no es un archivo de texto.'
    }
} else {
    Write-Error 'El archivo no existe.'
}

<#

    .SYNOPSIS
    Ejercicio 2 - TP1 - PowerShell


    .DESCRIPTION
    El script muestra el porcentaje de ocurrencia de cada carácter en un archivo de texto, cuya ruta será pasada por parámetro. Se debe cumplir con las siguientes consideraciones:
    * Los resultados se muestran en formato de tabla utilizando el cmdlet Format-Table.
    * Se distingue entre mayúsculas y minúsculas.
    * Se tienen en cuenta todos los caracteres del archivo, incluidos los espacios, tabs, salto de línea, etc.

    .PARAMETER ruta
    Ruta del archivo .txt a analizar. 

    .EXAMPLE
    > .\Desktop\ejercicio2.ps1 .\prueba.txt

    .NOTES
    Como windows basa el reconocimiento de archivos en el uso de extensiones, exigimos al usuario un *.txt

    .LINK
    N/A

#>