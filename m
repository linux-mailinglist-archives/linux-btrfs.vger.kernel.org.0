Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B4512A936
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Dec 2019 23:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLYWmN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Dec 2019 17:42:13 -0500
Received: from naboo.endor.pl ([91.194.229.149]:49265 "EHLO naboo.endor.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfLYWmN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Dec 2019 17:42:13 -0500
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Dec 2019 17:42:07 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id 837EA1A1078
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Dec 2019 23:35:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nytoFCQGIa6q for <linux-btrfs@vger.kernel.org>;
        Wed, 25 Dec 2019 23:35:55 +0100 (CET)
Received: from [192.168.1.16] (aaef77.neoplus.adsl.tpnet.pl [83.4.109.77])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id 4AC991A1069
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Dec 2019 23:35:55 +0100 (CET)
From:   Leszek Dubiel <leszek@dubiel.pl>
Subject: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     linux-btrfs@vger.kernel.org
Message-ID: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
Date:   Wed, 25 Dec 2019 23:35:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl-PL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hello!

I have a server: 3 disks, 6TB each, total 17TB space, occupied with data 
6TB.


One of the disks got smart errors:

     197 Current_Pending_Sector  0x0022   100   100   000 Old_age   
Always       -       16
     198 Offline_Uncorrectable   0x0008   100   100   000 Old_age   
Offline      -       2

And didn't pass tests:

     Num  Test_Description    Status                  Remaining 
LifeTime(hours)  LBA_of_first_error
     # 1  Extended offline    Completed: read failure 90%      
3575         -
     # 2  Short offline       Completed without error 00%      
3574         -
     # 3  Extended offline    Completed: read failure 90%      
3574         -
     # 4  Extended offline    Completed: read failure 90%      
3560         -
     # 5  Extended offline    Completed: read failure 50%      
3559         -

I decided to remove that drive from BTRFS system:

     btrfs dev delete /dev/sda2 /


At the beginning iostat showed that system is reading from /dev/sda 
100Mb/sec, then writing to /dev/sdb + /dev/sdc 100Mb/sek. It looked 
correct, and during a few hours it moved aobut 1.5 TB of data out of the 
failing disk. But then it stuck... Iostat no longer showed reading or 
writing, "btrfs dev usage" didn't change. Couldn't stop "btrfs dev 
delete" command -- nor Ctrl+C nor "kill -9". I have rebooted system, 
started "btrfs dev delete" again.

But this is extremely slow. Disks can read/write 100-150Mb/sek. But 
"process btrfs dev delete" moved 53Gb during 6 hours, that is only about 
2Mb/sek.

Why this is so slow? Below are some logs. Some other people also have 
had this problem...

What is my problem? I am testing btrfs for many years, I have had some 
issues few years ago, recently I considered btrfs to be stable... but I 
cannot put btrfs into production when I have such problems when disk 
fails... to move 3Tb with 2mb/sec speed it would take many, many days. 
Server does almost nothing... it just deletes one drive. Cpu is not 
intensive, iostat looks lazy...




#################################################

root@wawel:~# uname -a
Linux wawel 4.19.0-6-amd64 #1 SMP Debian 4.19.67-2+deb10u2 (2019-11-11) 
x86_64 GNU/Linux

root@wawel:~# btrfs --version
btrfs-progs v4.20.1

root@wawel:~# dpkg -l | egrep btrfs
ii  btrfs-progs                   4.20.1-2 amd64        Checksumming 
Copy on Write Filesystem utilities

#################################################

root@wawel:~# btrfs sub list /  | wc -l
21

#################################################

root@wawel:~# btrfs dev usage /
/dev/sda2, ID: 1
    Device size:             5.45TiB
    Device slack:            5.45TiB
    Data,single:             1.08TiB
    Metadata,RAID1:         11.00GiB
    System,RAID1:           32.00MiB
    Unallocated:            -1.09TiB

/dev/sdb2, ID: 2
    Device size:             5.45TiB
    Device slack:              0.00B
    Data,single:             3.22TiB
    Metadata,RAID1:         87.00GiB
    Unallocated:             2.15TiB

/dev/sdc2, ID: 3
    Device size:             5.45TiB
    Device slack:              0.00B
    Data,single:             3.21TiB
    Metadata,RAID1:         96.00GiB
    System,RAID1:           32.00MiB
    Unallocated:             2.15TiB

#################################################

root@wawel:~# iostat -m -d 30
Linux 4.19.0-6-amd64 (wawel)     25.12.2019     _x86_64_    (4 CPU)

Device             tps    MB_read/s    MB_wrtn/s    MB_read MB_wrtn
sda              29,52         2,77         0,90     158467 51287
sdb             532,93         0,77        16,80      44046 962107
sdc             532,03         0,59        16,79      34017 961406

Device             tps    MB_read/s    MB_wrtn/s    MB_read MB_wrtn
sda               0,70         0,00         0,01 0          0
sdb             624,20         0,05        14,17          1 424
sdc             628,47         0,06        14,79          1 443

Device             tps    MB_read/s    MB_wrtn/s    MB_read MB_wrtn
sda              17,90         0,23         0,59 7         17
sdb             760,63         0,15        15,39          4 461
sdc             761,13         0,09        16,75          2 502

Device             tps    MB_read/s    MB_wrtn/s    MB_read MB_wrtn
sda              65,80         1,00         0,26 30          7
sdb            1085,93         0,18        26,14          5 784
sdc            1081,03         0,09        27,03          2 810

Device             tps    MB_read/s    MB_wrtn/s    MB_read MB_wrtn
sda             101,53         1,57         0,10 47          3
sdb             609,63         0,34        19,29         10 578
sdc             612,67         0,33        19,73          9 591

Device             tps    MB_read/s    MB_wrtn/s    MB_read MB_wrtn
sda             114,30         1,76         0,28 52          8
sdb             355,90         0,39        19,60         11 587
sdc             368,50         0,35        20,17         10 605

Device             tps    MB_read/s    MB_wrtn/s    MB_read MB_wrtn
sda              63,70         0,55         0,54 16         16
sdb             438,40         0,13         7,83          3 234
sdc             463,97         0,09         8,93          2 267

root@wawel:~# iostat -m -d 30
Linux 4.19.0-6-amd64 (wawel)     25.12.2019     _x86_64_    (4 CPU)

Device             tps    MB_read/s    MB_wrtn/s    MB_read MB_wrtn
sda              30,18         2,51         1,01     226710 91462
sdb             531,30         0,69        15,36      62022 1384919
sdc             535,25         0,59        15,53      53092 1400122

Device             tps    MB_read/s    MB_wrtn/s    MB_read MB_wrtn
sda               2,80         0,01         0,49 0         14
sdb             154,77         0,53         3,05 15         91
sdc             161,40         0,64         3,02 19         90

Device             tps    MB_read/s    MB_wrtn/s    MB_read MB_wrtn
sda             124,87         0,01         3,02 0         90
sdb             799,33         0,13        19,40          3 581
sdc             930,63         0,23        22,21          6 666

Device             tps    MB_read/s    MB_wrtn/s    MB_read MB_wrtn
sda               5,97         0,00         0,69 0         20
sdb             730,10         0,05        14,62          1 438
sdc             739,23         0,13        14,86          3 445

Device             tps    MB_read/s    MB_wrtn/s    MB_read MB_wrtn
sda               6,53         0,01         1,39 0         41
sdb             800,63         0,13        15,63          4 468
sdc             801,83         0,02        16,12          0 483

Device             tps    MB_read/s    MB_wrtn/s    MB_read MB_wrtn
sda               4,83         0,00         1,13 0         33
sdb             756,30         0,14        15,08          4 452
sdc             759,03         0,15        15,33          4 459



#################################################

root@wawel:~# btrfs dev usage -b / | sed -r "s/^/$(date +'%F %T')\t/" >> 
btrfsdevusage
root@wawel:~# btrfs dev usage -b / | sed -r "s/^/$(date +'%F %T')\t/" >> 
btrfsdevusage
root@wawel:~# btrfs dev usage -b / | sed -r "s/^/$(date +'%F %T')\t/" >> 
btrfsdevusage
root@wawel:~# btrfs dev usage -b / | sed -r "s/^/$(date +'%F %T')\t/" >> 
btrfsdevusage

root@wawel:~# cat btrfsdevusage  | egrep sda -A5 | egrep single
2019-12-25 17:03:04       Data,single:          1188632199168
2019-12-25 18:31:27       Data,single:          1184337231872
2019-12-25 19:00:56       Data,single:          1177894780928
2019-12-25 20:25:46       Data,single:          1158567428096
2019-12-25 21:06:00       Data,single:          1147830009856
2019-12-25 23:01:34       Data,single:          1132797624320
2019-12-25 23:16:27       Data,single:          1130650140672

root@wawel:~# echo "speed is $(( ( 1188632199168  - 1130650140672 ) / 
1024 / 1024 / ((23 - 17) * 3600)  )) MB/sec"
speed is 2 MB/sec

