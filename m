Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFF07BE086
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 16:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfIYOuH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 10:50:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42858 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfIYOuH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 10:50:07 -0400
Received: by mail-io1-f67.google.com with SMTP id n197so14507493iod.9
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 07:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pallissard.net; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=AAWZuC2IsrVAnuX9dlXXAIKuUPu86S/V5KE4kmPvTZo=;
        b=FC0n5670p5zRC5KdBGK0Jb9JFhCL3u6gvBnrxAEZNPoWcrjN8OLUzEudyBzbJKfCG9
         v6Shtmv20EOtKJahki6eNdXqVRHGNIPPt0v2IIFtW5uNg2QJilX91UUYJuQsDDLf6FeM
         CbE9pH0xX0TFs07i1+KE6qKzZWJKE9jdk+lSZXTVAT+tsC5cQLVOn4Qqwueonp7vVpAi
         qVqgEdPOEfMaQ2MWMgxez2jyyCdNxHc1JiTvRXR1THaeHPuuCgNED3CrBmpvRpufg7F8
         g0fZ/v3RoMt2P4H0j7r7cdy78sEkxUCS2KmJ8Ik5mDyg6ABMF/v5QMZUKH35exZNuD2D
         E0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=AAWZuC2IsrVAnuX9dlXXAIKuUPu86S/V5KE4kmPvTZo=;
        b=VKFL5shZUK+c7LZzZMaCLT72KRjsVoPmPvmGre3+7kWE1WHJhRUuTqLYInCAYiHYHL
         QkbpFuozNytxBCtb7Q1BJfGbp6mRVo0E7wyQ72hO5A3N2Fr0KiE8u/0qAAY1V5T8AKcD
         6QS8Y7vLS8qrkNspsMWhl7/HilehjpDON7eQNq5tTYPusapjKII3J7MOSeFmKoMosinz
         HHT3Di4ZeocTMdHgwVDOZbepwL6GGeaHklEusdfUqYTBBmrlAMvc7LSobTo8X/hoe19T
         LpHc6aOY89UDqdvGeZGiTXOlHUVlZ2EtM3+yvV82w3sRh5CkuCZzv7qt794xzzl3Q777
         HhtA==
X-Gm-Message-State: APjAAAVUKzWeV5mEX4d2GFKIYUultgUBCx90G9XUQo6bt5G9tGNi/o7b
        2DbRUmTmlyOKsw7nsjYo9H33+7VkddM=
X-Google-Smtp-Source: APXvYqyA02yBVJWvocq5rqvfeP2j6BwKBKQ1R7KL/jNtsQX7QKAxtSL1n1lGqfvoO8f+W7TOg6YhbQ==
X-Received: by 2002:a92:9e86:: with SMTP id s6mr867347ilk.83.1569423004958;
        Wed, 25 Sep 2019 07:50:04 -0700 (PDT)
Received: from mail.matt.pallissard.net (149.174.239.35.bc.googleusercontent.com. [35.239.174.149])
        by smtp.gmail.com with ESMTPSA id y5sm4338660iol.75.2019.09.25.07.50.03
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 07:50:04 -0700 (PDT)
Date:   Wed, 25 Sep 2019 07:50:00 -0700
From:   "Pallissard, Matthew" <matt@pallissard.net>
To:     linux-btrfs@vger.kernel.org
Subject: errors found in extent allocation tree or chunk allocation after
 power failure
Message-ID: <20190925144959.p4xyyhn2d2sajxjj@matt-laptop-p01>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r7nlph6o5p5f55gf"
Content-Disposition: inline
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--r7nlph6o5p5f55gf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hey all,

tl;dr Had a power failure while executing snapshot operations on a 6 drive =
HDD raid-10 configuration. I now have errors.  I'm willing to let this arra=
y be a guinea pig.


Not-quite-ancient hardware running in a basement lab. Dell R710, 6 HDDs.  I=
t acts as a hypervisor; as such the files on disk are few, but large.
Mostly qcow2, a few raw images, and the xml that describes the vms.  The vm=
 images range from ~20GB to ~1TB.

