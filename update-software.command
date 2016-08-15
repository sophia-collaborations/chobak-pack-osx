#! /bin/sh

PATH="${HOME}/bin:${PATH}"
export PATH

cd ~/etc || exit
cd chobakwrap
( cd chobakwrap && (
  git pull origin master
  sh install.sh
) )
( cd languamunity && (
  git pull origin master
  sh install.sh
) )
ls



echo
echo
echo "UPDATE COMPLETE"
echo "Press [ENTER] to acknowledge."
read AVOGADRIAN



