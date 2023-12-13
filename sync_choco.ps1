# Read each line in choco_packages.txt
Get-Content choco_packages.txt | Where-Object {$_ -and $_ -notmatch "packages installed|Chocolatey"} | ForEach-Object {
    # Split the line to get the package name
    $packageName = $_.Split(' ')[0]
    # Install the package using Chocolatey
    choco install $packageName -y
}