#################################################

root@wawel:~# iotop -d12

Total DISK READ:         0.00 B/s | Total DISK WRITE:         0.00 B/s
Current DISK READ:       0.00 B/s | Current DISK WRITE:     183.48 M/s
   TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN     IO> COMMAND
  8138 be/4 root        0.00 B/s    0.00 B/s  0.00 % 99.99 % btrfs dev 
delete /dev/sda2 /
     1 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % init
     2 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [kthreadd]
     3 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [rcu_gp]
     4 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [rcu_par_gp]
     6 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % 
[kworker/0:0H-kblockd]
     8 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [mm_percpu_wq]

Total DISK READ:        11.23 M/s | Total DISK WRITE:        28.77 M/s
Current DISK READ:      11.23 M/s | Current DISK WRITE:      56.51 M/s
   TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN     IO> COMMAND
10349 be/4 root       29.26 K/s  168.89 K/s  0.00 % 75.29 % 
[kworker/u8:3-btrfs-endio-meta]
  8138 be/4 root       11.03 M/s   23.61 M/s  0.00 % 74.65 % btrfs dev 
delete /dev/sda2 /
10351 be/4 root       45.21 K/s 1365.76 K/s  0.00 % 11.50 % 
[kworker/u8:8-btrfs-endio-write]
10350 be/4 root       63.83 K/s 1542.63 K/s  0.00 % 10.22 % 
[kworker/u8:7-btrfs-freespace-write]
  7879 be/4 root       42.56 K/s 1186.23 K/s  0.00 %  7.07 % 
