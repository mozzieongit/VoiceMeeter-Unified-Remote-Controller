#pragma comment(lib, User32.lib)

#include <iostream>
#include <fstream>
#include "resource.h"

/*******************************************************************************/
/**                           GET VOICEMEETER DIRECTORY                       **/
/*******************************************************************************/
static char uninstDirKey[]="SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall";
#define INSTALLER_UNINST_KEY	"VB:Voicemeeter {17359A74-1236-5467}"
void RemoveNameInPath(char * szPath)
{
    long ll;
    ll=(long)strlen(szPath);
    while ((ll>0) && (szPath[ll]!='\\')) ll--;
    if (szPath[ll] == '\\') szPath[ll]=0;
}
#ifndef KEY_WOW64_32KEY
#define KEY_WOW64_32KEY 0x0200
#endif
BOOL __cdecl RegistryGetVoicemeeterFolder(char * szDir)
{
    char szKey[256];
    char sss[1024];
    DWORD nnsize=1024;
    HKEY hkResult;
    LONG rep;
    DWORD pptype=REG_SZ;
    sss[0]=0;

    // build Voicemeeter uninstallation key
    strcpy(szKey,uninstDirKey);
    strcat(szKey,"\\");
    strcat(szKey,INSTALLER_UNINST_KEY);

    // open key
    rep=RegOpenKeyEx(HKEY_LOCAL_MACHINE,szKey,0, KEY_READ, &hkResult);
    if (rep != ERROR_SUCCESS)
    {
        // if not present we consider running in 64bit mode and force to read 32bit registry
        rep=RegOpenKeyEx(HKEY_LOCAL_MACHINE,szKey,0, KEY_READ | KEY_WOW64_32KEY, &hkResult);
    }
    if (rep != ERROR_SUCCESS) return FALSE;
    // read uninstall profram path
    rep=RegQueryValueEx(hkResult,"UninstallString",0,&pptype,(unsigned char *)sss,&nnsize);
    RegCloseKey(hkResult);

    if (pptype != REG_SZ) return FALSE;
    if (rep != ERROR_SUCCESS) return FALSE;
    // remove name to get the path only
    RemoveNameInPath(sss);
    if (nnsize>512) nnsize=512;
    strncpy(szDir,sss,nnsize);

    return TRUE;
}

/*******************************************************************************/
/**                                GET DLL INTERFACE                          **/
/*******************************************************************************/

static HMODULE G_H_Module=NULL;
static T_VBVMR_INTERFACE iVMR;

