#if defined _ammo_callbacks_included
    #endinput
#endif
#define _ammo_callbacks_included

stock OnPlayerGiveWeapon(playerid ,i)
{
    WeaponInfo[playerid][aMagazineSize][i] = 0;
    WeaponInfo[playerid][aAmmo][i] = 0;
    SyncWeaponData(playerid);
}
stock GetPlayerWeaponId(playerid)
{
    if(AttachedWeapon[playerid] == 0) return 0;
    new weaponid = AttachedWeapon[playerid];
    return weaponid;
}
// call each time when player removes weapon or gives weapon
stock SyncWeaponData(playerid)
{
    
    LastWeapon[playerid] = 0;
    ValidWeapons[playerid] = 0;

    for(new i = 0; i < 13; i++)
    {
        if(WeaponInfo[playerid][aWeapons][i] == 0) continue;

        SetDefaultWeaponInfo(playerid, i);
        Shots[playerid][i] = 0;
        WeaponInfo[playerid][aReloadDone][i] = false;
        WeaponInfo[playerid][aStandardMag][i] = GetWeaponStandardMagSize(WeaponInfo[playerid][aWeapons][i]);
    }
    //SavePlayerMagazineSize(playerid);
    SynchronizeWeaponSlot(playerid);
    return 1;
}

stock SynchronizeWeaponSlot(playerid)
{
    new slot[13];
    new slotid[13];
    new count = 0;

    // Direct 0-indexed loop mapping valid weapons
    for(new i = 0; i < 13; i++)
    {
        new weaponid = WeaponInfo[playerid][aWeapons][i];
        if(weaponid == 0) continue;

        slot[count] = GetWeaponSlotAmmo(weaponid);
        slotid[count] = weaponid;
        count++;
    }

    ValidWeapons[playerid] = count;
    ParallelSort(slot, slotid, count, playerid);
    return 1;
}

stock ParallelSort(slot[], slotid[], size, playerid)
{
    new temp1, temp2;

    // Clear ClientWeaponSlot map before assignment
    for(new c = 0; c < 13; c++)
    {
        ClientWeaponSlot[playerid][c] = 0;
    }

    // Bubble sort ascending order
    for (new i = 0; i < size - 1; i++)
    {
        for (new j = 0; j < size - i - 1; j++)
        {
            if (slot[j] > slot[j + 1])
            {
                temp1 = slot[j];
                slot[j] = slot[j + 1];
                slot[j + 1] = temp1;

                temp2 = slotid[j];
                slotid[j] = slotid[j + 1];
                slotid[j + 1] = temp2;
            }
        }
    }

    for (new i = 0; i < size; i++)
    {
        ClientWeaponSlot[playerid][i] = slotid[i];
    }
    return 1;
}
new const WeaponModelIDs[] = {
	0, 331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324,
	325, 326, 342, 343, 344, 0, 0, 0, 346, 347, 348, 349, 350, 351, 352,
	353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366,
	367, 368, 368, 371
};
stock SetDefaultWeaponInfo(playerid, i)
{
    new weaponid = WeaponInfo[playerid][aWeapons][i];
    WeaponInfo[playerid][aWeaponObj][i] = WeaponModelIDs[weaponid];
    switch(WeaponInfo[playerid][aWeapons][i])
    {
        case 22: // 9mm pistol
        {
            WeaponInfo[playerid][aAmmoType][i] = 0;
        }
        case 23: // Silenced 9mm pistol
        {
            WeaponInfo[playerid][aAmmoType][i] = 0;
        }
        case 24: // Desert Eagle
        {
            WeaponInfo[playerid][aAmmoType][i] = 0;
        }
        case 26: // Sawnoff shotgun
        {
            WeaponInfo[playerid][aAmmoType][i] = 2;
        }
        case 27: // SPAS-12
        {
            WeaponInfo[playerid][aAmmoType][i] = 2;
        }
        case 28: // Micro UZI
        {
            WeaponInfo[playerid][aAmmoType][i] = 1;
        }
        case 29: // MP5
        {
            WeaponInfo[playerid][aAmmoType][i] = 1;
        }
        case 30: // AK-47
        {
            WeaponInfo[playerid][aAmmoType][i] = 1;
        }
        case 31: // M4
        {
            WeaponInfo[playerid][aAmmoType][i] = 1;
        }
        case 32: // Tec-9
        {
            
            WeaponInfo[playerid][aAmmoType][i] = 1;
        }
    }
    new magazinetype = 3;
    for(new j = 0; j <=2 ;j++)
    {
        if(MagazineInfo[weaponid][j] == WeaponInfo[playerid][aMagazineSize][i]){
            magazinetype = j;
            break;
        }
    } 
    if(magazinetype == 2){
        magazinetype = -1;
    }
    WeaponInfo[playerid][aMagazineAttached][i] = magazinetype;
    if(WeaponInfo[playerid][aMagazineSize][i] == 0)
    {
        WeaponInfo[playerid][aMagazineSize][i] = MagazineInfo[weaponid][2];
        WeaponInfo[playerid][aMagazineAttached][i] = -1;
    }
}
stock SetMagazine(playerid,i)
{
    if(WeaponInfo[playerid][aMagazineAttached][i] == 0){
    new weaponid = WeaponInfo[playerid][aWeapons][i];
    WeaponInfo[playerid][aMagazineSize][i] = MagazineInfo[weaponid][0];
    }
    if(WeaponInfo[playerid][aMagazineAttached][i] == 1){
    new weaponid = WeaponInfo[playerid][aWeapons][i];
    WeaponInfo[playerid][aMagazineSize][i] = MagazineInfo[weaponid][1];
    }
    SetMagazineTD(playerid,WeaponInfo[playerid][aMagazineSize][i]);
    SavePlayerMagazineSize(playerid);

}

stock GetWeaponStandardMagSize(weaponid)
{
    switch(weaponid)
    {
        case 22, 23: return 17;
        case 26: return 2;
        case 24, 27: return 7;
        case 28, 31, 32: return 50;
        case 29, 30: return 30;
    }
    return 0;
}
stock OnplayerRemoveGun(playerid,i)
{
    RemoveWeaponObject(playerid);
    AttachedWeapon[playerid] = 0;
    WeaponInfo[playerid][aMagazineSize][i] = 0;
    if(WeaponInfo[playerid][aMagazineAttached][i] != -1)
    {
        AmmoInfo[playerid][aMagazine][WeaponInfo[playerid][aMagazineAttached][i]]++;
    }
    SyncWeaponData(playerid);
}
stock GetWeaponSlotAmmo(weaponid)
{
    switch(weaponid)
    {
        case 0, 1,19,20,21: return 0; // Unarmed / Brass Knuckles
        case 2..9: return 1; // Melee
        case 22..24: return 2; // Handguns
        case 25..27: return 3; // Shotguns
        case 28, 29, 32: return 4; // SMG
        case 30, 31: return 5; // Assault Rifles
        case 33,34: return 6; // Rifles
        case 35..38: return 7; // Heavy
        case 16..18,39: return 8; // Explosives
        case 41..43: return 9; // Special 1
        case 44..46: return 10; // Special 2
        case 10..15: return 10; // Gifts
        case 40: return 12; // Detonator
    }
    return 0;
}

stock OnPlayerbuyAmmo(playerid,ammo,ammotype)
{
    AmmoInfo[playerid][aReserve][ammotype] += ammo;
    SendClientMessage(playerid, -1, "%i and %i.",AmmoInfo[playerid][aReserve][ammotype],ammotype);
    SavePlayerAmmo(playerid);
    SetPlayerArmedWeapon(playerid, 0);
    return 1;
}