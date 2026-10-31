# HARDWARE.md — Verified hardware inventory and base-system baseline

Dell XPS 13 9350 as actually detected on 2026-10-31 through read-only
inspection (no changes were made to the system). This is reference data
for hardware-dependent decisions; update it when the system or hardware
changes. Requirements live in SPECS.md; progress, pending tasks and deferred
decisions live in STATUS.md.

## Hardware inventory

| Component | Detected | Driver / status |
|---|---|---|
| CPU | Intel Core i7-6500U (Skylake-U, 2C/4T, 400 MHz–3.1 GHz, VT-x, 4 MiB L3) | intel_pstate + HWP, governor `powersave` |
| RAM | 16 GiB | OK |
| GPU | Intel HD Graphics 520 [8086:1916] | i915, KMS active |
| Display | eDP-1, 3200x1800 (QHD+, ~276 PPI, 13.3") | connected; `intel_backlight` present |
| Touchscreen | ELAN digitizer (USB) | present (occasional use) |
| Storage | Samsung PM951 NVMe 512 GB, fw BXV76D0Q (476.9 GiB) | nvme |
| Wi-Fi | Broadcom BCM4350 = Dell Wireless 1820 [14e4:43a3] | brcmfmac, working |
| Bluetooth | BCM2045A0 (USB) | btusb, hci0 up, rfkill clear |
| Audio | Realtek ALC3246 (HDA) + Intel HDMI codec | snd_hda_intel |
| Card reader | Realtek RTS525A PCIe microSD | rtsx_pci; not yet tested |
| Webcam | Integrated_Webcam_HD (USB) | not yet tested |
| Battery | BAT0, 56 Wh nominal (7.368 Ah) | firmware reports 100% health, 0 cycles (likely replaced) |
| Thermals | 25–40 °C across zones at idle | healthy |

Not present: fingerprint reader, Thunderbolt controller (not listed by
lspci — absent in this SKU or disabled in BIOS). No Ethernet port; the
machine is Wi-Fi only.

## Firmware and boot

- BIOS 1.13.0 (2020-02-10) — believed to be the final release for the
  9350 (not yet verified online).
- UEFI boot; Secure Boot disabled; TPM2 present (unused for measurement).
- Boot loader: rEFInd on the ESP (/dev/nvme0n1p1, 1 GiB, mounted at
  /boot with restrictive masks — its config requires root to read and
  has not been inspected yet).
- One stale NVRAM boot entry (0x0000) points to a partition that no
  longer exists (probably the installer USB).
- Kernel command line: `root=/dev/ArchinstallVg/root zswap.enabled=0 rw
  rootfstype=ext4 initrd=\initramfs-linux.img`.
- Kernel `linux` 7.2.11-arch1-1; intel-ucode loaded (0xf0, latest
  package). CPU vulnerability mitigations active; "Gather data sampling:
  no microcode" is expected on Skylake (no fix exists).
- Boot time ~20 s: firmware 7.7 s + loader 6.5 s (rEFInd menu —
  reducible) + kernel 2.5 s + userspace 3.4 s.

## Storage layout

- nvme0n1 (GPT, 476.9 GiB):
  - p1: 1 GiB vfat → /boot (ESP)
  - p2: LVM2 PV → volume group `ArchinstallVg`
    - `root` 47 GiB ext4 → /
    - `home` 428.7 GiB ext4 → /home
- Swap: zram 4 GiB (zram-generator, priority 100); zswap disabled on
  the kernel command line. No swap on disk and no `resume=` parameter,
  so hibernation is impossible as configured.
- fstab: UUID-based, `relatime`. fstrim.timer enabled. mkinitcpio HOOKS
  include lvm2/kms/microcode (correct for this layout).

## Base system state (2026-10-31)

- Installed with archinstall on 2026-10-26 (inferred from the LVM volume
  group name, kernel command line and package set). Added afterwards on
  2026-10-30: opencode, git, github-cli.
- 287 packages installed; 25 explicit (base, linux, linux-firmware,
  intel-ucode, lvm2, mkinitcpio, refind, networkmanager, wpa_supplicant,
  bluez, bluez-utils, the PipeWire stack — pipewire, pipewire-alsa,
  pipewire-jack, pipewire-pulse, wireplumber, gst-plugin-pipewire,
  libpulse —, power-profiles-daemon, ufw, sudo, zram-generator, git,
  github-cli, opencode). No AUR packages; no AUR helper; multilib
  disabled ([core] + [extra] only).
- Enabled units: NetworkManager (+ dispatcher, + wait-online),
  bluetooth, power-profiles-daemon, ufw, systemd-timesyncd,
  fstrim.timer, getty@, systemd-userdbd.socket, remote-fs.target.
  No sshd; no failed units.
- No text editor, terminal emulator or graphical session installed yet
  (bare TTY + bash). dbus-broker, NetworkManager, wpa_supplicant,
  bluetoothd and power-profiles-daemon are running.
- Locale en_US.UTF-8; keymap `es` (VC and X11); timezone Europe/Madrid;
  NTP synchronized; RTC in UTC.
- User: gilpe (uid 1000, wheel), bash. `~/.config` contains only `gh`
  and `opencode`; no dotfiles managed yet.

## Findings and quirks

1. Wi-Fi is Broadcom (DW1820), not Intel. Works with brcmfmac, but it is
   the historically troublesome option on Linux (firmware quirks,
   limited AP mode). Watch for issues; replacing the card is out of
   scope unless problems appear.
2. HiDPI (3200x1800 on 13.3") requires fractional scaling in Wayland /
   Hyprland; font and DPI decisions belong to those modules. The panel
   is a touchscreen (occasional use → basic touch support; gestures or
   disabling decided later).
3. No hibernation possible as configured (zram-only swap, no resume=).
4. rEFInd: 6.5 s loader time (menu timeout, reducible) and tiny text on
   a QHD panel; refind.conf not yet inspected. Stale NVRAM entry
   cleanable with efibootmgr.
5. NetworkManager-wait-online.service is enabled — a common source of
   slow boots; candidate to disable.
6. power-profiles-daemon is active; TLP is the alternative (decision
   belongs to the power module).
7. The PipeWire audio stack is already installed system-wide; the audio
   module reduces to validating speaker/jack routing on the ALC3246.
8. Only the `linux` kernel is installed; no `linux-lts` fallback.
9. Multilib is disabled — enable only if 32-bit support is ever needed.
10. Reproducibility gap found and fixed: `git` and `opencode` were
    installed manually on 2026-10-30 and were missing from install.sh.
