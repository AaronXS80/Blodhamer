/*
																	GAMMEODE INI BIKINAN ORANG RUSIA
															JIKA KALIAN MAU SHARE GAMEMODE INI JANGAN LUPA KASIH AUTHOR GM
																				HARGAI AUTHOR ++
		AUTHOR : MAXIMK47
		SHARE THIS GM : KAZUJI / ALTIORUS
		FIXX BEBEREPA BUG : KAZUJI
		
		BLOODHAMER v1.2
		MODE : DRIFT

*/

//=[�������]====================================================================
#include <a_samp> // ������� ������
#include <streamer> // ��� ��������
#include <mxINI>
#include <utils>
#include <sscanf2>
#include <a_players>
#include <core>
#include <float>
#include <progress>
#include <mSelection>
#include <dini>

#pragma dynamic 999999 // ������� �������� �������
//#pragma unused ret_memcpy // ������� ������ �� ��� ������� ret_memcpy
//=[������ �������]=============================================================

new logo1,logo2,logo3,logo4,logo5,logo6,logo7,logo8,logo9,logo10,logo11;

//=[������� ������]=============================================================
#define COLOR_GREY 0xBEBEBEAA // ����� ����
#define COLOR_PURPLE 0xC2A2DAAA // ��������� ����
#define COLOR_YELLOW 0xFFFF00AA // Ƹ���� ����
#define COLOR_WHITE 0xFFFFFFAA // ����� ����
#define COLOR_DBLUE 0x2641FEAA // ����� ����
#define COLOR_BLUE 0x33AAFFFF // ������� ����
#define COLOR_GREEN 0x21DD00FF // ������ ����
#define COLOR_RED 0xF60000AA // ������� ����
#define COLOR_ORANGE 0xFF9900AA // ��������� ����
#define COLOR_BLACK 0x212121AA // ������ ����
#define COLOR_LIGHTGREEN 0x9ACD32AA // ��������� ����
#define COLOR_LIGHTBLUE 0x33CCFFAA
//=[����]=======================================================================
#define MAX_HOUSES 2000
#define MAX_HOUSES_OWNED    			3
#define D_H_CREATE_DESC 1
#define D_H_CREATE_PRICE 2
#define D_H_CREATE_INT 3
#define D_H_CREATE_CONF 4
//==============================================================================
#define MAX_SPIKESTRIPS 100 // ������������ ���������� �����
#define ARMOUR_INDEX 4 // ����� �� ����
#define max_line 400 // ��� ������� ���������� ��� ���� � � ���
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1 // ��� ������
#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0))) // ��� ����
#define SLOW_KEY_ID  40
#define RADIO 3000 //�����
#define buygun 57354
#define Texts 200 // Change ID
#define TextsAdm 300 // Change ID
#define COLOR_LIGHTRED 0xFF6347AA

//=[����� �������]==============================================================
#define DRIFT_MINKAT 10.0 // ����� �������
#define DRIFT_MAXKAT 90.0 // ����� �������
#define DRIFT_SPEED 30.0 // ����� �������

//Config defines, change to your likings
#define MAX_GARAGES 2000 //Max garages to be created in the server
#define GARAGE_OWNED_PICKUP 1559 //Change this to the pickup model you prefer. Default: White arrow (diamond)
#define GARAGE_FREE_PICKUP 1273 //Change this to the pickup model you prefer. Default: Green house
#define GARAGE_OWNED_TEXT "Owner: %s\nLocked: %s" //This text will appear at all owned garages
#define GARAGE_FREE_TEXT "FOR SALE!\n Price: %d\n\nUse /buygarage to buy this garage." //This text will appear at all garages that are for sale
#define DD 200.0 //The streamdistance for the textlabels
#define TXTCOLOR 0xF9C50FFF //The textcolor for the textlabels
#define COLOR_USAGE 0xBB4D4DFF //The textcolor for the 'command usage' message
#define COLOR_SUCCESS 0x00AE00FF //The textcolor for the 'command sucessfull' message
#define COLOR_ERROR 0xFF0000FF //The textcolor for the 'error' message

//System defines, no need to change stuff here
#define SCRIPT_VERSION "V1.0b"

new CurrentSpawnedVehicle[MAX_PLAYERS];
#define carmenu 4450

new Menu[MAX_PLAYERS];
new Menu2[MAX_PLAYERS];
new Text3D:entrancetext;
new TextsActive[MAX_PLAYERS];
new entrancegate, exitgate;
new water1, water2, water3, water4, water5, water6, water7;
new usingcarwash = -1;
new unwashable[89][0] = {
{403},{406},{408},{414},{417},
{423},{424},{425},{430},{431},
{432},{433},{435},{437},{441},
{443},{444},{446},{447},{448},
{452},{453},{454},{455},{456},
{457},{460},{461},{462},{463},
{464},{465},{468},{469},{471},
{472},{473},{476},{481},{484},
{485},{486},{487},{488},{493},
{497},{498},{501},{508},{509},
{510},{511},{512},{513},{514},
{515},{519},{520},{521},{522},
{523},{524},{530},{531},{532},
{539},{544},{548},{553},{556},
{557},{563},{564},{568},{571},
{572},{573},{574},{577},{578},
{581},{583},{586},{588},{592},
{593},{594},{595},{609}
};
////////////////////////////////////////////////////////////////////////////////
new DriftPointsNow[200]; // ����� �������
new PlayerDriftCancellation[200]; // ����� �������
new Float:ppos[200][3]; // ����� �������
new scores[MAX_PLAYERS]; // ����� �������
enum Float:Pos{ Float:sX,Float:sY,Float:sZ }; // ����� �������
new Float:SavedPos[MAX_PLAYERS][Pos]; // ����� �������
new Text:Score[MAX_PLAYERS]; // ����� �������
new Text:Chet[MAX_PLAYERS]; // ����� �������
new chets[MAX_PLAYERS], lolka[MAX_PLAYERS], kazan[MAX_PLAYERS], fartuk[MAX_PLAYERS];
new Fdap[MAX_PLAYERS];
new frodo[MAX_PLAYERS];
new MenuL[MAX_PLAYERS];

new Text3D:garageLabel[MAX_GARAGES]; //Will hold the garage label
new garagePickup[MAX_GARAGES]; //Will hold the garage pickup
new lastGarage[MAX_PLAYERS]; //Will hold the last garage ID the player went in to
//=[����]=======================================================================
new m_h;
new STR[158];
//=[����]=======================================================================
new maxping = 2000; // ��� �����
new gHostName; // ������ �������� �������
new ObjectSelect[MAX_VEHICLES][999]; // ����
new neon[MAX_PLAYERS][999]; // ����
new IsMessageSent[MAX_PLAYERS]; // ��������
new interval = 3; // �������� �� 3 �������
new Counting; // ��� �������
new chat=1; // ����� ���
new ta4karepair[MAX_PLAYERS];
new ta4karepaircar;
new pLights[MAX_PLAYERS], bool:LightsOnOff[MAX_PLAYERS];
new Text: Speed[MAX_PLAYERS][3];
new Glow[MAX_PLAYERS];
new MSecondsTimer;
new GlowColor;
new Text:Textdraw2;
new Text:Textdraw0[MAX_PLAYERS];
new Text:Textdraw1[MAX_PLAYERS];
new Moder[MAX_PLAYERS];
new skinlist = mS_INVALID_LISTID;
new car1 = mS_INVALID_LISTID;
new car2 = mS_INVALID_LISTID;
new car3 = mS_INVALID_LISTID;
new car4 = mS_INVALID_LISTID;
new car5 = mS_INVALID_LISTID;


forward MSeconds();
forward Countdown();
forward Check();
forward AutoRepair();
forward AutoFlip();
forward IsAdrcCar(carid);
forward IsAvipCar(carid);
forward IsAotherCar(carid);
forward SaveAccounts();
forward GetMoney();
forward Drift();
forward AngleUpdate();
forward DriftCancellation(playerid);
forward Autocruise(playerid, in);
forward OpenExit(playerid);
forward EndWash(playerid);
forward Water(playerid, on);

new GlowColors[37] = {
0xFF0000FF,
0xFF4E00FF,
0xFF7E00FF,
0xFFA800FF,
0xFFC000FF,
0xFFD800FF,
0xFFF600FF,
0xEAFF00FF,
0xD2FF00FF,
0x9CFF00FF,
0x3CFF00FF,
0x00FF2AFF,
0x00FF90FF,
0x00FFBAFF,
0x00FFF0FF,
0x00F6FFFF,
0x00C6FFFF,
0x00BAFFFF,
0x0096FFFF,
0x0084FFFF,
0x006CFFFF,
0x004EFFFF,
0x003CFFFF,
0x0000FFFF,
0x1200FFFF,
0x3600FFFF,
0x4E00FFFF,
0x6C00FFFF,
0x8A00FFFF,
0xA800FFFF,
0xC000FFFF,
0xDE00FFFF,
0xFF00F6FF,
0xFF00A8FF,
0xFF007EFF,
0xFF0066FF,
0xFF0036FF
};

stock IPAntiPorts[][] =
{
	"5555", "6666", "7777", "8888", "9999" // �����������
};

new	dje, // ���� � ��������� ������
djq,
LVSSENTER,
LVSSEXIT,
LVCCENTER,
LVCCEXIT,
LVDRAGONENTER,
LVDRAGONEXIT,
LVDISCOENTER,
LVDISCOEXIT,
LVLSPDENTER,
LVLSPDEXIT,
LVJMENTER,
LVJMEXIT
;

new CrashCars1[] = { // ����-������. ����������� ����
	401,402,403,407,408,410,411,412,413,414,415,416,417,419,422,423,424,427,428,429,433,434,
	436,440,443,444,447,451,455,456,457,459,461,462,463,468,469,471,474,475,477,478,480,482,
	483,489,491,494,495,496,498,499,500,502,503,504,505,506,508,511,514,515,517,518,521,522,
	523,524,525,526,527528,533,534,535,537,538,541,542,543,544,545 ,548,549,552,554,556,557,
	558,559,562,563,565,573,574,575,576,578,581,582, 586,587,588,589,599,600,601,602,603,605,609
};

new CrashCars2[] = { // ����-������. ����������� ����
	406,425,430,432,441,446,448,452,453,454,460,464,465,472,473,476,481,
	484,485,486,493,501,509,510,512,513,519,520,530,531,532,539,553,564,
	568,571,572,577,583,592,593,594,595
};

new PlayerColors[200] = { // ����� �����
	0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,
	0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,
	0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,
	0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,0x3D0A4FFF,
	0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,0x057F94FF,
	0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,
	0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,
	0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,
	0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,
	0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,0xDCDE3DFF,
	0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,
	0xD8C762FF,0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,
	0xF4A460FF,0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,
	0x10DC29FF,0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,
	0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,
	0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,
	0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,
	0x18F71FFF,0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,
	0x12D6D4FF,0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,
	0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,
	0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,
	0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,
	0xD8C762FF,0xD8C762FF
};

enum garageInfo{

        Owner[24], //Holds the name of the owner
        Owned, //Holds the owned value (1 if owned, 0 if for sale)
        Locked, //The locked status of the garage (0 unlocked, 1 locked)
        Price, //The price of the garage
        Float:PosX, //The outside X position of the garage
        Float:PosY, //The outside Y position of the garage
        Float:PosZ, //The outside Z position of the garage
        Interior, //The internal interior number of the garage
        UID //Unique ID, keeps a unique ID of the garages so the virtualworld doesn't mix up when deleting and reloading garages
}

new gInfo[MAX_GARAGES][garageInfo]; //This is used to access variable from our enumerator
new garageCount; //This will hold the total of loaded garages
new Float:GarageInteriors[][] = //This array holds the coordinates, facing angle and interior ID of the garages.
{
        {616.4642, -124.4003, 997.5993, 90.0, 3.0}, // Small garage
    {617.0011, -74.6962, 997.8426, 90.0, 2.0}, // Medium garage
    {606.4268, -9.9375, 1000.7485, 270.0, 1.0} //Big garage

};

//=[����]=======================================================================
enum hInfo
{
        hDesc[32],
        hOwner[MAX_PLAYER_NAME],
        Float:hX,Float:hY,Float:hZ,
        hInterior,
        hVirtWorld,
        hPrice,
        hLock,
        hPick,
        Text3D:hText
};
new House[MAX_HOUSES][hInfo];

enum hiInfo
{
        Float:hiX,Float:hiY,Float:hiZ,hiInt,
        hiName[15],
}

new HInts[][hiInfo]={
        {318.564971,1118.209960,1083.882812,5,"Crack den"},
        {2269.4453,-1210.2952,1047.5625,10,"Hashbury House"},
        {2496.2676,-1693.8955,1014.7422,3,"Johnsons House"},
        {1299.14,-794.77,1084.00,5,"Madd Doggs M."},
        {2260.3711,-1135.7345,1050.6328,10,"R.B.M. Room"},
        {2365.6023,-1133.6688,1050.8750,8,"V. B. House"},
        {1302.519897,-1.787510,1001.028259,18,"Warehouse 2"},
        {2324.419921,-1145.568359,1050.710083,12,"Un. safe house"},
        {76.632553,-301.156829,1.578125,0,"Blueberry"}
};

enum pInfo
{
    pMoney, // ��������� ���-�� �����.
    pSkin,
    pAdmin,
    pVIP,
    pScore,
    pBanned,
    pWarns,
    pMuted,
    pMuteTime,
    pMenuL,
};

new PlayerInfo[MAX_PLAYERS][pInfo];

//==============================================================================
forward ArmourUpdate(); // ����� �� ����
public ArmourUpdate() // ����� �� ����
{
	for(new i=0; i<=GetMaxPlayers(); i++)
	{
		new Float:armour;
		GetPlayerArmour(i, armour);
		if( armour > 0.0 )
		{
			SetPlayerAttachedObject( i, ARMOUR_INDEX, 373, 1, 0.286006, -0.038657, -0.158132, 67.128456, 21.916156, 33.972290, 1.000000, 1.000000, 1.000000 ); // ����� ����� �� ������
		}
		else if( armour == 0.0 ) // ���� �� ������ ��� �����
		{
			RemovePlayerAttachedObject(i, ARMOUR_INDEX); // ����� ����� �� ������
		}
	}
	return 1;
}
//==============================================================================
stock SPD(playerid, dialogid, style, caption[], info[], button1[], button2[]) // ��� ���������� ����
{
	ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
	SetPVarInt(playerid, "USEDIALOGID", dialogid);
	return 1;
}
#define ShowPlayerDialog SPD // ��� ���������� ����

public AutoRepair()
{
    for(new playerid=0; playerid<MAX_PLAYERS; playerid++)
	{
 		if(IsPlayerInAnyVehicle(playerid))
 		{
			if(ta4karepair[playerid] == 1)
			{
			new Float:CarHP;
			GetVehicleHealth(GetPlayerVehicleID(playerid), CarHP);
            if (CarHP < 1000)
            {
				RepairVehicle(GetPlayerVehicleID(playerid));
			}
 		}
	}
  }
}
//==============================================================================
main() // ������ � ���� �������
{
	print("\n=========================");
	print("Blodhamer Nice Drift Welcome\n");
	print("=========================\n");
}
//==============================================================================
public OnGameModeInit() // ������� ��� �������
{
	LoadHouses();
	SetGameModeText("Gang+House+Garage");// �������� ����
	SendRconCommand("mapname Grand Final"); // ����� ����
	chat=1; // ����� ���
	Load_Garages();
	SetTimer("Check",1000,1); // ������� �� �������
	SetTimer("OnPlayerRequestClass",100,0);
	ta4karepaircar = SetTimer("AutoRepair", 1000, true);
	SetTimer("AutoRepair", 1000, true);
	SetTimer("PingKick", 30000, true); // ��� �����
	SetTimer("PHostname",5000,1); // ������ �������� �������
	SetTimer("OtherTime", 1000, 1); // ��� ���������
	SetTimer("Reklama",600000,1); // ��� �������
	SetTimer("ArmourUpdate", 1000, true); // ����� �� ����
	SetTimer("Drift", 200, true); // ����� �������
	SetTimer("AngleUpdate", 200, true); // ����� �������
	SetTimer("Timer", 300, true);
	MSecondsTimer = SetTimer("MSeconds", 100, 1);
	skinlist = LoadModelSelectionMenu("mSelection/skins.txt");
	car1 = LoadModelSelectionMenu("car1.txt");
	car2 = LoadModelSelectionMenu("car2.txt");
	car3 = LoadModelSelectionMenu("car3.txt");
	car4 = LoadModelSelectionMenu("car4.txt");
	car5 = LoadModelSelectionMenu("car5.txt");

	new Hour;
	gettime(Hour, _, _);
	SetWorldTime(Hour);

	entrancegate = CreateObject(17951,1911.21130371,-1780.68151855,14.15972233,0.00000000,0.00000000,90.00000000);
    exitgate = CreateObject(17951,1911.21130371,-1771.97814941,14.15972233,0.00000000,0.00000000,90.00000000);
    CreateObject(1250,1908.84997559,-1783.68945312,13.40625000,0.00000000,0.00000000,90.00000000);
    CreatePickup(1239, 1, 1911.1886,-1784.2952,13.5, -1);
    entrancetext = Create3DTextLabel("��������� ���������.\n������� (/carwash)",0x008B00FF,1911.1886,-1784.2952,14.5,50,0,1);
	//=[����������� �������]========================================================
	DisableInteriorEnterExits(); // ��������� ���� � ���������
	//==============================================================================
	//UsePlayerPedAnims(); // ��� ���� ������ �������� ��� ������
	//AllowAdminTeleport(1); // Rcon ����� ����� ���������������� ������� �� �����
	//ShowPlayerMarkers(1); // ���������� ��� �� ���������� ������� �� �����
	//ShowNameTags(1); // ���������� ��� �� ���������� ���� ��� �������
	//SetNameTagDrawDistance(40.0); // ���������� �� ������� ����� ����
	//SendRconCommand("loadfs �������� �������"); // ���������� ������ ����� ���
	//SetWorldTime(12); // ����� ��� �������
	//SetWeather(0); // ������ ��� �������
	//ManualVehicleEngineAndLights(); // ��������� ��������� � ���� ������� ��� RP
	//SetTeamCount(11); // ������ ��� ����
	//EnableTirePopping(1); // ������ ��� ����
	//EnableZoneNames(1); // ������ ��� ����
	//ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL); // ������ ��� ����

	//=[��� ����� � ��������� ������]===============================================
	//-[����� ���� � ��]------------------------------------------------------------
	dje = CreatePickup(19130, 23, -2625.3530, 1412.5995, 7.0938, 0); // ���� � ������
	djq = CreatePickup(19130, 23, -2635.9272,1402.4644,906.4609, 0); // ����� �� ������
	CreateDynamic3DTextLabel("..::���� � ���� Jizzy::..",0x21DD00FF,-2625.3530, 1412.5995, 8.0938,20.0);
	CreateDynamic3DTextLabel("..::����� �� ����� Jizzy::..",0xF60000AA,-2635.9272,1402.4644,907.4609,20.0);
	//-[����-��� � ��]--------------------------------------------------------------
	LVSSENTER = CreatePickup(19130, 23, 2087.1636,2074.0681,10.9613, 0); // ���� � LV Sex Shop
	LVSSEXIT = CreatePickup(19130, 23, -100.4864,-24.1279,1000.7188, 0); // ����� �� LV Sex Shop
	CreateDynamic3DTextLabel("..::���� � 'Sex Shop'::..",0x21DD00FF,2087.1636,2074.0681,11.9613,20.0);
	CreateDynamic3DTextLabel("..::����� �� 'Sex Shop'::..",0xF60000AA,-100.4864,-24.1279,1001.7188,20.0);
	//-[������ �������� � ��]-------------------------------------------------------
	LVCCENTER = CreatePickup(19130, 23, 2196.9663,1677.0699,12.3672, 0); // ���� � Caligulas Casino
	LVCCEXIT = CreatePickup(19130, 23, 2234.8755,1714.0452,1012.3250, 0); // ����� �� Caligulas Casino
	CreateDynamic3DTextLabel("..::���� � 'Caligulas Casino'::..",0x21DD00FF,2196.9663,1677.0699,13.3672,20.0);
	CreateDynamic3DTextLabel("..::����� �� 'Caligulas Casino'::..",0xF60000AA,2234.8755,1714.0452,1013.3250,20.0);
	//-[������ 4 ������� � ��]------------------------------------------------------
	LVDRAGONENTER = CreatePickup(19130, 23, 2019.3190,1007.7507,10.8203, 0); // ���� � 4 Dragons Casino
	LVDRAGONEXIT = CreatePickup(19130, 23, 2019.0706,1018.0717,996.8750, 0); // ����� �� 4 Dragons Casino
	CreateDynamic3DTextLabel("..::���� � '4 Dragons Casino'::..",0x21DD00FF,2019.3190,1007.7507,11.8203,20.0);
	CreateDynamic3DTextLabel("..::����� �� '4 Dragons Casino'::..",0xF60000AA,2019.0706,1018.0717,997.8750,20.0);
	//-[���� � ��]------------------------------------------------------------------
	LVDISCOENTER = CreatePickup(19130, 23, 1836.8392,-1682.7113,13.3312, 0); // ���� � Los Santos Disco
	LVDISCOEXIT = CreatePickup(19130, 23, 493.1924,-23.3746,1000.6797, 0); // ����� �� Los Santos Disco
	CreateDynamic3DTextLabel("..::���� � 'Los Santos Disco'::..",0x21DD00FF,1836.8392,-1682.7113,14.3312,20.0);
	CreateDynamic3DTextLabel("..::����� �� 'Los Santos Disco'::..",0xF60000AA,493.1924,-23.3746,1001.6797,20.0);
	//-[����������� ����������� � ��]-----------------------------------------------
	LVLSPDENTER = CreatePickup(19130, 23, 1553.6818,-1675.4729,16.1953, 0); // ���� � Los Santos Police Department
	LVLSPDEXIT = CreatePickup(19130, 23, 246.5820,63.7510,1003.6406, 0); // ����� �� Los Santos Police Department
	CreateDynamic3DTextLabel("..::���� � 'Los Santos Police Department'::..",0x21DD00FF,1553.6818,-1675.4729,17.1953,20.0);
	CreateDynamic3DTextLabel("..::����� �� 'Los Santos Police Department'::..",0xF60000AA,246.5820,63.7510,1004.6406,20.0);
	//-[����� ���������� � ��]------------------------------------------------------
	LVJMENTER = CreatePickup(19130, 23, 2231.9253,-1159.9746,25.8906, 0); // ���� � Jefferson Motel
	LVJMEXIT = CreatePickup(19130, 23, 2215.4075,-1150.5133,1025.7969, 0); // ����� �� Jefferson Motel
	CreateDynamic3DTextLabel("..::���� � 'Jefferson Motel'::..",0x21DD00FF,2231.9253,-1159.9746,26.8906,20.0);
	CreateDynamic3DTextLabel("..::����� �� 'Jefferson Motel'::..",0xF60000AA,2215.4075,-1150.5133,1026.7969,20.0);
	return 1;
}
//==============================================================================
public OnGameModeExit() // ������� ��� ��������
{

	print("\n================");
	print("Blodhamer Nice Drift Welcome");
	print("================\n");
	KillTimer(MSecondsTimer);
	Save_Garages();
    Remove_PickupsAndLabels();
	
	DestroyObject(entrancegate);
    DestroyObject(exitgate);
    DestroyObject(3);
    DestroyPickup(1);
    Delete3DTextLabel(entrancetext);
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    if(GetPlayerVehicleID(i) == GetPlayerVehicleID(usingcarwash))
    {
    DestroyPlayerObject(i, water1);
    DestroyPlayerObject(i, water2);
    DestroyPlayerObject(i, water3);
    DestroyPlayerObject(i, water4);
    DestroyPlayerObject(i, water5);
    DestroyPlayerObject(i, water6);
    DestroyPlayerObject(i, water7);
    TogglePlayerControllable(i, 1);
    SetCameraBehindPlayer(i);
    }
    }
    
	return 1;
}
//==============================================================================
public OnPlayerStateChange(playerid,newstate,oldstate)
{
	if(newstate == PLAYER_STATE_PASSENGER) // ����-������
	{
		for(new i; i<111; i++)
		{
			if(GetVehicleModel(GetPlayerVehicleID(playerid))==CrashCars1[i]&&GetPlayerVehicleSeat(playerid) > 1)
			{
				new pname[MAX_PLAYER_NAME];
				new string[256];
				GetPlayerName(playerid,pname,sizeof(pname));
				format(string,sizeof(string),"{0077FF}Blodhamer Drift :{ffffff} ����� [%s] ��� ������. {FFFF00}( �������: ������ ������� �1 ).",pname,playerid);
				SendClientMessageToAll(0x21DD00FF,string);
				Kick(playerid);
			}
		}
		for(new i; i<43; i++)
		{
			if(GetVehicleModel(GetPlayerVehicleID(playerid))==CrashCars2[i])
			{
				new pname[MAX_PLAYER_NAME];
				new string[256];
				GetPlayerName(playerid,pname,sizeof(pname));
				format(string,sizeof(string),"{0077FF}Blodhamer Drift :{fffffff} ����� [%s] ��� ������. {FFFF00}( �������: ������ ������� �2 ).",pname,playerid);
				SendClientMessageToAll(0x21DD00FF,string);
				Kick(playerid);
			}
		}
	}
	if(newstate == PLAYER_STATE_DRIVER)
	{
            TextDrawShowForPlayer(playerid, Speed[playerid][0]);
            TextDrawShowForPlayer(playerid, Speed[playerid][1]);
            TextDrawShowForPlayer(playerid, Speed[playerid][2]);
	}
	if(oldstate == PLAYER_STATE_DRIVER)
	{
			TextDrawHideForPlayer(playerid, Speed[playerid][0]);
			TextDrawHideForPlayer(playerid, Speed[playerid][1]);
			TextDrawHideForPlayer(playerid, Speed[playerid][2]);
	}
	
	return 1;
}

//==============================================================================
public OnPlayerRequestClass(playerid, classid) // ���������� ������ �����
{
    SetPlayerPos(playerid, -1657.0343,1216.7537,13.6719);
	SetPlayerFacingAngle(playerid, 199.4727);
	SetPlayerCameraPos(playerid, -1654.8575,1213.5493,13.6719);
	SetPlayerCameraLookAt(playerid, -1657.0343,1216.7537,13.6719);
    return 1;
}
//==============================================================================
public OnPlayerConnect(playerid) // ��� ����� �� ������
{
	//------------------------------------------------------------------------------
    new PlayerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
    new account[128];
    format(account,sizeof(account),"Users/%s.ini",PlayerName);
    if(!fexist(account))
    {
        SpawnPlayer(playerid);
        SendClientMessage(playerid, COLOR_YELLOW,"{0077FF}Blodhamer Drift :{ffffff} ������� ������ ����� ������������������.");
        ShowPlayerDialog(playerid,111,DIALOG_STYLE_PASSWORD, "{0077FF}Blodhamer Drift :{ffffff} �����������", "{FFFFFF}����������, ���������� ������� ������,\n����� �������� ���������� ������ ������ ��������.\n\n������� ������:", "������", ""); //...���������� ������ ������ ����
	}
    else
    {
        SendClientMessage(playerid, COLOR_YELLOW,"{0077FF}Blodhamer Drift :{ffffff} ��� ��� ���������������, ����������, ������� ������.");
        new str[128],sctring[2000];
		format(str,sizeof(str),"{0077FF}Blodhamer Drift :{ffffff} �� ������� ������� ����������!\n");
		strcat(sctring,str);
		format(str,sizeof(str),"�� ������� {FF0000}���� ������ (� ������ �������) {FFFFFF}�� ��������� ��������!\n");
		strcat(sctring,str);
		format(str,sizeof(str),"������������� {FF0000}�� ����� ��������������� {FFFFFF}�� ���������� ��������.\n\n");
		strcat(sctring,str);
		format(str,sizeof(str),"������� ������:");
		strcat(sctring,str);
        ShowPlayerDialog(playerid,112,DIALOG_STYLE_PASSWORD, "{0077FF}Blodhamer Drift :{ffffff} �����������", sctring, "�����", ""); //���� �� ����, �� ���������� ���
    }
	////////////////////////////////////////////////////////////////////////////////
	scores[playerid] = 1; // ����� �������
	chets[playerid] = 1;
	lolka[playerid] = 1;
    kazan[playerid] = 1;
    fartuk[playerid] = 1;
    Fdap[playerid] = 1;
    MenuL[playerid] = 1;
    Glow[playerid] = 1;
	frodo[playerid] = 1;
	SetPlayerColor(playerid, PlayerColors[playerid]); // ����� �����
	ta4karepair[playerid] = 1;
	////////////////////////////////////////////////////////////////////////////////
	Textdraw0[playerid] = TextDrawCreate(500, 115, "FRAG:~r~");
    TextDrawBackgroundColor(Textdraw0[playerid], 0x000000ff);
    TextDrawFont(Textdraw0[playerid], 3);
    TextDrawLetterSize(Textdraw0[playerid], 0.3, 1.2);
    TextDrawColor(Text:Textdraw0[playerid], 0xFFFFFFAA);
    TextDrawSetOutline(Textdraw0[playerid], 1);
    TextDrawSetProportional(Textdraw0[playerid], 1);

   	Textdraw1[playerid] = TextDrawCreate(500, 128, "RANG:~r~"); //�����
    TextDrawBackgroundColor(Textdraw1[playerid], 0x000000ff); //���� �������
    TextDrawFont(Textdraw1[playerid], 3); //��� 0-4
    TextDrawLetterSize(Textdraw1[playerid], 0.3, 1.2); //������ ���������
    TextDrawColor(Text:Textdraw1[playerid], 0xFFFFFFAA); //���� ����
    TextDrawSetOutline(Textdraw1[playerid], 1); //������� �������
    TextDrawSetProportional(Textdraw1[playerid], 1);

    TextDrawBoxColor(Textdraw1[playerid],0x00000050 );
    Textdraw2 = TextDrawCreate(500, 103, "STATS:");
    TextDrawFont(Textdraw2, 2);
    TextDrawLetterSize(Textdraw2, 0.2, 0.9);
    TextDrawSetOutline(Textdraw2, 1);
    TextDrawSetProportional(Textdraw2, 1);

	Chet[playerid] = TextDrawCreate(500,141," "); // ����� �������
	TextDrawBackgroundColor(Chet[playerid],0x000000ff);
	TextDrawFont(Chet[playerid],3);
	TextDrawLetterSize(Chet[playerid],0.3, 1.2);
	TextDrawColor(Chet[playerid],0xFFFFFFAA);
	TextDrawSetOutline(Chet[playerid],1);
	TextDrawSetProportional(Chet[playerid],1);

    //------------------------------------------------------------------------------
    Speed[playerid][0] = TextDrawCreate(138.000000, 403.000000, " "); //30
    TextDrawBackgroundColor(Speed[playerid][0], 0x00000033);
    TextDrawFont(Speed[playerid][0], 1);
    TextDrawLetterSize(Speed[playerid][0], 0.359999, 1.299998);
    TextDrawColor(Speed[playerid][0], -1);
    TextDrawSetOutline(Speed[playerid][0], 1);
    TextDrawSetProportional(Speed[playerid][0], 1);

    Speed[playerid][1] = TextDrawCreate(138.000000, 403.000000, "IIIIIIIIIIIIIIIIIIIIIIIIIIIII"); //30
    TextDrawBackgroundColor(Speed[playerid][1], 0x00000000);
    TextDrawFont(Speed[playerid][1], 1);
    TextDrawLetterSize(Speed[playerid][1], 0.359999, 1.299998);
    TextDrawColor(Speed[playerid][1], 0xFFFFFF33);
    TextDrawSetOutline(Speed[playerid][1], 1);
    TextDrawSetProportional(Speed[playerid][1], 1);

    Speed[playerid][2] = TextDrawCreate(145.000000, 388.000000, " "); //km
    TextDrawBackgroundColor(Speed[playerid][2], 0x000000FF);
    TextDrawFont(Speed[playerid][2], 2);
    TextDrawLetterSize(Speed[playerid][2], 0.309998, 1.600000);
    TextDrawColor(Speed[playerid][2], -1);
    TextDrawSetOutline(Speed[playerid][2], 0);
    TextDrawSetProportional(Speed[playerid][2], 1);
    TextDrawSetShadow(Speed[playerid][2], 0);

	IsMessageSent[playerid] = 0; // ��������
	
	SetPlayerMapIcon(playerid,0,2025.5804,1007.8265,10.8203,25,0xFFFFFFFF);
	SetPlayerMapIcon(playerid,1,2189.6609,1677.3126,11.3131,25,0xFFFFFFFF);
	SetPlayerMapIcon(playerid,2,2536.4409,2081.6021,10.8203,6,0xFFFFFFFF);
	SetPlayerMapIcon(playerid,3,2157.1365,941.1958,10.8203,6,0xFFFFFFFF);
	SetPlayerMapIcon(playerid,5,-1507.9429,2608.5994,55.8359,6,0xFFFFFFFF);
	SetPlayerMapIcon(playerid,6,-2625.8647,210.6339,4.6173,6,0xFFFFFFFF);
	SetPlayerMapIcon(playerid,8,238.7927,-177.8448,1.5781,6,0xFFFFFFFF);
	SetPlayerMapIcon(playerid,9,2401.8452,-1979.5873,13.5469,6,0xFFFFFFFF);
	SetPlayerMapIcon(playerid,10,1364.5735,-1278.8613,13.5469,6,0xFFFFFFFF);
	SetPlayerMapIcon(playerid,11,1545.9814,-1675.3253,13.5614,30,0xFFFFFFFF);
	SetPlayerMapIcon(playerid,12,-1619.5039,684.9335,7.1901,30,0xFFFFFFFF);
	SetPlayerMapIcon(playerid,13,2295.0627,2457.1348,10.8203,30,0xFFFFFFFF);
	SetPlayerMapIcon(playerid,14,631.0374,-572.1962,16.3359,30,0xFFFFFFFF);
	SetPlayerMapIcon(playerid,15,-325.1331,1533.0276,75.3594,53,0xFFFFFFFF);
	SetPlayerMapIcon(playerid,16,-2207.1196,-991.9159,36.8409,53,0xFFFFFFFF);
	SetPlayerMapIcon(playerid,17,1583.3257,-2375.7019,13.3750,53,0xFFFFFFFF);
	SetPlayerMapIcon(playerid,18,1241.1146,-745.0139,95.0895,53,0xFFFFFFFF);
	SetPlayerMapIcon(playerid,19,290.5400,2045.2251,17.6406,6,0xFFFFFFFF);
	
	return 1;
}
//==============================================================================
public OnPlayerDisconnect(playerid,reason) // ��� ������ �� �������
{
	//------------------------------------------------------------------------------
    new string[256];
	//------------------------------------------------------------------------------

	TextDrawDestroy(Score[playerid]); // ����� �������
	TextDrawDestroy(Chet[playerid]); // ����� �������
	SaveAccount(playerid);
	//------------------------------------------------------------------------------
	switch(reason)
	{
	case 0: format(string,sizeof(string),"%s (�����).",string);
	case 1: format(string,sizeof(string),"%s (�����).",string);
	case 2: format(string,sizeof(string),"%s (Kick/Ban).",string);
	}
	SendClientMessageToAll(0x21DD00FF,string);
	KillTimer(ta4karepaircar);
	TextDrawDestroy(Score[playerid]);
	TextDrawDestroy(Chet[playerid]);

    if(usingcarwash == playerid)
    {
      SetVehicleToRespawn(GetPlayerVehicleID(playerid));
      usingcarwash = -1;
      Update3DTextLabelText(entrancetext, 0x008B00FF, "��������� ���������.\n������� (/carwash)");
    }
	return 1;
}