I had two snapshots from June of 2019 I was cleaning up.  After the deletio=
ns I went to take a fresh snapshot.  I ran the commands in immediate succes=
sion.
After the deletions, while the snapshot command was running the decade+ old=
 UPS decided to fail.  Order of operations is as follows.

1. snapshot delete old0
2. snapshot delete old1
3. snapshot new
[power failure]
4. btrfsfck
5. btrfs balance
6. btrfs del new
7. btrfsck (same errors show as #4)


I can mount the filesystem.  I have backups, but am attempting one more at =
the moment.
I plan on running a balance again after the backup completes. Unless of cou=
rse someone here tells me differently.
I'm willing to perform any potentially destructive operations if any devs h=
ere would find it helpful.


Version:
Kernel: 5.2.2-arch1-1-ARCH #1 SMP PREEMPT Sun Jul 21 19:18:34 UTC 2019 x86_=
64 GNU/Linux
Btrfs version: btrfs-progs v5.2

Info:

Sorry, I didn't run the commands specified on the list wiki verbatim.  I ca=
ptured this info before double checking that.  I can go back later and gath=
er additional info if need be.

1. There are 6 spinning rust drives
2. Each drive is passed through a perc raid controller individually
3. Each drive is a luks volume
4. Btrfs exists on each device-mapped luks volume
6. There are no device errors
6. There is one stacktrace in dmesg that happened during the balance.
  6a. I have not seen a hung task timeout on this array before.  I also hav=
en't done many intensive I/O operations.
  6b. That's not to say it hasn't happened without me missing it.


> Overall:
>     Device size:                   5.45TiB
>     Device allocated:              3.30TiB
>     Device unallocated:            2.15TiB
>     Device missing:                  0.00B
>     Used:                          3.22TiB
>     Free (estimated):              1.12TiB      (min: 1.12TiB)
>     Data ratio:                       2.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>
> Data,RAID10: Size:1.65TiB, Used:1.61TiB
>    /dev/mapper/luks-a    562.00GiB
>    /dev/mapper/luks-b    562.00GiB
>    /dev/mapper/luks-c    562.00GiB
>    /dev/mapper/luks-d    562.00GiB
>    /dev/mapper/luks-e    562.00GiB
>    /dev/mapper/luks-f    562.00GiB
>
> Metadata,RAID10: Size:4.03GiB, Used:2.24GiB
>    /dev/mapper/luks-a      1.34GiB
>    /dev/mapper/luks-b      1.34GiB
>    /dev/mapper/luks-c      1.34GiB
>    /dev/mapper/luks-d      1.34GiB
>    /dev/mapper/luks-e      1.34GiB
>    /dev/mapper/luks-f      1.34GiB
>
> System,RAID10: Size:7.88MiB, Used:224.00KiB
>    /dev/mapper/luks-a      2.62MiB
>    /dev/mapper/luks-b      2.62MiB
>    /dev/mapper/luks-c      2.62MiB
>    /dev/mapper/luks-d      2.62MiB
>    /dev/mapper/luks-e      2.62MiB
>    /dev/mapper/luks-f      2.62MiB
>
> Unallocated:
>    /dev/mapper/luks-a    367.65GiB
>    /dev/mapper/luks-b    367.65GiB
>    /dev/mapper/luks-c    367.65GiB
>    /dev/mapper/luks-d    367.65GiB
>    /dev/mapper/luks-e    367.65GiB
>    /dev/mapper/luks-f    367.65GiB


Error:
btrfsck output
> btrfsck /dev/mapper/luks-a

> Opening filesystem to check...
> Checking filesystem on /dev/mapper/luks-a
> UUID: 1f562f3d-5ba4-4bae-9099-2a4eb836e7f8
> [1/7] checking root items
> [2/7] checking extents
> ref mismatch on [1453984899072 524288] extent item 0, found 1
> data backref 1453984899072 root 5 owner 1468 offset 1910132736 num_refs 0=
 not found in extent tree
> incorrect local backref count on 1453984899072 root 5 owner 1468 offset 1=
910132736 found 1 wanted 0 back 0x556ab4725490
> backpointer mismatch on [1453984899072 524288]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> [4/7] checking fs roots
> root 5 inode 271 errors 2000, link count wrong
>         unresolved ref dir 261 index 4 namelen 22 name mirror-nginx-p01.q=
cow2 filetype 1 errors 0
> root 5 inode 272 errors 2000, link count wrong
>         unresolved ref dir 261 index 5 namelen 18 name bind-dns-p01.qcow2=
 filetype 1 errors 0
> root 5 inode 273 errors 2000, link count wrong
>         unresolved ref dir 261 index 6 namelen 18 name ovpn-vpn-p01.qcow2=
 filetype 1 errors 0
> root 5 inode 321 errors 2000, link count wrong
>         unresolved ref dir 261 index 7 namelen 18 name isc-dhcp-p01.qcow2=
 filetype 1 errors 0
> root 5 inode 425 errors 2000, link count wrong
>         unresolved ref dir 261 index 8 namelen 18 name afs-file-p01.qcow2=
 filetype 1 errors 0
> root 5 inode 564 errors 2000, link count wrong
>         unresolved ref dir 277 index 2 namelen 20 name plex-nginx-p01.qco=
w2 filetype 1 errors 0
> root 5 inode 607 errors 2000, link count wrong
>         unresolved ref dir 277 index 3 namelen 19 name linux-rtr-p01.qcow=
2 filetype 1 errors 0
> root 5 inode 1340 errors 2000, link count wrong
>         unresolved ref dir 261 index 106 namelen 17 name gen-nfs-p01.qcow=
2 filetype 1 errors 0
> root 5 inode 1453 errors 2000, link count wrong
>         unresolved ref dir 261 index 115 namelen 23 name gen-kube-cont-p0=
3.qcow2 filetype 1 errors 0
> root 5 inode 1454 errors 2000, link count wrong
>         unresolved ref dir 261 index 116 namelen 25 name gen-master-cont-=
p01.qcow2 filetype 1 errors 0
> root 5 inode 1455 errors 2000, link count wrong
>         unresolved ref dir 261 index 117 namelen 23 name gen-kube-cont-p0=
4.qcow2 filetype 1 errors 0
> root 5 inode 1458 errors 2000, link count wrong
>         unresolved ref dir 261 index 118 namelen 23 name gen-kube-cont-p0=
1.qcow2 filetype 1 errors 0
> root 5 inode 1468 errors 3000, some csum missing, link count wrong
>         unresolved ref dir 261 index 119 namelen 23 name gen-kube-cont-p0=
2.qcow2 filetype 1 errors 0
> root 5 inode 1499 errors 2000, link count wrong
>         unresolved ref dir 261 index 120 namelen 22 name gen-nfs-p01-nfs0=
=2Eqcow2 filetype 1 errors 0
> root 5 inode 2456 errors 2100, file extent discount, link count wrong
> Found file extent holes:
>         start: 0, len: 7612334080
>         unresolved ref dir 261 index 131 namelen 27 name infra-vol-gluste=
r-p01.qcow2 filetype 1 errors 0
> root 5 inode 2474 errors 2000, link count wrong
>         unresolved ref dir 261 index 133 namelen 31 name matt-headless-de=
sktop-p01.qcow2 filetype 1 errors 0
> ERROR: errors found in fs roots
> found 1769310683136 bytes used, error(s) found
> total csum bytes: 990772952
> total tree bytes: 2456469504
> total fs tree bytes: 601128960
> total extent tree bytes: 614989824
> btree space waste bytes: 430394740
> file data blocks allocated: 19047078367232
>  referenced 1549807284224


Here is the output of;
> dmesg --ctime | grep -v audit | grep -i -B 10 -A 10 btrfs

I took the liberty of removing all of the duplicate messages, unrelated dev=
ice enumeration at boot, audit logs, etc.
NOTE: I did snap in a usb drive and ran mkfs on it to caputure the output. =
(I think I trimmed that all out successfully)

> [   73.164024] cryptd: max_cpu_qlen set to 1000
> [   73.538329] BTRFS: device fsid 1f562f3d-5ba4-4bae-9099-2a4eb836e7f8 de=
vid 1 transid 8156599 /dev/dm-0
> [   75.318334] BTRFS: device fsid 1f562f3d-5ba4-4bae-9099-2a4eb836e7f8 de=
vid 2 transid 8156599 /dev/dm-1
> [   77.076659] BTRFS: device fsid 1f562f3d-5ba4-4bae-9099-2a4eb836e7f8 de=
vid 3 transid 8156599 /dev/dm-2
> [   78.892821] BTRFS: device fsid 1f562f3d-5ba4-4bae-9099-2a4eb836e7f8 de=
vid 4 transid 8156599 /dev/dm-3
> [   80.701286] BTRFS: device fsid 1f562f3d-5ba4-4bae-9099-2a4eb836e7f8 de=
vid 5 transid 8156599 /dev/dm-4
> [   82.568686] BTRFS: device fsid 1f562f3d-5ba4-4bae-9099-2a4eb836e7f8 de=
vid 6 transid 8156599 /dev/dm-5
> [   82.922537] BTRFS info (device dm-0): disk space caching is enabled
> [   82.922541] BTRFS info (device dm-0): has skinny extents
> [  184.375844] BTRFS: error (device dm-0) in btrfs_replay_log:2302: errno=
=3D-22 unknown (Failed to recover log tree)
> [  188.832121] BTRFS error (device dm-0): open_ctree failed
> [ 1223.523145] BTRFS info (device dm-0): allowing degraded mounts
> [ 1223.523148] BTRFS info (device dm-0): disk space caching is enabled
> [ 1223.523150] BTRFS info (device dm-0): has skinny extents
> [ 1228.714934] BTRFS info (device dm-0): checking UUID tree
> [ 1257.835784] BTRFS error (device dm-0): csum mismatch on free space cac=
he
> [ 1257.836801] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 534753705984, rebuilding it now
> [ 1260.892300] BTRFS error (device dm-0): csum mismatch on free space cac=
he
> [ 1260.893284] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 1171751043072, rebuilding it now
> [ 1261.543959] BTRFS error (device dm-0): csum mismatch on free space cac=
he
> [ 1261.544959] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 1258724130816, rebuilding it now
> [ 1261.712144] BTRFS error (device dm-0): csum mismatch on free space cac=
he
> [ 1261.712152] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 1281272709120, rebuilding it now
> [ 1262.083594] BTRFS error (device dm-0): csum mismatch on free space cac=
he
> [ 1262.084552] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 1329591091200, rebuilding it now
> [ 1262.091133] BTRFS error (device dm-0): csum mismatch on free space cac=
he
> [ 1262.092086] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 1332812316672, rebuilding it now
> [ 1262.137185] BTRFS error (device dm-0): csum mismatch on free space cac=
he
> [ 1262.138036] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 1339254767616, rebuilding it now
> [ 1262.143510] BTRFS error (device dm-0): csum mismatch on free space cac=
he
> [ 1262.144370] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 1342475993088, rebuilding it now
> [ 1262.159166] BTRFS error (device dm-0): csum mismatch on free space cac=
he
> [ 1262.160013] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 1345697218560, rebuilding it now
> [ 1262.164526] BTRFS error (device dm-0): csum mismatch on free space cac=
he
> [ 1262.165401] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 1348918444032, rebuilding it now
> [ 1262.178524] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 1352139669504, rebuilding it now
> [ 1262.194532] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 1355360894976, rebuilding it now
> [ 1262.210247] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 1358582120448, rebuilding it now
> [ 1262.217203] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 1361803345920, rebuilding it now
> [ 1262.226936] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 1365024571392, rebuilding it now
> [ 1262.283055] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 1371467022336, rebuilding it now
> [ 1262.300303] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 1374688247808, rebuilding it now
> [ 1263.555486] io_ctl_check_crc: 7 callbacks suppressed
> [ 1263.555489] BTRFS error (device dm-0): csum mismatch on free space cac=
he
> [ 1263.556515] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 1825659813888, rebuilding it now
> [ 1264.241637] BTRFS info (device dm-0): balance: start -d -m -s
> [ 1264.242432] BTRFS info (device dm-0): relocating block group 253221548=
8512 flags data|raid10
> [ 1600.754725] BTRFS error (device dm-0): csum mismatch on free space cac=
he
> [ 1600.755753] BTRFS warning (device dm-0): failed to load free space cac=
he for block group 1474546237440, rebuilding it now


these repeat a lot

> [ 1638.059938] BTRFS info (device dm-0): found 911 extents
> [ 1648.389965] BTRFS info (device dm-0): found 911 extents
> [ 1648.764284] BTRFS info (device dm-0): relocating block group 252899426=
3040 flags data|raid10

end repeat


> [ 9127.793658] WARNING: CPU: 9 PID: 1294 at fs/btrfs/extent-tree.c:1573 l=
ookup_inline_extent_backref+0x5fd/0x640 [btrfs]


looks like my array took too long here

> [ 9127.793660] Modules linked in: dm_crypt crypto_simd cryptd glue_helper=
 aes_x86_64 algif_skcipher af_alg dm_mod fuse openafs(POE) 8021q garp mrp b=
ridge stp llc bonding xt_tcpudp xt_state xt_conntrack iptable_filter xt_com=
ment xt_MASQUERADE iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag=
_ipv4 msr iptable_mangle nls_iso8859_1 nls_cp437 vfat fat ipmi_ssif mgag200=
 intel_powerclamp i2c_algo_bit ttm coretemp kvm_intel drm_kms_helper drm kv=
m irqbypass agpgart syscopyarea sysfillrect intel_cstate sysimgblt intel_un=
core fb_sys_fops ipmi_si iTCO_wdt bnx2 iTCO_vendor_support gpio_ich tpm_tis=
 tpm_tis_core ipmi_devintf input_leds mousedev joydev lpc_ich ipmi_msghandl=
er i7core_edac tpm evdev dcdbas rng_core pcspkr mac_hid acpi_power_meter sg=
 ip_tables x_tables btrfs libcrc32c crc32c_generic xor raid6_pq hid_generic=
 ses enclosure ata_generic sd_mod scsi_transport_sas pata_acpi usbhid hid u=
as usb_storage uhci_hcd ata_piix libata megaraid_sas crc32c_intel scsi_mod =
ehci_pci ehci_hcd
> [ 9127.793700] CPU: 9 PID: 1294 Comm: btrfs Tainted: P          IOE     5=
=2E2.2-arch1-1-ARCH #1
> [ 9127.793701] Hardware name: Dell Inc. PowerEdge R710/0YDJK3, BIOS 6.1.0=
 10/18/2011
> [ 9127.793718] RIP: 0010:lookup_inline_extent_backref+0x5fd/0x640 [btrfs]
> [ 9127.793720] Code: 8d 8d 8f 00 00 00 4c 39 ce 0f 83 64 fd ff ff 0f 0b 4=
c 8b 64 24 38 b8 8b ff ff ff e9 c9 fb ff ff 49 89 dc 31 db e9 c1 fc ff ff <=
0f> 0b b8 fb ff ff ff e9 b3 fb ff ff 80 7c 24 5e bf 0f 87 81 fe ff
> [ 9127.793721] RSP: 0018:ffffadd4c7bef710 EFLAGS: 00010202
> [ 9127.793723] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 000000000=
0000000
> [ 9127.793723] RDX: 0000000000000001 RSI: ffffa2bfd043a540 RDI: ffffa2bf5=
d34a318
> [ 9127.793724] RBP: 0000000000080000 R08: 0000000000000000 R09: 000000000=
0000001
> [ 9127.793725] R10: 0000000000000045 R11: ffffa2bb00000000 R12: ffffa2bfd=
043a540
> [ 9127.793726] R13: ffffa2c160ef2958 R14: 000000000000000d R15: ffffa2c16=
40b9000
> [ 9127.793727] FS:  00007f7202fa58c0(0000) GS:ffffa2c167b00000(0000) knlG=
S:0000000000000000
> [ 9127.793728] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 9127.793729] CR2: 000055768cb67552 CR3: 0000000c3c638000 CR4: 000000000=
00006e0
> [ 9127.793730] Call Trace:
> [ 9127.793752]  insert_inline_extent_backref+0x5a/0xe0 [btrfs]
> [ 9127.793768]  __btrfs_inc_extent_ref.isra.0+0xa0/0x2a0 [btrfs]
> [ 9127.793773]  ? _raw_spin_unlock+0x16/0x30
> [ 9127.793790]  __btrfs_run_delayed_refs+0x886/0x1080 [btrfs]
> [ 9127.793809]  btrfs_run_delayed_refs.part.0+0x4e/0x160 [btrfs]
> [ 9127.793828]  btrfs_commit_transaction+0xaa/0x980 [btrfs]
> [ 9127.793851]  prepare_to_merge+0x200/0x230 [btrfs]
> [ 9127.793873]  relocate_block_group+0x38c/0x620 [btrfs]
> [ 9127.793896]  btrfs_relocate_block_group+0x156/0x2f0 [btrfs]
> [ 9127.793917]  btrfs_relocate_chunk+0x31/0xa0 [btrfs]
> [ 9127.793938]  btrfs_balance+0x71a/0xee0 [btrfs]
> [ 9127.793961]  btrfs_ioctl_balance+0x292/0x340 [btrfs]
> [ 9127.793983]  btrfs_ioctl+0x84c/0x3060 [btrfs]
> [ 9127.793987]  ? preempt_count_add+0x79/0xb0
> [ 9127.793988]  ? _raw_spin_lock_irqsave+0x26/0x50
> [ 9127.793990]  ? up+0x12/0x60
> [ 9127.793991]  ? preempt_count_add+0x79/0xb0
> [ 9127.793992]  ? _raw_spin_lock+0x13/0x30
> [ 9127.793994]  ? _raw_spin_unlock+0x16/0x30
> [ 9127.793995]  ? preempt_count_add+0x79/0xb0
> [ 9127.793996]  ? _raw_spin_lock_irqsave+0x26/0x50
> [ 9127.793998]  ? _raw_spin_unlock_irqrestore+0x20/0x40
> [ 9127.793999]  ? __wake_up_common_lock+0x8d/0xc0
> --
> [ 9127.794018]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 9127.794020] RIP: 0033:0x7f720309b21b
> [ 9127.794022] Code: 0f 1e fa 48 8b 05 75 8c 0c 00 64 c7 00 26 00 00 00 4=
8 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 45 8c 0c 00 f7 d8 64 89 01 48
> [ 9127.794022] RSP: 002b:00007ffedae78488 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000010
> [ 9127.794024] RAX: ffffffffffffffda RBX: 00007ffedae784f0 RCX: 00007f720=
309b21b
> [ 9127.794025] RDX: 00007ffedae784f0 RSI: 00000000c4009420 RDI: 000000000=
0000004
> [ 9127.794025] RBP: 0000000000000004 R08: 0000000000000027 R09: 000000000=
0000002
> [ 9127.794026] R10: 00007ffedae78367 R11: 0000000000000246 R12: 000055ac4=
325c125
> [ 9127.794027] R13: 00007ffedae79dea R14: 0000000000000000 R15: 00007f720=
31656a8
> [ 9127.794030] ---[ end trace e6a280878e0f6ea2 ]---
> [ 9127.794034] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:2907:=
 errno=3D-5 IO failure
