pragma Singleton
import QtQuick
import Qt.labs.folderlistmodel
import Quickshell
import Quickshell.Io
import qs.Settings

Singleton {
    id: manager

    property string updateInterval: "2s"
    property string cpuUsageStr: ""
    property string cpuTempStr: ""
    property string memoryUsageStr: ""
    property string memoryUsagePerStr: ""
    property string batteryStatusStr: ""
    property string batteryStatusIcon: ""
    property real cpuUsage: 0
    property real memoryUsage: 0
    property real cpuTemp: 0
    property real diskUsage: 0
    property real memoryUsagePer: 0
    property string diskUsageStr: ""

    Process {
        id: zigstatProcess
        running: true
        command: [Quickshell.shellRoot + "/Programs/zigstat", updateInterval]
        stdout: SplitParser {
            onRead: function (line) {
                try {
                    const data = JSON.parse(line);
                    cpuUsage = +data.cpu;
                    cpuTemp = +data.cputemp;
                    memoryUsage = +data.mem;
                    memoryUsagePer = +data.memper;
                    diskUsage = +data.diskper;
                    cpuUsageStr = data.cpu + "%";
                    cpuTempStr = data.cputemp + "°C";
                    memoryUsageStr = data.mem + "G";
                    memoryUsagePerStr = data.memper + "%";
                    diskUsageStr = data.diskper + "%";
                } catch (e) {
                    console.error("Failed to parse zigstat output:", e);
                }
            }
        }
    }

    Process {
        id: batteryProcess
        running: true
        command: ["upower", "-i", "/org/freedesktop/UPower/devices/battery_BAT0"]
        stdout: SplitParser {
            onRead: function (line) {
                try {
                    const usageMatch = line.match(/percentage:\s+(\d+)%/);
                    if (usageMatch) {
                        batteryStatusStr = usageMatch[1] + "%";
                    }
                    const stateMatch = line.match(/state:\s+(\w+)/);
                    if (stateMatch) {
                        const state = stateMatch[1];
                        if (state === "fully-charged") {
                            batteryStatusIcon = "battery_charging_full";
                        } else if (state === "discharging") {
                            if (usageMatch) {
                                const usage = parseInt(usageMatch[1]);
                                if (usage >= 80) {
                                    batteryStatusIcon = "battery_full";
                                } else if (usage >= 60) {
                                    batteryStatusIcon = "battery_5_bar";
                                } else if (usage >= 40) {
                                    batteryStatusIcon = "battery_4_bar";
                                } else if (usage >= 20) {
                                    batteryStatusIcon = "battery_3_bar";
                                } else if (usage >= 10) {
                                    batteryStatusIcon = "battery_2_bar";
                                } else if (usage >= 5) {
                                    batteryStatusIcon = "battery_1_bar";
                                } else {
                                    batteryStatusIcon = "battery_alert";
                                }
                            } else {
                                batteryStatusIcon = "battery_alert";
                            }
                        }
                    }
                } catch (e) {
                    console.error("Failed to parse battery output:", e);
                }
            }
        }
    }
}