long InitializeDLLInterfaces(void)
{
    char szDllName[1024];
    memset(&iVMR,0,sizeof(T_VBVMR_INTERFACE));

    //get folder where is installed Voicemeeter
    if (RegistryGetVoicemeeterFolder(szDllName) == FALSE)
    {
        // voicemeeter not installed
        return -100;
    }
    //use right dll according O/S type
    if (sizeof(void*) == 8) strcat(szDllName,"\\VoicemeeterRemote64.dll");
    else strcat(szDllName,"\\VoicemeeterRemote.dll");

    // Load Dll
    G_H_Module=LoadLibrary(szDllName);
    if (G_H_Module == NULL) return -101;

    // Get function pointers
    iVMR.VBVMR_Login					=(T_VBVMR_Login)GetProcAddress(G_H_Module,"VBVMR_Login");
    iVMR.VBVMR_Logout					=(T_VBVMR_Logout)GetProcAddress(G_H_Module,"VBVMR_Logout");
    iVMR.VBVMR_RunVoicemeeter			=(T_VBVMR_RunVoicemeeter)GetProcAddress(G_H_Module,"VBVMR_RunVoicemeeter");
    iVMR.VBVMR_GetVoicemeeterType		=(T_VBVMR_GetVoicemeeterType)GetProcAddress(G_H_Module,"VBVMR_GetVoicemeeterType");
    iVMR.VBVMR_GetVoicemeeterVersion	=(T_VBVMR_GetVoicemeeterVersion)GetProcAddress(G_H_Module,"VBVMR_GetVoicemeeterVersion");

    iVMR.VBVMR_IsParametersDirty		=(T_VBVMR_IsParametersDirty)GetProcAddress(G_H_Module,"VBVMR_IsParametersDirty");
    iVMR.VBVMR_GetParameterFloat		=(T_VBVMR_GetParameterFloat)GetProcAddress(G_H_Module,"VBVMR_GetParameterFloat");
    iVMR.VBVMR_GetParameterStringA		=(T_VBVMR_GetParameterStringA)GetProcAddress(G_H_Module,"VBVMR_GetParameterStringA");
    iVMR.VBVMR_GetParameterStringW		=(T_VBVMR_GetParameterStringW)GetProcAddress(G_H_Module,"VBVMR_GetParameterStringW");
    iVMR.VBVMR_GetLevel					=(T_VBVMR_GetLevel)GetProcAddress(G_H_Module,"VBVMR_GetLevel");
    iVMR.VBVMR_GetMidiMessage			=(T_VBVMR_GetMidiMessage)GetProcAddress(G_H_Module,"VBVMR_GetMidiMessage");

    iVMR.VBVMR_SetParameterFloat		=(T_VBVMR_SetParameterFloat)GetProcAddress(G_H_Module,"VBVMR_SetParameterFloat");
    iVMR.VBVMR_SetParameters			=(T_VBVMR_SetParameters)GetProcAddress(G_H_Module,"VBVMR_SetParameters");
    iVMR.VBVMR_SetParametersW			=(T_VBVMR_SetParametersW)GetProcAddress(G_H_Module,"VBVMR_SetParametersW");
    iVMR.VBVMR_SetParameterStringA		=(T_VBVMR_SetParameterStringA)GetProcAddress(G_H_Module,"VBVMR_SetParameterStringA");
    iVMR.VBVMR_SetParameterStringW		=(T_VBVMR_SetParameterStringW)GetProcAddress(G_H_Module,"VBVMR_SetParameterStringW");

    iVMR.VBVMR_Output_GetDeviceNumber	=(T_VBVMR_Output_GetDeviceNumber)GetProcAddress(G_H_Module,"VBVMR_Output_GetDeviceNumber");
    iVMR.VBVMR_Output_GetDeviceDescA	=(T_VBVMR_Output_GetDeviceDescA)GetProcAddress(G_H_Module,"VBVMR_Output_GetDeviceDescA");
    iVMR.VBVMR_Output_GetDeviceDescW	=(T_VBVMR_Output_GetDeviceDescW)GetProcAddress(G_H_Module,"VBVMR_Output_GetDeviceDescW");
    iVMR.VBVMR_Input_GetDeviceNumber	=(T_VBVMR_Input_GetDeviceNumber)GetProcAddress(G_H_Module,"VBVMR_Input_GetDeviceNumber");
    iVMR.VBVMR_Input_GetDeviceDescA		=(T_VBVMR_Input_GetDeviceDescA)GetProcAddress(G_H_Module,"VBVMR_Input_GetDeviceDescA");
    iVMR.VBVMR_Input_GetDeviceDescW		=(T_VBVMR_Input_GetDeviceDescW)GetProcAddress(G_H_Module,"VBVMR_Input_GetDeviceDescW");

#ifdef VMR_INCLUDE_AUDIO_PROCESSING_EXAMPLE
    iVMR.VBVMR_AudioCallbackRegister	=(T_VBVMR_AudioCallbackRegister)GetProcAddress(G_H_Module,"VBVMR_AudioCallbackRegister");
		iVMR.VBVMR_AudioCallbackStart		=(T_VBVMR_AudioCallbackStart)GetProcAddress(G_H_Module,"VBVMR_AudioCallbackStart");
		iVMR.VBVMR_AudioCallbackStop		=(T_VBVMR_AudioCallbackStop)GetProcAddress(G_H_Module,"VBVMR_AudioCallbackStop");
		iVMR.VBVMR_AudioCallbackUnregister	=(T_VBVMR_AudioCallbackUnregister)GetProcAddress(G_H_Module,"VBVMR_AudioCallbackUnregister");
#endif
    // check pointers are valid
    if (iVMR.VBVMR_Login == NULL) return -1;
    if (iVMR.VBVMR_Logout == NULL) return -2;
    if (iVMR.VBVMR_RunVoicemeeter == NULL) return -2;
    if (iVMR.VBVMR_GetVoicemeeterType == NULL) return -3;
    if (iVMR.VBVMR_GetVoicemeeterVersion == NULL) return -4;
    if (iVMR.VBVMR_IsParametersDirty == NULL) return -5;
    if (iVMR.VBVMR_GetParameterFloat == NULL) return -6;
    if (iVMR.VBVMR_GetParameterStringA == NULL) return -7;
    if (iVMR.VBVMR_GetParameterStringW == NULL) return -8;
    if (iVMR.VBVMR_GetLevel == NULL) return -9;
    if (iVMR.VBVMR_SetParameterFloat == NULL) return -10;
    if (iVMR.VBVMR_SetParameters == NULL) return -11;
    if (iVMR.VBVMR_SetParametersW == NULL) return -12;
    if (iVMR.VBVMR_SetParameterStringA == NULL) return -13;
    if (iVMR.VBVMR_SetParameterStringW == NULL) return -14;
    if (iVMR.VBVMR_GetMidiMessage == NULL) return -15;

    if (iVMR.VBVMR_Output_GetDeviceNumber == NULL) return -30;
    if (iVMR.VBVMR_Output_GetDeviceDescA == NULL) return -31;
    if (iVMR.VBVMR_Output_GetDeviceDescW == NULL) return -32;
    if (iVMR.VBVMR_Input_GetDeviceNumber == NULL) return -33;
    if (iVMR.VBVMR_Input_GetDeviceDescA == NULL) return -34;
    if (iVMR.VBVMR_Input_GetDeviceDescW == NULL) return -35;

#ifdef VMR_INCLUDE_AUDIO_PROCESSING_EXAMPLE
    if (iVMR.VBVMR_AudioCallbackRegister == NULL) return -40;
		if (iVMR.VBVMR_AudioCallbackStart == NULL) return -41;
		if (iVMR.VBVMR_AudioCallbackStop == NULL) return -42;
		if (iVMR.VBVMR_AudioCallbackUnregister == NULL) return -43;
#endif
    return 0;
}