public MSeconds()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(Glow[i]==0)
		{
			GlowColor = GlowColor+1;
        	if(GlowColor==36)
			{
				GlowColor=1;
			}
        	SetPlayerColor(i,GlowColors[GlowColor]);
		}
	}
	return 1;
}
//==============================================================================
public OnPlayerSpawn(playerid) // ��� ������ ������
{

    if(PlayerInfo[playerid][pSkin] == 0)
    {
      ShowPlayerDialog(playerid, 5307, DIALOG_STYLE_LIST,"{0077FF}Blodhamer Drift :{ffffff}������� ���� ?", ">> [1] �������\n>> [2] {ff0000}������ ", "��� :)", "");
    }
   	SetPlayerPos(playerid,314.7714,-240.2481,1.5781);
	SetPlayerFacingAngle(playerid, 360.0000);
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	//-------------------
	TextDrawShowForPlayer( playerid, Textdraw0[playerid] );
    TextDrawShowForPlayer( playerid, Textdraw1[playerid] );
    TextDrawShowForPlayer( playerid, Textdraw2 );
   	StopAudioStreamForPlayer(playerid); // ����� ��� ������ �� ������
	//TogglePlayerClock(playerid,1); // ������� ����
	GivePlayerWeapon(playerid,5,1); // ���� ��� ��������
	GivePlayerWeapon(playerid,43,77); // ������ ��� ��������
	GivePlayerWeapon(playerid,46,100); // ������� ��� ��������
	//------------------------------------------------------------------------------
	SetCameraBehindPlayer(playerid); // ������ ��� ����
	//------------------------------------------------------------------------------
	return 1;
}
//==============================================================================
public OnPlayerPickUpPickup(playerid, pickupid) // ������
{
	if(pickupid == dje) // ���� � ����� ����
	{
		SetPlayerPos(playerid, -2637.4500,1405.9532,906.4609);
		SetPlayerInterior(playerid, 3);
	}
	//------------------------------------------------------------------------------
	if(pickupid == djq) // ����� �� ����� �����
	{
		SetPlayerPos(playerid, -2624.8923,1409.2222,7.0938);
		SetPlayerInterior(playerid, 0);
	}
	//------------------------------------------------------------------------------
	if(pickupid == LVSSENTER) // ���� � ����-��� � ��
	{
		SetPlayerPos(playerid, -100.3639,-21.3062,1000.7188);
		SetPlayerInterior(playerid, 3);
	}
	//------------------------------------------------------------------------------
	if(pickupid == LVSSEXIT) // ����� �� ����-���� � ��
	{
		SetPlayerPos(playerid, 2089.5200,2074.4800,10.8203);
		SetPlayerInterior(playerid, 0);
	}
	//------------------------------------------------------------------------------
	if(pickupid == LVCCENTER) // ���� � ������ ��������
	{
		SetPlayerPos(playerid, 2233.9075,1710.4777,1011.2206);
		SetPlayerInterior(playerid, 1);
	}
	//------------------------------------------------------------------------------
	if(pickupid == LVCCEXIT) // ����� �� ������ ��������
	{
		SetPlayerPos(playerid, 2193.6367,1676.6332,12.3672);
		SetPlayerInterior(playerid, 0);
	}
	//------------------------------------------------------------------------------
	if(pickupid == LVDRAGONENTER) // ���� � ������ 4 �������
	{
		SetPlayerPos(playerid, 2015.4500,1017.0900,996.8750);
		SetPlayerInterior(playerid, 10);
	}
	//------------------------------------------------------------------------------
	if(pickupid == LVDRAGONEXIT) // ����� �� ������ 4 �������
	{
		SetPlayerPos(playerid, 2022.6882,1007.2611,10.8203);
		SetPlayerInterior(playerid, 0);
	}
	//------------------------------------------------------------------------------
	if(pickupid == LVDISCOENTER) // ���� � ���� � ��
	{
		SetPlayerPos(playerid, 493.2131,-21.1337,1000.6797);
		SetPlayerInterior(playerid, 17);
	}
	//------------------------------------------------------------------------------
	if(pickupid == LVDISCOEXIT) // ����� �� ����� � ��
	{
		SetPlayerPos(playerid, 1833.6759,-1681.7500,13.4634);
		SetPlayerInterior(playerid, 0);
	}
	//------------------------------------------------------------------------------
	if(pickupid == LVLSPDENTER) // ���� � ����������� ����������� � ��
	{
		SetPlayerPos(playerid, 246.7836,64.9720,1003.6406);
		SetPlayerInterior(playerid, 6);
	}
	//------------------------------------------------------------------------------
	if(pickupid == LVLSPDEXIT) // ����� �� ������������ ������������ � ��
	{
		SetPlayerPos(playerid, 1552.1062,-1675.0248,16.1408);
		SetPlayerInterior(playerid, 0);
	}
	//------------------------------------------------------------------------------
	if(pickupid == LVJMENTER) // ���� � ����� ����������
	{
		SetPlayerPos(playerid, 2216.8081,-1150.5562,1025.7969);
		SetPlayerInterior(playerid, 15);
	}
	//------------------------------------------------------------------------------
	if(pickupid == LVJMEXIT) // ����� �� ����� ����������
	{
		SetPlayerPos(playerid, 2229.0200,-1159.8000,25.7981);
		SetPlayerInterior(playerid, 0);
	}
	return 1;
}
//==============================================================================
public OnVehicleSpawn(vehicleid) // ��� ������ ����
{
	switch (GetVehicleModel(vehicleid))
	{
    case 560: {SetVehicleNumberPlate(vehicleid,"{00ff00}Elegy");} // Elegy �������� ����
	}
	return 1;
}
//==============================================================================
public OnPlayerUpdate(playerid)
{
    new string[128];
	//------------------------------------------------------------------------------
	//------------------------------------------------------------------------------
    new score = GetPlayerScore(playerid);
    format( string, sizeof string, "FRAG:~r~ %d~w~/~r~%d", score ,Moder[playerid]);
    TextDrawSetString(Textdraw0[playerid], string);
    format( string, sizeof string, "RANG:~r~ %s",RangName(playerid));
    TextDrawSetString( Textdraw1[playerid], string );
	
	if(GetPlayerState(playerid) == 2)
	{
		SetSpeedDel(playerid);
		SetSpeedPok(playerid);
	}
	//-[������� �� ������]----------------------------------------------------------
	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 9) // ���������
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------
	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 16) // �������
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 17) // ������������ ���
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 18) // �������� ��������
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 19) // ����������
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 20) // ����������
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 21) // ����������
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 22) // ��������
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------
	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 24) // ����
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------
	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 26) // ��������
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------
	//------------------------------------------------------------------------------
	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 33) // ��������
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------

	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 35) // �������� �������� ��������� �1
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 36) // �������� �������� ��������� �2
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------

	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 38) // �������
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 39) // �����
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 40) // ���������
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 41) // ��������
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 42) // ������������
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------
	/*if(GetPlayerWeapon(playerid) == 43) // ������
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}*/
	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 44) // ������ �������
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------
	if(GetPlayerWeapon(playerid) == 45) // �������� �������
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}
	//------------------------------------------------------------------------------
	/*if(GetPlayerWeapon(playerid) == 46) // �������
	{
		ResetPlayerWeapons(playerid);
		return 1;
	}*/
	//------------------------------------------------------------------------------
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
	{
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{ffffff} ����� [%s] ��� ������ {FFFF00}( �������: Jetpack ).",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		Kick(playerid);
		return 1;
	}

	return 1;
}

