#! /bin/sh

cd "$(dirname "${0}")" || exit

rm -rf x-tmp
perl pl/initial-install.pl

echo
cat "x-tmp/end-mesg.txt"
echo
echo "Press [ENTER] to acknowledge."
read AVOGADRIAN

if [ -f "x-tmp/end-action.sh" ]; then
  sh x-tmp/end-action.sh
fi


