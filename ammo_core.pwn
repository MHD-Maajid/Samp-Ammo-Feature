
/*
 ****************************************************************
 *  ___________________________________________________________ *
 * |                         INFORMATION                       |*
 * |___________________________________________________________|*
 * |                                                           |*
 * |   [Module]: "ammo-system Core"                            |*
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


#if defined _ammo_core_included
    #endinput
#endif
#define _ammo_core_included

#include <YSI_Coding/y_hooks>       


//#define DISCORD_DEBUG 

#include "modules/weapon_ammo/ammo_header.pwn"
#include "modules/weapon_ammo/ammo_mysql.pwn"
#include "modules/weapon_ammo/ammo_td.pwn"
#include "modules/weapon_ammo/ammo_functions.pwn"
#include "modules/weapon_ammo/ammo_cmds.pwn"
#include "modules/weapon_ammo/ammo_callbacks.pwn"


#include <weapon-config>
hook OnPlayerConnect(playerid) {
    AttachedWeapon[playerid] = 0;
    TDShow[playerid] = false;
    WeaponWarning[playerid] = 0;
    ValidWeapons[playerid] = 0;
    for(new i = 0; i < 13; i++){
        WeaponInfo[playerid][aAmmo][i] = 0;
        WeaponInfo[playerid][aAmmoType][i] = -1;
    }
}
hook OnGameModeInit() {
    
    // 2 is the standard magazine never set this as zero
    MagazineInfo[22][2] = 12;
    MagazineInfo[23][2] = 12;
    MagazineInfo[24][2] = 7;
    MagazineInfo[26][2] = 2;
    MagazineInfo[27][2] = 7;
    MagazineInfo[28][2] = 40;
    MagazineInfo[29][2] = 30;
    MagazineInfo[30][2] = 30;
    MagazineInfo[31][2] = 40;
    MagazineInfo[32][2] = 40;
// 0 is the extended magazine never set this as equal to standard or drum
    MagazineInfo[22][0] = 20;
    MagazineInfo[23][0] = 20;
//    MagazineInfo[24][0] = 7;
//    MagazineInfo[26][0] = 2;
    MagazineInfo[27][0] = 10;
    MagazineInfo[28][0] = 50;
    MagazineInfo[29][0] = 40;
    MagazineInfo[30][0] = 40;
    MagazineInfo[31][0] = 50;
    MagazineInfo[32][0] = 50;
// 1 is the drum magazine never set this as equal to standard or extended
//    MagazineInfo[22][1] = 20;
//    MagazineInfo[23][1] = 20;
//    MagazineInfo[24][1] = 7;
//    MagazineInfo[26][1] = 2;
//    MagazineInfo[27][1] = 10;
    MagazineInfo[28][1] = 60;
    MagazineInfo[29][1] = 50;
    MagazineInfo[30][1] = 50;
    MagazineInfo[31][1] = 60;
    MagazineInfo[32][1] = 60;
    new colorStr1[] = "00FF00FF";
    new colorInt;

    //converting to decimal to add in textdraw
    sscanf(colorStr1, "x", colorInt); 
    Tdcolor[0] = colorInt;
    new colorStr2[] = "FF9900FF";
    colorInt = 0;

    //converting to decimal to add in textdraw
    sscanf(colorStr2, "x", colorInt); 
    Tdcolor[1] = colorInt;

    new colorStr3[] = "FF0000FF";
    colorInt = 0;

    //converting to decimal to add in textdraw
    sscanf(colorStr3, "x", colorInt); 
    Tdcolor[2] = colorInt;
    return 1;

}
// calls when previuos weapon is different from new weapon call this from public onplayerupdate checking weapon change
stock OnPlayerSwitchWeapon(playerid,prevweaponid, weaponid)
{
    if(weaponid == 0 && AttachedWeapon[playerid] == 0){
        HideTDWeapon(playerid);
        return 1;
    }

    if (weaponid == 0|| weaponid == 46 || weaponid == 1)
        return 1;
    
    if (AttachedWeapon[playerid] > 0)
    {

        new nextweapon = 0;
        if(ClientWeaponSlot[playerid][ValidWeapons[playerid]-1] == weaponid)
        {
        for (new i = 0; i < ValidWeapons[playerid]; i++)
        {
            if (ClientWeaponSlot[playerid][i] == AttachedWeapon[playerid])
            {
                if (i - 1 >= 0)
                {
                    nextweapon = ClientWeaponSlot[playerid][i - 1];
                    if (nextweapon == LastWeapon[playerid])
                    {
                        i--;
                        if (i - 1 >= 0)
                        {
                            nextweapon = ClientWeaponSlot[playerid][i -1];
                        }
                        else
                        {
                            nextweapon = 0;
                        }
                    }
                }
                else
                {
                    nextweapon = 0;
                }
                break;
            }
        }
        }
        else{
        for (new i = 0; i < ValidWeapons[playerid]; i++)
        {
            if (ClientWeaponSlot[playerid][i] == AttachedWeapon[playerid])
            {
                if (i + 1 < ValidWeapons[playerid])
                {
                    nextweapon = ClientWeaponSlot[playerid][i + 1];
                    if (nextweapon == LastWeapon[playerid])
                    {
                        i++;
                        if (i + 1 < ValidWeapons[playerid])
                        {
                            nextweapon = ClientWeaponSlot[playerid][i + 1];
                        }
                        else
                        {
                            nextweapon = ClientWeaponSlot[playerid][i - 1];
                        }
                    }
                }
                else
                {
                    nextweapon = 0;
                }
                break;
            }
        }
        }
        RemoveWeaponObject(playerid);
        AttachedWeapon[playerid] = 0;

        SetPlayerArmedWeapon(playerid, nextweapon);
        LastWeapon[playerid] = nextweapon;
        if (nextweapon != 0)
        {
            for (new slot = 0; slot < 13; slot++)
            {
                if (WeaponInfo[playerid][aWeapons][slot] == nextweapon)
                {
                    new ObjectId = WeaponInfo[playerid][aWeaponObj][slot];
                    SetPlayerWeaponTd(playerid,ObjectId);
                    SetAmmoReserveTD(playerid,AmmoInfo[playerid][aReserve][WeaponInfo[playerid][aAmmoType][slot]],slot);
                    SetAmmoTD(playerid,WeaponInfo[playerid][aAmmo][slot]);
                    SetMagazineTD(playerid,WeaponInfo[playerid][aMagazineSize][slot]);
                    CheckAmmo(playerid, nextweapon, slot);
                    break;
                }
            }
        }

        return 1;
    }

    // Find the custom slot for the selected weapon.
    new currentSlot = -1;
    for (new i = 0; i < 13; i++)
    {
        if (WeaponInfo[playerid][aWeapons][i] == prevweaponid)
        {
            if(WeaponInfo[playerid][aReloadDone][i]) SetPlayerArmedWeapon(playerid,prevweaponid);
        }
    }
    for (new i = 0; i < 13; i++)
    {
        if (WeaponInfo[playerid][aWeapons][i] == weaponid)
        {
            currentSlot = i;
            new ObjectId = WeaponInfo[playerid][aWeaponObj][i];
            if (ObjectId == 0) {
                HideTDWeapon(playerid);
                break;
            }
            if (WeaponInfo[playerid][aAmmoType][i] == -1)
            {
                SetPlayerWeaponTd(playerid,ObjectId);
                SetValue0(playerid);
                break;
            }
            SetPlayerWeaponTd(playerid,ObjectId);
            SetAmmoReserveTD(playerid,AmmoInfo[playerid][aReserve][WeaponInfo[playerid][aAmmoType][i]],i);
            SetAmmoTD(playerid,WeaponInfo[playerid][aAmmo][i]);
            SetMagazineTD(playerid,WeaponInfo[playerid][aMagazineSize][i]);
            
            break;
        }
    }
    if (currentSlot == -1)
        return 1;
    if(WeaponInfo[playerid][aMagazineSize][currentSlot] == 0){
        RemoveWeaponObject(playerid);
        AttachedWeapon[playerid] = 0;
        return 1;
    }
    if (WeaponInfo[playerid][aAmmo][currentSlot] <= 0)
    {
        if (WeaponInfo[playerid][aReloadDone][currentSlot])
            return 1;

        new ammoType = WeaponInfo[playerid][aAmmoType][currentSlot];
        new reserveAmmo = AmmoInfo[playerid][aReserve][ammoType];
        new magsize = WeaponInfo[playerid][aMagazineSize][currentSlot];

        if (reserveAmmo <= 0)
        {
            WeaponObject(playerid, currentSlot);
            return 1;
        }
        // currently turned off because of some bugs 
        if(WeaponInfo[playerid][aAmmo][currentSlot] == -1){
        if (reserveAmmo <= magsize)
        {
            WeaponInfo[playerid][aAmmo][currentSlot] = reserveAmmo;
            SetAmmoReserveTD(playerid,reserveAmmo - WeaponInfo[playerid][aAmmo][currentSlot],currentSlot);
            SetAmmoTD(playerid,WeaponInfo[playerid][aAmmo][currentSlot]);
            return 1;
        }
        else if(reserveAmmo > magsize)
        {
            WeaponInfo[playerid][aAmmo][currentSlot] = magsize;
            SetAmmoReserveTD(playerid,reserveAmmo - WeaponInfo[playerid][aAmmo][currentSlot],currentSlot);
            SetAmmoTD(playerid,WeaponInfo[playerid][aAmmo][currentSlot]);
            return 1;
        }
        }
        else{
            APlayReloadAnimation(playerid, weaponid, currentSlot);
        }
    }

    return 1;
}
// when player make a shot
hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    for(new i = 0; i < 13; i++)
    {

        if(WeaponInfo[playerid][aWeapons][i] == weaponid)
        {
            if(WeaponInfo[playerid][aReloadDone][i])
            {
                SAM(COLOR_RED, "AdmWarning: %s[%i] ammo desync/cheat detected", GetRPName(playerid), playerid);
                // warning kodth or kick akiyekk cause he is not animinating in reload at this point
                return 0; // Block bullet
            }
            if(WeaponInfo[playerid][aMagazineSize][i] >= WeaponInfo[playerid][aStandardMag][i])
            {
                Shots[playerid][i] ++;
                if(Shots[playerid][i] == WeaponInfo[playerid][aStandardMag][i]-2)
                {
                    GivePlayerWeapon(playerid, weaponid, WeaponInfo[playerid][aStandardMag][i]);
                    Shots[playerid][i] = 0;
                }
            }
            

            if(WeaponInfo[playerid][aMagazineSize][i] == 0) SyncWeaponData(playerid);

            if(WeaponInfo[playerid][aAmmo][i] <= 0)
            {
                WeaponInfo[playerid][aReloadDone][i] = true;
                WeaponInfo[playerid][aAmmo][i] = 0; 
                APlayReloadAnimation(playerid, weaponid, i);
                return 0; 
            }
            

            else if(WeaponInfo[playerid][aAmmo][i] > WeaponInfo[playerid][aMagazineSize][i])
            {
                APlayReloadAnimation(playerid, weaponid, i);
                SAM(COLOR_RED, "AdmWarning: %s[%i] ammo desync/cheat detected", GetRPName(playerid), playerid);
            }
            else{
                new ammoType = WeaponInfo[playerid][aAmmoType][i];
                AmmoInfo[playerid][aReserve][ammoType] -= 1; 
                WeaponInfo[playerid][aAmmo][i] -= 1;
                SetAmmoTD(playerid,WeaponInfo[playerid][aAmmo][i]);
                
                if(WeaponInfo[playerid][aAmmo][i] <= 0) 
                {
                    WeaponInfo[playerid][aReloadDone][i] = true;
                    WeaponInfo[playerid][aAmmo][i] = 0; 
                    APlayReloadAnimation(playerid, weaponid, i);
                    return 1;
                }
            }
            
            return 1; 
        }
    }
    return 1;
}
#define _WEAPON_AMMO_LOADED