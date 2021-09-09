Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1A1405A5A
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Sep 2021 17:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbhIIPqY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Sep 2021 11:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhIIPqY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Sep 2021 11:46:24 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39D6C061574
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Sep 2021 08:45:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j16so2131489pfc.2
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Sep 2021 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=T/RL4kxL3BEpaJBE1pUrUMV+mUIwfM2MSC38QKm2gl8=;
        b=UI8qyUjPZzB/qOf9PWe9NuV1OBSFw1tNcQB/DQR75o3hN4+ZOJm9f5U7G9mc7OZ+PY
         Ta5+3d4RPtW7zb+HJvC8Lz3Em2uI2JnihgZ1NHIKA0DwOratCAhs9lxFcNi0I9TnyPfJ
         qUCiDa+NxYYTq/q1DhO78DZ5iYvyr40o+VifVpgg/vYphoK7qujAaQpPxpbzsnz8ab6E
         Am/vZpZpKCvG8ol+WzPjNjYHjXBRUsTnNCoprX+Du+ZOmLGwZH2SDJlr+Dd9NUAak3Ak
         p7+2o2MwIVXC4bgkS9uaQXlD7Cks8Es3emhJfMYs6lxSkhOg49Ky+RK4JrAkLOyzdgIr
         MPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=T/RL4kxL3BEpaJBE1pUrUMV+mUIwfM2MSC38QKm2gl8=;
        b=XsUASR7Vr1dXQI1jHwWrJ8RwbddmahpyqiD0+x4xotfgJa4wJQ2BrxIreZ88/nVqnJ
         803vK4INUcs+kMHozLwNkA/bjV7hhRRCLmkwPQ2nhWpTePim/IxFuhS+M/nCAMQJHMBj
         ufLqUSreTGg4n3bKgs34MGG1IZxJwUz6j0X+Q8pKbaTet5YurWut/KXlZ/B+RaOS73L4
         uGJXuOx9nOScOj3VoZdGisE37YwDCvnXUvby35RmNsBmodE0trtcC6smIaW+W2BuCLqm
         OXYRfeVLj79jV20rIoXcRxtfm6E3wGk3MxbmHNUv8uDyVmRtYW+mcNdT0EbwAyokih1N
         lq0g==
X-Gm-Message-State: AOAM5332BAcUp6aKskBzJuSYyo8yzx67dChhfmm7nNriyW43KhipkAcv
        bldz39lWGH3i5BeXLbM5AldE4mK4zualAJGQ1bZx/L2DOG8=
X-Google-Smtp-Source: ABdhPJwvZaVqV6PaiP2o/65BjiWrTFblPDqoUFfVLfdkmJYaVboYpzmoxdIdPzslpL24zDIEFoszrljP8zIPp/nlGe8=
X-Received: by 2002:a65:508a:: with SMTP id r10mr3266711pgp.96.1631202312605;
 Thu, 09 Sep 2021 08:45:12 -0700 (PDT)
MIME-Version: 1.0
From:   "Sergio Ortiz V." <seov33@gmail.com>
Date:   Thu, 9 Sep 2021 12:45:01 -0300
Message-ID: <CAHWNsAtPTZVZwNn94N4rZBC-9n=EB=qrzPpSuknHZhpTyVR3cw@mail.gmail.com>
Subject: btrfs raid5 8 devices mount error
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dears , I can't mount, repair , recover my raid 5 .  Help me ! Are
there any ways to recover the data ?
this array was mount in rockstor 3 server. crash hardware. Device 7 is
missing and I think its an  electronic failure because it does
nothing. and now I try mount with -o degraded but nothing.



uname -a
Linux localhost.localdomain 5.3.18-59.19-default #1 SMP Tue Aug 3
14:11:23 UTC 2021 (055c4fd) x86_64 x86_64 x86_64 GNU/Linux

btrfs --version
btrfs-progs v5.13.1

btrfs fi show
Label: none  uuid: 4a0ab1ef-0ed3-46a8-97eb-9af5dcf27afa
    Total devices 1 FS bytes used 6.10GiB
    devid    1 size 215.33GiB used 8.05GiB path /dev/sda3

warning, device 7 is missing
bad tree block 21086208, bytenr mismatch, want=3D21086208, have=3D21479424
Couldn't read chunk tree
Label: 'DATOS'  uuid: 0d2c5bf7-7ce4-42f4-be4d-d40cc349cfe1
    Total devices 8 FS bytes used 14.57TiB
    devid    1 size 9.10TiB used 2.24TiB path /dev/sdj
    devid    2 size 9.10TiB used 2.24TiB path /dev/sdf
    devid    3 size 9.10TiB used 2.24TiB path /dev/sdg
    devid    4 size 9.10TiB used 2.24TiB path /dev/sdd
    devid    5 size 9.10TiB used 2.24TiB path /dev/sdc
    devid    6 size 9.10TiB used 2.24TiB path /dev/sdi
    devid    8 size 9.10TiB used 2.24TiB path /dev/sdb
    *** Some devices missing

btrfs fi df   # no point mount.

dmesg:

[   11.371795] BTRFS info (device sde): disk space caching is enabled
[   11.371796] BTRFS info (device sde): has skinny extents
[   11.371797] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[   11.423430] BTRFS error (device sde): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[   11.423432] BTRFS error (device sde): failed to read the system array: -=
2
[   11.519132] rfkill: input handler disabled
[   11.656751] BTRFS error (device sde): open_ctree failed
[   11.673686] BTRFS info (device sde): disk space caching is enabled
[   11.673688] BTRFS info (device sde): has skinny extents
[   11.673688] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[   11.704322] BTRFS error (device sde): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[   11.704325] BTRFS error (device sde): failed to read the system array: -=
2
[   11.916745] BTRFS error (device sde): open_ctree failed
[   11.918430] BTRFS info (device sde): disk space caching is enabled
[   11.918432] BTRFS info (device sde): has skinny extents
[   11.918433] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[   11.955935] BTRFS error (device sde): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[   11.955937] BTRFS error (device sde): failed to read the system array: -=
2
[   12.120786] BTRFS error (device sde): open_ctree failed
[   12.128770] BTRFS info (device sde): disk space caching is enabled
[   12.128776] BTRFS info (device sde): has skinny extents
[   12.128777] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[   12.132382] BTRFS error (device sde): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[   12.132388] BTRFS error (device sde): failed to read the system array: -=
2
[   12.276832] BTRFS error (device sde): open_ctree failed
[   12.281153] BTRFS info (device sde): disk space caching is enabled
[   12.281154] BTRFS info (device sde): has skinny extents
[   12.281155] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[   12.281873] BTRFS error (device sde): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[   12.281876] BTRFS error (device sde): failed to read the system array: -=
2
[   12.456936] BTRFS error (device sde): open_ctree failed
[   13.263069] sd 14:0:0:0: [sdi] Attached SCSI disk
[   13.544967] BTRFS: device label DATOS devid 6 transid 1427716 /dev/sdi
[   13.669143] BTRFS info (device sde): disk space caching is enabled
[   13.669144] BTRFS info (device sde): has skinny extents
[   13.669144] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[   13.669622] BTRFS error (device sde): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[   13.669624] BTRFS error (device sde): failed to read the system array: -=
2
[   13.840805] BTRFS error (device sde): open_ctree failed
[   20.985277] e1000e 0000:00:1f.6 eth0: NIC Link is Up 100 Mbps Full
Duplex, Flow Control: Rx/Tx
[   20.985278] e1000e 0000:00:1f.6 eth0: 10/100 speed: disabling TSO
[   20.985333] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   21.017760] NET: Registered protocol family 17
[   21.909038] e1000e 0000:00:1f.6 eth0: NIC Link is Down
[   50.796951] e1000e 0000:00:1f.6 eth0: NIC Link is Up 100 Mbps Full
Duplex, Flow Control: Rx/Tx
[   50.796956] e1000e 0000:00:1f.6 eth0: 10/100 speed: disabling TSO
[  601.108127] ata6.00: exception Emask 0x10 SAct 0xc SErr 0x190002
action 0xe frozen
[  601.108131] ata6.00: irq_stat 0x80400000, PHY RDY changed
[  601.108135] ata6: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[  601.108139] ata6.00: failed command: READ FPDMA QUEUED
[  601.108147] ata6.00: cmd 60/00:10:00:35:b8/0a:00:03:00:00/40 tag 2
ncq dma 1310720 in
                        res 40/00:10:00:35:b8/00:00:03:00:00/40 Emask
0x10 (ATA bus error)
[  601.108150] ata6.00: status: { DRDY }
[  601.108153] ata6.00: failed command: READ FPDMA QUEUED
[  601.108160] ata6.00: cmd 60/00:18:00:3f:b8/0a:00:03:00:00/40 tag 3
ncq dma 1310720 in
                        res 40/00:10:00:35:b8/00:00:03:00:00/40 Emask
