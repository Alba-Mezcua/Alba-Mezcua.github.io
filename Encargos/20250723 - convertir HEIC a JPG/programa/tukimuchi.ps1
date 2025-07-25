#C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy RemoteSigned -noexit "programa\tukimuchi.ps1"
Write-Host 
#Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
$key = 'HKLM:\SOFTWARE\ImageMagick\Current\'
$installpath = Get-ItemPropertyValue $key 'BinPath'
$inputimages = Get-ChildItem -Path $inputfolder -File -Filter *.heic

function CambioFormato ($entrada) {
    $salida = $entrada | ForEach-Object basename
    $entrada = ".\entrada\$entrada"
    $salida = ".\salida\$salida.jpg"
    Write-Host $entrada
    Write-Host $salida

    Start-Process -FilePath "$installpath\magick.exe" -ArgumentList "$entrada", "$salida" -Wait -NoNewWindow
}

foreach ($inputimage in $inputimages) {
    Write-Host "Processing file: $($inputimage.name)" #>> ".\programa\logs\$($inputimage.name).log"
    CambioFormato($inputimage)
}