Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8EC113113C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 12:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgAFLOL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 06:14:11 -0500
Received: from naboo.endor.pl ([91.194.229.149]:54402 "EHLO naboo.endor.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgAFLOL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 06:14:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id 3A2D11A11C0;
        Mon,  6 Jan 2020 12:14:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6ZRol7Pmu0aT; Mon,  6 Jan 2020 12:14:02 +0100 (CET)
Received: from [192.168.1.16] (acjy229.neoplus.adsl.tpnet.pl [83.10.74.229])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id DADBC1A11BD;
        Mon,  6 Jan 2020 12:14:01 +0100 (CET)
From:   Leszek Dubiel <leszek@dubiel.pl>
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com>
 <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
 <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com>
 <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
 <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
 <2c135c87-d01b-53f1-9f76-a5653918a4e7@dubiel.pl>
 <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
 <20191228202344.GE13306@hungrycats.org>
 <c278f501-f5a5-c905-5431-2d735e97fa13@dubiel.pl>
 <CAJCQCtRvAZS1CNgJLdUZTNeUma6A74oPT-SeQe7NYHhXKrMzoA@mail.gmail.com>
Message-ID: <4aff5709-5644-daa8-08b9-94dcefe65b19@dubiel.pl>
Date:   Mon, 6 Jan 2020 12:14:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRvAZS1CNgJLdUZTNeUma6A74oPT-SeQe7NYHhXKrMzoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl-PL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



W dniu 02.01.2020 o 22:57, Chris Murphy pisze:

 > but I would say that in retrospect it would have been better to NOT
 > delete the device with a few bad sectors, and instead use `btrfs
 > replace` to do a 1:1 replacement of that particular drive.


Tested "replace" on ahother server:

     root@zefir:~# btrfs replace start /dev/sde1 /dev/sdb3 /

and speed was quite normal:

     1.49 TiB * ( 1024 * 1024 MiB/TiB ) / ( 4.5 hours * 3600 sec/hour )
         =     1.49 * ( 1024 * 1024 ) / ( 4.5 * 3600 )   =  96.44 MiB / sec


Questions:

1. it is a little bit confusing that kerner reports sdc1 and sde1 on the 
same line: "BTRFS warning (device sdc1): i/o error ... on dev 
/dev/sde1"....

2. can I reset counters of errors for /dev/sda1? there were errors due 
to malfunctioning SATA cable, cable was replaced and counters don't grow 
any more; btrfs withstood that failure with no data loss



=======================================

root@zefir:~# tail /var/log/kern.log
Jan  6 00:19:37 zefir kernel: [33959.394053] BTRFS info (device sdc1): 
dev_replace from /dev/sde1 (devid 4) to /dev/sdb3 started
Jan  6 00:50:32 zefir kernel: [35815.080061] INFO: NMI handler 
(perf_event_nmi_handler) took too long to run: 1.126 msecs
Jan  6 04:48:25 zefir kernel: [50087.254634] BTRFS info (device sdc1): 
dev_replace from /dev/sde1 (devid 4) to /dev/sdb3 finished



root@zefir:~# btrfs dev usage /
/dev/sda1, ID: 5
    Device size:             1.80TiB
    Device slack:              0.00B
    Data,RAID1:              1.51TiB
    Metadata,RAID1:         20.00GiB
    System,RAID1:           32.00MiB
    Unallocated:           279.97GiB

/dev/sdb3, ID: 4
    Device size:             1.80TiB
    Device slack:            1.77GiB  <<<<------------
    Data,RAID1:              1.49TiB
    Metadata,RAID1:         42.00GiB
    Unallocated:           280.00GiB

/dev/sdc1, ID: 1
    Device size:             1.80TiB
    Device slack:              0.00B
    Data,RAID1:              1.50TiB
    Metadata,RAID1:         30.00GiB
    Unallocated:           278.00GiB

/dev/sdd1, ID: 3
    Device size:             1.80TiB
    Device slack:              0.00B
    Data,RAID1:              1.50TiB
    Metadata,RAID1:         36.00GiB
    Unallocated:           277.00GiB

/dev/sdf1, ID: 2
    Device size:             1.80TiB
    Device slack:              0.00B
    Data,RAID1:              1.49TiB
    Metadata,RAID1:         40.00GiB
    System,RAID1:           32.00MiB
    Unallocated:           279.97GiB




# reduce slack
root@zefir:~# btrfs fi resize 4:max /
Resize '/' of '4:max'
root@zefir:~# btrfs dev usage /
...
/dev/sdb3, ID: 4
    Device size:             1.80TiB
    Device slack:            3.50KiB <<<<<<<<<<<<<<<<<<<<
    Data,RAID1:              1.49TiB
    Metadata,RAID1:         42.00GiB
    Unallocated:           281.77GiB
...




root@zefir:~# btrfs dev stat /
[/dev/sdc1].write_io_errs    0
[/dev/sdc1].read_io_errs     0
[/dev/sdc1].flush_io_errs    0
[/dev/sdc1].corruption_errs  0
[/dev/sdc1].generation_errs  0
[/dev/sdf1].write_io_errs    0
[/dev/sdf1].read_io_errs     0
[/dev/sdf1].flush_io_errs    0
[/dev/sdf1].corruption_errs  0
[/dev/sdf1].generation_errs  0
[/dev/sdd1].write_io_errs    0
[/dev/sdd1].read_io_errs     0
[/dev/sdd1].flush_io_errs    0
[/dev/sdd1].corruption_errs  0
[/dev/sdd1].generation_errs  0
[/dev/sdb3].write_io_errs    0
[/dev/sdb3].read_io_errs     0
[/dev/sdb3].flush_io_errs    0
[/dev/sdb3].corruption_errs  0
[/dev/sdb3].generation_errs  0
[/dev/sda1].write_io_errs    10418
[/dev/sda1].read_io_errs     227
[/dev/sda1].flush_io_errs    117
[/dev/sda1].corruption_errs  77
[/dev/sda1].generation_errs  47




# erorr count doesn't change any more:
root@zefir:/mnt/root/zefir_snaps# egrep . */root/btrfs_dev_stat  | egrep 
write_io_errs | egrep sda1 | egrep ' 23:'
2019-12-27 23:50:01 z 
harmonogramu/root/btrfs_dev_stat:[/dev/sda1].write_io_errs 10418
2019-12-28 23:50:01 z 
harmonogramu/root/btrfs_dev_stat:[/dev/sda1].write_io_errs 10418
2019-12-29 23:50:01 z 
harmonogramu/root/btrfs_dev_stat:[/dev/sda1].write_io_errs 10418
2019-12-30 23:50:02 z 
harmonogramu/root/btrfs_dev_stat:[/dev/sda1].write_io_errs 10418
2019-12-31 23:50:01 z 
harmonogramu/root/btrfs_dev_stat:[/dev/sda1].write_io_errs 10418
2020-01-01 23:50:01 z 
harmonogramu/root/btrfs_dev_stat:[/dev/sda1].write_io_errs 10418
2020-01-02 23:50:03 z 
harmonogramu/root/btrfs_dev_stat:[/dev/sda1].write_io_errs 10418
2020-01-03 23:50:01 z 
harmonogramu/root/btrfs_dev_stat:[/dev/sda1].write_io_errs 10418
2020-01-04 23:50:01 z 
harmonogramu/root/btrfs_dev_stat:[/dev/sda1].write_io_errs 10418
2020-01-05 23:00:01 z 
harmonogramu/root/btrfs_dev_stat:[/dev/sda1].write_io_errs 10418
2020-01-05 23:10:03 z 
harmonogramu/root/btrfs_dev_stat:[/dev/sda1].write_io_errs 10418
2020-01-05 23:20:01 z 
harmonogramu/root/btrfs_dev_stat:[/dev/sda1].write_io_errs 10418
2020-01-05 23:30:01 z 
harmonogramu/root/btrfs_dev_stat:[/dev/sda1].write_io_errs 10418
2020-01-05 23:40:01 z 
harmonogramu/root/btrfs_dev_stat:[/dev/sda1].write_io_errs 10418
2020-01-05 23:50:01 z 
harmonogramu/root/btrfs_dev_stat:[/dev/sda1].write_io_errs 10418



######### kernel log
root@zefir:~# cat /var/log/kern.log | egrep BTRFS
Jan  5 13:52:09 zefir kernel: [1291932.446093] BTRFS warning (device 
sdc1): i/o error at logical 11658111352832 on dev /dev/sde1, physical 
867246145536: metadata leaf (level 0) in tree 9109477097472
Jan  5 13:52:09 zefir kernel: [1291932.446095] BTRFS warning (device 
sdc1): i/o error at logical 11658111352832 on dev /dev/sde1, physical 
867246145536: metadata leaf (level 0) in tree 9109477097472
Jan  5 13:52:09 zefir kernel: [1291932.446098] BTRFS error (device 
sdc1): bdev /dev/sde1 errs: wr 0, rd 2, flush 0, corrupt 0, gen 0
Jan  5 13:52:09 zefir kernel: [1291932.689845] BTRFS error (device 
sdc1): fixed up error at logical 11658111352832 on dev /dev/sde1
Jan  5 14:54:30 zefir kernel: [    4.654734] BTRFS: device fsid 
dd38db97-fa4a-479b-bc1b-973f01a61a8a devid 1 transid 257 /dev/sdd3
Jan  5 14:54:30 zefir kernel: [    4.654855] BTRFS: device fsid 
0a75ba3d-0540-4370-bb04-22470e855caa devid 1 transid 241 /dev/sdf3
Jan  5 14:54:30 zefir kernel: [    4.655047] BTRFS: device fsid 
e2652ff5-6d5e-45de-912c-a662f92c10f0 devid 1 transid 280 /dev/sde3
Jan  5 14:54:30 zefir kernel: [    4.655200] BTRFS: device fsid 
8e960630-2b51-452b-b026-abc59dcf5f35 devid 1 transid 61 /dev/sda3
Jan  5 14:54:30 zefir kernel: [    4.661180] BTRFS: device fsid 
c100cf56-f210-42d7-a953-bbe1974a28f0 devid 1 transid 292 /dev/sdc3
Jan  5 14:54:30 zefir kernel: [    4.661331] BTRFS: device fsid 
9d6e641c-ec71-411e-9312-f1f67a70913f devid 3 transid 2500779 /dev/sdd1
Jan  5 14:54:30 zefir kernel: [    4.661450] BTRFS: device fsid 
9d6e641c-ec71-411e-9312-f1f67a70913f devid 2 transid 2500779 /dev/sdf1
Jan  5 14:54:30 zefir kernel: [    4.663399] BTRFS: device fsid 
9d6e641c-ec71-411e-9312-f1f67a70913f devid 4 transid 2500779 /dev/sde1
Jan  5 14:54:30 zefir kernel: [    4.663547] BTRFS: device fsid 
9d6e641c-ec71-411e-9312-f1f67a70913f devid 5 transid 2500779 /dev/sda1
Jan  5 14:54:30 zefir kernel: [    4.663779] BTRFS: device fsid 
9d6e641c-ec71-411e-9312-f1f67a70913f devid 1 transid 2500779 /dev/sdc1
Jan  5 14:54:30 zefir kernel: [    4.695640] BTRFS info (device sdc1): 
disk space caching is enabled
Jan  5 14:54:30 zefir kernel: [    4.695642] BTRFS info (device sdc1): 
has skinny extents
Jan  5 14:54:30 zefir kernel: [    5.363215] BTRFS info (device sdc1): 
bdev /dev/sde1 errs: wr 0, rd 2, flush 0, corrupt 0, gen 0
Jan  5 14:54:30 zefir kernel: [    5.363219] BTRFS info (device sdc1): 
bdev /dev/sda1 errs: wr 10418, rd 227, flush 117, corrupt 77, gen 47
Jan  5 14:54:30 zefir kernel: [   37.646828] BTRFS info (device sdc1): 
disk space caching is enabled
Jan  5 19:55:25 zefir kernel: [18107.366949] BTRFS warning (device 
sdc1): i/o error at logical 8728914731008 on dev /dev/sde1, physical 
1395531751424, root 119218, inode 63539433, offset 138190848, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:25 zefir kernel: [18107.366952] BTRFS warning (device 
sdc1): i/o error at logical 8728912101376 on dev /dev/sde1, physical 
1395529121792, root 119218, inode 63539433, offset 135561216, length 
4096, links 1 (path: var/mail/bem1)
------------------------------------------------
------ 8< cut many similar erorrs ------------------
------------------------------------------------
Jan  5 19:55:25 zefir kernel: [18107.368411] BTRFS warning (device 
sdc1): i/o error at logical 8728912101376 on dev /dev/sde1, physical 
1395529121792, root 119122, inode 63539433, offset 135561216, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:25 zefir kernel: [18107.368413] BTRFS warning (device 
sdc1): i/o error at logical 8728914731008 on dev /dev/sde1, physical 
1395531751424, root 119122, inode 63539433, offset 138190848, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:25 zefir kernel: [18107.368441] BTRFS warning (device 
sdc1): i/o error at logical 8728914731008 on dev /dev/sde1, physical 
1395531751424, root 119120, inode 63539433, offset 138190848, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:25 zefir kernel: [18107.368443] BTRFS warning (device 
sdc1): i/o error at logical 8728912101376 on dev /dev/sde1, physical 
1395529121792, root 119120, inode 63539433, offset 135561216, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:25 zefir kernel: [18107.446304] BTRFS error (device sdc1): 
bdev /dev/sde1 errs: wr 0, rd 3, flush 0, corrupt 0, gen 0
Jan  5 19:55:25 zefir kernel: [18107.446306] BTRFS error (device sdc1): 
bdev /dev/sde1 errs: wr 0, rd 4, flush 0, corrupt 0, gen 0
Jan  5 19:55:25 zefir kernel: [18107.446450] BTRFS error (device sdc1): 
bdev /dev/sde1 errs: wr 0, rd 5, flush 0, corrupt 0, gen 0
Jan  5 19:55:25 zefir kernel: [18107.473619] BTRFS error (device sdc1): 
fixed up error at logical 8728912101376 on dev /dev/sde1
Jan  5 19:55:29 zefir kernel: [18111.775171] BTRFS error (device sdc1): 
fixed up error at logical 8728914731008 on dev /dev/sde1
Jan  5 19:55:29 zefir kernel: [18111.775336] BTRFS error (device sdc1): 
fixed up error at logical 8728913416192 on dev /dev/sde1
Jan  5 19:55:29 zefir kernel: [18111.778932] BTRFS error (device sdc1): 
bdev /dev/sde1 errs: wr 0, rd 6, flush 0, corrupt 0, gen 0
Jan  5 19:55:29 zefir kernel: [18111.779367] BTRFS error (device sdc1): 
fixed up error at logical 8728912105472 on dev /dev/sde1
Jan  5 19:55:34 zefir kernel: [18116.660449] BTRFS warning (device 
sdc1): i/o error at logical 8728914735104 on dev /dev/sde1, physical 
1395531755520, root 119218, inode 63539433, offset 138194944, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:34 zefir kernel: [18116.660476] BTRFS warning (device 
sdc1): i/o error at logical 8728914735104 on dev /dev/sde1, physical 
1395531755520, root 119216, inode 63539433, offset 138194944, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:34 zefir kernel: [18116.660502] BTRFS warning (device 
sdc1): i/o error at logical 8728914735104 on dev /dev/sde1, physical 
1395531755520, root 119214, inode 63539433, offset 138194944, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:34 zefir kernel: [18116.660528] BTRFS warning (device 
sdc1): i/o error at logical 8728914735104 on dev /dev/sde1, physical 
1395531755520, root 119212, inode 63539433, offset 138194944, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:34 zefir kernel: [18116.660554] BTRFS warning (device 
sdc1): i/o error at logical 8728914735104 on dev /dev/sde1, physical 
1395531755520, root 119210, inode 63539433, offset 138194944, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:34 zefir kernel: [18116.660580] BTRFS warning (device 
sdc1): i/o error at logical 8728914735104 on dev /dev/sde1, physical 
1395531755520, root 119208, inode 63539433, offset 138194944, length 
4096, links 1 (path: var/mail/bem1)
------------------------------------------------
------ 8< cut many similar erorrs ------------------
------------------------------------------------
Jan  5 19:55:34 zefir kernel: [18116.662869] BTRFS warning (device 
sdc1): i/o error at logical 8728914735104 on dev /dev/sde1, physical 
1395531755520, root 118872, inode 63539433, offset 138194944, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:34 zefir kernel: [18116.662894] BTRFS warning (device 
sdc1): i/o error at logical 8728914735104 on dev /dev/sde1, physical 
1395531755520, root 118860, inode 63539433, offset 138194944, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:34 zefir kernel: [18116.662919] BTRFS warning (device 
sdc1): i/o error at logical 8728914735104 on dev /dev/sde1, physical 
1395531755520, root 118848, inode 63539433, offset 138194944, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:34 zefir kernel: [18116.663077] BTRFS warning (device 
sdc1): i/o error at logical 8728914735104 on dev /dev/sde1, physical 
1395531755520, root 118836, inode 63539433, offset 138194944, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:34 zefir kernel: [18116.663104] BTRFS warning (device 
sdc1): i/o error at logical 8728914735104 on dev /dev/sde1, physical 
1395531755520, root 118824, inode 63539433, offset 138194944, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:34 zefir kernel: [18116.663863] BTRFS error (device sdc1): 
bdev /dev/sde1 errs: wr 0, rd 7, flush 0, corrupt 0, gen 0
Jan  5 19:55:38 zefir kernel: [18120.678251] BTRFS error (device sdc1): 
fixed up error at logical 8728914735104 on dev /dev/sde1
Jan  5 19:55:38 zefir kernel: [18120.681960] BTRFS error (device sdc1): 
bdev /dev/sde1 errs: wr 0, rd 8, flush 0, corrupt 0, gen 0
Jan  5 19:55:42 zefir kernel: [18124.968600] BTRFS warning (device 
sdc1): i/o error at logical 8728913420288 on dev /dev/sde1, physical 
1395530440704, root 119218, inode 63539433, offset 136880128, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:42 zefir kernel: [18124.968627] BTRFS warning (device 
sdc1): i/o error at logical 8728913420288 on dev /dev/sde1, physical 
1395530440704, root 119216, inode 63539433, offset 136880128, length 
4096, links 1 (path: var/mail/bem1)
------------------------------------------------
------ 8< cut many similar erorrs ------------------
------------------------------------------------
Jan  5 19:55:42 zefir kernel: [18124.968961] BTRFS warning (device 
sdc1): i/o error at logical 8728913420288 on dev /dev/sde1, physical 
1395530440704, root 119190, inode 63539433, offset 136880128, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:42 zefir kernel: [18124.968986] BTRFS warning (device 
sdc1): i/o error at logical 8728913420288 on dev /dev/sde1, physical 
1395530440704, root 119188, inode 63539433, offset 136880128, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:42 zefir kernel: [18124.969010] BTRFS error (device sdc1): 
fixed up error at logical 8728912109568 on dev /dev/sde1
Jan  5 19:55:42 zefir kernel: [18124.969012] BTRFS warning (device 
sdc1): i/o error at logical 8728913420288 on dev /dev/sde1, physical 
1395530440704, root 119186, inode 63539433, offset 136880128, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:42 zefir kernel: [18124.969038] BTRFS warning (device 
sdc1): i/o error at logical 8728913420288 on dev /dev/sde1, physical 
1395530440704, root 119184, inode 63539433, offset 136880128, length 
4096, links 1 (path: var/mail/bem1)
------------------------------------------------
------ 8< cut many similar erorrs ------------------
------------------------------------------------
Jan  5 19:55:42 zefir kernel: [18124.971065] BTRFS warning (device 
sdc1): i/o error at logical 8728913420288 on dev /dev/sde1, physical 
1395530440704, root 118872, inode 63539433, offset 136880128, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:42 zefir kernel: [18124.971091] BTRFS warning (device 
sdc1): i/o error at logical 8728913420288 on dev /dev/sde1, physical 
1395530440704, root 118860, inode 63539433, offset 136880128, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:42 zefir kernel: [18124.971117] BTRFS warning (device 
sdc1): i/o error at logical 8728913420288 on dev /dev/sde1, physical 
1395530440704, root 118848, inode 63539433, offset 136880128, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:42 zefir kernel: [18124.971143] BTRFS warning (device 
sdc1): i/o error at logical 8728913420288 on dev /dev/sde1, physical 
1395530440704, root 118836, inode 63539433, offset 136880128, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:42 zefir kernel: [18124.971169] BTRFS warning (device 
sdc1): i/o error at logical 8728913420288 on dev /dev/sde1, physical 
1395530440704, root 118824, inode 63539433, offset 136880128, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:42 zefir kernel: [18124.971948] BTRFS error (device sdc1): 
bdev /dev/sde1 errs: wr 0, rd 9, flush 0, corrupt 0, gen 0
Jan  5 19:55:42 zefir kernel: [18125.004219] BTRFS error (device sdc1): 
fixed up error at logical 8728913420288 on dev /dev/sde1
Jan  5 19:55:47 zefir kernel: [18129.529678] BTRFS error (device sdc1): 
bdev /dev/sde1 errs: wr 0, rd 10, flush 0, corrupt 0, gen 0
Jan  5 19:55:51 zefir kernel: [18133.498294] BTRFS error (device sdc1): 
fixed up error at logical 8728914739200 on dev /dev/sde1
Jan  5 19:55:51 zefir kernel: [18133.498938] BTRFS warning (device 
sdc1): i/o error at logical 8728913424384 on dev /dev/sde1, physical 
1395530444800, root 119218, inode 63539433, offset 136884224, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:51 zefir kernel: [18133.498966] BTRFS warning (device 
sdc1): i/o error at logical 8728913424384 on dev /dev/sde1, physical 
1395530444800, root 119216, inode 63539433, offset 136884224, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:51 zefir kernel: [18133.498992] BTRFS warning (device 
sdc1): i/o error at logical 8728913424384 on dev /dev/sde1, physical 
1395530444800, root 119214, inode 63539433, offset 136884224, length 
4096, links 1 (path: var/mail/bem1)
------------------------------------------------
------ 8< cut many similar erorrs ------------------
------------------------------------------------
Jan  5 19:55:51 zefir kernel: [18133.501578] BTRFS warning (device 
sdc1): i/o error at logical 8728913424384 on dev /dev/sde1, physical 
1395530444800, root 118848, inode 63539433, offset 136884224, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:51 zefir kernel: [18133.501604] BTRFS warning (device 
sdc1): i/o error at logical 8728913424384 on dev /dev/sde1, physical 
1395530444800, root 118836, inode 63539433, offset 136884224, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:51 zefir kernel: [18133.501629] BTRFS warning (device 
sdc1): i/o error at logical 8728913424384 on dev /dev/sde1, physical 
1395530444800, root 118824, inode 63539433, offset 136884224, length 
4096, links 1 (path: var/mail/bem1)
Jan  5 19:55:51 zefir kernel: [18133.502390] BTRFS error (device sdc1): 
bdev /dev/sde1 errs: wr 0, rd 11, flush 0, corrupt 0, gen 0
Jan  5 19:55:51 zefir kernel: [18133.525951] BTRFS error (device sdc1): 
fixed up error at logical 8728913424384 on dev /dev/sde1
Jan  6 00:19:37 zefir kernel: [33959.394053] BTRFS info (device sdc1): 
dev_replace from /dev/sde1 (devid 4) to /dev/sdb3 started
Jan  6 04:48:25 zefir kernel: [50087.254634] BTRFS info (device sdc1): 
dev_replace from /dev/sde1 (devid 4) to /dev/sdb3 finished



########## before replace (/dev/sde1 got errors):
[/dev/sdc1].write_io_errs    0
[/dev/sdc1].read_io_errs     0
[/dev/sdc1].flush_io_errs    0
[/dev/sdc1].corruption_errs  0
[/dev/sdc1].generation_errs  0
[/dev/sdf1].write_io_errs    0
[/dev/sdf1].read_io_errs     0
[/dev/sdf1].flush_io_errs    0
[/dev/sdf1].corruption_errs  0
[/dev/sdf1].generation_errs  0
[/dev/sdd1].write_io_errs    0
[/dev/sdd1].read_io_errs     0
[/dev/sdd1].flush_io_errs    0
[/dev/sdd1].corruption_errs  0
[/dev/sdd1].generation_errs  0
[/dev/sde1].write_io_errs    0
[/dev/sde1].read_io_errs     11
[/dev/sde1].flush_io_errs    0
[/dev/sde1].corruption_errs  0
[/dev/sde1].generation_errs  0
[/dev/sda1].write_io_errs    10418
[/dev/sda1].read_io_errs     227
[/dev/sda1].flush_io_errs    117
[/dev/sda1].corruption_errs  77
[/dev/sda1].generation_errs  47


root@zefir:/# smartctl -a /dev/sde | egrep 'Pending|Offline_Unc|Error 
Count'
197 Current_Pending_Sector  0x0012   100   100   000    Old_age 
Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age 
Offline      -       0
ATA Error Count: 16 (device log contains only the most recent five errors)