//==============================================================================
forward Reklama(); // ��� �������
public Reklama()
{
	SendClientMessageToAll(0x21DD00FF, "{0077FF}Blodhamer Drift :{ffffff} ����� ����: ALT (������), 2 (� ������),  /menu (���� �� ��������, ��� ALT � 2).");
	SendClientMessageToAll(0x21DD00FF, "{0077FF}Blodhamer Drift :{ffffff} ���� �� ��� ������ ��� � �� ��������� ��� ��� ������, ����� ������� �������: /help");
	SendClientMessageToAll(0x21DD00FF, "{0077FF}Blodhamer Drift :{ffffff} �� ��������� �������� ������ � {0015FF}vk.com {ffffff}: https://vk.com/blodhamerdrift.server");
	SendClientMessageToAll(0x21DD00FF, "{0077FF}Blodhamer Drift :{ffffff} ������� �������|������ {0015FF}Skype {ffffff}: faiik_3gps");
	return 1;
}
//==============================================================================
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{

	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    new panels, doors, lights, tires;
    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
    UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
	return 1;
}
//==============================================================================
public OnPlayerDeath(playerid, killerid, reason) // ����� ������� �����
{
	new pname[max_line], kname[max_line], wname[max_line], msg[max_line];
	GetPlayerName(playerid,pname,max_line);
	GetPlayerName(killerid,kname,max_line);
	GetWeaponName(reason,wname,max_line);
	//------------------------------------------------------------------------------
	if(reason==54) format(msg,max_line,"{0077FF}Blodhamer Drift {ffffff}: [%s] {ff0000}��������.",pname); else
	if(reason==49) format(msg,max_line,"{0077FF}Blodhamer Drift {ffffff}: [%s] {ff0000}��� ��������.",pname); else
	if(reason==53) format(msg,max_line,"{0077FF}Blodhamer Drift {ffffff}: [%s] {ff0000}������.",pname); else
	if(reason==255) format(msg,max_line,"{0077FF}Blodhamer Drift {ffffff}: [%s] {ff0000}�����.",pname); else
	if(IsPlayerConnected(killerid)) format(msg,max_line,"{0077FF}Blodhamer Drift {ffffff}: [%s] {ff0000}���� � ������ ( %s ).",
	kname,pname,wname); SendClientMessageToAll(0x21DD00FF,msg);
	//------------------------------------------------------------------------------
	GameTextForPlayer(playerid,"~r~Ymep...",4000,3); // ����� �� �������� ������ ����� ����� �������
	SetSpawnInfo(playerid,0,0,1958.33,1343.12,15.36,269.15,0,0,0,0,0,0);
	SpawnPlayer(playerid);
	//SendDeathMessage(killerid,playerid,reason); // �������� ��� ��� ����
	if(usingcarwash == playerid)
    {
      SetVehicleToRespawn(GetPlayerVehicleID(playerid));
      usingcarwash = -1;
      Update3DTextLabelText(entrancetext, 0x008B00FF, "��������� ���������.\n������� (/carwash)");
    }
	return 1;
}
//==============================================================================
public OnPlayerCommandText(playerid, cmdtext[]) // �������
{
	new cmd[128]; // ��� ������
	new	idx; // ��� ������
	new	tmp[256]; // ��� ������
	new string[256]; // ��� ������
	new Message[256]; // ��� ��
	new gMessage[256]; // ��� ��
	new pName[MAX_PLAYER_NAME+1]; // ��� ��
	new iName[MAX_PLAYER_NAME+1]; // ��� ��
	new giveplayerid; // ��� �����
	new moneys; // ��� �����
	new giveplayer[MAX_PLAYER_NAME]; // ��� �����
	new sendername[MAX_PLAYER_NAME]; // ��� �����
	new playermoney; // ��� �����
	//------------------------------------------------------------------------------
	cmd = strtok(cmdtext, idx); // ��� ����� ������

	//=[������]=====================================================================
	if(strcmp(cmd, "/help", true) == 0 || strcmp(cmd, "/������", true) == 0) // ������
	{
		new String[1024];
		strins(String,"{00ff00}/cmds -{ffffff} �������\n",strlen(String));
		strins(String,"{00ff00}/about -{ffffff} ����� ����\n",strlen(String));
		strins(String,"{00ff00}/rules -{ffffff} �������\n",strlen(String));
		ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"{0077FF}Blodhamer Drift :{ffffff} ������",String,"��","");
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/cmds", true) == 0 || strcmp(cmd, "/�������", true) == 0) // �������
	{
		new String[1024];
		strins(String,"{00ff00}/hi -{ffffff} ������������� �� �����\n",strlen(String));
		strins(String,"{00ff00}/bb -{ffffff} ����������� �� �����\n",strlen(String));
		strins(String,"{00ff00}/menu -{ffffff} ������� ����\n",strlen(String));
		strins(String,"{00ff00}/givecash -{ffffff} �������� ������\n",strlen(String));
		strins(String,"{00ff00}/pm -{ffffff} ��������� ��\n",strlen(String));
		strins(String,"{00ff00}/dt -{ffffff} ����������� ���\n",strlen(String));
		strins(String,"{00ff00}/repair -{ffffff} ������� ����\n",strlen(String));
		strins(String,"{00ff00}/flip -{ffffff} ����������� ����\n",strlen(String));
		strins(String,"{00ff00}/kill -{ffffff} ����� ����\n",strlen(String));
		strins(String,"{00ff00}/count -{ffffff} ������\n",strlen(String));
		strins(String,"{00ff00}/admins -{ffffff} ������ ������\n",strlen(String));
		strins(String,"{00ff00}/vips -{ffffff} VIP's ������\n",strlen(String));
		strins(String,"{00ff00}/report -{ffffff} �������� ������\n",strlen(String));
		ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"{0077FF}Blodhamer Drift :{ffffff} �������",String,"��","");
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/about", true) == 0 || strcmp(cmd, "/�����", true) == 0) // ����� ����
	{
		new String[1024];
		strins(String,"{00ff00}�������� ����:{ffffff} Mini Drift\n",strlen(String));
		strins(String,"{00ff00}�����:{ffffff} FaSTL\n",strlen(String));
		strins(String,"{00ff00}Skype:{ffffff} faiik_3gps\n",strlen(String));
		ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"{0077FF}Blodhamer Drift :{ffffff} ����� ����",String,"��","");
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/rules", true) == 0 || strcmp(cmd, "/�������", true) == 0) // �������
	{
		new String[1024];
		strins(String,"{ffffff}1. ��������� ������ ��� ����� �����.\n",strlen(String));
		strins(String,"{ffffff}2. ��������� ���������� ������� � ������ �� ������.\n",strlen(String));
		strins(String,"{ffffff}3. ��������� ������� ������� � ���������� �������.\n",strlen(String));
		strins(String,"{ffffff}4. ��������� ������������� ����� ������� ����� ����� �����.\n",strlen(String));
		strins(String,"{ffffff}5. ��������� ������� ����� ������������ ���������.\n",strlen(String));
		strins(String,"{ffffff}6. ��������� ���������� � �������.\n",strlen(String));
		strins(String,"{ffffff}7. ��������� ������������ ���� ���� � ������ ��������� �����.\n",strlen(String));
		ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"{0077FF}Blodhamer Drift :{ffffff} ������� �������",String,"��","");
		return 1;
	}
	
    if(strcmp(cmd, "/carwash", true) == 0) // ����������� ����
    {
      if(IsPlayerInRangeOfPoint(playerid, 5, 1911.1886,-1784.2952,13.0801))
      {
        if(IsPlayerInAnyVehicle(playerid))
        {
          if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
          {
		    for(new x = 0; x < sizeof(unwashable); x++)
            {
              if(GetVehicleModel(GetPlayerVehicleID(playerid)) == unwashable[x][0])
              {
		        SendClientMessage(playerid, 0xAA3333AA, "�� �� ������ ������ ��� ������.");
		        return 1;
              }
            }
            if(GetPlayerMoney(playerid) > 4)
            {
              if(usingcarwash == -1)
              {
		        GiveMoney(playerid, -100);
		        usingcarwash = playerid;
		        Update3DTextLabelText(entrancetext, 0xB0171FFF, "��������� ������.\n ���������...");
		        for(new i = 0; i < MAX_PLAYERS; i++)
                {
                  if(GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
                  {
		            TogglePlayerControllable(i, 0);
		            SetPlayerCameraPos(i,1907.8804,-1790.0590,15);
		            SetPlayerCameraLookAt(i,1911.0471,-1781.6868,13.3828);
                  }
                  if(GetPlayerSurfingVehicleID(i) == GetPlayerVehicleID(playerid))
                  {
		            SetPlayerPos(i,1906.9204,-1786.0435,13.5469);
		            SetPlayerFacingAngle(i, 270);
                  }
	            }
                SetVehiclePos(GetPlayerVehicleID(playerid), 1911.1886, -1784.2952, 13.0801);
                SetVehicleZAngle(GetPlayerVehicleID(playerid), 0);
                MoveObject(entrancegate, 1911.21130371, -1780.68151855, 10.50000000, 1);
                SetTimerEx("Autocruise",3500,0,"ii",playerid, 1);
              }
              else
              {
		        SendClientMessage(playerid, 0xAA3333AA, "�� �� ������ ��� �� ���������? ��������� ������!");
              }
            }
            else
            {
		      SendClientMessage(playerid, 0xAA3333AA, "� ���� ��� �����!");
            }
          }
          else
          {
		    SendClientMessage(playerid, 0xAA3333AA, "�� �� �� ����!");
          }
        }
        else
        {
		  SendClientMessage(playerid, 0xAA3333AA, "�� �� � ����!");
        }
      }
      else
      {
	    SendClientMessage(playerid, 0xAA3333AA, "�� �� �� ���������!");
      }
      return 1;
    }
    
    if(strcmp(cmd, "/addhouse", true, 13) == 0) // ����������� ����
    {
      if(!IsPlayerAdmin(playerid)) return 0;
      ShowPlayerDialog(playerid,11555,DIALOG_STYLE_INPUT,"�������� ���� - ��������","������� �������� ��� ����.","�����","�������");
      return 1;
    }

    else if(strcmp(cmd, "/ahlock", true, 7) == 0)
    {
      for(new h=1;h<=m_h;h++)
      {
        if(!IsPlayerInRangeOfPoint(playerid,1.5,House[h][hX],House[h][hY],House[h][hZ]))continue;
        if(House[h][hLock]==1)House[h][hLock]=0,GameTextForPlayer(playerid,"~g~House unlocked",100,1);
        else House[h][hLock]=1,GameTextForPlayer(playerid,"~r~House locked",100,1);
        SaveHouse(h);
        return 1;
      }
      return 1;
    }

    else if(strcmp(cmd, "/buyhouse", true, 9) == 0)
    {
      for(new h=1;h<=m_h;h++)
      {
        if(!IsPlayerInRangeOfPoint(playerid,1.5,House[h][hX],House[h][hY],House[h][hZ]))continue;
        if(GetPlayerMoney(playerid)<House[h][hPrice])return SendClientMessage(playerid,-1,"� ��� �� ������� �������!");
        if(strcmp(House[h][hOwner],"None",true)!=0)return SendClientMessage(playerid,-1,"��� ��� ������!");
        strmid(House[h][hOwner],Name(playerid),0,24,24),UpdateHouse(h);
        SaveHouse(h);
        GiveMoney(playerid,-House[h][hPrice]);
        SendClientMessage(playerid,-1,"�� ������� ������ ���!");
        return 1;
      }
      SendClientMessage(playerid,-1,"����� � ���� ��� ����!");
      return 1;
    }

    else if(strcmp(cmd, "/sellhouse", true, 10) == 0)
    {
      for(new h=1;h<=m_h;h++)
      {
        if(!IsPlayerInRangeOfPoint(playerid,1.5,House[h][hX],House[h][hY],House[h][hZ]))continue;
        if(!strcmp(House[h][hOwner],Name(playerid),true))
        {
          strmid(House[h][hOwner],"None",0,5,5),UpdateHouse(h);
          SaveHouse(h);
          GiveMoney(playerid,House[h][hPrice]/2);
          SendClientMessage(playerid,-1,"�� ������� ���� ���!");
          return 1;
        }
      }
      //SendClientMessage(playerid,-1,"����� � ���� ��� ����!");
      return 1;
    }

    else if(strcmp(cmd, "/enter", true, 6) == 0)
    {
      for(new h=1;h<=m_h;h++)
      {
        if(!IsPlayerInRangeOfPoint(playerid,1.5,House[h][hX],House[h][hY],House[h][hZ]))continue;
        if(strcmp(House[h][hOwner],Name(playerid),true)!=0 && House[h][hLock]==1)return SendClientMessage(playerid,-1,"��� ������!");
        SetPlayerPos(playerid,HInts[House[h][hInterior]][hiX],HInts[House[h][hInterior]][hiY],HInts[House[h][hInterior]][hiZ]);
        SetPlayerInterior(playerid,HInts[House[h][hInterior]][hiInt]);
        SetPlayerVirtualWorld(playerid,House[h][hVirtWorld]);
      }
      return 1;
    }

    else if(strcmp(cmd, "/exit", true, 5) == 0)
    {
      for(new h=1;h<=m_h;h++)
      {
        if(IsPlayerInRangeOfPoint(playerid, 4.0, HInts[House[h][hInterior]][hiX], HInts[House[h][hInterior]][hiY], HInts[House[h][hInterior]][hiZ]) && GetPlayerVirtualWorld(playerid) == House[h][hVirtWorld])
        {
          SetPlayerInterior(playerid, 0);
          SetPlayerPos(playerid, House[h][hX],House[h][hY],House[h][hZ]);
          SetPlayerVirtualWorld(playerid, 0);
        }
      }
      return 1;
    }

    else if(strcmp(cmd, "/hlock", true, 6) == 0)
    {
      for(new h=1;h<=m_h;h++)
      {
        if(!IsPlayerInRangeOfPoint(playerid,1.5,House[h][hX],House[h][hY],House[h][hZ]))continue;
        if(strcmp(House[h][hOwner],Name(playerid),true)!=0)return SendClientMessage(playerid,-1,"� ��� ��� ������ �� ����� ����!");
        if(House[h][hLock]==0)House[h][hLock]=1,SaveHouse(h),GameTextForPlayer(playerid,"~r~House locked",100,1);
        else if(House[h][hLock]==1)return SendClientMessage(playerid,-1,"��� ��� ������!");
        return 1;
      }
      return 1;
    }

    else if(strcmp(cmd, "/hopen", true, 6) == 0)
    {
      for(new h=1;h<=m_h;h++)
      {
        if(!IsPlayerInRangeOfPoint(playerid,1.5,House[h][hX],House[h][hY],House[h][hZ]))continue;
        if(strcmp(House[h][hOwner],Name(playerid),true)!=0)return SendClientMessage(playerid,-1,"� ��� ��� ������ �� ����� ����!");
        if(House[h][hLock]==1)House[h][hLock]=0,SaveHouse(h),GameTextForPlayer(playerid,"~g~House unlocked",100,1);
        else if(House[h][hLock]==0)return SendClientMessage(playerid,-1,"��� ��� ������!");
        return 1;
      }
      return 1;
    }
    
    else if(strcmp(cmd, "/garagehelp", true, 11) == 0)
{
  SendClientMessage(playerid, COLOR_ORANGE, "jGarage commands:");
  if(!IsPlayerAdmin(playerid))
  {
    SendClientMessage(playerid, COLOR_LIGHTBLUE, "/genter | /gexit | /lockgarage | /buygarage | /sellgarage");
  }
  else
  {
    SendClientMessage(playerid, COLOR_LIGHTBLUE, "/creategarage | /removegarage | /garagetypes | /genter | /gexit | /lockgarage | /buygarage | /sellgarage");
  }
  return 1;
}
    else if(strcmp(cmd, "/garagetypes", true, 12) == 0)
{
  if(!IsPlayerAdmin(playerid)) return 0;
  SendClientMessage(playerid, COLOR_ORANGE, "jGarage info - Garage types");
  SendClientMessage(playerid, COLOR_LIGHTBLUE, "Type 0: Small garage");
  SendClientMessage(playerid, COLOR_LIGHTBLUE, "Type 1: Medium garage");
  SendClientMessage(playerid, COLOR_LIGHTBLUE, "Type 2: Big garage");
  return 1;
}

    else if(strcmp(cmd, "/removegarage", true, 13) == 0)
{
  if(!IsPlayerAdmin(playerid)) return 0;
  for(new i=0; i < garageCount+1; i++)
  {
    if(IsPlayerInRangeOfPoint(playerid, 3.0, gInfo[i][PosX], gInfo[i][PosY], gInfo[i][PosZ]))
    {
      format(gInfo[i][Owner],24,"REMOVED");
      gInfo[i][Owned] = -999;
      gInfo[i][Price] = -999;
      gInfo[i][Interior] = -999;
      gInfo[i][UID] = -999;
      gInfo[i][PosX] = -999;
      gInfo[i][PosY] = -999;
      gInfo[i][PosZ] = -999;
      gInfo[i][Locked] = -999;
      DestroyDynamic3DTextLabel(garageLabel[i]);
      DestroyDynamicPickup(garagePickup[i]);
      new path[128];
      format(path,sizeof(path),"garages/%d.ini",i); //Format the path with the filenumber
      dini_Remove(path);
      SendClientMessage(playerid, COLOR_SUCCESS, "You have removed this garage.");
      return 1;
    }
  }
  SendClientMessage(playerid, COLOR_ERROR,"Error: You're not near any garage.");
  return 1;
}
    else if(strcmp(cmd, "/genter", true, 7) == 0)
{
  for(new i=0; i < garageCount+1; i++)
  {
    if(IsPlayerInRangeOfPoint(playerid, 3.0, gInfo[i][PosX], gInfo[i][PosY], gInfo[i][PosZ]))
    {
      if(gInfo[i][Locked] == 1 && strcmp(GetPlayerNameEx(playerid),gInfo[i][Owner])) return SendClientMessage(playerid,COLOR_ERROR,"Error: You're not the owner of this garage. It's locked, you can't enter.");
      new gtype = gInfo[i][Interior];
      if(!IsPlayerInAnyVehicle(playerid))
      {
        SetPlayerVirtualWorld(playerid,gInfo[i][UID]);
        SetPlayerInterior(playerid,floatround(GarageInteriors[gtype][4]));
        SetPlayerPos(playerid,GarageInteriors[gtype][0],GarageInteriors[gtype][1],GarageInteriors[gtype][2]);
        lastGarage[playerid] = i;
      }
      else
      {
        new vid = GetPlayerVehicleID(playerid);
        LinkVehicleToInterior(vid,floatround(GarageInteriors[gtype][4]));
        SetVehicleVirtualWorld(vid,gInfo[i][UID]);
        SetPlayerVirtualWorld(playerid,gInfo[i][UID]);
        SetPlayerInterior(playerid,floatround(GarageInteriors[gtype][4]));
        SetVehiclePos(vid,GarageInteriors[gtype][0],GarageInteriors[gtype][1],GarageInteriors[gtype][2]);
        lastGarage[playerid] = i;
      }
      return 1;
    }
  }
  SendClientMessage(playerid,COLOR_ERROR,"Error: You're not near any garage. ");
  return 1;
}
    else if(strcmp(cmd, "/gexit", true, 6) == 0)
{
  if(lastGarage[playerid] >= 0)
  {
    new lg = lastGarage[playerid];
    if(!IsPlayerInAnyVehicle(playerid))
    {
      SetPlayerPos(playerid,gInfo[lg][PosX],gInfo[lg][PosY],gInfo[lg][PosZ]);
      SetPlayerInterior(playerid,0);
      SetPlayerVirtualWorld(playerid,0);
    }
    else
    {
      new vid = GetPlayerVehicleID(playerid);
      LinkVehicleToInterior(vid,0);
      SetVehicleVirtualWorld(vid,0);
      SetVehiclePos(vid,gInfo[lg][PosX],gInfo[lg][PosY],gInfo[lg][PosZ]);
      SetPlayerVirtualWorld(playerid,0);
      SetPlayerInterior(playerid,0);
    }
    lastGarage[playerid] = -999;
  }
  else return SendClientMessage(playerid,COLOR_ERROR,"Error: You're not in any garage.");
  return 1;
}
    else if(strcmp(cmd, "/buygarage", true, 10) == 0)
{
  for(new i=0; i < garageCount+1; i++)
  {
    if(IsPlayerInRangeOfPoint(playerid, 3.0, gInfo[i][PosX], gInfo[i][PosY], gInfo[i][PosZ]))
    {
      if(gInfo[i][Owned] == 1) return SendClientMessage(playerid, COLOR_ERROR,"Error: This garage is already owned.");
      if(GetPlayerMoney(playerid) < gInfo[i][Price]) return SendClientMessage(playerid,COLOR_ERROR,"Error: You don't have enough money to buy this garage.");
      GiveMoney(playerid,-gInfo[i][Price]);
      gInfo[i][Price]-= random(5000); //Take some money off of the original price
      format(gInfo[i][Owner],24,"%s",GetPlayerNameEx(playerid));
      gInfo[i][Owned] = 1;
      Save_Garage(i);
      UpdateGarageInfo(i);
      SendClientMessage(playerid,COLOR_SUCCESS,"You have successfully bought this garage.");
      return 1;
    }
  }
  SendClientMessage(playerid,COLOR_ERROR,"Error: You're not near any garage.");
  return 1;
}
    else if(strcmp(cmd, "/lockgarage", true, 11) == 0)
{
  for(new i=0; i < garageCount+1; i++)
  {
    if(IsPlayerInRangeOfPoint(playerid, 3.0, gInfo[i][PosX], gInfo[i][PosY], gInfo[i][PosZ]))
    {
      if(strcmp(gInfo[i][Owner],GetPlayerNameEx(playerid))) return SendClientMessage(playerid,COLOR_ERROR,"Error: You're not the owner of this garage.");
      if(gInfo[i][Locked] == 1)
      {
        gInfo[i][Locked] = 0;
        UpdateGarageInfo(i);
        Save_Garage(i);
        SendClientMessage(playerid,COLOR_SUCCESS,"You have unlocked your garage.");
        return 1;
      }
      else
      {
        gInfo[i][Locked] = 1;
        UpdateGarageInfo(i);
        Save_Garage(i);
        SendClientMessage(playerid,COLOR_SUCCESS,"You have locked your garage.");
        return 1;
      }
    }
  }
  SendClientMessage(playerid,COLOR_ERROR,"Error: You're not near any garage.");
  return 1;
}
    else if(strcmp(cmd, "/sellgarage", true, 11) == 0)
{
  for(new i=0; i < garageCount+1; i++)
  {
    if(IsPlayerInRangeOfPoint(playerid, 3.0, gInfo[i][PosX], gInfo[i][PosY], gInfo[i][PosZ]))
    {
      if(strcmp(gInfo[i][Owner],GetPlayerNameEx(playerid))) return SendClientMessage(playerid,COLOR_ERROR,"Error: You're not the owner of this garage.");
      GiveMoney(playerid,gInfo[i][Price]-random(500));
      gInfo[i][Owned] = 0;
      format(gInfo[i][Owner],24,"the State");
      gInfo[i][Locked] = 1;
      UpdateGarageInfo(i);
      Save_Garage(i);
      SendClientMessage(playerid, COLOR_SUCCESS,"You have successfully sold your garage.");
      return 1;
    }
  }
  SendClientMessage(playerid, COLOR_ERROR,"You're not near any garage.");
  return 1;
}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/qq", true) == 0 || strcmp(cmd, "/hi", true) == 0) // �������������� ����
	{
		new strings[256], frog[MAX_PLAYER_NAME];
		GetPlayerName(playerid, frog, sizeof(frog));
		format(strings, sizeof(strings), "{0077FF}Blodhamer Drift :{00FF08}%s {00FF37}������������ ���� �������", frog);
		SendClientMessageToAll(0x21DD00FF, strings);
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/bb", true) == 0 || strcmp(cmd, "/��", true) == 0) // ����������� �� �����
	{
		new strings[256], frog[MAX_PLAYER_NAME];
		GetPlayerName(playerid, frog, sizeof(frog));
		format(strings, sizeof(strings), "{0077FF}Blodhamer Drift :{00FF08}%s {00FF37}��������� �� ����� ��������", frog);
		SendClientMessageToAll(0x21DD00FF, strings);
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/repair", true) == 0) // ������� ����
	{
		RepairVehicle(GetPlayerVehicleID(playerid));
		SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ffffff} �� �������� ��� ����.");
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/flip", true) == 0) // ����������� ����
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0);
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ffffff} �� ����������� ��� ����.");
		}
	}

	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/pm", true, 10) == 0) // ������ ���������
	{
		tmp = strtok(cmdtext,idx);

		if(!strlen(tmp) || strlen(tmp) > 5)
		{
			SendClientMessage(playerid,0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} /pm [id] [���������] - ������ ���������.");
			return 1;
		}
        new id = strval(tmp);
		gMessage = strrest(cmdtext,idx);

		if(!strlen(gMessage)) {
			SendClientMessage(playerid,0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} /pm [id] [���������] - ������ ���������.");
			return 1;
		}

		if(!IsPlayerConnected(id))
		{
			SendClientMessage(playerid,0x21DD00FF,"{0077FF}Blodhamer Drift :{ff0000} ������ ������ ����.");
			return 1;
		}

		if(playerid != id)
		{
			GetPlayerName(id,iName,sizeof(iName));
			GetPlayerName(playerid,pName,sizeof(pName));
			format(Message,sizeof(Message),"�� ��������� ��������� ������ %s(%d): %s",iName,id,gMessage);
			SendClientMessage(playerid,0xFFFFFFAA,Message);
			format(Message,sizeof(Message),"���� ������ ������ ��������� �� %s(%d): %s",pName,playerid,gMessage);
			SendClientMessage(id,0xFFFFFFAA,Message);
			PlayerPlaySound(id,1085,0.0,0.0,0.0);
		}
		else
		{
			SendClientMessage(playerid,0x21DD00FF,"{0077FF}Blodhamer Drift :{ff0000} ������ ������ ����.");
		}
		return 1;
	}
	
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/givecash", true, 10) == 0) // �������� ����� � ������ �������
	{
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp))
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /givecash [id] [�����] - �������� ������.");
			return 1;
		}
		giveplayerid = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /givecash [id] [�����] - �������� ������.");
			return 1;
		}
		moneys = strval(tmp);
		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			playermoney = GetSRVMoney(playerid);
			if (moneys > 0 && playermoney >= moneys)
			{
				GiveMoney(playerid, (0 - moneys));
				GiveMoney(giveplayerid, moneys);
				format(string, sizeof(string), "{0077FF}Blodhamer Drift :{FFFF00} �� ��������� ������ %s[%d] ����� $%d.", giveplayer,giveplayerid, moneys);
				SendClientMessage(playerid, 0x21DD00FF, string);
				format(string, sizeof(string), "{0077FF}Blodhamer Drift :{FFFF00} �� �������� $%d �� ������ %s[%d].", moneys, sendername, playerid);
				SendClientMessage(giveplayerid, 0x21DD00FF, string);
			}
			else
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} � ��� ��� ����� �����.");
			}
		}
		else
		{
			format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������ � id %d ������������.", giveplayerid);
			SendClientMessage(playerid, 0x21DD00FF, string);
		}
		return 1;
	}
	//-----[Radio]------------------------------------------------------------------------
	if(strcmp(cmdtext, "/radio", true) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
			ShowPlayerDialog(playerid, RADIO, DIALOG_STYLE_LIST, "�������� ����� �����:","������ FM\n������ ����\nMaks FM\nICE FM\n{FF3300}��������� �����", "Ok", "�����");
		}
		return 1;
	}
	//##################################[�������]###################################
	if(strcmp(cmd, "/adminka", true) == 0 || strcmp(cmd, "/adm", true) == 0) // ������ �������
	{
		if(IsPlayerConnected(playerid))
		{
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				SendClientMessage(playerid, 0xFFFFFFAA,"��������� �������:");
			}

			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "1-�������: /a /saveall /getid ");
			}

			if (PlayerInfo[playerid][pAdmin] >= 2)
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "2-�������: /ip /int /skin ");
			}

			if (PlayerInfo[playerid][pAdmin] >= 3)
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "3-�������: /boom /god /cc ");
			}

			if (PlayerInfo[playerid][pAdmin] >= 4)
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "4-�������: /time /weather /warn /unwarn");
			}

			if (PlayerInfo[playerid][pAdmin] >= 5)
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "5-�������: /goto /gethere /giveweapon /disarm /givemoney");
			}

			if (PlayerInfo[playerid][pAdmin] >= 6)
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "6-�������: /jail /unjail /kick /mute /killp");
			}

			if (PlayerInfo[playerid][pAdmin] >= 7)
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "7-�������: /sethp /setarm /setmoney /ban /setcmd");
			}

			if (PlayerInfo[playerid][pAdmin] >= 8)
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "8-�������: /moneyall /disarmall /setallhp /killall /getall");
			}

			if (PlayerInfo[playerid][pAdmin] >= 9)
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "9-�������: /setscore /tpto /setint ");
			}

			if (PlayerInfo[playerid][pAdmin] >= 10)
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "10-�������: /setlevel /gmx /delakk /achat /g");
			}
			else
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
			}
			return 1;
		}
	}
	//##################################[�������]###################################
	if(strcmp(cmd, "/vipka", true) == 0 || strcmp(cmd, "/vipon", true) == 0) // ������ �������
	{
		if(IsPlayerConnected(playerid))
		{
			if (PlayerInfo[playerid][pVIP] >= 1)
			{
				SendClientMessage(playerid, 0xFFFFFFAA,"VIP �������:");
			}

			if (PlayerInfo[playerid][pVIP] >= 1)
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "1-�������: /v /vskin /vboom ");
			}

			if (PlayerInfo[playerid][pVIP] >= 2)
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "2-�������: /vhp /vgoto /vkill ");
			}

			if (PlayerInfo[playerid][pVIP] >= 3)
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "3-�������: /vIp /vgod /vdiv ");
			}
			if (PlayerInfo[playerid][pVIP] >= 4)
			{
				SendClientMessage(playerid, 0xFFFFFFAA, "4-�������: /setvip ");
			}
			else
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� VIP's �������.");
			}
			return 1;
		}
	}
	
	//[��� ������� �������]=========================================================
	if(strcmp(cmd, "/admins", true) == 0) // ��������� ��� �� ������� ������
	{
		new admins;
		SendClientMessage(playerid, 0x21DD00FF, "�������������� �������:");
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(PlayerInfo[i][pAdmin] > 0)
			{
				new str[256];
				format(str, sizeof(str), " %s ", oGetPlayerName(i));
				SendClientMessage(playerid, 0xFFFFFFAA, str);
				admins++;
			}
		}
		if(admins == 0)
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} ��������������� {2FFF00}OnLine {ff0000}����.");
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �������� ������� ���������� � Skype: {ffffff}faiik_3gps");
		}
		admins = 0;
		return 1;
	}
	
	if(strcmp(cmd, "/vips", true) == 0) // ��������� ��� �� ������� ������
	{
		new VIP;
		SendClientMessage(playerid, 0x21DD00FF, "VIP's �������:");
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(PlayerInfo[i][pVIP] > 0)
			{
				new str[256];
				format(str, sizeof(str), " %s ", oGetPlayerName(i));
				SendClientMessage(playerid, 0xFFFFFFAA, str);
				VIP++;
			}
		}
		if(VIP == 0)
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} VIP's {2FFF00}OnLine {ff0000}����.");
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �������� VIP ���������� � Skype: {ffffff}faiik_3gps");
		}
		VIP = 0;
		return 1;
	}
	if(strcmp(cmdtext,"/vboom",true)==0) // �������� ����
	{
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pVIP] >= 1)
		{
			SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ��������� ����...");
			new Float:slx,Float:sly,Float:slz;
			GetPlayerPos(playerid, slx, sly, slz);
			CreateExplosion(slx, sly , slz, 7, 10.0);
			CreateExplosion(slx+1, sly+1 , slz, 7, 10.0);
			CreateExplosion(slx-1, sly-1 , slz, 7, 10.0);
			CreateExplosion(slx+1, sly , slz, 7, 10.0);
			CreateExplosion(slx, sly+1 , slz, 7, 10.0);
			CreateExplosion(slx-1, sly , slz, 7, 10.0);
			CreateExplosion(slx, sly-1 , slz, 7, 10.0);
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� VIP's �������.");
		}
		return 1;
	}
	//vip 2
	if(strcmp(cmdtext,"/vgod",true)==0) // ������� ���� ����������
	{
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pVIP] >= 3)
		{
			SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ������� ���� ����������.");
			SetPlayerHealth(playerid, 999999);
			SetPlayerArmour(playerid, 999999);
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� VIP's �������.");
		}
		return 1;
	}
	
    
	if(strcmp(cmd, "/vgoto", true) == 0) // ����������������� � ������
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /vgoto [id] - ����������������� � ������.");
			return 1;
		}
		new targetid = strval(tmp);
		new Float:targetX, Float:targetY, Float:targetZ, Float:targetA;
		if(IsPlayerConnected(targetid))
		{
			if(targetid != INVALID_PLAYER_ID)
			{
				if(PlayerInfo[playerid][pVIP] > 2)
				{
					GetPlayerPos(targetid, targetX, targetY, targetZ);
					GetPlayerFacingAngle(targetid, targetA);
					if(GetPlayerState(playerid) != 2)
					{
						if(GetPlayerInterior(playerid) != GetPlayerInterior(targetid))
						{
							SetPlayerInterior(playerid, GetPlayerInterior(targetid));
						}
						if(GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(targetid))
						{
							SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
						}
						SetPlayerPos(playerid, targetX, targetY, targetZ+2.0);
						SetPlayerFacingAngle(playerid, targetA);
					}
					else
					{
						if(GetPlayerInterior(playerid) != GetPlayerInterior(targetid))
						{
							SetPlayerInterior(playerid, GetPlayerInterior(targetid));
						}
						if(GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(targetid))
						{
							SetPlayerVirtualWorld(GetPlayerVehicleID(playerid), GetPlayerVirtualWorld(targetid));
							if(GetPlayerInterior(playerid) == GetPlayerInterior(targetid))
							{
								SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GetPlayerVirtualWorld(targetid));
							}
						}
						SetVehiclePos(GetPlayerVehicleID(playerid), targetX, targetY, targetZ+2.0);
						SetVehicleZAngle(GetPlayerVehicleID(playerid), targetA);
					}
				}
				else
				{
					SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� VIP's �������.");
				}
			}
		}
		else
		{
			format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������ � id %d ������������.", targetid);
			SendClientMessage(playerid, 0x21DD00FF, string);
		}
		return 1;
	}
	
	if(strcmp(cmdtext,"/vkill",true)==0) // ������� ���� ����������
	{
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pVIP] >= 2)
		{
			SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ����� ����.");
		    SetPlayerHealth(playerid, -999);
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� VIP's �������.");
		}
		return 1;
	}
	
	if(strcmp(cmdtext,"/vhp",true)==0) // ������� ���� ����������
	{
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pVIP] >= 2)
		{
			SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ��������� ����� � �����.");
		    SetPlayerArmour(playerid, 100);
	        SetPlayerHealth(playerid, 100);
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� VIP's �������.");
		}
		return 1;
	}
	
    if(strcmp(cmdtext,"/vdiv",true)==0) // ������� ���� ����������
	{
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pVIP] >= 3)
		{
		new Float:x;
        new Float:y;
		new Float:z;
		GivePlayerWeapon(playerid,46,1);
		GetPlayerPos(playerid,x,y,z);
		SetPlayerPos(playerid,x,y,z+2000);
		SendClientMessage(playerid,0x21DD00FF,"{0077FF}Blodhamer Drift :{ffffff} ����...");
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� VIP's �������.");
		}
		return 1;
	}

	
    if(strcmp(cmd, "/vIp", true) == 0) // ������ IP ������
     {
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /ip [id] - ������ IP ������.");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pVIP] >= 3)
		{
			if(IsPlayerConnected(giveplayerid))
			{
				new playerip[256];
				GetPlayerIp(giveplayerid, playerip, sizeof(playerip));
				format(string, sizeof(string),"{0077FF}Blodhamer Drift :{ffffff} IP ������ %s(%i): %s ",giveplayer, giveplayerid, playerip);
				SendClientMessage(playerid, 0x21DD00FF, string);
			}
			else
			{
				format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������ ������ ����.", giveplayer);
				SendClientMessage(playerid, 0x21DD00FF, string);
			}
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� VIP's �������.");
			return 1;
		}
		return 1;
	}
	
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/report", true) == 0) // �������� ������
	{
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /report [�����] - �������� ������.");
			return 1;
		}
		format(string, sizeof(string), "������: ����� �������� %s(ID:%d):{ffffff} %s.", oGetPlayerName(playerid), playerid, (result));
		for(new i; i < MAX_PLAYERS; i++)
		{
			if(PlayerInfo[i][pAdmin] > 0)
			{
				SendClientMessage(i,0x21DD00FF, string);
			}
		}
		SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ffffff} ������ ��������� �������.");
		return 1;
	}
	//------------------------------------------------------------------------------
	if (strcmp("/kill", cmdtext, true, 10) == 0) // ����� �������
	{
		SetPlayerHealth(playerid, -999);
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{ff0000} �� ����� ����...");
		return 1;
	}
	//vip 1
	if(strcmp(cmd, "/v", true) == 0) // �������� �� VIP
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new length = strlen(cmdtext);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /v [���������] - �������� �� VIP's.");
			return 1;
		}
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pVIP] >= 1)
		{
			format(string, sizeof(string), "[%d-�������]{00ff00} VIP's %s:{ffffff} %s",PlayerInfo[playerid][pVIP], sendername, result);
			SendClientMessageToAll(0xFFFFFFAA,string);
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� VIP's �������.");
			return 1;
		}
		return 1;
	}
	//[1-�������]===================================================================
	if(strcmp(cmd, "/a", true) == 0) // �������� �� ������
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new length = strlen(cmdtext);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /a [���������] - �������� �� ������.");
			return 1;
		}
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pAdmin] >= 1)
		{
			format(string, sizeof(string), "[%d-�������]{00ff00} A���� %s:{ffffff} %s",PlayerInfo[playerid][pAdmin], sendername, result);
			SendClientMessageToAll(0xFFFFFFAA,string);
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
			return 1;
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/saveall", true) == 0) // ��������� ��� ��������
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SaveAccounts(); // ��� ���������� ���������
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} �� ��������� ��� ��������.");
		}
		return 1;
	}
	//[2-�������]===================================================================
	if(strcmp(cmd, "/ip", true) == 0) // ������ IP ������
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /ip [id] - ������ IP ������.");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pAdmin] >= 2)
		{
			if(IsPlayerConnected(giveplayerid))
			{
				new playerip[256];
				GetPlayerIp(giveplayerid, playerip, sizeof(playerip));
				format(string, sizeof(string),"{0077FF}Blodhamer Drift :{ffffff} IP ������ %s(%i): %s ",giveplayer, giveplayerid, playerip);
				SendClientMessage(playerid, 0x21DD00FF, string);
			}
			else
			{
				format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������ ������ ����.", giveplayer);
				SendClientMessage(playerid, 0x21DD00FF, string);
			}
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
			return 1;
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/int", true) == 0) // �������� ��������
	{
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pAdmin] >= 2)
		{
			new vehicletype;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /int [ID ���������] - �������� ��������.");
				return 1;
			}
			vehicletype = strval(tmp);
			format(string, sizeof(string), "{0077FF}Blodhamer Drift :{FFFF00} �������� ������ �� %d.", vehicletype);
			SendClientMessage(playerid,0x21DD00FF,string);
			SetPlayerInterior(playerid, vehicletype);
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
		}
		return 1;
	}
	//[3-�������]===================================================================
	if(strcmp(cmdtext,"/boom",true)==0) // �������� ����
	{
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pAdmin] >= 3)
		{
			SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ��������� ����...");
			new Float:slx,Float:sly,Float:slz;
			GetPlayerPos(playerid, slx, sly, slz);
			CreateExplosion(slx, sly , slz, 7, 10.0);
			CreateExplosion(slx+1, sly+1 , slz, 7, 10.0);
			CreateExplosion(slx-1, sly-1 , slz, 7, 10.0);
			CreateExplosion(slx+1, sly , slz, 7, 10.0);
			CreateExplosion(slx, sly+1 , slz, 7, 10.0);
			CreateExplosion(slx-1, sly , slz, 7, 10.0);
			CreateExplosion(slx, sly-1 , slz, 7, 10.0);
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmdtext,"/god",true)==0) // ������� ���� ����������
	{
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pAdmin] >= 3)
		{
			SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ������� ���� ����������.");
			SetPlayerHealth(playerid, 999999);
			SetPlayerArmour(playerid, 999999);
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/cc", true) == 0) // �������� ���
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			SendClientMessageToAll(0xFFFFFFFF, "");
			new PlayerName[MAX_PLAYER_NAME];
			GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
			format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� {00F7F7}%s(%d) {ff0000}������� ���...",PlayerName,playerid);
			SendClientMessageToAll(0x21DD00FF, string);
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd,"/eject",true) == 0) // �������� �� ������ ������
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid,0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} /eject [id] - �������� ������ �� ������.");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pAdmin] >= 3)
		{
			if(IsPlayerConnected(giveplayerid))
			{
				if(IsPlayerInAnyVehicle(giveplayerid))
				{
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(giveplayerid, giveplayer, sizeof(sendername));
					RemovePlayerFromVehicle(giveplayerid);
					format(string, sizeof(string), "{0077FF}Blodhamer Drift :{FFFF00} ����� %s ������� ��� �� ������.", sendername);
					SendClientMessage(giveplayerid, 0x21DD00FF, string);
					format(string, sizeof(string), "{0077FF}Blodhamer Drift :{FFFF00} ����� %s ��� ������� �� ������ ������� %s", giveplayer, sendername);
					SendClientMessageToAll(0x21DD00FF, string);
					return 1;
				}
				else
				{
					format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������ ����� �� � ������.", giveplayer);
					SendClientMessage(playerid, 0x21DD00FF, string);
					return 1;
				}
			}
			else
			{
				format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������ ������ ����.", giveplayerid);
				SendClientMessage(playerid, 0x21DD00FF, string);
			}
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
		}

		return 1;
	}
	//[4-�������]===================================================================
	if(strcmp(cmd, "/time", true) == 0) // ���������� ����� ��� �������
	{
		if(IsPlayerConnected(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /time [�����] (0-23) - ���������� �����.");
				return 1;
			}
			new hour1;
			hour1 = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 4)
			{
				SetWorldTime(hour1);
				new PlayerName[MAX_PLAYER_NAME];
				GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
				format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� %s[%d] ������ �����.",PlayerName,playerid);
				SendClientMessageToAll(0x21DD00FF, string);
			}
			else
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
			}
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/weather", true) == 0) // �������� ������
	{
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pAdmin] >= 4)
		{
			if(IsPlayerConnected(playerid))
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /weather [ID ������] - �������� ������.");
					return 1;
				}
				new weather;
				weather = strval(tmp);
				if(weather < 0||weather > 999)
				{
					SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} ID ������ �� 0 �� 999.");
					return 1;
				}
				SetWeather(weather);
				new PlayerName[MAX_PLAYER_NAME];
				GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
				format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� %s[%d] ������ ������.",PlayerName,playerid);
				SendClientMessageToAll(0x21DD00FF, string);
			}
			else
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
			}
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/warn", true) == 0) // ������������ ������
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 1) return SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /warn [id] [�������] - ������������ ������.");
		giveplayerid = ReturnUser(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 4)
		{
			if(IsPlayerConnected(giveplayerid))
			{
				if(giveplayerid != INVALID_PLAYER_ID)
				{
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					new length = strlen(cmdtext);
					while ((idx < length) && (cmdtext[idx] <= ' '))
					{
						idx++;
					}
					new offset = idx;
					new result[64];
					while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
					{
						result[idx - offset] = cmdtext[idx];
						idx++;
					}
					result[idx - offset] = EOS;
					if(!strlen(result)) return SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /warn [id] [�������] - ������������ ������.");
					PlayerInfo[giveplayerid][pWarns] += 1;
					if(PlayerInfo[giveplayerid][pWarns] >= 3)
					{
						format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� %s(%d) ����������� ������ %s(%d) ��� 3 ���� � ������� �������� ������ {FFFF00}( �������: %s ).", sendername, playerid ,giveplayer, playerid, (result));
						SendClientMessageToAll(0x21DD00FF, string);
						PlayerInfo[giveplayerid][pBanned] = true;
						Kick(giveplayerid);
						return 1;
					}
					format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� %s(%d) ����������� ������ %s(%d) {FFFF00}( �������: %s ).", sendername, playerid ,giveplayer, playerid, (result));
					SendClientMessageToAll(0x21DD00FF, string);
					return 1;
				}
			}
			else
			{
				format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������ ������ ����.", giveplayerid);
				SendClientMessage(playerid, 0x21DD00FF, string);
			}
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/unwarn", true) == 0) // �������� ������
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 1) return SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /unwarn [id] - �������� ������.");
		giveplayerid = ReturnUser(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 4)
		{
			if(IsPlayerConnected(giveplayerid))
			{
				if(giveplayerid != INVALID_PLAYER_ID)
				{
					if(PlayerInfo[giveplayerid][pWarns] <= 0) return SendClientMessage(playerid,0x21DD00FF,"{0077FF}Blodhamer Drift :{ff0000} � ������ 0 ��������������...");
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[giveplayerid][pWarns] = PlayerInfo[giveplayerid][pWarns] - 1;
					format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} �� ����� �������������� � ������ %s.", giveplayer);
					SendClientMessage(playerid, 0x21DD00FF, string);
					format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� %s ���� � ��� ��������������. � ��� ������ %d ��������������.", sendername,PlayerInfo[giveplayerid][pWarns]);
					SendClientMessage(giveplayerid, 0x21DD00FF, string);
					return 1;
				}
			}
			else
			{
				format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������ ������ ����.", giveplayerid);
				SendClientMessage(playerid, 0x21DD00FF, string);
			}
		}
		return 1;
	}
	
	else if(strcmp(cmd, "/skin", true) == 0)
	{
		ShowModelSelectionMenu(playerid, skinlist, "Select Skin");
		PlayerPlaySound(playerid, 1132, 0.0, 0.0, 0.0);
		return 1;
	}
	//[5-�������]===================================================================
	if(strcmp(cmd, "/goto", true) == 0) // ����������������� � ������
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /goto [id] - ����������������� � ������.");
			return 1;
		}
		new targetid = strval(tmp);
		new Float:targetX, Float:targetY, Float:targetZ, Float:targetA;
		if(IsPlayerConnected(targetid))
		{
			if(targetid != INVALID_PLAYER_ID)
			{
				if(PlayerInfo[playerid][pAdmin] > 5)
				{
					GetPlayerPos(targetid, targetX, targetY, targetZ);
					GetPlayerFacingAngle(targetid, targetA);
					if(GetPlayerState(playerid) != 2)
					{
						if(GetPlayerInterior(playerid) != GetPlayerInterior(targetid))
						{
							SetPlayerInterior(playerid, GetPlayerInterior(targetid));
						}
						if(GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(targetid))
						{
							SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
						}
						SetPlayerPos(playerid, targetX, targetY, targetZ+2.0);
						SetPlayerFacingAngle(playerid, targetA);
					}
					else
					{
						if(GetPlayerInterior(playerid) != GetPlayerInterior(targetid))
						{
							SetPlayerInterior(playerid, GetPlayerInterior(targetid));
						}
						if(GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(targetid))
						{
							SetPlayerVirtualWorld(GetPlayerVehicleID(playerid), GetPlayerVirtualWorld(targetid));
							if(GetPlayerInterior(playerid) == GetPlayerInterior(targetid))
							{
								SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GetPlayerVirtualWorld(targetid));
							}
						}
						SetVehiclePos(GetPlayerVehicleID(playerid), targetX, targetY, targetZ+2.0);
						SetVehicleZAngle(GetPlayerVehicleID(playerid), targetA);
					}
				}
				else
				{
					SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
				}
			}
		}
		else
		{
			format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������ � id %d ������������.", targetid);
			SendClientMessage(playerid, 0x21DD00FF, string);
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/gethere", true) == 0) // ��������������� ������ � ����
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /gethere [id] - ��������������� ������ � ����.");
			return 1;
		}
		new targetid = strval(tmp);
		new Float:X, Float:Y, Float:Z, Float:A;
		if(IsPlayerConnected(targetid))
		{
			if(targetid != INVALID_PLAYER_ID)
			{
				if(PlayerInfo[playerid][pAdmin] > 5)
				{
					GetPlayerPos(playerid, X, Y, Z);
					GetPlayerFacingAngle(playerid, A);
					if(GetPlayerState(targetid) != 2)
					{
						if(GetPlayerInterior(targetid) != GetPlayerInterior(playerid))
						{
							SetPlayerInterior(targetid, GetPlayerInterior(playerid));
						}
						if(GetPlayerVirtualWorld(targetid) != GetPlayerVirtualWorld(playerid))
						{
							SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
						}
						SetPlayerPos(targetid, X, Y, Z+2.0);
						SetPlayerFacingAngle(targetid, A);
					}
					else
					{
						if(GetPlayerInterior(targetid) != GetPlayerInterior(playerid))
						{
							SetPlayerInterior(targetid, GetPlayerInterior(playerid));
						}
						if(GetPlayerVirtualWorld(targetid) != GetPlayerVirtualWorld(playerid))
						{
							SetPlayerVirtualWorld(GetPlayerVehicleID(targetid), GetPlayerVirtualWorld(playerid));
							if(GetPlayerInterior(targetid) == GetPlayerInterior(playerid))
							{
								SetVehicleVirtualWorld(GetPlayerVehicleID(targetid), GetPlayerVirtualWorld(playerid));
							}
						}
						SetVehiclePos(GetPlayerVehicleID(targetid), X, Y, Z+2.0);
						SetVehicleZAngle(GetPlayerVehicleID(targetid), A);
					}
					SendClientMessage(targetid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} ��� �������������� �������������...");
				}
				else
				{
					SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
				}
			}
		}
		else
		{
			format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������ � id %d ������������.", targetid);
			SendClientMessage(playerid, 0x21DD00FF, string);
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/givemoney", true) == 0) // ���� ����� ������
	{
		if(PlayerInfo[playerid][pAdmin] > 5)
		{
			tmp = strtok(cmdtext, idx);
			new name[MAX_PLAYER_NAME];
			new targetname[MAX_PLAYER_NAME];
			new targetid = strval(tmp);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /givemoney [id] [������] - ���� ����� ������.");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			new money;
			money = strval(tmp);
			if(IsPlayerConnected(targetid))
			{
				if(targetid != INVALID_PLAYER_ID)
				{
					if(!strval(tmp))
					{
						SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /givemoney [id] [������] - ���� ����� ������.");
						return 1;
					}
					if(money > 0)
					{
						GiveMoney(targetid, money);
					}
					else if(money < 0)
					{
						GiveMoney(targetid, -money);
					}
					GetPlayerName(targetid, targetname, sizeof(targetname));
					format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} �� ���� ������ %s $%d.", targetname, money);
					SendClientMessage(playerid, 0x21DD00FF, string);
					GetPlayerName(playerid, name, sizeof(name));
					format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� %s ��� ��� $%d.", name, money);
					SendClientMessage(targetid, 0x21DD00FF, string);
				}
			}
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
		}
		return 1;
	}
	//[6-�������]===================================================================
	if(strcmp(cmd, "/jail", true) == 0) // �������� � ������
	{
		if(IsPlayerConnected(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /jail [id] [�����] - �������� � ������.");
				return 1;
			}
			new playa;
			new mins;
			playa = strval(tmp);
			tmp = strtok(cmdtext, idx);
			mins = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] > 6)
			{
				if(mins < 1)
				{
					SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /jail [id] [�����] - �������� � ������.");
					return 1;
				}
				if(IsPlayerConnected(playa))
				{
					if(playa != INVALID_PLAYER_ID)
					{
						format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} �� �������� ������ %s.", oGetPlayerName(playa));
						SendClientMessage(playerid, 0x21DD00FF, string);
						format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} �� ���� �������� ��������������� %s.", oGetPlayerName(playerid));
						SendClientMessage(playa, 0x21DD00FF, string);
						ResetPlayerWeapons(playa);
						SetPlayerInterior(playa, 6);
						SetPlayerPos(playa, 264.6288,77.5742,1001.0391);
						format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ��� �������� �� %d �����.", mins);
						SendClientMessage(playa, 0x21DD00FF, string);
						PlayerPlaySound(playa, 1145, 0.0, 0.0, 0.0);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
			}
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/unjail", true) == 0) // ��������� �� ������
	{
		if(IsPlayerConnected(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /unjail [id] - ��������� �� ������.");
				return 1;
			}
			new playa;
			playa = strval(tmp);
			tmp = strtok(cmdtext, idx);
			if (PlayerInfo[playerid][pAdmin] > 6)
			{
				if(IsPlayerConnected(playa))
				{
					if(playa != INVALID_PLAYER_ID)
					{
						format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} �� ��������� ������ %s �� ������.", oGetPlayerName(playa));
						SendClientMessage(playerid, 0x21DD00FF, string);
						format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} �� ���� ����������� �� ������ ��������������� %s.", oGetPlayerName(playerid));
						SendClientMessage(playa, 0x21DD00FF, string);
						SetPlayerInterior(playa, 0);
						SetPlayerPos(playa, -292.1982,1514.3942,75.3594);
						PlayerPlaySound(playa, 1145, 0.0, 0.0, 0.0);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
			}
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/kick", true) == 0) // ������� ������
	{
		tmp = strtok(cmdtext, idx);
		new name[MAX_PLAYER_NAME];
		new targetname[MAX_PLAYER_NAME];
		new targetid = strval(tmp);
		if(PlayerInfo[playerid][pAdmin] > 6)
		{
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /kick [id] [�������] - ������� ������.");
				return 1;
			}
			if(IsPlayerConnected(targetid))
			{
				if(targetid != INVALID_PLAYER_ID)
				{
					GetPlayerName(targetid, targetname, sizeof(targetname));
					GetPlayerName(playerid, name, sizeof(name));
					new reason[256];
					reason = strrest(cmdtext, idx);
					if(!strlen(reason))
					{
						SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /kick [id] [�������] - ������� ������.");
						return 1;
					}
					format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} �� ������� ������ %s {FFFF00}( �������: %s ).", targetname, reason);
					SendClientMessage(playerid, 0x21DD00FF, string);
					format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} �� ���� ������� ��������������� %s {FFFF00}( �������: %s ).", name, reason);
					SendClientMessage(targetid, 0x21DD00FF, string);
					Kick(targetid);
					format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ����� %s ��� ������ ��������������� %s {FFFF00}( �������: %s ).", targetname, name, reason);
					SendClientMessageToAll(0x21DD00FF, string);
					return 1;
				}
			}
			else if(!IsPlayerConnected(targetid))
			{
				format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������ ������ ����.", targetid);
				SendClientMessage(playerid, 0x21DD00FF, string);
			}
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/mute", true) == 0) // �������� ������
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 6) return SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /mute [id] [�������] - ��������� ������ � ��� ������.");
		new playa,mtime;
		playa = ReturnUser(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 6)
		{
			if(IsPlayerConnected(playa))
			{
				if(playa != INVALID_PLAYER_ID)
				{
					GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					if(PlayerInfo[playa][pMuted] == 0)
					{
						tmp = strtok(cmdtext, idx);
						if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 6) return SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /mute [id] [�������] - ��������� ������ � ��� ������.");
						mtime = strval(tmp);
						PlayerInfo[playa][pMuted] = 1;
						PlayerInfo[playa][pMuteTime] = mtime;
						format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� %s(%d) �������� ��� ������ %s(%d) �� %d ������.",sendername, playerid,giveplayer, playerid, mtime);
						SendClientMessageToAll(0x21DD00FF, string);
					}
					else
					{
						PlayerInfo[playa][pMuted] = 0;
						PlayerInfo[playa][pMuteTime] = 0;
						format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� %s(%d) ������� ��� ������ %s(%d)",sendername,playerid,giveplayer,playerid);
						SendClientMessageToAll(0x21DD00FF, string);
					}
				}
			}
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/killp", true) == 0) // ����� ������
	{
		new tmp10[256];
		tmp10 = strtok(cmdtext, idx);
		if(!strlen(tmp10))
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /killp [id] - ����� ������.");
			return 1;
		}
		new playa1;
		{
			playa1 = strval(tmp10);
		}
		GetPlayerName(playa1, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pAdmin] >= 6)
		{
			SetPlayerHealth(playa1, 0.0);
			format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� %s ���� ������ %s",sendername,giveplayer);
			SendClientMessageToAll(0x21DD00FF, string);
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
		}
		return 1;
	}
	//[7-�������]===================================================================
	if(strcmp(cmd, "/sethp", true) == 0) // ���� �����
	{
		if(PlayerInfo[playerid][pAdmin] > 7)
		{
			tmp = strtok(cmdtext, idx);
			new name[MAX_PLAYER_NAME];
			new targetname[MAX_PLAYER_NAME];
			new targetid = strval(tmp);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /sethp [id] [��������] - ���������� ����� ������.");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			new health;
			health = strval(tmp);
			if(IsPlayerConnected(targetid))
			{
				if(targetid != INVALID_PLAYER_ID)
				{
					if(!strval(tmp))
					{
						SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /sethp [id] [��������] - ���������� ����� ������.");
						return 1;
					}
					SetPlayerHealth(targetid, health);
					GetPlayerName(targetid, targetname, sizeof(targetname));
					format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} �� �������� �������� ��� %s �� %d.", targetname, health);
					SendClientMessage(playerid, 0x21DD00FF, string);
					GetPlayerName(playerid, name, sizeof(name));
					format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� %s ������� ���� �������� �� %d.", name, health);
					SendClientMessage(targetid, 0x21DD00FF, string);
				}
			}
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/setarm", true) == 0) // ���� �����
	{
		if(PlayerInfo[playerid][pAdmin] > 7)
		{
			tmp = strtok(cmdtext, idx);
			new name[MAX_PLAYER_NAME];
			new targetname[MAX_PLAYER_NAME];
			new targetid = strval(tmp);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /setarm [id] [�����] - ���������� ������ �����.");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			new armour;
			armour = strval(tmp);
			if(IsPlayerConnected(targetid))
			{
				if(targetid != INVALID_PLAYER_ID)
				{
					if(!strval(tmp))
					{
						SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /setarm [id] [�����] - ���������� ������ �����.");
						return 1;
					}
					SetPlayerArmour(targetid, armour);
					GetPlayerName(targetid, targetname, sizeof(targetname));
					format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} �� �������� ����� ��� %s �� %d.", targetname, armour);
					SendClientMessage(playerid, 0x21DD00FF, string);
					GetPlayerName(playerid, name, sizeof(name));
					format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� %s ������� ���� ����� �� %d.", name, armour);
					SendClientMessage(targetid, 0x21DD00FF, string);
				}
			}
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/setmoney", true) == 0) // ���������� ������ ������
	{
		if(IsPlayerConnected(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 7) return SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /setmoney [id] [�����] - ���������� ����� ������.");
			new playa,money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 7)
			{
				if(IsPlayerConnected(playa))
				{
					if(playa != INVALID_PLAYER_ID)
					{
						PlayerInfo[playa][pMoney] = money;
						format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} �� ���������� ����� ��� ������ �� $%d...",money);
						SendClientMessage(playerid, 0x21DD00FF, string);
					}
				}
				else
				{
					SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
				}
			}
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp("/ban", cmd , true) == 0) // �������� ������
	{
		if(IsPlayerConnected(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /ban [id] [�������] - �������� ������.");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pAdmin] >= 7)
			{
				if(IsPlayerConnected(giveplayerid))
				{
					if(giveplayerid != INVALID_PLAYER_ID)
					{
						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						new length = strlen(cmdtext);
						while ((idx < length) && (cmdtext[idx] <= ' '))
						{
							idx++;
						}
						new offset = idx;
						new result[64];
						while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
						{
							result[idx - offset] = cmdtext[idx];
							idx++;
						}
						result[idx - offset] = EOS;
						if(!strlen(result))
						{
							SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /ban [id] [�������] - �������� ������.");
							return 1;
						}
						new year, month,day;
						getdate(year, month, day);
						format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ����� %s ��� ������� ��������������� %s {FFFF00}( �������: %s (%d-%d-%d) ).", giveplayer, sendername, (result),month,day,year);
						format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ����� %s ��� ������� ��������������� %s {FFFF00}( �������: %s ).", giveplayer, sendername, (result));
						SendClientMessageToAll(0x21DD00FF, string);
						PlayerInfo[giveplayerid][pAdmin] = PlayerInfo[giveplayerid][pAdmin];
						PlayerInfo[giveplayerid][pAdmin] = 0;
						PlayerInfo[giveplayerid][pBanned] = true;
						Kick(giveplayerid);
						return 1;
					}
				}
				else
				{
					SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} ������ ������ ����.");
				}
			}
			else
			{
				format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.", giveplayerid);
				SendClientMessage(playerid, 0x21DD00FF, string);
			}
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/setcmd", true) == 0) // ������ ������� ����� ������
	{
		if(IsPlayerConnected(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /setcmd [id] [�������] - ������ ������� ����� ������.");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 7)
			{
				if(IsPlayerConnected(giveplayerid))
				{
					if(giveplayerid != INVALID_PLAYER_ID)
					{
						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						new length = strlen(cmdtext);
						while ((idx < length) && (cmdtext[idx] <= ' '))
						{
							idx++;
						}
						new offset = idx;
						new result[64];
						while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
						{
							result[idx - offset] = cmdtext[idx];
							idx++;
						}
						result[idx - offset] = EOS;
						if(!strlen(result))
						{
							SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /setcmd [id] [�������] - ������ ������� ����� ������.");
							return 1;
						}
						format(string,sizeof(string),"%s",(result));
						OnPlayerCommandText(giveplayerid,string);
						format(string, 256, "{0077FF}Blodhamer Drift :{ff0000} ������������� %s ����������� ���� �������: %s �� ������: %s", sendername,(result),giveplayer);
					}
				}
				return 1;
			}
			else
			{
				format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������ ������ ����.", giveplayerid);
				SendClientMessage(playerid, 0x21DD00FF, string);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/gang", true) == 0)
	{
		ShowPlayerDialog(playerid, 12000, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ����������", "\
		>> [1] ������� �����\
		\n>> [2] ���������� �������� �����\
		\n>> [3] �������� �����\
		\n>> {ff0000}���� �� �����\
		", "�������", "������");
		return true;
 	}
	//[8-�������]===================================================================
	if(strcmp(cmd, "/moneyall", true) == 0)
	{
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pAdmin] >= 8)
		{
			for(new i = 0; i < MAX_PLAYERS; i++)
			GiveMoney(i,10000);
			new PlayerName[MAX_PLAYER_NAME];
			GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
			format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� %s[%d] ��� ���� �� 10.000 ������...",PlayerName,playerid);
			SendClientMessageToAll(0x21DD00FF, string);
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/disarmall", true) == 0) // ������ � ���� ������
	{
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pAdmin] >= 8)
		{
			for(new i = 0; i < MAX_PLAYERS; i++)
			ResetPlayerWeapons(i);
			new PlayerName[MAX_PLAYER_NAME];
			GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
			format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� %s[%d] ����� � ���� ������...",PlayerName,playerid);
			SendClientMessageToAll(0x21DD00FF, string);
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/setallhp", true) == 0) // ���� ���� �����
	{
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pAdmin] >= 8)
		{
			for(new i = 0; i < MAX_PLAYERS; i++)
			SetPlayerHealth(i,100);
			new PlayerName[MAX_PLAYER_NAME];
			GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
			format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� %s[%d] ��� ���� �����...",PlayerName,playerid);
			SendClientMessageToAll(0x21DD00FF, string);
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/killall", true) == 0) // ����� ���� �������
	{
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pAdmin] >= 8)
		{
			new PlayerName[MAX_PLAYER_NAME];
			GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
			format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� %s[%d] ���� ���� �������...",PlayerName,playerid);
			SendClientMessageToAll(0x21DD00FF, string);
			for(new i=0; i<MAX_PLAYERS; i++)
			{
				SetPlayerHealth(i,0);
			}
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/getall", true) == 0) // ��������������� ���� � ����
	{
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pAdmin] >= 8)
		{
			new Float:x;
			new Float:y;
			new Float:z;
			for(new i=0; i<MAX_PLAYERS; i++)
			if(IsPlayerConnected(i))
			{
				GetPlayerPos(playerid,x,y,z);
				SetPlayerPos(i,x,y,z+1);
				new PlayerName[MAX_PLAYER_NAME];
				GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
				format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� %s[%d] �������������� ���� � ����.",PlayerName,playerid);
				SendClientMessageToAll(0x21DD00FF, string);
			}
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
		}
		return 1;
	}
	
	if(strcmp(cmd, "/setscore", true) == 0) // ���������� ������ score
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp) && PlayerInfo[playerid][pAdmin] >= 9) return SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /setscore [id] [score] - ���������� ������ Score.");
		new playa, level;
		playa = ReturnUser(tmp);
		tmp = strtok(cmdtext, idx);
		level = strval(tmp);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		if (PlayerInfo[playerid][pAdmin] >= 9)
		{
			if(IsPlayerConnected(playa))
			{
				if(playa != INVALID_PLAYER_ID)
				{
					PlayerInfo[playa][pScore] = level;
					format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} �� ������ %d �����(score) ������ %s",level,giveplayer);
					SendClientMessage(playerid, 0x21DD00FF, string);
					format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� %s(%d) ����� ��� %d �����(score)...",sendername,playerid, level);
					SendClientMessage(playa, 0x21DD00FF, string);
				}
			}
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/setint", true) == 0) // ������� �������� ������
	{
		if(IsPlayerConnected(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /setint [id] [id ���������] - ������� �������� ������.");
				return 1;
			}
			new playa;
			playa = ReturnUser(tmp);
			new intid;
			tmp = strtok(cmdtext, idx);
			intid = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= 9)
			{
				if(IsPlayerConnected(playa))
				{
					if(playa != INVALID_PLAYER_ID)
					{
						GetPlayerName(playa, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						SetPlayerInterior(playa, intid);
						format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} �� ���������� ������ %s �������� �� %d...", giveplayer, intid);
						SendClientMessage(playerid, 0x21DD00FF, string);
						format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ff0000} ������������� %s ������ ��� �������� �� %d...", sendername, intid);
						SendClientMessage(playa, 0x21DD00FF, string);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
			}
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/object", true) == 0 ){ // ������� �������
		if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pAdmin] >= 9)
		{
			new objid1;
			new rot;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /object [ID �������] [���� ��������] - ���������� ������.");
				return 1;
			}
			objid1 = strval(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /object [ID �������] [���� ��������] - ���������� ������.");
				return 1;
			}
			new Float:X, Float:Y,Float:Z,Float:rX,Float:rY;
			GetPlayerPos(playerid, X, Y, Z);
			rot = strval(tmp);
			SetPlayerPos(playerid,X,Y,Z +5);
			CreateObject(objid1, X, Y, Z, rX, rY, rot);
		}
		else
		{
			SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
		}
		return 1;
	}
	//[10-�������]===================================================================
	if(strcmp(cmd, "/setlevel", true) == 0) // ���� �������
	{
		if(IsPlayerConnected(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /setlevel [id] [1-10-�������] - ���� �������.");
				return 1;
			}
			new para1;
			new level;
			para1 = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			level = strval(tmp);
			if(level < 0 || level > 10)
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /setlevel [id] [1-5-�������] - ���� �������.");
				return 1;
			}
			//����� ������� 10 � ����� ������ 0
			if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pAdmin] >= 10)
			{
				if(IsPlayerConnected(para1))
				{
					if(para1 != INVALID_PLAYER_ID)
					{
						GetPlayerName(para1, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));

						PlayerInfo[para1][pAdmin] = level;
						printf("{0077FF}Blodhamer Drift :{ffffff} ����� %s ��� ������� ��������������� %s �� %d ������ �����������������.", sendername, giveplayer, level);
						format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ffffff} �� ���� �������� �� %d ������ ����������������� ������� %s", level, sendername);
						SendClientMessage(para1, 0x21DD00FF, string);
						format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ffffff} �� �������� ������ %s �� ������ %d �����������������.", giveplayer,level);
						SendClientMessage(playerid, 0x21DD00FF, string);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
			}
		}
		return 1;
	}
	
		//[10-�������]===================================================================
	if(strcmp(cmd, "/setvip", true) == 0) // ���� �������
	{
		if(IsPlayerConnected(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /setvip [id] [1-3-�������] - ���� VIP.");
				return 1;
			}
			new para1;
			new level;
			para1 = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			level = strval(tmp);
			if(level < 0 || level > 4)
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /setvip [id] [1-3-�������] - ���� VIP.");
				return 1;
			}
			//����� ������� 10 � ����� ������ 0
			if (IsPlayerAdmin(playerid) == 1 || PlayerInfo[playerid][pVIP] >= 4)
			{
				if(IsPlayerConnected(para1))
				{
					if(para1 != INVALID_PLAYER_ID)
					{
						GetPlayerName(para1, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));

						PlayerInfo[para1][pVIP] = level;
						printf("{0077FF}Blodhamer Drift :{ffffff} ����� %s ��� ������� ��������������� %s �� %d ������ VIP.", sendername, giveplayer, level);
						format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ffffff} �� ���� �������� �� %d ������ VIP VIP's %s", level, sendername);
						SendClientMessage(para1, 0x21DD00FF, string);
						format(string, sizeof(string), "{0077FF}Blodhamer Drift :{ffffff} �� �������� ������ %s �� ������ %d VIP.", giveplayer,level);
						SendClientMessage(playerid, 0x21DD00FF, string);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� �� VIP's �������.");
			}
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/delakk", true) == 0) // ������� �������
	{
		if(PlayerInfo[playerid][pAdmin] >= 10)
		{
			new akk[256],ssss[256];
			akk = strtok(cmdtext, idx);
			if(!strlen(akk))
			{
				SendClientMessage(playerid,0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} /delakk [�������] - ������� �������.");
				return 1;
			}
			format(string,sizeof(string),"users/%s.ini",akk);
			if(!fexist(string))
			{
				SendClientMessage(playerid,0x21DD00FF,"{0077FF}Blodhamer Drift :{ff0000} ������ �������� ����...");
				return 1;
			}
			else
			{
				fremove(string);
				format(ssss,sizeof(ssss),"{0077FF}Blodhamer Drift :{ff0000} ������� � ������ %s ��� ������� �����...",akk);
				SendClientMessage(playerid,0x21DD00FF,ssss);
			}
		}
		else
		{
			SendClientMessage(playerid,0x21DD00FF,"{0077FF}Blodhamer Drift :{ff0000} �� �� ������������� �������.");
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(strcmp(cmd, "/achat", true) == 0) // ��������� ����� ���
	{
		if(PlayerInfo[playerid][pAdmin]>= 10)
		{
			if(chat== 1)
			{
				new pname[MAX_PLAYER_NAME];
				GetPlayerName(playerid,pname,sizeof(pname));
				format(string,sizeof(string),"{0077FF}Blodhamer Drift :{ff0000} ������������� %s �������� ����� ���...",pname,playerid);
				SendClientMessageToAll(0x21DD00FF,string);
				chat= 0;
			}
			else
			{
				new pname[MAX_PLAYER_NAME];
				GetPlayerName(playerid,pname,sizeof(pname));
				format(string,sizeof(string),"{0077FF}Blodhamer Drift :{ff0000} ������������� %s ������� ����� ���...",pname,playerid);
				SendClientMessageToAll(0x21DD00FF,string);
				chat=1;
			}
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if (strcmp("/menu", cmdtext, true, 10) == 0)ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������� ����", "[1] ������ \n[2] ��������� \n[3] �������� \n[4] ���������� \n[5] ���������� ���������� \n[6] ���� ������ \n[7] {FF00FF}������ \n[8] ������ \n[9] {FF0000}����� \n[10] ���������� ���� \n[11] ������ \n[12] ���������", "�������", "�����");
	//------------------------------------------------------------------------------
	dcmd(dt, 2, cmdtext); // ���������� ���
	//------------------------------------------------------------------------------
	dcmd(count, 5, cmdtext); // ������
	dcmd(creategarage, 12, cmdtext);
	
	//------------------------------------------------------------------------------
	return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{00ff00}{0077FF}Blodhamer Drift :{ffffff} ������", "{ffffff}����� ������� �� ���������� ������� ��� ������ �������:{ff0000} /help\n{ffffff}���� �� �������� ��� ������ �������\n{ffffff}������ ����������� ����� ��������� �������.", "OK", "");
}
//==============================================================================
public OnPlayerText(playerid, text[]) // ��� ����
{
	if(text[0] == '!') // ��� �������
	{
		if(PlayerInfo[playerid][pAdmin] > 0)
		{
			new string[256];
			format(string, sizeof(string), "[���-�������]{FFFF00} %s:{ffffff} %s", oGetPlayerName(playerid), text[1]);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(PlayerInfo[i][pAdmin] > 0)
					{
						SendClientMessage(i, 0x21DD00FF, string);
					}
				}
			}
		}
		else
		{
			SetPlayerChatBubble(playerid, text, 0x21DD00FF, 100.0, 7000);
		}
		return 0;
	}
	//------------------------------------------------------------------------------
	if(chat== 0) // ����� ���
	{
		SendClientMessage(playerid,0x21DD00FF,"{0077FF}Blodhamer Drift :{ffffff} ����� ��� ��������...");
		return 0;
	}
	//------------------------------------------------------------------------------
	if(PlayerInfo[playerid][pMuted] == 1)
	{
		SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ffffff} � ��� �������� ���...");
		return 0;
	}
	//------------------------------------------------------------------------------
	if(CheckOnIP(text)) // �����������
	{
		new sendername[MAX_PLAYER_NAME];
		new string[128];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, 256, "{0077FF}Blodhamer Drift {ffffff}: [%s] ��� ������ {FFFF00}( �������: ������� ).", sendername);
		SendClientMessageToAll(0x21DD00FF, string);
		SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ffffff} ������� ������ �������� ���������." );
		Kick(playerid);
		return 0;
	}
	//------------------------------------------------------------------------------
	if(IsMessageSent[playerid] == 1) // ��������
	{
		SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ffffff} � ��� ����� ������ ������ {ff0000}3 {ffffff}�������.");
		return false;
	}
	else
	{
		IsMessageSent[playerid] = 1;
		SetTimerEx("UnMutedX",interval*1000,0,"d",playerid);
	}
	//------------------------------------------------------------------------------
	UpperToLower(text); // ��� ����-caps
	SetPlayerChatBubble(playerid, text, 0x21DD00FF, 250.0, 8000); // ��� ��� �������

    new str[200];
	if(strlen(text)> 48)
   {
      SendClientMessage(playerid,-1,"Text Too Big! Maximum Allowed: 48.");
      return 0;
   }
   // Origins
    if(TextsActive[playerid] == 0)
    {
    format(str, sizeof(str), "{FFFFFF}%s",text[0]);
    SendPlayerMessageToAll(playerid, str);
    return 0;
    }
   // Yellow
    if(TextsActive[playerid] == 1)
    {
      format(str, sizeof(str), "{FFFF00}%s",text[0]);
      SendPlayerMessageToAll(playerid, str);
      return 0;
    }
   // Red
    if(TextsActive[playerid] == 2)
    {
      format(str, sizeof(str), "{FF0000}%s",text[0]);
      SendPlayerMessageToAll(playerid, str);
      return 0;
    }
   // Blue
    if(TextsActive[playerid] == 3)
    {
      format(str, sizeof(str), "{00BFFF}%s",text[0]);
      SendPlayerMessageToAll(playerid, str);
      return 0;
    }
   // Green
    if(TextsActive[playerid] == 4)
    {
      format(str, sizeof(str), "{00FF00}%s",text[0]);
      SendPlayerMessageToAll(playerid, str);
      return 0;
    }
        // Gray
    if(TextsActive[playerid] == 5)
    {
      format(str, sizeof(str), "{696969}%s",text[0]);
      SendPlayerMessageToAll(playerid, str);
      return 0;
    }
        // Pink
    if(TextsActive[playerid] == 6)
    {
      format(str, sizeof(str), "{FF00FF}%s",text[0]);
      SendPlayerMessageToAll(playerid, str);
      return 0;
    }
        // White
    if(TextsActive[playerid] == 7)
    {
      format(str, sizeof(str), "{FFFFFF}%s",text[0]);
      SendPlayerMessageToAll(playerid, str);
      return 0;
    }
	return 1;
}
//==============================================================================
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_CROUCH && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) // ������� ���� �� ��������
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)RepairVehicle(GetPlayerVehicleID(playerid));
		}
	}
	if(Menu[playerid] == 0)
    {
	//------------------------------------------------------------------------------
	if ((newkeys==KEY_SUBMISSION)) // ���� �� "2"
	{
		if(IsPlayerInAnyVehicle(playerid))
		ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������� ����", ">> [1] ������ \n>> [2] ��������� \n>> [3] �������� \n>> [4] ���������� \n>> [5] ���������� ���������� \n>> [6] {FF00FF}���������� \n>> [7] ������ \n>> [8] {FF0000}����� \n>> [9] ���������� ���� \n>> [10] ������ \n>> [11] ��������� \n>> [12] ����������", ">>", "X");
	}
	//------------------------------------------------------------------------------
	if ((newkeys==1024)) // ���� �� ALT
	{
		if(!IsPlayerInAnyVehicle(playerid))
		ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������� ����", ">> [1] ������ \n>> [2] ��������� \n>> [3] �������� \n>> [4] ���������� \n>> [5] ���������� ���������� \n>> [6] {FF00FF}���������� \n>> [7] ������ \n>> [8] {FF0000}����� \n>> [9] ���������� ���� \n>> [10] ������ \n>> [11] ��������� \n>> [12] ����������", ">>", "X");
	}
    }
	else
	{
    if(Menu2[playerid] == 0)
    {
	//------------------------------------------------------------------------------
	if ((newkeys==65536)) // ���� �� "2"
	{
		if(IsPlayerInAnyVehicle(playerid))
		ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������� ����", ">> [1] ������ \n>> [2] ��������� \n>> [3] �������� \n>> [4] ���������� \n>> [5] ���������� ���������� \n>> [6] {FF00FF}���������� \n>> [7] ������ \n>> [8] {FF0000}����� \n>> [9] ���������� ���� \n>> [10] ������ \n>> [11] ��������� \n>> [12] ����������", ">>", "X");
	}
	//------------------------------------------------------------------------------
	if ((newkeys==65536)) // ���� �� ALT
	{
		if(!IsPlayerInAnyVehicle(playerid))
		ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������� ����", ">> [1] ������ \n>> [2] ��������� \n>> [3] �������� \n>> [4] ���������� \n>> [5] ���������� ���������� \n>> [6] {FF00FF}����������� \n>> [7] ������ \n>> [8] {FF0000}����� \n>> [9] ���������� ���� \n>> [10] ������ \n>> [11] ��������� \n>> [12] ����������", ">>", "X");
	}
    }
    }
	//------------------------------------------------------------------------------
	if( newkeys == 1 || newkeys == 9 || newkeys == 33 && oldkeys != 1 || oldkeys != 9 || oldkeys != 33) // ����
	{
		new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
		switch(Model)
		{
		case 446,432,448,452,424,453,454,461,462,463,468,471,430,472,449,473,481,484,493,495,509,510,521,538,522,523,532,537,570,581,586,590,569,595,604,611: return 0;
		}
		AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
	}
	//------------------------------------------------------------------------------
	/*if (newkeys == 65410 || newkeys == 130) // �������� ���� C+
	{
		new pname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"Russia Drift:{ff0000} ����� %s ��� ������ ��������� {FFFF00}( �������: �������� ���� C+ ).",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		TogglePlayerControllable(playerid, 0); // ������������ ������
		Kick(playerid);
	}*/
	return 1;
}
//==============================================================================
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) // ���������� ����
{
    if(GetPVarInt(playerid,"USEDIALOGID") != dialogid) return 1; // ��� ���������� ����
	//------------------------------------------------------------------------------
    if(dialogid == 111) //�����������
    {
        if(!strlen(inputtext)) return ShowPlayerDialog(playerid,111,DIALOG_STYLE_INPUT, "{0077FF}Blodhamer Drift :{ffffff} �����������", "{FFFFFF}��� ������� ��� �� ��������������� �� ���� �������!\n������ ����� ��������� �� 6-� �� 24-�� ��������\n\n{ffd700}���������� ���� ������ � �������� ��� �����:", "������", "");
        if(response) //�������� �� ������ "��" � �� ������� Enter'�
        {
            new PlayerName[MAX_PLAYER_NAME];
            GetPlayerName(playerid,PlayerName,sizeof(PlayerName)); //������ ���
            new account[128];
            format(account,sizeof(account),"Users/%s.ini",PlayerName);//���� ���
            if(fexist(account))
			{
				new str[128],sctring[2000];
				format(str,sizeof(str),"{FF0000}��������������:{FFFFFF} �� ������� ������� ����������!\n");
				strcat(sctring,str);
				format(str,sizeof(str),"�� ������� {FF0000}���� ������ (� ������ �������) {FFFFFF}�� ��������� ��������!\n");
				strcat(sctring,str);
				format(str,sizeof(str),"������������� {FF0000}�� ����� ��������������� {FFFFFF}�� ���������� ��������.\n\n");
				strcat(sctring,str);
				format(str,sizeof(str),"������� ������:");
				strcat(sctring,str);
		        ShowPlayerDialog(playerid,112,DIALOG_STYLE_INPUT, "{0077FF}Blodhamer Drift :{ffffff} �����������", sctring, "�����", "");
				return 1;
			}
			new iniFile = ini_createFile(account); //������� ���
            if(iniFile < 0) ini_openFile (account); //���� ���� ������, ��...
            {
                ini_setString(iniFile,"Key",inputtext); //������� ������ � ���������� ���
                ini_setInteger(iniFile, "Money", 15000); // ������� ���-�� ����� � ����.
                //ini_setInteger(iniFile, "Skin", 142); // ������� ���-�� ����� � ����.
                ini_setInteger(iniFile, "Admin", 0); // ������� ���-�� ����� � ����.
                ini_setInteger(iniFile, "MenuL", 0); // ������� ���-�� ����� � ����.
                ini_setInteger(iniFile, "VIP", 0); // ������� ���-�� ����� � ����.
                ini_setInteger(iniFile, "Score", 0); // ������� ���-�� ����� � ����.
                ini_setInteger(iniFile, "Ban", 0); // ������� ���-�� ����� � ����.
                ini_setInteger(iniFile, "Warn", 0); // ������� ���-�� ����� � ����.
                ini_setInteger(iniFile, "Muted", 0); // ������� ���-�� ����� � ����.
                ini_setInteger(iniFile, "MuteTime", 0); // ������� ���-�� ����� � ����.
                ini_closeFile(iniFile); //������� ����
                PlayerInfo[playerid][pMoney] = 15000;
                //PlayerInfo[playerid][pSkin] = 0;
                PlayerInfo[playerid][pAdmin] = 0;
                PlayerInfo[playerid][pMenuL] = 0;
                PlayerInfo[playerid][pVIP] = 0;
                PlayerInfo[playerid][pScore] = 0;
                PlayerInfo[playerid][pBanned] = 0;
                PlayerInfo[playerid][pWarns] = 0;
                PlayerInfo[playerid][pMuted] = 0;
                PlayerInfo[playerid][pMuteTime] = 0;
                SendClientMessage(playerid, COLOR_YELLOW,"{0077FF}Blodhamer Drift :{ffffff} ����������� �������� {60ff00}������� ���� {ffffff}�� �������: {60ff00}/rules{ffffff}.");
                SendClientMessage(playerid, COLOR_YELLOW,"{0077FF}Blodhamer Drift :{ffffff} �� ���� ��� ������ �� {0077FF}Blodhamer Drift {ffffff}, ��� ������� ������� {60ff00}/help{ffffff}.");
                SendClientMessage(playerid, COLOR_YELLOW,"{0077FF}Blodhamer Drift :{ffffff} ��� �� �� ������ ����� {60ff00}������ {ffffff}� ����� ����.");
                SendClientMessage(playerid, COLOR_YELLOW,"{0077FF}Blodhamer Drift :{ffffff} ��� ����� � ���� ������� {fff82f}Alt/2 {ffffff}.");
                format(account, sizeof(account), "{0077FF}Blodhamer Drift :{ffffff} ��� ������� \"%s\" ��� ������� ���������������, �� ��������� ���� ������.",PlayerName);
                SendClientMessage(playerid, COLOR_YELLOW,account);
                new acoountnew[128];
                format(acoountnew, sizeof(acoountnew), "{0077FF}Blodhamer Drift :{ffffff} ����� \"%s\" ����������������� � ����� � ����.",PlayerName);
                SendClientMessageToAll(COLOR_YELLOW,acoountnew);
				SendClientMessage(playerid, COLOR_YELLOW,"{0077FF}Blodhamer Drift :{ffffff} �� ���� ������������� ����������.");
	            SetSpawnInfo(playerid,0,0,1958.33,1343.12,15.36,269.15,0,0,0,0,0,0);
				SpawnPlayer(playerid);
            }
        }
        else //�������� �� ������ ������, �� �� �� �� �� �������. �� ���� ������ Esc, �� �� �� ��������. ��� ��� �� ������ �������� �� ������� Esc'����
        {
            ShowPlayerDialog(playerid,111,DIALOG_STYLE_PASSWORD, "{0077FF}Blodhamer Drift :{ffffff} �����������", "{FFFFFF}��� ������� ��� �� ��������������� �� ���� �������!\n������ ����� ��������� �� 6-� �� 24-�� ��������\n\n{ffd700}���������� ���� ������ � �������� ��� �����:", "������", "");
        }
    }
    if(dialogid == 112)
    {
        if(!strlen(inputtext))
		{
			new str[128],sctring[2000];
			format(str,sizeof(str),"{FF0000}��������������:{FFFFFF} �� ������� ������� ����������!\n");
			strcat(sctring,str);
			format(str,sizeof(str),"�� ������� {FF0000}���� ������ (� ������ �������) {FFFFFF}�� ��������� ��������!\n");
			strcat(sctring,str);
			format(str,sizeof(str),"������������� {FF0000}�� ����� ��������������� {FFFFFF}�� ���������� ��������.\n\n");
			strcat(sctring,str);
			format(str,sizeof(str),"������� ������:");
			strcat(sctring,str);
	        ShowPlayerDialog(playerid,112,DIALOG_STYLE_PASSWORD, "{0077FF}Blodhamer Drift :{ffffff} �����������", sctring, "�����", "");
		}
		if(response) // �������� �� ������ "��" � Enter
        {
            new PlayerName[MAX_PLAYER_NAME], password[64];
            GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
            new account[128];
            format(account,sizeof(account),"Users/%s.ini",PlayerName);
            if(IsPlayerNPC(playerid))return 1;
            new iniFile = ini_openFile(account);
            ini_getString(iniFile, "Key",password); // ����� ������ ��������.
            if(!strcmp(inputtext, password, true))
            {
                ini_getInteger(iniFile, "Money", PlayerInfo[playerid][pMoney]); // ������� ���-�� ����� � ����������.
                ini_getInteger(iniFile, "Skin", PlayerInfo[playerid][pSkin]); // ������� ���-�� ����� � ����������.
                ini_getInteger(iniFile, "Admin", PlayerInfo[playerid][pAdmin]); // ������� ���-�� ����� � ����������.
                ini_getInteger(iniFile, "MenuL", PlayerInfo[playerid][pMenuL]); // ������� ���-�� ����� � ����������.
                ini_getInteger(iniFile, "VIP", PlayerInfo[playerid][pVIP]); // ������� ���-�� ����� � ����������.
                ini_getInteger(iniFile, "Score", PlayerInfo[playerid][pScore]); // ������� ���-�� ����� � ����������.
                ini_getInteger(iniFile, "Ban", PlayerInfo[playerid][pBanned]); // ������� ���-�� ����� � ����������.
                ini_getInteger(iniFile, "Warn", PlayerInfo[playerid][pWarns]); // ������� ���-�� ����� � ����������.
                ini_getInteger(iniFile, "Muted", PlayerInfo[playerid][pMuted]); // ������� ���-�� ����� � ����������.
                ini_getInteger(iniFile, "MuteTime", PlayerInfo[playerid][pMuteTime]); // ������� ���-�� ����� � ����������.
                ini_closeFile(iniFile);
                SendClientMessage(playerid, COLOR_YELLOW,"{0077FF}Blodhamer Drift :{ffffff} ����������� �������� {60ff00}������� ���� {ffffff}�� �������: {60ff00}/rules{ffffff}.");
                SendClientMessage(playerid, COLOR_YELLOW,"{0077FF}Blodhamer Drift :{ffffff} �� ���� ��� ������ �� {0077FF}Blodhamer Drift {ffffff}, ��� ������� ������� {60ff00}/help{ffffff}.");
                SendClientMessage(playerid, COLOR_YELLOW,"{0077FF}Blodhamer Drift :{ffffff} ������� � ���������� �� ������ � ����� ������ : vk.com/blodhamerdrift.server");
                SendClientMessage(playerid, COLOR_YELLOW,"{0077FF}Blodhamer Drift :{ffffff} ��� ����� � ���� ������� {fff82f}Alt/2 {ffffff}.");
                SendClientMessage(playerid, COLOR_YELLOW,"{0077FF}Blodhamer Drift :{ffffff} �� ���� ������� ����������");
                SetPlayerScore(playerid, PlayerInfo[playerid][pScore]);
                SetSpawnInfo(playerid,0,0,1958.33,1343.12,15.36,269.15,0,0,0,0,0,0);
				SpawnPlayer(playerid);
                return 1;
            }
            else
            {
                SendClientMessage(playerid, 0xFFFFFFFF, "{0077FF}Blodhamer Drift :{ffffff} �������� ������!");
                new str[128],sctring[2000];
				format(str,sizeof(str),"{FF0000}��������������:{FFFFFF} �� ������� ������� ����������!\n");
				strcat(sctring,str);
				format(str,sizeof(str),"�� ������� {FF0000}���� ������ (� ������ �������) {FFFFFF}�� ��������� ��������!\n");
				strcat(sctring,str);
				format(str,sizeof(str),"������������� {FF0000}�� ����� ��������������� {FFFFFF}�� ���������� ��������.\n\n");
				strcat(sctring,str);
				format(str,sizeof(str),"������� ������:");
				strcat(sctring,str);
		        ShowPlayerDialog(playerid,112,DIALOG_STYLE_PASSWORD, "{0077FF}Blodhamer Drift :{ffffff} �����������", sctring, "�����", "");
                return 1;
            }
        }
        else //���� ������ Esc, ��...
        {
            new str[128],sctring[2000];
			format(str,sizeof(str),"{FF0000}��������������:{FFFFFF} �� ������� ������� ����������!\n");
			strcat(sctring,str);
			format(str,sizeof(str),"�� ������� {FF0000}���� ������ (� ������ �������) {FFFFFF}�� ��������� ��������!\n");
			strcat(sctring,str);
			format(str,sizeof(str),"������������� {FF0000}�� ����� ��������������� {FFFFFF}�� ���������� ��������.\n\n");
			strcat(sctring,str);
			format(str,sizeof(str),"������� ������:");
			strcat(sctring,str);
	        ShowPlayerDialog(playerid,112,DIALOG_STYLE_INPUT, "{0077FF}Blodhamer Drift :{ffffff} �����������", sctring, "�����", "");
        }
	}
	else
    {
		PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
	    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	}

//#############################################################################
	
	//##############################################################################
    if(dialogid == 11) // ��������� ���
	{
		if(response)
		{
   			if(listitem == 0)
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)ShowPlayerDialog(playerid, 4, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ ����", ">> [1] �����\n>> [2] ����������\n>> [3] �������� ������\n>> [4] ����\n>> [5] ������\n>> [6] ����\n>> [7] ����� ������\n>> [8] ����\n>> [9] ������� ������", ">>", "X");
					else SendClientMessage(playerid, COLOR_RED, "{0077FF}Blodhamer Drift :{ffffff} ��� ������ ������ �� ������������ �����.");
				}
    			else SendClientMessage(playerid, COLOR_RED, "{0077FF}Blodhamer Drift :{ffffff} ��� ������ �������� ����������.");
			}
			//--------------------------------------------------------------------------------------------------------------------------
			if(listitem == 1)
			{
			ShowPlayerDialog(playerid, 222, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ���������", ">> [1] ����� \n>> [2] ���� \n>> [3] ������ \n>> [4] BMX \n>> [5] ������", ">>", "X");
			}
			//--------------------------------------------------------------------------------------------------------------------------
			if(listitem == 2)
			{
			new string[2048];
            strcat(string, ">> [1] ������� � C������� \n");
            strcat(string, ">> [2] ��������� \n");
            strcat(string, ">> [3] ������� \n");
            strcat(string, ">> [4] ��������� ����� \n");
            strcat(string, ">> [5] �������� \n");
            strcat(string, ">> [6] �������� ���� \n");
            strcat(string, ">> [7] ������� \n");
            strcat(string, ">> [8] ������� \n");
            strcat(string, ">> [9] ������� \n");
            strcat(string, ">> [10] ��������� ���� \n");
            strcat(string, ">> [11] ������ \n");
            strcat(string, ">> [12] ���������� ������ \n");
            strcat(string, ">> [13] ������� \n");
            strcat(string, ">> [14] �������� \n");
            strcat(string, ">> [15] ������������� \n");
            strcat(string, ">> [16] �������� \n");
            strcat(string, ">> [17] ������ \n");
            strcat(string, ">> [18] ������ � ����� \n");
            strcat(string, ">> [19] ������ �� ����� \n");
            strcat(string, ">> [20] �������� ��� \n");
            strcat(string, ">> [21] �������� \n");
            strcat(string, ">> [22] ������� ���� \n");
            strcat(string, ">> {ff0000}���������� ��������\n");
            ShowPlayerDialog(playerid,777,DIALOG_STYLE_LIST,"{0077FF}Blodhamer Drift :{ffffff} ��������",string,">>","X");
            }
			//--------------------------------------------------------------------------------------------------------------------------
            if(listitem == 3)ShowPlayerDialog(playerid, 9, DIALOG_STYLE_LIST, "����������", ">> [1] �������\n>> [2] �������\n>> [3] �������\n>> [4] �������\n>> [5] �������", "�������", "�����");
			//--------------------------------------------------------------------------------------------------------------------------
			if(listitem == 4)
            {
                new puck[11], menuh[11], string[512];
				switch(Fdap[playerid])
				{
                    case 2: puck = "{00FF08}+";
				    case 1: puck = "{FF0000}-";
				}
				switch(MenuL[playerid])
				{
                    case 1: menuh = "ALT|2";
				    case 2: menuh = "Y";
				}
			    format(string, sizeof(string), ">> [1] ����� \n>> [2] ������ \n>> [3] ���� ���� \n>> [4] ����� ��� \n>> [5] ���� ���� \n>> [6] ������� \n>> [7] ����� �� �����\
				\n>> [8] {ff0000}������� ���� \n>> [9] ������� ����[%s{ffffff}]\n>> [10] ���� ������� [%s{ffffff}]",puck,menuh,string);
                ShowPlayerDialog(playerid,1000,DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ���������� ����������", string, ">>", "X");

		    }
			//--------------------------------------------------------------------------------------------------------------------------
			if(listitem == 5)
			{
			OnPlayerCommandText(playerid,"/gang");
			}
			//--------------------------------------------------------------------------------------------------------------------------
			if(listitem == 6)
            {
            ShowPlayerDialog(playerid, 1022, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������", ">> [1] ����\n>> [2] �������\n>> [3] ����������\n>> [4] ������", ">>", "X");
		    }
		    //--------------------------------------------------------------------------------------------------------------------------
			if(listitem == 7)
			{
            ShowPlayerDialog(playerid, 8675, DIALOG_STYLE_INPUT,"{0077FF}Blodhamer Drift :{ffffff} �����","������� ����� ������� �� ( ������|�������� ).",">>","X");
			}
			//--------------------------------------------------------------------------------------------------------------------------
			if(listitem == 8)
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,0xFFFFFFFF,"�� ������ ���� � ����������.");
				ShowPlayerDialog(playerid,0,DIALOG_STYLE_LIST,"{0077FF}Blodhamer Drift :{ffffff} ����-����",">> [1] ������� �����\n>> [2] ������� ��������\n>> [3] �������� ����\n>> [4] �������� ������������\n>> [5] ������� �����\n>> [6] ��������� �����\
            	\n>> [7] ������� �����\n>> [8] ������� ��������\n>> [9] ��������� ����\n>> [10] ��������� ������������\n>> [11] ������� �����\n>> [12] ��������� �����\n",">>","X");
  
			}
            //--------------------------------------------------------------------------------------------------------------------------
			if(listitem == 9)
			{
			ShowPlayerDialog(playerid, 1006, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������", ">> [1] �����\n>> [2] ����\n>> [3] �������\n>> [4] �����\n>> [5] ������\n>> {ff0000}�������", ">>", "X");
            }
			//--------------------------------------------------------------------------------------------------------------------------
			if(listitem == 10)
			{
			    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,0xFFFFFFFF,"�� ������ ���� � ����������.");
			    new dtext[11], spedl[11], kuzik[11], fira[11], string[512];
			    switch(chets[playerid])
				{
				    case 1: dtext = "{00FF08}+";
				    case 2: dtext = "{FF0000}-";
				}
                switch(lolka[playerid])
				{
                    case 1: spedl = "{00FF08}+";
				    case 2: spedl = "{FF0000}-";
				}
				switch(kazan[playerid])
				{
                    case 1: kuzik = "{00FF08}+";
				    case 2: kuzik = "{FF0000}-";
				}
				switch(fartuk[playerid])
				{
                    case 2: fira = "{00FF08}+";
				    case 1: fira = "{FF0000}-";
				}
			    format(string, sizeof(string), ">> [1] ����� ������� [%s{ffffff}]\n>> [2] ��������� [%s{ffffff}]\n>> [3] ���� ������ [%s{ffffff}]\
				\n>> [4] ����������� [%s{ffffff}]",dtext,spedl,kuzik,fira,string);
                ShowPlayerDialog(playerid,3010,DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ���������", string, ">>", "X");
			    }

			if(listitem == 11)
            {
              ShowStats(playerid,playerid);
	        }
		}
	}


    new carid = GetPlayerVehicleID(playerid);
	new engine,lights,alarm,doors,bonnet,boot,objective;
    if(dialogid == 0)//??? ?? ?? ???, ?? AutoMenu
	{
		if(response)
		{
			if(listitem == 0)//????? ???
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,lights,alarm,doors,true,boot,objective);
			}
			else if(listitem == 1)//???????? ???
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,true,objective);
			}
			else if(listitem == 2)//???? ???
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,true,alarm,doors,bonnet,boot,objective);
			}
			else if(listitem == 3)//?????? ???
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,lights,true,doors,bonnet,boot,objective);
			}
			else if(listitem == 4)//????? ????
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,lights,alarm,true,bonnet,boot,objective);
			}
			else if(listitem == 5)//????? ?????
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,true,lights,alarm,doors,bonnet,boot,objective);
			}
			else if(listitem == 6)//????? ???
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,lights,alarm,doors,false,boot,objective);
			}
			else if(listitem == 7)//???????? ???
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,false,objective);
			}
			else if(listitem == 8)//???? ????
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,false,alarm,doors,bonnet,boot,objective);
			}
			else if(listitem == 9)//?????? ????
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,lights,false,doors,bonnet,boot,objective);
			}
			else if(listitem == 10)//????? ????
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,lights,alarm,false,bonnet,boot,objective);
			}
			else if(listitem == 11)//????? ????
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,false,lights,alarm,doors,bonnet,boot,objective);
			}
		}
		else ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������� ����", ">> [1] ������ \n>> [2] ��������� \n>> [3] �������� \n>> [4] ���������� \n>> [5] ���������� ���������� \n>> [6] {FF00FF}���������� \n>> [7] ������ \n>> [8] {FF0000}����� \n>> [9] ���������� ���� \n>> [10] ������ \n>> [11] ��������� \n>> [12] ����������", ">>", "X");
	}

		
    if(dialogid == 8675)
    {
     new donate;
     new file = ini_openFile("donate.ini");
	 if(ini_getInteger(file, inputtext, donate) == 0)
     {
		if(donate == 1) // FIND (NOT MONEY) (DONATERANK)
        {
            SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� �������� VIP �������, |3LVL|");
            ini_removeKey(file,inputtext);
            PlayerInfo[playerid][pVIP] = 3;
            return 1;
        }
        else if(donate == 2) // FIND (NOT MONEY) (LEVEL)
        {
            SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� �������� |10.000| Drift �����.");
            ini_removeKey(file,inputtext);
            PlayerInfo[playerid][pScore] += 10000;
            return 1;
        }
        else if(donate == 3)
        {
            SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� �������� |100 000| �����.");
            ini_removeKey(file,inputtext);
            GiveMoney(playerid, 100000);
            return 1;
        }
        else if(donate == 4)
        {
            SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� �������� |500 000| �����.");
            ini_removeKey(file,inputtext);
            GiveMoney(playerid, 500000);
            return 1;
        }
        else if(donate == 5)
        {
            SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� �������� |1 000 000| �����");
            ini_removeKey(file,inputtext);
            GiveMoney(playerid, 1000000);
            return 1;
        }
        else if(donate == 6)
        {
            SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� �������� |3 000 000| �����.");
            ini_removeKey(file,inputtext);
            GiveMoney(playerid, 3000000);
            return 1;
        }
        ini_removeKey(file,inputtext);
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"������� �� �������");
     }
     else
     {
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"�������� ���");
     }
     iniClose(file);
  }


    if(dialogid == 11555)
    {
      if(response)
      {
        if(!strlen(inputtext))return ShowPlayerDialog(playerid,11555,DIALOG_STYLE_INPUT,"�������� ���� - ��������","������� �������� ��� ����.","�����","�������");
        SetPVarString(playerid,"h_desc",inputtext);
        ShowPlayerDialog(playerid,11556,DIALOG_STYLE_INPUT,"�������� ���� - ����","������� ���� ��� ����.","�����","�����");
      }
    }

    if(dialogid == 11556)
    {
       if(response)
       {
         if(!strlen(inputtext))return ShowPlayerDialog(playerid,11556,DIALOG_STYLE_INPUT,"�������� ���� - ����","������� ���� ��� ����.","�����","�����");
         SetPVarInt(playerid,"h_price",strval(inputtext));
         STR="";
         for(new i;i<sizeof(HInts);i++)
         {
           strcat(STR,HInts[i][hiName]);
           strcat(STR,"\n");
         }
         ShowPlayerDialog(playerid,11557,DIALOG_STYLE_LIST,"�������� ���� - ��������",STR,"�����","�����");
       }
       else DeletePVar(playerid,"h_desc"),ShowPlayerDialog(playerid,11555,DIALOG_STYLE_INPUT,"�������� ���� - ��������","������� �������� ���  ����.","�����","�������");
    }

    if(dialogid == 11557)
    {
      if(response)
      {
        SetPVarInt(playerid,"h_int",listitem);
        ShowPlayerDialog(playerid,11558,DIALOG_STYLE_MSGBOX,"�������� ���� - �������������","�� ������������� ������ ������� ��� � ���� �����?","�������","������");
      }
      else DeletePVar(playerid,"h_price"),ShowPlayerDialog(playerid,11555,DIALOG_STYLE_INPUT,"�������� ���� - ����","������� ���� ��� ����.","�����","�����");
    }

    if(dialogid == 11558)
    {
      if(response)
      {
        m_h++,SaveHouseAmount();
        new Float:x[3],str[32];
        GetPlayerPos(playerid,x[0],x[1],x[2]),GetPVarString(playerid,"h_desc",str,32);
        House[m_h][hX]=x[0],House[m_h][hY]=x[1],House[m_h][hZ]=x[2],House[m_h][hPrice]=GetPVarInt(playerid,"h_price"),
        House[m_h][hInterior]=GetPVarInt(playerid,"h_int"),House[m_h][hVirtWorld]=m_h,strmid(House[m_h][hDesc],str,0,32,32),
        strmid(House[m_h][hOwner],"None",0,5,5);
        SaveHouse(m_h);
        House[m_h][hPick]=CreatePickup(1273,23,x[0],x[1],x[2],0); // ������� �����
        format(STR,128,"{0015FF}Blodhamer{ffffff}: House System\n{ffffff}��� [{00FF11}��������{ffffff}]\nBlodhamer: %s\n����: $%d\n/buyhouse",House[m_h][hDesc],House[m_h][hPrice]);
        House[m_h][hText]=Create3DTextLabel(STR,0xFFFFFFFF,x[0],x[1],x[2]+0.5,10.0,0,0);
        GameTextForPlayer(playerid,"~g~House created",100,1);
        DeletePVar(playerid,"h_price"),DeletePVar(playerid,"h_desc"),DeletePVar(playerid,"h_int");
      }
      else DeletePVar(playerid,"h_price"),DeletePVar(playerid,"h_desc"),DeletePVar(playerid,"h_int");
    }

    if(dialogid == 3010)//??? ?? ?? ???, ?? AutoMenu
	{
		if(response)
		{
			if(listitem == 0)//????? ???
			  {
			    if(chets[playerid] == 1)
			    {
                    TextDrawHideForPlayer(playerid, Textdraw0[playerid]);
			        TextDrawHideForPlayer(playerid, Chet[playerid]);
			        TextDrawHideForPlayer(playerid, Textdraw1[playerid]);
			        TextDrawHideForPlayer(playerid, Textdraw2);
			        chets[playerid] = 2;
			    }
			    else
			    {
                    TextDrawShowForPlayer(playerid, Textdraw0[playerid]);
			        TextDrawShowForPlayer(playerid, Chet[playerid]);
			        TextDrawShowForPlayer(playerid, Textdraw1[playerid]);
			        TextDrawShowForPlayer(playerid, Textdraw2);
			        chets[playerid] = 1;
			    }
			}
            if(listitem == 1)
			{
			    if(lolka[playerid] == 1)
			    {
                    TextDrawHideForPlayer(playerid, Speed[playerid][0]);
                    TextDrawHideForPlayer(playerid, Speed[playerid][1]);
                    TextDrawHideForPlayer(playerid, Speed[playerid][2]);
			        lolka[playerid] = 2;
			    }
			    else
			    {
                    TextDrawShowForPlayer(playerid, Speed[playerid][0]);
                    TextDrawShowForPlayer(playerid, Speed[playerid][1]);
                    TextDrawShowForPlayer(playerid, Speed[playerid][2]);
			        lolka[playerid] = 1;
               }
            }
            if(listitem == 2)
			{
			    if(kazan[playerid] == 1)
			    {
                    ta4karepair[playerid] = 0;
			        kazan[playerid] = 2;
			    }
			    else
			    {
                    ta4karepair[playerid] = 1;
			        kazan[playerid] = 1;
               }
            }
            if(listitem == 3)
			{
			    if(fartuk[playerid] == 1)
			    {
                    LightsOnOff[playerid] = true;
			        fartuk[playerid] = 2;
			    }
			    else
			    {
                    LightsOnOff[playerid] = false;
			        fartuk[playerid] = 1;
               }
            }
	     }
	     else ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������� ����", ">> [1] ������ \n>> [2] ��������� \n>> [3] �������� \n>> [4] ���������� \n>> [5] ���������� ���������� \n>> [6] {FF00FF}���������� \n>> [7] ������ \n>> [8] {FF0000}����� \n>> [9] ���������� ���� \n>> [10] ������ \n>> [11] ��������� \n>> [12] ����������", ">>", "X");
      }
