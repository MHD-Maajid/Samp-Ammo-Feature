#if defined _ammo_functions_included
    #endinput
#endif
#define _ammo_functions_included

#define ATTACH_INDEX 5

/*
 ****************************************************************
 *  ___________________________________________________________ *
 * |                         INFORMATION                       |*
 * |___________________________________________________________|*
 * |                                                           |*
 * |   [Module]: "ammo-system functions"                       |*
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


stock CheckAmmo(playerid,weaponid, currentSlot)
{
    if(WeaponInfo[playerid][aAmmo][currentSlot] <= 0)
    {
        if(WeaponInfo[playerid][aReloadDone][currentSlot])
        return 1;
        new ammoType = WeaponInfo[playerid][aAmmoType][currentSlot];
        new reserveAmmo = AmmoInfo[playerid][aReserve][ammoType];

        if(reserveAmmo <= 0)
        {
            RemoveWeaponObject(playerid);
            WeaponObject(playerid, currentSlot);
            return 1;
        }
        else
        {
            APlayReloadAnimation(playerid, weaponid , currentSlot);
        }
    }
    return 1;
}
stock RemoveWeaponObject(playerid)
{
    if(IsPlayerAttachedObjectSlotUsed(playerid, ATTACH_INDEX))
    {
        RemovePlayerAttachedObject(playerid, ATTACH_INDEX);

    }
    return 1;
}

stock WeaponObject(playerid, slot)
{
    AttachedWeapon[playerid] = WeaponInfo[playerid][aWeapons][slot];
    
    SetPlayerAttachedObject(
        playerid, 
        ATTACH_INDEX,
        WeaponInfo[playerid][aWeaponObj][slot],         
        6, // Right Hand
        -0.01, 0.01, -0.003,
        12.5, -1.6, 2.3,
        1.0, 1.0, 1.0
    );

    SetPlayerArmedWeapon(playerid, 0);
    return 1;
}
stock APlayReloadAnimation(playerid, weaponid, i)
{
    new duration = 2000;
    WeaponInfo[playerid][aReloadDone][i] = true;
    new ammoType = WeaponInfo[playerid][aAmmoType][i];
    new reserveAmmo = AmmoInfo[playerid][aReserve][ammoType];
    new magSize = WeaponInfo[playerid][aMagazineSize][i];
    if(magSize == 0){
        RemoveWeaponObject(playerid);
        AttachedWeapon[playerid] = 0;
        return 1;
    }
    new ammoloaded;
    for(new l=0; l < 13; l++)
    {
        if(WeaponInfo[playerid][aAmmoType][l] == ammoType)
        {
            ammoloaded+=WeaponInfo[playerid][aAmmo][l];
        }
    }
    reserveAmmo -= ammoloaded;
    if(reserveAmmo <= 0)
    {
        WeaponInfo[playerid][aReloadDone][i] = false;
        WeaponObject(playerid, i);
        return 0;
    }
    new ammoToLoad = 0;

    if(reserveAmmo >= magSize)
    {
        ammoToLoad = magSize;
    }
    else
    {
        ammoToLoad = reserveAmmo;
    }

    switch(weaponid)
    {
        case 22: { ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.0, 0, 0, 0, 0, 0); duration = 1000; }
        case 23: { ApplyAnimation(playerid, "SILENCED", "Silence_reload", 4.0, 0, 0, 0, 0, 0); duration = 1000; }
        case 24: { ApplyAnimation(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0); duration = 1000; }
        case 25, 27: { ApplyAnimation(playerid, "BUDDY", "buddy_reload", 4.0, 0, 0, 0, 0, 0); duration = 1200; }
        case 26: { ApplyAnimation(playerid, "COLT45", "sawnoff_reload", 4.0, 0, 0, 0, 0, 0); duration = 1200; }
        case 29..31, 33, 34: { ApplyAnimation(playerid, "RIFLE", "rifle_load", 4.0, 0, 0, 0, 0, 0); duration = 1500; }
        case 28, 32: { ApplyAnimation(playerid, "TEC", "tec_reload", 4.0, 0, 0, 0, 0, 0); duration = 1400; }
    }
    SetTimerEx("ReloadDone", duration, false, "iiiii", playerid, i, weaponid, ammoToLoad, ammoloaded);
    return 1;
}

forward ReloadDone(playerid, slot, weaponid, ammo, ammoloaded);

public ReloadDone(playerid, slot, weaponid, ammo, ammoloaded)
{
    if(!WeaponInfo[playerid][aReloadDone][slot]) return 1;
    if(IsPlayerAttachedObjectSlotUsed(playerid, ATTACH_INDEX))
    {
        RemovePlayerAttachedObject(playerid, ATTACH_INDEX);
    }
    new ammoType = WeaponInfo[playerid][aAmmoType][slot];
    new reserveAmmo = AmmoInfo[playerid][aReserve][ammoType];
    reserveAmmo -= ammo;
    SetAmmoReserveTD(playerid,reserveAmmo,slot);
    WeaponInfo[playerid][aAmmo][slot] = ammo;
    WeaponInfo[playerid][aReloadDone][slot] = false;
    Shots[playerid][slot] ++;
    PlayerTextDrawColour(playerid, WeaponTD[playerid][2], -1);
    SetAmmoTD(playerid,ammo);
    GivePlayerWeapon(playerid, weaponid, ammo);
    SetPlayerArmedWeapon(playerid, weaponid);
    return 1;
}

