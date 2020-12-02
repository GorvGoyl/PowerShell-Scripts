#OPEN IN NOTEPAD
# notpad $PSHOME\Microsoft.PowerShell_profile.ps1

#references
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-6
# https://stackoverflow.com/questions/58625575/git-add-commit-push-one-liner-for-powershell-windows/58734235?noredirect=1#comment103759608_58734235

# Set-PSReadLineOption -EditMode Windows
# Set-PSReadLineKeyHandler -Chord Ctrl+Backspace -Function BackwardDeleteChar

# get all keybindings
# https://docs.microsoft.com/en-gb/previous-versions/powershell/module/psreadline/Get-PSReadLineKeyHandler?view=powershell-5.0
#Get-PSReadLineKeyHandler -Bound -Unbound

# try catch blocks
#https://stackoverflow.com/questions/8693675/check-if-a-command-has-run-successfully
#https://www.gngrninja.com/script-ninja/2016/6/5/powershell-getting-started-part-11-error-handling

Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
if ($env:TERM_PROGRAM -eq "vscode") {
  Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardKillWord
}

# open file explorer `ii .`

# colorize powershell and show git branch
# Import-Module posh-git
function Write-BranchName () {
    try {
        $branch = git rev-parse --abbrev-ref HEAD

        if ($branch -eq "HEAD") {
            # we're probably in detached HEAD state, so print the SHA
            $branch = git rev-parse --short HEAD
            Write-Host " ($branch)" -ForegroundColor "red"
        }
        else {
            # we're on an actual branch, so print it
            Write-Host " ($branch)" -ForegroundColor "blue"
        }
    } catch {
        # we'll end up here if we're in a newly initiated git repo
        Write-Host " (no branches yet)" -ForegroundColor "yellow"
    }
}

function prompt {
    $base = "PS "
    $path = "$($executionContext.SessionState.Path.CurrentLocation)"
    $userPrompt = "$('>' * ($nestedPromptLevel + 1)) "

    Write-Host "`n$base" -NoNewline

    if (Test-Path .git) {
        Write-Host $path -NoNewline -ForegroundColor "green"
        Write-BranchName
    }
    else {
        # we're not in a repo so don't bother displaying branch name/sha
        Write-Host $path -ForegroundColor "green"
    }

    return $userPrompt
}


function gitacp {
  param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [String[]] $message
  )
  echo "👉 git add ."
  git add .

  echo "👉 git commit -a -m "$message""
  git commit -a -m "$message"

  echo "👉 git push"
  git push
}

function touch
{
    $file = $args[0]
    if($file -eq $null) {
        throw "No filename supplied"
    }

    if(Test-Path $file)
    {
        throw "file already exists"
    }
    else
    {
        # echo $null > $file
        New-Item -ItemType File -Name ($file)
    }
}


