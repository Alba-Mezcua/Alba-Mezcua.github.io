Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
$key = 'HKLM:\SOFTWARE\ImageMagick\Current\'
$installpath = Get-ItemPropertyValue $key 'BinPath'
$inputfolder = "..\entrada"
$outputfolder = "..\salida"

$inputimages = Get-ChildItem -Path $inputfolder -File -Filter *.heic

foreach ($inputimage in $inputimages) {
    Write-Host "Processing file: $($inputimage.FullName)" -NoNewWindow
    Start-Process -FilePath "$installpath\magick.exe" -ArgumentList "magick","$outputfoldet$inputimage.name" -Wait -RedirectStandardError ".\logs\$inputimage.name.log"
}

# necesita magick y librerías libheif 
#libjpeg-turbo 3.1.0