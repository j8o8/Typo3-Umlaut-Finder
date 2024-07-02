[CmdletBinding()] param(
    [Parameter(Mandatory=$false)] # Directory to search in
    [string[]]$Path = "D:\xampp\htdocs\cms1"
)

Write-Host "Listing files with any umlaut`n" -ForegroundColor Yellow

$UmlautFiles = Get-ChildItem -Path $Path -Include *ä*,*ö*,*ü* -Recurse -Force -ErrorAction "SilentlyContinue"

if (([string]::IsNullOrEmpty($UmlautFiles))) {
        Write-Host "No files found" -ForegroundColor Green
} else {
    $c = 1
    foreach ($File in $UmlautFiles) {
        Write-Host "File $c" -ForegroundColor Yellow
        $FileName = ($File).FullName
        if ($FileName -match "ä") {
            $FileName = $FileName.Split("ä")
            Write-Host $FileName[0] -NoNewline
            Write-Host "ä" -NoNewline -ForegroundColor Red
            Write-Host $FileName[1]
        } elseif ($FileName -match "ö") {
            $FileName = $FileName.Split("ö")
            Write-Host $FileName[0] -NoNewline
            Write-Host "ö" -NoNewline -ForegroundColor Red
            Write-Host $FileName[1]
        } elseif ($FileName -match "ü") {
            $FileName = $FileName.Split("ü")
            Write-Host $FileName[0] -NoNewline
            Write-Host "ü" -NoNewline -ForegroundColor Red
            Write-Host $FileName[1]
        }
        Write-Host "Owner: " -NoNewline
        (Get-Acl ($File).FullName).Owner
        $c = $c + 1
    }
    Write-Host "`nListing files complete" -ForegroundColor Green
}