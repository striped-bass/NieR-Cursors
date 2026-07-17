#!/usr/bin/bash

printf -v date '%(%Y-%m-%d)T'

git tag ${date}

cd icons/
zip -q ../NieR_Cursors_Windows_${date}.zip nier_cursors_windows/*
tar -caf ../NieR_Cursors_${date}.tar.xz nier_cursors

# Create hyprcursor theme
cd ..
x2wincurtheme icons/nier_cursors/cursors -n nier_cursors -o NieR_Cursors_${date}_Windows/
mkdir -p NieR_Cursors_${date}_XCursor/cursors
win2xcurtheme NieR_Cursors_${date}_Windows/install.inf -o NieR_Cursors_${date}_XCursor/cursors
hyprcursor-util --extract NieR_Cursors_${date}_XCursor
mkdir -p NieR_Cursors_${date}_Hyprcursor
hyprcursor-util --create extracted_NieR_Cursors_${date}_XCursor -o NieR_Cursors_${date}_Hyprcursor
mv "NieR_Cursors_${date}_Hyprcursor/theme_Extracted Theme" "NieR_Cursors_${date}_Hyprcursor/nier_cursors"
rm "NieR_Cursors_${date}_Hyprcursor/nier_cursors/manifest.hl"
echo "name = NierTheme
description = Hyprcursor theme based on NieR Automata 
release = ${date}
cursors_directory = hyprcursors" > NieR_Cursors_${date}_Hyprcursor/nier_cursors/manifest.hl

# Clean up
rm -r NieR_Cursors_${date}_Windows/
rm -r NieR_Cursors_${date}_XCursor
rm -r extracted_NieR_Cursors_${date}_XCursor/