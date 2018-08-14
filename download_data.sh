#!/bin/sh


https://cloud9.cs.fau.de/index.php/s/46qcNZSNePHx08A  

下面网址已经失效 
wget http://lgdv.cs.fau.de/uploads/publications/data/innmann2016deform/umbrella_data.zip
mkdir -p data/umbrella/depth
mkdir -p data/umbrella/color

mv umbrella_data.zip data/umbrella
cd data/umbrella
unzip umbrella_data.zip
rm *.txt
mv *color*.png color/
mv *depth*.png depth/
rm umbrella_data.zip

