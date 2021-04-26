@echo off

rem ###########################################
rem # Archive - Backup file indexer           #
rem # Date: 30-03-2021                        #
rem # Author: q3aql                           #
rem # Contact: q3aql@protonmail.ch            #
rem ###########################################

rem # Filter variables
set skip_files_list="-I css -I ico -I index.html -I index.php -I src"
set dir_files=..\files
set dir_files_scripts=..\scripts
set dir_files_documents=..\documents

rem # Filter variables
set dirTemp=gen
set listTemp=total-files.list
set IndexerTempFolder=gen\indexer

rem # Create initial HTML
echo.
echo * Creating initial HTML
type gen\main-win.html > index.html
type gen\main-scripts-win.html > scripts\index.html
type gen\main-documents-win.html > documents\index.html

rem # Build file list
dir /B %dir_files% > gen\list-archive-files.txt
dir /B %dir_files_scripts% > gen\list-archive-scripts.txt
dir /B %dir_files_documents% > gen\list-archive-documents.txt

rem # Count files
type gen\list-archive-documents.txt | find /v "" /c > gen\count-archive-documents.txt
type gen\list-archive-scripts.txt | find /v "" /c > gen\count-archive-scripts.txt
type gen\list-archive-files.txt | find /v "" /c > gen\count-archive-files.txt
set /p number_files=<gen\count-archive-files.txt
set /p number_documents=<gen\count-archive-documents.txt
set /p number_scripts=<gen\count-archive-scripts.txt

rem # Set latest update
echo ^<div class="mb-2 alert alert-dark"^> >> index.html
echo The last update was on %date% (%number_files% packages). >> index.html
echo ^</div^> >> index.html
echo ^<ul class="list-group"^> >> index.html

rem # Set latest update (documents)
echo ^<div class="mb-2 alert alert-dark"^> >> documents\index.html
echo The last update was on %date% (%number_documents% documents). >> documents\index.html
echo ^</div^> >> documents\index.html
echo ^<ul class="list-group"^> >> documents\index.html

rem # Set latest update (scripts)
echo ^<div class="mb-2 alert alert-dark"^> >> scripts\index.html
echo The last update was on %date% (%number_scripts% scripts). >> scripts\index.html
echo ^</div^> >> scripts\index.html
echo ^<ul class="list-group"^> >> scripts\index.html

rem # Index files from files folder
for /F %%f in (gen\list-archive-files.txt) do (
echo + Indexing the file %%f
echo ^<li class="list-group-item"^>^<a href="%dir_files%\%%f"^>%%f^</a^> - Package or application %%f ^(autoindexed^)^.^</li^> >>index.html
)

rem # Index files from scripts folder
for /F %%f in (gen\list-archive-scripts.txt) do (
echo + Indexing the file %%f
echo ^<li class="list-group-item"^>^<a href="..\%dir_files_scripts%\%%f"^>%%f^</a^>^</li^> >> scripts\index.html
)

rem # Index files from documents folder
for /F %%f in (gen\list-archive-documents.txt) do (
echo + Indexing the file %%f
echo ^<li class="list-group-item"^>^<a href="..\%dir_files_documents%\%%f"^>%%f^</a^>^</li^> >> documents\index.html
)

rem # Apply filters
call filters.cmd

rem # Create the final part 
echo * Create final HTML
type gen\footer.html >> index.html
type gen\footer.html >> scripts\index.html
type gen\footer.html >> documents\index.html