//##############################################################################
    if(dialogid == 8234)
	 {
		if(response)
		{
			if(listitem == 0)
			{
				DestroyObject(neon[playerid][0]);
				DestroyObject(neon[playerid][1]);
				neon[playerid][0] = CreateObject(18647,0,0,0,0,0,0,100.0);
				neon[playerid][1] = CreateObject(18647,0,0,0,0,0,0,100.0);
				AttachObjectToVehicle(neon[playerid][0], GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(neon[playerid][1], GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			}
			//--------------------------------------------------------------------------------------------------------------------------
			else if(listitem == 1)
			{
				DestroyObject(neon[playerid][0]);
				DestroyObject(neon[playerid][1]);
				neon[playerid][0] = CreateObject(18648,0,0,0,0,0,0,100.0);
				neon[playerid][1] = CreateObject(18648,0,0,0,0,0,0,100.0);
				AttachObjectToVehicle(neon[playerid][0], GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(neon[playerid][1], GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			}
			//--------------------------------------------------------------------------------------------------------------------------
			else if(listitem == 2)
			{
				DestroyObject(neon[playerid][0]);
				DestroyObject(neon[playerid][1]);
				neon[playerid][0] = CreateObject(18649,0,0,0,0,0,0,100.0);
				neon[playerid][1] = CreateObject(18649,0,0,0,0,0,0,100.0);
				AttachObjectToVehicle(neon[playerid][0], GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(neon[playerid][1], GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			}
			//--------------------------------------------------------------------------------------------------------------------------
			else if(listitem==3)
			{
				DestroyObject(neon[playerid][0]);
				DestroyObject(neon[playerid][1]);
				neon[playerid][0] = CreateObject(18650,0,0,0,0,0,0,100.0);
				neon[playerid][1] = CreateObject(18650,0,0,0,0,0,0,100.0);
				AttachObjectToVehicle(neon[playerid][0], GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(neon[playerid][1], GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			}
			//--------------------------------------------------------------------------------------------------------------------------
			else if(listitem==4)
			{
				DestroyObject(neon[playerid][0]);
				DestroyObject(neon[playerid][1]);
				neon[playerid][0] = CreateObject(18651,0,0,0,0,0,0,100.0);
				neon[playerid][1] = CreateObject(18651,0,0,0,0,0,0,100.0);
				AttachObjectToVehicle(neon[playerid][0], GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(neon[playerid][1], GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			}
			//--------------------------------------------------------------------------------------------------------------------------
			else if(listitem==5)
			{
				DestroyObject(neon[playerid][0]);
				DestroyObject(neon[playerid][1]);
				neon[playerid][0] = CreateObject(18652,0,0,0,0,0,0,100.0);
				neon[playerid][1] = CreateObject(18652,0,0,0,0,0,0,100.0);
				AttachObjectToVehicle(neon[playerid][0], GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(neon[playerid][1], GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			}
			//--------------------------------------------------------------------------------------------------------------------------
			else if(listitem==6)
			{
				DestroyObject(neon[playerid][0]);
				DestroyObject(neon[playerid][1]);
			}
		}
		else ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ����", ">> [1] ���� {FF3300}[||||||] \n>> [2] ���� {0033CC}[||||||] \n>> [3] ���� {33FF00}[||||||] \n>> [4] ���� {FFFF00}[||||||] \n>> [5] ���� {FEBFEF}[||||||] \n>> [6] ���� {FEFEFE}[||||||] \n>> {ff0000}���������", ">>", "X");
	}

//##############################################################################
    if(dialogid == 1022)
	{
		if(response)
		{
			if(listitem == 0)
			{
		    	ShowPlayerDialog(playerid, 88, DIALOG_STYLE_MSGBOX, "{0077FF}Blodhamer Drift :{33FF00} ����", "�� ������� ������������ ������� �����.\n�� ������� ����������� ����� 2000 �����.\n\t������� :\n��� �� ������ ���, ��� ����� ������ �� ������ ����� � ������ /buyhouse.\n��� �� ������� ���, ����� ��������� /hopen.\n��� �� ������� ���, ����� ��������� /hlock.\n��� �� ����� �� ����, ����� ��������� /exit.\n��� �� ������� ���, ����� ��������� /sellhouse", ">>", "X");
            }
            //--------------------------------------------------------------------------------------------------------------------------
			if(listitem == 1)
            {
                ShowPlayerDialog(playerid, 88, DIALOG_STYLE_MSGBOX, "{0077FF}Blodhamer Drift :{33FF00} �������", "", ">>", "X");
         	}
         	//--------------------------------------------------------------------------------------------------------------------------
 		    if(listitem == 2)
			{
		    	ShowPlayerDialog(playerid, 88, DIALOG_STYLE_MSGBOX, "{0077FF}Blodhamer Drift :{33FF00} ����������","",">>", "X");
            }
            if(listitem == 3)
			{
		    	ShowPlayerDialog(playerid, 88, DIALOG_STYLE_MSGBOX, "{0077FF}Blodhamer Drift :{33FF00} ������","�� ������� ������������ ������� �������.\n�� ������� ����������� ����� 2000 �������.\n\t������� :\n��� �� ������ �����, ��� ����� ��������� /buygarage\n��� �� ������� �����, ��� ����� ��������� /sellgarage\n��� �� ����� � �����, ��� ����� ��������� /genter\n��� �� ����� �� ������, ��� ����� ��������� /gexit\n��� �� �������|������� �����, ��� ����� ��������� /lockgarage",">>", "X");
            }
   	    }
        else ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������� ����", ">> [1] ������ \n>> [2] ��������� \n>> [3] �������� \n>> [4] ���������� \n>> [5] ���������� ���������� \n>> [6] {FF00FF}���������� \n>> [7] ������ \n>> [8] {FF0000}����� \n>> [9] ���������� ���� \n>> [10] ������ \n>> [11] ��������� \n>> [12] ����������", ">>", "X");
	}
//##############################################################################
    if(dialogid == 1000)//???? ???????? ????? ?? ??????? Panther'a
	{
      if(response)
  		{
     	        if(listitem == 0)
	            {
                ShowPlayerDialog(playerid, 1001, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} �����", ">> [1] 00:00 \n>> [2] 02:00 \n>> [3] 04:00 \n>> [4] 06:00 \n>> [5] 08:00 \n>> [6] 10:00 \n>> [7] 12:00 \n>> [8] 14:00 \n>> [9] 16:00 \n>> [10] 18:00 \n>> [11] 20:00 \n>> [12] 22:00", ">>", "X");
                }
                //--------------------------------------------------------------------------------------------------------------------------
				if(listitem == 1)
				{
				ShowPlayerDialog(playerid, 1002, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������", ">> [1] ����� \n>> [2] ����� \n>> [3] ����� ���� \n>> [4] ���� \n>> [5] ��������� \n>> [6] ��������� \n>> [7] ����� - ����, ���� \n>> [8] �������� ���� \n>> [9] ����� � ����� ������", ">>", "X");
				}
				//--------------------------------------------------------------------------------------------------------------------------
				if(listitem == 2)
				{
				new string[2048];
                strcat(string, ">> [1] ���� {FF0000}[||||||] \n");
                strcat(string, ">> [2] ���� {BEBEBE}[||||||] \n");
                strcat(string, ">> [3] ���� {006400}[||||||] \n");
                strcat(string, ">> [4] ���� {EEA2AD}[||||||] \n");
                strcat(string, ">> [5] ���� {00FF00}[||||||] \n");
                strcat(string, ">> [6] ���� {0000FF}[||||||] \n");
                strcat(string, ">> [7] ���� {FFFF00}[||||||] \n");
                strcat(string, ">> [8] ���� {00FFFF}[||||||] \n");
                strcat(string, ">> [9] ���� {FFA500}[||||||] \n");
                strcat(string, ">> [10] ���� {FF00FF}[||||||] \n");
                strcat(string, ">> [11] ���� {FF6347}[||||||] \n");
                strcat(string, ">> [12] ���� {551A8B}[||||||] \n");
                strcat(string, ">> [13] ���� {B8860B}[||||||] \n");
                strcat(string, ">> [14] ���� {698B22}[||||||] \n");
                strcat(string, ">> [15] ���� {9ACD32}[||||||] \n");
                strcat(string, ">> [16] ���� {8B4513}[||||||] \n");
                strcat(string, ">> [17] ���� {EE6A50}[||||||] \n");
                strcat(string, ">> [18] ���� {FF4500}[||||||] \n");
                strcat(string, ">> {ff0000}��������� ����\n");
                ShowPlayerDialog(playerid,1003,DIALOG_STYLE_LIST,"{0077FF}Blodhamer Drift :{ffffff} ���� ����",string,">>","X");
	            }
				//--------------------------------------------------------------------------------------------------------------------------
				if(listitem == 3)
				{
				ShowPlayerDialog(playerid, 1005, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ����� ���", ">> [1] ����\n>> [2] ����-�� \n>> [3] ����� \n>> [4] ���� \n>> {FF0000}��������", ">>", "X");
			    }
			    if(listitem == 4)
				{
				ShowPlayerDialog(playerid, 6246, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ���� ����", ">> [1] ���� {FFFF00}[||||||] \n>> [2] ���� {FF0000}[||||||] \n>> [3] ���� {00BFFF}[||||||] \n>> [4] ���� {00FF00}[||||||] \n>> [5] ���� {696969}[||||||] \n>> [6] ���� {FF00FF}[||||||] \n>> [7] ���� {FFFFFF}[||||||] ", ">>", "X");
				}
			    if(listitem == 5)
			    {
			    ShowPlayerDialog(playerid, 1004, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} �������", ">> [1] ��� \n>> [2] ������������� ��� \n>> [3] ��� \n>> [4] ������� ���� \n>> {FF0000}���������", ">>", "X");
			    }
			    if(listitem == 6)
			    {
			    ShowPlayerDialog(playerid, 2030, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} Loggo �� �����", ">> [1] Wi-Fi \n>> [2] Tribal \n>> [3] Mafia \n>> [4] Demons \n>> [5] Saint \n>> [6] Facebook \n>> [7] Youtube \n>> [8] AC-DC \n>> [9] Metalica \n>> [10] No mercy \n>> [11] EmineM \n>> {FF0000}������� Loggo", ">>", "X");
                PlayerPlaySound(playerid, 2031, 0.0, 0.0, 10.0);
                }
                if(listitem == 7)
			    {
                OnPlayerCommandText(playerid,"/skin");
                }
                if(listitem == 8)
			    {
			    if(Fdap[playerid] == 1)
			    {
	                Glow[playerid] = 0;
			        Fdap[playerid] = 2;
			    }
			    else
			    {
                    Glow[playerid] = 1;
			        Fdap[playerid] = 1;
                }
                }
                if(listitem == 9)
			    {
			    if(MenuL[playerid] == 1)
			    {
	                Menu[playerid] = 1;
	                Menu2[playerid] = 0;
			        MenuL[playerid] = 2;
			    }
			    else
			    {
                    Menu2[playerid] = 1;
                    Menu[playerid] = 0;
			        MenuL[playerid] = 1;
                }
               }
  		     }
  		     else ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������� ����", ">> [1] ������ \n>> [2] ��������� \n>> [3] �������� \n>> [4] ���������� \n>> [5] ���������� ���������� \n>> [6] {FF00FF}���������� \n>> [7] ������ \n>> [8] {FF0000}����� \n>> [9] ���������� ���� \n>> [10] ������ \n>> [11] ��������� \n>> [12] ����������", ">>", "X");
	      }

   //##############################################################################
    if(dialogid == 2030)
    {
        if(response)
		{
            if(listitem == 0)
            {
			logo1 = CreateObject(19326,0,0,0,0,0,0);
			SetObjectMaterialText(logo1, "{FFFFFF}Wi-Fi", 0, OBJECT_MATERIAL_SIZE_256x128, "TI logoso TFB", 35,0, -16776961, 0,OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			AttachObjectToPlayer(logo1, playerid, 0.000000, -0.200000, 0.40000, 3.000000, 3.00000, 3.000000);
			SendClientMessage(playerid, 0xDEEE20FF, "������������!");
			}
			//--------------------------------------------------------------------------------------------------------------------------
            if(listitem == 1)
            {
			logo2 = CreateObject(19326,0,0,0,0,0,0);
			SetObjectMaterialText(logo2, "{FFFFFF}Des", 0, OBJECT_MATERIAL_SIZE_256x128, "Tribal Animals Tattoo Designs", 35,0, -16776961, 0,OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			AttachObjectToPlayer(logo2, playerid, 0.000000, -0.120000, 0.40000, 0.000000, 0.00000, 0.000000);
			SendClientMessage(playerid, 0xDEEE20FF, "������������!");
			}
			//--------------------------------------------------------------------------------------------------------------------------
            if(listitem == 2)
            {
			logo3 = CreateObject(19326,0,0,0,0,0,0);
			SetObjectMaterialText(logo3, "{FFFFFF}00MAFIA00", 0, OBJECT_MATERIAL_SIZE_256x128, "C39HrP48DhTt", 35,0, -16776961, 0,OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			AttachObjectToPlayer(logo3, playerid, 0.000000, -0.120000, 0.40000, 0.000000, 0.00000, 0.000000);
			SendClientMessage(playerid, 0xDEEE20FF, "������������!");
			}
			//--------------------------------------------------------------------------------------------------------------------------
            if(listitem == 3)
            {
			logo4 = CreateObject(19326,0,0,0,0,0,0);
			SetObjectMaterialText(logo4, "{FFFFFF}3", 0, OBJECT_MATERIAL_SIZE_256x128, "Cornucopia of Ornaments", 35,0, -16776961, 0,OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			AttachObjectToPlayer(logo4, playerid, 0.000000, -0.120000, 0.40000, 0.000000, 0.00000, 0.000000);
			SendClientMessage(playerid, 0xDEEE20FF, "������������!");
			}
			//--------------------------------------------------------------------------------------------------------------------------
            if(listitem == 4)
            {
			logo5 = CreateObject(19326,0,0,0,0,0,0);
			SetObjectMaterialText(logo5, "{FFFFFF}J", 0, OBJECT_MATERIAL_SIZE_256x128, "crossbats tfb", 35,0, -16776961, 0,OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			AttachObjectToPlayer(logo5, playerid, 0.000000, -0.120000, 0.40000, 0.000000, 0.00000, 0.000000);
			SendClientMessage(playerid, 0xDEEE20FF, "������������!");
			}
			//--------------------------------------------------------------------------------------------------------------------------
            if(listitem == 5)
            {
			logo6 = CreateObject(19326,0,0,0,0,0,0);
			SetObjectMaterialText(logo6, "{FFFFFF}D", 0, OBJECT_MATERIAL_SIZE_256x128, "Social logos tfb", 35,0, -16776961, 0,OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			AttachObjectToPlayer(logo6, playerid, 0.000000, -0.120000, 0.40000, 0.000000, 0.00000, 0.000000);
			SendClientMessage(playerid, 0xDEEE20FF, "������������!");
			}
			//--------------------------------------------------------------------------------------------------------------------------
            if(listitem == 6)
            {
			logo7 = CreateObject(19326,0,0,0,0,0,0);
			SetObjectMaterialText(logo7, "{FFFFFF}B", 0, OBJECT_MATERIAL_SIZE_256x128, "Social logos tfb", 35,0, -16776961, 0,OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			AttachObjectToPlayer(logo7, playerid, 0.000000, -0.120000, 0.40000, 0.000000, 0.00000, 0.000000);
			SendClientMessage(playerid, 0xDEEE20FF, "������������!");
			}
			//--------------------------------------------------------------------------------------------------------------------------
            if(listitem == 7)
            {
			logo8 = CreateObject(19326,0,0,0,0,0,0);
			SetObjectMaterialText(logo8, "{FFFFFF}k", 0, OBJECT_MATERIAL_SIZE_256x128, "MUSIC LOGOS TFB", 35,0, -16776961, 0,OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			AttachObjectToPlayer(logo8, playerid, 0.000000, -0.120000, 0.40000, 0.000000, 0.00000, 0.000000);
			SendClientMessage(playerid, 0xDEEE20FF, "������������!");
			}
			//--------------------------------------------------------------------------------------------------------------------------
            if(listitem == 8)
            {
			logo9 = CreateObject(19326,0,0,0,0,0,0);
			SetObjectMaterialText(logo9, "{FFFFFF}l", 0, OBJECT_MATERIAL_SIZE_256x128, "MUSIC LOGOS TFB", 35,0, -16776961, 0,OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			AttachObjectToPlayer(logo9, playerid, 0.000000, -0.120000, 0.40000, 0.000000, 0.00000, 0.000000);
			SendClientMessage(playerid, 0xDEEE20FF, "������������!");
			}
			//--------------------------------------------------------------------------------------------------------------------------
            if(listitem == 9)
            {
			logo10 = CreateObject(19326,0,0,0,0,0,0);
			SetObjectMaterialText(logo10, "{FFFFFF}z", 0, OBJECT_MATERIAL_SIZE_256x128, "MUSIC LOGOS TFB", 35,0, -16776961, 0,OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			AttachObjectToPlayer(logo10, playerid, 0.000000, -0.120000, 0.40000, 0.000000, 0.00000, 0.000000);
			SendClientMessage(playerid, 0xDEEE20FF, "������������!");
			}
			//--------------------------------------------------------------------------------------------------------------------------
            if(listitem == 10)
            {
			logo11 = CreateObject(19326,0,0,0,0,0,0);
			SetObjectMaterialText(logo11, "{FFFFFF}y", 0, OBJECT_MATERIAL_SIZE_256x128, "MUSIC LOGOS TFB", 35,0, -16776961, 0,OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			AttachObjectToPlayer(logo11, playerid, 0.000000, -0.120000, 0.40000, 0.000000, 0.00000, 0.000000);
			SendClientMessage(playerid, 0xDEEE20FF, "������������!");
            }
            //--------------------------------------------------------------------------------------------------------------------------
			if(listitem == 11)
            {
		    DestroyObject(logo1);
			DestroyObject(logo2);
		    DestroyObject(logo3);
			DestroyObject(logo4);
		    DestroyObject(logo5);
			DestroyObject(logo6);
		    DestroyObject(logo7);
			DestroyObject(logo8);
		    DestroyObject(logo9);
			DestroyObject(logo10);
            DestroyObject(logo11);
		    }
          }
          else ShowPlayerDialog(playerid, 1000, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ���������� ����������", ">> [1] ����� \n>> [2] ������ \n>> [3] ���� ���� \n>> [4] ����� ��� \n>> [5] ���� ���� \n>> [6] ������� \n>> [7] ����� �� ����� \n>> [8] {ff0000}������� ���� \n>> [9] ������� ��� \t(%s)", ">>", "X");
        }
//##############################################################################
    if(dialogid == 1005) // id ??????? , ??????? ?? ???? !
    {
      if(response) switch(listitem)
      {
        case 0:
        {
            SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING); // ????? ???
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ���� | ������� [������ ������ ����] � ����� [F]");
            PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0); // ????
			}
            case 1:
			{
			 SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU);
             SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ����-�� | ������ [������ ������ ����] � ����� [F]");
             PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0); // ????
			}
			case 2:
			{
			SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ����� | ������� [������ ������ ����] � ����� [F]");
            PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0); // ????
			}
			case 3:
			{
			SetPlayerFightingStyle(playerid, FIGHT_STYLE_GRABKICK);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ���� | ������� [������ ������ ����] � ����� [F]");
            PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0); // ????
			}
			case 4:
			{
			SetPlayerFightingStyle(playerid, FIGHT_STYLE_NORMAL);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "* �������� | ������� [������ ������ ����] � ����� [F]");
            PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0); // ????
           }
        }
        else ShowPlayerDialog(playerid, 1000, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ���������� ����������", ">> [1] ����� \n>> [2] ������ \n>> [3] ���� ���� \n>> [4] ����� ��� \n>> [5] ���� ���� \n>> [6] ������� \n>> [7] ����� �� ����� \n>> [8] {ff0000}������� ���� \n>> [9] ������� ��� \t(%s)", ">>", "X");
     }
//##############################################################################
    if(dialogid == 5307)//Time
	{
      if(response)
      {
        if(listitem == 0)
        {
        OnPlayerCommandText(playerid,"/skin");
		}
		if(listitem == 1)
        {
        
		}
       }
	 }

    if(dialogid == 1001)//Time
	{

		if(response)
	    {
	        if(listitem == 0)
		    {

		        SetPlayerTime(playerid,0,0);
		    }
		    //--------------------------------------------------------------------------------------------------------------------------
		    if(listitem == 1)
		    {

		        SetPlayerTime(playerid,2,0);
		    }
		    //--------------------------------------------------------------------------------------------------------------------------
		    if(listitem == 2)
		    {

		        SetPlayerTime(playerid,4,0);
		    }
		    //--------------------------------------------------------------------------------------------------------------------------
		    if(listitem == 3)
		    {

		        SetPlayerTime(playerid,6,0);
		    }
		    //--------------------------------------------------------------------------------------------------------------------------
		    if(listitem == 4)
		    {

		        SetPlayerTime(playerid,8,0);
		    }
		    //--------------------------------------------------------------------------------------------------------------------------
		    if(listitem == 5)
		    {

		        SetPlayerTime(playerid,10,0);
		    }
		    //--------------------------------------------------------------------------------------------------------------------------
		    if(listitem == 6)
		    {

		        SetPlayerTime(playerid,12,0);
		    }
		    //--------------------------------------------------------------------------------------------------------------------------
		    if(listitem == 7)
		    {

		        SetPlayerTime(playerid,14,0);
		    }
		    //--------------------------------------------------------------------------------------------------------------------------
		    if(listitem == 8)
		    {

		        SetPlayerTime(playerid,16,0);
		    }
		    //--------------------------------------------------------------------------------------------------------------------------
		    if(listitem == 9)
		    {

		        SetPlayerTime(playerid,18,0);
		    }
		    //--------------------------------------------------------------------------------------------------------------------------
		    if(listitem == 10)
		    {

		        SetPlayerTime(playerid,20,0);
		    }
		    //--------------------------------------------------------------------------------------------------------------------------
		    if(listitem == 11)
		    {

		        SetPlayerTime(playerid,22,0);
		    }
          }
          else ShowPlayerDialog(playerid, 1000, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ���������� ����������", ">> [1] ����� \n>> [2] ������ \n>> [3] ���� ���� \n>> [4] ����� ��� \n>> [5] ���� ���� \n>> [6] ������� \n>> [7] ����� �� ����� \n>> [8] {ff0000}������� ���� \n>> [9] ������� ��� \t(%s)", ">>", "X");
        }
       

//##############################################################################
    if(dialogid == 1006) // ������
	{
		if(response)
		{
			if(listitem == 0)
			{
			new string[2048];
            strcat(string, ">> [1] Motocross \n");
            strcat(string, ">> [2] Motocross \n");
            strcat(string, ">> [3] Motocross \n");
            strcat(string, ">> [4] Motocross \n");
            strcat(string, ">> [5] Motocross \n");
            ShowPlayerDialog(playerid,1010,DIALOG_STYLE_LIST,"{0077FF}Blodhamer Drift :{ffffff} �����",string,">>","X");
			}
			//------------------------------------------------------------------------------
			if(listitem == 1)
			{
			new string[2048];
            strcat(string, ">> [1] Brille \n");
            strcat(string, ">> [2] Brille \n");
            strcat(string, ">> [3] Brille \n");
            strcat(string, ">> [4] Brille \n");
            strcat(string, ">> [5] Brille \n");
            strcat(string, ">> [6] Brille \n");
            strcat(string, ">> [7] Brille \n");
            strcat(string, ">> [8] Brille \n");
            strcat(string, ">> [9] Brille \n");
            strcat(string, ">> [10] Brille \n");
            strcat(string, ">> [11] Brille \n");
            strcat(string, ">> [12] Brille \n");
            strcat(string, ">> [13] Brille \n");
            strcat(string, ">> [14] Brille \n");
            strcat(string, ">> [15] Brille \n");
            strcat(string, ">> [16] Brille \n");
            strcat(string, ">> [17] Brille \n");
            strcat(string, ">> [18] Brille \n");
            strcat(string, ">> [19] Brille \n");
            strcat(string, ">> [20] Brille \n");
            strcat(string, ">> [21] Brille \n");
            strcat(string, ">> [22] Brille \n");
            strcat(string, ">> [23] Brille \n");
            strcat(string, ">> [24] Brille \n");
            strcat(string, ">> [25] Brille \n");
            strcat(string, ">> [26] Brille \n");
            strcat(string, ">> [27] Brille \n");
            strcat(string, ">> [28] Brille \n");
            strcat(string, ">> [29] Brille \n");
            strcat(string, ">> [30] Brille \n");
            ShowPlayerDialog(playerid,1011,DIALOG_STYLE_LIST,"{0077FF}Blodhamer Drift :{ffffff} ����",string,">>","X");
			}
			//------------------------------------------------------------------------------
			if(listitem == 2)
			{
			new string[2048];
            strcat(string, ">> [1] Bandanna \n");
            strcat(string, ">> [2] Bandanna \n");
            strcat(string, ">> [3] Bandanna \n");
            strcat(string, ">> [4] Bandanna \n");
            strcat(string, ">> [5] Bandanna \n");
            strcat(string, ">> [6] Bandanna \n");
            strcat(string, ">> [7] Bandanna \n");
            strcat(string, ">> [8] Bandanna \n");
            strcat(string, ">> [9] Bandanna \n");
            strcat(string, ">> [10] Bandanna \n");
            ShowPlayerDialog(playerid,1012,DIALOG_STYLE_LIST,"{0077FF}Blodhamer Drift :{ffffff} �������",string,">>","X");
			}
			//------------------------------------------------------------------------------
			if(listitem == 3)
			{
			new string[2048];
            strcat(string, ">> [1] Hockeymask \n");
            strcat(string, ">> [2] Hockeymask \n");
            strcat(string, ">> [3] Hockeymask \n");
            strcat(string, ">> [4] Hockeymask \n");
            strcat(string, ">> [5] Zorromask \n");
            strcat(string, ">> [6] Boxing \n");
            ShowPlayerDialog(playerid,1013,DIALOG_STYLE_LIST,"{0077FF}Blodhamer Drift :{ffffff} �����",string,">>","X");
			}
			//------------------------------------------------------------------------------
			if(listitem == 4)
			{
			new string[2048];
            strcat(string, ">> [1] ����� ����� \n");
            strcat(string, ">> [2] ������� �� ����� \n");
            strcat(string, ">> [3] �������� \n");
            strcat(string, ">> [4] ����� \n");
            strcat(string, ">> [5] ���� � ���� \n");
            strcat(string, ">> [6] ����� ����� \n");
            strcat(string, ">> [7] ����� \n");
            strcat(string, ">> [8] ������� \n");
            strcat(string, ">> [9] ����� ������ \n");
            strcat(string, ">> [10] ��� �� ����� \n");
            strcat(string, ">> [11] ��� � ���� \n");
            strcat(string, ">> [12] ������� \n");
            strcat(string, ">> [13] ������� ��� \n");
            ShowPlayerDialog(playerid,1014,DIALOG_STYLE_LIST,"{0077FF}Blodhamer Drift :{ffffff} ������",string,">>","X");
			}
			//------------------------------------------------------------------------------
		    if(listitem == 5)
			{
				new zz=0;
				while(zz!=MAX_PLAYER_ATTACHED_OBJECTS)
				{
					if(IsPlayerAttachedObjectSlotUsed(playerid, zz))
					{
						RemovePlayerAttachedObject(playerid, zz);
					}
					zz++;
				}
			}
         }
         else ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������� ����", ">> [1] ������ \n>> [2] ��������� \n>> [3] �������� \n>> [4] ���������� \n>> [5] ���������� ���������� \n>> [6] {FF00FF}���������� \n>> [7] ������ \n>> [8] {FF0000}����� \n>> [9] ���������� ���� \n>> [10] ������ \n>> [11] ��������� \n>> [12] ����������", ">>", "X");
      }
//##############################################################################
    if(dialogid == 1010) // �����
	{
		if(response)
		{
			if(listitem == 0)//
			{
				SetPlayerAttachedObject(playerid, 1, 18976, 2, 0.09, 0.03, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 1)//
			{
				SetPlayerAttachedObject(playerid, 1, 18645, 2, 0.07, 0, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 2)//
			{
				SetPlayerAttachedObject(playerid, 1, 18977, 2, 0.07, 0, 0, 88, 75, 0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 3)//
			{
				SetPlayerAttachedObject(playerid, 1, 18978, 2, 0.07, 0, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 4)//
			{
				SetPlayerAttachedObject(playerid, 1, 18979, 2, 0.07, 0, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
		 }
		 else ShowPlayerDialog(playerid, 1006, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������", ">> [1] ����� \n>> [2] ���� \n>> [3] ������� \n>> [4] ����� \n>> [5] ������ \n>> {ff0000}�������", ">>", "X");
      }
//##############################################################################
    if(dialogid == 1011) // ����
	{
		if(response)
		{
			if(listitem ==  0)//GlassesType1
			{
				SetPlayerAttachedObject(playerid, 2, 19006, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  1)//GlassesType2
			{
				SetPlayerAttachedObject(playerid, 2, 19007, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  2)//GlassesType3
			{
				SetPlayerAttachedObject(playerid, 2, 19008, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  3)//GlassesType4
			{
				SetPlayerAttachedObject(playerid, 2, 19009, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  4)//GlassesType5
			{
				SetPlayerAttachedObject(playerid, 2, 19010, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  5)//GlassesType6
			{
				SetPlayerAttachedObject(playerid, 2, 19011, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  6)//GlassesType7
			{
				SetPlayerAttachedObject(playerid, 2, 19012, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  7)//GlassesType8
			{
				SetPlayerAttachedObject(playerid, 2, 19013, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  8)//GlassesType9
			{
				SetPlayerAttachedObject(playerid, 2, 19014, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  9)//GlassesType10
			{
				SetPlayerAttachedObject(playerid, 2, 19015, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  10)//GlassesType11
			{
				SetPlayerAttachedObject(playerid, 2, 19016, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  11)//GlassesType12
			{
				SetPlayerAttachedObject(playerid, 2, 19017, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  12)//GlassesType13
			{
				SetPlayerAttachedObject(playerid, 2, 19018, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  13)//GlassesType14
			{
				SetPlayerAttachedObject(playerid, 2, 19019, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  14)//GlassesType15
			{
				SetPlayerAttachedObject(playerid, 2, 19020, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  15)//GlassesType16
			{
				SetPlayerAttachedObject(playerid, 2, 19021, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  16)//GlassesType17
			{
				SetPlayerAttachedObject(playerid, 2, 19022, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  17)//GlassesType18
			{
				SetPlayerAttachedObject(playerid, 2, 19023, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  18)//GlassesType19
			{
				SetPlayerAttachedObject(playerid, 2, 19024, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  19)//GlassesType20
			{
				SetPlayerAttachedObject(playerid, 2, 19025, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  20)//GlassesType21
			{
				SetPlayerAttachedObject(playerid, 2, 19026, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  21)//GlassesType22
			{
				SetPlayerAttachedObject(playerid, 2, 19027, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  22)//GlassesType23
			{
				SetPlayerAttachedObject(playerid, 2, 19028, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  23)//GlassesType24
			{
				SetPlayerAttachedObject(playerid, 2, 19029, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  24)//GlassesType25
			{
				SetPlayerAttachedObject(playerid, 2, 19030, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  25)//GlassesType26
			{
				SetPlayerAttachedObject(playerid, 2, 19031, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  26)//GlassesType27
			{
				SetPlayerAttachedObject(playerid, 2, 19032, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  27)//GlassesType28
			{
				SetPlayerAttachedObject(playerid, 2, 19033, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  28)//GlassesType29
			{
				SetPlayerAttachedObject(playerid, 2, 19034, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  29)//GlassesType30
			{
				SetPlayerAttachedObject(playerid, 2, 19035, 2, 0.09, 0.04, 0, 88, 75, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
		 }
		 else ShowPlayerDialog(playerid, 1006, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������", ">> [1] ����� \n>> [2] ���� \n>> [3] ������� \n>> [4] ����� \n>> [5] ������ \n>> {ff0000}�������", ">>", "X");
      }
//##############################################################################
    if(dialogid == 1012) // �������
	{
		if(response)
		{
			if(listitem ==  0)//bandanna1
			{
				SetPlayerAttachedObject(playerid, 3, 18911, 2, -0.08, 0.03, 0.0, 90, -180, -90);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  1)//bandanna2
			{
				SetPlayerAttachedObject(playerid, 3, 18912, 2, -0.08, 0.03, 0.0, 90, -180, -90);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  2)//bandanna3
			{
				SetPlayerAttachedObject(playerid, 3, 18913, 2, -0.08, 0.03, 0.0, 90, -180, -90);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  3)//bandanna4
			{
				SetPlayerAttachedObject(playerid, 3, 18914, 2, -0.08, 0.03, 0.0, 90, -180, -90);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  4)//bandanna5
			{
				SetPlayerAttachedObject(playerid, 3, 18915, 2, -0.08, 0.03, 0.0, 90, -180, -90);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  5)//bandanna6
			{
				SetPlayerAttachedObject(playerid, 3, 18916, 2, -0.08, 0.03, 0.0, 90, -180, -90);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  6)//bandanna7
			{
				SetPlayerAttachedObject(playerid, 3, 18917, 2, -0.08, 0.03, 0.0, 90, -180, -90);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  7)//bandanna8
			{
				SetPlayerAttachedObject(playerid, 3, 18918, 2, -0.08, 0.03, 0.0, 90, -180, -90);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  8)//bandanna9
			{
				SetPlayerAttachedObject(playerid, 3, 18919, 2, -0.08, 0.03, 0.0, 90, -180, -90);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  9)//bandanna10
			{
				SetPlayerAttachedObject(playerid, 3, 18920, 2, -0.08, 0.03, 0.0, 90, -180, -90);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
		}
		else ShowPlayerDialog(playerid, 1006, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������", ">> [1] ����� \n>> [2] ���� \n>> [3] ������� \n>> [4] ����� \n>> [5] ������ \n>> {ff0000}�������", ">>", "X");
     }
//##############################################################################
    if(dialogid == 1013) // �����
	{
		if(response)
		{
			if(listitem ==  0)//Hockeymask1
			{
				SetPlayerAttachedObject(playerid, 1, 19036, 2, 0.107, 0.020, 0.0, 90, 90, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  1)//Hockeymask2
			{
				SetPlayerAttachedObject(playerid, 1, 19037, 2, 0.107, 0.020, 0.0, 90, 90, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  2)//Hockeymask3
			{
				SetPlayerAttachedObject(playerid, 1, 19038, 2, 0.107, 0.020, 0.0, 90, 90, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  3)//Zorromask
			{
				SetPlayerAttachedObject(playerid, 1, 18974, 2, 0.098, 0.0258, 0.0, 90, 90, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem ==  4)//Boxing
			{
				SetPlayerAttachedObject(playerid, 1, 18952, 2, 0.105, 0.01, 0.0, 0, 0, 0);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
		}
		else ShowPlayerDialog(playerid, 1006, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������", ">> [1] ����� \n>> [2] ���� \n>> [3] ������� \n>> [4] ����� \n>> [5] ������ \n>> {ff0000}�������", ">>", "X");
     }
//##############################################################################
    if(dialogid == 1014) // ������
	{
		if(response)
		{
			if(listitem == 0) // ����� �����
			{
				SetPlayerAttachedObject( playerid, 0, 19065, 2, 0.121128, 0.023578, 0.001139, 222.540847, 90.773872, 211.130859, 1.098305, 1.122310, 1.106640 ); // SantaHat
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 1) // ������� �� �����
			{
				SetPlayerAttachedObject( playerid, 0, 19078, 1, 0.329150, -0.072101, 0.156082, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 ); // TheParrot1
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 2) // �������
			{
				SetPlayerAttachedObject( playerid, 0, 19078, 1, -1.097527, -0.348305, -0.008029, 0.000000, 0.000000, 0.000000, 8.073966, 8.073966, 8.073966 ); // TheParrot1 - parrot man
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 3) // �������
			{
				SetPlayerAttachedObject( playerid, 0, 1371, 1, 0.037538, 0.000000, -0.020199, 350.928314, 89.107200, 180.974227, 1.000000, 1.000000, 1.000000 ); // CJ_HIPPO_BIN - /hippo
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 4) // �����
			{
				SetPlayerAttachedObject( playerid, 0, 18939, 2, 0.147825, 0.010626, -0.004892, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 ); // CapBack1 - Sapca RuTeN
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 5) // ���� � ����
			{
				SetPlayerAttachedObject( playerid, 0, 1210, 6, 0.259532, -0.043030, -0.009978, 85.185333, 271.380615, 253.650283, 1.000000, 1.000000, 1.000000 ); // briefcase - briefcase
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 6) // ����� �����
			{
				SetPlayerAttachedObject( playerid, 0, 1550, 15, 0.016491, 0.205742, -0.208498, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 ); // CJ_MONEY_BAG - money
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 7) // �����
			{
				SetPlayerAttachedObject( playerid, 0, 1608, 1, 0.201047, -1.839761, -0.010739, 0.000000, 90.005447, 0.000000, 1.000000, 1.000000, 1.000000 ); // shark - shark
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 8) // �������
			{
				SetPlayerAttachedObject( playerid, 0, 1607, 1, 0.000000, 0.000000, 0.000000, 0.000000, 86.543479, 0.000000, 1.000000, 1.000000, 1.000000 ); // dolphin - /dolphin
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 9) // ����� ������
			{
				SetPlayerAttachedObject( playerid, 0, 19137, 2, 0.110959, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 ); // CluckinBellHat1 - 7
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 10) // ��� �� ����
			{
				SetPlayerAttachedObject(playerid, 1 , 18637, 1, 0, -0.1, 0.18, 90, 0, 272, 1, 1, 1);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 11) // ��� �� �����
			{
				SetPlayerAttachedObject(playerid, 1, 18637, 4, 0.3, 0, 0, 0, 170, 270, 1, 1, 1);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 12) // �������
			{
				SetPlayerAttachedObject(playerid, 2,18641, 5, 0.1, 0.02, -0.05, 0, 0, 0, 1, 1, 1);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 13) // ����������
			{
				SetPlayerAttachedObject(playerid, 2,18642, 5, 0.12, 0.02, -0.05, 0, 0, 45,1,1,1);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
		}
		else ShowPlayerDialog(playerid, 1006, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������", ">> [1] ����� \n>> [2] ���� \n>> [3] ������� \n>> [4] ����� \n>> [5] ������ \n>> {ff0000}�������", ">>", "X");
     }

    if(dialogid == 6246)
    {
      if(response)
      {
        if(listitem == 0)// Yellow
        {
          TextsActive[playerid] = 1;
          SendClientMessage(playerid, COLOR_LIGHTBLUE,"� {ffffff}����������� {FFFF00}[||||||]");
        }
        if(listitem == 1)// Red
        {
          TextsActive[playerid] = 2;
          SendClientMessage(playerid, COLOR_LIGHTBLUE,"� {ffffff}����������� {FF0000}[||||||]");
        }
        if(listitem == 2)// Blue
        {
          TextsActive[playerid] = 3;
          SendClientMessage(playerid, COLOR_LIGHTBLUE,"� {ffffff}����������� {00BFFF}[||||||]");
        }
        if(listitem == 3)// Green
        {
          TextsActive[playerid] = 4;
          SendClientMessage(playerid, COLOR_LIGHTBLUE,"� {ffffff}����������� {00FF00}[||||||]");
        }
        if(listitem == 4)// Gray
        {
          TextsActive[playerid] = 5;
          SendClientMessage(playerid, COLOR_LIGHTBLUE,"� {ffffff}����������� {696969}[||||||]");
        }
        if(listitem == 5)// Pink
        {
          TextsActive[playerid] = 6;
          SendClientMessage(playerid, COLOR_LIGHTBLUE,"� {ffffff}����������� {FF00FF}[||||||]");
        }
        if(listitem == 6)// White
        {
          TextsActive[playerid] = 7;
          SendClientMessage(playerid, COLOR_LIGHTBLUE,"� {ffffff}����������� {FFFFFF}[||||||]");
        }
      }
      else ShowPlayerDialog(playerid, 1000, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ���������� ����������", ">> [1] ����� \n>> [2] ������ \n>> [3] ���� ���� \n>> [4] ����� ��� \n>> [5] ���� ���� \n>> [6] ������� \n>> [7] ����� �� ����� \n>> [8] {ff0000}������� ���� \n>> [9] ������� ��� \t(%s)", ">>", "X");
    }
//##############################################################################
    if(dialogid==1002)
{
if(listitem== 0)
{
SetPlayerWeather(playerid,0);
}
if(listitem== 1)
{
SetPlayerWeather(playerid,09);
}
if(listitem== 2)
{
SetPlayerWeather(playerid,10);
}
if(listitem== 3)
{
SetPlayerWeather(playerid,11);
}
if(listitem== 4)
{
SetPlayerWeather(playerid,12);
}
if(listitem== 5)
{
SetPlayerWeather(playerid,16);
}
if(listitem== 6)
{
SetPlayerWeather(playerid,17);
}
if(listitem== 7)
{
SetPlayerWeather(playerid,19);
}
if(listitem== 8)
{
SetPlayerWeather(playerid,20);
        }
        else ShowPlayerDialog(playerid, 1000, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ���������� ����������", ">> [1] ����� \n>> [2] ������ \n>> [3] ���� ���� \n>> [4] ����� ��� \n>> [5] ���� ���� \n>> [6] ������� \n>> [7] ����� �� ����� \n>> [8] {ff0000}������� ���� \n>> [9] ������� ��� \t(%s)", ">>", "X");
     }
//##############################################################################
    if(dialogid == 1003)
{
if(response)
{
switch(listitem)
{
case 0:
{
SetPlayerColor(playerid,0xAA3333AA);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {F70519}[||||||]");
}
case 1:
{
SetPlayerColor(playerid,0xAFAFAFAA);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {575455}[||||||]");
}
case 2:
{
SetPlayerColor(playerid,0x008000AA);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {368426}[||||||]");
}
case 3:
{
SetPlayerColor(playerid,0xFF80FFAA);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {E32BD3}[||||||]");
}
case 4:
{
SetPlayerColor(playerid,0x00FF40AA);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {03FD03}[||||||]");
}
case 5:
{
SetPlayerColor(playerid,0x0000FFAA);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {3521E9}[||||||]");
}
case 6:
{
SetPlayerColor(playerid,0xFFFF00AA);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {D5E921}[||||||]");
}
case 7:
{
SetPlayerColor(playerid,0x00FFFFAA);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {21E9D5}[||||||]");
}
case 8:
{
SetPlayerColor(playerid,0xFF8000AA);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {E9AD21}[||||||]");
}
case 9:
{
SetPlayerColor(playerid,0xFF00FFAA);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {FF00FF}[||||||]");
}
case 10:
{
SetPlayerColor(playerid,0xF96C77AA);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {FF6347}[||||||]");
}
case 11:
{
SetPlayerColor(playerid,0x400080AA);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {551A8B}[||||||]");
}
case 12:
{
SetPlayerColor(playerid,0x808000AA);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {A4A208}[||||||]");
}
case 13:
{
SetPlayerColor(playerid,0x808040AA);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {698B22}[||||||]");
}
case 14:
{
SetPlayerColor(playerid,0x809E21AA);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {9ACD32}[||||||]");
}
case 15:
{
SetPlayerColor(playerid,0x804040AA);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {8B4513}[||||||]");
}
case 16:
{
SetPlayerColor(playerid,0xAD163DAA);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {EE6A50}[||||||]");
}
case 17:
{
SetPlayerColor(playerid,0xFF4500AA);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {FF4500}[||||||]");
}
case 18:
{
SetPlayerColor(playerid,0xFFFFFF00);
SendClientMessage(playerid, COLOR_LIGHTBLUE, "� {ffffff}����������� {FFFFFF}[||||||]");
      }
    }
  }
  else ShowPlayerDialog(playerid, 1000, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ���������� ����������", ">> [1] ����� \n>> [2] ������ \n>> [3] ���� ���� \n>> [4] ����� ��� \n>> [5] ���� ���� \n>> [6] ������� \n>> [7] ����� �� ����� \n>> [8] {ff0000}������� ���� \n>> [9] ������� ��� \t(%s)", ">>", "X");
}
//##############################################################################
    if(dialogid == 1004)//???????
	{
		if(response)
		{
   			if(listitem == 0)
		    {
		    SetPlayerAttachedObject( playerid, 0, 18728, 2, 0.134301, 1.475258, -0.192459, 82.870338, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
			}
			if(listitem == 1)
			{
			SetPlayerAttachedObject( playerid, 0, 2114, 2, 0.043076, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
			}
			if(listitem == 2)
		    {
		    SetPlayerAttachedObject( playerid, 0, 18844, 1, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, -0.027590, -0.027590, -0.027590 );
			}
			if(listitem == 3)
			{
            SetPlayerAttachedObject( playerid, 0, 18749, 2, 0.264992, 0.043229, -0.004249, 0.000000, 87.368362, 165.130233, 1.000000, 1.000000, 1.000000 );
			}
            if(listitem == 4)
            {
            RemovePlayerAttachedObject(playerid, 0);
            DestroyPlayerObject(playerid, 18728);
			}
		}
		else ShowPlayerDialog(playerid, 1000, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ���������� ����������", ">> [1] ����� \n>> [2] ������ \n>> [3] ���� ���� \n>> [4] ����� ��� \n>> [5] ���� ���� \n>> [6] ������� \n>> [7] ����� �� ����� \n>> [8] {ff0000}������� ���� \n>> [9] ������� ��� \t(%s)", ">>", "X");
     }
//##############################################################################
    if(dialogid == 222)
	{
		if(response)
		{
		    if(listitem == 0)
			{
  			ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ��������� �����", "[1]  [LV] ���\n[2]  [LV] ��������\n[3]  [SF] �������-����\n[4]  [SF] ��������\n[5]  [LS] �������\n[6]  [LV] ���������-1\n[7]  [SF] ���������-2\n[8]  [LS] ����-1\n[9]  [LV] ��������\n[10]  [LS] ����-2", "�������", "�����");
			}
		    if(listitem == 1)
	        {
  			ShowPlayerDialog(playerid, 7, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ��������� ����", "[1]  [LV] �����\n[2]  [LS] ����\n[3]  [SF] 2-�����\n[4]  [SF] ������\n[5]  [LV] �����-2\n[6]  [SF] ��������", "�������", "�����");
			}
		    if(listitem == 2)
			{
  			ShowPlayerDialog(playerid, 8, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ��������� ������", "[1]  [LS] ������\n[2]  [LS] ������\n[3]  [SF] ������\n[4]  [SF] ������\n[5]  [SF] ������", "�������", "�����");
  			}
		    if(listitem == 3)
			{
  			ShowPlayerDialog(playerid, 999, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ��������� BMX �����", "[1] [SF] Bmx1\n[2] [SF] Bmx2", "�������", "�����");
			}
			if(listitem == 4)
			{
  			ShowPlayerDialog(playerid, 10, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ��������� ������", "[1] [LS] Gruv-Street\n[2] [SF] Mafia\n[3] [LV] ���������", "�������", "�����");
  			}
        }
        else ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������� ����", ">> [1] ������ \n>> [2] ��������� \n>> [3] �������� \n>> [4] ���������� \n>> [5] ���������� ���������� \n>> [6] {FF00FF}���������� \n>> [7] ������ \n>> [8] {FF0000}����� \n>> [9] ���������� ���� \n>> [10] ������ \n>> [11] ��������� \n>> [12] ����������", ">>", "X");
	}

	//##############################################################################
    if(dialogid == 4)//tuning menu �������
	{
		if(response)
		{
		    if(listitem == 0)
		    {
		    	ShowPlayerDialog(playerid, 30, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ ������", ">> [1] Shadow\n>> [2] Mega\n>> [3] Wires\n>> [4] Classic\n>> [5] Rimshine\n>> [6] Cutter\n>> [7] Twist\n>> [8] Switch\n>> [9] Grove\n>> [10] Import\n>> [11] Dollar\n>> [12] Trance\n>> [13] Atomic", ">>", "X");
			}
			if(listitem == 1)
		    {
		    	new vehicleid = GetPlayerVehicleID(playerid);
				AddVehicleComponent(vehicleid,1087);
				PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
				ShowPlayerDialog(playerid, 4, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ ����", ">> [1] �����\n>> [2] ����������\n>> [3] �������� ������\n>> [4] ����\n>> [5] ������\n>> [6] ����\n>> [7] ����� ������\n>> [8] ����\n>> [9] ������� ������", ">>", "X");
			}
			if(listitem == 2)
			{
			    new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
				switch(Model)
				{
					case 559,560,561,562,565,558: ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ Wheel Arch Angels", ">> [1] �������� ������ X-flow\n>> [2] �������� ������ Alien\n>> [3] ������ ������ X-Flow\n>> [4] ������ ������ Alien\
					\n>> [5] ������� X-Flow \n>> [6] ������� Alien \n>> [7] ������� ���� X-Flow \n>> [8] ������� ���� Alien\n>> [9] ��������������� X-Flow\n>> [10] ��������������� Alien\n>> [11] ������ X-flow\n>> [12] ������ Alien", ">>", "X");
					default: SendClientMessage(playerid,0xFFFFFFFF,"�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus");
				}
			}
			if(listitem == 3)
			{
			new string[2048];
            strcat(string, ">> [1] ���� {FF0009}[||||||] \n");
            strcat(string, ">> [2] ���� {06FFDE}[||||||]  \n");
            strcat(string, ">> [3] ���� {EEFF06}[||||||]  \n");
            strcat(string, ">> [4] ���� {2AAE1C}[||||||]  \n");
            strcat(string, ">> [5] ���� {666262}[||||||] \n");
            strcat(string, ">> [6] ���� {FBA104}[||||||] \n");
            strcat(string, ">> [7] ���� {080808}[||||||] \n");
            strcat(string, ">> [8] ���� {ffffff}[||||||] \n");
            strcat(string, ">> [9] ���� {7B239D}[||||||] \n");
            strcat(string, ">> [10] ���� {66400A}[||||||] \n");
            strcat(string, ">> [11] ���� {E71BAE}[||||||] \n");
            strcat(string, ">> [12] ���� {34C2F1}[||||||] \n");
            strcat(string, ">> [13] ���� {CFB685}[||||||] \n");
            strcat(string, ">> [14] ���� {0EC29B}[||||||] \n");
            strcat(string, ">> [15] ���� {0EC29B}[||||||] \n");
            ShowPlayerDialog(playerid,13,DIALOG_STYLE_LIST,"{0077FF}Blodhamer Drift :{ffffff} ����� �����",string,">>","X");
			}
			if(listitem == 4)ShowPlayerDialog(playerid, 14, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ����� ������", ">> [1] ����� \n>> [2] ����� \n>> [3] ����� \n>> [4] �����", "��", "�����");
			if(listitem == 5)
			{
			new string[2048];
            strcat(string, ">> [1] ���� {FF3300}[||||||] \n");
            strcat(string, ">> [2] ���� {0033CC}[||||||]  \n");
            strcat(string, ">> [3] ���� {33FF00}[||||||]  \n");
            strcat(string, ">> [4] ���� {FFFF00}[||||||]  \n");
            strcat(string, ">> [5] ���� {FEBFEF}[||||||] \n");
            strcat(string, ">> [6] ���� {FEFEFE}[||||||] \n");
            strcat(string, ">> {ff0000}��������� \n");
            ShowPlayerDialog(playerid,8234,DIALOG_STYLE_LIST,"{0077FF}Blodhamer Drift :{ffffff} ����",string,">>","X");
			}
			if(listitem == 6)ShowPlayerDialog(playerid, 698 ,DIALOG_STYLE_INPUT,"{0077FF}Blodhamer Drift :{ffffff} ����� ������","������� ������ ���� � ������(8 ��������)",">>","X");
            if(listitem == 7)
            {
            new string[2048];
            strcat(string, ">> [1] ���������� {ffffff}[||||||] \n");
            strcat(string, ">> [2] ���������� {ff0000}[||||||]  \n");
            strcat(string, ">> [3] ���������� {00ff00}[||||||]  \n");
            strcat(string, ">> [4] ���������� {42aaff}[||||||] \n");
            strcat(string, ">> [5] ���������� {ffffff}[|||{1811F7}|||] \n");
            strcat(string, ">> {ff0000}��������� \n");
            ShowPlayerDialog(playerid,1020,DIALOG_STYLE_LIST,"{0077FF}Blodhamer Drift :{ffffff} ����",string,">>","X");
			}
            if(listitem == 8) // ������� ������ ����
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				new cartype = GetVehicleModel(vehicleid);

				if(cartype == 562)
				{
					AddVehicleComponent(vehicleid,1146);
					AddVehicleComponent(vehicleid,1034);
					AddVehicleComponent(vehicleid,1035);
					AddVehicleComponent(vehicleid,1036);
					AddVehicleComponent(vehicleid,1040);
					AddVehicleComponent(vehicleid,1149);
					AddVehicleComponent(vehicleid,1171);
					AddVehicleComponent(vehicleid,1079);
				}

				if(cartype == 560)
				{
					AddVehicleComponent(vehicleid,1139);
					AddVehicleComponent(vehicleid,1026);
					AddVehicleComponent(vehicleid,1027);
					AddVehicleComponent(vehicleid,1029);
					AddVehicleComponent(vehicleid,1032);
					AddVehicleComponent(vehicleid,1149);
					AddVehicleComponent(vehicleid,1141);
					AddVehicleComponent(vehicleid,1169);
					AddVehicleComponent(vehicleid,1079);
				}

				if(cartype == 559)
				{
					AddVehicleComponent(vehicleid,1158);
					AddVehicleComponent(vehicleid,1162);
					AddVehicleComponent(vehicleid,1159);
					AddVehicleComponent(vehicleid,1160);
					AddVehicleComponent(vehicleid,1069);
					AddVehicleComponent(vehicleid,1070);
					AddVehicleComponent(vehicleid,1067);
					AddVehicleComponent(vehicleid,1065);
					AddVehicleComponent(vehicleid,1079);
				}

				if(cartype == 575)
				{
					AddVehicleComponent(vehicleid,1042);
					AddVehicleComponent(vehicleid,1044);
					AddVehicleComponent(vehicleid,1174);
					AddVehicleComponent(vehicleid,1176);
					AddVehicleComponent(vehicleid,1079);
				}

				if(cartype == 558)
				{
					AddVehicleComponent(vehicleid,1164);
					AddVehicleComponent(vehicleid,1088);
					AddVehicleComponent(vehicleid,1092);
					AddVehicleComponent(vehicleid,1090);
					AddVehicleComponent(vehicleid,1094);
					AddVehicleComponent(vehicleid,1166);
					AddVehicleComponent(vehicleid,1168);
					AddVehicleComponent(vehicleid,1079);
				}

				if(cartype == 561)
				{
					AddVehicleComponent(vehicleid,1058);
					AddVehicleComponent(vehicleid,1055);
					AddVehicleComponent(vehicleid,1056);
					AddVehicleComponent(vehicleid,1062);
					AddVehicleComponent(vehicleid,1064);
					AddVehicleComponent(vehicleid,1154);
					AddVehicleComponent(vehicleid,1155);
					AddVehicleComponent(vehicleid,1079);
				}

				if(cartype == 565)
				{
					AddVehicleComponent(vehicleid,1049);
					AddVehicleComponent(vehicleid,1046);
					AddVehicleComponent(vehicleid,1047);
					AddVehicleComponent(vehicleid,1051);
					AddVehicleComponent(vehicleid,1054);
					AddVehicleComponent(vehicleid,1150);
					AddVehicleComponent(vehicleid,1153);
					AddVehicleComponent(vehicleid,1079);
				}

				if(cartype == 576)
				{
					AddVehicleComponent(vehicleid,1134);
					AddVehicleComponent(vehicleid,1136);
					AddVehicleComponent(vehicleid,1137);
					AddVehicleComponent(vehicleid,1190);
					AddVehicleComponent(vehicleid,1192);
					AddVehicleComponent(vehicleid,1010);
					AddVehicleComponent(vehicleid,1076);
				}

				if(cartype == 534)
				{
					AddVehicleComponent(vehicleid,1124);
					AddVehicleComponent(vehicleid,1106);
					AddVehicleComponent(vehicleid,1126);
					AddVehicleComponent(vehicleid,1125);
					AddVehicleComponent(vehicleid,1179);
					AddVehicleComponent(vehicleid,1180);
				}

				if(cartype == 567)
				{
					AddVehicleComponent(vehicleid,1133);
					AddVehicleComponent(vehicleid,1130);
					AddVehicleComponent(vehicleid,1186);
					AddVehicleComponent(vehicleid,1188);
					AddVehicleComponent(vehicleid,1129);
				}

				if(cartype == 535)
				{
					AddVehicleComponent(vehicleid,1110);
					AddVehicleComponent(vehicleid,1111);
					AddVehicleComponent(vehicleid,1113);
					AddVehicleComponent(vehicleid,1115);
					AddVehicleComponent(vehicleid,1117);
					AddVehicleComponent(vehicleid,1118);
					AddVehicleComponent(vehicleid,1120);
					AddVehicleComponent(vehicleid,1010);
					AddVehicleComponent(vehicleid,1079);
				}

				if(cartype == 536)
				{
					AddVehicleComponent(vehicleid,1182);
					AddVehicleComponent(vehicleid,1184);
					AddVehicleComponent(vehicleid,1107);
					AddVehicleComponent(vehicleid,1108);
				}

				if(cartype == 415)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
				}

				if(cartype == 405)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
				}

				if(cartype == 439)
				{
					AddVehicleComponent(vehicleid,1013);
					AddVehicleComponent(vehicleid,1145);
					AddVehicleComponent(vehicleid,1023);
				}

				if(cartype == 400)
				{
					AddVehicleComponent(vehicleid,1024);
					AddVehicleComponent(vehicleid,1018);
				}

				if(cartype == 477)
				{
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
					AddVehicleComponent(vehicleid,1006);
				}

				if(cartype == 404)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1013);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
				}

				if(cartype == 410)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1024);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
				}

				if(cartype == 478)
				{
					AddVehicleComponent(vehicleid,1012);
					AddVehicleComponent(vehicleid,1013);
					AddVehicleComponent(vehicleid,1018);
				}

				if(cartype == 589)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1024);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
					AddVehicleComponent(vehicleid,1012);
					AddVehicleComponent(vehicleid,1145);
					AddVehicleComponent(vehicleid,1006);
				}

				if(cartype == 401)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1024);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
					AddVehicleComponent(vehicleid,1012);
					AddVehicleComponent(vehicleid,1145);
					AddVehicleComponent(vehicleid,1006);
				}

				if(cartype == 418)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1006);
				}

				if(cartype == 420)
				{
					AddVehicleComponent(vehicleid,1012);
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
				}

				if(cartype == 421)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
				}

				if(cartype == 422)
				{
					AddVehicleComponent(vehicleid,1013);
					AddVehicleComponent(vehicleid,1018);
				}

				if(cartype == 426)
				{
					AddVehicleComponent(vehicleid,1006);
					AddVehicleComponent(vehicleid,1012);
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
				}

				if(cartype == 436)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1024);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
					AddVehicleComponent(vehicleid,1006);
				}

				if(cartype == 491)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
					AddVehicleComponent(vehicleid,1145);
				}

				if(cartype == 492)
				{
					AddVehicleComponent(vehicleid,1012);
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1006);
				}

				if(cartype == 496)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
					AddVehicleComponent(vehicleid,1012);
					AddVehicleComponent(vehicleid,1145);
					AddVehicleComponent(vehicleid,1006);
				}

				if(cartype == 500)
				{
					AddVehicleComponent(vehicleid,1013);
					AddVehicleComponent(vehicleid,1018);
				}

				if(cartype == 516)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
					AddVehicleComponent(vehicleid,1012);
				}

				if(cartype == 517)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
					AddVehicleComponent(vehicleid,1145);
				}

				if(cartype == 518)
				{
					AddVehicleComponent(vehicleid,1006);
					AddVehicleComponent(vehicleid,1012);
					AddVehicleComponent(vehicleid,1013);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
					AddVehicleComponent(vehicleid,1145);
				}

				if(cartype == 527)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
				}

				if(cartype == 529)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1006);
					AddVehicleComponent(vehicleid,1012);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
				}

				if(cartype == 540)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1024);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
					AddVehicleComponent(vehicleid,1012);
					AddVehicleComponent(vehicleid,1145);
					AddVehicleComponent(vehicleid,1006);
				}

				if(cartype == 542)
				{
					AddVehicleComponent(vehicleid,1145);
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
				}

				if(cartype == 546)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1024);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
					AddVehicleComponent(vehicleid,1012);
					AddVehicleComponent(vehicleid,1145);
					AddVehicleComponent(vehicleid,1006);
				}

				if(cartype == 547)
				{
					AddVehicleComponent(vehicleid,1145);
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
				}

				if(cartype == 549)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
					AddVehicleComponent(vehicleid,1012);
					AddVehicleComponent(vehicleid,1145);
				}

				if(cartype == 550)
				{
					AddVehicleComponent(vehicleid,1006);
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1012);
					AddVehicleComponent(vehicleid,1145);
				}

				if(cartype == 551)
				{
					AddVehicleComponent(vehicleid,1006);
					AddVehicleComponent(vehicleid,1012);
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
				}

				if(cartype == 580)
				{
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
					AddVehicleComponent(vehicleid,1006);
				}

				if(cartype == 585)
				{
					AddVehicleComponent(vehicleid,1024);
					AddVehicleComponent(vehicleid,1145);
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
					AddVehicleComponent(vehicleid,1006);
				}

				if(cartype == 600)
				{
					AddVehicleComponent(vehicleid,1024);
					AddVehicleComponent(vehicleid,1012);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
					AddVehicleComponent(vehicleid,1006);
				}

				if(cartype == 603)
				{
					AddVehicleComponent(vehicleid,1145);
					AddVehicleComponent(vehicleid,1023);
					AddVehicleComponent(vehicleid,1024);
					AddVehicleComponent(vehicleid,1018);
					AddVehicleComponent(vehicleid,1007);
					AddVehicleComponent(vehicleid,1017);
					AddVehicleComponent(vehicleid,1006);
				}
			  }
		    }
		   else ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������� ����", ">> [1] ������ \n>> [2] ��������� \n>> [3] �������� \n>> [4] ���������� \n>> [5] ���������� ���������� \n>> [6] {FF00FF}���������� \n>> [7] ������ \n>> [8] {FF0000}����� \n>> [9] ���������� ���� \n>> [10] ������ \n>> [11] ��������� \n>> [12] ����������", ">>", "X");
         }
//##############################################################################
    if(dialogid == 1020) // ��������� ���
	{
		if(response)
		{
			if(listitem == 0)
			{
				DestroyObject(ObjectSelect[GetPlayerVehicleID(playerid)][2]);
				DestroyObject(ObjectSelect[GetPlayerVehicleID(playerid)][3]);
				ObjectSelect[GetPlayerVehicleID(playerid)][2] = CreateObject(19281,0,0,0,0,0,0,100.0);
				ObjectSelect[GetPlayerVehicleID(playerid)][3] = CreateObject(19281,0,0,0,0,0,0,100.0);
				AttachObjectToVehicle(ObjectSelect[GetPlayerVehicleID(playerid)][2], GetPlayerVehicleID(playerid), -0.8, 2.25, 0.0, 0.0, 0.0, 180.0);
				AttachObjectToVehicle(ObjectSelect[GetPlayerVehicleID(playerid)][3], GetPlayerVehicleID(playerid), 0.8, 2.25, 0.0, 0.0, 0.0, 180.0);
				PlayerPlaySound(playerid,1150,0.0,0.0,0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 1)
			{
				DestroyObject(ObjectSelect[GetPlayerVehicleID(playerid)][2]);
				DestroyObject(ObjectSelect[GetPlayerVehicleID(playerid)][3]);
				ObjectSelect[GetPlayerVehicleID(playerid)][2] = CreateObject(19282,0,0,0,0,0,0,100.0);
				ObjectSelect[GetPlayerVehicleID(playerid)][3] = CreateObject(19282,0,0,0,0,0,0,100.0);
				AttachObjectToVehicle(ObjectSelect[GetPlayerVehicleID(playerid)][2], GetPlayerVehicleID(playerid), -0.8, 2.25, 0.0, 0.0, 0.0, 180.0);
				AttachObjectToVehicle(ObjectSelect[GetPlayerVehicleID(playerid)][3], GetPlayerVehicleID(playerid), 0.8, 2.25, 0.0, 0.0, 0.0, 180.0);
				PlayerPlaySound(playerid,1150,0.0,0.0,0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 2)
			{
				DestroyObject(ObjectSelect[GetPlayerVehicleID(playerid)][2]);
				DestroyObject(ObjectSelect[GetPlayerVehicleID(playerid)][3]);
				ObjectSelect[GetPlayerVehicleID(playerid)][2] = CreateObject(19283,0,0,0,0,0,0,100.0);
				ObjectSelect[GetPlayerVehicleID(playerid)][3] = CreateObject(19283,0,0,0,0,0,0,100.0);
				AttachObjectToVehicle(ObjectSelect[GetPlayerVehicleID(playerid)][2], GetPlayerVehicleID(playerid), -0.8, 2.25, 0.0, 0.0, 0.0, 180.0);
				AttachObjectToVehicle(ObjectSelect[GetPlayerVehicleID(playerid)][3], GetPlayerVehicleID(playerid), 0.8, 2.25, 0.0, 0.0, 0.0, 180.0);
				PlayerPlaySound(playerid,1150,0.0,0.0,0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 3)
			{
				DestroyObject(ObjectSelect[GetPlayerVehicleID(playerid)][2]);
				DestroyObject(ObjectSelect[GetPlayerVehicleID(playerid)][3]);
				ObjectSelect[GetPlayerVehicleID(playerid)][2] = CreateObject(19284,0,0,0,0,0,0,100.0);
				ObjectSelect[GetPlayerVehicleID(playerid)][3] = CreateObject(19284,0,0,0,0,0,0,100.0);
				AttachObjectToVehicle(ObjectSelect[GetPlayerVehicleID(playerid)][2], GetPlayerVehicleID(playerid), -0.8, 2.25, 0.0, 0.0, 0.0, 180.0);
				AttachObjectToVehicle(ObjectSelect[GetPlayerVehicleID(playerid)][3], GetPlayerVehicleID(playerid), 0.8, 2.25, 0.0, 0.0, 0.0, 180.0);
				PlayerPlaySound(playerid,1150,0.0,0.0,0.0);
			}
			//------------------------------------------------------------------------------
			if(listitem == 4)
			{
				DestroyObject(ObjectSelect[GetPlayerVehicleID(playerid)][2]);
				DestroyObject(ObjectSelect[GetPlayerVehicleID(playerid)][3]);
				ObjectSelect[GetPlayerVehicleID(playerid)][2] = CreateObject(19293,0,0,0,0,0,0,100.0);
				ObjectSelect[GetPlayerVehicleID(playerid)][3] = CreateObject(19293,0,0,0,0,0,0,100.0);
				AttachObjectToVehicle(ObjectSelect[GetPlayerVehicleID(playerid)][2], GetPlayerVehicleID(playerid), -0.8, 2.25, 0.0, 0.0, 0.0, 180.0);
				AttachObjectToVehicle(ObjectSelect[GetPlayerVehicleID(playerid)][3], GetPlayerVehicleID(playerid), 0.8, 2.25, 0.0, 0.0, 0.0, 180.0);
				PlayerPlaySound(playerid,1150,0.0,0.0,0.0);
			}
			//------------------------------------------------------------------------------
			else if(listitem== 5)
			{
				DestroyObject(ObjectSelect[GetPlayerVehicleID(playerid)][2]);
				DestroyObject(ObjectSelect[GetPlayerVehicleID(playerid)][3]);
			}
		}
		else ShowPlayerDialog(playerid, 1020, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ ����", ">> [1] �����\n>> [2] ����������\n>> [3] �������� ������\n>> [4] ����\n>> [5] ������\n>> [6] ����\n>> [7] ����� ������\n>> [8] ����\n>> [9] ������� ������", ">>", "X");
	}
//##############################################################################
    if(dialogid == 698)
	{
		if(response)
		{
		    if(!strlen(inputtext))
	    	{
				ShowPlayerDialog(playerid,2,DIALOG_STYLE_INPUT,"{0077FF}Blodhamer Drift :{ffffff} ����� ������","������� ������ ���� � ������(8 ��������)","������","������");
				return 1;
	    	}
	    	if(strlen(inputtext) > 8)
	    	{
				ShowPlayerDialog(playerid,2,DIALOG_STYLE_INPUT,"{0077FF}Blodhamer Drift :{ffffff} ����� ������","C������ ������� �����!\n������� ������ ���� � ������","������","������");
				return 1;
	    	}
            new Float:x,Float:y,Float:z,Float:ang;
            SetVehicleNumberPlate(GetPlayerVehicleID(playerid), inputtext);
			GetVehiclePos(GetPlayerVehicleID(playerid),x,y,z);
			GetVehicleZAngle(GetPlayerVehicleID(playerid),ang);
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SetVehiclePos(GetPlayerVehicleID(playerid),x,y,z);
			PutPlayerInVehicle(playerid,GetPlayerVehicleID(playerid),0);
			SetVehicleZAngle(GetPlayerVehicleID(playerid),ang);
		}
     }

//##############################################################################
	if(dialogid == 30)//spisok diskov
	{
		if(response)
		{
			new vehicleid = GetPlayerVehicleID(playerid);

		    if(listitem == 0)AddVehicleComponent(vehicleid,1073);
			if(listitem == 1)AddVehicleComponent(vehicleid,1074);
			if(listitem == 2)AddVehicleComponent(vehicleid,1076);
			if(listitem == 3)AddVehicleComponent(vehicleid,1077);
			if(listitem == 4)AddVehicleComponent(vehicleid,1075);
			if(listitem == 5)AddVehicleComponent(vehicleid,1079);
			if(listitem == 6)AddVehicleComponent(vehicleid,1078);
			if(listitem == 7)AddVehicleComponent(vehicleid,1080);
			if(listitem == 8)AddVehicleComponent(vehicleid,1081);
			if(listitem == 9)AddVehicleComponent(vehicleid,1082);
			if(listitem == 10)AddVehicleComponent(vehicleid,1083);
			if(listitem == 11)AddVehicleComponent(vehicleid,1084);
			if(listitem == 12)AddVehicleComponent(vehicleid,1085);

			PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
			ShowPlayerDialog(playerid, 30, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ ������", ">> [1] Shadow\n>> [2] Mega\n>> [3] Wires\n>> [4] Classic\n>> [5] Rimshine\n>> [6] Cutter\n>> [7] Twist\n>> [8] Switch\
            \n>> [9] Grove\n>> [10] Import\n>> [1] Dollar\n>> [11] Trance\n>> [12] Atomic", ">>", "X");
		}
		else ShowPlayerDialog(playerid, 4, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ ����", ">> [1] �����\n>> [2] ����������\n>> [3] �������� ������\n>> [4] ����\n>> [5] ������\n>> [6] ����\n>> [7] ����� ������\n>> [8] ����\n>> [9] ������� ������", ">>", "X");
   }
//##############################################################################
	if(dialogid == 13)//colors             cveta
	{
		if(response)
		{
		    new vehicleid = GetPlayerVehicleID(playerid);

 			if(listitem == 0)ChangeVehicleColor(vehicleid, 3, 3);
			if(listitem == 1)ChangeVehicleColor(vehicleid, 79, 79);
			if(listitem == 2)ChangeVehicleColor(vehicleid, 65, 65);
			if(listitem == 3)ChangeVehicleColor(vehicleid, 86, 86);
			if(listitem == 4)ChangeVehicleColor(vehicleid, 9, 9);
			if(listitem == 5)ChangeVehicleColor(vehicleid, 6, 6);
			if(listitem == 6)ChangeVehicleColor(vehicleid, 0, 0);
			if(listitem == 7)ChangeVehicleColor(vehicleid, 1, 1);
            if(listitem == 8)ChangeVehicleColor(vehicleid, 5, 5);
            if(listitem == 9)ChangeVehicleColor(vehicleid, 30, 30);
            if(listitem == 10)ChangeVehicleColor(vehicleid, 126, 126);
            if(listitem == 11)ChangeVehicleColor(vehicleid, 2, 2);
            if(listitem == 12)ChangeVehicleColor(vehicleid, 99, 99);
            if(listitem == 13)ChangeVehicleColor(vehicleid, 38, 38);
            if(listitem == 14)ChangeVehicleColor(vehicleid, 56, 56);

			PlayerPlaySound(playerid,1134,0.0,0.0,0.0);
   		}
		else ShowPlayerDialog(playerid, 4, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ ����", ">> [1] �����\n>> [2] ����������\n>> [3] �������� ������\n>> [4] ����\n>> [5] ������\n>> [6] ����\n>> [7] ����� ������\n>> [8] ����\n>> [9] ������� ������", ">>", "X");
	}
//##############################################################################
	if(dialogid == 9)//car spawning into
	{
	    if(response)//�������� �� ����, ����� �� �����-�� ����, ��� �� ����� - ������ �������.
		{
            new string[256];
            if (PlayerInfo[playerid][pScore] >= 0)
	        {
		    if(listitem == 0)
		    {
 				ShowModelSelectionMenu(playerid, car1, "Level 1");
 				return 1;
			}
			
            }
            if (PlayerInfo[playerid][pScore] >= 1000)
	        {
		 	if(listitem == 1)
			{
				ShowModelSelectionMenu(playerid, car2, "Level 2");
				return 1;
			}
			}
			if (PlayerInfo[playerid][pScore] >= 2500)
            {
		 	if(listitem == 2)
			{
			    ShowModelSelectionMenu(playerid, car3, "Level 3");
			    return 1;
			}
			}
			if (PlayerInfo[playerid][pScore] >= 5000)
            {
		 	if(listitem == 3)
			{
			    ShowModelSelectionMenu(playerid, car4, "Level 4");
			    return 1;
			}
			}
			if (PlayerInfo[playerid][pScore] >= 8000)
            {
		 	if(listitem == 4)
			{
			    ShowModelSelectionMenu(playerid, car5, "Level 5");
			    return 1;
			}
			}
			format(string,sizeof(string),"� ��� %s",RangName(playerid)); SendClientMessage(playerid,0x21DD00FF,string);
 	  }
    }
	//##############################################################################
	if(dialogid == 14)//vinils
 	{
  		if(response)
    	{
		    new vehicleid = GetPlayerVehicleID(playerid);
			ChangeVehiclePaintjob(vehicleid,listitem+0);
		    PlayerPlaySound(playerid,1134,0.0,0.0,0.0);
		}
		else ShowPlayerDialog(playerid, 14, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ����� ������", ">> [1] ����� \n>> [2] ����� \n>> [3] ����� \n>> [4] �����", "��", "�����");
	}
	//##############################################################################
 	if(dialogid == 12)//WAA tune
 	{
  		if(response)
    	{
  			if(listitem == 0)// x front
			{
    			new vehicleid = GetPlayerVehicleID(playerid);
				new cartype = GetVehicleModel(vehicleid);

				if(cartype == 562)AddVehicleComponent(vehicleid,1172);
				if(cartype == 560)AddVehicleComponent(vehicleid,1170);
				if(cartype == 565)AddVehicleComponent(vehicleid,1152);
				if(cartype == 559)AddVehicleComponent(vehicleid,1173);
				if(cartype == 561)AddVehicleComponent(vehicleid,1157);
				if(cartype == 558)AddVehicleComponent(vehicleid,1165);

				PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
				ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ Wheel Arch Angels", ">> [1] �������� ������ X-flow\n>> [2] �������� ������ Alien\n>> [3] ������ ������ X-Flow\n>> [4] ������ ������ Alien\
	               \n>> [5] ������� X-Flow \n>> [6] ������� Alien \n>> [7] ������� ���� X-Flow \n>> [8] ������� ���� Alien\n>> [9] ��������������� X-Flow\n>> [10] ��������������� Alien\n>> [11] ������ X-flow\n>> [12] ������ Alien", ">>", "X");
			}

			if(listitem == 1)//alien front
			{
    			new vehicleid = GetPlayerVehicleID(playerid);
				new cartype = GetVehicleModel(vehicleid);

				if(cartype == 562)AddVehicleComponent(vehicleid,1171);
				if(cartype == 560)AddVehicleComponent(vehicleid,1169);
				if(cartype == 565)AddVehicleComponent(vehicleid,1153);
				if(cartype == 559)AddVehicleComponent(vehicleid,1160);
				if(cartype == 561)AddVehicleComponent(vehicleid,1155);
				if(cartype == 558)AddVehicleComponent(vehicleid,1166);

				PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
				ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ Wheel Arch Angels", ">> [1] �������� ������ X-flow\n>> [2] �������� ������ Alien\n>> [3] ������ ������ X-Flow\n>> [4] ������ ������ Alien\
	               \n>> [5] ������� X-Flow \n>> [6] ������� Alien \n>> [7] ������� ���� X-Flow \n>> [8] ������� ���� Alien\n>> [9] ��������������� X-Flow\n>> [10] ��������������� Alien\n>> [11] ������ X-flow\n>> [12] ������ Alien", ">>", "X");
            }

			if(listitem == 2)//x rear
			{
    			new vehicleid = GetPlayerVehicleID(playerid);
				new cartype = GetVehicleModel(vehicleid);

				if(cartype == 562)AddVehicleComponent(vehicleid,1148);
				if(cartype == 560)AddVehicleComponent(vehicleid,1140);
				if(cartype == 565)AddVehicleComponent(vehicleid,1151);
				if(cartype == 559)AddVehicleComponent(vehicleid,1161);
				if(cartype == 561)AddVehicleComponent(vehicleid,1156);
				if(cartype == 558)AddVehicleComponent(vehicleid,1167);

				PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
				ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ Wheel Arch Angels", ">> [1] �������� ������ X-flow\n>> [2] �������� ������ Alien\n>> [3] ������ ������ X-Flow\n>> [4] ������ ������ Alien\
				\n>> [5] ������� X-Flow \n>> [6] ������� Alien \n>> [7] ������� ���� X-Flow \n>> [8] ������� ���� Alien\n>> [9] ��������������� X-Flow\n>> [10] ��������������� Alien\n>> [11] ������ X-flow\n>> [12] ������ Alien", ">>", "X");
			}

			if(listitem == 3)//alien rear
			{
    			new vehicleid = GetPlayerVehicleID(playerid);
				new cartype = GetVehicleModel(vehicleid);

				if(cartype == 562)AddVehicleComponent(vehicleid,1149);
				if(cartype == 560)AddVehicleComponent(vehicleid,1141);
				if(cartype == 565)AddVehicleComponent(vehicleid,1150);
				if(cartype == 559)AddVehicleComponent(vehicleid,1159);
				if(cartype == 561)AddVehicleComponent(vehicleid,1154);
				if(cartype == 558)AddVehicleComponent(vehicleid,1168);

				PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
				ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ Wheel Arch Angels", ">> [1] �������� ������ X-flow\n>> [2] �������� ������ Alien\n>> [3] ������ ������ X-Flow\n>> [4] ������ ������ Alien\
				\n>> [5] ������� X-Flow \n>> [6] ������� Alien \n>> [7] ������� ���� X-Flow \n>> [8] ������� ���� Alien\n>> [9] ��������������� X-Flow\n>> [10] ��������������� Alien\n>> [11] ������ X-flow\n>> [12] ������ Alien", ">>", "X");
			}

			if(listitem == 4)//x spoiler
			{
    			new vehicleid = GetPlayerVehicleID(playerid);
				new cartype = GetVehicleModel(vehicleid);

				if(cartype == 562)AddVehicleComponent(vehicleid,1146);
				if(cartype == 560)AddVehicleComponent(vehicleid,1139);
				if(cartype == 565)AddVehicleComponent(vehicleid,1050);
				if(cartype == 559)AddVehicleComponent(vehicleid,1158);
				if(cartype == 561)AddVehicleComponent(vehicleid,1160);
				if(cartype == 558)AddVehicleComponent(vehicleid,1163);

				PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
				ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ Wheel Arch Angels", ">> [1] �������� ������ X-flow\n>> [2] �������� ������ Alien\n>> [3] ������ ������ X-Flow\n>> [4] ������ ������ Alien\
				\n>> [5] ������� X-Flow \n>> [6] ������� Alien \n>> [7] ������� ���� X-Flow \n>> [8] ������� ���� Alien\n>> [9] ��������������� X-Flow\n>> [10] ��������������� Alien\n>> [11] ������ X-flow\n>> [12] ������ Alien", ">>", "X");
			}
			if(listitem == 5)//alien spoiler
			{
    			new vehicleid = GetPlayerVehicleID(playerid);
				new cartype = GetVehicleModel(vehicleid);

				if(cartype == 562)AddVehicleComponent(vehicleid,1147);
				if(cartype == 560)AddVehicleComponent(vehicleid,1138);
				if(cartype == 565)AddVehicleComponent(vehicleid,1049);
				if(cartype == 559)AddVehicleComponent(vehicleid,1162);
				if(cartype == 561)AddVehicleComponent(vehicleid,1058);
				if(cartype == 558)AddVehicleComponent(vehicleid,1164);

				PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
				ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ Wheel Arch Angels", ">> [1] �������� ������ X-flow\n>> [2] �������� ������ Alien\n>> [3] ������ ������ X-Flow\n>> [4] ������ ������ Alien\
				\n>> [5] ������� X-Flow \n>> [6] ������� Alien \n>> [7] ������� ���� X-Flow \n>> [8] ������� ���� Alien\n>> [9] ��������������� X-Flow\n>> [10] ��������������� Alien\n>> [11] ������ X-flow\n>> [12] ������ Alien", ">>", "X");
			}
			if(listitem == 6)//x side
			{
    			new vehicleid = GetPlayerVehicleID(playerid);
				new cartype = GetVehicleModel(vehicleid);

				if(cartype == 562)
				{
					AddVehicleComponent(vehicleid,1041);
					AddVehicleComponent(vehicleid,1039);
				}
				if(cartype == 560)
				{
					AddVehicleComponent(vehicleid,1031);
					AddVehicleComponent(vehicleid,1030);
				}
				if(cartype == 565)
				{
					AddVehicleComponent(vehicleid,1052);
					AddVehicleComponent(vehicleid,1048);
				}
				if(cartype == 559)
				{
					AddVehicleComponent(vehicleid,1070);
					AddVehicleComponent(vehicleid,1072);
				}
				if(cartype == 561)
				{
					AddVehicleComponent(vehicleid,1057);
					AddVehicleComponent(vehicleid,1063);
				}
				if(cartype == 558)
				{
					AddVehicleComponent(vehicleid,1093);
                	AddVehicleComponent(vehicleid,1095);
				}

				PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
				ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ Wheel Arch Angels", ">> [1] �������� ������ X-flow\n>> [2] �������� ������ Alien\n>> [3] ������ ������ X-Flow\n>> [4] ������ ������ Alien\
				\n>> [5] ������� X-Flow \n>> [6] ������� Alien \n>> [7] ������� ���� X-Flow \n>> [8] ������� ���� Alien\n>> [9] ��������������� X-Flow\n>> [10] ��������������� Alien\n>> [11] ������ X-flow\n>> [12] ������ Alien", ">>", "X");
			}

			if(listitem == 7)//alien side
			{
    			new vehicleid = GetPlayerVehicleID(playerid);
				new cartype = GetVehicleModel(vehicleid);

				if(cartype == 562)
				{
					AddVehicleComponent(vehicleid,1036);
					AddVehicleComponent(vehicleid,1040);
				}
				if(cartype == 560)
				{
					AddVehicleComponent(vehicleid,1026);
					AddVehicleComponent(vehicleid,1027);
				}
				if(cartype == 565)
				{
					AddVehicleComponent(vehicleid,1051);
					AddVehicleComponent(vehicleid,1047);
				}
				if(cartype == 559)
				{
					AddVehicleComponent(vehicleid,1069);
					AddVehicleComponent(vehicleid,1071);
				}
				if(cartype == 561)
				{
					AddVehicleComponent(vehicleid,1056);
					AddVehicleComponent(vehicleid,1062);
				}
				if(cartype == 558)
				{
					AddVehicleComponent(vehicleid,1090);
                	AddVehicleComponent(vehicleid,1094);
				}

				PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
				ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ Wheel Arch Angels", ">> [1] �������� ������ X-flow\n>> [2] �������� ������ Alien\n>> [3] ������ ������ X-Flow\n>> [4] ������ ������ Alien\
				\n>> [5] ������� X-Flow \n>> [6] ������� Alien \n>> [7] ������� ���� X-Flow \n>> [8] ������� ���� Alien\n>> [9] ��������������� X-Flow\n>> [10] ��������������� Alien\n>> [11] ������ X-flow\n>> [12] ������ Alien", ">>", "X");
			}

			if(listitem == 8)//x roof
			{
    			new vehicleid = GetPlayerVehicleID(playerid);
				new cartype = GetVehicleModel(vehicleid);

				if(cartype == 562)AddVehicleComponent(vehicleid,1035);
				if(cartype == 560)AddVehicleComponent(vehicleid,1033);
				if(cartype == 565)AddVehicleComponent(vehicleid,1052);
				if(cartype == 559)AddVehicleComponent(vehicleid,1068);
				if(cartype == 561)AddVehicleComponent(vehicleid,1061);
				if(cartype == 558)AddVehicleComponent(vehicleid,1091);

            	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
				ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ Wheel Arch Angels", ">> [1] �������� ������ X-flow\n>> [2] �������� ������ Alien\n>> [3] ������ ������ X-Flow\n>> [4] ������ ������ Alien\
				\n>> [5] ������� X-Flow \n>> [6] ������� Alien \n>> [7] ������� ���� X-Flow \n>> [8] ������� ���� Alien\n>> [9] ��������������� X-Flow\n>> [10] ��������������� Alien\n>> [11] ������ X-flow\n>> [12] ������ Alien", ">>", "X");
			}

			if(listitem == 9)//alien roof
			{
    			new vehicleid = GetPlayerVehicleID(playerid);
				new cartype = GetVehicleModel(vehicleid);

				if(cartype == 562)AddVehicleComponent(vehicleid,1038);
				if(cartype == 560)AddVehicleComponent(vehicleid,1032);
				if(cartype == 565)AddVehicleComponent(vehicleid,1054);
				if(cartype == 559)AddVehicleComponent(vehicleid,1067);
				if(cartype == 561)AddVehicleComponent(vehicleid,1055);
				if(cartype == 558)AddVehicleComponent(vehicleid,1088);

	            PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
				ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ Wheel Arch Angels", ">> [1] �������� ������ X-flow\n>> [2] �������� ������ Alien\n>> [3] ������ ������ X-Flow\n>> [4] ������ ������ Alien\
				\n>> [5] ������� X-Flow \n>> [6] ������� Alien \n>> [7] ������� ���� X-Flow \n>> [8] ������� ���� Alien\n>> [9] ��������������� X-Flow\n>> [10] ��������������� Alien\n>> [11] ������ X-flow\n>> [12] ������ Alien", ">>", "X");
			}
			if(listitem == 10)//x echaust
			{
    			new vehicleid = GetPlayerVehicleID(playerid);
				new cartype = GetVehicleModel(vehicleid);

				if(cartype == 562)AddVehicleComponent(vehicleid,1037);
				if(cartype == 560)AddVehicleComponent(vehicleid,1029);
				if(cartype == 565)AddVehicleComponent(vehicleid,1045);
				if(cartype == 559)AddVehicleComponent(vehicleid,1066);
				if(cartype == 561)AddVehicleComponent(vehicleid,1059);
				if(cartype == 558)AddVehicleComponent(vehicleid,1089);

                PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
				ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ Wheel Arch Angels", ">> [1] �������� ������ X-flow\n>> [2] �������� ������ Alien\n>> [3] ������ ������ X-Flow\n>> [4] ������ ������ Alien\
				\n>> [5] ������� X-Flow \n>> [6] ������� Alien \n>> [7] ������� ���� X-Flow \n>> [8] ������� ���� Alien\n>> [9] ��������������� X-Flow\n>> [10] ��������������� Alien\n>> [11] ������ X-flow\n>> [12] ������ Alien", ">>", "X");
			}
            if(listitem == 11)//alien echaust
			{
    			new vehicleid = GetPlayerVehicleID(playerid);
				new cartype = GetVehicleModel(vehicleid);

				if(cartype == 562)AddVehicleComponent(vehicleid,1034);
				if(cartype == 560)AddVehicleComponent(vehicleid,1028);
				if(cartype == 565)AddVehicleComponent(vehicleid,1046);
				if(cartype == 559)AddVehicleComponent(vehicleid,1065);
                if(cartype == 561)AddVehicleComponent(vehicleid,1064);
				if(cartype == 558)AddVehicleComponent(vehicleid,1092);

                PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
				ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ Wheel Arch Angels", ">> [1] �������� ������ X-flow\n>> [2] �������� ������ Alien\n>> [3] ������ ������ X-Flow\n>> [4] ������ ������ Alien\
				\n>> [5] ������� X-Flow \n>> [6] ������� Alien \n>> [7] ������� ���� X-Flow \n>> [8] ������� ���� Alien\n>> [9] ��������������� X-Flow\n>> [10] ��������������� Alien\n>> [11] ������ X-flow\n>> [12] ������ Alien", ">>", "X");
			}
 		}
		else ShowPlayerDialog(playerid, 4, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������ ����", ">> [1] �����\n>> [2] ����������\n>> [3] �������� ������\n>> [4] ����\n>> [5] ������\n>> [6] ����\n>> [7] ����� ������\n>> [8] ����\n>> [9] ������� ������", ">>", "X");
     }
     
//##############################################################################
    if(dialogid == 5)
	{
		if(response)
		{
			if(listitem == 0)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -325.1331,1533.0276,75.3594);
 	    else SetPlayerPos(playerid, -325.1331,1533.0276,75.3594);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ����������������� �� ���.");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
        format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� ���.",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		return 1;
			}
			if(listitem == 1)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 2323.7173,1420.4261,42.8203);
 	    else SetPlayerPos(playerid, 	2323.7173,1420.4261,42.8203);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ����������������� �� ��������.");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� ��������.",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		return 1;
			}
			if(listitem == 2)
			{
        new string[256];
        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -1563.00000000,279.60000610,8.39999962);
 	    else SetPlayerPos(playerid, -1563.00000000,279.60000610,8.39999962);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ����������������� �� �������-����.");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� �������-����.",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		return 1;
			}
			if(listitem == 3)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid),-884.28814697266, 550.00549316406, 5.3881149291992);
 	    else SetPlayerPos(playerid, -884.28814697266, 550.00549316406, 5.3881149291992);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ����������������� �� ��������.");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� ��������.",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		return 1;
			}
			if(listitem == 4)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 1241.1146,-745.0139,95.0895);
 	    else SetPlayerPos(playerid, 1241.1146,-745.0139,95.0895);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ����������������� �� �������.");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� �������.",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		return 1;
			}
			if(listitem == 5)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 3225.30004883,119.86599731,8.52700043);
 	    else SetPlayerPos(playerid,3225.30004883,119.86599731,8.52700043);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ����������������� �� ���������-1.");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� ���������-1.",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		return 1;
			}
			if(listitem == 6)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -3020.82592773,1789.21960449,3.14969826);
 	    else SetPlayerPos(playerid, -3020.82592773,1789.21960449,3.14969826);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ����������������� �� ���������-2.");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� ���������-2.",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		return 1;
			}
			if(listitem == 7)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 3093.47802734,-656.22399902,7.33599997);
 	    else SetPlayerPos(playerid,3093.47802734,-656.22399902,7.33599997);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ����������������� �� ����-1.");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� ����� ����-1.",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		return 1;
			}
			if(listitem == 8)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 1636.8478,-1159.7775,23.5685);
		else SetPlayerPos(playerid, 1636.8478,-1159.7775,23.5685);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ����������������� �� ��������.");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� ����� ��������.",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		return 1;
			}
			if(listitem == 9)
			{
        new string[256];
	   	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 3097.03906250,901.50500488,2.35999990);
	 	else SetPlayerPos(playerid,3097.03906250,901.50500488,2.35999990);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ����������������� �� ����-2.");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� ����-2.",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
			}
         }
      }
//##############################################################################
    if(dialogid == 7)
	{
		if(response)
		{
			if(listitem == 0)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -2006.37304688,-2847.64208984,3.23000002);
 	    else SetPlayerPos(playerid, -2006.37304688,-2847.64208984,3.23000002);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ����������������� �� �����.");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
        format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� �����.",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		return 1;
			}
			if(listitem == 1)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 2857.82397461,-1961.31994629,10.60000038);
 	    else SetPlayerPos(playerid, 2857.82397461,-1961.31994629,10.60000038);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ����������������� �� ����.");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� ����.",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		return 1;
			}
			if(listitem == 2)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -1667.1711,536.0791,38.2471);
	 	else SetPlayerPos(playerid, -1667.1711,536.0791,38.2471);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ����������������� �� 2-�����.");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� 2-�����.",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
        return 1;
			}
			if(listitem == 3)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -2143.2683,1038.7053,79.8516);
 	    else SetPlayerPos(playerid, -2143.2683,1038.7053,79.8516);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} �� ����������������� �� ������.");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� ������.",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		return 1;
			}
			if(listitem == 4)
			{

		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -325.1331,1533.0276,75.3594);
 	    else SetPlayerPos(playerid, -325.1331,1533.0276,75.3594);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} � ����������.");

		return 1;
			}
			if(listitem == 5)
			{

		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -325.1331,1533.0276,75.3594);
 	    else SetPlayerPos(playerid, -325.1331,1533.0276,75.3594);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} � ����������.");

			}
         }
      }

    if(dialogid == 8)
	{
		if(response)
		{
			if(listitem == 0)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 1554.17065440,-1320.08581553,16.93629466);
 	    else SetPlayerPos(playerid, 1554.17065440,-1320.08581553,16.93629466);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} ������ 1");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
        format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� ������ 1",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		return 1;
			}
			if(listitem == 1)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 1550.72717285,-1395.86950684,14.02088451);
 	    else SetPlayerPos(playerid, 1550.72717285,-1395.86950684,14.02088451);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} ������ 2");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� ������ 2",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		return 1;
			}
			if(listitem == 2)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -1977.47485352,567.19702148,35.02187347);
	 	else SetPlayerPos(playerid, -1977.47485352,567.19702148,35.02187347);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} ������ 3");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� ������ 3",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
        return 1;
			}
			if(listitem == 3)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -1636.36340332,1163.93774414,23.56129456);
 	    else SetPlayerPos(playerid, -1636.36340332,1163.93774414,23.56129456);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} ������ 4");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� ������ 4",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		return 1;
			}
			if(listitem == 4)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -2690.73168945,462.03167725,4.92416191);
 	    else SetPlayerPos(playerid, -2690.73168945,462.03167725,4.92416191);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} ������ 5");
        new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� ������ 5",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		}
     }
  }

    if(dialogid == 10)
	{
		if(response)
		{
			if(listitem == 0)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 2499.62695312,-1684.33398438,13.06900024);
 	    else SetPlayerPos(playerid, 2499.62695312,-1684.33398438,13.06900024);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} Gruv-Street");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
        format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� Gruv-Street",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		return 1;
			}
			if(listitem == 1)
			{
		new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -1497.22998047,920.26800537,6.84899998);
	 	else SetPlayerPos(playerid, -1497.22998047,920.26800537,6.84899998);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} ���������");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� ���������",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		return 1;
			}
			if(listitem == 2)
			{
		new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 2129.78100586,1143.60498047,13.22099972);
 	    else SetPlayerPos(playerid, 2129.78100586,1143.60498047,13.22099972);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} Mafia");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� Mafia",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
			}
        }
     }
     
    if(dialogid == 999)
	{
		if(response)
		{
			if(listitem == 0)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -2119.9621582031,1092.798828125,96.9453125);
 	    else SetPlayerPos(playerid, -2119.9621582031,1092.798828125,96.9453125);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} BMX 1");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� BMX 1",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
		return 1;
			}
			if(listitem == 1)
			{
        new string[256];
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -2339.7778320313,1221.6627197266,50.578125);
	 	else SetPlayerPos(playerid, -2339.7778320313,1221.6627197266,50.578125);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0); // ��������� ���� �� �����
		SendClientMessage(playerid, 0x21DD00FF,"{0077FF}Blodhamer Drift :{FFFF00} BMX 2");
		new pname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} ����� %s ���������������� �� BMX 2",pname,playerid);
		SendClientMessageToAll(0x21DD00FF,string);
			}
        }
     }
     
    if(dialogid == 130)//??
	{
		if(response)
		{
          if(listitem == 0)
			{
                new string[256];
                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 561.35241699,826.32397461,-23.00855446);
			 	else SetPlayerPos(playerid, 561.35241699,826.32397461,-23.00855446);
				SendClientMessage(playerid, 0xFF0000AA,"[��]: �� 1");
                GivePlayerWeapon(playerid, 30, 50000);
			    new pname[MAX_PLAYER_NAME];
                GetPlayerName(playerid, pname, sizeof(pname));
                format(string, sizeof(string), "%s {FFFF00}�������(�) �� 1 ", pname);
                SendClientMessageToAll(COLOR_ORANGE, string);
    }
          if(listitem == 1)
    {
                new string[256];
                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 1129.0205,-1454.4484,15.7969);
			 	else SetPlayerPos(playerid, 1129.0205,-1454.4484,15.7969);
				SendClientMessage(playerid, 0xFF0000AA,"[��]: �� 2");
                GivePlayerWeapon(playerid, 26, 50000);
 			    new pname[MAX_PLAYER_NAME];
                GetPlayerName(playerid, pname, sizeof(pname));
                format(string, sizeof(string), "%s {FFFF00}�������(�) �� 2 ", pname);
                SendClientMessageToAll(COLOR_ORANGE, string);
    }
          if(listitem == 2)
    {
                new string[256];
                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 2508.3787,2786.6370,10.8203);
			 	else SetPlayerPos(playerid, 2508.3787,2786.6370,10.8203);
				SendClientMessage(playerid, 0xFF0000AA,"[��]: �� 3");
                GivePlayerWeapon(playerid, 29, 50000);
       			new pname[MAX_PLAYER_NAME];
                GetPlayerName(playerid, pname, sizeof(pname));
                format(string, sizeof(string), "%s {FFFF00}�������(�) �� 3 ", pname);
                SendClientMessageToAll(COLOR_ORANGE, string);
    }
          if(listitem == 3)
    {
                new string[256];
                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 1447.1121,-1063.8628,213.3828);
			 	else SetPlayerPos(playerid, 1447.1121,-1063.8628,213.3828);
				SendClientMessage(playerid, 0xFF0000AA,"[��]: �� 4");
                GivePlayerWeapon(playerid, 32, 50000);
 			    new pname[MAX_PLAYER_NAME];
                GetPlayerName(playerid, pname, sizeof(pname));
                format(string, sizeof(string), "%s {FFFF00}�������(�) �� 4 ", pname);
                SendClientMessageToAll(COLOR_ORANGE, string);
    }
          if(listitem == 4)
    {
                new string[256];
                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -926.4914,-498.8946,25.9609);
			 	else SetPlayerPos(playerid, -926.4914,-498.8946,25.9609);
				SendClientMessage(playerid, 0xFF0000AA,"[��]: �� 5");
                GivePlayerWeapon(playerid, 27, 50000);
			    new pname[MAX_PLAYER_NAME];
                GetPlayerName(playerid, pname, sizeof(pname));
                format(string, sizeof(string), "%s {FFFF00}�������(�) �� 5 ", pname);
                SendClientMessageToAll(COLOR_ORANGE, string);
    }
          if(listitem == 5)
    {
                new string[256];
                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -2129.3096,-444.2732,35.5344);
			 	else SetPlayerPos(playerid, -2129.3096,-444.2732,35.5344);
				SendClientMessage(playerid, 0xFF0000AA,"[��]: �� 6");
                GivePlayerWeapon(playerid, 31, 50000);
			    new pname[MAX_PLAYER_NAME];
                GetPlayerName(playerid, pname, sizeof(pname));
                format(string, sizeof(string), "%s {FFFF00}�������(�) �� 6 ", pname);
                SendClientMessageToAll(COLOR_ORANGE, string);
    }
          if(listitem == 6)
    {
                new string[256];
	            if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 1315.9521,-987.8052,148.6437);
			 	else SetPlayerPos(playerid, 1315.9521,-987.8052,148.6437);
				SendClientMessage(playerid, 0xFF0000AA,"[��]: �� 7");
                GivePlayerWeapon(playerid, 28, 50000);
			    new pname[MAX_PLAYER_NAME];
                GetPlayerName(playerid, pname, sizeof(pname));
                format(string, sizeof(string), "%s {FFFF00}�������(�) �� 7 ", pname);
                SendClientMessageToAll(COLOR_ORANGE, string);
    }
          if(listitem == 7)
    {
                new string[256];
                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 214.5838,1875.3218,17.6406);
			 	else SetPlayerPos(playerid, 214.5838,1875.3218,17.6406);
				SendClientMessage(playerid, 0xFF0000AA,"[��]: �� 8");
                GivePlayerWeapon(playerid, 30, 50000);
                new pname[MAX_PLAYER_NAME];
                GetPlayerName(playerid, pname, sizeof(pname));
                format(string, sizeof(string), "%s {FFFF00}�������(�) �� 8 ", pname);
                SendClientMessageToAll(COLOR_ORANGE, string);
    }
          if(listitem == 8)
    {
                new string[256];
                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 2275.7498,1072.6093,10.8203);
			 	else SetPlayerPos(playerid, 2275.7498,1072.6093,10.8203);
				SendClientMessage(playerid, 0xFF0000AA,"[��]: �� 9");
                GivePlayerWeapon(playerid, 33, 50000);
			    new pname[MAX_PLAYER_NAME];
                GetPlayerName(playerid, pname, sizeof(pname));
                format(string, sizeof(string), "%s {FFFF00}�������(�) �� 9 ", pname);
                SendClientMessageToAll(COLOR_ORANGE, string);
    }
          if(listitem == 9)
    {
                new string[256];
                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 2257.3013,1086.0162,33.5284);
			 	else SetPlayerPos(playerid, 2257.3013,1086.0162,33.5284);
				SendClientMessage(playerid, 0xFF0000AA,"[��]: �� 10");
                GivePlayerWeapon(playerid, 26, 50000);
       			new pname[MAX_PLAYER_NAME];
                GetPlayerName(playerid, pname, sizeof(pname));
                format(string, sizeof(string), "%s {FFFF00}�������(�) �� 10 ", pname);
                SendClientMessageToAll(COLOR_ORANGE, string);
    }
          if(listitem == 10)
    {
                new string[256];
                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -1465.3469,385.0039,30.0859);
			 	else SetPlayerPos(playerid, -1465.3469,385.0039,30.0859);
				SendClientMessage(playerid, 0xFF0000AA,"[��]: �� 11");
                GivePlayerWeapon(playerid, 31, 50000);
                new pname[MAX_PLAYER_NAME];
                GetPlayerName(playerid, pname, sizeof(pname));
                format(string, sizeof(string), "%s {FFFF00}�������(�) �� 11 ", pname);
                SendClientMessageToAll(COLOR_ORANGE, string);
    }
          if(listitem == 11)
    {
                new string[256];
                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -1600.6583,146.1976,-11.1581);
			 	else SetPlayerPos(playerid, -1600.6583,146.1976,-11.1581);
				SendClientMessage(playerid, 0xFF0000AA,"[��]: �� 12");
                GivePlayerWeapon(playerid, 25, 50000);
                new pname[MAX_PLAYER_NAME];
                GetPlayerName(playerid, pname, sizeof(pname));
                format(string, sizeof(string), "%s {FFFF00}�������(�) �� 12 ", pname);
                SendClientMessageToAll(COLOR_ORANGE, string);

           }
        }
      }
