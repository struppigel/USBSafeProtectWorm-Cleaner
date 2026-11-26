# USBSafeProtectWorm-Cleaner

Removal and file-recovery tool for the **"Usb Safe Protect"** USB worm.

The worm hides your files in an invisible folder on USB drives and network shares and leaves a launcher in their place. This tool removes the worm and moves your files back.

Removed malware is quarantined in `%ProgramData%\USBSafeProtectWorm-Cleaner\Quarantine`.

## Requirements

- Windows 10 or later (.NET Framework 4.x, already included in Windows). No installation needed.
- Administrator rights are recommended. They are needed to clean other users' autostart entries and some protected locations.

## Download

Get `USBSafeProtectWorm-Cleaner.exe` from the [Releases](../../releases) page. A `.sha256` file is provided to verify the download.

## Usage (GUI)

1. Run `USBSafeProtectWorm-Cleaner.exe`. If the title bar does not say "(Administrator)", click **Restart as admin**.
2. Plug in the infected drive
3. Click **Scan**. The scan checks this PC and all connected drives. Use **Add folder / share...** to include a network share or folder.
4. Review the findings list. Untick anything you do not want touched.
5. Click **Clean selected**.
6. Scan again to confirm that "No traces of the worm found." is shown.

Use **Delete quarantine...** to empty the quarantine folder when you no longer need it.

## Usage (command line)

```
USBSafeProtectWorm-Cleaner.exe /scan | /clean [/path \\nas\share ...] [/noquarantine] [/deletequarantine] [/log file]
```

| Option | Meaning |
| --- | --- |
| `/scan` | Only report findings, change nothing. |
| `/clean` | Scan, clean, then scan again. |
| `/path <folder or share>` | Also check this folder or network share. Can be repeated. |
| `/noquarantine` | Do not keep copies of removed malware. |
| `/deletequarantine` | Empty the quarantine folder. Alone it only does that; combined with `/clean` it runs after cleaning. |
| `/log <file>` | Write the output to this file. |

Exit codes: `0` = nothing found (or all cleaned), `1` = traces remain, `2` = quarantine could not be deleted.

The program is a GUI executable, so console output may not show in a terminal. Use `/log` to capture the result.

Example:

```
USBSafeProtectWorm-Cleaner.exe /clean /path \\nas\share /log result.txt
```

## Logs

Every run (GUI or command line) writes `USBSafeProtectWorm-Cleaner_<yyyyMMdd_HHmmss>.txt` next to the executable. If that folder is read-only, logs go to `%ProgramData%\USBSafeProtectWorm-Cleaner\Logs`.

## Build from source

No SDK is required. In a Windows command prompt:

```
%WINDIR%\Microsoft.NET\Framework64\v4.0.30319\csc.exe /nologo /target:winexe /optimize+ ^
  /r:System.Management.dll /r:System.Windows.Forms.dll /r:System.Drawing.dll ^
  /win32manifest:app.manifest /win32icon:app.ico ^
  /out:USBSafeProtectWorm-Cleaner.exe USBSafeProtectWorm-Cleaner.cs
```
## License

[MIT](LICENSE)
