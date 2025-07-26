#C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy RemoteSigned -noexit "programa\tukimuchi.ps1"

# Bajamos ImageMagick
#Invoke-WebRequest -Uri https://imagemagick.org/archive/binaries/ImageMagick-7.1.2-0-portable-Q16-x64.zip -OutFile ".\programa\ImageMagick-7.1.2-0-portable-Q16-x64.zip"
Write-Host "Script cargado con exito"
$key = 'HKLM:\SOFTWARE\ImageMagick\Current\'
$installpath = Get-ItemPropertyValue $key 'BinPath'
$inputimages = Get-ChildItem -Path ".\entrada\" -File -Filter *.heic
Write-Host $inputimages

function CambioFormato ($entrada) {
    $salida = $entrada | ForEach-Object basename
    $entrada = ".\entrada\$entrada"
    $salida = ".\salida\$salida.jpg"
    Start-Process -FilePath "$installpath\magick.exe" -ArgumentList "$entrada", "$salida" -Wait -NoNewWindow
}

foreach ($inputimage in $inputimages) {
    Write-Host "Procesando imagen: $($inputimage.name)"
    CambioFormato($inputimage)
}