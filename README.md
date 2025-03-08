# TweaksForWindows10

  
  ![Windows 10](https://img.shields.io/badge/Windows-10-blue?logo=windows)
  ![License](https://img.shields.io/badge/License-MIT-green)
  ![Status](https://img.shields.io/badge/Status-Active-brightgreen)
  ![Version](https://img.shields.io/badge/Version-1.0-orange)
</div>

## 📋 Overview

**TweaksForWindows10** is a comprehensive collection of tools, scripts, and utilities designed to optimize, enhance, and customize your Windows 10 experience. This project provides users with ready-to-use solutions for improving system performance, enhancing graphics driver functionality, cleaning system files, and more.

## 🛠️ Tools Description

### 📁 Basic System Setup (Folder 1)

| File | Description |
|------|-------------|
| **1) Activator.bat** | Windows 10 activation script using KMS activation method. |
| **2) DebloatApps.cmd** | Removes pre-installed Windows 10 bloatware and unnecessary applications. |
| **3) Fix Explorer.reg** | Registry fixes for common Windows Explorer issues and optimizations. |
| **4) Sound settings.lnk** | Shortcut to Windows sound settings for quick audio configuration. |
| **5) Language Settings.url** | Quick access to language and region settings for localization. |
| **99) sysclean.bat** | System cleaning script (identical to the one in Cleaner folder). |

### 📁 Hardware Optimization (Folder 2)

#### CPU Intel

| File | Description |
|------|-------------|
| **CPU-Intel-tweak.bat** | Comprehensive optimization script for Intel CPUs with gaming-focused tweaks for power management, scheduling, and performance. |

#### CPU+GPU AMD

| File | Description |
|------|-------------|
| **CPU AMD tweaks.bat** | Optimization script specifically designed for AMD processors to improve gaming performance. |
| **GPU AMD Dwords.bat** | Registry tweaks and optimizations for AMD graphics cards to enhance gaming performance. |
| **AMD-DRIVERS.url** | Link to download the latest AMD drivers for optimal performance. |

#### GPU NVIDIA

| File | Description |
|------|-------------|
| **1) NVCleanstall_1.18.0.exe** | Clean NVIDIA driver installer (same as in Tweak-Programs). |
| **2) NVIDIA.bat** | Batch script with NVIDIA-specific optimizations and registry tweaks. |
| **3) nvidiaProfileInspector.exe** | Tool for advanced NVIDIA driver settings (same as in Tweak-Programs). |
| **3) Custom Profile.nip** | Pre-configured NVIDIA profile with optimized settings for gaming. |

### 📁 Advanced System Tweaks (Folder 3)

| File | Description |
|------|-------------|
| **1) openPOW.reg** | Registry file that adds an option to open advanced power settings directly. |
| **2) Latency Tweaks.cmd** | Script focused on reducing system latency for better responsiveness in gaming. |
| **3) Remove Power Saving Features On USB Devices.bat** | Disables USB power saving features that can cause disconnections or lag. |
| **4) Disable Memory Compression.cmd** | Disables Windows memory compression for potentially improved performance on high-RAM systems. |
| **5) Optimal Registry Settings.reg** | Collection of registry tweaks optimized for gaming and system responsiveness. |
| **6) Apply Windows Tweaks.bat** | Comprehensive batch script applying multiple system tweaks including boot configuration, service optimizations, and more. |

### 🧹 Cleaner

| File | Description |
|------|-------------|
| **sysclean.bat** | A comprehensive batch script that thoroughly cleans your system by removing temporary files, clearing cache, emptying recycle bin, deleting prefetch files, cleaning Edge browser cache, and clearing event logs. Helps free up disk space and may improve system performance. |

### 🔧 Tweak-Programs

