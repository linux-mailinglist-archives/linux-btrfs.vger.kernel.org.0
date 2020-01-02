Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB5212EE93
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 23:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbgABWj2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 17:39:28 -0500
Received: from naboo.endor.pl ([91.194.229.149]:39136 "EHLO naboo.endor.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731461AbgABWj0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 17:39:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id 7AD571A167D;
        Thu,  2 Jan 2020 23:39:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kMwTcA-i6CYT; Thu,  2 Jan 2020 23:39:22 +0100 (CET)
Received: from [192.168.1.16] (aciu198.neoplus.adsl.tpnet.pl [83.10.44.198])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id D533B1A1681;
        Thu,  2 Jan 2020 23:39:15 +0100 (CET)
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
From:   Leszek Dubiel <leszek@dubiel.pl>
Message-ID: <5e6e2ff8-89be-45db-49d3-802de42663ed@dubiel.pl>
Date:   Thu, 2 Jan 2020 23:39:13 +0100
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


 > I'm not sure why it's slow and I don't think it should be this slow,
 > but I would say that in retrospect it would have been better to NOT
 > delete the device with a few bad sectors, and instead use `btrfs
 > replace` to do a 1:1 replacement of that particular drive.

Thank you. I will remember that.



 > When you delete a device, it has to rewrite everything onto the two
 > remaining device. And now that you added another device, it has to
 > rewrite everything onto three devices. Two full balances. Whereas
 > 'device replace' is optimized to copy block groups as-is from source
 > to destination drives. Only on a read-error will Btrfs use mirror
 > copies from other devices.

Thank you.





 > Almost no reads, all writes, but slow. And rather high write request
 > per second, almost double for sdc. And sdc is near it's max
 > utilization so it might be ear to its iops limit?
 >
 > ~210 rareq-sz = 210KiB is the average size of the read request for 
sda and sdb
 >
 > Default mkfs and default mount options? Or other and if so what other?
 >
 > Many small files on this file system? Or possibly large files with a
 > lot of fragmentation?

Default mkfs and default mount options.

This system could have a few million (!) of small files.
On reiserfs it takes about 40 minutes, to do "find /".
Rsync runs for 6 hours to backup data.





 >> Device            r/s     w/s     rMB/s     wMB/s rrqm/s wrqm/s
 >> %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
 >> sda              2,38  186,52      0,20      3,33 1,33 4,20  35,87
 >> 2,20    9,88    3,48   0,63    86,04    18,27 0,30   5,60
 >> sdb              1,00  108,35      0,02      1,99 0,00 2,73   0,00
 >> 2,46    8,92    3,78   0,41    18,00    18,85 0,27   2,98
 >> sdc             13,47  294,68      0,21      5,32 0,00 6,92   0,00
 >> 2,29   13,33   61,56  18,28    16,00    18,48 3,13  96,45
 >
 > And again, sdc is at max utilization, with ~300 write requests per
 > second which is at the high end for a fast drive for IOPS, if I'm not
 > mistaken. That's a lot of writes per second. The average write request
 > size is 18KiB.
 >
 > So what's going on with the workload? Is this only a balance operation
 > or are there concurrent writes happening from some process?

root@wawel:~# btrfs bala stat /
Balance on '/' is running
62 out of about 1231 chunks balanced (4224 considered),  95% left

root@wawel:~# btrfs scrub stat  /
scrub status for 44803366-3981-4ebb-853b-6c991380c8a6
     scrub started at Sat Dec 28 19:32:06 2019 and was aborted after 
03:07:57
     total bytes scrubbed: 3.33TiB with 0 errors

root@wawel:~# btrfs sub list -d /

root@wawel:~# btrfs sub list / | wc -l
27






 > iotop -d 5 -o might be more revealing; all zeros doesn't really make
 > sense. I see balance and scrub reported in iotop.


# iotop -d5

Total DISK READ:         0.00 B/s | Total DISK WRITE:        32.98 M/s
Current DISK READ:       0.00 B/s | Current DISK WRITE:      26.19 M/s
   TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN     IO> COMMAND
  4596 be/4 root        0.00 B/s   31.78 M/s  0.00 % 86.16 % btrfs 
balance start -dconvert raid1 soft -mconvert raid1 soft /
30893 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.16 % 
[kworker/0:2-events]
29683 be/4 root        0.00 B/s  659.23 K/s  0.00 %  0.00 % 
[kworker/u16:4-btrfs-extent-refs]
29684 be/4 root        0.00 B/s  560.50 K/s  0.00 %  0.00 % 
[kworker/u16:8-btrfs-extent-refs]
30115 be/4 root        0.00 B/s    6.37 K/s  0.00 %  0.00 % 
[kworker/u16:2-btrfs-extent-refs]
     1 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % init
     2 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [kthreadd]
     3 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [rcu_gp]
     4 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [rcu_par_gp]
     6 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % 
[kworker/0:0H-kblockd]






# iotop -d30

Total DISK READ:        34.12 M/s | Total DISK WRITE: 40.36 M/s
Current DISK READ:      34.12 M/s | Current DISK WRITE:      79.22 M/s
   TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN     IO> COMMAND
  4596 be/4 root       34.12 M/s   37.79 M/s  0.00 % 91.77 % btrfs 
balance start -dconvert raid1 soft -mconvert raid1 soft /
29687 be/4 root        0.00 B/s  465.87 K/s  0.00 %  0.32 % 
[kworker/u16:10-edac-poller]
30893 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.13 % 
[kworker/0:2-events_freezable_power_]
30115 be/4 root        0.00 B/s 1373.65 K/s  0.00 %  0.08 % 
[kworker/u16:2-btrfs-endio-write]
26871 be/4 root        0.00 B/s  260.89 K/s  0.00 %  0.03 % 
[kworker/u16:7-btrfs-extent-refs]
23756 be/4 root        0.00 B/s   80.40 K/s  0.00 %  0.00 % 
[kworker/u16:1-btrfs-extent-refs]
29681 be/4 root        0.00 B/s  169.84 K/s  0.00 %  0.00 % 
[kworker/u16:0-btrfs-extent-refs]
29683 be/4 root        0.00 B/s  280.59 K/s  0.00 %  0.00 % 
[kworker/u16:4-btrfs-endio-write]
     1 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % init
     2 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [kthreadd]
     3 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [rcu_gp]




PS. I have set Thunderbird not to wrap long lines. Hope my emails are 
more readable now.


