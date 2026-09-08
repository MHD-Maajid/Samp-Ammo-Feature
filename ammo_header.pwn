#if defined _ammo_header_included
    #endinput
#endif
#define _ammo_header_included

/*
 ****************************************************************
 *  ___________________________________________________________ *
 * |                         INFORMATION                       |*
 * |___________________________________________________________|*
 * |                                                           |*
 * |   [Module]: "ammo-system headers"                         |*
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
enum ammo_system
{
    aMagazine[2],
    aReserve[3]
}
enum weapon_ammo_system
{
    aWeapons[13],
    aAmmo[13],
    aMagazineSize[13],
    aMagazineAttached[13],
    bool:aReloadDone[13],
    aWeaponObj[13],
    aStandardMag[13],
    aAmmoType[13]
}
new PlayerText:WeaponTD[MAX_PLAYERS][7];
new MagazineInfo[33][3];
new WeaponInfo[MAX_PLAYERS][weapon_ammo_system];
new AmmoInfo[MAX_PLAYERS][ammo_system];
new ClientWeaponSlot[MAX_PLAYERS][13] = {-1, ...};
new WeaponWarning[MAX_PLAYERS];
new Shots[MAX_PLAYERS][13];
new AttachedWeapon[MAX_PLAYERS];
new Tdcolor[3];
// this TDShow variable is used in gamemode to show only one time this td avoiding repeated showing
new bool: TDShow[MAX_PLAYERS];
new PlayerTDColor[MAX_PLAYERS];
new LastWeapon[MAX_PLAYERS];
new ValidWeapons[MAX_PLAYERS];

    