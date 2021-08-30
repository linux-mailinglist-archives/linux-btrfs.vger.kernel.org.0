Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1233FBB53
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 19:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbhH3R6t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 13:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238342AbhH3R6s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 13:58:48 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E17C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 10:57:54 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id c206so9173112ybb.12
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=J4UKBj6ywwnLhttf+N8wbWAES+RFG90RRLkzo3dv1c0=;
        b=ilhTjN4173K2bQRL/EY6Z4ydzPBMCX7QJMyBDtq4x803dPmigeRuuCYHy3bkR5kVVe
         ZVaPG6OXnjgAMv8zBBuinLXt9FnUPIm3EEMlWdZQnTwYFxgYRIgGmMub+NC4ot8BGZTn
         b3ARn298dNYBCXFIQip4QZiR8wrfanN4yOet/sM5IJWWc+lGlqvycGujFh97Yjm9jCiU
         quR3cZ/KofgTGF4T3FS8wKjqbcbfduwlDl5pUVVNqb+afucRvgFKXGpeOljt8lQR37BO
         qAqa9UHr8kYAFrf/tbQVas65ovWCPsSg5ASNXNYY0iV+YKTyHpc7D423PnLXWtSOD+38
         vq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=J4UKBj6ywwnLhttf+N8wbWAES+RFG90RRLkzo3dv1c0=;
        b=XsP6PTojD8JmXx4TrJrDAMsayJ5jDPFxQ0S2E920SW+Db2YqU1+icAglvOAY8XS79q
         gTz5rwJoGYml0e3J4ooSQp24uvV0eVYhHYqRPytrT0z7hNfoKPM5jHO7YR02I0fzFVr1
         pjyLAiM/gQnQtBvToOFNtjRVUKSYM0rOI2qelJorgYlVmIAz3FOb5iM84mEJUDrE5+CF
         ffrVKmqUb5UWcM9Yzp4C4tRWKKDg86PghZ2HWSubynHkFhk05FdPGDPZ7qRuzI6gcVCn
         /nyyaNVoLpZmHdn5lIdYDKl0UZ0HzJKPfzx3oIKsDV6RNz7syz4LE2Hum7XoNvcgHwcp
         xLbw==
X-Gm-Message-State: AOAM533n+XaCKgUYvO6PkxBa5gf1JRxocx/3yY6ZuJGwuq0q3qnAhilO
        K0ho6H3Yn4rlU+BZmGmQPoqCP5v0G2WR6RVSf/hlaEPu8Zg89Ibl
X-Google-Smtp-Source: ABdhPJyxTldYsIADUxakOTrF/UnrtPK/fypryxJSOJqJ93gpRsOnk3J0c7WgVAVf+s0QTGVCJ7a9aeWHymGkBiXGe4s=
X-Received: by 2002:a25:6cc1:: with SMTP id h184mr23975352ybc.240.1630346273124;
 Mon, 30 Aug 2021 10:57:53 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 30 Aug 2021 11:57:37 -0600
Message-ID: <CAJCQCtSXKHSToLeOOconR_nKeuk8RjGjT7_z2QvV9=2zHfYB6g@mail.gmail.com>
Subject: 5.13.8, enospc with 6G unused
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fedora 34 user reports enospc without any kernel messages, and 77%
used is reported.



=3D=3D=3D fpaste 0.4.2.0 System Information =3D=3D=3D
* Kernel (uname -r ; cat /proc/cmdline):
     5.13.8-200.fc34.x86_64
     BOOT_IMAGE=3D(hd1,gpt2)/vmlinuz-5.13.8-200.fc34.x86_64
root=3DUUID=3D0929fd70-d300-4da7-93bf-ff6d0b3a1406 ro
rootflags=3Dsubvol=3Droot
rd.luks.uuid=3Dluks-4ac739d9-8d73-4913-89ac-656c79f89835 rhgb quiet

* btrfs-progs (rpm -q btrfs-progs):
     btrfs-progs-5.13.1-1.fc34.x86_64

* btrfs mounts (grep btrfs /proc/mounts):
     /dev/mapper/luks-4ac739d9-8d73-4913-89ac-656c79f89835 / btrfs
rw,seclabel,relatime,ssd,space_cache,subvolid=3D257,subvol=3D/root 0 0
     /dev/mapper/luks-4ac739d9-8d73-4913-89ac-656c79f89835 /home btrfs
rw,seclabel,relatime,ssd,space_cache,subvolid=3D256,subvol=3D/home 0 0

* block devices (lsblk -o
NAME,FSTYPE,SIZE,FSUSE%,MOUNTPOINT,UUID,MIN-IO,SCHED,DISC-GRAN,MODEL):
     NAME                                          FSTYPE       SIZE
