INSTALLDIR="/gui"
LOGFILE="/gui/logfile"

java -jar "/client/$JAR_FILE" -d $INSTALLDIR -l $LOGFILE -G -M -R -v -s
rm -rf "/client/$JAR_FILE"
