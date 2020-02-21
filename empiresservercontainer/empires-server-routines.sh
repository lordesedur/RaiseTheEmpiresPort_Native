sudo apt-get install python3 python3-setuptools python3-dev git dialog openssh -y
sudo pacman -S python git dialog python-setuptools openssh --noconfirm
python3 -m pip install tendo py3amf flask flask_session flask_sqlalchemy flask_compress flask_socketio daiquiri git+git://github.com/christhechris/libscrc python-editor
export RaiseTheEmpiresRNTINI=RaiseTheEmpires/RaiseTheEmpires.ini
echo "[Info]" > ${RaiseTheEmpiresRNTINI}
echo "Name=RaiseTheEmpires_GNU_LINUX_EDITION" >> ${RaiseTheEmpiresRNTINI}
echo "URL=https://github.com/AcidCaos/empires-and-allies" >> ${RaiseTheEmpiresRNTINI}
echo "Binary=empires-server" >> ${RaiseTheEmpiresRNTINI}
echo "[InstallFolders]" >> ${RaiseTheEmpiresRNTINI}
echo "InstallPath=$(pwd)/RaiseTheEmpires" >> ${RaiseTheEmpiresRNTINI}
echo "MyGamesPath=$(pwd)/RaiseTheEmpires/fileSave" >> ${RaiseTheEmpiresRNTINI}
echo "[InstallSettings]" >> ${RaiseTheEmpiresRNTINI}
echo "Arch=$(uname -m)" >> ${RaiseTheEmpiresRNTINI}
export TMPDIR=$(pwd)/RaiseTheEmpires/RNT
export origindir=$(pwd)
HEIGHT=15
WIDTH=80
CHOICE_HEIGHT=18
ver=$(cat ${origindir}/buildnumber)
BACKTITLE="empires-server Build ${ver} by RaiseTheEmpires team"
TITLE="Empires And Allies Mission Control"
#import executionCall
. ${origindir}/executionRoutines


UpdateSERVER & # This will updates the server while in use without needing to do manual labour




dialog --msgbox "Welcome to empires-server build ${ver}" 40 40

function menuSel()
{
OPTIONS=(
"Start" "Start empires-server"
"changelog" "see the changelog"
"RestoreSnapshot" "Restore Save File Snapshot"
"ManualUpdate" "Triggers the empires-server to update manually if you had downloaded the newest version but no update"
"MigratetoPC" "This will export the save file to your internal storage in RaiseTheEmpires folder"
"MigratetoTermux" "This will import save file that is on RaiseTheEmpires Folder in your internal storage "
"trim" "This will trim the storage usage but sacrifices the snapshot backup"
"exit" "Exit from the empires-server boot menu")


mission=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "Select Action" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)


if [ ${mission} == 'changelog' ]; then
changelogsee
fi

if [ ${mission} == 'Start' ]; then
serverRun
fi

if [ ${mission} == 'RestoreSnapshot' ]; then
snapshotMenu
fi

if [ ${mission} == 'ManualUpdate' ]; then
UpdateSERVER
fi

if [ ${mission} == 'MigratetoPC' ]; then
MigratetoPC
fi

if [ ${mission} == 'MigratetoTermux' ]; then
MigratetoTermux
fi


if [ ${mission} == 'trim' ]; then
trimSTG
fi

if [ ${mission} == 'exit' ]; then
exit
dialog --msgbox "Thank you for playing" 40 40
fi

menuSel

}

menuSel