---


# GRUB Repair Tool

This script helps you **reinstall** or **update** the GRUB bootloader on Manjaro or Arch-based systems from a live USB environment.

---

## Features

- Reinstall GRUB  
- Update only `grub.cfg`  
- Supports Btrfs and standard filesystems  
- Works only in live USB environment  
- Supports GUI (Zenity) and CLI modes  
- English language support

---

## Usage

1. Boot your system from a live USB and open a terminal.  
2. Run the script:  
```bash
   sudo bash grub-repair.sh
````

3. Select “English” language if prompted.
4. Choose the desired action (Reinstall or Update).
5. Enter your root (/) and EFI partitions (examples provided).
6. Specify if the root partition is Btrfs.
7. The script will mount the partitions, chroot, and perform the selected action.
8. Once done, reboot your system.

---

## Notes

* Run this script **only on a live USB environment**.
* Use `lsblk -f` to check partition information.
* EFI partition is usually a small (\~100-500 MB) FAT32 partition.
* Root partition can be ext4, btrfs, or other filesystem.

---

## Requirements

* `bash`
* `zenity` (for GUI; will fallback to terminal if not present)
* `manjaro-chroot` (for Manjaro/Arch)
* `grub-install` and `grub-mkconfig` utilities

---

## License

Distributed under the MIT License.

---

## Contact

For bugs or suggestions, please open an issue on GitHub.
