if(!(Test-Path "f:\")) {
    "Error: destination path does not exist, abort backup" >> "d:\temp\backup.log"
    Write-Host "Error: destination path does not exist, abort backup"
    return;
}

$param = '"d:\reference" "f:\reference" /MIR /R:1 /W:0 /LOG:d:\temp\backup.log /V'
& robocopy $param

$param = '"d:\admin" "f:\admin" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$excludefiles = @(
    'visionsupport.pst',
    'visionsupport_archive.pst',
    '*.tmp')
$param = '"d:\mail" "f:\mail" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log /V'
$excludefiles | foreach { $param = $param + ' /xf ' + $_ }
if(Get-Process outlook) {
    "Warning: Outlook is running, skipping mailbox backup" >> "d:\temp\backup.log"
    Write-Host "Warning: Outlook is running, skipping mailbox backup"
}
else {
    & robocopy $param    
}

#$excludefiles = @(
#    '*.obj'
#    '*.pch'
#    '*.log'
#    '*.pdb'
#    '*.map'
#    '*.exp'
#    '*.ilk'
#    '*.ncb'
#    '*.suo'
#    '*.scc'
#    '*.idb'
#    '*.ipch'
#    '*.tlog')
#$param = '"d:\Projects" "f:\Projects" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
#$excludefiles | foreach { $param = $param + ' /xf ' + $_ }
#& robocopy $param

push-location
cd "d:\Projects\Integra"
git push "f:\Projects\Integra"
$param = '"d:\Projects\Integra\.gitignore" "f:\Projects\Integra\.gitignore" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param
pop-location

$param = '"d:\scripts" "f:\scripts" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"d:\Evernote" "f:\Evernote" "work.enex" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"D:\Integra Maxx_x64" "f:\Integra Maxx_x64" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"D:\Integra Maxx_isort" "f:\Integra Maxx_isort" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"D:\IntegraVision_V5" "f:\IntegraVision_V5" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"D:\OTF_x64" "f:\OTF_x64" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"D:\OTF_x86" "f:\OTF_x86" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"D:\Program Files\STI\OTF" "f:\Program Files\STI\OTF" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"D:\Parameters" "f:\Parameters" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"D:\tasks" "f:\tasks" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"D:\reg" "f:\reg" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"D:\sti_doc" "f:\sti_doc" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"D:\sti_packages" "f:\sti_packages" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"D:\ocr" "f:\ocr" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"D:\tools" "f:\tools" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"D:\updater3.1" "f:\updater3.1" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"C:\Users\sutunmiang\Documents" "f:\Users\sutunmiang\Documents" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"C:\Users\sutunmiang\Desktop" "f:\Users\sutunmiang\Desktop" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"C:\Users\sutunmiang\Downloads" "f:\Users\sutunmiang\Downloads" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"D:\STILIB" "f:\STILIB" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

$param = '"D:\OCR" "f:\OCR" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
& robocopy $param

select-string -path "d:\temp\backup.log" -pattern 'ERROR \d+' -CaseSensitive | tee-object -filepath "d:\temp\backupSummary.log"

#Stop-Computer -Force