//##############################################################################
 
	if(dialogid == 777) // ���� ��������
	{
  		if(response)
  		{
			if(listitem == 0)
   			{
				ShowPlayerDialog(playerid, 123, DIALOG_STYLE_LIST, "������� � C�������", "����\n��������\n����\n������", "OK", "�����");
			}
            if(listitem == 1)
   			{
				ShowPlayerDialog(playerid, 321, DIALOG_STYLE_LIST, "���������", "����� - 1\n����� - 2\n����� - 3\n����� - 4", "OK", "�����");
			}
            if(listitem == 2)
   			{
			   SetPlayerSpecialAction (playerid, SPECIAL_ACTION_USECELLPHONE);
               PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
            if(listitem == 3)
   			{
	      ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // ��������� �����
		  return 1;
			}
            if(listitem == 4)
   			{
          ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0); // ��������
		  return 1;
			}
            if(listitem == 5)
   			{
          ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 0, 0, 0, 0, 0); // �������� ����
			}
            if(listitem == 6)
   			{
          ApplyAnimation(playerid, "PAULNMAC", "wank_loop", 4.0, 0, 0, 0, 0, 0); // �������
		  return 1;
			}
            if(listitem == 7)
   			{
          ApplyAnimation(playerid, "PAULNMAC", "wank_out", 4.0, 0, 0, 0, 0, 0); // �������
		  return 1;
			}
            if(listitem == 8)
   			{
          ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.0, 0, 0, 0, 0, 0); // �������
		  return 1;
			}
            if(listitem == 9)
   			{
          ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 0, 0, 0, 0); // ��������� ����
		  return 1;
			}
            if(listitem == 10)
   			{
          ApplyAnimation(playerid,"BEACH", "bather", 4.0, 0, 0, 0, 0, 0); // ������
		  return 1;
			}
            if(listitem == 11)
   			{
          ApplyAnimation(playerid, "ped", "cower", 3.0, 0, 0, 0, 0, 0); // ���������� ������
			}
            if(listitem == 12)
   			{
	      ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0); // �������
		  return 1;
			}
            if(listitem == 13)
   			{
	      ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.00, 0, 0, 0, 0, 0); // ��������
		  return 1;
			}
            if(listitem == 14)
   			{
	      ApplyAnimation(playerid, "KISSING", "BD_GF_Wave", 3.0, 0, 0, 0, 0, 0); // �������������
		  return 1;
			}
            if(listitem == 15)
   			{
          ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 0, 0, 0, 0, 0); // ��������
		  return 1;
			}
            if(listitem == 16)
   			{
          ApplyAnimation(playerid, "PAULNMAC", "Piss_in", 3.0, 0, 0, 0, 0, 0); // ������
		  return 1;
			}
            if(listitem == 17)
   			{
          ApplyAnimation(playerid,"SMOKING", "M_smklean_loop", 4.0, 0, 0, 0, 0, 0); // ������ � �����
		  return 1;
			}
            if(listitem == 18)
   			{
          ApplyAnimation(playerid,"BEACH", "ParkSit_M_loop", 4.0, 0, 0, 0, 0, 0); // ������ �� �����
		  return 1;
			}
            if(listitem == 19)
   			{
	      ApplyAnimation( playerid,"ped", "fucku", 4.1, 0, 1, 1, 1, 1 ); // �������� ���
		  return 1;
			}
            if(listitem == 20)
   			{
         ApplyAnimation(playerid,"PED","IDLE_CHAT",4.1,0,1,1,1,1); //��������
         return 1;
			}
            if(listitem == 21)
   			{
         SetPlayerSpecialAction (playerid, SPECIAL_ACTION_HANDSUP); // ������� ����
         return 1;
			}
            if(listitem == 22)
   			{
			SetPlayerSpecialAction (playerid, SPECIAL_ACTION_NONE);
 			SetPlayerDrunkLevel (playerid, 0);
    		SetPlayerSpecialAction (playerid, 13 - SPECIAL_ACTION_STOPUSECELLPHONE);
    		SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ffffff} �� ��������� �������� ����� ��������.");
          	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
            else ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������� ����", ">> [1] ������ \n>> [2] ��������� \n>> [3] �������� \n>> [4] ���������� \n>> [5] ���������� ���������� \n>> [6] {FF00FF}���������� \n>> [7] ������ \n>> [8] {FF0000}����� \n>> [9] ���������� ���� \n>> [10] ������ \n>> [11] ��������� \n>> [12] ����������", ">>", "X");
         }
	  }
	//##############################################################################
    if(dialogid == 123)//������� � ��������
	{
		if(response)
		{
			if(listitem == 0)
			{
				SetPlayerSpecialAction (playerid, SPECIAL_ACTION_DRINK_BEER );
			}
			if(listitem == 1)
			{
				SetPlayerSpecialAction (playerid, SPECIAL_ACTION_SMOKE_CIGGY );
			}
			if(listitem == 2)
			{
			    SetPlayerSpecialAction (playerid, SPECIAL_ACTION_DRINK_WINE );
			}
			if(listitem == 3)
			{
				SetPlayerSpecialAction (playerid, SPECIAL_ACTION_DRINK_SPRUNK );
			}
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
   		}
		else ShowPlayerDialog(playerid, 777, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{FF0000}��������", "������� � C�������\n���������\n�������\n��������� �����\n��������\n�������� ����\n�������\n�������\n�������\n��������� ����\n������\n���������� ������\n�������\n��������\n�������������\n��������\n������\n������ � �����\n������ �� �����\n�������� ���\n��������\n������� ����\n���������� ��������", "OK", "�����");
     }
//##############################################################################
    if(dialogid == 321)//anim dance
    {
		if(response)
  		{
  			if(listitem == 0)
			{
				SetPlayerSpecialAction (playerid, SPECIAL_ACTION_DANCE1);
		    }
            if(listitem == 1)
			{
		        SetPlayerSpecialAction (playerid, SPECIAL_ACTION_DANCE2);
		    }
            if(listitem == 2)
			{
			    SetPlayerSpecialAction (playerid, SPECIAL_ACTION_DANCE3);
			}
            if(listitem == 3)
			{
		       SetPlayerSpecialAction (playerid, SPECIAL_ACTION_DANCE4);
		    }
      		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		}
		else ShowPlayerDialog(playerid, 777, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{FF0000}��������", "������� � C�������\n���������\n�������\n��������� �����\n��������\n�������� ����\n�������\n�������\n�������\n��������� ����\n������\n���������� ������\n�������\n��������\n�������������\n��������\n������\n������ � �����\n������ �� �����\n�������� ���\n��������\n������� ����\n���������� ��������", "OK", "�����");
     }
//##############################################################################
    if(dialogid == 456)//������
 	{
		if(response)
  		{
  			if(listitem == 0)
			{
    ApplyAnimation(playerid,"SUNBATHE","PARKSIT_M_IN",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"SUNBATHE","PARKSIT_M_IN",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"SUNBATHE","PARKSIT_M_IN",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"SUNBATHE","PARKSIT_M_IN",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"SUNBATHE","PARKSIT_M_IN",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"SUNBATHE","PARKSIT_M_IN",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"SUNBATHE","PARKSIT_M_IN",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"SUNBATHE","PARKSIT_M_IN",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"SUNBATHE","PARKSIT_M_IN",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"SUNBATHE","PARKSIT_M_IN",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"SUNBATHE","PARKSIT_M_IN",4.1,0,1,1,1,1);
		    }
            if(listitem == 1)
			{
    ApplyAnimation(playerid,"BEACH","bather",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","bather",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","bather",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","bather",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","bather",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","bather",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","bather",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","bather",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","bather",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","bather",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","bather",4.1,0,1,1,1,1);
		    }
            if(listitem == 2)
			{
    ApplyAnimation(playerid,"BEACH","ParkSit_W_loop",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","ParkSit_W_loop",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","ParkSit_W_loop",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","ParkSit_W_loop",4.1,0,1,1,1,1);
	ApplyAnimation(playerid,"BEACH","ParkSit_W_loop",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","ParkSit_W_loop",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","ParkSit_W_loop",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","ParkSit_W_loop",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","ParkSit_W_loop",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","ParkSit_W_loop",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","ParkSit_W_loop",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"BEACH","ParkSit_W_loop",4.1,0,1,1,1,1);
			}
            if(listitem == 3)
			{
    ApplyAnimation(playerid,"ped","fucku",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"ped","fucku",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"ped","fucku",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"ped","fucku",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"ped","fucku",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"ped","fucku",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"ped","fucku",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"ped","fucku",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"ped","fucku",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"ped","fucku",4.1,0,1,1,1,1);
    ApplyAnimation(playerid,"ped","fucku",4.1,0,1,1,1,1);
	ApplyAnimation(playerid,"ped","fucku",4.1,0,1,1,1,1);
        			}
		    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
      	}
      	else ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{FF0000}��������", "������� � C������� \n����� \n������ \n{FF0000}���������� ��������", "OK", "�����");
	}

	if(dialogid == 888)//skins
	{
		if(response)
		{
			if(strval(inputtext) >= -0 && strval(inputtext) <= 300)
			{
	  			SetPlayerSkin(playerid,strval(inputtext));
	  			PlayerPlaySound(playerid,1150,0.0,0.0,0.0);
			}
		}
		else ShowPlayerDialog(playerid, 888, DIALOG_STYLE_INPUT, "{0077FF}Blodhamer Drift :����� �����", "������� ID", "OK", "�����");
 }
	//##############################################################################
	if(dialogid == 5) // ��� �����
	{
		if(response)
		{
			if(listitem == 2)
			{
			}
		}
		else ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "{0077FF}Blodhamer Drift :{ffffff} ������� ����", ">> [1] ������ \n>> [2] ��������� \n>> [3] �������� \n>> [4] ���������� \n>> [5] ���������� ���������� \n>> [6] {FF00FF}���������� \n>> [7] ������ \n>> [8] {FF0000}����� \n>> [9] ���������� ���� \n>> [10] ������ \n>> [11] ��������� \n>> [12] ����������", ">>", "X");
	}

	return 0;
}

public SaveAccounts()
{
    for(new f; f < GetMaxPlayers(); f++)
    {
        if(!IsPlayerConnected(f))continue;
        SaveAccount(f);
        //UpdatePlayerPosition(f);
    }
}

stock SaveAccount(playerid)
{
    new PlayerName[MAX_PLAYER_NAME], account[128];
    GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
    format(account,sizeof(account), "Users/%s.ini", PlayerName);
    new iniFile = ini_openFile(account);
    ini_setInteger(iniFile, "Money", PlayerInfo[playerid][pMoney]);
    ini_setInteger(iniFile, "Skin", PlayerInfo[playerid][pSkin]);
    ini_setInteger(iniFile, "VIP", PlayerInfo[playerid][pVIP]);
	ini_setInteger(iniFile, "Admin", PlayerInfo[playerid][pAdmin]);
	ini_setInteger(iniFile, "MenuL", PlayerInfo[playerid][pMenuL]);
    ini_setInteger(iniFile, "Score", PlayerInfo[playerid][pScore]);
    ini_setInteger(iniFile, "Ban", PlayerInfo[playerid][pBanned]);
    ini_setInteger(iniFile, "Warn", PlayerInfo[playerid][pWarns]);
    ini_setInteger(iniFile, "Muted", PlayerInfo[playerid][pMuted]);
    ini_setInteger(iniFile, "MuteTime", PlayerInfo[playerid][pMuteTime]);
    ini_closeFile(iniFile);
    return 1;
}

public GetMoney()
{
    for(new i=0;i<GetMaxPlayers();i++)
    {
        if(IsPlayerConnected(i))
        {
			new money = GetPlayerMoney(i);
			if(PlayerInfo[i][pMoney] > money) // �������: ���� � ������ ����� �������� �������� ������ ��� �������.
	        {
		        ResetPlayerMoney(i);
    			GivePlayerMoney(i, PlayerInfo[i][pMoney]);
		    }
		    else if(PlayerInfo[i][pMoney] < money) // �������: ���� ������� ����� � ������ ������ ��� �������� ��������.
	        {
		        ResetPlayerMoney(i);
  				GivePlayerMoney(i, PlayerInfo[i][pMoney]);
		    }
		}
	}
	return ;
}

stock GiveMoney(playerid, amount)
{
    PlayerInfo[playerid][pMoney] += amount;
}

stock GetSRVMoney(playerid)
{
	return PlayerInfo[playerid][pMoney];
}

//==============================================================================
forward OtherTime(); // ��� ���������
public OtherTime() // ��� ���������
{
	new plname[MAX_PLAYER_NAME], string[128];
	GetMoney();
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pMuteTime] >=1 && PlayerInfo[i][pMuted] == 1)
		{
			PlayerInfo[i][pMuteTime] -=1;
		}
		else if(PlayerInfo[i][pMuteTime] <=0 && PlayerInfo[i][pMuted] == 1)
		{
			if(IsPlayerConnected(i))
			{
				PlayerInfo[i][pMuteTime] = 0;
				PlayerInfo[i][pMuted] = 0;
				GetPlayerName(i,plname,sizeof(plname));
				format(string,sizeof(string),"{0077FF}Blodhamer Drift :{ffffff} ������ %s ��� ������������� ������� ���.",plname);
				SendClientMessageToAll(0x21DD00FF,string);
			}
		}
	}
	return 1;
}