[kworker/u8:1-btrfs-freespace-write]
23032 be/4 root       25.27 K/s  972.12 K/s  0.00 %  5.04 % 
[kworker/u8:12-btrfs-extent-refs]
  8035 be/4 root        0.00 B/s   25.27 K/s  0.00 %  0.00 % 
[kworker/u8:4-btrfs-endio-meta]
  8036 be/4 root        0.00 B/s   11.97 K/s  0.00 %  0.00 % 
[kworker/u8:5-btrfs-extent-refs]
31253 be/4 root        0.00 B/s    5.32 K/s  0.00 %  0.00 % 
[kworker/u8:9-btrfs-extent-refs]

Total DISK READ:       674.25 K/s | Total DISK WRITE:        13.57 M/s
Current DISK READ:     674.25 K/s | Current DISK WRITE:      39.97 M/s
   TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN     IO> COMMAND
  8138 be/4 root      147.62 K/s    7.72 M/s  0.00 % 79.89 % btrfs dev 
delete /dev/sda2 /
10274 be/4 root      484.08 K/s    4.91 M/s  0.00 % 56.93 % 
[kworker/u8:2+btrfs-extent-refs]
10351 be/4 root       27.93 K/s  492.06 K/s  0.00 %  3.03 % 
[kworker/u8:8-btrfs-endio-meta]
10350 be/4 root        3.99 K/s  115.70 K/s  0.00 %  0.59 % 
[kworker/u8:7-btrfs-endio-write]
  8037 be/4 root        5.32 K/s   79.79 K/s  0.00 %  0.40 % 
[kworker/u8:6-btrfs-endio-write]
23032 be/4 root        3.99 K/s   79.79 K/s  0.00 %  0.20 % 
[kworker/u8:12-btrfs-endio-write]
  7879 be/4 root     1361.80 B/s  105.06 K/s  0.00 %  0.10 % 