FSUSE% MOUNTPOINT UUID                                 MIN-IO SCHED
DISC-GRAN MODEL
     mmcblk0                                                   29.1G
                                                        512 bfq
  4M
     =E2=94=9C=E2=94=80mmcblk0p1                                   vfat    =
     600M
  3% /boot/efi  7C61-D240                               512 bfq
  4M
     =E2=94=9C=E2=94=80mmcblk0p2                                   ext4    =
       1G
 25% /boot      ea9c35c0-2cb2-4492-bebd-8af75448e75f    512 bfq
  4M
     =E2=94=94=E2=94=80mmcblk0p3                                   crypto_L=
UKS 27.5G
                4ac739d9-8d73-4913-89ac-656c79f89835    512 bfq
  4M
       =E2=94=94=E2=94=80luks-4ac739d9-8d73-4913-89ac-656c79f89835 btrfs   =
    27.5G
 77% /home      0929fd70-d300-4da7-93bf-ff6d0b3a1406    512
  4M
     mmcblk0boot0                                                 4M
                                                        512 bfq
  4M
     mmcblk0boot1                                                 4M
                                                        512 bfq
  4M
     zram0                                                      3.7G
     [SWAP]                                            4096
  4K

* Kernel messages (journalctl -k -o short-monotonic --no-hostname |
grep "Linux version\| ata\|Btrfs\|BTRFS\|] hd\| scsi\| sd\| sdhci\|
mmc\| nvme\| usb\| vd"):
     [    0.000000] kernel: Linux version 5.13.8-200.fc34.x86_64
(mockbuild@bkernel01.iad2.fedoraproject.org) (gcc (GCC) 11.2.1
20210728 (Red Hat 11.2.1-1), GNU ld version 2.35.1-41.fc34) #1 SMP Wed
Aug 4 19:59:54 UTC 2021
     [    0.753604] kernel: usbcore: registered new interface driver usbfs
     [    0.753625] kernel: usbcore: registered new interface driver hub
     [    0.753651] kernel: usbcore: registered new device driver usb
     [    0.923828] kernel: usb usb1: New USB device found,
idVendor=3D1d6b, idProduct=3D0002, bcdDevice=3D 5.13
     [    0.923837] kernel: usb usb1: New USB device strings: Mfr=3D3,
Product=3D2, SerialNumber=3D1
     [    0.923841] kernel: usb usb1: Product: xHCI Host Controller
     [    0.923845] kernel: usb usb1: Manufacturer: Linux
5.13.8-200.fc34.x86_64 xhci-hcd
     [    0.923849] kernel: usb usb1: SerialNumber: 0000:00:14.0
     [    0.925806] kernel: usb usb2: New USB device found,
idVendor=3D1d6b, idProduct=3D0003, bcdDevice=3D 5.13
     [    0.925813] kernel: usb usb2: New USB device strings: Mfr=3D3,
Product=3D2, SerialNumber=3D1
     [    0.925818] kernel: usb usb2: Product: xHCI Host Controller
     [    0.925821] kernel: usb usb2: Manufacturer: Linux
5.13.8-200.fc34.x86_64 xhci-hcd
     [    0.925825] kernel: usb usb2: SerialNumber: 0000:00:14.0
     [    0.926388] kernel: usb: port power management may be unreliable
     [    0.927600] kernel: usbcore: registered new interface driver
usbserial_generic
     [    0.927615] kernel: usbserial: USB Serial support registered for ge=
neric
     [    0.942818] kernel: usbcore: registered new interface driver usbhid
     [    0.942821] kernel: usbhid: USB HID core driver
     [    1.166732] kernel: usb 1-2: new high-speed USB device number
2 using xhci_hcd
     [    1.294422] kernel: usb 1-2: New USB device found,
idVendor=3D1058, idProduct=3D1010, bcdDevice=3D 1.75
     [    1.294455] kernel: usb 1-2: New USB device strings: Mfr=3D1,
Product=3D2, SerialNumber=3D3
     [    1.294472] kernel: usb 1-2: Product: External HDD
     [    1.294485] kernel: usb 1-2: Manufacturer: Western Digital
     [    1.294496] kernel: usb 1-2: SerialNumber:
57442D575835314331303830303530
     [    1.410877] kernel: usb 1-3: new high-speed USB device number
3 using xhci_hcd
     [    1.559234] kernel: usb 1-3: New USB device found,
idVendor=3D04f2, idProduct=3Db52d, bcdDevice=3D40.60
     [    1.559270] kernel: usb 1-3: New USB device strings: Mfr=3D3,
Product=3D1, SerialNumber=3D2
     [    1.559287] kernel: usb 1-3: Product: HP Webcam
     [    1.559299] kernel: usb 1-3: Manufacturer: Chicony Electronics Co.,=
Ltd.
     [    1.559311] kernel: usb 1-3: SerialNumber: 0x0001
     [    1.676680] kernel: usb 1-4: new full-speed USB device number
4 using xhci_hcd
     [    1.703760] kernel: Btrfs loaded, crc32c=3Dcrc32c-generic, zoned=3D=
yes
     [    1.806356] kernel: usb 1-4: New USB device found,
idVendor=3D8087, idProduct=3D0a2a, bcdDevice=3D 0.01
     [    1.806391] kernel: usb 1-4: New USB device strings: Mfr=3D0,
Product=3D0, SerialNumber=3D0
     [    1.924871] kernel: usb 1-5: new low-speed USB device number 5
using xhci_hcd
     [    2.111027] kernel: usb 1-5: New USB device found,
idVendor=3D04d9, idProduct=3D2517, bcdDevice=3D 1.00
     [    2.111064] kernel: usb 1-5: New USB device strings: Mfr=3D0,
Product=3D0, SerialNumber=3D0
     [    2.184853] kernel: hid-generic 0003:04D9:2517.0001:
input,hidraw0: USB HID v1.10 Keyboard [HID 04d9:2517] on
usb-0000:00:14.0-5/input0
     [    2.255926] kernel: hid-generic 0003:04D9:2517.0002:
input,hidraw1: USB HID v1.10 Mouse [HID 04d9:2517] on
usb-0000:00:14.0-5/input1
     [    4.208452] kernel: sdhci: Secure Digital Host Controller
Interface driver
     [    4.208462] kernel: sdhci: Copyright(c) Pierre Ossman
     [    4.236791] kernel: mmc0: SDHCI controller on ACPI
[80860F14:00] using ADMA
     [    4.338803] kernel: mmc0: new HS200 MMC card at address 0001
     [    4.799086] kernel: mmcblk0: mmc0:0001 DF4032 29.1 GiB
     [    4.799295] kernel: mmcblk0boot0: mmc0:0001 DF4032 4.00 MiB
     [    4.799524] kernel: mmcblk0boot1: mmc0:0001 DF4032 4.00 MiB
     [    4.804869] kernel: mmcblk0rpmb: mmc0:0001 DF4032 4.00 MiB,
chardev (238:0)
     [    4.831813] kernel:  mmcblk0: p1 p2 p3
     [   29.899960] kernel: BTRFS: device label fedora_localhost-live
devid 1 transid 313642 /dev/dm-0 scanned by systemd-udevd (797)
     [   30.085084] kernel: BTRFS info (device dm-0): disk space
caching is enabled
     [   30.085096] kernel: BTRFS info (device dm-0): has skinny extents
     [   30.206581] kernel: BTRFS info (device dm-0): enabling ssd optimiza=
tions
     [   35.019332] kernel: BTRFS info (device dm-0): disk space
caching is enabled
     [   39.096878] kernel: usb-storage 1-2:1.0: USB Mass Storage
device detected
     [   39.111611] kernel: scsi host0: usb-storage 1-2:1.0
     [   39.111904] kernel: usbcore: registered new interface driver usb-st=
orage
     [   39.152292] kernel: usbcore: registered new interface driver uas
     [   39.473199] kernel: usbcore: registered new interface driver btusb
     [   39.733032] kernel: usb 1-3: Found UVC 1.00 device HP Webcam (04f2:=
b52d)
     [   39.735546] kernel: usb 1-3: Failed to query (GET_INFO) UVC
control 8 on unit 1: -32 (exp. 1).
     [   39.770751] kernel: usbcore: registered new interface driver uvcvid=
eo
     [   40.161659] kernel: scsi 0:0:0:0: Direct-Access     WD
5000BEV External 1.75 PQ: 0 ANSI: 4
     [   40.163286] kernel: sd 0:0:0:0: [sda] 976773168 512-byte
logical blocks: (500 GB/466 GiB)
     [   40.163430] kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
     [   40.163511] kernel: sd 0:0:0:0: [sda] Write Protect is off
     [   40.163522] kernel: sd 0:0:0:0: [sda] Mode Sense: 23 00 00 00
     [   40.163747] kernel: sd 0:0:0:0: [sda] No Caching mode page found
     [   40.163752] kernel: sd 0:0:0:0: [sda] Assuming drive cache:
write through
     [   40.171427] kernel:  sda: sda1
     [   40.177698] kernel: sd 0:0:0:0: [sda] Attached SCSI disk
     [   40.888130] kernel: BTRFS info (device dm-0): devid 1 device
path /dev/mapper/luks-4ac739d9-8d73-4913-89ac-656c79f89835 changed to
/dev/dm-0 scanned by systemd-udevd (967)
     [   40.964039] kernel: BTRFS info (device dm-0): devid 1 device
path /dev/dm-0 changed to
/dev/mapper/luks-4ac739d9-8d73-4913-89ac-656c79f89835 scanned by
systemd-udevd (967)
     [ 1542.640987] kernel: usb 1-2: USB disconnect, device number 2

* btrfs usage (btrfs filesystem usage -T /):
     Overall:
         Device size:          27.52GiB
         Device allocated:          27.52GiB
         Device unallocated:           1.00MiB
         Device missing:          27.52GiB
         Used:              21.03GiB
         Free (estimated):           6.42GiB    (min: 6.42GiB)
         Free (statfs, df):           6.42GiB
         Data ratio:                  1.00
         Metadata ratio:              1.00
         Global reserve:          57.03MiB    (used: 0.00B)
         Multiple profiles:                no

                                                              Data
Metadata  System
     Id Path                                                  single
single    single   Unallocated
     -- ----------------------------------------------------- --------
--------- -------- -----------
      1 /dev/mapper/luks-4ac739d9-8d73-4913-89ac-656c79f89835        -
        -        -       0.00B
     -- ----------------------------------------------------- --------
--------- -------- -----------
        Total                                                 27.00GiB
520.00MiB  4.00MiB       0.00B
        Used                                                  20.58GiB
457.53MiB 16.00KiB

* FSUUID (findmnt -n -o UUID $(stat -c '%m' "/")):
     0929fd70-d300-4da7-93bf-ff6d0b3a1406

* btrfs allocations (FSUUID=3D$(findmnt -n -o UUID $(stat -c '%m' "/"));
grep -R . /sys/fs/btrfs/"$FSUUID"/allocation/ | sed
"s/^.*allocation//"):
     /metadata/disk_used:479756288
     /metadata/bytes_pinned:393216
     /metadata/bytes_used:479756288
     /metadata/single/used_bytes:479756288
     /metadata/single/total_bytes:545259520
     /metadata/total_bytes_pinned:393216
     /metadata/disk_total:545259520
     /metadata/total_bytes:545259520
     /metadata/bytes_reserved:0
     /metadata/bytes_readonly:0
     /metadata/bytes_zone_unusable:0
     /metadata/bytes_may_use:60588032
     /metadata/flags:4
     /system/disk_used:16384
     /system/bytes_pinned:0
     /system/bytes_used:16384
     /system/single/used_bytes:16384
     /system/single/total_bytes:4194304
     /system/total_bytes_pinned:0
     /system/disk_total:4194304
     /system/total_bytes:4194304
     /system/bytes_reserved:0
     /system/bytes_readonly:0
     /system/bytes_zone_unusable:0
     /system/bytes_may_use:0
     /system/flags:2
     /global_rsv_reserved:59801600
     /data/disk_used:22102777856
     /data/bytes_pinned:8192
     /data/bytes_used:22102777856
     /data/single/used_bytes:22102777856
     /data/single/total_bytes:28996272128
     /data/total_bytes_pinned:8192
     /data/disk_total:28996272128
     /data/total_bytes:28996272128
     /data/bytes_reserved:0
     /data/bytes_readonly:65536
     /data/bytes_zone_unusable:0
     /data/bytes_may_use:0
     /data/flags:1
     /global_rsv_size:59801600

* btrfs features (FSUUID=3D$(findmnt -n -o UUID $(stat -c '%m' "/"));
grep -R . /sys/fs/btrfs/"$FSUUID"/features/ | sed "s/^.*features//"):
     /mixed_backref:1
     /big_metadata:1
     /skinny_metadata:1
     /extended_iref:1

* btrfs checksum (FSUUID=3D$(findmnt -n -o UUID $(stat -c '%m' "/"));
cat /sys/fs/btrfs/"$FSUUID"/checksum):
     crc32c (crc32c-intel)



>>note that          Device missing:          27.52GiB  is bogus. Filed htt=
ps://github.com/kdave/btrfs-progs/issues/395


btrfs balance start -dlimit=3D1 /   also fails but with kernel messages


[ 2631.911822] BTRFS info (device dm-0): balance: start -dusage=3D1
[ 2631.911903] BTRFS info (device dm-0): balance: ended with status: 0
[ 2728.028923] BTRFS info (device dm-0): balance: start -dusage=3D5
[ 2728.028985] BTRFS info (device dm-0): balance: ended with status: 0
[ 2757.173044] BTRFS info (device dm-0): balance: start -dlimit=3D1
[ 2757.182662] BTRFS info (device dm-0): relocating block group
28476178432 flags data
[ 2757.703239] BTRFS info (device dm-0): 1 enospc errors during balance
[ 2757.703253] BTRFS info (device dm-0): balance: ended with status: -28




--=20
Chris Murphy
