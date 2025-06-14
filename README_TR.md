
# GRUB Onarma Aracı

Bu betik, Manjaro veya Arch tabanlı sistemlerde GRUB önyükleyicisini **canlı USB (live USB)** ortamından kolayca yeniden kurmak veya güncellemek için hazırlanmıştır.

---

## Özellikler

- GRUB’u yeniden kurma  
- Sadece `grub.cfg` dosyasını güncelleme  
- Btrfs veya normal dosya sistemi desteği  
- Canlı USB ortamında çalışır, sistem içinde çalıştırılmamalıdır  
- Hem grafik arayüz (Zenity) hem de terminal tabanlı kullanım destekler  

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

