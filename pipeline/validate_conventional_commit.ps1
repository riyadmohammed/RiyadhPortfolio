Param(
    [Parameter(Mandatory = $True)]
    [string]$CommitMessage
)

$Regex = "^(fix|feat|style|refactor|test|docs|chore|revert|release):[\s\S]*$"

$buildRegexPattern = "^\[Build\]\[(Production|Staging|Uat)\]:\s*(Staging|Production|Uat)\s*(Android|iOS)\s*\d+\.\d+\.\d+\s*\(\d+\)(?:\s*:\s*(Staging|Production|Uat)\s*(Android|iOS)\s*\d+\.\d+\.\d+\s*\(\d+\))?[\s\S]*$"

if ($CommitMessage -match $Regex -or $CommitMessage -match $buildRegexPattern) {
    Write-Host "The commit message complies with conventional commits."
}
else {
    Throw "Error: Invalid commit message! $CommitMessage"
}