# VM-Unified-Remote
Unified Remote for Voicemeeter Banana

INSTALLATION: (German)

1. Unified Remote Server (ServerSetup-3.6.1.xxxx.exe) installieren.

2. Unified Remote App - APK installieren. (Apple: https://itunes.apple.com/de/app/unified-remote/id825534179)

3. "UnifiedRemote_VoiceMeeter_EXE" in einen Ordner deiner Wahl verschieben, in dem dieser Ordner für längere Zeit bleiben kann. 
    In diesem Ordner wird eine Datei erstellt, die die Initialisierungsdaten für die UnifiedRemoteApp enhält.
    Kopiert den Pfad: (Bsp: "C:\Users\mozzi\Desktop\Programme\UnifiedRemote_VoiceMeeter_EXE") 
	jedes "\" muss doppelt sein: "C:\\Users\\mozzi\\Desktop\\Programme\\UnifiedRemote_VoiceMeeter_EXE\\voicemeeter_unified_remote.dat")

4. "VoiceMeeter RM" in "C:\ProgramData\Unified Remote\Remotes\Bundled" verschieben.
    In der Datei "remote.lua" den Pfad für "voicemeeter_unified_remote.dat" ändern.
		local path = "C:\\Users\\mozzi\\Desktop\\Programme\\UnifiedRemote_VoiceMeeter_EXE\\voicemeeter_unified_remote.dat"


INSTALLATION: (English)

1. Download & Install Unified Remote Server

2. Download & Install "Unified Remote App Full" (for Android) and "Unified Remote" (for iOS)

3. Copy "UnifiedRemote_VoiceMeeter_EXE" folder into a place of your choice and copy the path

4. Copy "VoiceMeeter RM" folder into the Unified Remote Bundled Remotes folder (probably: C:\ProgramData\Unified Remote\Remotes\Bundled)
		And edit the file "remote.lua" to point to your copied path: (in line 5:)
			local path = "C:\\Users\\mozzi\\Desktop\\Programme\\UnifiedRemote_VoiceMeeter_EXE\\voicemeeter_unified_remote.dat"
		
----------
LINKS:
Unified Remote Server Download: https://www.unifiedremote.com/download
Unified Remote App:
-> Android: https://play.google.com/store/apps/details?id=com.Relmtech.RemotePaid&hl=en_US
-> iOS: https://itunes.apple.com/de/app/unified-remote/id825534179