long startup() {
    long rep;
    //get DLL interface
    rep=InitializeDLLInterfaces();
    if(rep < 0){

        return 1;
    }
    rep=iVMR.VBVMR_Login();
    if (rep == 1)
    {
        iVMR.VBVMR_RunVoicemeeter(2);
        Sleep(1000);
    }
    iVMR.VBVMR_IsParametersDirty();
    return 0;
}

/* variables */
HWND Hwnd;
HMENU Hmenu;
HMENU hSubMenu;
NOTIFYICONDATA notifyIconData;
NOTIFYICONDATA notifyIconData2;
UINT WM_TASKBAR = 0;

TCHAR szTIP[64] = TEXT("VoiceMeeterRemote Controller");
TCHAR szInfo[64] = TEXT("Volume is");
char szClassName[ ] = "VoiceMeeterRemote Controller";

long fDisplayParam;
bool logs = false;
float volume;

float value = 0.0;
char ParamName[64] = "";

/* procedures */
LRESULT CALLBACK WindowProcedure (HWND, UINT, WPARAM, LPARAM);
void minimize();
void restore();
void InitNotifyIconData();
void Stealth();
void ManageInfoBox(HWND);
void pointCurDevice(char*);
void writeDataToFile();

float calculate(LPARAM param);

/* MAIN */
int WINAPI WinMain (HINSTANCE hThisInstance,
                    HINSTANCE hPrecInstance,
                    LPSTR lpszArgument,
                    int nCmdShow)
{
    /* Handle for our windows */
    MSG messages;       /* Saves Messages to the app */
    WNDCLASSEX wincl;   /* Data Structure for the windowclass */
    WM_TASKBAR = RegisterWindowMessageA("TaskbarCreated");

    /* Window Structure */
    wincl.hInstance         = hThisInstance;
    wincl.lpszClassName     = szClassName;
    wincl.lpfnWndProc       = WindowProcedure;        /* this function is called by windows */
    wincl.style             = CS_DBLCLKS;
    wincl.cbSize            = sizeof(WNDCLASSEX);

    /* Use default icon and mouse-pointer */
    wincl.hIcon             = LoadIcon (GetModuleHandle(NULL), MAKEINTRESOURCE(ICO1));
    wincl.hIconSm           = LoadIcon (GetModuleHandle(NULL), MAKEINTRESOURCE(ICO1));
    wincl.hCursor           = LoadCursor (NULL, IDC_ARROW);
    wincl.lpszMenuName      = "MyMainAppMenu";                  /* No Menu --> Doch*/
    wincl.cbClsExtra        = 0;                     /* No extra bytes after the window class */
    wincl.cbWndExtra        = 0;                     /* structure of the window instance */
    wincl.hbrBackground     = (HBRUSH)(CreateSolidBrush(RGB(255, 255, 255)));

    /* Register the window class, and if it fails quit the program */
    if (!RegisterClassEx (&wincl)) return 0;

    Hwnd = CreateWindowEx (
            0,                   /* Extended possibilites for variation */
            szClassName,         /* Classname */
            szClassName,         /* Title Text */
            WS_OVERLAPPEDWINDOW, /* default window */
            CW_USEDEFAULT,       /* Windows decides the position */
            CW_USEDEFAULT,       /* where the window ends up on the screen */
            544,                 /* The programs width */
            375,                 /* and height in pixels */
            HWND_DESKTOP,        /* The window is a child-window to desktop */
            NULL,                /* No menu */
            hThisInstance,       /* Program Instance handler */
            NULL                 /* No Window Creation data */
            );

    /* Init the NOTIFYICONDATA structure only once */
    InitNotifyIconData();

    /* Make the window visible on the screen */
    ShowWindow(Hwnd, nCmdShow);
    //minimize();

    /* Run the message loop. It will run until GetMessage() returns 0 */
    while (GetMessage(&messages, NULL, 0, 0)) {
        /*Translate virtual-key messages into character messages */
        TranslateMessage(&messages);
        /* send msg to WinProcedure */
        DispatchMessage(&messages);
    }

    return messages.wParam;
}

