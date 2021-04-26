#!/bin/bash

###########################################
# Archive - Backup file indexer           #
# Date: 30-03-2021                        #
# Author: q3aql                           #
# Contact: q3aql@protonmail.ch            #
###########################################

# Filter variables
skip_files_list="-I css -I ico -I index.html -I index.php -I src"
dir_files="../files"
dir_files_scripts="../scripts"
dir_files_documents="../documents"

# Filter variables
dirTemp="gen"
listTemp="total-files.list"
IndexerTempFolder="gen/indexer"

# Build file list
ls -1 ${skip_files_list} ${dir_files}/ > gen/list-archive-files.txt
ls -1 ${skip_files_list} ${dir_files_scripts}/ > gen/list-archive-scripts.txt
ls -1 ${skip_files_list} ${dir_files_documents}/ > gen/list-archive-documents.txt
number_files=$(wc -l gen/list-archive-files.txt | cut -d " " -f 1)
number_documents=$(wc -l gen/list-archive-documents.txt | cut -d " " -f 1)
number_scripts=$(wc -l gen/list-archive-scripts.txt | cut -d " " -f 1)

# Create initial HTML
echo ""
echo "* Creating initial HTML"
cat gen/main.html > index.html
cat gen/main-scripts.html > scripts/index.html
cat gen/main-documents.html > documents/index.html
current_date_update=$(date +%d-%m-%Y)
sed -i "s/variable-date-change-day-today/${current_date_update}/g" index.html &> /dev/null
sed -i "s/variable-date-change-day-today/${current_date_update}/g" documents/index.html &> /dev/null
sed -i "s/variable-date-change-day-today/${current_date_update}/g" scripts/index.html &> /dev/null
sed -i "s/variable-number-of-files/${number_files}/g" index.html &> /dev/null
sed -i "s/variable-number-of-files/${number_documents}/g" documents/index.html &> /dev/null
sed -i "s/variable-number-of-files/${number_scripts}/g" scripts/index.html &> /dev/null

# Function to remove extension from file
# Syntax: removeExtension "<text>"
function removeExtension() {
  wordToConvert=${1}
  IndexerSedFile="${IndexerTempFolder}/sai-indexer.txt"
  mkdir -p ${IndexerTempFolder} && chmod 777 -R ${IndexerTempFolder} 2> /dev/null
  echo "${wordToConvert}" > ${IndexerSedFile}
  # Remove extensions
  sed -i 's/-32-bits.deb//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/-64-bits.deb//g' "${IndexerSedFile}" &> /dev/null 
  sed -i 's/-32bit-build1.deb//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/-64bit-build1.deb//g' "${IndexerSedFile}" &> /dev/null 
  sed -i 's/-amd64.deb//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/-i386.deb//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/-installer.exe//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/_amd64.deb//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/_i386.deb//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/_all.deb//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/-all.deb//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/-win32.zip//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/-win64.zip//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/_win32.zip//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/_win64.zip//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/-x86_64.run//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/-x86-64.run//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/-x86.run//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/_x86_64.run//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/_x86-64.run//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/_x86.run//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/.deb//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/.txt//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/.exe//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/.msi//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/.tar.gz//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/.tar.bz2//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/.tar.xz//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/.zip//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/.7z//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/.rpm//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/.run//g' "${IndexerSedFile}" &> /dev/null
  sed -i 's/.sh//g' "${IndexerSedFile}" &> /dev/null
  # Show file without extension
  wordToConvert=$(cat ${IndexerSedFile})
  echo ${wordToConvert}
}

# Process the file list (Main Menu)
list_total_files=$(cat gen/list-archive-files.txt)
list_total_files_scripts=$(cat gen/list-archive-scripts.txt)
list_total_files_documents=$(cat gen/list-archive-documents.txt)

for file in ${list_total_files} ; do
  echo "+ Indexing the file ${file} (Packages)"
  type_format_file=$(file ${dir_files}/${file} | cut -d ":" -f 2)
  echo -n '<li class="list-group-item"><a href=' >> index.html
  echo -n '"' >> index.html
  echo -n "${dir_files}/${file}" >> index.html
  echo -n '">' >> index.html
  name_package=$(removeExtension "${file}")
  echo "${file}</a> - Package or application ${name_package} (autoindexed).</li>" >> index.html
done

for file in ${list_total_files_scripts} ; do
  echo "+ Indexing the file ${file} (Scripts)"
  echo -n '<li class="list-group-item"><a href=' >> scripts/index.html
  echo -n '"' >> scripts/index.html
  echo -n "../${dir_files_scripts}/${file}" >> scripts/index.html
  echo -n '">' >> scripts/index.html
  echo "${file}</a></li>" >> scripts/index.html
done

for file in ${list_total_files_documents} ; do
  echo "+ Indexing the file ${file} (Documents)"
  echo -n '<li class="list-group-item"><a href=' >> documents/index.html
  echo -n '"' >> documents/index.html
  echo -n "../${dir_files_documents}/${file}" >> documents/index.html
  echo -n '">' >> documents/index.html
  echo "${file}</a></li>" >> documents/index.html
done

# Apply filters
bash filters.sh

# Create the final part 
echo "* Create final HTML"
cat gen/footer.html >> index.html
cat gen/footer.html >> scripts/index.html
cat gen/footer.html >> documents/index.html
