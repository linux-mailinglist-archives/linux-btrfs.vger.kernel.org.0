Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A7130EAD2
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 04:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhBDDSP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Feb 2021 22:18:15 -0500
Received: from out20-50.mail.aliyun.com ([115.124.20.50]:55512 "EHLO
        out20-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhBDDSN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Feb 2021 22:18:13 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00983358-0.000887847-0.989279;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.JUuggTY_1612408628;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JUuggTY_1612408628)
          by smtp.aliyun-inc.com(10.147.42.198);
          Thu, 04 Feb 2021 11:17:09 +0800
Date:   Thu, 04 Feb 2021 11:17:12 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        Filipe Manana <fdmanana@kernel.org>
Subject: Re: [PATCH 6/6] btrfs: do not block inode logging for so long during transaction commit
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <20210203231649.F5D8.409509F4@e16-tech.com>
References: <c83533db-5a2d-1ca3-5e4c-7bd3b5f2fd8c@suse.com> <20210203231649.F5D8.409509F4@e16-tech.com>
Message-Id: <20210204111706.0AD1.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I tried to run btrfs misc-next(5.11-rc6 +81patches) based on linux LTS
5.10.12 with the same other kernel components and the same kernel config.

Better dbench(sync open) result on both Throughput and max_latency.

 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX     958611     0.026   440.564
 Close         703418     0.002     0.085
 Rename         40599     0.518   439.825
 Unlink        194095     0.282   439.792
 Qpathinfo     869295     0.010     1.852
 Qfileinfo     151285     0.002     0.095
 Qfsinfo       159492     0.004     0.051
 Sfileinfo      78078     0.010     0.104
 Find          335905     0.036     3.043
 WriteX        473353     3.637   713.039
 ReadX        1502197     0.005     0.752
 LockX           3100     0.004     0.024
 UnlockX         3100     0.002     0.020
 Flush          67264     0.575   363.550

Throughput 497.551 MB/sec (sync open)  32 clients  32 procs  max_latency=713.045 ms