LRESULT CALLBACK WindowProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam){

    if (message == WM_TASKBAR && !IsWindowVisible(Hwnd)){
        //minimize();
        return 0;
    }

    switch (message) {          /* handle messages */
        case WM_ACTIVATE:
            Shell_NotifyIcon(NIM_ADD, &notifyIconData);

            break;

        case WM_CREATE: {
            long rep;
            rep = startup();
            if (rep != 0) {printf("Failed to login..");
                MessageBox(Hwnd, "Failed To Login!", "Init Error...", MB_APPLMODAL | MB_OK | MB_ICONERROR);
                return 1;}
            logs = true;

            ///* Write Initial Data to file:
            writeDataToFile();

            //*/

            iVMR.VBVMR_GetParameterFloat(const_cast<char *>("Bus[0].Gain"), &volume);
            Stealth();

            //ShowWindow(Hwnd, SW_HIDE);
            Hmenu = CreatePopupMenu();
            AppendMenu(Hmenu, MF_STRING, ID_TRAY_OPEN, TEXT("Open Window"));
            AppendMenu(Hmenu, MF_STRING, ID_TRAY_MINI, TEXT("Minimize Window"));
            AppendMenu(Hmenu, MF_SEPARATOR, 0, 0);
            AppendMenu(Hmenu, MF_STRING, ID_TRAY_EXIT, TEXT("Exit Program"));

            SetTimer(hwnd, MYTIMERID, 20, NULL);//50 Hz timer

            break;
        }
        case WM_SYSCOMMAND:
            /*In WM_SYSCOMMAND messages, the four low-order bits of the wParam parameter
	        are used internally by the system. To obtain the correct result when testing the value of wParam,
	        an application must combine the value 0xFFF0 with the wParam value by using the bitwise AND operator.*/

            switch (wParam & 0xFFF0){
                case SC_MINIMIZE:
                    break;
                case SC_CLOSE:
                    iVMR.VBVMR_Logout();
                    Shell_NotifyIcon(NIM_DELETE, &notifyIconData);
                    PostQuitMessage(0);
                    return 0;
            }
            break;
        case WM_SYSICON: {
            switch (wParam){
                case ID_TRAY_APP_ICON:
                    SetForegroundWindow(Hwnd);
                    break;
            }

            if (lParam == WM_LBUTTONUP && IsWindowVisible(Hwnd)){
                minimize();
            }else if(lParam == WM_LBUTTONUP){
                restore();
            }
                /*else if (lParam == WM_LBUTTONUP){
                restore();
                // Changed the way, the mouse interacts with the tray icon
                } */
            else if(lParam == WM_RBUTTONDOWN){
                /* Get curr mouse position */
                POINT curPoint;
                GetCursorPos(&curPoint);
                SetForegroundWindow(Hwnd);

                /* TrackPopupMenu blocks the app until TrackPopupMenu returns */
                UINT clicked = TrackPopupMenu(Hmenu,
                                              TPM_RETURNCMD | TPM_NONOTIFY,
                                              curPoint.x,
                                              curPoint.y,
                                              0,
                                              hwnd,
                                              NULL
                                );

                SendMessage(hwnd, WM_NULL, 0, 0);  /* send begin message to window to make sure the menu goes away*/
                if (clicked == ID_TRAY_EXIT){
                    /* quit APP */
                    iVMR.VBVMR_Logout();
                    Shell_NotifyIcon(NIM_DELETE, &notifyIconData);
                    PostQuitMessage(0);
                }
                if (clicked == ID_TRAY_OPEN){
                    restore();
                }
                if (clicked == ID_TRAY_MINI){
                    minimize();
                }
            }
        }break;
            /* intercept the hittest message.. */
        case WM_NCHITTEST: {
            UINT uHitTest = DefWindowProc(hwnd, WM_NCHITTEST, wParam, lParam);
            if(uHitTest == HTCLIENT){
                return HTCAPTION;
            } else return uHitTest;
        }

        case WM_CLOSE:
            iVMR.VBVMR_Logout();
            Shell_NotifyIcon(NIM_DELETE, &notifyIconData);
            PostQuitMessage(0);
            return 0;

        case WM_DESTROY:
            iVMR.VBVMR_Logout();
            Shell_NotifyIcon(NIM_DELETE, &notifyIconData);
            PostQuitMessage(0);
            return 0;

        case WM_COMMAND:
            switch (wParam){

                case ID_USAGE:
                    ManageInfoBox(hwnd);
                    break;
                case ID_TRAY_EXIT:
                    iVMR.VBVMR_Logout();
                    Shell_NotifyIcon(NIM_DELETE, &notifyIconData);
                    PostQuitMessage(0);
                    return 0;
            }
            break;
        case WM_TIMER:
            if (wParam == MYTIMERID)
            {
                //check if we have parameter change
                fDisplayParam=iVMR.VBVMR_IsParametersDirty();
                if (fDisplayParam!= 0) {
                    long vi, nb;

                    // check for mute
                    float muted = -1;
                    nb = iVMR.VBVMR_GetParameterFloat(const_cast<char *>("Bus[0].Mute"), &muted);

                    // check for vol change
                    /* TODO: Volume change detected. Now do balloon tip
                    float vol;
                    nb = iVMR.VBVMR_GetParameterFloat(const_cast<char *>("Bus[0].Gain"), &vol);
                    if (vol != volume) printf("It worked");
                    */
                }
            }
            break;
        case ID_RELOAD_INIT:
            writeDataToFile();
            break;
        case ID_MSG_STRIP: {
            //calculation: (0 - (500 - progress*2.5)) / 10;

            printf("\nMSG: %u W-%u --> ", message, wParam);

            //TODO: Send Command to Voicemeeter

            value = calculate(lParam);
            std::cout << value;

            switch (wParam) {
                case ID_STRIP_01: {
                    strcpy(ParamName, "Strip[0].Gain\0");
                    iVMR.VBVMR_SetParameterFloat(ParamName, value);
                    break;
                }
                case ID_STRIP_02: {
                    strcpy(ParamName, "Strip[1].Gain\0");
                    iVMR.VBVMR_SetParameterFloat(ParamName, value);
                    break;
                }
                case ID_STRIP_03: {
                    strcpy(ParamName, "Strip[2].Gain\0");
                    iVMR.VBVMR_SetParameterFloat(ParamName, value);
                    break;
                }
                case ID_STRIP_04: {
                    strcpy(ParamName, "Strip[3].Gain\0");
                    iVMR.VBVMR_SetParameterFloat(ParamName, value);
                    break;
                }
                case ID_STRIP_05: {
                    strcpy(ParamName, "Strip[4].Gain\0");
                    iVMR.VBVMR_SetParameterFloat(ParamName, value);
                    break;
                }
            }
            break;
        }
        case ID_MSG_BUS: {

            printf("\nMSG: %u W-%u --> ", message, wParam);

            value = calculate(lParam);
            std::cout << value;

            switch (wParam) {
                case ID_BUS_01: {
                    strcpy(ParamName, "Bus[0].Gain\0");
                    iVMR.VBVMR_SetParameterFloat(ParamName, value);
                    break;
                }
                case ID_BUS_02: {
                    strcpy(ParamName, "Bus[1].Gain\0");
                    iVMR.VBVMR_SetParameterFloat(ParamName, value);
                    break;
                }
                case ID_BUS_03: {
                    strcpy(ParamName, "Bus[2].Gain\0");
                    iVMR.VBVMR_SetParameterFloat(ParamName, value);
                    break;
                }
                case ID_BUS_04: {
                    strcpy(ParamName, "Bus[3].Gain\0");
                    iVMR.VBVMR_SetParameterFloat(ParamName, value);
                    break;
                }
                case ID_BUS_05: {
                    strcpy(ParamName, "Bus[4].Gain\0");
                    iVMR.VBVMR_SetParameterFloat(ParamName, value);
                    break;
                }
            }
            break;
        }
        case ID_MSG_BUTTON_ST01:
        case ID_MSG_BUTTON_ST02:
        case ID_MSG_BUTTON_ST03:
        case ID_MSG_BUTTON_ST04:
        case ID_MSG_BUTTON_ST05:
        case ID_MSG_BUTTON_ST06:
        case ID_MSG_BUTTON_ST07:
        case ID_MSG_BUTTON_ST08: {
            printf("MSG: %u W-%u --> ", message, wParam);
            std::cout << lParam;
            switch (message){
                case ID_MSG_BUTTON_ST01:
                    strcpy(ParamName, "Strip[0].");
                    break;
                case ID_MSG_BUTTON_ST02:
                    strcpy(ParamName, "Strip[1].");
                    break;
                case ID_MSG_BUTTON_ST03:
                    strcpy(ParamName, "Strip[2].");
                    break;
                case ID_MSG_BUTTON_ST04:
                    strcpy(ParamName, "Strip[3].");
                    break;
                case ID_MSG_BUTTON_ST05:
                    strcpy(ParamName, "Strip[4].");
                    break;
                case ID_MSG_BUTTON_ST06:
                    strcpy(ParamName, "Strip[5].");
                    break;
                case ID_MSG_BUTTON_ST07:
                    strcpy(ParamName, "Strip[6].");
                    break;
                case ID_MSG_BUTTON_ST08:
                    strcpy(ParamName, "Strip[7].");
                    break;
            }

            switch (wParam) {
                case ID_BUTTON_A1:
                    strcat(ParamName, "A1=");
                    break;
                case ID_BUTTON_A2:
                    strcat(ParamName, "A2=");
                    break;
                case ID_BUTTON_A3:
                    strcat(ParamName, "A3=");
                    break;
                case ID_BUTTON_A4:
                    strcat(ParamName, "A4=");
                    break;
                case ID_BUTTON_A5:
                    strcat(ParamName, "A5=");
                    break;
                case ID_BUTTON_B1:
                    strcat(ParamName, "B1=");
                    break;
                case ID_BUTTON_B2:
                    strcat(ParamName, "B2=");
                    break;
                case ID_BUTTON_B3:
                    strcat(ParamName, "B3=");
                    break;
                case ID_BUTTON_MO:
                    strcat(ParamName, "Mono=");
                    break;
                case ID_BUTTON_SO:
                    strcat(ParamName, "Solo=");
                    break;
                case ID_BUTTON_MU:
                    strcat(ParamName, "Mute=");
                    break;
                case ID_BUTTON_MC:
                    strcat(ParamName, "MC=");
                    break;

            }

            if(lParam == 1){
                strcat(ParamName, "1;");
            }
            else{
                strcat(ParamName, "0;");
            }
            std::cout << std::endl << ParamName;

            iVMR.VBVMR_SetParameters(ParamName);

            break;
        }
        case ID_MSG_BUTTON_BU01:
        case ID_MSG_BUTTON_BU02:
        case ID_MSG_BUTTON_BU03:
        case ID_MSG_BUTTON_BU04:
        case ID_MSG_BUTTON_BU05:
        case ID_MSG_BUTTON_BU06:
        case ID_MSG_BUTTON_BU07:
        case ID_MSG_BUTTON_BU08: {

            switch (message){
                case ID_MSG_BUTTON_BU01:
                    strcpy(ParamName, "Bus[0].");
                    break;
                case ID_MSG_BUTTON_BU02:
                    strcpy(ParamName, "Bus[1].");
                    break;
                case ID_MSG_BUTTON_BU03:
                    strcpy(ParamName, "Bus[2].");
                    break;
                case ID_MSG_BUTTON_BU04:
                    strcpy(ParamName, "Bus[3].");
                    break;
                case ID_MSG_BUTTON_BU05:
                    strcpy(ParamName, "Bus[4].");
                    break;
                case ID_MSG_BUTTON_BU06:
                    strcpy(ParamName, "Bus[5].");
                    break;
                case ID_MSG_BUTTON_BU07:
                    strcpy(ParamName, "Bus[6].");
                    break;
                case ID_MSG_BUTTON_BU08:
                    strcpy(ParamName, "Bus[7].");
                    break;
            }

            switch (wParam) {
                case ID_BUTTON_MO:
                    strcat(ParamName, "Mono=");
                    break;
                case ID_BUTTON_MU:
                    strcat(ParamName, "Mute=");
                    break;
            }

            if(lParam == 1){
                strcat(ParamName, "1;");
            } else {
                strcat(ParamName, "0;");
            }
            std::cout << std::endl << ParamName;

            iVMR.VBVMR_SetParameters(ParamName);

            break;
        }
    }
    return DefWindowProc(hwnd, message, wParam, lParam);
}

