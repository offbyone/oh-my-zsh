alias clean='rm -f *~ .??*~ \#* *.pyc'
alias cleantree='find . -type f \( -name "*~" -o -name ".??*~" -o -name "#*" -o -name ".#*" -o -name "*.pyc" \) \( -exec rm {} \; -o -print \)'
alias scrape='find . -type f \( -name "*~" -o -name ".??*~" -o -name "#*" -o -name ".#*" -o -name "*.pyc" \) -exec rm "{}" \;'