0x10 (ATA bus error)
[  601.108162] ata6.00: status: { DRDY }
[  601.108168] ata6: hard resetting link
[  601.844123] ata6: SATA link down (SStatus 0 SControl 300)
[  607.080095] ata6: hard resetting link
[  615.496178] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  615.620045] ata6.00: configured for UDMA/133
[  615.620090] sd 5:0:0:0: [sde] tag#2 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[  615.620098] sd 5:0:0:0: [sde] tag#2 Sense Key : Illegal Request [current=
]
[  615.620102] sd 5:0:0:0: [sde] tag#2 Add. Sense: Unaligned write command
[  615.620106] sd 5:0:0:0: [sde] tag#2 CDB: Read(16) 88 00 00 00 00 00
03 b8 35 00 00 00 0a 00 00 00
[  615.620112] blk_update_request: I/O error, dev sde, sector 62403840
op 0x0:(READ) flags 0x80700 phys_seg 21 prio class 0
[  615.620174] sd 5:0:0:0: [sde] tag#3 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[  615.620177] sd 5:0:0:0: [sde] tag#3 Sense Key : Illegal Request [current=
]
[  615.620180] sd 5:0:0:0: [sde] tag#3 Add. Sense: Unaligned write command
[  615.620184] sd 5:0:0:0: [sde] tag#3 CDB: Read(16) 88 00 00 00 00 00
03 b8 3f 00 00 00 0a 00 00 00
[  615.620187] blk_update_request: I/O error, dev sde, sector 62406400
op 0x0:(READ) flags 0x80700 phys_seg 21 prio class 0
[  615.620221] ata6: EH complete
[  633.257892] BTRFS info (device sda3): qgroup scan completed
(inconsistency flag cleared)
[ 1828.436166] ata6.00: exception Emask 0x10 SAct 0xc SErr 0x190002
action 0xe frozen
[ 1828.436170] ata6.00: irq_stat 0x80400000, PHY RDY changed
[ 1828.436174] ata6: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[ 1828.436178] ata6.00: failed command: READ FPDMA QUEUED
[ 1828.436186] ata6.00: cmd 60/00:10:00:35:8a/0a:00:27:00:00/40 tag 2
ncq dma 1310720 in
                        res 40/00:10:00:35:8a/00:00:27:00:00/40 Emask
0x10 (ATA bus error)
[ 1828.436188] ata6.00: status: { DRDY }
[ 1828.436191] ata6.00: failed command: READ FPDMA QUEUED
[ 1828.436198] ata6.00: cmd 60/00:18:00:3f:8a/0a:00:27:00:00/40 tag 3
ncq dma 1310720 in
                        res 40/00:10:00:35:8a/00:00:27:00:00/40 Emask
0x10 (ATA bus error)
[ 1828.436200] ata6.00: status: { DRDY }
[ 1828.436206] ata6: hard resetting link
[ 1829.178918] ata6: SATA link down (SStatus 0 SControl 300)
[ 1834.342877] ata6: hard resetting link
[ 1842.850962] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 1842.946110] ata6.00: configured for UDMA/133
[ 1842.946131] sd 5:0:0:0: [sde] tag#2 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 1842.946136] sd 5:0:0:0: [sde] tag#2 Sense Key : Illegal Request [current=
]
[ 1842.946139] sd 5:0:0:0: [sde] tag#2 Add. Sense: Unaligned write command
[ 1842.946144] sd 5:0:0:0: [sde] tag#2 CDB: Read(16) 88 00 00 00 00 00
27 8a 35 00 00 00 0a 00 00 00
[ 1842.946149] blk_update_request: I/O error, dev sde, sector
663368960 op 0x0:(READ) flags 0x80700 phys_seg 21 prio class 0
[ 1842.946207] sd 5:0:0:0: [sde] tag#3 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 1842.946211] sd 5:0:0:0: [sde] tag#3 Sense Key : Illegal Request [current=
]
[ 1842.946214] sd 5:0:0:0: [sde] tag#3 Add. Sense: Unaligned write command
[ 1842.946217] sd 5:0:0:0: [sde] tag#3 CDB: Read(16) 88 00 00 00 00 00
27 8a 3f 00 00 00 0a 00 00 00
[ 1842.946220] blk_update_request: I/O error, dev sde, sector
663371520 op 0x0:(READ) flags 0x80700 phys_seg 21 prio class 0
[ 1842.946256] ata6: EH complete
[ 1843.242963] ata6.00: exception Emask 0x10 SAct 0x20 SErr 0x190002
action 0xe frozen
[ 1843.242966] ata6.00: irq_stat 0x80400000, PHY RDY changed
[ 1843.242970] ata6: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[ 1843.242974] ata6.00: failed command: READ FPDMA QUEUED
[ 1843.242982] ata6.00: cmd 60/08:28:c8:39:8a/00:00:27:00:00/40 tag 5
ncq dma 4096 in
                        res 40/00:28:c8:39:8a/00:00:27:00:00/40 Emask
0x10 (ATA bus error)
[ 1843.242985] ata6.00: status: { DRDY }
[ 1843.242990] ata6: hard resetting link
[ 1843.963016] ata6: SATA link down (SStatus 0 SControl 300)
[ 1843.963021] ata10: SATA link down (SStatus 0 SControl 300)
[ 1849.190956] ata6: hard resetting link
[ 1857.626925] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 1857.734548] ata6.00: configured for UDMA/133
[ 1857.734566] ata6: EH complete
[ 1857.766971] ata10: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 1858.075778] ata10.00: configured for UDMA/133
[ 2176.487621] ata6.00: exception Emask 0x10 SAct 0x80800000 SErr
0x190002 action 0xe frozen
[ 2176.487625] ata6.00: irq_stat 0x80400000, PHY RDY changed
[ 2176.487628] ata6: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[ 2176.487633] ata6.00: failed command: READ FPDMA QUEUED
[ 2176.487642] ata6.00: cmd 60/00:b8:00:35:e4/0a:00:30:00:00/40 tag 23
ncq dma 1310720 in
                        res 40/00:b8:00:35:e4/00:00:30:00:00/40 Emask
0x10 (ATA bus error)
[ 2176.487644] ata6.00: status: { DRDY }
[ 2176.487647] ata6.00: failed command: READ FPDMA QUEUED
[ 2176.487654] ata6.00: cmd 60/00:f8:00:3f:e4/0a:00:30:00:00/40 tag 31
ncq dma 1310720 in
                        res 40/00:b8:00:35:e4/00:00:30:00:00/40 Emask
0x10 (ATA bus error)
[ 2176.487656] ata6.00: status: { DRDY }
[ 2176.487661] ata6: hard resetting link
[ 2177.199627] ata6: SATA link down (SStatus 0 SControl 300)
[ 2182.247545] ata6: hard resetting link
[ 2182.562898] ata6: SATA link down (SStatus 0 SControl 300)
[ 2182.669511] ata6: hard resetting link
[ 2190.823650] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 2191.049635] ata6.00: configured for UDMA/133
[ 2191.049655] sd 5:0:0:0: [sde] tag#23 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 2191.049660] sd 5:0:0:0: [sde] tag#23 Sense Key : Illegal Request [curren=
t]
[ 2191.049664] sd 5:0:0:0: [sde] tag#23 Add. Sense: Unaligned write command
[ 2191.049668] sd 5:0:0:0: [sde] tag#23 CDB: Read(16) 88 00 00 00 00
00 30 e4 35 00 00 00 0a 00 00 00
[ 2191.049674] blk_update_request: I/O error, dev sde, sector
820262144 op 0x0:(READ) flags 0x80700 phys_seg 21 prio class 0
[ 2191.049733] sd 5:0:0:0: [sde] tag#31 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 2191.049736] sd 5:0:0:0: [sde] tag#31 Sense Key : Illegal Request [curren=
t]
[ 2191.049739] sd 5:0:0:0: [sde] tag#31 Add. Sense: Unaligned write command
[ 2191.049743] sd 5:0:0:0: [sde] tag#31 CDB: Read(16) 88 00 00 00 00
00 30 e4 3f 00 00 00 0a 00 00 00
[ 2191.049746] blk_update_request: I/O error, dev sde, sector
820264704 op 0x0:(READ) flags 0x80700 phys_seg 21 prio class 0
[ 2191.049786] ata6: EH complete
[ 2830.109089] ata6.00: exception Emask 0x10 SAct 0x6 SErr 0x190002
action 0xe frozen
[ 2830.109093] ata6.00: irq_stat 0x80400000, PHY RDY changed
[ 2830.109096] ata6: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[ 2830.109100] ata6.00: failed command: READ FPDMA QUEUED
[ 2830.109109] ata6.00: cmd 60/78:08:88:46:a6/02:00:43:00:00/40 tag 1
ncq dma 323584 in
                        res 40/00:10:00:49:a6/00:00:43:00:00/40 Emask
0x10 (ATA bus error)
[ 2830.109111] ata6.00: status: { DRDY }
[ 2830.109114] ata6.00: failed command: READ FPDMA QUEUED
[ 2830.109121] ata6.00: cmd 60/00:10:00:49:a6/04:00:43:00:00/40 tag 2
ncq dma 524288 in
                        res 40/00:10:00:49:a6/00:00:43:00:00/40 Emask
0x10 (ATA bus error)
[ 2830.109123] ata6.00: status: { DRDY }
[ 2830.109129] ata6: hard resetting link
[ 2830.829075] ata6: SATA link down (SStatus 0 SControl 300)
[ 2836.073052] ata6: hard resetting link
[ 2844.461069] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 2844.558950] ata6.00: configured for UDMA/133
[ 2844.558971] sd 5:0:0:0: [sde] tag#1 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 2844.558976] sd 5:0:0:0: [sde] tag#1 Sense Key : Illegal Request [current=
]
[ 2844.558980] sd 5:0:0:0: [sde] tag#1 Add. Sense: Unaligned write command
[ 2844.558985] sd 5:0:0:0: [sde] tag#1 CDB: Read(16) 88 00 00 00 00 00
43 a6 46 88 00 00 02 78 00 00
[ 2844.558990] blk_update_request: I/O error, dev sde, sector
1134970504 op 0x0:(READ) flags 0x80700 phys_seg 20 prio class 0
[ 2844.559056] sd 5:0:0:0: [sde] tag#2 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 2844.559059] sd 5:0:0:0: [sde] tag#2 Sense Key : Illegal Request [current=
]
[ 2844.559062] sd 5:0:0:0: [sde] tag#2 Add. Sense: Unaligned write command
[ 2844.559066] sd 5:0:0:0: [sde] tag#2 CDB: Read(16) 88 00 00 00 00 00
43 a6 49 00 00 00 04 00 00 00
[ 2844.559069] blk_update_request: I/O error, dev sde, sector
1134971136 op 0x0:(READ) flags 0x80700 phys_seg 89 prio class 0
[ 2844.559096] ata6: EH complete
[ 2909.025242] ata6.00: exception Emask 0x10 SAct 0x30 SErr 0x190002
action 0xe frozen
[ 2909.025245] ata6.00: irq_stat 0x80400000, PHY RDY changed
[ 2909.025249] ata6: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[ 2909.025253] ata6.00: failed command: READ FPDMA QUEUED
[ 2909.025262] ata6.00: cmd 60/00:20:00:6d:89/08:00:45:00:00/40 tag 4
ncq dma 1048576 in
                        res 40/00:20:00:6d:89/00:00:45:00:00/40 Emask
0x10 (ATA bus error)
[ 2909.025264] ata6.00: status: { DRDY }
[ 2909.025267] ata6.00: failed command: READ FPDMA QUEUED
[ 2909.025274] ata6.00: cmd 60/00:28:00:75:89/0a:00:45:00:00/40 tag 5
ncq dma 1310720 in
                        res 40/00:20:00:6d:89/00:00:45:00:00/40 Emask
0x10 (ATA bus error)
[ 2909.025276] ata6.00: status: { DRDY }
[ 2909.025281] ata6: hard resetting link
[ 2909.757226] ata6: SATA link down (SStatus 0 SControl 300)
[ 2914.921217] ata6: hard resetting link
[ 2923.501185] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 2923.597633] ata6.00: configured for UDMA/133
[ 2923.597655] sd 5:0:0:0: [sde] tag#4 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 2923.597660] sd 5:0:0:0: [sde] tag#4 Sense Key : Illegal Request [current=
]
[ 2923.597664] sd 5:0:0:0: [sde] tag#4 Add. Sense: Unaligned write command
[ 2923.597668] sd 5:0:0:0: [sde] tag#4 CDB: Read(16) 88 00 00 00 00 00
45 89 6d 00 00 00 08 00 00 00
[ 2923.597674] blk_update_request: I/O error, dev sde, sector
1166634240 op 0x0:(READ) flags 0x80700 phys_seg 17 prio class 0
[ 2923.597724] sd 5:0:0:0: [sde] tag#5 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 2923.597727] sd 5:0:0:0: [sde] tag#5 Sense Key : Illegal Request [current=
]
[ 2923.597730] sd 5:0:0:0: [sde] tag#5 Add. Sense: Unaligned write command
[ 2923.597733] sd 5:0:0:0: [sde] tag#5 CDB: Read(16) 88 00 00 00 00 00
45 89 75 00 00 00 0a 00 00 00
[ 2923.597736] blk_update_request: I/O error, dev sde, sector
1166636288 op 0x0:(READ) flags 0x80700 phys_seg 21 prio class 0
[ 2923.597775] ata6: EH complete
[ 2991.893320] ata6.00: exception Emask 0x10 SAct 0x6 SErr 0x190002
action 0xe frozen
[ 2991.893324] ata6.00: irq_stat 0x80400000, PHY RDY changed
[ 2991.893327] ata6: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[ 2991.893331] ata6.00: failed command: READ FPDMA QUEUED
[ 2991.893340] ata6.00: cmd 60/00:08:00:cd:88/08:00:47:00:00/40 tag 1
ncq dma 1048576 in
                        res 40/00:08:00:cd:88/00:00:47:00:00/40 Emask
0x10 (ATA bus error)
[ 2991.893342] ata6.00: status: { DRDY }
[ 2991.893345] ata6.00: failed command: READ FPDMA QUEUED
[ 2991.893352] ata6.00: cmd 60/00:10:00:d5:88/0a:00:47:00:00/40 tag 2
ncq dma 1310720 in
                        res 40/00:08:00:cd:88/00:00:47:00:00/40 Emask
0x10 (ATA bus error)
[ 2991.893354] ata6.00: status: { DRDY }
[ 2991.893360] ata6: hard resetting link
[ 2992.625402] ata6: SATA link down (SStatus 0 SControl 300)
[ 2997.865401] ata6: hard resetting link
[ 3006.377417] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 3006.487124] ata6.00: configured for UDMA/133
[ 3006.487146] sd 5:0:0:0: [sde] tag#1 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 3006.487151] sd 5:0:0:0: [sde] tag#1 Sense Key : Illegal Request [current=
]
[ 3006.487155] sd 5:0:0:0: [sde] tag#1 Add. Sense: Unaligned write command
[ 3006.487159] sd 5:0:0:0: [sde] tag#1 CDB: Read(16) 88 00 00 00 00 00
47 88 cd 00 00 00 08 00 00 00
[ 3006.487164] blk_update_request: I/O error, dev sde, sector
1200147712 op 0x0:(READ) flags 0x80700 phys_seg 33 prio class 0
[ 3006.487227] sd 5:0:0:0: [sde] tag#2 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 3006.487231] sd 5:0:0:0: [sde] tag#2 Sense Key : Illegal Request [current=
]
[ 3006.487234] sd 5:0:0:0: [sde] tag#2 Add. Sense: Unaligned write command
[ 3006.487237] sd 5:0:0:0: [sde] tag#2 CDB: Read(16) 88 00 00 00 00 00
47 88 d5 00 00 00 0a 00 00 00
[ 3006.487241] blk_update_request: I/O error, dev sde, sector
1200149760 op 0x0:(READ) flags 0x80700 phys_seg 26 prio class 0
[ 3006.487275] ata6: EH complete
[ 3101.097617] ata6: limiting SATA link speed to 3.0 Gbps
[ 3101.097624] ata6.00: exception Emask 0x10 SAct 0x300 SErr 0x190002
action 0xe frozen
[ 3101.097626] ata6.00: irq_stat 0x80400000, PHY RDY changed
[ 3101.097629] ata6: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[ 3101.097633] ata6.00: failed command: READ FPDMA QUEUED
[ 3101.097642] ata6.00: cmd 60/00:40:00:ad:4c/08:00:4a:00:00/40 tag 8
ncq dma 1048576 in
                        res 40/00:40:00:ad:4c/00:00:4a:00:00/40 Emask
0x10 (ATA bus error)
[ 3101.097644] ata6.00: status: { DRDY }
[ 3101.097646] ata6.00: failed command: READ FPDMA QUEUED
[ 3101.097653] ata6.00: cmd 60/00:48:00:b5:4c/0a:00:4a:00:00/40 tag 9
ncq dma 1310720 in
                        res 40/00:40:00:ad:4c/00:00:4a:00:00/40 Emask
0x10 (ATA bus error)
[ 3101.097655] ata6.00: status: { DRDY }
[ 3101.097661] ata6: hard resetting link
[ 3101.833619] ata6: SATA link down (SStatus 0 SControl 320)
[ 3106.925605] ata6: hard resetting link
[ 3107.240935] ata6: SATA link down (SStatus 0 SControl 320)
[ 3107.287824] ata6: hard resetting link
[ 3115.553668] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 3115.668709] ata6.00: configured for UDMA/133
[ 3115.668732] sd 5:0:0:0: [sde] tag#8 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 3115.668737] sd 5:0:0:0: [sde] tag#8 Sense Key : Illegal Request [current=
]
[ 3115.668741] sd 5:0:0:0: [sde] tag#8 Add. Sense: Unaligned write command
[ 3115.668745] sd 5:0:0:0: [sde] tag#8 CDB: Read(16) 88 00 00 00 00 00
4a 4c ad 00 00 00 08 00 00 00
[ 3115.668750] blk_update_request: I/O error, dev sde, sector
1246539008 op 0x0:(READ) flags 0x80700 phys_seg 65 prio class 0
[ 3115.668806] sd 5:0:0:0: [sde] tag#9 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 3115.668810] sd 5:0:0:0: [sde] tag#9 Sense Key : Illegal Request [current=
]
[ 3115.668813] sd 5:0:0:0: [sde] tag#9 Add. Sense: Unaligned write command
[ 3115.668816] sd 5:0:0:0: [sde] tag#9 CDB: Read(16) 88 00 00 00 00 00
4a 4c b5 00 00 00 0a 00 00 00
[ 3115.668820] blk_update_request: I/O error, dev sde, sector
1246541056 op 0x0:(READ) flags 0x80700 phys_seg 81 prio class 0
[ 3115.668862] ata6: EH complete
[ 3116.061671] ata6.00: exception Emask 0x10 SAct 0x300000 SErr
0x190002 action 0xe frozen
[ 3116.061674] ata6.00: irq_stat 0x80400000, PHY RDY changed
[ 3116.061678] ata6: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[ 3116.061683] ata6.00: failed command: READ FPDMA QUEUED
[ 3116.061691] ata6.00: cmd 60/00:a0:00:cd:4c/08:00:4a:00:00/40 tag 20
ncq dma 1048576 in
                        res 40/00:a0:00:cd:4c/00:00:4a:00:00/40 Emask
0x10 (ATA bus error)
[ 3116.061694] ata6.00: status: { DRDY }
[ 3116.061696] ata6.00: failed command: READ FPDMA QUEUED
[ 3116.061703] ata6.00: cmd 60/00:a8:00:d5:4c/0a:00:4a:00:00/40 tag 21
ncq dma 1310720 in
                        res 40/00:a0:00:cd:4c/00:00:4a:00:00/40 Emask
0x10 (ATA bus error)
[ 3116.061705] ata6.00: status: { DRDY }
[ 3116.061710] ata6: hard resetting link
[ 3116.797647] ata6: SATA link down (SStatus 0 SControl 320)
[ 3122.025643] ata6: hard resetting link
[ 3130.505684] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 3130.615647] ata6.00: configured for UDMA/133
[ 3130.615670] sd 5:0:0:0: [sde] tag#20 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 3130.615675] sd 5:0:0:0: [sde] tag#20 Sense Key : Illegal Request [curren=
t]
[ 3130.615679] sd 5:0:0:0: [sde] tag#20 Add. Sense: Unaligned write command
[ 3130.615683] sd 5:0:0:0: [sde] tag#20 CDB: Read(16) 88 00 00 00 00
00 4a 4c cd 00 00 00 08 00 00 00
[ 3130.615688] blk_update_request: I/O error, dev sde, sector
1246547200 op 0x0:(READ) flags 0x80700 phys_seg 33 prio class 0
[ 3130.615744] sd 5:0:0:0: [sde] tag#21 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 3130.615747] sd 5:0:0:0: [sde] tag#21 Sense Key : Illegal Request [curren=
t]
[ 3130.615750] sd 5:0:0:0: [sde] tag#21 Add. Sense: Unaligned write command
[ 3130.615753] sd 5:0:0:0: [sde] tag#21 CDB: Read(16) 88 00 00 00 00
00 4a 4c d5 00 00 00 0a 00 00 00
[ 3130.615757] blk_update_request: I/O error, dev sde, sector
1246549248 op 0x0:(READ) flags 0x80700 phys_seg 42 prio class 0
[ 3130.615793] ata6: EH complete
[ 3153.429756] ata6.00: exception Emask 0x10 SAct 0x380000 SErr
0x190002 action 0xe frozen
[ 3153.429760] ata6.00: irq_stat 0x80400000, PHY RDY changed
[ 3153.429764] ata6: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[ 3153.429769] ata6.00: failed command: READ FPDMA QUEUED
[ 3153.429778] ata6.00: cmd 60/00:98:00:55:f5/0a:00:4a:00:00/40 tag 19
ncq dma 1310720 in
                        res 40/00:98:00:55:f5/00:00:4a:00:00/40 Emask
0x10 (ATA bus error)
[ 3153.429780] ata6.00: status: { DRDY }
[ 3153.429783] ata6.00: failed command: READ FPDMA QUEUED
[ 3153.429790] ata6.00: cmd 60/28:a0:00:5f:f5/07:00:4a:00:00/40 tag 20
ncq dma 937984 in
                        res 40/00:98:00:55:f5/00:00:4a:00:00/40 Emask
0x10 (ATA bus error)
[ 3153.429792] ata6.00: status: { DRDY }
[ 3153.429795] ata6.00: failed command: READ FPDMA QUEUED
[ 3153.429801] ata6.00: cmd 60/d8:a8:28:66:f5/02:00:4a:00:00/40 tag 21
ncq dma 372736 in
                        res 40/00:98:00:55:f5/00:00:4a:00:00/40 Emask
0x10 (ATA bus error)
[ 3153.429803] ata6.00: status: { DRDY }
[ 3153.429808] ata6: hard resetting link
[ 3154.177709] ata6: SATA link down (SStatus 0 SControl 320)
[ 3159.401742] ata6: hard resetting link
[ 3167.957766] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 3168.185290] ata6.00: configured for UDMA/133
[ 3168.185315] sd 5:0:0:0: [sde] tag#19 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 3168.185320] sd 5:0:0:0: [sde] tag#19 Sense Key : Illegal Request [curren=
t]
[ 3168.185324] sd 5:0:0:0: [sde] tag#19 Add. Sense: Unaligned write command
[ 3168.185328] sd 5:0:0:0: [sde] tag#19 CDB: Read(16) 88 00 00 00 00
00 4a f5 55 00 00 00 0a 00 00 00
[ 3168.185333] blk_update_request: I/O error, dev sde, sector
1257592064 op 0x0:(READ) flags 0x80700 phys_seg 24 prio class 0
[ 3168.185398] sd 5:0:0:0: [sde] tag#20 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 3168.185401] sd 5:0:0:0: [sde] tag#20 Sense Key : Illegal Request [curren=
t]
[ 3168.185404] sd 5:0:0:0: [sde] tag#20 Add. Sense: Unaligned write command
[ 3168.185408] sd 5:0:0:0: [sde] tag#20 CDB: Read(16) 88 00 00 00 00
00 4a f5 5f 00 00 00 07 28 00 00
[ 3168.185411] blk_update_request: I/O error, dev sde, sector
1257594624 op 0x0:(READ) flags 0x84700 phys_seg 168 prio class 0
[ 3168.185425] sd 5:0:0:0: [sde] tag#21 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 3168.185428] sd 5:0:0:0: [sde] tag#21 Sense Key : Illegal Request [curren=
t]
[ 3168.185431] sd 5:0:0:0: [sde] tag#21 Add. Sense: Unaligned write command
[ 3168.185434] sd 5:0:0:0: [sde] tag#21 CDB: Read(16) 88 00 00 00 00
00 4a f5 66 28 00 00 02 d8 00 00
[ 3168.185436] blk_update_request: I/O error, dev sde, sector
1257596456 op 0x0:(READ) flags 0x80700 phys_seg 45 prio class 0
[ 3168.185475] ata6: EH complete
[ 3232.417887] ata6.00: exception Emask 0x10 SAct 0x7000000 SErr
0x190002 action 0xe frozen
[ 3232.417891] ata6.00: irq_stat 0x80400000, PHY RDY changed
[ 3232.417894] ata6: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[ 3232.417899] ata6.00: failed command: READ FPDMA QUEUED
[ 3232.417908] ata6.00: cmd 60/00:c0:00:6d:d7/08:00:4c:00:00/40 tag 24
ncq dma 1048576 in
                        res 40/00:c0:00:6d:d7/00:00:4c:00:00/40 Emask
0x10 (ATA bus error)
[ 3232.417910] ata6.00: status: { DRDY }
[ 3232.417913] ata6.00: failed command: READ FPDMA QUEUED
[ 3232.417920] ata6.00: cmd 60/20:c8:00:75:d7/06:00:4c:00:00/40 tag 25
ncq dma 802816 in
                        res 40/00:c0:00:6d:d7/00:00:4c:00:00/40 Emask
0x10 (ATA bus error)
[ 3232.417922] ata6.00: status: { DRDY }
[ 3232.417924] ata6.00: failed command: READ FPDMA QUEUED
[ 3232.417930] ata6.00: cmd 60/e0:d0:20:7b:d7/03:00:4c:00:00/40 tag 26
ncq dma 507904 in
                        res 40/00:c0:00:6d:d7/00:00:4c:00:00/40 Emask
0x10 (ATA bus error)
[ 3232.417932] ata6.00: status: { DRDY }
[ 3232.417937] ata6: hard resetting link
[ 3233.141907] ata6: SATA link down (SStatus 0 SControl 320)
[ 3238.249886] ata6: hard resetting link
[ 3238.565161] ata6: SATA link down (SStatus 0 SControl 320)
[ 3238.601409] ata6: hard resetting link
[ 3246.845936] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 3247.066802] ata6.00: configured for UDMA/133
[ 3247.066829] sd 5:0:0:0: [sde] tag#24 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 3247.066834] sd 5:0:0:0: [sde] tag#24 Sense Key : Illegal Request [curren=
t]
[ 3247.066838] sd 5:0:0:0: [sde] tag#24 Add. Sense: Unaligned write command
[ 3247.066842] sd 5:0:0:0: [sde] tag#24 CDB: Read(16) 88 00 00 00 00
00 4c d7 6d 00 00 00 08 00 00 00
[ 3247.066848] blk_update_request: I/O error, dev sde, sector
1289186560 op 0x0:(READ) flags 0x80700 phys_seg 59 prio class 0
[ 3247.066907] sd 5:0:0:0: [sde] tag#25 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 3247.066911] sd 5:0:0:0: [sde] tag#25 Sense Key : Illegal Request [curren=
t]
[ 3247.066914] sd 5:0:0:0: [sde] tag#25 Add. Sense: Unaligned write command
[ 3247.066917] sd 5:0:0:0: [sde] tag#25 CDB: Read(16) 88 00 00 00 00
00 4c d7 75 00 00 00 06 20 00 00
[ 3247.066921] blk_update_request: I/O error, dev sde, sector
1289188608 op 0x0:(READ) flags 0x84700 phys_seg 168 prio class 0
[ 3247.066935] sd 5:0:0:0: [sde] tag#26 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 3247.066938] sd 5:0:0:0: [sde] tag#26 Sense Key : Illegal Request [curren=
t]
[ 3247.066941] sd 5:0:0:0: [sde] tag#26 Add. Sense: Unaligned write command
[ 3247.066944] sd 5:0:0:0: [sde] tag#26 CDB: Read(16) 88 00 00 00 00
00 4c d7 7b 20 00 00 03 e0 00 00
[ 3247.066947] blk_update_request: I/O error, dev sde, sector
1289190176 op 0x0:(READ) flags 0x80700 phys_seg 87 prio class 0
[ 3247.066985] ata6: EH complete
[ 3316.614079] ata6: limiting SATA link speed to 1.5 Gbps
[ 3316.614085] ata6.00: exception Emask 0x10 SAct 0x6000 SErr 0x190002
action 0xe frozen
[ 3316.614088] ata6.00: irq_stat 0x80400000, PHY RDY changed
[ 3316.614091] ata6: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[ 3316.614095] ata6.00: failed command: READ FPDMA QUEUED
[ 3316.614104] ata6.00: cmd 60/00:68:00:0d:e1/08:00:4e:00:00/40 tag 13
ncq dma 1048576 in
                        res 40/00:68:00:0d:e1/00:00:4e:00:00/40 Emask
0x10 (ATA bus error)
[ 3316.614106] ata6.00: status: { DRDY }
[ 3316.614108] ata6.00: failed command: READ FPDMA QUEUED
[ 3316.614115] ata6.00: cmd 60/00:70:00:15:e1/0a:00:4e:00:00/40 tag 14
ncq dma 1310720 in
                        res 40/00:68:00:0d:e1/00:00:4e:00:00/40 Emask
0x10 (ATA bus error)
[ 3316.614117] ata6.00: status: { DRDY }
[ 3316.614122] ata6: hard resetting link
[ 3317.334026] ata6: SATA link down (SStatus 0 SControl 310)
[ 3322.474063] ata6: hard resetting link
[ 3322.793354] ata6: SATA link down (SStatus 0 SControl 310)
[ 3322.802138] ata6: hard resetting link
[ 3331.074114] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 3331.173787] ata6.00: configured for UDMA/133
[ 3331.173809] sd 5:0:0:0: [sde] tag#13 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 3331.173813] sd 5:0:0:0: [sde] tag#13 Sense Key : Illegal Request [curren=
t]
[ 3331.173817] sd 5:0:0:0: [sde] tag#13 Add. Sense: Unaligned write command
[ 3331.173821] sd 5:0:0:0: [sde] tag#13 CDB: Read(16) 88 00 00 00 00
00 4e e1 0d 00 00 00 08 00 00 00
[ 3331.173827] blk_update_request: I/O error, dev sde, sector
1323371776 op 0x0:(READ) flags 0x80700 phys_seg 33 prio class 0
[ 3331.173880] sd 5:0:0:0: [sde] tag#14 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 3331.173883] sd 5:0:0:0: [sde] tag#14 Sense Key : Illegal Request [curren=
t]
[ 3331.173886] sd 5:0:0:0: [sde] tag#14 Add. Sense: Unaligned write command
[ 3331.173890] sd 5:0:0:0: [sde] tag#14 CDB: Read(16) 88 00 00 00 00
00 4e e1 15 00 00 00 0a 00 00 00
[ 3331.173893] blk_update_request: I/O error, dev sde, sector
1323373824 op 0x0:(READ) flags 0x80700 phys_seg 41 prio class 0
[ 3331.173929] ata6: EH complete
[ 3572.478580] ata6.00: exception Emask 0x10 SAct 0x60000 SErr
0x1390002 action 0xe frozen
[ 3572.478584] ata6.00: irq_stat 0x88400000, interface fatal error,
PHY RDY changed
[ 3572.478588] ata6: SError: { RecovComm PHYRdyChg 10B8B Dispar BadCRC
TrStaTrns }
[ 3572.478593] ata6.00: failed command: READ FPDMA QUEUED
[ 3572.478601] ata6.00: cmd 60/00:88:00:35:e8/0a:00:52:00:00/40 tag 17
ncq dma 1310720 in
                        res 40/00:88:00:35:e8/00:00:52:00:00/40 Emask
0x10 (ATA bus error)
[ 3572.478604] ata6.00: status: { DRDY }
[ 3572.478606] ata6.00: failed command: READ FPDMA QUEUED
[ 3572.478613] ata6.00: cmd 60/00:90:00:3f:e8/0a:00:52:00:00/40 tag 18
ncq dma 1310720 in
                        res 40/00:88:00:35:e8/00:00:52:00:00/40 Emask
0x10 (ATA bus error)
[ 3572.478615] ata6.00: status: { DRDY }
[ 3572.478621] ata6: hard resetting link
[ 3573.214641] ata6: SATA link down (SStatus 0 SControl 310)
[ 3578.222621] ata6: hard resetting link
[ 3578.537675] ata6: SATA link down (SStatus 0 SControl 310)
[ 3578.659648] ata6: hard resetting link
[ 3586.922660] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 3587.230705] ata6.00: configured for UDMA/133
[ 3587.230733] sd 5:0:0:0: [sde] tag#17 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 3587.230738] sd 5:0:0:0: [sde] tag#17 Sense Key : Illegal Request [curren=
t]
[ 3587.230743] sd 5:0:0:0: [sde] tag#17 Add. Sense: Unaligned write command
[ 3587.230747] sd 5:0:0:0: [sde] tag#17 CDB: Read(16) 88 00 00 00 00
00 52 e8 35 00 00 00 0a 00 00 00
[ 3587.230753] blk_update_request: I/O error, dev sde, sector
1390949632 op 0x0:(READ) flags 0x80700 phys_seg 81 prio class 0
[ 3587.230819] sd 5:0:0:0: [sde] tag#18 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 3587.230822] sd 5:0:0:0: [sde] tag#18 Sense Key : Illegal Request [curren=
t]
[ 3587.230825] sd 5:0:0:0: [sde] tag#18 Add. Sense: Unaligned write command
[ 3587.230829] sd 5:0:0:0: [sde] tag#18 CDB: Read(16) 88 00 00 00 00
00 52 e8 3f 00 00 00 0a 00 00 00
[ 3587.230832] blk_update_request: I/O error, dev sde, sector
1390952192 op 0x0:(READ) flags 0x80700 phys_seg 55 prio class 0
[ 3587.230870] ata6: EH complete
[ 4238.852700] ata6.00: exception Emask 0x10 SAct 0xc000 SErr
0x1390002 action 0xe frozen
[ 4238.852704] ata6.00: irq_stat 0x88400000, interface fatal error,
PHY RDY changed
[ 4238.852708] ata6: SError: { RecovComm PHYRdyChg 10B8B Dispar BadCRC
TrStaTrns }
[ 4238.852713] ata6.00: failed command: READ FPDMA QUEUED
[ 4238.852721] ata6.00: cmd 60/00:70:00:b5:c7/0a:00:5d:00:00/40 tag 14
ncq dma 1310720 in
                        res 40/00:70:00:b5:c7/00:00:5d:00:00/40 Emask
0x10 (ATA bus error)
[ 4238.852724] ata6.00: status: { DRDY }
[ 4238.852726] ata6.00: failed command: READ FPDMA QUEUED
[ 4238.852733] ata6.00: cmd 60/00:78:00:bf:c7/0a:00:5d:00:00/40 tag 15
ncq dma 1310720 in
                        res 40/00:70:00:b5:c7/00:00:5d:00:00/40 Emask