float calculate(LPARAM param) {
    int progress = param;
    return static_cast<float>((0 - (500 - progress * 2.5)) / 10);
}

void pointCurDevice(char *pString) {
    char temp[512];
    iVMR.VBVMR_GetParameterStringA(const_cast<char *>("Bus[0].device.name"), temp);
    sprintf(pString, "%s", temp);
}
void minimize() {
    /* hide main window */
    ShowWindow(Hwnd, SW_HIDE);
}
void restore() {
    ShowWindow(Hwnd, SW_SHOW);
}
void InitNotifyIconData() {
    memset(&notifyIconData, 0, sizeof(NOTIFYICONDATA));

    notifyIconData.cbSize       = sizeof(NOTIFYICONDATA);
    notifyIconData.hWnd         = Hwnd;
    notifyIconData.uID          = ID_TRAY_APP_ICON;
    notifyIconData.uFlags       = NIF_ICON | NIF_MESSAGE | NIF_TIP;
    notifyIconData.uCallbackMessage = WM_SYSICON;   /* set up our invented windows message */
    notifyIconData.hIcon        = (HICON)LoadIcon(GetModuleHandle(NULL), MAKEINTRESOURCE(ICO1));
    strncpy(notifyIconData.szTip, szTIP, sizeof(szTIP));
}
void Stealth() {
    HWND Stealth;
    AllocConsole();
    Stealth = FindWindowA("ConsoleWindowClass", NULL);
    ShowWindow(Stealth,0);
}
void ManageInfoBox(HWND hw) {
    char title[]="Usage...";
    char message[512];
    char sz[128];

    //get Voicemeeter Program Type
    strcpy(message,"This Program gets Messages from Unified Remote");
    strcat(message,"\nAnd sends commands to Voicemeeter Banana ");
    strcat(message,"\n");

    MessageBox(hw,message,title, MB_APPLMODAL | MB_OK);
}
void writeDataToFile(){
    float value = 0;
    char szParaName[64];

    std::string data = "";

    for(int i = 0; i < 5; i++){

        switch (i){
            case 0:
                strcpy(szParaName, "Strip[0].Gain\0");
                iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                data = data + szParaName + "=" + std::to_string(int(round(value))) + "&";
                for(int j = 0; j < 12; j ++){
                    strcpy(szParaName, "Strip[0].");
                    switch (j){
                        case 0:
                            strcat(szParaName, "A1");
                            break;
                        case 1:
                            strcat(szParaName, "A2");
                            break;
                        case 2:
                            strcat(szParaName, "A3");
                            break;
                        case 3:
                            continue;
                            strcat(szParaName, "A4");
                            break;
                        case 4:
                            continue;
                            strcat(szParaName, "A5");
                            break;
                        case 5:
                            strcat(szParaName, "B1");
                            break;
                        case 6:
                            strcat(szParaName, "B2");
                            break;
                        case 7:
                            continue;
                            strcat(szParaName, "B3");
                            break;
                        case 8:
                            strcat(szParaName, "Mono");
                            break;
                        case 9:
                            strcat(szParaName, "Solo");
                            break;
                        case 10:
                            strcat(szParaName, "Mute");
                            break;
                        case 11:
                            continue;
                            strcat(szParaName, "MC");
                            break;

                        default:
                            continue;

                    }
                    iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                    data = data + szParaName + "=" + std::to_string(int(value)) + "&";
                }
                //std::cout << data;
                break;
            case 1:
                strcpy(szParaName, "Strip[1].Gain\0");
                iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                data = data + szParaName + "=" + std::to_string(int(round(value))) + "&";
                for(int j = 0; j < 12; j ++){
                    strcpy(szParaName, "Strip[1].");
                    switch (j){
                        case 0:
                            strcat(szParaName, "A1");
                            break;
                        case 1:
                            strcat(szParaName, "A2");
                            break;
                        case 2:
                            strcat(szParaName, "A3");
                            break;
                        case 3:
                            continue;
                            strcat(szParaName, "A4");
                            break;
                        case 4:
                            continue;
                            strcat(szParaName, "A5");
                            break;
                        case 5:
                            strcat(szParaName, "B1");
                            break;
                        case 6:
                            strcat(szParaName, "B2");
                            break;
                        case 7:
                            continue;
                            strcat(szParaName, "B3");
                            break;
                        case 8:
                            strcat(szParaName, "Mono");
                            break;
                        case 9:
                            strcat(szParaName, "Solo");
                            break;
                        case 10:
                            strcat(szParaName, "Mute");
                            break;
                        case 11:
                            continue;
                            strcat(szParaName, "MC");
                            break;

                        default:
                            continue;

                    }
                    iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                    data = data + szParaName + "=" + std::to_string(int(value)) + "&";
                }
                //std::cout << data;
                break;
            case 2:
                strcpy(szParaName, "Strip[2].Gain\0");
                iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                data = data + szParaName + "=" + std::to_string(int(round(value))) + "&";
                for(int j = 0; j < 12; j ++){
                    strcpy(szParaName, "Strip[2].");
                    switch (j){
                        case 0:
                            strcat(szParaName, "A1");
                            break;
                        case 1:
                            strcat(szParaName, "A2");
                            break;
                        case 2:
                            strcat(szParaName, "A3");
                            break;
                        case 3:
                            continue;
                            strcat(szParaName, "A4");
                            break;
                        case 4:
                            continue;
                            strcat(szParaName, "A5");
                            break;
                        case 5:
                            strcat(szParaName, "B1");
                            break;
                        case 6:
                            strcat(szParaName, "B2");
                            break;
                        case 7:
                            continue;
                            strcat(szParaName, "B3");
                            break;
                        case 8:
                            strcat(szParaName, "Mono");
                            break;
                        case 9:
                            strcat(szParaName, "Solo");
                            break;
                        case 10:
                            strcat(szParaName, "Mute");
                            break;
                        case 11:
                            continue;
                            strcat(szParaName, "MC");
                            break;

                        default:
                            continue;

                    }
                    iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                    data = data + szParaName + "=" + std::to_string(int(value)) + "&";
                }
                //std::cout << data;
                break;
            case 3:
                strcpy(szParaName, "Strip[3].Gain\0");
                iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                data = data + szParaName + "=" + std::to_string(int(round(value))) + "&";
                for(int j = 0; j < 12; j ++){
                    strcpy(szParaName, "Strip[3].");
                    switch (j){
                        case 0:
                            strcat(szParaName, "A1");
                            break;
                        case 1:
                            strcat(szParaName, "A2");
                            break;
                        case 2:
                            strcat(szParaName, "A3");
                            break;
                        case 3:
                            continue;
                            strcat(szParaName, "A4");
                            break;
                        case 4:
                            continue;
                            strcat(szParaName, "A5");
                            break;
                        case 5:
                            strcat(szParaName, "B1");
                            break;
                        case 6:
                            strcat(szParaName, "B2");
                            break;
                        case 7:
                            continue;
                            strcat(szParaName, "B3");
                            break;
                        case 8:
                            continue;
                            strcat(szParaName, "Mono");
                            break;
                        case 9:
                            strcat(szParaName, "Solo");
                            break;
                        case 10:
                            strcat(szParaName, "Mute");
                            break;
                        case 11:
                            strcat(szParaName, "MC");
                            break;

                        default:
                            continue;

                    }
                    iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                    data = data + szParaName + "=" + std::to_string(int(value)) + "&";
                }
                //std::cout << data;
                break;
            case 4:
                strcpy(szParaName, "Strip[4].Gain\0");
                iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                data = data + szParaName + "=" + std::to_string(int(round(value))) + "&";
                for(int j = 0; j < 12; j ++){
                    strcpy(szParaName, "Strip[4].");
                    switch (j){
                        case 0:
                            strcat(szParaName, "A1");
                            break;
                        case 1:
                            strcat(szParaName, "A2");
                            break;
                        case 2:
                            strcat(szParaName, "A3");
                            break;
                        case 3:
                            continue;
                            strcat(szParaName, "A4");
                            break;
                        case 4:
                            continue;
                            strcat(szParaName, "A5");
                            break;
                        case 5:
                            strcat(szParaName, "B1");
                            break;
                        case 6:
                            strcat(szParaName, "B2");
                            break;
                        case 7:
                            continue;
                            strcat(szParaName, "B3");
                            break;
                        case 8:
                            continue;
                            strcat(szParaName, "Mono");
                            break;
                        case 9:
                            strcat(szParaName, "Solo");
                            break;
                        case 10:
                            strcat(szParaName, "Mute");
                            break;
                        case 11:
                            strcat(szParaName, "MC");
                            break;

                        default:
                            continue;

                    }
                    iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                    data = data + szParaName + "=" + std::to_string(int(value)) + "&";
                }
                //std::cout << data;
                break;

                //Hier wuerde um die naechsten Strips ergaenzt werden
            default:
                continue;
        }
        //std::cout << std::endl;
    }
    std::cout << data << std::endl;
    // BUSSE
    for(int i = 0; i < 5; i++){

        switch (i){
            case 0:
                strcpy(szParaName, "Bus[0].Gain\0");
                iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                data = data + szParaName + "=" + std::to_string(int(round(value))) + "&";
                for(int j = 0; j < 2; j ++){
                    strcpy(szParaName, "Bus[0].");
                    switch (j){
                        case 0:
                            strcat(szParaName, "Mono");
                            break;
                        case 1:
                            strcat(szParaName, "Mute");
                            break;
                        default:
                            continue;
                    }
                    iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                    data = data + szParaName + "=" + std::to_string(int(value)) + "&";
                }
                //std::cout << data;
                break;
            case 1:
                strcpy(szParaName, "Bus[1].Gain\0");
                iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                data = data + szParaName + "=" + std::to_string(int(round(value))) + "&";
                for(int j = 0; j < 2; j ++){
                    strcpy(szParaName, "Bus[1].");
                    switch (j){
                        case 0:
                            strcat(szParaName, "Mono");
                            break;
                        case 1:
                            strcat(szParaName, "Mute");
                            break;
                        default:
                            continue;
                    }
                    iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                    data = data + szParaName + "=" + std::to_string(int(value)) + "&";
                }
                //std::cout << data;
                break;
            case 2:
                strcpy(szParaName, "Bus[2].Gain\0");
                iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                data = data + szParaName + "=" + std::to_string(int(round(value))) + "&";
                for(int j = 0; j < 2; j ++){
                    strcpy(szParaName, "Bus[2].");
                    switch (j){
                        case 0:
                            strcat(szParaName, "Mono");
                            break;
                        case 1:
                            strcat(szParaName, "Mute");
                            break;
                        default:
                            continue;
                    }
                    iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                    data = data + szParaName + "=" + std::to_string(int(value)) + "&";
                }
                //std::cout << data;
                break;
            case 3:
                strcpy(szParaName, "Bus[3].Gain\0");
                iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                data = data + szParaName + "=" + std::to_string(int(round(value))) + "&";
                for(int j = 0; j < 2; j ++){
                    strcpy(szParaName, "Bus[3].");
                    switch (j){
                        case 0:
                            strcat(szParaName, "Mono");
                            break;
                        case 1:
                            strcat(szParaName, "Mute");
                            break;
                        default:
                            continue;
                    }
                    iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                    data = data + szParaName + "=" + std::to_string(int(value)) + "&";
                }
                //std::cout << data;
                break;
            case 4:
                strcpy(szParaName, "Bus[4].Gain\0");
                iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                data = data + szParaName + "=" + std::to_string(int(round(value))) + "&";
                for(int j = 0; j < 2; j ++){
                    strcpy(szParaName, "Bus[4].");
                    switch (j){
                        case 0:
                            strcat(szParaName, "Mono");
                            break;
                        case 1:
                            strcat(szParaName, "Mute");
                            break;
                        default:
                            continue;
                    }
                    iVMR.VBVMR_GetParameterFloat(szParaName,&value);
                    data = data + szParaName + "=" + std::to_string(int(value)) + "&";
                }
                //std::cout << data;
                break;

                //Hier wuerde um die naechsten Busse ergaenzt werden
            default:
                continue;
        }
        //std::cout << std::endl;
    }

    data = data.substr(0, data.length()-1);
    std::cout << data << std::endl;

    // TODO: write to file
    ///*
    std::fstream file;
    file.open("voicemeeter_unified_remote.dat", std::fstream::out | std::fstream::trunc);
    file << data;
    file.close();
    //*/

}