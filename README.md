Archive indexer (Bootstrap) - Create simple HTML/CSS page with indexed files.
=============================================================================

# How to use:

  * **Available folders**:
  
    * **`files:`** For packages or applications.
    * **`scripts:`** For text files or scripts.
    * **`documents:`** For documents as ODT, PDF or DOCX.
    
  * **Steps**:
  
    * After depositing your different files in the mentioned folders, the next step is to run the indexer.
    * If you use `Linux/Unix`:
      
      ```shell
      chmod +x file-indexer.sh
      ./file-indexer.sh
      ````
      
    * If you use `Windows`:
    
      ```shell
      file-indexer.cmd
      ````
      
    * Finally, open the file **`index.html`** in your browser.

_**Note**: Files must `not contain spaces`._

# Filters:

  * If you want certain packages to be indexed with custom descriptions, you will have to edit the following filters.
  
    * `Linux/Unix`:
    
    ```shell
    - dark/filters.sh
    - light/filters.sh
    ````
    
    * `Windows`:
    
    ```shell
    - dark/filters.cmd
    - light/filters.cmd
    ````
    
# Images (Dark Theme & Light Theme):

<img src="https://raw.githubusercontent.com/q3aql/archive-indexer-bootstrap/main/dark/ico/archive-dark.png" />

<img src="https://raw.githubusercontent.com/q3aql/archive-indexer-bootstrap/main/light/ico/archive-light.png" />

### External links:

  * [Bootstrap](https://getbootstrap.com/)
  * [Ubuntu font Homepage](https://design.ubuntu.com/font/)
  * [HTML 5 Homepage](https://html.com/html5/)
