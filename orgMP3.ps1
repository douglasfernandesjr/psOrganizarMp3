#Input Params
param ($src, $target, $debugMode)
$srcFolder = $src
$targetFolder = $target

#functions
function DefaultFolderValue {
    param([string]$inputSrt)

    if ([string]::IsNullOrEmpty($inputSrt)) {
        return '.\'
    }
    elseif ( !($inputSrt[-1] -eq '\')) {
        return $inputSrt + '\' 
    }
    else {
        $inputSrt
    }
}

function OrgMp3 {
    param([string]$srcRoot, [string]$dstRoot, [bool]$debugMode)

    $fileList = Get-ChildItem -Path $srcRoot -Filter *.mp3  -File -Recurse

    $shell = New-Object -COMObject Shell.Application
  
    $i = 0;

    foreach ($file in $fileList) {  
        $folderPath = Split-Path $file.FullName
        $objFolder = $shell.Namespace($folderPath)
        $shellfile = $objFolder.ParseName($file.Name)

        $year = $objFolder.getDetailsOf($shellfile, 15)
        if (!$year) {
            $year = "0"
        }
        $album = $objFolder.getDetailsOf($shellfile, 14)
        if (!$album) {
            $album = "AlbumNaoDefinido"
        }else{
            $album = $album -replace '/|\[|\]', ' '
            $album = $album -replace '\:|\?|\"|\-', ''
        }
        ##13 ou 20 também
        $artist = $objFolder.getDetailsOf($shellfile, 237)
        if (!$artist) {
            $artist = $objFolder.getDetailsOf($shellfile, 13)   
        }
        if (!$artist) {
            $artist = "ArtistaNaoDefinido"
        }

        $title = $objFolder.getDetailsOf($shellfile, 21)
        $ext = $objFolder.getDetailsOf($shellfile, 164)
        $fileName = $file.Name
        if($title){
            $title = $title -replace '/|\[|\]', ' '
            $title = $title -replace '\:|\?|\"|\-', ''
            $fileName = $title+ $ext
        }
     
        $newPath = $dstRoot + $artist + "\" + $album + "_" + $year
        $fileNewFullName = $newPath + "\" + $fileName
       

        if ($debugMode) {
            Write-Output $file.FullName 
            Write-Output $fileNewFullName 
        }
        else {
           
            If (!(test-path $newPath )) {
                New-Item -ItemType Directory -Force -Path $newPath
            }

            Move-Item -Path $file.FullName -Destination $fileNewFullName   -Force
        }

        $i++;
    }
    if (!$debugMode) {
        write-host $i " arquivos movidos com sucesso"
    }
    else {
        write-host $i " arquivos listados"
    }
}



#Exec
$srcFolder = DefaultFolderValue -inputSrt $srcFolder

if ([string]::IsNullOrEmpty($targetFolder)) {
    $targetFolder = $srcFolder
}
else {
    $targetFolder = DefaultFolderValue -inputSrt $targetFolder
}

$debug = $false;
if ($debugMode -eq 1) {
    $debug = $true 
}

if ($debug) {
    write-host $srcFolder 
    write-host $targetFolder
}

OrgMp3 -srcRoot $srcFolder  -dstRoot $targetFolder -debugMode $debug
