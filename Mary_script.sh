#!/bin/bash

USERNAME="azura"
FOLDER="/home/$USERNAME/toloka_tools/speech_functions/services/toloka_dispatcher"
TIME=10

touch $FOLDER/laststep_1.log
touch $FOLDER/laststep_2.log
touch $FOLDER/laststep_3.log

while true; do
  echo "$(date)" >> $FOLDER/step_1.log
  echo "$(date)" >> $FOLDER/step_2.log
  echo "$(date)" >> $FOLDER/step_3.log

  echo "\n"

  python3 $FOLDER/step_1.py  2>&1 | tee -a $FOLDER/step_1.log  2>&1 | grep Exception  2>&1 | tee $FOLDER/laststep_1.log


  echo "\n"

  python3 $FOLDER/step_2.py  2>&1 | tee -a $FOLDER/step_2.log  2>&1 | grep Exception  2>&1 | tee $FOLDER/laststep_2.log

  echo "\n"

  python3 $FOLDER/step_3.py  2>&1 | tee -a $FOLDER/step_3.log  2>&1 | grep Exception  2>&1 | tee $FOLDER/laststep_3.log

  sh tg_notify.sh

  sleep $TIME

done
