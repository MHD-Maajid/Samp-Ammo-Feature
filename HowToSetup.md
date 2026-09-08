* **Include** - include core file after creating variable connectionid and penum and before major publics and cmd.

* **Data's** - i have only added data's saving system in includes, you have to take data's from database and create database structure

* **SyncWeaponData** - its a crucial function call this function everytime a player join server after taking data's from DB

* **OnPlayerGiveWeapon** -  When player recieve new weapon or gives weapon search function like GiveWeapon and call this function on it

* **OnplayerRemoveGun** - when a player drops or give weapon search function like RemovePlayerWeaponEx and call this function on it

* **portability** - i have used some gamemode defined variables across the module in mysql and some other functions but the variables are available in every gamemodes please check wether you included before and the name of variable isn't miss-matching

* **OnPlayerSwitchWeapon** - when a player switches weapon check it on OnPlayerUpdate checking of weapon change maybe already exist in your gamemode otherwise create it and call

* **SavePlayerAmmo** - call when a player leaves the server and on saveplayervariable and when player buys or crafts ammo

* **SavePlayerMagazine** - call when player buys magazine.

* **SavePlayerMagazineSize** - call when player Lefts server.

* **ammo&Magazine** - create a system to purchase or craft ammo & magazine.

* **Textdraw** - add textdraw to gamemode, and call ShowPlayerWeaponTd & HideTDWeapon once when player is not in vehicle and calls when player exists from vehicle and call HideWeaponTD when enters to vehicle.

* **GetPlayerWeaponId** - call this to give weaponid to dropgun and give gun call this function inside GetScriptWeapon or suitable function in your script

* **GetScriptWeapon** - call when player left the game.

* **PB-Ammo** - for better experience set unlimited ammo in paintball.

* **Not-For-Use** - this script is under maintenence and testing phase , after improving quality , optimisation and ensuring its bug free you can use with the permission of devloper (simon</>).