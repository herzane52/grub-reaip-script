#!/bin/bash

# Çoklu dil seçimi
ask_language() {
    if command -v zenity >/dev/null; then
        LANG=$(zenity --list --radiolist --title="Select Language / Dil Seçin" \
            --column="Seçili" --column="Dil / Language" \
            TRUE "Türkçe" FALSE "English" \
            --width=300 --height=200)
    else
        echo "Dil seçin / Select language:"
        echo "1) Türkçe"
        echo "2) English"
        read -p "Seçiminiz / Your choice (1/2): " lang_choice
        if [[ $lang_choice == "1" ]]; then LANG="Türkçe"; else LANG="English"; fi
    fi
}

ask_language

# Dil dosyaları
if [[ "$LANG" == "Türkçe" ]]; then
    TITLE="🛠️ GRUB Onarma Aracı"
    NOT_LIVE="❌ Bu betik yalnızca canlı USB ortamında çalıştırılabilir."
    SELECT_ACTION="⚙️ Hangi işlemi yapmak istersiniz?"
    OPTION1="GRUB'u yeniden kur"
    OPTION2="Sadece güncelle (grub.cfg)"
    ENTER_ROOT="👉 Root (/) bölümünüzü girin (örn: /dev/nvme0n1p3):"
    ENTER_EFI="💾 EFI bölümünüzü girin (örn: /dev/nvme0n1p1):"
    ASK_BTRFS="📦 Root bölümü Btrfs mi? (e/h)"
    MOUNTING="📂 Bölümler bağlanıyor..."
    CHROOTING="🔄 Chroot ortamına giriliyor..."
    GRUB_INSTALLING="📦 GRUB yeniden kuruluyor..."
    GRUB_CONFIGURING="⚙️ GRUB yapılandırması (grub.cfg) oluşturuluyor..."
    SUCCESS="✅ İşlem başarıyla tamamlandı. Şimdi yeniden başlatabilirsiniz."
    FAIL_MOUNT="❌ Mount başarısız oldu!"
    DISK_HINT="💡 Disk bölümlerini görmek için 'lsblk -f' kullanabilirsiniz."
else
    TITLE="🛠️ GRUB Recovery Tool"
    NOT_LIVE="❌ This script must be run from a Live USB environment."
    SELECT_ACTION="⚙️ What do you want to do?"
    OPTION1="Reinstall GRUB"
    OPTION2="Just update grub.cfg"
    ENTER_ROOT="👉 Enter your root (/) partition (e.g. /dev/nvme0n1p3):"
    ENTER_EFI="💾 Enter your EFI partition (e.g. /dev/nvme0n1p1):"
    ASK_BTRFS="📦 Is your root partition Btrfs? (y/n)"
    MOUNTING="📂 Mounting partitions..."
    CHROOTING="🔄 Entering chroot environment..."
    GRUB_INSTALLING="📦 Reinstalling GRUB..."
    GRUB_CONFIGURING="⚙️ Generating grub.cfg..."
    SUCCESS="✅ Done. You can now reboot."
    FAIL_MOUNT="❌ Mount failed!"
    DISK_HINT="💡 Use 'lsblk -f' to see disk partitions."
fi

# GUI ve CLI mesaj gösterici
function show_info() {
    if command -v zenity >/dev/null; then
        zenity --info --title="$TITLE" --text="$1"
    else
        echo -e "$1"
    fi
}

function show_error() {
    if command -v zenity >/dev/null; then
        zenity --error --title="$TITLE" --text="$1"
    else
        echo -e "\e[31m$1\e[0m"
    fi
}

# Canlı sistem kontrolü
if [ ! -d /run/miso ]; then
    show_error "$NOT_LIVE"
    exit 1
fi

# İşlem seçimi
if command -v zenity >/dev/null; then
    ACTION=$(zenity --list --radiolist --title="$TITLE" \
        --column="✓" --column="İşlem / Action" \
        TRUE "$OPTION1" FALSE "$OPTION2" \
        --height=200)
else
    echo -e "$SELECT_ACTION"
    echo "1) $OPTION1"
    echo "2) $OPTION2"
    read -p "> " ACTION_INPUT
    [[ "$ACTION_INPUT" == "1" ]] && ACTION="$OPTION1" || ACTION="$OPTION2"
fi

echo "$DISK_HINT"
lsblk -f

read -p "$ENTER_ROOT " ROOT_PART
read -p "$ENTER_EFI " EFI_PART
read -p "$ASK_BTRFS " IS_BTRFS

show_info "$MOUNTING"

if [[ "$IS_BTRFS" == @(e|E|y|Y) ]]; then
    sudo mount -o subvol=@ "$ROOT_PART" /mnt || { show_error "$FAIL_MOUNT"; exit 1; }
else
    sudo mount "$ROOT_PART" /mnt || { show_error "$FAIL_MOUNT"; exit 1; }
fi

sudo mount "$EFI_PART" /mnt/boot/efi || { show_error "$FAIL_MOUNT"; exit 1; }

show_info "$CHROOTING"

sudo manjaro-chroot /mnt /bin/bash <<EOF

if [[ "$ACTION" == "$OPTION1" ]]; then
    echo "$GRUB_INSTALLING"
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Manjaro --recheck || {
        echo "❌ GRUB install failed"; exit 1;
    }
fi

echo "$GRUB_CONFIGURING"
grub-mkconfig -o /boot/grub/grub.cfg || {
    echo "❌ grub.cfg creation failed"; exit 1;
}

exit
EOF

show_info "$SUCCESS"
