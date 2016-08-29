<#
    EJERCICIO 1 - Primera entrega
    Integrantes:


#>

Param($pathsalida)
$existe = Test-Path $pathsalida
if ($existe -eq $true)
{
$lista = Get-ChildItem -File
foreach ($item in $lista)
{
Write-Host “$($item.Name) $($item.Length)”
}
}
else
{
Write-Error "El path no existe"
}

#a) El objetivo del script es determinar si todos los elementos que hay en la variable "$pathsalida" existen. En caso de existir lanza true y se guarda
#en la variable "$existe", caso contrario saldra false. En caso de ser true el valor que hay en la variable $existe se guarda en la variable $lista
#todos los archivos que haya en el directorio actual y por cada archivo ($item) que se encuentre en la lista mostrara por pantalla el nombre del archivo con su extensión seguido de su peso.
#En caso de ser false el valor de la variable $existe se mostrará por pantalla el mensaje de error: "el path no existe".
#b) Las validaciones que agregaría a la definición de parámetros sería un Mandatory = $true para que sea obligatorio el ingreso de $pathsalida.
#c) Con los cmdlet: GetFileNameWithoutExtension y GetExtension se podría reemplazar el script para mostrar una salida similar por pantalla
<# Param($pathsalida)
$existe = Test-Path C:\Users\Adriel
if ($existe -eq $true)
{
$lista = Get-ChildItem -File
foreach ($item in $lista)
{
Write-Host “GetFileNameWithoutExtension("$($item.Name)") GetExtension("$($item.Length)")" 
}
}
else
{
Write-Error "El path no existe"
} #>

<#

.SYNOPSIS
Ejercicio 1 - TP1 - PowerShell


.DESCRIPTION
El objetivo del script es determinar si todos los elementos que hay en la variable "$pathsalida" existen. En caso de existir lanza true y se guarda en la variable "$existe", caso contrario saldra false. En caso de ser true el valor que hay en la variable $existe se guarda en la variable $lista
todos los archivos que haya en el directorio actual y por cada archivo ($item) que se encuentre en la lista mostrara por pantalla el nombre del archivo con su extensión seguido de su peso. En caso de ser false el valor de la variable $existe se mostrará por pantalla el mensaje de error: "el path no existe".

.EXAMPLE
Para su ejecución hay que reemplazar el contenido de $pathsalida por alguna ruta válida, una vez hecho eso lo podemos ejecutar.

.NOTES

.LINK
N/A

#>