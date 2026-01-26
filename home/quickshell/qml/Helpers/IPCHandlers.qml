import Quickshell.Io

IpcHandler {
    property var appLauncherPanel
    property var lockScreen
    property var sidebarPopup

    target: "globalIPC"

    // Toggle Applauncher visibility
    function toggleLauncher(): void {
        if (!appLauncherPanel) {
            console.warn("AppLauncherIpcHandler: appLauncherPanel not set!");
            return;
        }
        if (appLauncherPanel.visible) {
            appLauncherPanel.hidePanel();
        } else {
            console.log("[IPC] Applauncher show() called");
            appLauncherPanel.showAt();
        }
    }

    // Toggle Quick Access / Sidebar Panel
    function toggleQuickAccess(): void {
        if (!sidebarPopup) {
            console.warn("QuickAccessIpcHandler: sidebarPopup not set!");
            return;
        }
        if (sidebarPopup.visible) {
            console.log("[IPC] QuickAccess hide() called");
            sidebarPopup.hidePopup();
        } else {
            console.log("[IPC] QuickAccess show() called");
            sidebarPopup.showAt();
        }
    }

    // Alias for toggleQuickAccess
    function toggleStatusMenu(): void {
        toggleQuickAccess();
    }

    // Toggle LockScreen
    function toggleLock(): void {
        if (!lockScreen) {
            console.warn("LockScreenIpcHandler: lockScreen not set!");
            return;
        }
        console.log("[IPC] LockScreen show() called");
        lockScreen.locked = true;
    }
}
