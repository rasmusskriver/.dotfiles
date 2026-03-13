# The final boss, arch linux manual

## Installer korrekt keyboard (som selvfølgelig er det danske uden døde taster)

loadkeys dk

## hak lige lortet på wifi først

iwctl
station list # this will show your wireless cards usually it will be wlan0
station wlan0 get-networks
station wlan0 connect YOUR_WIFI_NETWORK

skriv kode

ctrl + c for at exit

kør en pacman -Syy

## Find der hvor arch linux skal installeres

fdisk -l

fdisk "Partion name"

If your drive already has partitions on it, we'll have to delete them

Enter the character 'd' and hit enter. Keep repeating this until you get the message "no partition is defined yet"

Now enter these keys

(any prompts you receive about the filesystem containing a "signature" just answer yes "Y")

```
n # Make a new partition this will be our EFI system partition (ESP)
ENTER
ENTER
ENTER
+1024M # Set the max size to 1024MiB or 1GiB
ENTER
t # Change the partition's type to be recognised as an ESP
ENTER
ef
ENTER
n # Create another partition. This will be our root partition
ENTER
ENTER
ENTER
ENTER
w
ENTER
```

Formatting the Disk

mkfs.fat -F32 "partion navn boot"
mkfs.ext4 "partion navn alminedelig"

mount dem

mount ROOT_BLOCK_DEVICE /mnt

mount --mkdir ESP_BLOCK_DEVICE /mnt/boot

installer kernel på den nye partion

pacstrap -K /mnt base linux linux-firmware
(OBS linux-headers for nvidia dkms show fatter noget, ved dog ikke om man kan installere det her allerede)

(prøv at køre der fstab show inden chroot)

chroot ind i lortet

arch-chroot /mnt

lav en swap fil
(create 16GiB swapfile for 16GiB RAM)

mkswap -U clear --size 16G --file /swapfile

swapon /swapfile

hop ud af chroot
exit
genfstab -U /mnt >> /mnt/etc/fstab

chroot ind igen

arch-chroot /mnt

pacman -S vim sudo iwd dhcpcd git base-devel networkmanager fastfetch

## Packages explained:

```
vim: Text editor we will use later in the guide

sudo: Temporarily grants a non-root user root privileges

iwd: CLI tool to connect to WiFi

dhcpcd: DHCP client (we'll enable this later to get internet access)

git: Version control software we'll use to download yay (AUR helper) later

base-devel: Key packages such as gcc and make needed to build from the AUR

networkmanager: dhcpcd is our DHCP client however we still need network manager to work alongside it for internet access

fastfetch: Show people that you use Arch btw (neofetch er dødt)
```

You should also install microcode for either your Intel or AMD CPU.

pacman -S intel-ucode

or:

pacman -S amd-ucode

## Timezones

Use the keys 'j' and 'k' to navigate down and up.

timedatectl list-timezones

Set your timezone

timedatectl set-timezone Europe/Copenhagen

Set the hardware clock

hwclock --systohc

Set timedatectl to synchronise the clock using NTP.

timedatectl set-ntp true

## Locales

vim /etc/locale.gen
Use the arrow keys to move down until you find en_US.UTF-8 delete the '#' to uncomment

locale-gen

echo LANG=en_US.UTF-8 > /etc/locale.conf

## Hostname

The hostname will be your device's name or any name for that matter. We will write to the /etc/hostname file using the same echo command we used to set the locale.

echo Thinkpad-T420 > /etc/hostname

## Account Setup

Set the root password.

passwd

Next we're going to create a new user.

useradd -m rasmus

The -m flag will add a new /home directory for you new user.

Set the password for your new user.

passwd rasmus

Put our user into the wheel, audio, video and storage groups.

usermod -aG wheel,audio,video,storage rasmus

visudo

Find sektion "User privilege specification" and delete the # character of the line %wheel ALL=(ALL:ALL) ALL.

Hit the key 'x' to delete that #.

Press :wq then hit ENTER. This both writes the changes and exits Vim.

## Setting Up GRUB

pacman -S grub efibootmgr

(tilføj os-prober til ovenstående for windows dual boot entry)

mount ESP_BLOCK_DEVICE /boot/efi

Next we need to install GRUB to our ESP.

grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi

(
Aktiver detektion af andre OS'er
Rediger /etc/default/grub og sørg for at denne linje ikke er kommenteret:
GRUB_DISABLE_OS_PROBER=false
)

GRUB requires a configuration file in order to work so we need to generate one.

grub-mkconfig -o /boot/grub/grub.cfg

Hvis det ikke virker kan det være windows skal mountes først ??

mkdir -p /mnt/windows_esp
mount /dev/sdY1 /mnt/windows_esp

## Last touch

systemctl enable dhcpcd

systemctl enable NetworkManager

systemctl enable iwd

Exit back to the live environment and unmount the disks.

exit
umount /mnt/boot
umount /mnt

Finally reboot the computer either through the power switch or via command line.

reboot now

OBS tjek om denne er sat efter headers er installeret
To enable it, create and edit /etc/modprobe.d/nvidia.conf, and add this line to the file:
/etc/modprobe.d/nvidia.conf

options nvidia_drm modeset=1

Husk også installere dem her med pacman:
nvidia-open-dkms
nvidia-utils
egl-wayland

evt tjek:
https://wiki.hypr.land/Nvidia/

NOTER:
credit to john ling:
https://www.johnling.me/blog/Hyprland-Guide

https://wiki.archlinux.org/title/Installation_guide

## packages for hyprland

sudo pacman -S firefox alacritty dolphin pipewire wireplumber pipewire-audio pipewire-pulse dunst xdg-desktop-portal-hyprland hyprpolkitagent hyprpaper hyprlock hypridle qt5-wayland qt6-wayland waybar rofi feh kvantum qt5ct qt6ct nwg-look bluez bluez-utils blueman sof-firmware wl-clipboard sddm

# Explanation of packages

```
firefox: Web browser
alacritty: Terminal
dolphin: GUI File Manager
pipewire: Sound server for getting... sound
wireplumber (needed): Session and policy manager for pipewire
pipewire-audio: Audio support for pipewire
pipewire-pulse: Pipewire replacement for pulseaudio (common sound server on Linux)
dunst: Daemon used for displaying notifications such as Discord messages or Spotify song changes
xdg-desktop-portal-hyprland: Implementation of an xdg-desktop-portal for Hyprland. Explanation of portals can be found at https://wiki.archlinux.org/title/XDG_Desktop_Portal
hyprpolkitagent: Polkit authentication daemon. Needed for GUI apps to request elevated permissions.
hyprpaper: Used for setting and changing wallpapers in Hyprland
hyprlock: Screen locker for Hyprland
hypridle: Run scripts when your device goes idle. This can be ignored if you don't want your device to sleep such as a desktop
qt5-wayland and qt6-wayland: Libraries for QT applications to work under wayland. QT is a framework for building GUI apps in C++.
waybar: Menubar for Wayland systems.
rofi: Application launcher
feh: Simple image viewer
kvantum: Used for theming Dolphin
qt5ct and qt6ct: Used for theming QT5 and QT6 apps
nwg-look: Used for theming Gnome apps
bluez and bluez-utils: Bluetooth support
blueman: GUI for connecting to Bluetooth devices
sof-firmware: Some **laptops** may need this for their speakers to work
wl-clipboard: Clipboard manager for Wayland
sddm: Login screen
```
