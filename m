Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3D712EA0A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 19:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgABSrO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 13:47:14 -0500
Received: from naboo.endor.pl ([91.194.229.149]:44615 "EHLO naboo.endor.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbgABSrO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 13:47:14 -0500
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jan 2020 13:47:12 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id ADB051A1571
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jan 2020 19:37:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zb9xZPUcVl4G for <linux-btrfs@vger.kernel.org>;
        Thu,  2 Jan 2020 19:37:14 +0100 (CET)
Received: from [192.168.1.16] (aciu198.neoplus.adsl.tpnet.pl [83.10.44.198])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id 7ED821A156B
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jan 2020 19:37:14 +0100 (CET)
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com>
 <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
 <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com>
 <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
 <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
 <2c135c87-d01b-53f1-9f76-a5653918a4e7@dubiel.pl>
 <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
 <20191228202344.GE13306@hungrycats.org>
From:   Leszek Dubiel <leszek@dubiel.pl>
Message-ID: <c278f501-f5a5-c905-5431-2d735e97fa13@dubiel.pl>
Date:   Thu, 2 Jan 2020 19:37:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191228202344.GE13306@hungrycats.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl-PL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


 > It might be handy to give users a clue on snapshot delete, like add
 > "use btrfs sub list -d to monitor deletion progress, or btrfs sub sync
 > to wait for deletion to finish".

After having cleaned old shapshots, and after "dev delete" has
completed I have added new fresh empty disk


                  btrfs dev add /dev/sda3 /


and started to balance:


                      btrfs balance start -dconvert=raid1 -mconvert=raid1 /


It was slow (3-5 MB/sec), so canceled balance.
Iostat showed no activity.
Started balance again:


                 btrfs balance start -dconvert=raid1,soft 
-mconvert=raid1,soft /


it is slow again. Server is not working hard, disks are healthy this time.

I will patiently wait until it completes, but I wanted to inform about 
user experience.
I have no clue why it is not going on full speed of disks.




root@wawel:~# iostat -x 60 -m
Linux 4.19.0-6-amd64 (wawel)     02.01.2020     _x86_64_    (8 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,25    0,00    0,79    6,30    0,00   92,66

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
sda              4,39  142,05      0,90      3,78     3,64 12,68  
45,32   8,20    9,81    5,48   0,78   209,68    27,26 0,54   7,95
sdb              4,66  155,25      0,97      4,03     4,52 13,11  
49,27   7,78    9,25    4,68   0,73   213,20    26,59 0,49   7,89
sdc              6,35  246,61      0,38      6,94     4,35 25,11  
40,67   9,24   27,09   48,00  11,92    61,02    28,82 2,65  67,02

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,09    0,00    1,68   11,70    0,00   86,53

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
sda              1,27  205,48      0,02      7,44     0,00 2,47   0,00   
1,19   18,25    1,67   0,37    16,00    37,07 0,37   7,55
sdb              1,20  223,10      0,02      7,33     0,00 5,32   0,00   
2,33   16,26    1,68   0,38    16,00    33,64 0,34   7,72
sdc             19,50  428,38      0,30     14,76     0,00 7,78   0,00   
1,78   59,97    6,80   4,07    16,00    35,28 2,05  91,85

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,09    0,00    0,63    8,79    0,00   90,49

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
sda              0,75  208,78      0,01      3,74     0,00 4,47   0,00   
2,09   11,96    3,78   0,75    16,00    18,35 0,23   4,75
sdb              0,45  109,97      0,01      1,92     0,00 2,77   0,00   
2,45   21,22    3,44   0,36    16,00    17,92 0,27   2,94
sdc              9,22  318,28      0,14      5,66     0,00 7,22   0,00   
2,22   13,79   58,62  18,71    16,00    18,20 2,92  95,57

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,09    0,00    0,68    7,07    0,00   92,16

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
sda              0,00  305,72      0,00      5,69     0,00 9,73   0,00   
3,09    0,00    7,20   2,12     0,00    19,06 0,47  14,23
sdb              0,00  189,15      0,00      3,39     0,00 5,90   0,00   
3,02    0,00    7,59   1,39     0,00    18,37 0,52   9,84
sdc              0,00  288,97      0,00      5,44     0,00 8,63   0,00   
2,90    0,00   62,44  17,91     0,00    19,29 2,89  83,38

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,12    0,00    0,34    6,73    0,00   92,81

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
sda              0,00  189,57      0,00      3,53     0,00 5,65   0,00   
2,89    0,00    8,12   1,48     0,00    19,09 0,56  10,66
sdb              0,00  284,67      0,00      5,03     0,00 9,10   0,00   
3,10    0,00    6,01   1,62     0,00    18,11 0,38  10,83
sdc              0,00  308,95      0,00      5,65     0,00 9,30   0,00   
2,92    0,00   60,87  18,73     0,00    18,74 2,86  88,24

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,09    0,00    1,99    6,62    0,00   91,30

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
sda              0,80  294,67      0,01     18,03     0,00 2,43   0,00   
0,82   22,50    3,45   1,00    16,00    62,66 0,32   9,51
sdb             28,28  224,48     16,84      4,72     0,33 13,97   
1,16   5,86    6,80    3,88   1,00   609,62    21,54 0,46  11,61
sdc              8,60  518,88      0,14     22,76     0,08 16,30   
0,96   3,05   10,12   27,26  14,01    16,19    44,91 1,42  74,85

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,22    0,00    1,91    9,46    0,00   88,42

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
sda              1,88  130,13      0,03      2,70     0,00 9,73   0,00   
6,96   15,23    0,58   0,10    16,00    21,23 0,45   5,98
sdb              1,45  147,78      0,02      3,18     0,00 12,62   
0,00   7,87   11,53    0,66   0,11    16,00    22,02 0,39   5,84
sdc             25,08  275,75      0,39      5,88     0,00 24,55   
0,00   8,18   47,78    6,50   2,97    16,00    21,83 3,18  95,79

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            0,14    0,00    0,73    9,28    0,00   89,85

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s wrqm/s  
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
sda              2,38  186,52      0,20      3,33     1,33 4,20  35,87   
2,20    9,88    3,48   0,63    86,04    18,27 0,30   5,60
sdb              1,00  108,35      0,02      1,99     0,00 2,73   0,00   
2,46    8,92    3,78   0,41    18,00    18,85 0,27   2,98
sdc             13,47  294,68      0,21      5,32     0,00 6,92   0,00   
2,29   13,33   61,56  18,28    16,00    18,48 3,13  96,45




top:

top - 19:29:52 up  2:00,  2 users,  load average: 1,21, 1,53, 1,92
Tasks: 165 total,   1 running, 164 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0,0 us,  0,0 sy,  0,0 ni, 91,9 id,  8,1 wa,  0,0 hi, 0,0 si,  
0,0 st
MiB Mem :  32130,4 total,  15827,0 free,    409,4 used,  15893,9 buff/cache
MiB Swap:      0,0 total,      0,0 free,      0,0 used.  31244,2 avail Mem

   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM TIME+ COMMAND
   289 root       0 -20       0      0      0 I   6,7   0,0 0:00.73 
kworker/4:1H-kblockd
     1 root      20   0   22036  10140   7872 S   0,0   0,0 0:11.52 systemd
     2 root      20   0       0      0      0 S   0,0   0,0 0:00.01 
kthreadd
     3 root       0 -20       0      0      0 I   0,0   0,0 0:00.00 rcu_gp
     4 root       0 -20       0      0      0 I   0,0   0,0 0:00.00 
rcu_par_gp
     6 root       0 -20       0      0      0 I   0,0   0,0 0:00.00 
kworker/0:0H-kblockd
     8 root       0 -20       0      0      0 I   0,0   0,0 0:00.00 
mm_percpu_wq
     9 root      20   0       0      0      0 S   0,0   0,0 0:00.04 
ksoftirqd/0
    10 root      20   0       0      0      0 I   0,0   0,0 0:02.61 
rcu_sched
    11 root      20   0       0      0      0 I   0,0   0,0 0:00.00 rcu_bh
    12 root      rt   0       0      0      0 S   0,0   0,0 0:00.02 
migration/0
    14 root      20   0       0      0      0 S   0,0   0,0 0:00.00 cpuhp/0
    15 root      20   0       0      0      0 S   0,0   0,0 0:00.00 cpuhp/1
    16 root      rt   0       0      0      0 S   0,0   0,0 0:00.02 
migration/1
    17 root      20   0       0      0      0 S   0,0   0,0 0:00.07 
ksoftirqd/1
    19 root       0 -20       0      0      0 I   0,0   0,0 0:00.00 
kworker/1:0H-kblockd



iotop:

Total DISK READ:         0.00 B/s | Total DISK WRITE:         0.00 B/s
Current DISK READ:       0.00 B/s | Current DISK WRITE:       0.00 B/s
   TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN     IO> COMMAND
     1 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % init
     2 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [kthreadd]
     3 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [rcu_gp]
     4 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [rcu_par_gp]
     6 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % 
[kworker/0:0H-kblockd]
     8 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [mm_percpu_wq]
     9 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [ksoftirqd/0]
    10 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [rcu_sched]
    11 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [rcu_bh]
    12 rt/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [migration/0]
    14 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [cpuhp/0]
    15 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [cpuhp/1]
    16 rt/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [migration/1]
    17 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [ksoftirqd/1]
    19 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % 
[kworker/1:0H-kblockd]
    20 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [cpuhp/2]
    21 rt/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [migration/2]
    22 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [ksoftirqd/2]
    24 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % 
[kworker/2:0H-kblockd]
    25 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [cpuhp/3]
    26 rt/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [migration/3]
    27 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [ksoftirqd/3]
    29 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % 
[kworker/3:0H-kblockd]
    30 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [cpuhp/4]



