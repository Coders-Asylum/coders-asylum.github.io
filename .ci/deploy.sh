export GITHUB_TOKEN = Maverick099:ENCRYPTED[323b2424340d76527a19341a764fbbc25d5be1fffb6a389302b52ee18bb2867cd78bf000e4e963620fe7e4b73da39afd]

git config --global user.name "Maverick099"
git remote set_url origin https://$GITHUB_TOKEN@github.com/Coders-Asylum/coders-asylum.github.io.git

git commit --all -m "New Build"
git push origin production 