| File | Description |
|------|-------------|
| **NVCleanstall_1.18.0.exe** | A utility for clean NVIDIA driver installation. Allows you to customize which components to install, remove telemetry, and optimize driver settings for better performance. |
| **nvidiaProfileInspector.exe** | Advanced tool for tweaking NVIDIA driver settings beyond what's available in the NVIDIA Control Panel. Useful for optimizing game-specific profiles and unlocking hidden settings. |
| **GoInterruptPolicy.exe** | Tool to optimize CPU interrupt policies, which can help reduce input lag and improve system responsiveness for gaming. |
| **Autoruns64.exe** | Microsoft Sysinternals utility that shows all programs configured to run during system bootup or login. Helps identify and disable unnecessary startup programs to improve boot time. |
| **OBS-Studio-31.0.1-Windows-Installer.exe** | Open Broadcaster Software for video recording and live streaming. Optimized version for Windows 10. |
| **7zSetup-x64.exe** | 7-Zip file archiver with high compression ratio. Useful for extracting and creating various archive formats. |
| **NSudoLG.exe** | Powerful tool to run programs with full system privileges (TrustedInstaller). Useful for making system changes that require elevated permissions. |

#### CRU-1.5.1 (Custom Resolution Utility)

| File | Description |
|------|-------------|
| **CRU.exe** | Custom Resolution Utility - allows you to create and manage custom display resolutions and refresh rates not available in standard Windows display settings. |
| **reset-all.exe** | Resets all display driver settings to default values. Useful when display configurations cause problems. |
| **restart.exe** | Restarts the graphics driver without rebooting the system (32-bit version). Use after making changes in CRU. |
| **restart64.exe** | 64-bit version of the graphics driver restart utility. Preferred on 64-bit Windows systems. |

## ⚠️ Warning

- **Create a system restore point before using any of these tools**
- Some utilities modify system settings that may impact stability if used incorrectly
- Tools provided by third parties are subject to their respective licenses
- Use at your own risk

## 🖥️ Recommended Usage

1. **For New System Setup**:
   - Start with scripts in Folder 1 to set up your system
   - Run DebloatApps.cmd to remove unnecessary Windows components

2. **For Hardware-Specific Optimization**:
   - Use scripts in Folder 2 based on your hardware (Intel CPU, AMD CPU/GPU, or NVIDIA GPU)

3. **For Advanced Users**:
   - Apply tweaks from Folder 3 for better system responsiveness and gaming performance

4. **For System Cleaning**:
   - Run sysclean.bat as administrator when your system feels sluggish or before gaming sessions

5. **For NVIDIA GPU Users**:
   - Use NVCleanstall for clean driver installations
   - Use NVIDIA Profile Inspector to optimize game-specific settings

6. **For Display Customization**:
   - Use CRU to set custom refresh rates or resolutions
   - Always use restart64.exe (on 64-bit systems) after making changes

7. **For System Optimization**:
   - Use Autoruns64 to disable unnecessary startup programs
   - Use GoInterruptPolicy to optimize for gaming performance


## ❓ Frequently Asked Questions

**Q: Are these tools safe to use?**  
A: All included tools are widely used in the Windows optimization community, but it's always recommended to create a system restore point before using them.

**Q: Will these tools work on Windows 11?**  
A: Most tools should work on Windows 11, but they are primarily tested and optimized for Windows 10.

**Q: Do I need to run all the tools?**  
A: No, each tool serves a specific purpose. Choose the ones that address your specific needs.

**Q: How often should I run the system cleaner?**  
A: Running the cleaner once every 2-4 weeks is typically sufficient for most users.

**Q: Which folder should I start with?**  
A: For a new system, start with Folder 1. For specific hardware optimizations, go to Folder 2. For advanced tweaking, check Folder 3.

**Q: Will the activation script work for all Windows 10 versions?**  
A: The activation script is designed for Windows 10 Pro. Results may vary with other editions.

---

<div align="center">
  <p>⭐ If you find this project useful, please consider giving it a star! ⭐</p>
  <p>Made with ❤️ for the Windows community</p>
</div>
