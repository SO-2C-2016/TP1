<#
    EJERCICIO 4 - Primera entrega
    Integrantes:


#>

# Habilito los parametros comunes de PowerShell, como –Verbose y –Debug
# Adicionalmente nombramos al set default de parametros para que powershell pueda
# diferenciarlos de los subsets declarados posteriormente.
[CmdletBinding(DefaultParameterSetName='default')]
Param (
    [ValidateNotNull()][Parameter (ValueFromPipeline=$true)] $input,
    [ValidateNotNullOrEmpty()] [Parameter (Mandatory=$True)] [String] $propiedad,
    [ValidateNotNullOrEmpty()] [Parameter (Mandatory=$True)] [String] $filtro,
    [Parameter (Mandatory=$false, ParameterSetName='desc')] [switch] $desc,
    [Parameter (Mandatory=$false, ParameterSetName='asc')] [switch] $asc,
    [ValidateNotNullOrEmpty()] [Parameter (Mandatory=$false)] [String[]] $print
) 

if ($print) {
    # Solo imprimimos los datos solicitados formateados como lista.
    Write-Output ($input | Where-Object {$_.$propiedad -like "*$filtro*"} | Select-Object -Property $print | Format-List)
} else {
    # Devolvemos la lista de objetos filtrada y ordenada segun lo requerido por el usuario.
    if ($desc) {
        $input | Where-Object {$_.$propiedad -like "*$filtro*"} | Sort-Object -Property $propiedad -Descending
    } else {
        $input | Where-Object {$_.$propiedad -like "*$filtro*"} | Sort-Object -Property $propiedad
    }
}

<#
	.SYNOPSIS
	Este script permite filtrar, ordenar y opcionalmente mostrar por pantalla una colección de objetos.
	.DESCRIPTION
	Este script permita filtrar, ordenar y opcionalmente mostrar por pantalla una colección de objetos.
	Posee dos modos de uso: 
    1- Mostrar por pantalla las propiedades seleccionadas de los objetos que coinciden con la búsqueda.
    2- Filtrar, ordenar y Entregar como salida la lista de objetos que coinciden con la búsqueda.
    Todos los parametros de este script parametros deben ser referenciados por nombre.
	.PARAMETER input
	Lista de objetos de entrada. Debe recibirse a través de un pipeline.
	.PARAMETER propiedad
	Nombre de la propiedad por la que se desea filtrar.
    .PARAMETER filtro
    Palabra clave utilizada como criterio de búsqueda. El texto de este argumento debe ser igual o estar contenido en el valor de la propiedad indicada en -propiedad. 
    .PARAMETER desc
    Ordena la lista de objetos obtenida de forma descendente según la propiedad indicada en -propiedad. No puede ser utilizado al mismo tiempo que -asc.
    .PARAMETER asc
    (Default) Ordena la lista de objetos obtenida de forma ascendente según la propiedad indicada en -propiedad. No puede ser utilizado al mismo tiempo que -desc.
    .PARAMETER print
    Si está presente, debe indicarse como argumento una lista de propiedades. El script solo mostrará por pantalla las propiedades seleccionadas de los objetos que coinciden con la búsqueda. No se realiza ordenamiento.
	.EXAMPLE
    Devuelve una lista filtrada de objetos Process. Aquellos que tengan el numero 12 en su ID, ordenados ascendentemente según dicha propiedad.

	Get-Process | .\ejercicio4.ps1 -propiedad ID -filtro 12 -desc
	.EXAMPLE
    Devuelve una lista filtrada de objetos Process. Aquellos que tengan el numero 12 en su ID, ordenados descendentemente según dicha propiedad.

	Get-Process | .\ejercicio4.ps1 -propiedad ID -filtro 12 -asc
	.EXAMPLE
    Devuelve una lista filtrada de objetos Process. Aquellos que tengan el numero 12 en su ID, ordenados ascendentemente (por default) según dicha propiedad.

	Get-Process | .\ejercicio4.ps1 -propiedad ID -filtro 12
    .EXAMPLE
    Filtra una lista de objetos Process. Aquellos que tengan el numero 12 en su ID, y muestra por pantalla las propiedades indicadas en -print para cada resultado obtenido.
    
	Get-Process | .\ejercicio4.ps1 -propiedad ID -filtro 12 -print Name,CPU,Handles
    .EXAMPLE
    Devuelve una lista de los objetos que representan archivos con la extensión .txt.
    
	gci | .\ejercicio4.ps1 -propiedad Name -filtro .txt
#>
