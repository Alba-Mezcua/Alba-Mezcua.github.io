### PROGRAMA ###
# copia del acceso directo:
#C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy RemoteSigned -noexit "programa\tukimuchi.ps1"
# FUNCIONES #
# TODO: Investigar comprobar la integridad de todo lo necesario para que funcione y descargar lo que esté corrupto
# TODO: Investigar comprobar última versión y descargar
# TODO: Try-Catch para los requisitos de arquitectura, reparar carpetas y preparar imagemagick 
function Get-Arquitectura {
    #TODO: Falta comprobar si es ARM64 o WIN64 y cómo decidir entre Q8, Q16 y Q16-HDRI (son las opciones del ImageMagick)
    if ((Get-WmiObject win32_operatingsystem | Select-Object osarchitecture).osarchitecture -like "64*") {
        #64 bit logic here
        return "64"
    }
    else {
        #32 bit logic here
        return "32"
    }
}

function Set-Carpetas {
    if ( !(Get-ChildItem -Filter "entrada" -Directory)) {
        Write-Host "Creando carpeta entrada"
        New-Item -Path ".\" -Name "entrada" -ItemType Directory
    }
    if ( !(Get-ChildItem -Filter "salida" -Directory)) {
        Write-Host "Creando carpeta salida"
        New-Item -Path ".\" -Name "salida" -ItemType Directory
    }
}

function Set-ImageMagick ($versionSO) {
    if (!(Get-ChildItem -Filter ".\programa\$versionMagick" -Directory)) {
        # Si no existe el directorio
        if (!(Get-ChildItem -Filter ".\programa\$versionMagick" -File)) {
            # Si no existen ni el directorio ni el fichero, descargamos
            # TODO: Buscar repositorio alternativo por si está caído
            Invoke-WebRequest -Uri "https://imagemagick.org/archive/binaries/$versionMagick.zip" -OutFile ".\programa\$versionMagick.zip"
            # Descomprimimos
            Expand-Archive ".\programa\$versionMagick.zip" -DestinationPath ".\programa"
        }
    }
    # Ejemplos nombre recurso web:
    #https://imagemagick.org/archive/binaries/ImageMagick-7.1.2-0-portable-Q16-x64.zip
    #https://imagemagick.org/archive/binaries/ImageMagick-7.1.2-0-portable-Q16-arm64.zip
    #https://imagemagick.org/archive/binaries/ImageMagick-7.1.2-0-portable-Q8-x86.zip
    #https://imagemagick.org/archive/binaries/ImageMagick-7.1.2-0-portable-Q16-HDRI-x64.zip
}

function Start-CambioFormato ($entrada) {
    $salida = $entrada | ForEach-Object basename
    $entrada = ".\entrada\$entrada"
    $salida = ".\salida\$salida.jpg"
    Start-Process -FilePath ".\programa\$versionMagick\magick.exe" -ArgumentList "$entrada", "$salida" -Wait -NoNewWindow
}

# Comenzamos
Write-Host "Script cargado con exito"

# Pasos iniciales #

$versionSO = Get-Arquitectura
Write-Host "Arquitectura: $versionSO"
$versionMagick = "ImageMagick-7.1.2-0-portable-Q16-HDRI-x$versionSO"
Set-ImageMagick($versionMagick)

Set-Carpetas
Write-Host "Requisitos listos"

# Inicializamos variables
$imagenes = Get-ChildItem -Path ".\entrada\" -File -Filter *.heic

# Y las convertimos
Write-Host "Detectados "$imagenes.Count" archivos .heic"
foreach ($imagen in $imagenes) {
    Write-Host "Procesando imagen: $($imagen.name)"
    Write-Host "Ejecutando .\programa\$versionMagick\magick.exe" #DEBUG
    Start-CambioFormato($imagen)
}