//==============================================================================
stock LockCar(carid) // ��� �������� ����
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			SetVehicleParamsForPlayer(carid,i,0,1);
		}
	}
}
//==============================================================================
stock UnLockCar(carid) // ��� �������� ����
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			SetVehicleParamsForPlayer(carid,i,0,0);
		}
	}
}
//==============================================================================
forward SendAdminText(color,const string[],level); // ��� ���������
public SendAdminText(color,const string[],level) // ��� ���������
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (PlayerInfo[i][pAdmin] >= level)
			{
				SendClientMessage(i, color, string);
				printf("%s", string);
			}
		}
	}
	return 1;
}
//==============================================================================
forward CountDown(num); // ��� �������
public CountDown(num) // ��� �������
{
	new str[2];
	for(new i=0;i<MAX_PLAYERS;i++)

	if (num)
	{
		format(str, sizeof(str), "%i", num);

		GameTextForAll(str, 1001, 4);
		PlayerPlaySound(i,1056,0.0,0.0,0.0);
	}
	else
	{
		GameTextForAll("~g~Go Go Go", 3000, 4);
		PlayerPlaySound(i,1057,0.0,0.0,0.0);
		Counting = false;
	}
}
//==============================================================================
dcmd_count(playerid, params[]) // ��� �������
{
	if (!strlen(params)) return SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /count [1-9] - ��������� ������.");
	if (!IsNumeric(params)) return SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /count [1-9] - ��������� ������.");
	if (strval(params) < 1) return SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} ����� �� ������ ���� ������ 1 � ������ 9.");
	if (Counting) return SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} ������ ��� ��������� ����� ����.");
	Counting = true;
	new ii = strval(params);
	do
	{
		SetTimerEx("CountDown", (strval(params) - ii) * 1000, false, "i", ii);

		ii --;
	}
	while (ii != -1);
	SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} �� ��������� ������.");
	new string[256];
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pname,sizeof(pname));
	format(string,sizeof(string),"{0077FF}Blodhamer Drift :{FFFF00} %s �������� ������.",pname,playerid);
	SendClientMessageToAll(0x21DD00FF,string);
	return 1;
}

