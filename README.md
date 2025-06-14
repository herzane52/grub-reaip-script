---

# README\_TR.md

````markdown
# GRUB Onarma Aracı

Bu betik, Manjaro veya Arch tabanlı sistemlerde GRUB önyükleyicisini **canlı USB (live USB)** ortamından kolayca yeniden kurmak veya güncellemek için hazırlanmıştır.

---

## Özellikler

- GRUB’u yeniden kurma  
- Sadece `grub.cfg` dosyasını güncelleme  
- Btrfs veya normal dosya sistemi desteği  
- Canlı USB ortamında çalışır, sistem içinde çalıştırılmamalıdır  
- Hem grafik arayüz (Zenity) hem de terminal tabanlı kullanım destekler  
- Türkçe dil desteği

---

## Kullanım

1. Canlı USB’den sistemi başlatın ve terminal açın.  
2. Betiği çalıştırın:  
   ```bash
   sudo bash grub-repair.sh
````

3. Dil seçimi ekranında “Türkçe” seçin (varsa).
4. İstediğiniz işlemi seçin (Yeniden kur veya Güncelle).
5. Root (/) ve EFI bölümlerinizi girin (örneklerle desteklenir).
6. Root bölümünüzün Btrfs olup olmadığını belirtin.
7. Betik bölümleri bağlar, chroot ortamına girer ve işlemi gerçekleştirir.
8. İşlem tamamlanınca sistemi yeniden başlatabilirsiniz.

---

## Dikkat Edilmesi Gerekenler

* Betik yalnızca **canlı USB ortamında** çalıştırılmalıdır.
* Bölüm bilgilerinizi `lsblk -f` komutuyla kontrol edin.
* EFI bölümü genelde küçük (\~100-500 MB) FAT32 bölümüdür.
* Root bölümü ext4, btrfs veya başka dosya sistemi olabilir.

---

## Gereksinimler

* `bash`
* `zenity` (GUI için, yoksa terminal modunda devam eder)
* `manjaro-chroot` (Manjaro/Arch için)
* `grub-install` ve `grub-mkconfig` komutları

---

## Lisans

MIT Lisansı altında dağıtılmaktadır.

---

## İletişim

Herhangi bir hata veya öneri için GitHub üzerinden issue açabilirsiniz.

````

---

# README_EN.md

```markdown
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

```

---

İstersen ben bu iki dosyayı `.md` formatında hazırlayıp senin için dosya olarak da gönderebilirim. Nasıl istersen devam edelim!
```
