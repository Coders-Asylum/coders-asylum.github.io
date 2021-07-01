
git config --global user.name "Maverick099"
git remote set-url origin https://Maverick099:$GITHUB_TOKEN@github.com/Coders-Asylum/coders-asylum.github.io.git

git commit --all -m 'New Build'
git push origin production 