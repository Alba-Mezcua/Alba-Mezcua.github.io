### PROGRAMA ###
# copia del acceso directo:
#C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy RemoteSigned -noexit "programa\tukimuchi.ps1"
# FUNCIONES #

function Comprobar-Arquitectura {
    if ((Get-WmiObject win32_operatingsystem | Select-Object osarchitecture).osarchitecture -eq "64*") {
        #64 bit logic here
        Write-Host "64-bit OS"
        $versionSO = "x64"
    }
    else {
        #32 bit logic here
        Write-Host "32-bit OS"
        $versionSO = "x32"
    }
}

function Reparar-Carpetas {
    if ( !(Get-ChildItem -Filter "entrada" -Directory)) {
        Write-Host "Creando carpeta entrada"
        New-Item -Path ".\" -Name "entrada" -ItemType Directory
    }
    if ( !(Get-ChildItem -Filter "salida" -Directory)) {
        Write-Host "Creando carpeta salida"
        New-Item -Path ".\" -Name "salida" -ItemType Directory
    }
}

function Preparar-ImageMagick ($versionSO) {
    if (!(Get-ChildItem -Filter ".\programa\ImageMagick*" Directory)) {
        # Si no existe el directorio
        if (!(Get-ChildItem -Filter ".\programa\ImageMagick*" -File)) {
            # Si no existen ni el directorio ni el fichero, descargamos
            Invoke-WebRequest -Uri https://imagemagick.org/archive/binaries/ImageMagick-7.1.2-0-portable-Q16-x64.zip -OutFile ".\programa\ImageMagick-7.1.2-0-portable-Q16-x64.zip"
            # Descomprimimos
        }
    }
    #Invoke-WebRequest -Uri https://imagemagick.org/archive/binaries/ImageMagick-7.1.2-0-portable-Q16-x64.zip -OutFile ".\programa\ImageMagick-7.1.2-0-portable-Q16-x64.zip"
    #https://imagemagick.org/archive/binaries/ImageMagick-7.1.2-0-portable-Q16-arm64.zip
    #https://imagemagick.org/archive/binaries/ImageMagick-7.1.2-0-portable-Q8-x86.zip
}

function Cambio-Formato ($entrada) {
    $salida = $entrada | ForEach-Object basename
    $entrada = ".\entrada\$entrada"
    $salida = ".\salida\$salida.jpg"
    Start-Process -FilePath ".\programa\$versionMagick\magick.exe" -ArgumentList "$entrada", "$salida" -Wait -NoNewWindow
}

# Comenzamos
Write-Host "Script cargado con exito"

# Pasos iniciales #
Reparar-Carpetas
Preparar-ImageMagick
Write-Host "Requisitos listos"

# Inicializamos variables
$inputimages = Get-ChildItem -Path ".\entrada\" -File -Filter *.heic
$versionMagick = "ImageMagick-7.1.2-0-portable-Q16-HDRI-x64"

# Y las convertimos
Write-Host "Detectados "$inputimages.Count" archivos .heic"
foreach ($inputImage in $inputImages) {
    Write-Host "Procesando imagen: $($inputImage.name)"
    Write-Host "Ejecutando .\programa\$versionMagick\magick.exe"
    Cambio-Formato($inputImage)
}