Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE14412F5EC
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 10:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgACJIu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 04:08:50 -0500
Received: from naboo.endor.pl ([91.194.229.149]:41567 "EHLO naboo.endor.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgACJIu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 04:08:50 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id 9937B1A14CC;
        Fri,  3 Jan 2020 10:08:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iONzIbutvgPW; Fri,  3 Jan 2020 10:08:47 +0100 (CET)
Received: from [192.168.18.35] (91-231-23-50.studiowik.net.pl [91.231.23.50])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id 617711A148B;
        Fri,  3 Jan 2020 10:08:47 +0100 (CET)
From:   Leszek Dubiel <leszek@dubiel.pl>
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
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
 <5e6e2ff8-89be-45db-49d3-802de42663ed@dubiel.pl>
 <CAJCQCtSr9j8AzLRfguHb8+9n_snxmpXkw0V+LiuDnqqvLVAxKQ@mail.gmail.com>
Message-ID: <283b1c8a-9923-4612-0bbf-acb2a731e726@dubiel.pl>
Date:   Fri, 3 Jan 2020 10:08:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSr9j8AzLRfguHb8+9n_snxmpXkw0V+LiuDnqqvLVAxKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl-PL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



W dniu 03.01.2020 o 00:22, Chris Murphy pisze:
 > On Thu, Jan 2, 2020 at 3:39 PM Leszek Dubiel <leszek@dubiel.pl> wrote:
 >
 > > This system could have a few million (!) of small files.
 > > On reiserfs it takes about 40 minutes, to do "find /".
 > > Rsync runs for 6 hours to backup data.
 >
 >
 > There is a mount option:  max_inline=<bytes> which the man page says
 > (default: min(2048, page size) )
 >
 > I've never used it, so in theory the max_inline byte size is 2KiB.
 > However, I have seen substantially larger inline extents than 2KiB
 > when using a nodesize larger than 16KiB at mkfs time.
 >
 > I've wondered whether it makes any difference for the "many small
 > files" case to do more aggressive inlining of extents.
 >
 > I've seen with 16KiB leaf size, often small files that could be
 > inlined, are instead put into a data block group, taking up a minimum
 > 4KiB block size (on x64_64 anyway). I'm not sure why, but I suspect
 > there just isn't enough room in that leaf to always use inline
 > extents, and yet there is enough room to just reference it as a data
 > block group extent. When using a larger node size, a larger percentage
 > of small files ended up using inline extents. I'd expect this to be
 > quite a bit more efficient, because it eliminates a time expensive (on
 > HDD anyway) seek.

I will try that option when making new disks with BTRFS.
Then I'll report about efficiency.





 > Another optimization, using compress=zstd:1, which is the lowest
 > compression setting. That'll increase the chance a file can use inline
 > extents, in particular with a larger nodesize.
 >
 > And still another optimization, at the expense of much more
 > complexity, is LVM cache with an SSD. You'd have to pick a suitable
 > policy for the workload, but I expect that if the iostat utilizations
 > you see of often near max utilization in normal operation, you'll see
 > improved performance. SSD's can handle way higher iops than HDD. But a
 > lot of this optimization stuff is use case specific. I'm not even sure
 > what your mean small file size is.



There is 11 million files:

root@gamma:/mnt/sdb1# find orion2 > listor2
root@gamma:/mnt/sdb1# ls -lt listor2
-rw-r--r-- 1 root root 988973729 sty  3 03:09 listor2
root@gamma:/mnt/sdb1# wc -l listor2
11329331 listor2


And df on reiserfs shows:

root@orion:~# df  -h -BM
System plików    1M-bl   used      avail %uż. zamont. na
/dev/md0        71522M  10353M   61169M  15% /
/dev/md1       905967M 731199M  174768M  81% /root

10353 + 731199 = 741552 M,

that is average file size is 741552 * 1000000 / 11000000 = 67413 bytes 
per file.
This estimation is not good, because df counts in blocks...

I will count more precisely with df --apparent-size.





 >> # iotop -d30
 >>
 >> Total DISK READ:        34.12 M/s | Total DISK WRITE: 40.36 M/s
 >> Current DISK READ:      34.12 M/s | Current DISK WRITE:      79.22 M/s
 >>    TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN IO> COMMAND
 >>   4596 be/4 root       34.12 M/s   37.79 M/s  0.00 % 91.77 % btrfs
 >
 > Not so bad for many small file reads and writes with HDD. I've see
 > this myself with single spindle when doing small file reads and
 > writes.


So small files slow down in my case.
Ok! Thank you for the expertise.



PS. This morning:

root@wawel:~# btrfs bala stat /
Balance on '/' is running
1227 out of about 1231 chunks balanced (5390 considered),   0% left

So during the night it balanced  600Gb + 600Gb = 1.2Tb of
data in single profile to raid1 in about 12 hours. That is:

(600 + 600) * 1000 Mb/Gb / (12 hours * 3600 sec/hour)
       = (600 + 600) * 1000 / (12 × 3600)
             = 27 Mb/sec




root@wawel:~# btrfs dev usag /
/dev/sda2, ID: 2
    Device size:             5.45TiB
    Device slack:              0.00B
    Data,RAID1:              2.62TiB
    Metadata,RAID1:         22.00GiB
    Unallocated:             2.81TiB

/dev/sdb2, ID: 3
    Device size:             5.45TiB
    Device slack:              0.00B
    Data,RAID1:              2.62TiB
    Metadata,RAID1:         21.00GiB
    System,RAID1:           32.00MiB
    Unallocated:             2.81TiB

/dev/sdc3, ID: 4
    Device size:            10.90TiB
    Device slack:            3.50KiB
    Data,RAID1:              5.24TiB
    Metadata,RAID1:         33.00GiB
    System,RAID1:           32.00MiB
    Unallocated:             5.62TiB





root@wawel:~# iostat 10  -x
Linux 4.19.0-6-amd64 (wawel)     03.01.2020     _x86_64_    (8 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,00    0,00    0,00    0,00    0,00  100,00

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
sda              0,00    0,00      0,00      0,00     0,00 0,00   0,00   
0,00    0,00    0,00   0,00     0,00     0,00 0,00   0,00
sdb              0,00    0,00      0,00      0,00     0,00 0,00   0,00   
0,00    0,00    0,00   0,00     0,00     0,00 0,00   0,00
sdc              0,00    0,00      0,00      0,00     0,00 0,00   0,00   
0,00    0,00    0,00   0,00     0,00     0,00 0,00   0,00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,04    0,00    0,08    0,00    0,00   99,89

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
sda              0,00    0,00      0,00      0,00     0,00 0,00   0,00   
0,00    0,00    0,00   0,00     0,00     0,00 0,00   0,00
sdb              0,00    0,00      0,00      0,00     0,00 0,00   0,00   
0,00    0,00    0,00   0,00     0,00     0,00 0,00   0,00
sdc              0,00    0,00      0,00      0,00     0,00 0,00   0,00   
0,00    0,00    0,00   0,00     0,00     0,00 0,00   0,00






