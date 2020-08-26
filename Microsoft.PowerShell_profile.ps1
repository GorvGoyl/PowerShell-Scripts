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

function touch {New-Item -ItemType File -Name ($args[0])}




