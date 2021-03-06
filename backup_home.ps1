$logfile = 'e:\backup.log'
$summaryfile = 'e:\summarybackup.log'
get-date | set-content $logfile

if(!(Test-Path "e:\")) {
    "Error: destination path does not exist, abort backup" >> $logfile
    Write-Host "Error: destination path does not exist, abort backup"
    return;
}

#$excludefiles = @(
#    'visionsupport.pst',
#    'visionsupport_archive.pst',
#    '*.tmp')
#$param = '"d:\mail" "f:\mail" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log /V'
#$excludefiles | foreach { $param = $param + ' /xf ' + $_ }
#if(Get-Process outlook) {
#    "Warning: Outlook is running, skipping mailbox backup" >> "d:\temp\backup.log"
#    Write-Host "Warning: Outlook is running, skipping mailbox backup"
#}
#else {
#    & robocopy $param    
#}

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
#$param = '"d:" "e:\data" /MIR /R:1 /W:0 /LOG+:'+$logfile
#$excludefiles | foreach { $param = $param + ' /xf ' + $_ }
#& robocopy $param

#push-location
#cd "d:\Projects\Integra"
#git push "f:\Projects\Integra"
#$param = '"d:\Projects\Integra\.gitignore" "f:\Projects\Integra\.gitignore" /MIR /R:1 /W:0 /LOG+:d:\temp\backup.log'
#& robocopy $param
#pop-location

#$param = '"C:\Users\sutm\Documents" "h:\Users\sutm\Documents" /MIR /R:1 /W:0 /LOG+:'+$logfile
#& robocopy $param

#$param = '"C:\Users\sutm\Desktop" "h:\Users\sutm\Desktop" /MIR /R:1 /W:0 /LOG+:'+$logfile
#& robocopy $param

#$param = '"C:\Users\sutm\Downloads" "h:\Users\sutm\Downloads" /MIR /R:1 /W:0 /LOG+:'+$logfile
#& robocopy $param

#$param = '"C:\Users\sutm\Music" "h:\Users\sutm\Music" /MIR /R:1 /W:0 /LOG+:'+$logfile
#& robocopy $param

#$param = '"C:\Users\sutm\Videos" "h:\Users\sutm\Videos" /MIR /R:1 /W:0 /LOG+:'+$logfile
#& robocopy $param

#$param = '"C:\Users\sutm\Pictures" "h:\Users\sutm\Pictures" /MIR /R:1 /W:0 /LOG+:'+$logfile
#& robocopy $param

$includefolders = @(
    #'Documentaries',
    'Financial',
    'Housing',
    'Image Processing',
    'Job Application',
    'Letter Templates',
    'Machine Vision',
    'Mail',
    'Maths',
    'Medical',
    'Music',
    #'Music Videos',
    'Past Projects',
    'photo',
    #'pluralsight',
    'scripts',
    'study',
    'Utilities',
    'Warranty')

$includefolders | foreach {
    $folder = "$_"
    $src = "d:\"+"$folder"
    $dst = "e:\"+"$folder"
    $flag1 = "/MIR"
    $flag2 = "/R:1"
    $flag3 = "/W:0"
    $flag4 = "/LOG+:"+$logfile
    $allArgs = @($src, $dst, $flag1, $flag2, $flag3, $flag4)
    & robocopy $allArgs
}


#select-string -path $logfile -pattern 'ERROR \d+' -CaseSensitive | tee-object -filepath $summaryfile

#Stop-Computer -Force