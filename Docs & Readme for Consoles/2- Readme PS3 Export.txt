For exporting your game for PS3, please follow the steps below one by one on the order, follow with caution and attention, because the hardest part is to correctly setup PS3 SDK for compiling UDK for PS3.

1) Install PS3 SDK 3.00 (Found in "C:\UDKUltimate\PS3 SDK")

* Run PS3SdkInstaller.exe from the extracted folder PS3 SDK Installer:
- On the first screen click Next
- Then click on Install (Offline)
- Click on checkbox SDK 300 to select ALL components
- Set the installation folder to C:\usr\local\cell
- Always click on next and wait untill installation finishes (ignore any error messages)

* Install Playstation Egde Graphics SDK: (Found in "C:\UDKUltimate\PS3 SDK\Additional Files")

- Extract the archive [70]-edge_1_2_0.zip. Move the "cell" folder to "C:\usr\local\" and overwrite the cell folder inside there (if you receive a message asking to overwrite)

* Move the subdirectories (host-win32, SDK_doc, target) from C:\usr\local\cell\Tools\GPAD\cell to C:\usr\local\cell (overwrite)

* Copy C:\usr\local\cell\host-win32\Cg\include to C:\Program Files (x86)\SN Systems\PS3\sdk\include (overwrite)

* Copy C:\usr\local\cell\host-win32\Cg\include to C:\usr\local\cell\target\common\include (overwrite)

* Copy C:\usr\local\cell\host-win32\Cg\include to C:\usr\local\cell\host-common\include (overwrite)

* Copy C:\usr\local\cell\target\common\include\edge to C:\Program Files (x86)\SN Systems\PS3\sdk\include\edge (overwrite)

* Copy C:\usr\local\cell\host-common\include\edge to C:\Program Files (x86)\SN Systems\PS3\sdk\include\edge (overwrite)

* Copy lame_enc.dll to C:\Program Files (x86)\SCE\Multistream Tools\MSEnc (overwrite)

* Copy C:\Program Files (x86)\SCE\Multistream Tools\MSEnc to C:\usr\local\cell\host-win32\bin (overwrite)

##################################################################################

2) Start "UnrealFrontendConsoles" shortcut located at the folder "C:\UDKUltimate\UDKUltimate Desktop Shortcuts". At the left side of the screen, there is a tab called "Profile". Click on "UDK Ultimate PS3". Then on the tab "Maps to Cook", click on button "Add..." to add the maps you are going to cook. Important: As for consoles, at least the first map must have it`s name defined on the ini files for setting up a map cycle (for more information please study about gametype programming in UDK). I already setup the first map name to UDK-UDKUltimate. And for the sake of the testing, just add this "UDK-UDKUltimate" map which is a basic Third Person Template I created.

* Obs: if you see unreal frontend is not starting but appears on the taskmanager.exe, you need to shutdown ALL the PS3 SDk Services on the icon tray (SN-DBS, SN Systems and PS3 Target Manager), then restart UnrealFrontend.exe and this will work.

After added your map, click on the small black arrow at the side of the word "Start" located UNDER the first big green button at the top left of Unreal Fronten. After clicking on "Start" a drop-down menu will appear with some options. Click on "Start: Full rebuild and recook" and wait untill the cooking process finishes. If you have setup correctly the PS3 SDK, you should not receive any error messages on the cooking process. You will see a popup message saying that "Debug View are not allowed for consoles", just click on "Ok". If everything worked well, you will see a text message on green color at the bottom of Unreal Frontend saying "ALL PIPELINE STEPS COMPLETED SUCCESSFULLY".

##################################################################################

3) After the cooking process, copy the folder "CookedPS3" and the file "PS3TOC.TXT" from C:\UDKUltimate\UDKGame to the PS3 template's "UDKGAME" folder (\UDKUltimate\UDKGame PS3 Template\Build Package\TEST12345\USRDIR\UDKGAME). You can delete the old folder CookedPS3 from the template folder and paste your new folder there.

##################################################################################

4) Open the tool Advanced Renamer (\UDKUltimate\UDKGame PS3 Template\Renamer\ARen.exe). On the left select "Add Method" and select "New Case". Select "set upper case". In the main area select the green cross with "Add" and select "Directories", then pick "\UDKUltimate\UDKGame PS3 Template\Build Package\TEST12345\USRDIR\UDKGAME". It will list the files that will be set to upper case. At the top select "START BATCH" and it will rename them to be all uppercase (manually change CookedPS3 folder name to COOKEDPS3, and Movies folder name to MOVIES)

##################################################################################

5) Open PS3TOC.TXT and rename all the text inside PS3TOC.TXT to uppercase using notepad++ i.e. If there is any line of test mentioning some elf file (87425348 0 ..\Binaries\PS3\UDKGAME-PS3-SHIPPING.symbols.elf 0), delete the entire line. There may be 2 or 3 lines mentioning elf files

##################################################################################

6) Double-check everything to be sure you didn`t miss any step, then double click "b.BAT" (C:\UDKUltimate\UDKGame PS3 Template\Build Package). This will build the package for your system to install.

##################################################################################

7) Once built, transfer it to a usb drive and install it on your PS3 system with the package installer.

##################################################################################

8) Have fun playing your new PS3 game :)