[kworker/u8:1-btrfs-endio-write]
   538 be/4 root        0.00 B/s 1021.35 B/s  0.00 %  0.00 % rsyslogd -n 
-iNONE [rs:main Q:Reg]
10349 be/4 root        0.00 B/s   86.44 K/s  0.00 %  0.00 % 
[kworker/u8:3-btrfs-endio-meta]
     1 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % init



#################################################

root@wawel:~# top -d12
top - 23:23:01 up 1 day, 56 min,  1 user,  load average: 3,05, 3,28, 3,47
Tasks: 137 total,   1 running, 136 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0,0 us,  4,5 sy,  0,0 ni, 92,1 id,  3,3 wa,  0,0 hi, 0,1 si,  
0,0 st
MiB Mem :   7841,1 total,    797,0 free,    259,7 used,   6784,4 buff/cache
MiB Swap:   8053,0 total,   7962,2 free,     90,8 used.   7265,2 avail Mem
   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM TIME+ COMMAND
  8138 root      20   0    8540    104    104 D  11,6   0,0 23:25.88 btrfs
23032 root      20   0       0      0      0 I   4,8   0,0 0:51.20 
kworker/u8:12-btrfs-extent-refs
10350 root      20   0       0      0      0 I   0,9   0,0 0:01.79 
kworker/u8:7-btrfs-endio-meta
10349 root      20   0       0      0      0 I   0,8   0,0 0:02.12 
kworker/u8:3-btrfs-freespace-write
   242 root       0 -20       0      0      0 I   0,2   0,0 0:59.66 
kworker/2:1H-kblockd


#################################################

