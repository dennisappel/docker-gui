JAR="$1"
INSTALLDIR="/gui"
LOGFILE="/gui/logfile"

java -jar "/client/$JAR" -d $INSTALLDIR -l $LOGFILE -G -M -R -v -s
rm -rf "/client/$JAR"
