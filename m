Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E712BA603
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Nov 2020 10:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgKTJYa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Nov 2020 04:24:30 -0500
Received: from mail-03.mail-europe.com ([91.134.188.129]:46288 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKTJY2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Nov 2020 04:24:28 -0500
Date:   Fri, 20 Nov 2020 09:24:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1605864263; bh=vT1ikwb1BhIU5yV9Pdd11DnAfuR0ANSdOaBOsDacNS4=;
        h=Date:To:From:Reply-To:Subject:From;
        b=fqwzy45Z3Di3w5Q0q2P2q3W/fH3L2OemfCf3jXF4CVNt3JuTsQugRzp1pl+pn2NH4
         zhWlcpen8HmEiu9R4VnPcOm2tZzEd8RgY5+p7i/panrssgOu5WAUQwpi2kB4ZltauD
         naGr5jLxEQwiZPYH0E/FIFTqjzUwfQfGeM2FE1aCAFZ436s+wngk8RzUbK78A1EsRW
         rzawKcJO5h7pKKBf5bhkcaZL4ecFVmYmYvnWcvz3Lb17PbuE+K/TfKABs5Yfh7zteF
         wmyIY0h0EafHglLIxy4iVN/VnWV22yn8GTH5R4PpPXEwzFQlMbYAPM3eoEckYrHq7M
         LL11b/6FQIFVw==
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Kristupas Savickas <kristupas.savickas@pm.me>
Reply-To: Kristupas Savickas <kristupas.savickas@pm.me>
Subject: Not enough space during conversion to raid5, filesystem fails to mount as RW
Message-ID: <bzvIMgcJHYGZvBm4xa7bCl_20ql_b3sZtJ6zxcAVyw7eZ8jQYpRFCukGBshxLFF4cRJ-vwdkZgj7GkbqF8o9tKt25RU3xiz_ikIaejDuH90=@pm.me>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="---------------------5ea502b9041eff3302893c97526aebf7"; charset=utf-8
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
-----------------------5ea502b9041eff3302893c97526aebf7
Content-Type: multipart/mixed;boundary=---------------------7a9de01c3df804b1ef425d6972db5d97

-----------------------7a9de01c3df804b1ef425d6972db5d97
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hello,

I tried to convert my (nearly full) file system to raid5. The fs originall=
y contained 3 8TB disks.
After adding the forth disk I ran:
    # btrfs balance start -dconvert=3Draid5,soft -mconvert=3Draid5,soft -s=
convert=3Draid5,soft -b /mnt/

However, it looks like the conversion failed and the fs was left in RO sta=
te, with only part of the data being converted to raid5:

    # btrfs fi show /dev/sdc
    Label: 'array'  uuid: 6e95de0a-4b51-4aab-b935-469626c83036
            Total devices 4 FS bytes used 21.52TiB
            devid    1 size 7.28TiB used 7.28TiB path /dev/sdc
            devid    2 size 7.28TiB used 7.28TiB path /dev/sdd
            devid    3 size 7.28TiB used 7.28TiB path /dev/sda
            devid    4 size 7.28TiB used 7.28TiB path /dev/sdb

    # mount /dev/sdc /mnt/
    # mount | grep /mnt
    /dev/sdc on /mnt type btrfs (ro,relatime,space_cache,subvolid=3D5,subv=
ol=3D/)

    # btrfs fi df /mnt
    Data, single: total=3D14.22TiB, used=3D14.06TiB
    Data, RAID5: total=3D7.44TiB, used=3D7.43TiB
    System, RAID1: total=3D32.00MiB, used=3D2.47MiB
    System, RAID5: total=3D32.00MiB, used=3D128.00KiB
    Metadata, RAID1: total=3D13.00GiB, used=3D11.67GiB
    Metadata, RAID5: total=3D12.00GiB, used=3D11.90GiB
    GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
    WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
    WARNING:   Data: single, raid5
    WARNING:   Metadata: raid1, raid5
    WARNING:   System: raid1, raid5

    # dmesg
    [65134.312783] BTRFS info (device sdc): disk space caching is enabled
    [65134.312784] BTRFS info (device sdc): has skinny extents
    [65136.207839] BTRFS info (device sdc): bdev /dev/sdd errs: wr 0, rd 4=
, flush 0, corrupt 0, gen 0
    [65172.993492] BTRFS alert (device sdc): btrfs RAID5/6 is EXPERIMENTAL=
 and has known data-loss bugs
    [65204.813036] BTRFS info (device sdc): checking UUID tree
    [65211.733565] ------------[ cut here ]------------
    [65211.733567] BTRFS: Transaction aborted (error -28)
    [65211.733583] BTRFS: error (device sdc) in __btrfs_free_extent:3069: =
errno=3D-28 No space left
    [65211.733629] WARNING: CPU: 2 PID: 19980 at fs/btrfs/extent-tree.c:30=
69 __btrfs_free_extent.isra.0+0x57e/0x8f0 [btrfs]
    [65211.735427] BTRFS info (device sdc): forced readonly
    [65211.735427] Modules linked in: xt_recent fuse ufs
    [65211.735430] BTRFS: error (device sdc) in btrfs_run_delayed_refs:217=
3: errno=3D-28 No space left
    [65211.735431]  qnx4 hfsplus hfs cdrom minix msdos jfs xfs dm_mod uas =
usb_storage xt_nat veth xt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm_=
algo nft_chain_nat nf_nat br_netfilter bridge stp llc overlay hid_logitech=
_hidpp joydev hid_logitech_dj hid_generic usbhid hid amdgpu edac_mce_amd k=
vm_amd kvm irqbypass ip6t_REJECT nf_reject_ipv6 xt_hl ip6_tables ghash_clm=
ulni_intel nls_ascii nls_cp437 ppdev snd_hda_codec_realtek snd_hda_codec_g=
eneric ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg ip6=
t_rt snd_hda_codec vfat fat gpu_sched snd_hda_core ttm snd_hwdep ipt_REJEC=
T nf_reject_ipv4 efi_pstore aesni_intel xt_comment wmi_bmof libaes crypto_=
simd cryptd snd_pcm xt_multiport glue_helper rapl drm_kms_helper ccp snd_t=
imer sp5100_tco efivars pcspkr k10temp watchdog nft_limit snd cec rng_core=
 soundcore i2c_algo_bit sg parport_pc parport evdev xt_limit xt_addrtype x=
t_tcpudp acpi_cpufreq button xt_conntrack nf_conntrack nf_defrag_ipv6 nf_d=
efrag_ipv4 nft_compat nft_counter nf_tables
    [65211.735467]  nfnetlink drm efivarfs ip_tables x_tables autofs4 ext4=
 crc16 mbcache jbd2 btrfs blake2b_generic xor zstd_compress raid6_pq libcr=
c32c crc32c_generic sd_mod nvme nvme_core crc32_pclmul t10_pi ahci libahci=
 r8169 realtek mdio_devres crc_t10dif libphy i2c_piix4 crct10dif_generic l=
ibata crc32c_intel xhci_pci xhci_hcd usbcore scsi_mod crct10dif_pclmul crc=
t10dif_common usb_common wmi video gpio_amdpt gpio_generic
    [65211.737278] CPU: 2 PID: 19980 Comm: btrfs-transacti Tainted: G     =
   W      X  5.9.0-1-amd64 #1 Debian 5.9.1-1
    [65211.737280] BTRFS info (device sdc): balance: resume -dconvert=3Dra=
id5,soft -mconvert=3Draid5,soft -sconvert=3Draid5,soft
    [65211.737281] Hardware name: Gigabyte Technology Co., Ltd. AB350M-D3H=
/AB350M-D3H-CF, BIOS F51c 07/02/2020
    [65211.737300] RIP: 0010:__btrfs_free_extent.isra.0+0x57e/0x8f0 [btrfs=
]
    [65211.737302] Code: 24 0c ba 5b 0c 00 00 48 c7 c6 40 01 5d c0 4c 89 f=
7 e8 12 c2 0a 00 e9 b1 fe ff ff 44 89 e6 48 c7 c7 80 a5 5d c0 e8 98 c5 16 =
d1 <0f> 0b 44 89 e1 ba fd 0b 00 00 48 c7 c6 40 01 5d c0 4c 89 f7 e8 e5
    [65211.737303] RSP: 0018:ffffa398c192bc50 EFLAGS: 00010282
    [65211.737305] RAX: 0000000000000000 RBX: 000026d0f54f8000 RCX: ffff96=
9590898ac8
    [65211.737305] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff96=
9590898ac0
    [65211.737306] RBP: 0000259405cbd000 R08: 0000000000000995 R09: 000000=
0000000004
    [65211.737307] R10: 0000000000000000 R11: 0000000000000001 R12: 000000=
00ffffffe4
    [65211.737308] R13: ffff96955d4f0310 R14: ffff9692ab751d00 R15: 000000=
0000000005
    [65211.737309] FS:  0000000000000000(0000) GS:ffff969590880000(0000) k=
nlGS:0000000000000000
    [65211.737310] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [65211.737311] CR2: 000055ff8d180cb0 CR3: 00000003b621a000 CR4: 000000=
00003506e0
    [65211.737312] Call Trace:
    [65211.737333]  ? __btrfs_run_delayed_refs+0xfd3/0x1060 [btrfs]
    [65211.737351]  __btrfs_run_delayed_refs+0x27a/0x1060 [btrfs]
    [65211.737371]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
    [65211.737391]  btrfs_commit_transaction+0x57/0xa30 [btrfs]
    [65211.737411]  ? start_transaction+0xd2/0x540 [btrfs]
    [65211.737415]  ? try_to_wake_up+0x130/0x5e0
    [65211.737434]  transaction_kthread+0x14c/0x170 [btrfs]
    [65211.737453]  ? btrfs_cleanup_transaction.isra.0+0x5a0/0x5a0 [btrfs]
    [65211.737455]  kthread+0x11b/0x140
    [65211.737457]  ? __kthread_bind_mask+0x60/0x60
    [65211.737460]  ret_from_fork+0x22/0x30
    [65211.737462] ---[ end trace 2f4a1b25242944de ]---
    [65211.737463] BTRFS: error (device sdc) in __btrfs_free_extent:3069: =
errno=3D-28 No space left
    [65211.738722] BTRFS: error (device sdc) in btrfs_run_delayed_refs:217=
3: errno=3D-28 No space left
    [65211.748466] BTRFS info (device sdc): balance: ended with status: -3=
0

Looking at the dmesg output, I see:
    [65211.737280] BTRFS info (device sdc): balance: resume -dconvert=3Dra=
id5,soft -mconvert=3Draid5,soft -sconvert=3Draid5,soft

This indicates that the balance is ran again after remounting. Looking at =
the last line it says that:
    [65211.748466] BTRFS info (device sdc): balance: ended with status: -3=
0

I suppose this is what causes the fs to be mounted read only.

Trying to remount the system as RW results in:
    [68268.865313] BTRFS info (device sdc): disk space caching is enabled
    [68268.865316] BTRFS error (device sdc): Remounting read-write after e=
rror is not allowed

My question is how can I recover from a situation like this?
I could definitely reduce the file system usage if I could mount it as RW,=
 but
the balance is ran immediately after mounting and fails, which results in =
a RO mount.
Would it be possible to cancel the balance, so it doesn't run on mounting?

Additional information:
    # uname -a
    Linux s 5.9.0-1-amd64 #1 SMP Debian 5.9.1-1 (2020-10-17) x86_64 GNU/Li=
nux

    # btrfs --version
    btrfs-progs v5.9
-----------------------7a9de01c3df804b1ef425d6972db5d97--

-----------------------5ea502b9041eff3302893c97526aebf7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJft4tBACEJEFYJ8uTX7lJXFiEEYbJhISHEF6hbwUgsVgny
5NfuUlenkgf+I1g4ZGyUWC/P+W44jRlbySsaULRjcmxMK03LhZjTajtYgceQ
EZ/EGQdIB74PclWP5CPUd5gnCtdrr591VCsal7idGDYu1x6vhhvtyjtlkCMS
66adhkO+wSjzmlgfoVlKKCaxYIUdijIq1pOZ5EwX7FH4YnnfwY3kGs9nvofp
tfiSagr5PUyoLyEmCRnUu+WEW23a2OCAMilLcDCULkYnKli4lg9rSalbi6VF
FpqR1I+Imt5dH0uKOGdGJ2qPoZbatD/FHQRqa/Qbl5t21Q9pXvLOkLaQhFDl
HKz4hNdX1xatFZC+qe+7lszGPdyw/Ziw7WSQDeTRUARXYNklJCUd3A==
=iRJZ
-----END PGP SIGNATURE-----


-----------------------5ea502b9041eff3302893c97526aebf7--

