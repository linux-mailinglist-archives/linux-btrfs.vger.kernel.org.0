Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B198252EF1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 14:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgHZMuA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 08:50:00 -0400
Received: from mail.dubielvitrum.pl ([91.194.229.150]:46411 "EHLO
        naboo.endor.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729324AbgHZMt7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 08:49:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id 091851A1F38;
        Wed, 26 Aug 2020 14:49:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 57KBeZWNaicB; Wed, 26 Aug 2020 14:49:53 +0200 (CEST)
Received: from [192.168.18.34] (91-231-23-50.studiowik.net.pl [91.231.23.50])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id 5AE481A21A5;
        Wed, 26 Aug 2020 14:49:52 +0200 (CEST)
From:   Leszek Dubiel <leszek@dubiel.pl>
Subject: Re: btrfs-transacti -- change from be/4 to idle (?)
To:     linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, hans@knorrie.org
References: <806a0681-6a1b-30d0-de28-8f18019913ad@dubiel.pl>
 <c4359a4d-ae86-1b12-1a33-9372fd81e84e@gmx.com>
Message-ID: <597d007e-6c33-6bf9-b160-9d4623c5ab8c@dubiel.pl>
Date:   Wed, 26 Aug 2020 14:49:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c4359a4d-ae86-1b12-1a33-9372fd81e84e@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl-PL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




 >> Hello!
 >>
 >> Process btrfs-transacti takes 100% CPU time and server get very slow.
 > What's the workload and kernel version?


root@wawel:/var/log/ipfm# uname -a
Linux wawel 4.19.0-9-amd64 #1 SMP Debian 4.19.118-2+deb10u1 (2020-06-07) 
x86_64 GNU/Linux


Actually limit is not CPU but hardidsk bandwidth. Sorry for that mistake.
On program "iotop" I often see 100% usage  for "btrfs-transacti".


Workload when I see 100% usage for btrf-transacti:

For CPU:

root@wawel:~# sar 2 4
Linux 4.19.0-9-amd64 (wawel)     26.08.2020     _x86_64_    (4 CPU)

14:18:35        CPU     %user     %nice   %system   %iowait %steal     %idle
14:18:37        all      0,50      0,00      0,63     16,02 0,00     82,85
14:18:39        all      0,25      0,00      0,50     15,72 0,00     83,52
14:18:41        all      0,50      0,00      1,25     17,02 0,00     81,23
14:18:43        all      0,50      0,00     16,81     17,69 0,00     64,99
Średnia:       all      0,44      0,00      4,80     16,61 0,00     78,15



For DISKS:

root@wawel:/var/log# sar -p -d 5 2
Linux 4.19.0-9-amd64 (wawel)     08/26/20     _x86_64_    (4 CPU)

14:45:49          DEV       tps     rkB/s     wkB/s   areq-sz aqu-sz     
await     svctm     %util
14:45:54          sdc      0.00      0.00      0.00      0.00 0.00      
0.00      0.00      0.00
14:45:54          sda      0.00      0.00      0.00      0.00 0.00      
0.00      0.00      0.00
14:45:54          sdd    369.60      0.00   6716.80     18.17 6.21     
16.95      1.15     42.48
14:45:54          sde      0.00      0.00      0.00      0.00 0.00      
0.00      0.00      0.00
14:45:54          sdb    369.00      0.00   6707.20     18.18 18.73     
51.30      2.66     98.08
14:45:54          sdf      0.00      0.00      0.00      0.00 0.00      
0.00      0.00      0.00

14:45:54          DEV       tps     rkB/s     wkB/s   areq-sz aqu-sz     
await     svctm     %util
14:45:59          sdc      0.00      0.00      0.00      0.00 0.00      
0.00      0.00      0.00
14:45:59          sda      0.00      0.00      0.00      0.00 0.00      
0.00      0.00      0.00
14:45:59          sdd    341.20      0.00   6716.80     19.69 7.25     
21.03      1.46     49.92
14:45:59          sde      1.00     15.20      0.00     15.20 0.01     
10.40      5.60      0.56
14:45:59          sdb    345.40      0.00   6780.80     19.63 18.55     
54.16      2.75     95.04
14:45:59          sdf      0.00      0.00      0.00      0.00 0.00      
0.00      0.00      0.00

Average:          DEV       tps     rkB/s     wkB/s   areq-sz aqu-sz     
await     svctm     %util
Average:          sdc      0.00      0.00      0.00      0.00 0.00      
0.00      0.00      0.00
Average:          sda      0.00      0.00      0.00      0.00 0.00      
0.00      0.00      0.00
Average:          sdd    355.40      0.00   6716.80     18.90 6.73     
18.91      1.30     46.20
Average:          sde      0.50      7.60      0.00     15.20 0.01     
10.40      5.60      0.28
Average:          sdb    357.20      0.00   6744.00     18.88 18.64     
52.68      2.70     96.56
Average:          sdf      0.00      0.00      0.00      0.00 0.00      
0.00      0.00      0.00






 > Workload can tell us if it's really a bug, and different kernel has
 > quite different perf characteristic, especially if you're using qgroup.
 > (If you're using qgroup, recent v5.x kernel should have it fixed already)

Don't use qgroup.





W dniu 26.08.2020 o 11:47, Hans van Kranenburg pisze:
 > Hi!
 >
 >> Process btrfs-transacti takes 100% CPU time and server get very slow.
 >
 > Is it slow and not doing much, or is it busy doing things, taking more
 > time than you would want? Those two things are quite different.

Acutually this was IO traffic not CPU time. Sorry for mistake. Thanks 
for help.



 >> It runs with priority "best effort be/4".
 >>
 >> Is it a good idea to change priority to "idle"?
 >
 >> root@wawel:/var/log# df -h  /
 >>
 >> Filesystem      Size  Used Avail Use% Mounted on
 >> /dev/sda2        20T   11T  7.7T  58% /
 >
 > Are you using space_cache=v2 already?
 >
 > 
https://events.static.linuxfound.org/sites/events/files/slides/vault2016_0.pdf


I use defaults as mount options:

root@wawel:~# cat /etc/fstab  | egrep btrfs
UUID=44803366-3981-4ebb-853b-6c991380c8a6 /             btrfs 
defaults,subvol=/wawel              0       0
UUID=44803366-3981-4ebb-853b-6c991380c8a6 /mnt/root     btrfs 
defaults,subvol=/     0       0



And here is superblock:

root@wawel:/var/log# btrfs inspect-internal dump-super /dev/sda2
superblock: bytenr=65536, device=/dev/sda2
---------------------------------------------------------
csum_type        0 (crc32c)
csum_size        4
csum            0xa4b9b4ab [match]
bytenr            65536
flags            0x1
             ( WRITTEN )
magic            _BHRfS_M [match]
fsid            44803366-3981-4ebb-853b-6c991380c8a6
metadata_uuid        44803366-3981-4ebb-853b-6c991380c8a6
label
generation        1168642
root            21221477498880
sys_array_size        129
chunk_root_generation    1168634
root_level        1
chunk_root        21753638895616
chunk_root_level    1
log_root        0
log_root_transid    0
log_root_level        0
total_bytes        43865979846656
bytes_used        11379069538304
sectorsize        4096
nodesize        16384
leafsize (deprecated)        16384
stripesize        4096
root_dir        6
num_devices        6
compat_flags        0x0
compat_ro_flags        0x0
incompat_flags        0x163
             ( MIXED_BACKREF |
               DEFAULT_SUBVOL |
               BIG_METADATA |
               EXTENDED_IREF |
               SKINNY_METADATA )
cache_generation    1168642
uuid_tree_generation    594
dev_item.uuid        485e6e62-6e43-46bf-ad0b-d9ed88d7f908
dev_item.fsid        44803366-3981-4ebb-853b-6c991380c8a6 [match]
dev_item.type        0
dev_item.total_bytes    5992192409600
dev_item.bytes_used    4445291151360
dev_item.io_align    4096
dev_item.io_width    4096
dev_item.sector_size    4096
dev_item.devid        2
dev_item.dev_group    0
dev_item.seek_speed    0
dev_item.bandwidth    0
dev_item.generation    0







I have also found report in kern.log:

Aug 16 03:36:01 wawel kernel: [2476445.318200] INFO: task btrfs:4311 
blocked for more than 120 seconds.
Aug 16 03:36:01 wawel kernel: [2476445.318214]       Not tainted 
4.19.0-9-amd64 #1 Debian 4.19.118-2+deb10u1
Aug 16 03:36:01 wawel kernel: [2476445.318219] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.



I wonder if system is broken. Scrub was done in 19 hours:

root@wawel:/var/log# btrfs scrub stat /
scrub status for 44803366-3981-4ebb-853b-6c991380c8a6
     scrub started at Sat Aug 22 14:19:01 2020 and finished after 19:17:16
     total bytes scrubbed: 20.15TiB with 0 errors