detail:
  32     34620   506.62 MB/sec  execute   1 sec  latency 6.860 ms
  32     37878   528.91 MB/sec  execute   2 sec  latency 6.366 ms
  32     41015   541.17 MB/sec  execute   3 sec  latency 6.326 ms
  32     43981   539.10 MB/sec  execute   4 sec  latency 6.743 ms
  32     47111   540.92 MB/sec  execute   5 sec  latency 7.597 ms
  32     50163   544.44 MB/sec  execute   6 sec  latency 6.984 ms
  32     52952   532.23 MB/sec  execute   7 sec  latency 63.769 ms
  32     55561   514.29 MB/sec  execute   8 sec  latency 482.822 ms
  32     58415   515.72 MB/sec  execute   9 sec  latency 6.238 ms
  32     61365   515.94 MB/sec  execute  10 sec  latency 8.102 ms
  32     64309   518.10 MB/sec  execute  11 sec  latency 6.176 ms
  32     67322   517.59 MB/sec  execute  12 sec  latency 6.690 ms
  32     70343   515.28 MB/sec  execute  13 sec  latency 6.831 ms
  32     73323   512.81 MB/sec  execute  14 sec  latency 7.754 ms
  32     76151   513.38 MB/sec  execute  15 sec  latency 7.275 ms
  32     79042   513.44 MB/sec  execute  16 sec  latency 6.678 ms
  32     81995   514.71 MB/sec  execute  17 sec  latency 8.393 ms
  32     84911   512.80 MB/sec  execute  18 sec  latency 7.574 ms
  32     87884   510.68 MB/sec  execute  19 sec  latency 8.363 ms
  32     89711   502.50 MB/sec  execute  20 sec  latency 695.270 ms *1
  32     92628   503.68 MB/sec  execute  21 sec  latency 7.405 ms
  32     95627   503.66 MB/sec  execute  22 sec  latency 6.545 ms
  32     98638   502.90 MB/sec  execute  23 sec  latency 6.649 ms
  32    101641   503.29 MB/sec  execute  24 sec  latency 7.740 ms
  32    104515   503.72 MB/sec  execute  25 sec  latency 6.941 ms
  32    107448   504.28 MB/sec  execute  26 sec  latency 6.704 ms
  32    110321   504.79 MB/sec  execute  27 sec  latency 6.216 ms
  32    113235   503.77 MB/sec  execute  28 sec  latency 7.366 ms
  32    116185   503.18 MB/sec  execute  29 sec  latency 7.153 ms
  32    119074   503.35 MB/sec  execute  30 sec  latency 7.026 ms
  32    121970   503.51 MB/sec  execute  31 sec  latency 8.789 ms
  32    123948   498.76 MB/sec  execute  32 sec  latency 539.597 ms *2
  32    127045   499.14 MB/sec  execute  33 sec  latency 6.112 ms
  32    130059   499.66 MB/sec  execute  34 sec  latency 7.762 ms
  32    133062   500.45 MB/sec  execute  35 sec  latency 6.706 ms
  32    136014   501.03 MB/sec  execute  36 sec  latency 8.384 ms
  32    139018   502.13 MB/sec  execute  37 sec  latency 6.822 ms
  32    142047   502.50 MB/sec  execute  38 sec  latency 6.924 ms
  32    144935   501.74 MB/sec  execute  39 sec  latency 7.319 ms
  32    147836   501.38 MB/sec  execute  40 sec  latency 6.958 ms
  32    150677   501.36 MB/sec  execute  41 sec  latency 6.993 ms
  32    153562   501.63 MB/sec  execute  42 sec  latency 7.126 ms
  32    156385   501.63 MB/sec  execute  43 sec  latency 7.602 ms
  32    159258   500.99 MB/sec  execute  44 sec  latency 7.281 ms
  32    162248   501.05 MB/sec  execute  45 sec  latency 6.896 ms
  32    165128   501.12 MB/sec  execute  46 sec  latency 7.134 ms
  32    168070   501.39 MB/sec  execute  47 sec  latency 6.674 ms
  32    169978   497.76 MB/sec  execute  48 sec  latency 355.037 ms
  32    172936   497.92 MB/sec  execute  49 sec  latency 713.045 ms *3
  32    175828   497.93 MB/sec  execute  50 sec  latency 6.585 ms
  32    178731   498.06 MB/sec  execute  51 sec  latency 8.511 ms
  32    181681   498.79 MB/sec  execute  52 sec  latency 7.093 ms
  32    184622   498.83 MB/sec  execute  53 sec  latency 6.265 ms
  32    187647   498.90 MB/sec  execute  54 sec  latency 6.902 ms
  32    190125   497.59 MB/sec  execute  55 sec  latency 142.628 ms
  32    192920   497.36 MB/sec  execute  56 sec  latency 432.224 ms
  32    195822   497.85 MB/sec  execute  57 sec  latency 6.497 ms
  32    198709   497.56 MB/sec  execute  58 sec  latency 6.418 ms
  32    201665   497.55 MB/sec  execute  59 sec  latency 6.699 ms

Because of kernel interface changed between 5.10 and 5.11 , so we need
some modify to btrfs misc-next(5.11-rc6 +81patches) to run on linux LTS
5.10.12,
# drop 0001-block-add-a-bdev_kobj-helper.patch
# drop  0001-block-remove-i_bdev.patch
# add  0001-btrfs-bdev_nr_sectors.patch

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/02/04

