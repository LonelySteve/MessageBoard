$p = Start-Process -FilePath "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" -PassThru -ArgumentList $args[1..($args.Length - 1)];
$temp_file = Join-Path $args[0] "cpid";
$p.Id > $temp_file;