> [ 9127.794074] BTRFS info (device dm-0): forced readonly


which may have caused an error with the balance.
> [ 9127.795439] BTRFS info (device dm-0): balance: ended with status: -30


> [36269.471145] BTRFS info (device dm-0): disk space caching is enabled
> [36269.471148] BTRFS info (device dm-0): has skinny extents
> [36272.920637] BTRFS info (device dm-0): checking UUID tree
> [36273.905836] BTRFS info (device dm-0): balance: resume -dusage=3D90 -mu=
sage=3D90 -susage=3D90
> [36273.906920] BTRFS info (device dm-0): relocating block group 294342505=
2672 flags data|raid10
> [36274.096312] BTRFS info (device dm-0): relocating block group 294020382=
7200 flags data|raid10
> [36309.330874] BTRFS info (device dm-0): found 77 extents
> [36312.572905] BTRFS info (device dm-0): found 77 extents
> [36313.110274] BTRFS info (device dm-0): balance: paused
> [36689.402334] BTRFS info (device dm-0): disk space caching is enabled
> [36689.402337] BTRFS info (device dm-0): has skinny extents


but then it started again

> [36692.424302] BTRFS info (device dm-0): balance: resume -dusage=3D90 -mu=
sage=3D90 -susage=3D90


more repeating

