#if defined _INC_ammo_mysql
    #endinput
#else
    #define _INC_ammo_mysql
stock SavePlayerMagazineSize(playerid)
{
    mysql_format(connectionID, queryBuffer, sizeof(queryBuffer), "UPDATE users SET magazine_0 = %i, magazine_1 = %i, magazine_2 = %i, magazine_3 = %i, magazine_4 = %i, magazine_5 = %i, magazine_6 = %i, magazine_7 = %i, magazine_8 = %i, magazine_9 = %i, magazine_10 = %i, magazine_11 = %i, magazine_12 = %i WHERE uid = %i",
	WeaponInfo[playerid][aMagazineSize][0], WeaponInfo[playerid][aMagazineSize][1], WeaponInfo[playerid][aMagazineSize][2], WeaponInfo[playerid][aMagazineSize][3], WeaponInfo[playerid][aMagazineSize][4], WeaponInfo[playerid][aMagazineSize][5], WeaponInfo[playerid][aMagazineSize][6], WeaponInfo[playerid][aMagazineSize][7], WeaponInfo[playerid][aMagazineSize][8], WeaponInfo[playerid][aMagazineSize][9], WeaponInfo[playerid][aMagazineSize][10], WeaponInfo[playerid][aMagazineSize][11], WeaponInfo[playerid][aMagazineSize][12], PlayerInfo[playerid][pID]);
	mysql_tquery(connectionID, queryBuffer);
    return 1;
}
// call this when savevariables or when player leaves server
stock SavePlayerAmmo(playerid)
{
    mysql_format(connectionID, queryBuffer, sizeof(queryBuffer), "UPDATE users SET ammo_9mm = %i, ammo_556mm = %i, ammo_12guage = %i WHERE uid = %i",AmmoInfo[playerid][aReserve][0],AmmoInfo[playerid][aReserve][1], AmmoInfo[playerid][aReserve][2], PlayerInfo[playerid][pID]);
	mysql_tquery(connectionID, queryBuffer);
    return 1;
}
stock SavePlayerMagazine(playerid)
{
    mysql_format(connectionID, queryBuffer, sizeof(queryBuffer), "UPDATE users SET ext_magazine = %i, drum_magazine = %i WHERE uid = %i", AmmoInfo[playerid][aMagazine][0],AmmoInfo[playerid][aMagazine][1], PlayerInfo[playerid][pID]);
	mysql_tquery(connectionID, queryBuffer);
    return 1;
}

