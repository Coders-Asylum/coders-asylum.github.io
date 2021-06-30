git config --global user.name "codersAsylumDeployer"
git config --global user.name "codersasylum@gmail.com"
git remote set-url origin https://$github_token@github.com/Coders-Asylum/coders-asylum.github.io.git

git commit --all
git push origin production 