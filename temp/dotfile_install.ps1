





New-Item -ItemType SymbolicLink -Path "C:\Users\$env:USERNAME\AppData\Roaming\Code\User\settings.json" -Target "C:\Users\$env:USERNAME\vscode.json" -Force
New-Item -ItemType SymbolicLink -Path "C:\Users\$env:USERNAMEDocuments\WindowsPowerShell" -Target "C:\Users\$env:USERNAME\vscode.json" -Force


git init --bare $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc