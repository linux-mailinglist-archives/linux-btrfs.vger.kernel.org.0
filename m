Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03BBFB9236
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2019 16:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390790AbfITOae (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Sep 2019 10:30:34 -0400
Received: from know-smtprelay-omd-8.server.virginmedia.net ([81.104.62.40]:38864
        "EHLO know-smtprelay-omd-8.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390757AbfITOac (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Sep 2019 10:30:32 -0400
Received: from [172.16.100.1] ([86.12.75.74])
        by cmsmtp with ESMTPA
        id BJvYinxJYrx5ABJvYiQxOP; Fri, 20 Sep 2019 15:30:29 +0100
X-Originating-IP: [86.12.75.74]
X-Authenticated-User: peter.chant@ntlworld.com
X-Spam: 0
X-Authority: v=2.3 cv=Te64SyYh c=1 sm=1 tr=0 a=RxXffCTTaIU9mOmmEQ6aGA==:117
 a=RxXffCTTaIU9mOmmEQ6aGA==:17 a=IkcTkHD0fZMA:10 a=6s0VX7ivN6RIie3_96YA:9
 a=QEXdDO2ut3YA:10
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   Pete <pete@petezilla.co.uk>
Subject: Balance ENOSPC during balance despite additional storage added
Message-ID: <94ebf95b-c8c2-e2d5-8db6-77a74c19644a@petezilla.co.uk>
Date:   Fri, 20 Sep 2019 15:29:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGAvMAvh/iEOUFVGGQ/7Ou0BCO5e6i5l+r0VYg9AVcqC+s4YM6OuaAWCd9DZHiHahFf14Lo4t5ZZs5A+QBNMDovFbLD44oxsb7bAHlv9pcRFQOw5elqs
 dmHUKc9eiCNTtPW/B9vqplVtZWFkfHhpxaW70e58uAPq+hI4+ATGzr1NAf44EDW8o30ADMusO4J+Mg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a btrfs that is on top of an lvm logical volume on top of 
dm-crypt on a single nvme drive (Samsung 870 Pro 512GB).

I added a second logical volume to give more space to get rid of ENOSPC 
errors during balance, but to no avail.  This was after I started 
getting enospc during balance.  Without this additional logical device, 
before balance, I had run out of space owning to some unfortunate 
scripting interacting with lxc snapshots (non btrfs backed in the 
config, so a copy) and some copying.  I was performing a balance, 
following some deletions, when trying to get things back to a better state.

root@phoenix:/var/lib/lxc# btrfs balance start /var/lib/lxc
WARNING:

         Full balance without filters requested. This operation is very
         intense and takes potentially very long. It is recommended to
         use the balance filters to narrow down the scope of balance.
         Use 'btrfs balance start --full-balance' option to skip this
         warning. The operation will start in 10 seconds.
         Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting balance without any filters.
ERROR: error during balancing '/var/lib/lxc': No space left on device
There may be more info in syslog - try dmesg | tail
root@phoenix:/var/lib/lxc#

I can still write to the filesystem.


Kernel 5.1.21 (downgraded from 5.2.12)

root@phoenix:/var/lib/lxc# btrfs --version
btrfs-progs v5.1

root@phoenix:/var/lib/lxc# btrfs fi show /var/lib/lxc
Label: 'LXC_BTRFS'  uuid: 6b0245ec-bdd4-4076-b800-2243d466b174
         Total devices 2 FS bytes used 79.74GiB
         devid    1 size 250.00GiB used 93.03GiB path 
/dev/mapper/nvme0_vg-lxc
         devid    2 size 80.00GiB used 0.00B path 
/dev/mapper/nvme0_vg-tempdel

root@phoenix:/var/lib/lxc# btrfs fi u /var/lib/lxc
Overall:
     Device size:                 330.00GiB
     Device allocated:             93.03GiB
     Device unallocated:          236.97GiB
     Device missing:                  0.00B
     Used:                         79.74GiB
     Free (estimated):            237.70GiB      (min: 237.70GiB)
     Data ratio:                       1.00
     Metadata ratio:                   1.00
     Global reserve:              512.00MiB      (used: 0.00B)

Data,single: Size:71.00GiB, Used:70.26GiB
    /dev/mapper/nvme0_vg-lxc       71.00GiB

Metadata,single: Size:22.00GiB, Used:9.48GiB
    /dev/mapper/nvme0_vg-lxc       22.00GiB

System,single: Size:32.00MiB, Used:16.00KiB
    /dev/mapper/nvme0_vg-lxc       32.00MiB

Unallocated:
    /dev/mapper/nvme0_vg-lxc      156.97GiB
    /dev/mapper/nvme0_vg-tempdel   80.00GiB

btrfs fi df /var/lib/lxc
Data, single: total=71.00GiB, used=70.26GiB
System, single: total=32.00MiB, used=16.00KiB
Metadata, single: total=22.00GiB, used=9.48GiB
GlobalReserve, single: total=512.00MiB, used=0.00B
root@phoenix:/var/lib/lxc#



An unfiltered balance shows ENOSPC errors:
btrfs balance start /var/lib/lxc

Last bit of:
dmesg | tail -n 100


[  920.915627] BTRFS info (device dm-4): found 67520 extents
[  922.037071] BTRFS info (device dm-4): relocating block group 
1703106576384 flags data
[  924.742432] BTRFS info (device dm-4): found 57082 extents
[  927.245236] BTRFS info (device dm-4): found 57082 extents
[  928.371624] BTRFS info (device dm-4): relocating block group 
1702032834560 flags data
[  931.230841] BTRFS info (device dm-4): found 60454 extents
[  933.373249] BTRFS info (device dm-4): found 60454 extents
[  934.336628] BTRFS info (device dm-4): relocating block group 
1700959092736 flags data
[  937.330097] BTRFS info (device dm-4): found 67151 extents
[  940.296250] BTRFS info (device dm-4): found 67151 extents
[  941.524664] BTRFS info (device dm-4): relocating block group 
1699885350912 flags data
[  944.264618] BTRFS info (device dm-4): found 54931 extents
[  945.910666] BTRFS info (device dm-4): found 54931 extents
[  946.796308] BTRFS info (device dm-4): relocating block group 
1698811609088 flags data
[  949.426823] BTRFS info (device dm-4): found 55428 extents
[  950.880553] BTRFS info (device dm-4): found 55428 extents
[  951.622569] BTRFS info (device dm-4): relocating block group 
1697737867264 flags data
[  955.223382] BTRFS info (device dm-4): found 52897 extents
[  956.544084] BTRFS info (device dm-4): found 52897 extents
[  957.300021] BTRFS info (device dm-4): relocating block group 
1696664125440 flags data
[  959.936585] BTRFS info (device dm-4): found 48407 extents
[  961.421771] BTRFS info (device dm-4): found 48407 extents
[  962.203680] BTRFS info (device dm-4): relocating block group 
1695590383616 flags data
[  964.281128] BTRFS info (device dm-4): found 28238 extents
[  965.325130] BTRFS info (device dm-4): found 28238 extents
[  965.886794] BTRFS info (device dm-4): relocating block group 
1694516641792 flags data
[  968.999507] BTRFS info (device dm-4): found 46060 extents
[  970.447815] BTRFS info (device dm-4): found 46060 extents
[  971.276287] BTRFS info (device dm-4): relocating block group 
1693442899968 flags data
[  974.914746] BTRFS info (device dm-4): found 55159 extents
[  976.914228] BTRFS info (device dm-4): found 55159 extents
[  977.758643] BTRFS info (device dm-4): relocating block group 
1692369158144 flags data
[  980.081069] BTRFS info (device dm-4): found 36859 extents
[  981.630065] BTRFS info (device dm-4): found 36859 extents
[  982.498586] BTRFS info (device dm-4): relocating block group 
1691295416320 flags data
[  984.929101] BTRFS info (device dm-4): found 50062 extents
[  986.440469] BTRFS info (device dm-4): found 50062 extents
[  987.281364] BTRFS info (device dm-4): 11 enospc errors during balance
[  987.281365] BTRFS info (device dm-4): balance: ended with status: -28

Unfortunately I don't seem to have any more info in dmesg of the enospc 
errors:

root@phoenix:/var/lib/lxc# dmesg | grep enospc
[  987.281364] BTRFS info (device dm-4): 11 enospc errors during balance

root@phoenix:/var/lib/lxc# dmesg | grep ENOSPC
root@phoenix:/var/lib/lxc#

I've seen something a little odd in /var/log/messages, not sure it is 
related.:
Sep 20 13:05:07 phoenix named[1805]: zone 30.20.10.in-addr.arpa/IN: not 
loaded due to errors.
Sep 20 13:05:08 phoenix kernel: [    0.500023]  PPR NX GT IA GA PC GA_vAPIC
Sep 20 13:05:09 phoenix kernel: [    0.827723] Loading Adaptec I2O RAID: 
Version 2.4 Build 5go
Sep 20 13:05:09 phoenix kernel: [    0.829457] GDT-HA: Storage RAID 
Controller Driver. Version: 3.05
Sep 20 13:05:09 phoenix kernel: [    0.829615] 3ware Storage Controller 
device driver for Linux v1.26.02.003.
Sep 20 13:05:09 phoenix kernel: [    0.829766] 3ware 9000 Storage 
Controller device driver for Linux v2.26.02.014.
Sep 20 13:05:09 phoenix kernel: [    1.039111] nvme nvme0: missing or 
invalid SUBNQN field.
Sep 20 13:05:09 phoenix kernel: [    5.430984] ata5.00: supports DRM 
functions and may not be fully accessible
Sep 20 13:05:09 phoenix kernel: [   77.750030] RAX: ffffffffffffffda 
RBX: 00005648284a1610 RCX: 00007fc76dd7736f
Sep 20 13:05:09 phoenix kernel: [   77.750031] RDX: 0000000000000002 
RSI: 0000000000000080 RDI: 00005648284a16ac
Sep 20 13:05:09 phoenix kernel: [   77.750031] RBP: 00007fc7671e8e90 
R08: 00005648284a1600 R09: 0000000000000000
Sep 20 13:05:09 phoenix kernel: [   77.750032] R10: 0000000000000000 
R11: 0000000000000246 R12: 00007fc7671e8e88
Sep 20 13:05:09 phoenix kernel: [   77.750033] R13: 00007fc7671e8e80 
R14: 00007fc7671e8e98 R15: 00005648284a1610
Sep 20 13:05:09 phoenix kernel: [   77.750035] Call Trace:
Sep 20 13:05:09 phoenix kernel: [   77.750036]  ? __schedule+0x211/0x820
Sep 20 13:05:09 phoenix kernel: [   77.750038]  schedule+0x32/0x70
Sep 20 13:05:09 phoenix kernel: [   77.750040] 
futex_wait_queue_me+0xce/0x140
Sep 20 13:05:09 phoenix kernel: [   77.750041]  futex_wait+0xef/0x240
Sep 20 13:05:09 phoenix kernel: [   77.750043]  do_futex+0x17d/0xce0
Sep 20 13:05:09 phoenix kernel: [   77.750045]  ? __switch_to_asm+0x41/0x70


After no issues in quite a while I seem to be hitting a fair few at 
present.  No idea if I am doing something new.

Pete





