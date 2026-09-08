/*
 ****************************************************************
 *  ___________________________________________________________ *
 * |                         INFORMATION                       |*
 * |___________________________________________________________|*
 * |                                                           |*
 * |   [Module]: "ammo-system text-draw"                       |*
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




#if defined _ammo_td_included
    #endinput
#endif
#define _ammo_td_included

stock ShowPlayerWeaponTd(playerid)
{
    if(TDShow[playerid]) return;
    for(new i = 0; i < 7; i++)
    {
        if(i==1) continue;
        PlayerTextDrawShow(playerid, WeaponTD[playerid][i]);
    }
	TDShow[playerid] = true;

}
stock SetPlayerWeaponTd(playerid,ObjectId)
{
    PlayerTextDrawSetPreviewModel(playerid, WeaponTD[playerid][1], ObjectId);
    
    PlayerTextDrawShow(playerid, WeaponTD[playerid][1]);
}
stock HideWeaponTD(playerid)
{
    TDShow[playerid] = false;
    for(new i = 0; i < 7; i++)
    {
        PlayerTextDrawHide(playerid, WeaponTD[playerid][i]);
    }
}
stock DestroyWeaponTD(playerid)
{
    TDShow[playerid] = false;
    for(new i = 0; i < 7; i++)
    {
        PlayerTextDrawDestroy(playerid, WeaponTD[playerid][i]);
    }
}
stock HideTDWeapon(playerid)
{
    new string[16];
    PlayerTextDrawHide(playerid, WeaponTD[playerid][1]);
    format(string, sizeof(string), "000");
    PlayerTextDrawColour(playerid, WeaponTD[playerid][2], -1);
    PlayerTextDrawSetString(playerid, WeaponTD[playerid][3], string);
    PlayerTextDrawSetString(playerid, WeaponTD[playerid][2], string);
    PlayerTextDrawSetString(playerid, WeaponTD[playerid][6], string);
    PlayerTextDrawShow(playerid, WeaponTD[playerid][2]);
}
stock SetValue0(playerid)
{
    new string[16];
    format(string, sizeof(string), "000");
    PlayerTextDrawSetString(playerid, WeaponTD[playerid][3], string);
    PlayerTextDrawSetString(playerid, WeaponTD[playerid][2], string);
    PlayerTextDrawSetString(playerid, WeaponTD[playerid][6], string);
    PlayerTextDrawShow(playerid, WeaponTD[playerid][2]);
}
stock SetAmmoTD(playerid,ammo)
{
    // color red
    
    new string[16];
    if(ammo <= 0){
        if(PlayerTDColor[playerid] != 0){

            PlayerTDColor[playerid] = 0;
            PlayerTextDrawColour(playerid, WeaponTD[playerid][2], Tdcolor[2]);
            PlayerTextDrawShow(playerid, WeaponTD[playerid][2]);
        }
        
        format(string, sizeof(string), "000");
    }
    else if(ammo < 10){
        if(PlayerTDColor[playerid] != 1){
            PlayerTDColor[playerid] = 1;
            PlayerTextDrawColour(playerid, WeaponTD[playerid][2], Tdcolor[1]);
            PlayerTextDrawShow(playerid, WeaponTD[playerid][2]);
        }
        format(string, sizeof(string), "00%d", ammo);
    }
    else if(ammo < 100){
        if(PlayerTDColor[playerid] != 2){
            PlayerTDColor[playerid] = 2;
            PlayerTextDrawColour(playerid, WeaponTD[playerid][2], Tdcolor[0]);
            PlayerTextDrawShow(playerid, WeaponTD[playerid][2]);
        }
        format(string, sizeof(string), "0%d", ammo);
    }else{
        if(PlayerTDColor[playerid] != 2){
            PlayerTDColor[playerid] = 2;
            PlayerTextDrawColour(playerid, WeaponTD[playerid][2], Tdcolor[0]);
            PlayerTextDrawShow(playerid, WeaponTD[playerid][2]);
        }
        format(string, sizeof(string), "%d", ammo);
    }
    
    PlayerTextDrawSetString(playerid, WeaponTD[playerid][2], string);
}
stock SetAmmoReserveTD(playerid,reserveAmmo,slot)
{
    new string[16];

    new ammoType = WeaponInfo[playerid][aAmmoType][slot];
    new ammoloaded;
    for(new l=0; l < 13; l++)
    {
        if(WeaponInfo[playerid][aAmmoType][l] == ammoType)
        {
            ammoloaded+=WeaponInfo[playerid][aAmmo][l];
        }
    }
    reserveAmmo -= ammoloaded;
 
    format(string, sizeof(string), "%d", reserveAmmo);
    
    PlayerTextDrawSetString(playerid, WeaponTD[playerid][6], string);
}
stock SetMagazineTD(playerid,magazinesize)
{
    new string[16];
    if(magazinesize < 10){
        format(string, sizeof(string), "00%d", magazinesize);
    }
    else if(magazinesize < 100){
        format(string, sizeof(string), "0%d", magazinesize);
    }else{
        format(string, sizeof(string), "%d", magazinesize);
    }
    PlayerTextDrawSetString(playerid, WeaponTD[playerid][3], string);
    

}
// td implemented in gamemode
/*
WeaponTD[playerid][0] = CreatePlayerTextDraw(playerid, 91.000000, 278.000000, "_");
PlayerTextDrawFont(playerid, WeaponTD[playerid][0], 1);
PlayerTextDrawLetterSize(playerid, WeaponTD[playerid][0], 0.600000, 5.750002);
PlayerTextDrawTextSize(playerid, WeaponTD[playerid][0], 293.500000, 97.500000);
PlayerTextDrawSetOutline(playerid, WeaponTD[playerid][0], 1);
PlayerTextDrawSetShadow(playerid, WeaponTD[playerid][0], 0);
PlayerTextDrawAlignment(playerid, WeaponTD[playerid][0], 2);
PlayerTextDrawColour(playerid, WeaponTD[playerid][0], -1);
PlayerTextDrawBackgroundColour(playerid, WeaponTD[playerid][0], 255);
PlayerTextDrawBoxColour(playerid, WeaponTD[playerid][0], 72);
PlayerTextDrawUseBox(playerid, WeaponTD[playerid][0], 1);
PlayerTextDrawSetProportional(playerid, WeaponTD[playerid][0], 1);
PlayerTextDrawSetSelectable(playerid, WeaponTD[playerid][0], 0);

WeaponTD[playerid][1] = CreatePlayerTextDraw(playerid, 54.000000, 254.000000, "HUD:radar_burgershot");
PlayerTextDrawFont(playerid, WeaponTD[playerid][1], 5);
PlayerTextDrawLetterSize(playerid, WeaponTD[playerid][1], 0.600000, 2.000000);
PlayerTextDrawTextSize(playerid, WeaponTD[playerid][1], 86.500000, 106.000000);
PlayerTextDrawSetOutline(playerid, WeaponTD[playerid][1], 1);
PlayerTextDrawSetShadow(playerid, WeaponTD[playerid][1], 0);
PlayerTextDrawAlignment(playerid, WeaponTD[playerid][1], 1);
PlayerTextDrawColour(playerid, WeaponTD[playerid][1], -1);
PlayerTextDrawBackgroundColour(playerid, WeaponTD[playerid][1], -256);
PlayerTextDrawBoxColour(playerid, WeaponTD[playerid][1], 50);
PlayerTextDrawUseBox(playerid, WeaponTD[playerid][1], 1);
PlayerTextDrawSetProportional(playerid, WeaponTD[playerid][1], 1);
PlayerTextDrawSetSelectable(playerid, WeaponTD[playerid][1], 0);
PlayerTextDrawSetPreviewModel(playerid, WeaponTD[playerid][1], 355);
PlayerTextDrawSetPreviewRot(playerid, WeaponTD[playerid][1], -4.000000, 0.000000, -10.000000, 1.839998);
PlayerTextDrawSetPreviewVehCol(playerid, WeaponTD[playerid][1], 1, 1);

WeaponTD[playerid][2] = CreatePlayerTextDraw(playerid, 100.000000, 315.000000, "100");
PlayerTextDrawFont(playerid, WeaponTD[playerid][2], 2);
PlayerTextDrawLetterSize(playerid, WeaponTD[playerid][2], 0.216665, 1.399999);
PlayerTextDrawTextSize(playerid, WeaponTD[playerid][2], 400.000000, 17.000000);
PlayerTextDrawSetOutline(playerid, WeaponTD[playerid][2], 0);
PlayerTextDrawSetShadow(playerid, WeaponTD[playerid][2], 0);
PlayerTextDrawAlignment(playerid, WeaponTD[playerid][2], 1);
PlayerTextDrawColour(playerid, WeaponTD[playerid][2], -1);
PlayerTextDrawBackgroundColour(playerid, WeaponTD[playerid][2], 255);
PlayerTextDrawBoxColour(playerid, WeaponTD[playerid][2], 0);
PlayerTextDrawUseBox(playerid, WeaponTD[playerid][2], 0);
PlayerTextDrawSetProportional(playerid, WeaponTD[playerid][2], 1);
PlayerTextDrawSetSelectable(playerid, WeaponTD[playerid][2], 0);

WeaponTD[playerid][3] = CreatePlayerTextDraw(playerid, 124.000000, 315.000000, "100");
PlayerTextDrawFont(playerid, WeaponTD[playerid][3], 2);
PlayerTextDrawLetterSize(playerid, WeaponTD[playerid][3], 0.216665, 1.399999);
PlayerTextDrawTextSize(playerid, WeaponTD[playerid][3], 400.000000, 17.000000);
PlayerTextDrawSetOutline(playerid, WeaponTD[playerid][3], 0);
PlayerTextDrawSetShadow(playerid, WeaponTD[playerid][3], 0);
PlayerTextDrawAlignment(playerid, WeaponTD[playerid][3], 1);
PlayerTextDrawColour(playerid, WeaponTD[playerid][3], -1);
PlayerTextDrawBackgroundColour(playerid, WeaponTD[playerid][3], 255);
PlayerTextDrawBoxColour(playerid, WeaponTD[playerid][3], 0);
PlayerTextDrawUseBox(playerid, WeaponTD[playerid][3], 0);
PlayerTextDrawSetProportional(playerid, WeaponTD[playerid][3], 1);
PlayerTextDrawSetSelectable(playerid, WeaponTD[playerid][3], 0);

WeaponTD[playerid][4] = CreatePlayerTextDraw(playerid, 117.000000, 312.000000, "/");
PlayerTextDrawFont(playerid, WeaponTD[playerid][4], 1);
PlayerTextDrawLetterSize(playerid, WeaponTD[playerid][4], 0.341666, 2.049998);
PlayerTextDrawTextSize(playerid, WeaponTD[playerid][4], 400.000000, 17.000000);
PlayerTextDrawSetOutline(playerid, WeaponTD[playerid][4], 0);
PlayerTextDrawSetShadow(playerid, WeaponTD[playerid][4], 0);
PlayerTextDrawAlignment(playerid, WeaponTD[playerid][4], 1);
PlayerTextDrawColour(playerid, WeaponTD[playerid][4], -1);
PlayerTextDrawBackgroundColour(playerid, WeaponTD[playerid][4], 255);
PlayerTextDrawBoxColour(playerid, WeaponTD[playerid][4], 50);
PlayerTextDrawUseBox(playerid, WeaponTD[playerid][4], 0);
PlayerTextDrawSetProportional(playerid, WeaponTD[playerid][4], 1);
PlayerTextDrawSetSelectable(playerid, WeaponTD[playerid][4], 0);

WeaponTD[playerid][5] = CreatePlayerTextDraw(playerid, 91.000000, 333.000000, "reserve ammo   :");
PlayerTextDrawFont(playerid, WeaponTD[playerid][5], 2);
PlayerTextDrawLetterSize(playerid, WeaponTD[playerid][5], 0.116664, 1.149999);
PlayerTextDrawTextSize(playerid, WeaponTD[playerid][5], 402.500000, 98.500000);
PlayerTextDrawSetOutline(playerid, WeaponTD[playerid][5], 0);
PlayerTextDrawSetShadow(playerid, WeaponTD[playerid][5], 0);
PlayerTextDrawAlignment(playerid, WeaponTD[playerid][5], 2);
PlayerTextDrawColour(playerid, WeaponTD[playerid][5], -1);
PlayerTextDrawBackgroundColour(playerid, WeaponTD[playerid][5], 255);
PlayerTextDrawBoxColour(playerid, WeaponTD[playerid][5], 50);
PlayerTextDrawUseBox(playerid, WeaponTD[playerid][5], 1);
PlayerTextDrawSetProportional(playerid, WeaponTD[playerid][5], 0);
PlayerTextDrawSetSelectable(playerid, WeaponTD[playerid][5], 0);

WeaponTD[playerid][6] = CreatePlayerTextDraw(playerid, 119.000000, 331.000000, "1000");
PlayerTextDrawFont(playerid, WeaponTD[playerid][6], 2);
PlayerTextDrawLetterSize(playerid, WeaponTD[playerid][6], 0.216665, 1.399999);
PlayerTextDrawTextSize(playerid, WeaponTD[playerid][6], 400.000000, 17.000000);
PlayerTextDrawSetOutline(playerid, WeaponTD[playerid][6], 0);
PlayerTextDrawSetShadow(playerid, WeaponTD[playerid][6], 0);
PlayerTextDrawAlignment(playerid, WeaponTD[playerid][6], 1);
PlayerTextDrawColour(playerid, WeaponTD[playerid][6], -1);
PlayerTextDrawBackgroundColour(playerid, WeaponTD[playerid][6], 255);
PlayerTextDrawBoxColour(playerid, WeaponTD[playerid][6], 0);
PlayerTextDrawUseBox(playerid, WeaponTD[playerid][6], 0);
PlayerTextDrawSetProportional(playerid, WeaponTD[playerid][6], 1);
PlayerTextDrawSetSelectable(playerid, WeaponTD[playerid][6], 0);
*/