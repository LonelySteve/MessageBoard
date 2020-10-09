$p = Join-Path $args[0] "cpid"
$c = Get-Content $p;
Stop-Process $c;
Remove-Item $p
