<#
    EJERCICIO 3 - Primera entrega
    Integrantes:


#>

Param(
[Parameter(Position = 1, Mandatory = $true,HelpMessage="Ruta del directorio")]
[ValidateNotNullOrEmpty()] [String] $directorio,
[Parameter(Position = 2, Mandatory = $true,HelpMessage="Cantidad de caracteres")]
[ValidateNotNullOrEmpty()] [int] $cantidad
)



if(test-path -Path $directorio) #verifico que el directorio exista
{

    $listanombres = gci $directorio -File #obtengo una lista con los nombres de los archivos en el directorio.

    foreach ($nombre in $listanombres)
    {
        
        $baseName = $nombre.BaseName
        write $baseName
                        
                
        if(($baseName.Length -gt $cantidad)){
            [String]$espacios
            for($j = 0; $j -lt $cantidad; $j++) #creo una cadena de espacios de la cantidad indicada por parámetro.
            {
                $espacios += ' '
            }
           
            
            if($nombre.ToString().StartsWith($espacios)) #verifico que el nombre del archivo no comience con esa cantidad de espacios.
            {
                write "No se debe mover el archivo ya que comienza con $cantidad espacios."
            }
            else{
            
            write "Se debe mover el archivo, longitud del nombre supera $cantidad caracteres."
            [String]$nombreCarpeta
            for($j = 0; $j -lt $cantidad; $j++) #creo una cadena con el nombre del subdirectorio.
            {
                $nombreCarpeta += $nombre.ToString()[$j]
            }

            if(test-path -LiteralPath "$directorio\$nombreCarpeta") #si el subdirectorio existe, muevo el archivo.
            {
                Move-Item -LiteralPath "$directorio\$nombre" -Destination "$directorio\$nombreCarpeta" -Force
            }
            else
            {
                New-item -Path $directorio\$nombreCarpeta –type directory -Force   #creo el subdirectorio
                Move-Item -LiteralPath "$directorio\$nombre" -Destination "$directorio\$nombreCarpeta" -Force
            }
            $espacios = ""
            $nombreCarpeta = ""
            }
        }
        else
        {
            write "No se debe mover, longitud del nombre menor o igual a $cantidad caracteres"
        }

    }
}
else
{
    Write-Host "Path no válido"
    exit 1;
}

<#

.SYNOPSIS
Ejercicio 3 - TP1 - PowerShell


.DESCRIPTION
El script ordena los archivos dentro de subdirectorios cuyos nombres se encuentran basados en las primeras letras de los archivos, formando de esta manera un índice.

Sigue las siguientes reglas:
* Si la longitud del nombre del archivo es menor o igual a X caracteres (sin contar la extensión), el archivo no se debe mover.
* Si la longitud del nombre del archivo es mayor a X caracteres (sin contar la extensión), se debe mover dicho archivo a un subdirectorio cuyo nombre será la cadena formada por los primeros X caracteres del nombre del archivo. En el caso de no existir, crear el subdirectorio.
* Si los primeros X caracteres del nombre de un archivo son espacios, el archivo no se debe mover.

.EXAMPLE
C:\PS> .\ejer3.ps1 -directorio C:\directorio -cantidad 3

Este script moverá los archivos, que posean un nombre de longitud mayor a 3, a un subdirectorio cuyo nombre será la cadena formada por los primeros X caracteres del nombre del archivo. En el caso de no existir, crear el subdirectorio.

.NOTES

.LINK
N/A

#>