> Hi,
> 
> There is the dbench(sync open) test result of misc-next(5.11-rc6 +81patches)
> 
> 1, the MaxLat is changed from 1900ms level to 1000ms level.
>     that is a good improvement.
> 
> 2, It is OK that NTCreateX/Rename/Unlink/WriteX have the same level of
>     MaxLat because all of them will write something to disk.
> 
> 3, I'm not sure whether MaxLat of Flush is OK.
>     there should be nothing to write for Flush because of 
>     dbench(sync open) mode. but I'm not sure whether some
>     scsi comand such as Synchronize Cache will be executed by Flush.
> 
> Operation      Count    AvgLat    MaxLat
>  ----------------------------------------
>  NTCreateX     924298     0.035   745.523
>  Close         678499     0.002     0.093
>  Rename         39280     0.597   744.714
>  Unlink        187119     0.435   745.547
>  Qpathinfo     838558     0.013     0.978
>  Qfileinfo     146308     0.002     0.055
>  Qfsinfo       154172     0.004     0.108
>  Sfileinfo      75423     0.010     0.109
>  Find          324478     0.050     1.115
>  WriteX        457376     3.665   957.922
>  ReadX        1454051     0.005     0.131
>  LockX           3032     0.004     0.027
>  UnlockX         3032     0.002     0.022
>  Flush          64867     0.649   718.676
> 
> Throughput 481.002 MB/sec (sync open)  32 clients  32 procs  max_latency=957.929 ms
> + stat -f -c %T /btrfs/
> btrfs
> + uname -r
> 5.11.0-0.rc6.141.el8.x86_64
> 
> detail:
>   32     33682   548.70 MB/sec  execute   1 sec  latency 7.024 ms
>   32     36692   538.41 MB/sec  execute   2 sec  latency 6.719 ms
>   32     39787   544.75 MB/sec  execute   3 sec  latency 6.405 ms
>   32     42850   540.09 MB/sec  execute   4 sec  latency 7.717 ms
>   32     45872   535.64 MB/sec  execute   5 sec  latency 7.271 ms
>   32     48861   524.29 MB/sec  execute   6 sec  latency 6.685 ms
>   32     51343   512.54 MB/sec  execute   7 sec  latency 128.666 ms
>   32     53366   496.73 MB/sec  execute   8 sec  latency 703.255 ms *1
>   32     56428   498.60 MB/sec  execute   9 sec  latency 6.346 ms
>   32     59471   498.40 MB/sec  execute  10 sec  latency 9.958 ms
>   32     62175   495.68 MB/sec  execute  11 sec  latency 14.270 ms
>   32     65143   498.90 MB/sec  execute  12 sec  latency 9.391 ms
>   32     68116   502.19 MB/sec  execute  13 sec  latency 5.713 ms
>   32     71078   501.45 MB/sec  execute  14 sec  latency 6.235 ms
>   32     74030   500.43 MB/sec  execute  15 sec  latency 7.135 ms
>   32     76908   500.82 MB/sec  execute  16 sec  latency 7.071 ms
>   32     79794   499.61 MB/sec  execute  17 sec  latency 7.556 ms
>   32     82791   502.30 MB/sec  execute  18 sec  latency 6.509 ms
>   32     85676   502.05 MB/sec  execute  19 sec  latency 6.938 ms
>   32     86950   486.44 MB/sec  execute  20 sec  latency 554.015 ms *2
>   32     89670   487.60 MB/sec  execute  21 sec  latency 901.490 ms *3
>   32     92577   487.64 MB/sec  execute  22 sec  latency 6.715 ms
>   32     95528   488.03 MB/sec  execute  23 sec  latency 7.457 ms
>   32     98507   488.76 MB/sec  execute  24 sec  latency 7.266 ms
>   32    101340   488.76 MB/sec  execute  25 sec  latency 6.699 ms
>   32    104331   489.94 MB/sec  execute  26 sec  latency 6.506 ms
>   32    107166   490.87 MB/sec  execute  27 sec  latency 6.582 ms
>   32    110022   490.17 MB/sec  execute  28 sec  latency 7.072 ms
>   32    112931   490.34 MB/sec  execute  29 sec  latency 6.484 ms
>   32    115658   489.67 MB/sec  execute  30 sec  latency 6.767 ms
>   32    118569   490.14 MB/sec  execute  31 sec  latency 6.825 ms
>   32    121334   490.34 MB/sec  execute  32 sec  latency 7.270 ms
>   32    124182   489.95 MB/sec  execute  33 sec  latency 6.849 ms
>   32    127073   490.05 MB/sec  execute  34 sec  latency 6.934 ms
>   32    129835   489.56 MB/sec  execute  35 sec  latency 7.455 ms
>   32    130952   481.58 MB/sec  execute  36 sec  latency 635.676 ms *4
>   32    133736   481.74 MB/sec  execute  37 sec  latency 957.929 ms *5
>   32    136646   481.79 MB/sec  execute  38 sec  latency 7.339 ms
>   32    139616   483.23 MB/sec  execute  39 sec  latency 7.199 ms
>   32    142526   483.62 MB/sec  execute  40 sec  latency 7.344 ms
>   32    145429   483.58 MB/sec  execute  41 sec  latency 6.967 ms
>   32    148329   484.09 MB/sec  execute  42 sec  latency 8.043 ms
>   32    151091   483.89 MB/sec  execute  43 sec  latency 7.476 ms
>   32    153913   484.33 MB/sec  execute  44 sec  latency 7.611 ms
>   32    156679   484.29 MB/sec  execute  45 sec  latency 7.612 ms
>   32    159534   483.90 MB/sec  execute  46 sec  latency 8.295 ms
>   32    162328   484.17 MB/sec  execute  47 sec  latency 6.582 ms
>   32    165080   483.64 MB/sec  execute  48 sec  latency 8.939 ms
>   32    167861   484.12 MB/sec  execute  49 sec  latency 6.684 ms
>   32    170616   483.56 MB/sec  execute  50 sec  latency 7.051 ms
>   32    173557   483.89 MB/sec  execute  51 sec  latency 6.923 ms
>   32    176424   484.52 MB/sec  execute  52 sec  latency 6.689 ms
>   32    179255   484.14 MB/sec  execute  53 sec  latency 7.973 ms
>   32    181195   481.47 MB/sec  execute  54 sec  latency 305.495 ms
>   32    183309   479.62 MB/sec  execute  55 sec  latency 866.862 ms *6
>   32    186256   479.82 MB/sec  execute  56 sec  latency 7.016 ms
>   32    189209   480.82 MB/sec  execute  57 sec  latency 6.789 ms
>   32    192072   480.93 MB/sec  execute  58 sec  latency 7.305 ms
>   32    195054   481.00 MB/sec  execute  59 sec  latency 7.432 ms
> 
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/02/03
> 
> > 
> > 
> > On 3.02.21 §Ô. 12:51 §é., Filipe Manana wrote:
> > > On Tue, Feb 2, 2021 at 2:15 PM Wang Yugui <wangyugui@e16-tech.com> wrote:
> > >>
> > >> Hi, Filipe Manana
> > >>
> > >> There are some dbench(sync mode) result on the same hardware,
> > >> but with different linux kernel
> > >>
> > >> 4.14.200
> > >> Operation      Count    AvgLat    MaxLat
> > >>  ----------------------------------------
> > >>  WriteX        225281     5.163    82.143
> > >>  Flush          32161     2.250    62.669
> > >> Throughput 236.719 MB/sec (sync open)  32 clients  32 procs  max_latency=82.149 ms
> > >>
> > >> 4.19.21
> > >> Operation      Count    AvgLat    MaxLat
> > >>  ----------------------------------------
> > >>  WriteX        118842    10.946   116.345
> > >>  Flush          16506     0.115    44.575
> > >> Throughput 125.973 MB/sec (sync open)  32 clients  32 procs  max_latency=116.390 ms
> > >>
> > >> 4.19.150
> > >>  Operation      Count    AvgLat    MaxLat
> > >>  ----------------------------------------
> > >>  WriteX        144509     9.151   117.353
> > >>  lush          20563     0.128    52.014
> > >> Throughput 153.707 MB/sec (sync open)  32 clients  32 procs  max_latency=117.379 ms
> > >>
> > >> 5.4.91
> > >>  Operation      Count    AvgLat    MaxLat
> > >>  ----------------------------------------
> > >>  WriteX        367033     4.377  1908.724
> > >>  Flush          52037     0.159    39.871
> > >> Throughput 384.554 MB/sec (sync open)  32 clients  32 procs  max_latency=1908.968 ms
> > > 
> > > Ok, it seems somewhere between 4.19 and 5.4, something made the
> > > latency much worse for you at least.
> > > 
> > > Is it only when using sync open (O_SYNC, dbench's -s flag), what about
> > > when not using it?
> > > 
> > > I'll have to look at it, but it will likely take some time.
> > 
> > 
> > This seems like the perf regression I observed starting with kernel 5.0,
> > essentially preemptive flush of metadata was broken for quite some time,
> > but kernel 5.0 removed a btrfs_end_transaction call from
> > should_end_transaction which unmasked the issue.
> > 
> > In particular this should have been fixed by the following commit in
> > misc-next:
> > 
> > https://github.com/kdave/btrfs-devel/commit/28d7e221e4323a5b98e5d248eb5603ff5206a188
> > which is part of a larger series of patches. So Wang, in order to test
> > this hypothesis can you re-run those tests with the latest misc-next
> > branch .
> > 
> > <snip>
> 


