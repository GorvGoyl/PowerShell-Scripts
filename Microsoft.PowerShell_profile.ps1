#OPEN IN NOTEPAD
# notpad $PSHOME\Microsoft.PowerShell_profile.ps1

#references
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-6
# https://stackoverflow.com/questions/58625575/git-add-commit-push-one-liner-for-powershell-windows/58734235?noredirect=1#comment103759608_58734235
# function gitlazy {
#   param(
#     [Parameter(ValueFromRemainingArguments = $true)]
#     [String[]] $message
#   )
#   git add .
#   git commit -a -m "$message"
#   git push
# }
# Set-PSReadLineOption -EditMode Windows
# Set-PSReadLineKeyHandler -Chord Ctrl+Backspace -Function BackwardDeleteChar
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



function jkbuildgitacp {
  param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [String[]] $message
  )
  echo "👉 bundle exec jekyll build"
  bundle exec jekyll build 

  echo "👉 git add ."
  git add .

  echo "👉 git commit -a -m $message"	
  git commit -a -m "$message"

  echo "👉 git push"
  git push
}