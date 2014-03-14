doxie-applescript
=================

This AppleScript is used to automatically process images coming from a Doxie scanner without user intervention. 

The Doxie program does not correctly date stamp images, so this does the next best thing. Best used with the Eye-Fi card and a folder action, it will open the Doxie.app and save as a PDF with OCR to a specific folder (e.g. Dropbox, Google Drive).

I am not a professional software developer, so this script could use some refinements, the code cleaned up, or an entirely new approach. If you make any enhancements, please share!

Enjoy!


Installation:

1. Open the file DoxieProcessScript.scpt in a text editor.

2. Change the path variables at the top of the script to match the folders you want to use. 

3. Put the file DoxieProcessScript.scpt somewhere on your computer where you won't move it. I suggest "/Users/<yourusername>/Library/Workflows/Applications/Folder Actions/"

4. Open Automator.

5. Create a new Folder Action.

6. At the very top, set "Folder Action received files and folders added to" to  ~/Pictures/DoxieEye-Fi.

7. Add the action "Run AppleScript" from the library on the left to the main window on the right.

8. Put the code: 

run script ("/path-to-your-script" as POSIX file)

in the Folder Action. E.g. 

run script ("/Users/username/Library/Workflows/Applications/Folder Actions/DoxieProcessScript.scpt" as POSIX file)

9. Save everything.

10. Launch the program 'Folder Actions Setup" to double check the folder action is currently enabled.