0x10 (ATA bus error)
[ 4238.852735] ata6.00: status: { DRDY }
[ 4238.852741] ata6: hard resetting link
[ 4239.568719] ata6: SATA link down (SStatus 0 SControl 310)
[ 4244.588699] ata6: hard resetting link
[ 4244.904025] ata6: SATA link down (SStatus 0 SControl 310)
[ 4245.040597] ata6: hard resetting link
[ 4254.156836] ata6: SATA link down (SStatus 0 SControl 310)
[ 4254.156859] ata6.00: link offline, clearing class 1 to NONE
[ 4254.156870] ata6.00: disabled
[ 4254.156913] sd 5:0:0:0: [sde] tag#14 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 4254.156918] sd 5:0:0:0: [sde] tag#14 Sense Key : Illegal Request [curren=
t]
[ 4254.156922] sd 5:0:0:0: [sde] tag#14 Add. Sense: Unaligned write command
[ 4254.156926] sd 5:0:0:0: [sde] tag#14 CDB: Read(16) 88 00 00 00 00
00 5d c7 b5 00 00 00 0a 00 00 00
[ 4254.156932] blk_update_request: I/O error, dev sde, sector
1573369088 op 0x0:(READ) flags 0x80700 phys_seg 41 prio class 0
[ 4254.156990] sd 5:0:0:0: [sde] tag#15 FAILED Result: hostbyte=3DDID_OK
driverbyte=3DDRIVER_SENSE
[ 4254.156993] sd 5:0:0:0: [sde] tag#15 Sense Key : Illegal Request [curren=
t]
[ 4254.156996] sd 5:0:0:0: [sde] tag#15 Add. Sense: Unaligned write command
[ 4254.157000] sd 5:0:0:0: [sde] tag#15 CDB: Read(16) 88 00 00 00 00
00 5d c7 bf 00 00 00 0a 00 00 00
[ 4254.157003] blk_update_request: I/O error, dev sde, sector
1573371648 op 0x0:(READ) flags 0x80700 phys_seg 91 prio class 0
[ 4254.157024] sd 5:0:0:0: rejecting I/O to offline device
[ 4254.157033] blk_update_request: I/O error, dev sde, sector
1573369088 op 0x0:(READ) flags 0x0 phys_seg 8 prio class 0
[ 4254.157037] Buffer I/O error on dev sde, logical block 1573369088,
async page read
[ 4254.157040] Buffer I/O error on dev sde, logical block 1573369089,
async page read
[ 4254.157042] Buffer I/O error on dev sde, logical block 1573369090,
async page read
[ 4254.157044] Buffer I/O error on dev sde, logical block 1573369091,
async page read
[ 4254.157046] ata6: EH complete
[ 4254.157048] Buffer I/O error on dev sde, logical block 1573369092,
async page read
[ 4254.157050] Buffer I/O error on dev sde, logical block 1573369093,
async page read
[ 4254.157052] Buffer I/O error on dev sde, logical block 1573369094,
async page read
[ 4254.157054] Buffer I/O error on dev sde, logical block 1573369095,
async page read
[ 4254.157064] ata6.00: detaching (SCSI 5:0:0:0)
[ 4254.157360] blk_update_request: I/O error, dev sde, sector
1573369088 op 0x0:(READ) flags 0x0 phys_seg 8 prio class 0
[ 4254.157363] Buffer I/O error on dev sde, logical block 1573369088,
async page read
[ 4254.157366] Buffer I/O error on dev sde, logical block 1573369089,
async page read
[ 4255.704500] sd 5:0:0:0: [sde] Stopping disk
[ 4255.704521] sd 5:0:0:0: [sde] Start/Stop Unit failed: Result:
hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK
[ 4264.204724] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 4264.230059] ata6.00: ATA-10: TOSHIBA HDWT31A, 0603, max UDMA/133
[ 4264.230061] ata6.00: 19532873728 sectors, multi 16: LBA48 NCQ (depth 32)=
, AA
[ 4264.305089] ata6.00: configured for UDMA/133
[ 4264.305164] scsi 5:0:0:0: Direct-Access     ATA      TOSHIBA
HDWT31A  0603 PQ: 0 ANSI: 5
[ 4264.305842] sd 5:0:0:0: Attached scsi generic sg4 type 0
[ 4264.306010] sd 5:0:0:0: [sdj] 19532873728 512-byte logical blocks:
(10.0 TB/9.10 TiB)
[ 4264.306011] sd 5:0:0:0: [sdj] 4096-byte physical blocks
[ 4264.306015] sd 5:0:0:0: [sdj] Write Protect is off
[ 4264.306016] sd 5:0:0:0: [sdj] Mode Sense: 00 3a 00 00
[ 4264.306022] sd 5:0:0:0: [sdj] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[ 4264.472754] sd 5:0:0:0: [sdj] Attached SCSI removable disk
[ 4269.072446] BTRFS info (device sdj): disk space caching is enabled
[ 4269.072447] BTRFS info (device sdj): has skinny extents
[ 4269.072448] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[ 4269.073490] BTRFS error (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[ 4269.073492] BTRFS error (device sdj): failed to read the system array: -=
2
[ 4269.272725] BTRFS error (device sdj): open_ctree failed
[ 7138.367339] perf: interrupt took too long (2502 > 2500), lowering
kernel.perf_event_max_sample_rate to 79750
[10784.662666] perf: interrupt took too long (3129 > 3127), lowering
kernel.perf_event_max_sample_rate to 63750
[59248.497900] perf: interrupt took too long (3920 > 3911), lowering
kernel.perf_event_max_sample_rate to 51000
[76648.601272] perf: interrupt took too long (4901 > 4900), lowering
kernel.perf_event_max_sample_rate to 40750
[87072.759193] BTRFS info (device sda3): qgroup scan completed
(inconsistency flag cleared)
[173493.337966] BTRFS info (device sda3): qgroup scan completed
(inconsistency flag cleared)
[259953.622514] BTRFS info (device sda3): qgroup scan completed
(inconsistency flag cleared)
[279080.740854] ata5: SATA link down (SStatus 0 SControl 300)
[279086.180037] ata5: SATA link down (SStatus 0 SControl 300)
[279095.728932] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[279095.829330] ata5.00: configured for UDMA/133
[286224.183456] ata5: SATA link down (SStatus 0 SControl 300)
[286229.630708] ata5: SATA link down (SStatus 0 SControl 300)
[286239.183486] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[286239.277142] ata5.00: configured for UDMA/133
[346414.099150] BTRFS info (device sda3): qgroup scan completed
(inconsistency flag cleared)
[372630.521161] ata5: SATA link down (SStatus 0 SControl 300)
[372645.677136] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[372645.888868] ata5.00: configured for UDMA/133
[432854.319372] BTRFS info (device sda3): qgroup scan completed
(inconsistency flag cleared)
[459031.542698] ata5: SATA link down (SStatus 0 SControl 300)
[459036.953675] ata5: SATA link down (SStatus 0 SControl 300)
[459046.542758] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[459046.656537] ata5.00: configured for UDMA/133
[519274.526502] BTRFS info (device sda3): qgroup scan completed
(inconsistency flag cleared)
[545430.567889] ata5: SATA link down (SStatus 0 SControl 300)
[545436.039172] ata5: SATA link down (SStatus 0 SControl 300)
[545445.615959] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[545445.826091] ata5.00: configured for UDMA/133
[566951.669197] buffer_io_error: 6 callbacks suppressed
[566951.669201] Buffer I/O error on dev sde, logical block 41088,
async page read
[566951.669205] Buffer I/O error on dev sde, logical block 41089,
async page read
[566951.669208] Buffer I/O error on dev sde, logical block 41090,
async page read
[566951.669210] Buffer I/O error on dev sde, logical block 41091,
async page read
[566951.669213] Buffer I/O error on dev sde, logical block 41092,
async page read
[566951.669215] Buffer I/O error on dev sde, logical block 41093,
async page read
[566951.669218] Buffer I/O error on dev sde, logical block 41094,
async page read
[566951.669220] Buffer I/O error on dev sde, logical block 41095,
async page read
[583390.087450] BTRFS info (device sdj): disk space caching is enabled
[583390.087454] BTRFS info (device sdj): has skinny extents
[583390.087455] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[583390.088543] BTRFS error (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[583390.088549] BTRFS error (device sdj): failed to read the system array: =
-2
[583390.254068] BTRFS error (device sdj): open_ctree failed
[589115.524410] BTRFS info (device sdj): allowing degraded mounts
[589115.524419] BTRFS info (device sdj): disk space caching is enabled
[589115.524421] BTRFS info (device sdj): has skinny extents
[589115.524423] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[589115.525357] BTRFS warning (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[589115.525855] BTRFS warning (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[589118.634632] BTRFS error (device sdj): parent transid verify failed
on 1721729024 wanted 1427716 found 1427423
[589119.559781] BTRFS error (device sdj): parent transid verify failed
on 1721696256 wanted 1427716 found 1427440
[589119.562103] BTRFS error (device sdj): failed to verify dev extents
against chunks: -5
[589119.726548] BTRFS error (device sdj): open_ctree failed
[589150.792991] BTRFS info (device sdj): allowing degraded mounts
[589150.793000] BTRFS info (device sdj): disk space caching is enabled
[589150.793002] BTRFS info (device sdj): has skinny extents
[589150.793004] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[589150.795656] BTRFS warning (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[589150.823505] BTRFS error (device sdj): parent transid verify failed
on 1721729024 wanted 1427716 found 1427423
[589150.826424] BTRFS error (device sdj): parent transid verify failed
on 1721696256 wanted 1427716 found 1427440
[589150.828418] BTRFS error (device sdj): failed to verify dev extents
against chunks: -5
[589150.994688] BTRFS error (device sdj): open_ctree failed
[589168.003614] BTRFS info (device sdj): allowing degraded mounts
[589168.003624] BTRFS info (device sdj): disk space caching is enabled
[589168.003626] BTRFS info (device sdj): has skinny extents
[589168.003628] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[589168.005367] BTRFS warning (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[589168.045750] BTRFS error (device sdj): parent transid verify failed
on 1721729024 wanted 1427716 found 1427423
[589168.048886] BTRFS error (device sdj): parent transid verify failed
on 1721696256 wanted 1427716 found 1427440
[589168.051023] BTRFS error (device sdj): failed to verify dev extents
against chunks: -5
[589168.214763] BTRFS error (device sdj): open_ctree failed
[590813.154405] BTRFS info (device sdj): allowing degraded mounts
[590813.154415] BTRFS info (device sdj): disk space caching is enabled
[590813.154417] BTRFS info (device sdj): has skinny extents
[590813.154418] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[590813.156264] BTRFS warning (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[590813.195560] BTRFS error (device sdj): parent transid verify failed
on 1721729024 wanted 1427716 found 1427423
[590813.198794] BTRFS error (device sdj): parent transid verify failed
on 1721696256 wanted 1427716 found 1427440
[590813.200926] BTRFS error (device sdj): failed to verify dev extents
against chunks: -5
[590813.361793] BTRFS error (device sdj): open_ctree failed
[590843.568862] BTRFS info (device sdj): allowing degraded mounts
[590843.568872] BTRFS info (device sdj): disk space caching is enabled
[590843.568873] BTRFS info (device sdj): has skinny extents
[590843.568875] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[590843.572639] BTRFS warning (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[590843.609870] BTRFS error (device sdj): parent transid verify failed
on 1721729024 wanted 1427716 found 1427423
[590843.612974] BTRFS error (device sdj): parent transid verify failed
on 1721696256 wanted 1427716 found 1427440
[590843.614968] BTRFS error (device sdj): failed to verify dev extents
against chunks: -5
[590843.773921] BTRFS error (device sdj): open_ctree failed
[592360.837948] BTRFS info (device sdj): allowing degraded mounts
[592360.837957] BTRFS info (device sdj): trying to use backup root at mount=
 time
[592360.837964] BTRFS info (device sdj): disk space caching is enabled
[592360.837966] BTRFS info (device sdj): has skinny extents
[592360.837967] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[592360.840265] BTRFS warning (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[592360.880604] BTRFS error (device sdj): parent transid verify failed
on 1721729024 wanted 1427716 found 1427423
[592360.883797] BTRFS error (device sdj): parent transid verify failed
on 1721696256 wanted 1427716 found 1427440
[592360.885923] BTRFS error (device sdj): failed to verify dev extents
against chunks: -5
[592361.056389] BTRFS error (device sdj): open_ctree failed
[592993.375942] BTRFS info (device sdj): allowing degraded mounts
[592993.375950] BTRFS info (device sdj): disabling disk space caching
[592993.375957] BTRFS info (device sdj): has skinny extents
[592993.375959] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[592993.379660] BTRFS warning (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[592993.421359] BTRFS error (device sdj): parent transid verify failed
on 1721729024 wanted 1427716 found 1427423
[592993.424587] BTRFS error (device sdj): parent transid verify failed
on 1721696256 wanted 1427716 found 1427440
[592993.426686] BTRFS error (device sdj): failed to verify dev extents
against chunks: -5
[592993.603035] BTRFS error (device sdj): open_ctree failed
[593055.048963] BTRFS info (device sdj): allowing degraded mounts
[593055.048971] BTRFS info (device sdj): unrecognized mount option
'rootflags=3Drecovery'
[593055.203371] BTRFS error (device sdj): open_ctree failed
[593075.952143] BTRFS info (device sdj): allowing degraded mounts
[593075.952146] BTRFS info (device sdj): unrecognized mount option
'rootflags=3Drecovery'
[593076.087439] BTRFS error (device sdj): open_ctree failed
[594059.361437] BTRFS info (device sdj): allowing degraded mounts
[594059.361446] BTRFS info (device sdj): disk space caching is enabled
[594059.361448] BTRFS info (device sdj): has skinny extents
[594059.361450] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[594059.364292] BTRFS warning (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[594059.399082] BTRFS error (device sdj): parent transid verify failed
on 1721729024 wanted 1427716 found 1427423
[594059.402429] BTRFS error (device sdj): parent transid verify failed
on 1721696256 wanted 1427716 found 1427440
[594059.404633] BTRFS error (device sdj): failed to verify dev extents
against chunks: -5
[594059.563663] BTRFS error (device sdj): open_ctree failed
[596024.596486] request_module fs-minix succeeded, but still no fs?
[597127.243364] BTRFS info (device sdj): allowing degraded mounts
[597127.243374] BTRFS info (device sdj): trying to use backup root at mount=
 time
[597127.243376] BTRFS info (device sdj): disk space caching is enabled
[597127.243378] BTRFS info (device sdj): has skinny extents
[597127.243380] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[597127.246144] BTRFS warning (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[597127.274767] BTRFS error (device sdj): parent transid verify failed
on 1721729024 wanted 1427716 found 1427423
[597127.278244] BTRFS error (device sdj): parent transid verify failed
on 1721696256 wanted 1427716 found 1427440
[597127.280402] BTRFS error (device sdj): failed to verify dev extents
against chunks: -5
[597127.432774] BTRFS error (device sdj): open_ctree failed
[597133.226138] BTRFS info (device sdj): allowing degraded mounts
[597133.226145] BTRFS info (device sdj): trying to use backup root at mount=
 time
[597133.226147] BTRFS info (device sdj): disk space caching is enabled
[597133.226149] BTRFS info (device sdj): has skinny extents
[597133.226150] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[597133.227782] BTRFS warning (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[597133.254254] BTRFS error (device sdj): parent transid verify failed
on 1721729024 wanted 1427716 found 1427423
[597133.257127] BTRFS error (device sdj): parent transid verify failed
on 1721696256 wanted 1427716 found 1427440
[597133.259069] BTRFS error (device sdj): failed to verify dev extents
against chunks: -5
[597133.420797] BTRFS error (device sdj): open_ctree failed
[597150.955711] BTRFS info (device sdj): allowing degraded mounts
[597150.955718] BTRFS info (device sdj): trying to use backup root at mount=
 time
[597150.955720] BTRFS info (device sdj): disk space caching is enabled
[597150.955722] BTRFS info (device sdj): has skinny extents
[597150.955724] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[597150.958012] BTRFS warning (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[597150.985449] BTRFS error (device sdj): parent transid verify failed
on 1721729024 wanted 1427716 found 1427423
[597150.988644] BTRFS error (device sdj): parent transid verify failed
on 1721696256 wanted 1427716 found 1427440
[597150.990782] BTRFS error (device sdj): failed to verify dev extents
against chunks: -5
[597151.172867] BTRFS error (device sdj): open_ctree failed
[597155.978381] BTRFS info (device sdj): allowing degraded mounts
[597155.978388] BTRFS info (device sdj): trying to use backup root at mount=
 time
[597155.978390] BTRFS info (device sdj): disk space caching is enabled
[597155.978392] BTRFS info (device sdj): has skinny extents
[597155.978394] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[597155.979921] BTRFS warning (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[597156.013487] BTRFS error (device sdj): parent transid verify failed
on 1721729024 wanted 1427716 found 1427423
[597156.017078] BTRFS error (device sdj): parent transid verify failed
on 1721696256 wanted 1427716 found 1427440
[597156.019261] BTRFS error (device sdj): failed to verify dev extents
against chunks: -5
[597156.200896] BTRFS error (device sdj): open_ctree failed
[597163.099137] BTRFS info (device sdj): allowing degraded mounts
[597163.099144] BTRFS info (device sdj): trying to use backup root at mount=
 time
[597163.099146] BTRFS info (device sdj): disk space caching is enabled
[597163.099148] BTRFS info (device sdj): has skinny extents
[597163.099149] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[597163.102293] BTRFS warning (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[597163.144835] BTRFS error (device sdj): parent transid verify failed
on 1721729024 wanted 1427716 found 1427423
[597163.147997] BTRFS error (device sdj): parent transid verify failed
on 1721696256 wanted 1427716 found 1427440
[597163.150108] BTRFS error (device sdj): failed to verify dev extents
against chunks: -5
[597163.316916] BTRFS error (device sdj): open_ctree failed
[597331.108645] BTRFS info (device sdj): allowing degraded mounts
[597331.108654] BTRFS info (device sdj): disabling tree log
[597331.108658] BTRFS info (device sdj): disabling log replay at mount time
[597331.108666] BTRFS info (device sdj): disk space caching is enabled
[597331.108668] BTRFS info (device sdj): has skinny extents
[597331.108669] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[597331.110665] BTRFS warning (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[597331.138681] BTRFS error (device sdj): parent transid verify failed
on 1721729024 wanted 1427716 found 1427423
[597331.141699] BTRFS error (device sdj): parent transid verify failed
on 1721696256 wanted 1427716 found 1427440
[597331.143678] BTRFS error (device sdj): failed to verify dev extents
against chunks: -5
[597331.321642] BTRFS error (device sdj): open_ctree failed
[605734.837069] BTRFS info (device sda3): qgroup scan completed
(inconsistency flag cleared)
[616327.070807] usb 1-3: new high-speed USB device number 6 using xhci_hcd
[616327.231467] usb 1-3: New USB device found, idVendor=3D22b8,
idProduct=3D2e82, bcdDevice=3D 4.09
[616327.231471] usb 1-3: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[616327.231474] usb 1-3: Product: motorola one action
[616327.231476] usb 1-3: Manufacturer: motorola
[616327.231479] usb 1-3: SerialNumber: ZY326TGRQK
[616337.993896] usb 1-3: USB disconnect, device number 6
[616339.162897] usb usb1-port3: Cannot enable. Maybe the USB cable is bad?
[616340.134901] usb usb1-port3: Cannot enable. Maybe the USB cable is bad?
[616340.134968] usb usb1-port3: attempt power cycle
[616341.194905] usb usb1-port3: Cannot enable. Maybe the USB cable is bad?
[616342.170907] usb usb1-port3: Cannot enable. Maybe the USB cable is bad?
[616342.170982] usb usb1-port3: unable to enumerate USB device
[616431.351259] usb 1-3: new high-speed USB device number 11 using xhci_hcd
[616431.500164] usb 1-3: New USB device found, idVendor=3D22b8,
idProduct=3D2e24, bcdDevice=3D 4.09
[616431.500168] usb 1-3: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[616431.500171] usb 1-3: Product: motorola one action
[616431.500173] usb 1-3: Manufacturer: motorola
[616431.500176] usb 1-3: SerialNumber: ZY326TGRQK
[616431.522032] usbcore: registered new interface driver cdc_ether
[616431.525348] rndis_host 1-3:1.0 usb0: register 'rndis_host' at
usb-0000:00:14.0-3, RNDIS device, 1a:a8:c1:9e:94:b5
[616431.525366] usbcore: registered new interface driver rndis_host
[616432.267880] usb 1-3: USB disconnect, device number 11
[616432.268041] rndis_host 1-3:1.0 usb0: unregister 'rndis_host'
usb-0000:00:14.0-3, RNDIS device
[631832.205087] ata5: SATA link down (SStatus 0 SControl 300)
[631837.688428] ata5: SATA link down (SStatus 0 SControl 300)
[631847.317152] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[631847.432498] ata5.00: configured for UDMA/133
[659980.722638] BTRFS info (device sdj): disk space caching is enabled
[659980.722640] BTRFS info (device sdj): has skinny extents
[659980.722641] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[659980.723543] BTRFS error (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[659980.723545] BTRFS error (device sdj): failed to read chunk tree: -2
[659980.881724] BTRFS error (device sdj): open_ctree failed
[660708.679323] BTRFS info (device sdj): disk space caching is enabled
[660708.679324] BTRFS info (device sdj): has skinny extents
[660708.679325] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[660708.680488] BTRFS error (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[660708.680489] BTRFS error (device sdj): failed to read chunk tree: -2
[660708.860487] BTRFS error (device sdj): open_ctree failed
[661209.264857] BTRFS info (device sdj): allowing degraded mounts
[661209.264864] BTRFS info (device sdj): disabling tree log
[661209.264868] BTRFS info (device sdj): disabling log replay at mount time
[661209.264875] BTRFS info (device sdj): disk space caching is enabled
[661209.264876] BTRFS info (device sdj): has skinny extents
[661209.264878] btrfs: RAID56 is supported read-only, load module with
allow_unsupported=3D1
[661209.271602] BTRFS warning (device sdj): devid 7 uuid
a4986695-e6ac-40a2-8332-708dbda16ae6 is missing
[661211.528455] BTRFS error (device sdj): parent transid verify failed
on 1721729024 wanted 1427716 found 1427423
[661211.594984] BTRFS error (device sdj): parent transid verify failed
on 1721696256 wanted 1427716 found 1427440
[661211.597219] BTRFS error (device sdj): failed to verify dev extents
against chunks: -5
[661211.750801] BTRFS error (device sdj): open_ctree failed
[661241.633073] show_signal_msg: 3 callbacks suppressed
[661241.633079] btrfs[24430]: segfault at 7fb0e407d85c ip
000055a9fd75fc3f sp 00007fb0b7683c30 error 4 in
btrfs[55a9fd71b000+e2000]
[661241.633092] Code: 89 50 58 48 63 d5 48 8d 14 92 48 89 48 20 48 89
48 48 41 0f b6 4c 24 08 48 89 70 40 48 8d 14 92 8b 94 13 ee 00 00 00
88 48 50 <48> 8b 94 13 ed 00 00 00 48 89 50 60 48 8d 50 30 48 89 50 30
48 89


my commands:
mount -t btrfs -o
degraded,ro,notreelog,nologreplay,device=3D/dev/sdj,device=3D/dev/sdf,devic=
e=3D/dev/sdg,device=3D/dev/sdd,device=3D/dev/sdd,device=3D/dev/sdc,device=
=3D/dev/sdi,device=3D/dev/sdb
/dev/sdj /mnt/DATOS
mount: /mnt/DATOS: wrong fs type, bad option, bad superblock on
/dev/sdj, missing codepage or helper program, or other error.


--=20

Sergio Ortiz V

Ingeniero Inform=C3=A1tico

M=C3=B3vil: +56937318224
