#!/bin/bash
OUT_DIR=/home/USERID/scan
TMP_DIR=`mktemp -d`
FILE_NAME=scan_`date +%Y%m%d-%H%M%S`
cd $TMP_DIR
echo "################## Scanning ###################"
scanimage --resolution 150 --batch=scan_%03d.pnm --format=pnm --mode Gray --device-name "fujitsu:ScanSnap S1500:67953" --source "ADF Duplex" --page-width 210 --page-height 297 --sleeptimer 1 -y 297 -x 210
echo "################## Cleaning ###################"
for f in ./*.pnm; do
   unpaper –size a4 –overwrite "$f" "$f"
done
echo "############## Converting to PDF ##############"
mogrify -format tif *.pnm
echo "################ Cleaning Up ################"

for f in ./*.tif; do
   tesseract "$f" "$f" -l eng hocr
   hocr2pdf -i "$f" -s -o "$f.pdf" < "$f.html"
done
pdftk *.tif.pdf cat output $FILE_NAME.pdf && rm *.tif.pdf && rm *.tif.html

wput $FILE_NAME.pdf ftp://uid:pwd@scanner.domain:21/Alfresco/scans/

cp $FILE_NAME.pdf $OUT_DIR/
cd ..
rm -rf $TMP_DIR