dcmd_creategarage(playerid,params[])
{
	if(!IsPlayerAdmin(playerid)) return 0;
	if(garageCount == MAX_GARAGES) return SendClientMessage(playerid, COLOR_USAGE, "The max. amount of garages is reached. Increase the limit in the jGarage filterscript.");
	new price, type;
	if(sscanf(params,"dd",price, type)) return SendClientMessage(playerid, COLOR_USAGE, "Usage: /creategarage <price> <type>  || Use /garagetypes for a list of garage types.");
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X,Y,Z);
	format(gInfo[garageCount][Owner],24,"the State");
	gInfo[garageCount][Owned] = 0;
	gInfo[garageCount][Price] = price;
	gInfo[garageCount][Interior] = type;
	gInfo[garageCount][UID] = garageCount;
	gInfo[garageCount][PosX] = X;
	gInfo[garageCount][PosY] = Y;
	gInfo[garageCount][PosZ] = Z;
	gInfo[garageCount][Locked] = 1;
	new path[128];
	format(path,sizeof(path),"garages/%d.ini",garageCount); //Format the path with the filenumber
	dini_Create(path);
	Save_Garage(garageCount);
	UpdateGarageInfo(garageCount);
	garageCount++;
	SendClientMessage(playerid,COLOR_SUCCESS,"Garage created!");
	return 1;
}
//==============================================================================
stock oGetPlayerName(playerid) // ��� �������
{
	new pname[20];
	GetPlayerName(playerid,pname,sizeof(pname));
	return pname;
}
//==============================================================================
forward GetPlayerID (string[]); // ��� �������
public GetPlayerID(string[]) // ��� �������
{
	for(new i = 0; i <= MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			new testname[MAX_PLAYER_NAME];
			GetPlayerName(i, testname, sizeof(testname));
			if(strcmp(testname, string, true, strlen(string)) == 0)
			{
				return i;
			}
		}
	}
	return INVALID_PLAYER_ID;
}
//==============================================================================
forward IsStringAName (string[]); // ��� �������
public IsStringAName(string[]) // ��� �������
{
	for(new i = 0; i <= MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			new testname[MAX_PLAYER_NAME];
			GetPlayerName(i, testname, sizeof(testname));
			if(strcmp(testname, string, true, strlen(string)) == 0)
			{
				return 1;
			}
		}
	}
	return 0;
}
//==============================================================================
stock SendAdminMessage(color, string[]) // ��� �������
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(PlayerInfo[i][pAdmin] >= 1)
			{
				SendClientMessage(i, color, string);
			}
		}
	}
}
//==============================================================================
forward PingKick (); // ��� �����
public PingKick() // ��� �����
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		new pidName[MAX_PLAYER_NAME];
		new tmpp[256];
		new ping=GetPlayerPing(i);
		if(ping > maxping)
		{
			GetPlayerName(i,pidName, sizeof(pidName));
			format(tmpp, sizeof(tmpp), "{0077FF}Blodhamer Drift :{ff0000} ����� %s ������ �� ������� ���� {FFFF00}( ���� : %d ).",pidName,ping);
			SendClientMessageToAll(0x21DD00FF,tmpp);
			Kick(i);
		}
	}
	return 0;
}
//==============================================================================
forward PHostname(); // ������ �������� �������
public PHostname() // ������ �������� �������
{
	switch (gHostName)
	{
	case 0: SendRconCommand("hostname Blodhamer [RUS]"); //�������� 1
	case 1: SendRconCommand("hostname Blodhamer [RUS]"); //�������� 2
	}
	if (gHostName == 2)
	{
		gHostName = 0;
	}
	else
	{
		gHostName++;
	}
	return 1;
}
//==============================================================================
public OnRconLoginAttempt(ip[], password[], success) // ��������� �����
{
	if(!success) // �������� �� ��, ��� ������ ��� ������������
	{
		new YouIP[16];//������, ������� ������ ��� IP-�����
		for(new i = 0; i <= MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				GetPlayerIp(i, YouIP, sizeof(YouIP)); // ������� ��� IP � ������
				if(!strcmp(ip, YouIP, true)) // ��������� ��� IP, � ��� IP, ������� ����������� ���� Rcon-������.
				{
					new pname[MAX_PLAYER_NAME];
					new string[256];
					GetPlayerName(i,pname,sizeof(pname));
					format(string,sizeof(string),"{0077FF}Blodhamer Drift :{ff0000} ����� %s ��� ������ ��������� {FFFF00}( �������: ������� �������� RCON ������ ).",pname,i);
					SendClientMessageToAll(0x21DD00FF,string);
					SendClientMessage(i, 0x21DD00FF, "{0077FF}Blodhamer Drift :{ff0000} �� ���� ������� �� ������������ ���� Rcon-������.");
					Kick(i); // ������ ���
					return 1;
				}
			}
		}
	}
	return 1;
}
//==============================================================================
forward UpperToLower(test_text[]); // ��� ����-caps
public UpperToLower(test_text[]) {
	for (new i = 0; i < strlen(test_text); i++) {
		if (test_text[i] > 64 && test_text[i] < 91 ) // ����� A-Z
		test_text[i] += 32;
		else if (test_text[i] > 191 && test_text[i] < 224 ) // ����� �-�
		test_text[i] += 32;
		else if (test_text[i] == 168) // ����� �
		test_text[i] = 184;
	}
}
//==============================================================================
dcmd_dt(playerid, params[]) // ����������� ���
{

	new str[64],veh = GetPlayerVehicleID(playerid);
	if (!strlen(params)) return SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} /dt [���] - ����������� ���.");
	if (strval(params) < 0) return SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} ����� ������ ���� ������ ����.");
	new ii = strval(params);
	SetPlayerVirtualWorld(playerid,ii);
	SetVehicleVirtualWorld(veh, GetPlayerVirtualWorld(playerid));
	LinkVehicleToInterior(veh, GetPlayerInterior(playerid));
	format(str,64,"{0077FF}Blodhamer Drift :{FFFF00} ��� ��� ������ �� %d.",ii);
	SendClientMessage(playerid, 0x21DD00FF,str);
	if(ii!=0)return SendClientMessage(playerid, 0x00FF00AA, "{0077FF}Blodhamer Drift :{FFFF00} �� � ������ ����.");
	SendClientMessage(playerid, 0x21DD00FF, "{0077FF}Blodhamer Drift :{FFFF00} �� � ������� ����.");
	return 1;
}