> [36692.425104] BTRFS info (device dm-0): relocating block group 294342505=
2672 flags data|raid10
> [36723.945784] BTRFS info (device dm-0): found 77 extents
> [37049.457773] BTRFS info (device dm-0): found 77 extents

end repeating

> [42819.594722] BTRFS info (device dm-0): no csum found for inode 1468 sta=
rt 1910132736
> [42819.594731] BTRFS info (device dm-0): no csum found for inode 1468 sta=
rt 1910136832
> [42819.594790] BTRFS info (device dm-0): no csum found for inode 1468 sta=
rt 1910140928
> [42819.594795] BTRFS info (device dm-0): no csum found for inode 1468 sta=
rt 1910145024
> [42819.594799] BTRFS info (device dm-0): no csum found for inode 1468 sta=
rt 1910149120
> [42819.594803] BTRFS info (device dm-0): no csum found for inode 1468 sta=
rt 1910153216
> [42819.594806] BTRFS info (device dm-0): no csum found for inode 1468 sta=
rt 1910157312
> [42819.594810] BTRFS info (device dm-0): no csum found for inode 1468 sta=
rt 1910161408
> [42819.594813] BTRFS info (device dm-0): no csum found for inode 1468 sta=
rt 1910165504
> [42819.594817] BTRFS info (device dm-0): no csum found for inode 1468 sta=
rt 1910169600
> [42819.602862] BTRFS warning (device dm-0): csum failed root 5 ino 1468 o=
ff 1910140928 csum 0x972b9901 expected csum 0x00000000 mirror 2
> [42819.602889] BTRFS warning (device dm-0): csum failed root 5 ino 1468 o=
ff 1910337536 csum 0x98f94189 expected csum 0x00000000 mirror 2
> [42819.602912] BTRFS warning (device dm-0): csum failed root 5 ino 1468 o=
ff 1910145024 csum 0x7722536c expected csum 0x00000000 mirror 2
> [42819.602920] BTRFS warning (device dm-0): csum failed root 5 ino 1468 o=
ff 1910341632 csum 0x98f94189 expected csum 0x00000000 mirror 2
> [42819.602935] BTRFS warning (device dm-0): csum failed root 5 ino 1468 o=
ff 1910345728 csum 0x98f94189 expected csum 0x00000000 mirror 2
> [42819.602953] BTRFS warning (device dm-0): csum failed root 5 ino 1468 o=
ff 1910149120 csum 0x642755f8 expected csum 0x00000000 mirror 2
> [42819.602955] BTRFS warning (device dm-0): csum failed root 5 ino 1468 o=
ff 1910349824 csum 0x98f94189 expected csum 0x00000000 mirror 2
> [42819.602967] BTRFS warning (device dm-0): csum failed root 5 ino 1468 o=
ff 1910353920 csum 0x98f94189 expected csum 0x00000000 mirror 2
> [42819.602981] BTRFS warning (device dm-0): csum failed root 5 ino 1468 o=
ff 1910358016 csum 0x98f94189 expected csum 0x00000000 mirror 2
> [42819.602998] BTRFS warning (device dm-0): csum failed root 5 ino 1468 o=
ff 1910153216 csum 0xc8eac75b expected csum 0x00000000 mirror 2



Matt Pallissard

--r7nlph6o5p5f55gf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTvIUMPApUGn6YFkXl1uof+t048SQUCXYt+lAAKCRB1uof+t048
SRLxAP918XaLeem5RUGOYAxtlytVjq+6mk3CpyG/UJtffSabxwEAmwgoAb83hq3C
vSBKuUGgOBufMblrBMepOCeJnaHvTAw=
=8Be8
-----END PGP SIGNATURE-----

--r7nlph6o5p5f55gf--