root@wawel:~# tail /var/log/kern.log -n50
Dec 25 21:50:35 wawel kernel: [84258.634360] BTRFS info (device sda2): 
found 1752 extents
Dec 25 21:50:41 wawel kernel: [84264.771079] BTRFS info (device sda2): 
relocating block group 3434964058112 flags data
Dec 25 21:51:09 wawel kernel: [84291.864553] BTRFS info (device sda2): 
found 584 extents
Dec 25 21:55:51 wawel kernel: [84574.383303] BTRFS info (device sda2): 
found 584 extents
Dec 25 21:55:56 wawel kernel: [84579.359349] BTRFS info (device sda2): 
relocating block group 3431742832640 flags data
Dec 25 21:56:17 wawel kernel: [84600.668237] BTRFS info (device sda2): 
found 635 extents
Dec 25 22:00:36 wawel kernel: [84859.766366] BTRFS info (device sda2): 
found 635 extents
Dec 25 22:00:47 wawel kernel: [84870.367399] BTRFS info (device sda2): 
relocating block group 3428521607168 flags data
Dec 25 22:01:14 wawel kernel: [84897.313282] BTRFS info (device sda2): 
found 1170 extents
Dec 25 22:05:38 wawel kernel: [85161.264397] BTRFS info (device sda2): 
found 1170 extents
Dec 25 22:05:46 wawel kernel: [85169.216425] BTRFS info (device sda2): 
relocating block group 3425300381696 flags data
Dec 25 22:06:20 wawel kernel: [85202.963222] BTRFS info (device sda2): 
found 1336 extents
Dec 25 22:13:00 wawel kernel: [85603.648327] BTRFS info (device sda2): 
found 1336 extents
Dec 25 22:13:02 wawel kernel: [85604.878785] BTRFS info (device sda2): 
relocating block group 3422079156224 flags data
Dec 25 22:14:57 wawel kernel: [85720.394945] BTRFS info (device sda2): 
found 1771 extents
Dec 25 22:23:03 wawel kernel: [86206.582245] BTRFS info (device sda2): 
found 1771 extents
Dec 25 22:23:04 wawel kernel: [86207.671814] BTRFS info (device sda2): 
relocating block group 3418857930752 flags data
Dec 25 22:23:19 wawel kernel: [86222.138761] BTRFS info (device sda2): 
found 199 extents
Dec 25 22:26:26 wawel kernel: [86408.991487] BTRFS info (device sda2): 
found 199 extents
Dec 25 22:26:29 wawel kernel: [86412.181922] BTRFS info (device sda2): 
relocating block group 3415636705280 flags data
Dec 25 22:26:48 wawel kernel: [86431.726268] BTRFS info (device sda2): 
found 50 extents
Dec 25 22:27:32 wawel kernel: [86475.800606] BTRFS info (device sda2): 
found 50 extents
Dec 25 22:27:39 wawel kernel: [86482.222298] BTRFS info (device sda2): 
found 20 extents
Dec 25 22:27:44 wawel kernel: [86487.168278] BTRFS info (device sda2): 
relocating block group 3412415479808 flags data
Dec 25 22:28:27 wawel kernel: [86530.525657] BTRFS info (device sda2): 
found 6748 extents
Dec 25 22:34:07 wawel kernel: [86870.618140] BTRFS info (device sda2): 
found 6748 extents
Dec 25 22:34:35 wawel kernel: [86898.498949] BTRFS info (device sda2): 
relocating block group 3409194254336 flags data
Dec 25 22:36:06 wawel kernel: [86989.589309] BTRFS info (device sda2): 
found 1175 extents
Dec 25 22:40:12 wawel kernel: [87234.881523] perf: interrupt took too 
long (3943 > 3930), lowering kernel.perf_event_max_sample_rate to 50500
Dec 25 22:44:44 wawel kernel: [87507.870507] BTRFS info (device sda2): 
found 1175 extents
Dec 25 22:44:52 wawel kernel: [87515.563744] BTRFS info (device sda2): 
relocating block group 3405973028864 flags data
Dec 25 22:45:14 wawel kernel: [87537.128352] BTRFS info (device sda2): 
found 372 extents
Dec 25 22:46:11 wawel kernel: [87594.569709] BTRFS info (device sda2): 
found 372 extents
Dec 25 22:46:17 wawel kernel: [87600.772681] BTRFS info (device sda2): 
relocating block group 3402751803392 flags data
Dec 25 22:47:27 wawel kernel: [87670.663043] BTRFS info (device sda2): 
found 3483 extents
Dec 25 23:04:57 wawel kernel: [88720.068885] BTRFS info (device sda2): 
found 3479 extents
Dec 25 23:05:03 wawel kernel: [88726.864461] BTRFS info (device sda2): 
relocating block group 3399530577920 flags data
Dec 25 23:06:36 wawel kernel: [88819.464525] BTRFS info (device sda2): 
found 1871 extents
Dec 25 23:16:11 wawel kernel: [89393.997406] BTRFS info (device sda2): 
found 1868 extents
Dec 25 23:16:13 wawel kernel: [89396.825305] BTRFS info (device sda2): 
relocating block group 3396309352448 flags data
Dec 25 23:16:41 wawel kernel: [89424.310916] BTRFS info (device sda2): 
found 1946 extents
Dec 25 23:22:12 wawel kernel: [89755.068457] BTRFS info (device sda2): 
found 1946 extents
Dec 25 23:22:15 wawel kernel: [89758.601122] BTRFS info (device sda2): 
relocating block group 3393088126976 flags data
Dec 25 23:22:35 wawel kernel: [89778.172631] BTRFS info (device sda2): 
found 647 extents
Dec 25 23:23:06 wawel kernel: [89809.153016] BTRFS info (device sda2): 
found 647 extents
Dec 25 23:23:07 wawel kernel: [89810.017006] BTRFS info (device sda2): 
relocating block group 3389866901504 flags data
Dec 25 23:23:24 wawel kernel: [89827.351203] BTRFS info (device sda2): 
found 745 extents
Dec 25 23:24:38 wawel kernel: [89901.176493] BTRFS info (device sda2): 
found 745 extents
Dec 25 23:24:51 wawel kernel: [89914.840850] BTRFS info (device sda2): 
relocating block group 3386645676032 flags data
Dec 25 23:25:40 wawel kernel: [89963.641062] BTRFS info (device sda2): 
found 3114 extents




################################################

More on this topic:

https://strugglers.net/~andy/blog/2018/06/15/another-disappointing-btrfs-experience/

https://www.spinics.net/lists/linux-btrfs/msg50771.html

https://bugzilla.redhat.com/show_bug.cgi?id=1294531