stock PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
    {
	     new Float:oldposx, Float:oldposy, Float:oldposz;
	     new Float:tempposx, Float:tempposy, Float:tempposz;
	     GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	     tempposx = (oldposx -x);
	     tempposy = (oldposy -y);
	     tempposz = (oldposz -z);
	     if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))) return 1;
    }
	return 0;
}
//==============================================================================
stock CheckOnIP(string[]) // �����������
{
	new i;
	for(i = sizeof(IPAntiPorts) - 1; i >= 0; i--)
	if(strfind(string, IPAntiPorts[i], false, 0) >= 0)
	return 1;
	if((i = strfind(string, ".", false, 0)) >= 0)
	{
		new digits;
		for (++i; ; i++)
		{
			switch(string[i])
			{
			case ' ': if(digits > 0) break; else continue;
			case '0'..'9': digits++;
			default: break;
			}
		}
		if(digits >= 2) return 1;
	}
	return 0;
}

stock rName(playerid)
{
        new rname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, rname, sizeof(rname));
        return rname;
}
//==============================================================================
forward UnMutedX(playerid); // ��������
public UnMutedX(playerid) // ��������
{
	IsMessageSent[playerid] = 0;
	return true;
}
//==============================================================================
stock strrest(const string[], &index) // ��� ������
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}
	new offset = index;
	new result[128];
	while ((index < length) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
//==============================================================================
stock strtok(const string[], &index) // ��� ������
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
//=[����� �������]==============================================================
forward DriftCancellation(playerid); // ����� �������
public DriftCancellation(playerid) // ����� �������
{
	PlayerDriftCancellation[playerid] = 0;
	GiveMoney(playerid, DriftPointsNow[playerid]);
	PlayerInfo[playerid][pScore] += scores[playerid];
	SetPlayerScore(playerid, PlayerInfo[playerid][pScore]);
	DriftPointsNow[playerid] = 0;
	scores[playerid] = 0;
	TextDrawHideForPlayer(playerid, Chet[playerid]);
}
//==============================================================================
Float:ReturnPlayerAngle(playerid) // ����� �������
{
	new Float:Ang;
	if(IsPlayerInAnyVehicle(playerid))GetVehicleZAngle(GetPlayerVehicleID(playerid), Ang); else GetPlayerFacingAngle(playerid, Ang);
	return Ang;
}
//==============================================================================
Float:GetPlayerTheoreticAngle(i) // ����� �������
{
	new Float:sin;
	new Float:dis;
	new Float:angle2;
	new Float:x,Float:y,Float:z;
	new Float:tmp3;
	new Float:tmp4;
	new Float:MindAngle;

	if(IsPlayerConnected(i))
	{
		GetPlayerPos(i,x,y,z);
		dis = floatsqroot(floatpower(floatabs(floatsub(x,ppos[i][0])),2)+floatpower(floatabs(floatsub(y,ppos[i][1])),2));
		if(IsPlayerInAnyVehicle(i)){GetVehicleZAngle(GetPlayerVehicleID(i), angle2);}else{GetPlayerFacingAngle(i, angle2);}
		if(x>ppos[i][0]){tmp3=x-ppos[i][0];}else{tmp3=ppos[i][0]-x;}
		if(y>ppos[i][1]){tmp4=y-ppos[i][1];}else{tmp4=ppos[i][1]-y;}
		if(ppos[i][1]>y && ppos[i][0]>x)
		{
			sin = asin(tmp3/dis);
			MindAngle = floatsub(floatsub(floatadd(sin, 90), floatmul(sin, 2)), -90.0);
		}
		if(ppos[i][1]<y && ppos[i][0]>x)
		{
			sin = asin(tmp3/dis);
			MindAngle = floatsub(floatadd(sin, 180), 180.0);
		}
		if(ppos[i][1]<y && ppos[i][0]<x)
		{
			sin = acos(tmp4/dis);
			MindAngle = floatsub(floatadd(sin, 360), floatmul(sin, 2));
		}
		if(ppos[i][1]>y && ppos[i][0]<x)
		{
			sin = asin(tmp3/dis);
			MindAngle = floatadd(sin, 180);
		}
	}

	if(MindAngle == 0.0)
	{
		return angle2;
	}
	else
	{
		return MindAngle;
	}
}
//==============================================================================
forward Drift(); // ����� �������
public Drift() // ����� �������
{
	new Float:Angle1, Float:Angle2, Float:BySpeed, s[128];
	new Float:Z;
	new Float:X;
	new Float:Y;
	new Float:SpeedX;
	for(new g=0;g<MAX_PLAYERS;g++)
	{
		GetPlayerPos(g, X, Y, Z);
		SpeedX = floatsqroot(floatadd(floatadd(floatpower(floatabs(floatsub(X,SavedPos[ g ][ sX ])),2),floatpower(floatabs(floatsub(Y,SavedPos[ g ][ sY ])),2)),floatpower(floatabs(floatsub(Z,SavedPos[ g ][ sZ ])),2)));
		Angle1 = ReturnPlayerAngle(g);
		Angle2 = GetPlayerTheoreticAngle(g);
		BySpeed = floatmul(SpeedX, 12);
		if(IsPlayerInAnyVehicle(g) && IsCar(GetPlayerVehicleID(g)) && floatabs(floatsub(Angle1, Angle2)) > DRIFT_MINKAT && floatabs(floatsub(Angle1, Angle2)) < DRIFT_MAXKAT && BySpeed > DRIFT_SPEED)
		{
			if(PlayerDriftCancellation[g] > 0)KillTimer(PlayerDriftCancellation[g]);
			PlayerDriftCancellation[g] = 0;
			DriftPointsNow[g] += 10;
			scores[g]++;
			PlayerDriftCancellation[g] = SetTimerEx("DriftCancellation", 2000, 0, "d", g);
		}
		if(DriftPointsNow[g] > 0)
		{
			TextDrawShowForPlayer(g,Chet[g]);
			format(s, sizeof(s), "drift: ~r~%d", DriftPointsNow[g]);
			TextDrawSetString(Chet[g], s);
		}
		SavedPos[ g ][ sX ] = X;
		SavedPos[ g ][ sY ] = Y;
		SavedPos[ g ][ sZ ] = Z;
	}
}

//==============================================================================
IsCar(model) // ����� �������
{
	switch(model)
	{
	case 443:return 0;
	case 448:return 0;
	case 461:return 0;
	case 462:return 0;
	case 463:return 0;
	case 468:return 0;
	case 521:return 0;
	case 522:return 0;
	case 523:return 0;
	case 581:return 0;
	case 586:return 0;
	case 481:return 0;
	case 509:return 0;
	case 510:return 0;
	case 430:return 0;
	case 446:return 0;
	case 452:return 0;
	case 453:return 0;
	case 454:return 0;
	case 472:return 0;
	case 473:return 0;
	case 484:return 0;
	case 493:return 0;
	case 595:return 0;
	case 417:return 0;
	case 425:return 0;
	case 447:return 0;
	case 465:return 0;
	case 469:return 0;
	case 487:return 0;
	case 488:return 0;
	case 497:return 0;
	case 501:return 0;
	case 548:return 0;
	case 563:return 0;
	case 406:return 0;
	case 444:return 0;
	case 556:return 0;
	case 557:return 0;
	case 573:return 0;
	case 460:return 0;
	case 464:return 0;
	case 476:return 0;
	case 511:return 0;
	case 512:return 0;
	case 513:return 0;
	case 519:return 0;
	case 520:return 0;
	case 539:return 0;
	case 553:return 0;
	case 577:return 0;
	case 592:return 0;
	case 593:return 0;
	case 471:return 0;
	}
	return 1;
}
//==============================================================================
forward AngleUpdate(); // ����� �������
public AngleUpdate() // ����� �������
{
	for(new g=0;g<=MAX_PLAYERS;g++)
	{
		new Float:x, Float:y, Float:z;
		if(IsPlayerInAnyVehicle(g))GetVehiclePos(GetPlayerVehicleID(g), x, y, z); else GetPlayerPos(g, x, y, z);
		ppos[g][0] = x;
		ppos[g][1] = y;
		ppos[g][2] = z;
	}
}
//==============================================================================
public OnVehicleDamageStatusUpdate(vehicleid, playerid) // ����� �������
{
	if(DriftPointsNow[playerid] > 0)
	{
		DriftPointsNow[playerid] = 0;
		scores[playerid] = 0;
		TextDrawSetString(Chet[playerid], "~b~Crash");
	}
	return 1;
}

forward Timer();
public Timer()
{
    new p, vehicleid, panels, doors, lights, tires;
    for(p = 0; p < MAX_PLAYERS; p++)
    {
        if(!IsPlayerConnected(p) || IsPlayerNPC(p)) continue;
        {
            vehicleid = GetPlayerVehicleID(p);
            if(vehicleid != 0 && GetPlayerState(p) == PLAYER_STATE_DRIVER)
            {
                if(LightsOnOff[p])
                {
                    if(pLights[p] != 1 && pLights[p] != 4)
                    {
                        pLights[p] = 1;
                    }
                    else
                    {
                        if(pLights[p] == 1)
                        {
                            pLights[p] = 4;
                        }
                        else
                        {
                            pLights[p] = 1;
                        }
                    }
                    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
                    UpdateVehicleDamageStatus(vehicleid, panels, doors, pLights[p], tires);
                }
            }
        }
    }
    return 1;
}

stock SetSpeedDel(playerid)
{
	switch(SpeedVehicle(playerid))
	{
		case 0..9: TextDrawSetString(Speed[playerid][0], "~w~~h~I");
		case 10..14: TextDrawSetString(Speed[playerid][0], "~w~~h~II");
		case 15..19: TextDrawSetString(Speed[playerid][0], "~g~III");
		case 20..24: TextDrawSetString(Speed[playerid][0], "~g~IIII");
		case 25..29: TextDrawSetString(Speed[playerid][0], "~g~~h~IIIII");
		case 30..34: TextDrawSetString(Speed[playerid][0], "~g~~h~IIIIII");
		case 35..39: TextDrawSetString(Speed[playerid][0], "~g~~h~IIIIIII");
		case 40..44: TextDrawSetString(Speed[playerid][0], "~g~~h~IIIIIIII");
		case 45..49: TextDrawSetString(Speed[playerid][0], "~g~~h~~h~IIIIIIIII");
		case 50..59: TextDrawSetString(Speed[playerid][0], "~g~~h~~h~IIIIIIIIII");
		case 60..64: TextDrawSetString(Speed[playerid][0], "~g~~h~~h~IIIIIIIIIII");
		case 65..69: TextDrawSetString(Speed[playerid][0], "~g~~h~~h~IIIIIIIIIIII");
		case 70..79: TextDrawSetString(Speed[playerid][0], "~y~IIIIIIIIIIIII");
		case 80..89: TextDrawSetString(Speed[playerid][0], "~y~IIIIIIIIIIIIII");
		case 90..99: TextDrawSetString(Speed[playerid][0], "~y~~h~IIIIIIIIIIIIIII");
		case 100..109: TextDrawSetString(Speed[playerid][0], "~y~~h~IIIIIIIIIIIIIIII");
		case 110..119: TextDrawSetString(Speed[playerid][0], "~y~~h~IIIIIIIIIIIIIIIII");
		case 120..129: TextDrawSetString(Speed[playerid][0], "~y~~h~IIIIIIIIIIIIIIIIII");
		case 130..139: TextDrawSetString(Speed[playerid][0], "~y~~h~IIIIIIIIIIIIIIIIIII");
		case 140..149: TextDrawSetString(Speed[playerid][0], "~y~~h~IIIIIIIIIIIIIIIIIIII");
		case 150..164: TextDrawSetString(Speed[playerid][0], "~y~~h~IIIIIIIIIIIIIIIIIIIII");
		case 165..174: TextDrawSetString(Speed[playerid][0], "~y~~h~IIIIIIIIIIIIIIIIIIIIII");
		case 175..189: TextDrawSetString(Speed[playerid][0], "~r~IIIIIIIIIIIIIIIIIIIIIII");
		case 190..199: TextDrawSetString(Speed[playerid][0], "~r~IIIIIIIIIIIIIIIIIIIIIIII");
		case 200..209: TextDrawSetString(Speed[playerid][0], "~r~~h~IIIIIIIIIIIIIIIIIIIIIIIII");
		case 210..219: TextDrawSetString(Speed[playerid][0], "~r~~h~IIIIIIIIIIIIIIIIIIIIIIIIII");
		case 220..229: TextDrawSetString(Speed[playerid][0], "~r~~h~IIIIIIIIIIIIIIIIIIIIIIIIIII");
		case 230..239: TextDrawSetString(Speed[playerid][0], "~r~~h~~h~IIIIIIIIIIIIIIIIIIIIIIIIIIII");
		case 240..249: TextDrawSetString(Speed[playerid][0], "~r~~h~~h~IIIIIIIIIIIIIIIIIIIIIIIIIIIII");
		default: TextDrawSetString(Speed[playerid][0], "~r~~h~~h~IIIIIIIIIIIIIIIIIIIIIIIIIIIII");
	}
}

stock SpeedVehicle(playerid)
{
    new Float:ST[4];
    if(IsPlayerInAnyVehicle(playerid))
	GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);
	else GetPlayerVelocity(playerid,ST[0],ST[1],ST[2]);
    ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 253.3;
    return floatround(ST[3]);
}

stock SetSpeedPok(playerid)
{
	new string[256];
	format(string, sizeof(string), "%d km'h", SpeedVehicle(playerid));
	TextDrawSetString(Speed[playerid][2], string);
}

stock RangName(playerid)
{
	new unreal[64];
    if (GetPlayerScore(playerid) >= 0) unreal = ("1 Level"), Moder[playerid] = 1000;
	if (GetPlayerScore(playerid) > 1000) unreal = ("2 Level"),Moder[playerid] = 2500;
	if (GetPlayerScore(playerid) > 2500) unreal = ("3 Level"), Moder[playerid] = 5000;
	if (GetPlayerScore(playerid) > 5000) unreal = ("4 Level"), Moder[playerid] = 8000;
	if (GetPlayerScore(playerid) > 8000) unreal = ("5 Level"), Moder[playerid] = 14000;
	if (GetPlayerScore(playerid) > 14000) unreal = ("6 Level"), Moder[playerid] = 20000;
	if (GetPlayerScore(playerid) > 20000) unreal = ("7 Level"), Moder[playerid] = 28000;
	if (GetPlayerScore(playerid) > 28000) unreal = ("8 Level"), Moder[playerid] = 38000;
	if (GetPlayerScore(playerid) > 38000) unreal = ("9 Level"), Moder[playerid] = 50000;
	if (GetPlayerScore(playerid) > 50000) unreal = ("10 Level"), Moder[playerid] = 64000;
	if (GetPlayerScore(playerid) > 64000) unreal = ("11 Level"), Moder[playerid] = 80000;
	if (GetPlayerScore(playerid) > 80000) unreal = ("12 Level"), Moder[playerid] = 98000;
	if (GetPlayerScore(playerid) > 98000) unreal = ("13 Level"), Moder[playerid] = 118000;
	if (GetPlayerScore(playerid) > 118000) unreal = ("14 Level"), Moder[playerid] = 140000;
	if (GetPlayerScore(playerid) > 140000) unreal = ("15 Level"), Moder[playerid] = 166000;
	return unreal;
}

public OnPlayerModelSelection(playerid, response, listid, modelid)
{
    new Float:X, Float:Y, Float:Z, Float:Angle;
    if(frodo[playerid] == 1)
    {
	  if(listid == skinlist)
	  {
	    if(response)
	    {
	    	SetPlayerSkin(playerid, modelid);
	    	PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
            SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	    }
    	return 1;
	  }
    }
	if(listid == car1)
	{
	    if(response)
	    {
		    SendClientMessage(playerid, 0xFF0000FF, "���������� ���������.");
	    	CreateVehicleEx(playerid,modelid, X,Y,Z+1, Angle, random(126), random(126), -1);
	    }
	    else SendClientMessage(playerid, 0xFF0000FF, "�� ������� ���� � ������������.");
    	return 1;
	}
	if(listid == car2)
	{
	    if(response)
	    {
		    SendClientMessage(playerid, 0xFF0000FF, "���������� ���������.");
	    	CreateVehicleEx(playerid,modelid, X,Y,Z+1, Angle, random(126), random(126), -1);
	    }
	    else SendClientMessage(playerid, 0xFF0000FF, "�� ������� ���� � ������������.");
    	return 1;
	}
	if(listid == car3)
	{
	    if(response)
	    {
		    SendClientMessage(playerid, 0xFF0000FF, "���������� ���������.");
	    	CreateVehicleEx(playerid,modelid, X,Y,Z+1, Angle, random(126), random(126), -1);
	    }
	    else SendClientMessage(playerid, 0xFF0000FF, "�� ������� ���� � ������������.");
    	return 1;
	}
	if(listid == car4)
	{
	    if(response)
	    {
		    SendClientMessage(playerid, 0xFF0000FF, "���������� ���������.");
	    	CreateVehicleEx(playerid,modelid, X,Y,Z+1, Angle, random(126), random(126), -1);
	    }
	    else SendClientMessage(playerid, 0xFF0000FF, "�� ������� ���� � ������������.");
    	return 1;
	}
	if(listid == car5)
	{
	    if(response)
	    {
		    SendClientMessage(playerid, 0xFF0000FF, "���������� ���������.");
	    	CreateVehicleEx(playerid,modelid, X,Y,Z+1, Angle, random(126), random(126), -1);
	    }
	    else SendClientMessage(playerid, 0xFF0000FF, "�� ������� ���� � ������������.");
    	return 1;
	}
	return 0;
}

forward ShowStats(playerid,targetid);
public ShowStats(playerid,targetid)
{
	        new name[MAX_PLAYER_NAME];
	        new cash = PlayerInfo[targetid][pMoney];
            new warns = PlayerInfo[targetid][pWarns];
            new score = PlayerInfo[targetid][pScore];
            GetPlayerName(targetid, name, sizeof(name));
			new playerip[256];
			GetPlayerIp(targetid, playerip, sizeof(playerip));
			new coordsstring[1200];
			new msg[] = "���:\t\t\t%s\n\nScore:\t\t%d\nLevel:\t\t%s\n������:\t\t%d\n\nWarns:\t\t\t%d\n";
			format(coordsstring, 1000, msg, name,score,RangName(playerid),cash,warns);
			ShowPlayerDialog(playerid,10004,DIALOG_STYLE_MSGBOX,"���������� ���������",coordsstring,"��","");
}

public Autocruise(playerid, in)
{
  new Float:vehx, Float:vehy, Float:vehz;
  GetVehiclePos(GetPlayerVehicleID(playerid), vehx, vehy, vehz);
  if(in == 1)
  {
    if(-1777 < vehy)
    {
      for(new i = 0; i < MAX_PLAYERS; i++)
      {
        if(GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
        {
          SetPlayerCameraPos(i,1910.4637,-1771.8,15);
          SetPlayerCameraLookAt(i,1911.2863,-1775.1614,13.3828);
        }
      }
      SetVehicleZAngle(GetPlayerVehicleID(playerid), 0);
      TogglePlayerControllable(playerid, 0);
      MoveObject(entrancegate, 1911.21130371, -1780.68151855, 14.15972233, 1);
      SetTimerEx("Water",4000,0,"ii",playerid, 1);
    }
    else
    {
      if(vehx != 1911.1886)
      {
        SetVehiclePos(GetPlayerVehicleID(playerid), 1911.1886, vehy, vehz);
        SetVehicleZAngle(GetPlayerVehicleID(playerid), 0);
      }
      TogglePlayerControllable(playerid, 1);
      SetVehicleVelocity(GetPlayerVehicleID(playerid), 0, 0.1, 0);
      SetTimerEx("Autocruise",100,0,"ii",playerid, 1);
    }
  }
  else
  {
    if(-1768 < vehy)
    {
      SetVehicleZAngle(GetPlayerVehicleID(playerid), 0);
      TogglePlayerControllable(playerid, 0);
      MoveObject(exitgate, 1911.21130371,-1771.97814941,14.15972233, 1);
      SetTimerEx("EndWash",1000,0,"i",playerid);
    }
    else
    {
      if(vehx != 1911.1886)
      {
        SetVehiclePos(GetPlayerVehicleID(playerid), 1911.1886, vehy, vehz);
        SetVehicleZAngle(GetPlayerVehicleID(playerid), 0);
      }
      TogglePlayerControllable(playerid, 1);
      SetVehicleVelocity(GetPlayerVehicleID(playerid), 0, 0.1, 0);
      SetTimerEx("Autocruise",100,0,"ii",playerid, 0);
    }
  }
  return 1;
}

public Water(playerid, on)
{
  if(on == 0)
  {
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
      if(GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
      {
        DestroyPlayerObject(i, water1);
        DestroyPlayerObject(i, water2);
        DestroyPlayerObject(i, water3);
        DestroyPlayerObject(i, water4);
        DestroyPlayerObject(i, water5);
        DestroyPlayerObject(i, water6);
        DestroyPlayerObject(i, water7);
        SetTimerEx("OpenExit",500,0,"i",playerid);
      }
    }
  }
  else
  {
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
      if(GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
      {
        water1 = CreatePlayerObject(i, 18747, 1911, -1776, 10, 0, 0, 90);
        water2 = CreatePlayerObject(i, 18747, 1914, -1776, 10, 0, 0, 90);
        water3 = CreatePlayerObject(i, 18739, 1910.1821, -1777.8997, 25, 0, 180, 0);
        water4 = CreatePlayerObject(i, 18739, 1910.1821, -1774.8132, 25, 0, 180, 0);
        water5 = CreatePlayerObject(i, 18739, 1912.1490, -1774.8132, 25, 0, 180, 0);
        water6 = CreatePlayerObject(i, 18739, 1912.1490, -1777.8997, 25, 0, 180, 0);
        water7 = CreatePlayerObject(i, 18739, 1911.2194, -1776.5117, 25, 0, 180, 0);
        SetTimerEx("Water",15000,0,"ii",playerid, 0);
      }
    }
  }
  return 1;
}

public OpenExit(playerid)
{
  for(new i = 0; i < MAX_PLAYERS; i++)
  {
	if(GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
	{
      SetPlayerCameraPos(i,1909.0697,-1760.7429,15);
      SetPlayerCameraLookAt(i,1911.2600,-1771.5955,13.3828);
	}
  }
  MoveObject(exitgate, 1911.21130371, -1771.97814941, 10.50000000, 1);
  SetTimerEx("Autocruise",3500,0,"ii",playerid, 0);
  return 1;
}

public EndWash(playerid)
{
  for(new i = 0; i < MAX_PLAYERS; i++)
  {
    if(GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
	{
      TogglePlayerControllable(i, 1);
      SetCameraBehindPlayer(i);
	}
  }
  usingcarwash = -1;
  Update3DTextLabelText(entrancetext, 0x008B00FF, "��������� ���������.\n������� (/carwash)");
  return 1;
}
//=[����]=======================================================================
Name(playerid)
{
  new Nm[MAX_PLAYER_NAME];
  GetPlayerName(playerid,Nm,24);
  return Nm;
}

SaveHouseAmount()
{
  new f=ini_openFile("houses/m_h.ini");
  ini_setInteger(f,"Amount",m_h);
  return ini_closeFile(f);
}

LoadHouses()
{
  if(!fexist("houses/m_h.ini"))return print("[������] ���� houses/m_h.ini �� ������");
  new f=ini_openFile("houses/m_h.ini");
  ini_getInteger(f,"Amount",m_h);
  ini_closeFile(f);
  if(!fexist("houses/houses.ini"))return print("[������] ���� houses/houses.ini �� ������");
  f=ini_openFile("houses/houses.ini");
  new str[8];
  for(new h=1;h<=m_h;h++)
  {
    format(str,sizeof(str),"ID %d",h);
    ini_getString(f,str,STR);
    sscanf(STR,"p<|>s[32]s[24]fffiiii",House[h][hDesc],House[h][hOwner],House[h][hX],House[h][hY],House[h][hZ],House[h][hInterior],
    House[h][hVirtWorld],House[h][hPrice],House[h][hLock]);
    if(!strcmp(House[h][hOwner],"None",true))
    {
      House[h][hPick]=CreatePickup(1273,23,House[h][hX],House[h][hY],House[h][hZ],0);
      format(STR,128,"{0015FF}Blodhamer{ffffff}: House System\n{ffffff}��� [{00FF11}��������{ffffff}]\nBlodhamer: %s\n����: $%d\n/buyhouse",House[h][hDesc],House[h][hPrice]);
      House[h][hText]=Create3DTextLabel(STR,0xFFFFFFFF,House[h][hX],House[h][hY],House[h][hZ]+0.5,10.0,0,0);
    }
    else
    {
      House[h][hPick]=CreatePickup(1239,23,House[h][hX],House[h][hY],House[h][hZ],0);
      format(STR,128,"{0015FF}Blodhamer{ffffff}: House System\n{ffffff}��� [{FF0000}������{ffffff}]\nBlodhamer: %s\n��������: %s\n/enter",House[h][hDesc],House[h][hOwner]);
      House[h][hText]=Create3DTextLabel(STR,0xFFFFFFFF,House[h][hX],House[h][hY],House[h][hZ]+0.5,10.0,0,0);
    }
  }
  ini_closeFile(f);
  return printf("Loaded %d houses",m_h);
}

SaveHouse(h)
{
  new f=ini_openFile("houses/houses.ini");
  new str[8];
  format(str,8,"ID %d",h);
  format(STR,sizeof(STR),"%s|%s|%f|%f|%f|%d|%d|%d|%d",House[h][hDesc],House[h][hOwner],House[h][hX],House[h][hY],House[h][hZ],House[h][hInterior],
  House[h][hVirtWorld],House[h][hPrice],House[h][hLock]);
  ini_setString(f,str,STR);
  ini_closeFile(f);
  return 1;
}

UpdateHouse(h)
{
  DestroyPickup(House[h][hPick]);
  if(!strcmp(House[h][hOwner],"None",true))
  {
    House[h][hPick]=CreatePickup(1273,23,House[h][hX],House[h][hY],House[h][hZ],0); // �����
    format(STR,128,"{0015FF}Blodhamer{ffffff}: House System\n{ffffff}��� [{00FF11}��������{ffffff}]\nBlodhamer: %s\n����: $%d\n/buyhouse",House[h][hDesc],House[h][hPrice]);
    Update3DTextLabelText(House[h][hText],0xFFFFFFFF,STR);
  }
  else
  {
    House[h][hPick]=CreatePickup(1239,23,House[h][hX],House[h][hY],House[h][hZ],0);
    format(STR,128,"{0015FF}Blodhamer{ffffff}: House System\n{ffffff}��� [{FF0000}������{ffffff}]\nBlodhamer: %s\n��������: %s\n/enter",House[h][hDesc],House[h][hOwner]);
    Update3DTextLabelText(House[h][hText],0xFFFFFFFF,STR);
  }
}

stock Load_Garages() //Loads all garages
{
        garageCount = 1;
        new path[128];
        for(new i=0; i < MAX_GARAGES; i++) //Loop trough all garage slots
        {
            format(path,sizeof(path),"garages/%d.ini",i); //Format the path with the filenumber
            if(dini_Exists(path)) //If the file exists, load the data
            {
                format(gInfo[i][Owner],24,"%s",dini_Get(path,"Owner"));
                gInfo[i][Owned] = dini_Int(path,"Owned");
                gInfo[i][Locked] = dini_Int(path,"Locked");
                gInfo[i][Price] = dini_Int(path,"Price");
                gInfo[i][PosX] = dini_Float(path,"PosX");
                gInfo[i][PosY] = dini_Float(path,"PosY");
                gInfo[i][PosZ] = dini_Float(path,"PosZ");
                gInfo[i][UID] = dini_Int(path,"UID");
                UpdateGarageInfo(i);
                garageCount++;
            }
        }
        printf("[jGarage]: Loaded %d garages.",garageCount);
        garageCount++; //To prevent overwriting/not detecting of garages
}
stock Save_Garages() //Saves all the garages
{
        new path[128];
        for(new i=0; i < garageCount+1; i++)
        {
            format(path,sizeof(path),"garages/%d.ini",i); //Format the path with the filenumber
            if(dini_Exists(path)) //If the file exists, save the data
            {
                dini_Set(path,"Owner",gInfo[i][Owner]);
                dini_IntSet(path,"Owned",gInfo[i][Owned]);
                dini_IntSet(path,"Locked",gInfo[i][Locked]);
                dini_IntSet(path,"Price",gInfo[i][Price]);
                dini_FloatSet(path,"PosX",gInfo[i][PosX]);
                dini_FloatSet(path,"PosY",gInfo[i][PosY]);
                dini_FloatSet(path,"PosZ",gInfo[i][PosZ]);
                dini_IntSet(path,"UID",gInfo[i][UID]);
            }
        }
}
stock Save_Garage(gid) //Saves a specific garage
{
        new path[128];
        format(path,sizeof(path),"garages/%d.ini",gid); //Format the path with the filenumber
        if(dini_Exists(path)) //If the file exists, save the data
    {
        dini_Set(path,"Owner",gInfo[gid][Owner]);
        dini_IntSet(path,"Owned",gInfo[gid][Owned]);
        dini_IntSet(path,"Locked",gInfo[gid][Locked]);
        dini_IntSet(path,"Price",gInfo[gid][Price]);
        dini_FloatSet(path,"PosX",gInfo[gid][PosX]);
        dini_FloatSet(path,"PosY",gInfo[gid][PosY]);
        dini_FloatSet(path,"PosZ",gInfo[gid][PosZ]);
        dini_IntSet(path,"UID",gInfo[gid][UID]);
    }

}
stock UpdateGarageInfo(gid) //Updates/creates the garage text and label
{
        //Get rid of the old label and pickup (if existing)
        DestroyDynamic3DTextLabel(garageLabel[gid]);
        DestroyDynamicPickup(garagePickup[gid]);

        //Re-create them with the correct data
        new ltext[128];
        if(gInfo[gid][Owned] == 1) //If the garage is owned
        {
            format(ltext,128,GARAGE_OWNED_TEXT,gInfo[gid][Owner],GetLockedStatus(gInfo[gid][Locked]));
            garageLabel[gid] = CreateDynamic3DTextLabel(ltext, TXTCOLOR, gInfo[gid][PosX],gInfo[gid][PosY],gInfo[gid][PosZ]+0.1,DD);
            garagePickup[gid] = CreateDynamicPickup(GARAGE_OWNED_PICKUP,1,gInfo[gid][PosX],gInfo[gid][PosY],gInfo[gid][PosZ]+0.2);
        }
        if(gInfo[gid][Owned] == 0)
        {
            format(ltext,128,GARAGE_FREE_TEXT,gInfo[gid][Price]);
            garageLabel[gid] = CreateDynamic3DTextLabel(ltext, TXTCOLOR, gInfo[gid][PosX],gInfo[gid][PosY],gInfo[gid][PosZ]+0.1,DD);
            garagePickup[gid] = CreateDynamicPickup(GARAGE_FREE_PICKUP,1,gInfo[gid][PosX],gInfo[gid][PosY],gInfo[gid][PosZ]);
        }
}
stock GetLockedStatus(value) //Returns 'Locked' or 'Unlocked' according to the value given
{
        new out[64];
        if(value == 1)
        {
            out = "Yes";
        }
        else
        {
            out = "No";
        }
        return out;
}
stock GetPlayerNameEx(playerid)
{
        new pName[24];
        GetPlayerName(playerid,pName,24);
        return pName;
}
stock Remove_PickupsAndLabels()
{
        for(new i=0; i < garageCount+1; i++)
        {
            DestroyDynamic3DTextLabel(garageLabel[i]);
            DestroyDynamicPickup(garagePickup[i]);
        }
}

//==============================================================================
stock IsVehicleOccupied(vehicleid)
{
  	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(GetPlayerState(i) == PLAYER_STATE_DRIVER || GetPlayerState(i) == PLAYER_STATE_PASSENGER)
		{
			if(GetPlayerVehicleID(i) == vehicleid)
			{
				return 1;
			}
		}
	}
	return 0;
}
//==============================================================================
stock CreateVehicleEx(playerid, modelid, Float:posX, Float:posY, Float:posZ, Float:angle, Colour1, Colour2, respawn_delay)
{
	new world = GetPlayerVirtualWorld(playerid);
	new interior = GetPlayerInterior(playerid);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		DestroyVehicle(GetPlayerVehicleID(playerid));
		GetPlayerPos(playerid, posX, posY, posZ);
		GetPlayerFacingAngle(playerid, angle);
		CurrentSpawnedVehicle[playerid] = CreateVehicle(modelid, posX, posY, posZ, angle, Colour1, Colour2, respawn_delay);
        LinkVehicleToInterior(CurrentSpawnedVehicle[playerid], interior);
		SetVehicleVirtualWorld(CurrentSpawnedVehicle[playerid], world);
		SetVehicleZAngle(CurrentSpawnedVehicle[playerid], angle);
		PutPlayerInVehicle(playerid, CurrentSpawnedVehicle[playerid], 0);
		SetPlayerInterior(playerid, interior);
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    if(IsVehicleOccupied(CurrentSpawnedVehicle[playerid])) {} else DestroyVehicle(CurrentSpawnedVehicle[playerid]);
		GetPlayerPos(playerid, posX, posY, posZ);
		GetPlayerFacingAngle(playerid, angle);
		CurrentSpawnedVehicle[playerid] = CreateVehicle(modelid, posX, posY, posZ, angle, Colour1, Colour2, respawn_delay);
		LinkVehicleToInterior(CurrentSpawnedVehicle[playerid], interior);
		SetVehicleVirtualWorld(CurrentSpawnedVehicle[playerid], world);
		SetVehicleZAngle(CurrentSpawnedVehicle[playerid], angle);
		PutPlayerInVehicle(playerid, CurrentSpawnedVehicle[playerid], 0);
		SetPlayerInterior(playerid, interior);
	}
	return 1;
}

/// {00ff00} - ������                                                       ///
/// {ff0000} - �������                                                       ///
/// {c71585} - ���������-�������                                             ///
/// {0000ff} - �����                                                         ///
/// {42aaff} - �������                                                       ///
/// {8b00ff} - ����������                                                    ///
/// {4b0082} - ������                                                        ///
/// {ffc0cb} - �������                                                       ///
/// {45161c} - �����                                                         ///
/// {ffd700} - �������                                                       ///
/// {ccff00} - ��������                                                      ///
/// {50c878} - ����������                                                    ///
/// {30d5c8} - ���������                                                     ///
/// {808080} - �����                                                         ///
/// {000000} - ׸����                                                        ///
/// {ffffff} - �����                                                         ///
/// {FFFF00} - Ƹ����                                                        ///


