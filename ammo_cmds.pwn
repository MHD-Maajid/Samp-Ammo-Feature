/*
 ****************************************************************
 *  ___________________________________________________________ *
 * |                         INFORMATION                       |*
 * |___________________________________________________________|*
 * |                                                           |*
 * |   [Module]: "ammo-system commands"                        |*
 * |   [Developer]: "Simon"   (devil</>)                       |*
 * |   [Scripts Date]: "23/08/2026"                            |*
 * |   [Version]: "OMP"                                        |*
 * |___________________________________________________________|*
 *                                                              *
 *                  For inquiries, contact:                     *
 *                 [maajidbiz@gmail.com]                        *
 *                                                              *
 ****************************************************************
*/

#if defined _ammo_cmds_included
    #endinput
#endif
#define _ammo_cmds_included
CMD:setcustommagazine(playerid, params[])
{
    new id, weaponid, magazinesize;
    if(!PlayerInfo[playerid][pDynamicAdmin])
	{
	    return SendClientMessage(playerid, COLOR_SYNTAX, "You are not authorized to use this command.");
	}
    if(sscanf(params, "iii", id, weaponid,magazinesize))
	{
	    SendClientMessage(playerid, COLOR_GREY2, "Usage: /setcustommagazine [id] [weaponid] [magazineSize]");
	    return 1;
	}
    new currentSlot = -1;
    for (new i = 0; i < 13; i++)
    {
        if (WeaponInfo[id][aWeapons][i] == weaponid)
        {
            SendClientMessage(playerid, COLOR_GREY2, "%s have %i [%i] weapon to give magazine",GetRPName(id),weaponid,i);
            currentSlot = i;
            break;
        }
    }
    if(currentSlot == -1)
    {
       
        SendClientMessage(playerid, COLOR_GREY2, "%s doesn't have [%i] weapon to give magazine",GetRPName(id),weaponid);
	    return 1;
    }
    if(WeaponInfo[id][aMagazineSize][currentSlot] == 0)
    {
        SendClientMessage(playerid, COLOR_GREY2, "Thie Weapon Doesn't Support Any Magazines");
	    return 1;
    }
    WeaponInfo[id][aMagazineSize][currentSlot] = magazinesize;
    SendClientMessage(playerid, COLOR_GREY2, "you have given %s's [%i] magazine size to %i ",GetRPName(id),weaponid,magazinesize);
    SendClientMessage(id, COLOR_GREY2, "%s has set your [%i] magazine size to %i ",GetRPName(playerid),weaponid,magazinesize);
    SavePlayerMagazineSize(id);
    SetMagazineTD(playerid, magazinesize);
	return 1;

}
CMD:changemagazine(playerid , params[])
{
    new weaponid = GetPlayerWeapon(playerid),id;
    new slot = 0;
    if (weaponid == 0)
    {
        weaponid = GetPlayerWeaponId(playerid);
    }
	for(new i = 0; i < 13; i++)
    {
        if(weaponid == WeaponInfo[playerid][aWeapons][i]) {
           slot = i;
           break; 
        }
        if(i == 12){
            weaponid = 0;
        }
    }
    if(sscanf(params, "i", id))
	{
	    SendClientMessage(playerid, COLOR_SYNTAX, "Usage: /changemagazine [type]");
        SendClientMessage(playerid, COLOR_GREY2, "LIST : (0) Extended-Magazine, (1) Drum-Magazine, (2) Normal-Magazine ");
	    return 1;
	}
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
	{
	    return SendClientMessage(playerid, COLOR_SYNTAX, "You need to be onfoot in order to Change-Magazine.");
	}
    if(id < 0 || id > 2 )
    {
        SendClientMessage(playerid, COLOR_SYNTAX, "Usage: /changemagazine [type]");
        SendClientMessage(playerid, COLOR_GREY2, "LIST : (0) Extended-Magazine, (1) Drum-Magazine, (2) Normal-Magazine ");
	    return 1;
    }
	if(weaponid == 0)
	{
	    return SendClientMessage(playerid, COLOR_SYNTAX, "You must be holding the weapon to change magazine.");
	}
    if(PlayerInfo[playerid][pTazedTime] > 0 || PlayerInfo[playerid][pInjured] > 0 || PlayerInfo[playerid][pHospital] > 0 || PlayerInfo[playerid][pTied] > 0 || PlayerInfo[playerid][pCuffed] > 0 || PlayerInfo[playerid][pJailTime] > 0 || PlayerInfo[playerid][pJoinedEvent] > 0 || PlayerInfo[playerid][pPaintball] > 0 || PlayerInfo[playerid][pDueling] != INVALID_PLAYER_ID)
	{
	    return SendClientMessage(playerid, COLOR_SYNTAX, "You can't use this command at the moment.");
	}
    new MagazineAttached = WeaponInfo[playerid][aMagazineAttached][slot];
    new magazineSize = WeaponInfo[playerid][aMagazineSize][slot];
    if(MagazineAttached == 3)
    {
        return SendClientMessage(playerid, COLOR_SYNTAX, "You can't use this command at this moment this function is under devlopment (drop your gun to changemagazine).");
    }

    switch(id)
	{
        case 0:{
            if(WeaponInfo[playerid][aMagazineAttached][slot] == 0){
                return SendClientMessage(playerid, COLOR_SYNTAX, "You Are Already Using Extended Magazine.");
            }
            if(AmmoInfo[playerid][aMagazine][0] == 0){

                return SendClientMessage(playerid, COLOR_SYNTAX, "You don't have any extended magazine.");
            }
            else{
                WeaponInfo[playerid][aMagazineAttached][slot] = 0;
                SetMagazine(playerid,slot);
            }
        }
        case 1:{
            if(WeaponInfo[playerid][aMagazineAttached][slot] == 1){
                return SendClientMessage(playerid, COLOR_SYNTAX, "You Are Already Using Drum Magazine.");
            }
            if(AmmoInfo[playerid][aMagazine][1] == 0){

                return SendClientMessage(playerid, COLOR_SYNTAX, "You don't have any drum magazine.");
            }
            else{
                WeaponInfo[playerid][aMagazineAttached][slot] = 1;
                SetMagazine(playerid,slot);
            }
        }
        case 2:{
            if(WeaponInfo[playerid][aMagazineAttached][slot] == -1){
                return SendClientMessage(playerid, COLOR_SYNTAX, "You Are Already Using Standard Magazine.");
            }else{
                WeaponInfo[playerid][aMagazineSize][slot] = 0;
                AmmoInfo[playerid][aMagazine][WeaponInfo[playerid][aMagazineAttached][slot]]++;
                WeaponInfo[playerid][aMagazineAttached][slot] = -1;
                SetDefaultWeaponInfo(playerid,slot);
                SetMagazineTD(playerid, WeaponInfo[playerid][aMagazineSize][slot]);
                SendClientMessage(playerid, COLOR_GREEN, "You have been added new magazine to the weapon now the magazine size of weapon is %i.", WeaponInfo[playerid][aMagazineSize][slot]);
                APlayReloadAnimation(playerid, weaponid, slot);
                return 1;
            }
        }
    }
    if(WeaponInfo[playerid][aMagazineSize][slot] == magazineSize )
    {
        WeaponInfo[playerid][aMagazineAttached][slot] = MagazineAttached;
        return SendClientMessage(playerid, COLOR_SYNTAX, "Your holding weapon can't add selected magazine.");
    }
    else
    {
        if(id == 2) return 1;
        AmmoInfo[playerid][aMagazine][id]--;
        WeaponInfo[playerid][aAmmo][slot] = 0;
        SavePlayerMagazine(playerid);
        SavePlayerMagazineSize(playerid);
        SetMagazineTD(playerid, WeaponInfo[playerid][aMagazineSize][slot]);
        SendClientMessage(playerid, COLOR_GREEN, "You have been added new magazine to the weapon now the magazine size of weapon is %i.", WeaponInfo[playerid][aMagazineSize][slot]);
        APlayReloadAnimation(playerid, weaponid, slot);
        return 1;
    }

}