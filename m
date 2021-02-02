Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A55230C102
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Feb 2021 15:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhBBOM1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Feb 2021 09:12:27 -0500
Received: from out20-25.mail.aliyun.com ([115.124.20.25]:44863 "EHLO
        out20-25.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbhBBOKz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Feb 2021 09:10:55 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0445657|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0149869-0.00968867-0.975324;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.JU6t2l8_1612274993;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JU6t2l8_1612274993)
          by smtp.aliyun-inc.com(10.147.42.16);
          Tue, 02 Feb 2021 22:09:54 +0800
Date:   Tue, 02 Feb 2021 22:09:56 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Filipe Manana <fdmanana@kernel.org>
Subject: Re: [PATCH 6/6] btrfs: do not block inode logging for so long during transaction commit
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <20210202210151.4AE7.409509F4@e16-tech.com>
References: <CAL3q7H73JQk=ndXM7NB0iqyL6J60-pUw3O8X_LMRYfO+gKUt4g@mail.gmail.com> <20210202210151.4AE7.409509F4@e16-tech.com>
Message-Id: <20210202220953.5EA7.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Filipe Manana

There are some dbench(sync mode) result on the same hardware,
but with different linux kernel

4.14.200
Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 WriteX        225281     5.163    82.143
 Flush          32161     2.250    62.669
Throughput 236.719 MB/sec (sync open)  32 clients  32 procs  max_latency=82.149 ms

4.19.21
Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 WriteX        118842    10.946   116.345
 Flush          16506     0.115    44.575
Throughput 125.973 MB/sec (sync open)  32 clients  32 procs  max_latency=116.390 ms

4.19.150
 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 WriteX        144509     9.151   117.353
 lush          20563     0.128    52.014
Throughput 153.707 MB/sec (sync open)  32 clients  32 procs  max_latency=117.379 ms

5.4.91
 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 WriteX        367033     4.377  1908.724
 Flush          52037     0.159    39.871
Throughput 384.554 MB/sec (sync open)  32 clients  32 procs  max_latency=1908.968 ms

5.10.12+patches
Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 WriteX        429696     3.960  2239.973
 Flush          60771     0.621     6.794
Throughput 452.385 MB/sec (sync open)  32 clients  32 procs  max_latency=1963.312 ms


MaxLat / AvgLat  of WriteX is increased from 82.143/5.163=15.9  to
2239.973/3.960=565.6.

For QoS, can we have an option to tune the value of MaxLat / AvgLat  of
WriteX to less than 100?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/02/02

> Hi, Filipe Manana
> 
> > On Tue, Feb 2, 2021 at 5:42 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
> > >
> > > Hi, Filipe Manana
> > >
> > > The dbench result with these patches is very good. thanks a lot.
> > >
> > > This is the dbench(synchronous mode) result , and then a question.
> > >
> > > command: dbench -s -t 60 -D /btrfs/ 32
> > > mount option:ssd,space_cache=v2
> > > kernel:5.10.12 + patchset 1 + this patchset
> > 
> > patchset 1 and "this patchset" are the same, did you mean two
> > different patchsets or just a single patchset?
> 
> patchset1:
> btrfs: some performance improvements for dbench alike workloads
> 
> patchset2:
> btrfs: more performance improvements for dbench workloads
> https://patchwork.kernel.org/project/linux-btrfs/list/?series=422801
> 
> I'm sorroy that I have replayed to the wrong patchset.
> 
> > 
> > >
> > > Question:
> > > for synchronous mode, the result type 1 is perfect?
> > 
> > What do you mean by perfect? You mean if result 1 is better than result 2?
> 
> In result 1,  the MaxLat of Flush of dbench synchronous mode is fast as
> expected, the same level as  kernel 5.4.91.
> 
> But in result 2, the MaxLat of Flush of dbench synchronous mode is big
> as write level, but this is synchronous mode, most job should be done
> already before flush.
> 
> > > and there is still some minor place about the flush to do for
> > > the result type2?
> > 
> > By "minor place" you mean the huge difference I suppose.
> > 
> > >
> > >
> > > result type 1:
> > >
> > >  Operation      Count    AvgLat    MaxLat
> > >  ----------------------------------------
> > >  NTCreateX     868942     0.028     3.017
> > >  Close         638536     0.003     0.061
> > >  Rename         36851     0.663     4.000
> > >  Unlink        175182     0.399     5.358
> > >  Qpathinfo     789014     0.014     1.846
> > >  Qfileinfo     137684     0.002     0.047
> > >  Qfsinfo       144241     0.004     0.059
> > >  Sfileinfo      70913     0.008     0.046
> > >  Find          304554     0.057     1.889
> > > ** WriteX        429696     3.960  2239.973
> > >  ReadX        1363356     0.005     0.358
> > >  LockX           2836     0.004     0.038
> > >  UnlockX         2836     0.002     0.018
> > > ** Flush          60771     0.621     6.794
> > >
> > > Throughput 452.385 MB/sec (sync open)  32 clients  32 procs  max_latency=1963.312 ms
> > > + stat -f -c %T /btrfs/
> > > btrfs
> > > + uname -r
> > > 5.10.12-4.el7.x86_64
> > >
> > >
> > > result type 2:
> > >  Operation      Count    AvgLat    MaxLat
> > >  ----------------------------------------
> > >  NTCreateX     888943     0.028     2.679
> > >  Close         652765     0.002     0.058
> > >  Rename         37705     0.572     3.962
> > >  Unlink        179713     0.383     3.983
> > >  Qpathinfo     806705     0.014     2.294
> > >  Qfileinfo     140752     0.002     0.125
> > >  Qfsinfo       147909     0.004     0.049
> > >  Sfileinfo      72374     0.008     0.104
> > >  Find          311839     0.058     2.305
> > > ** WriteX        439656     3.854  1872.109
> > >  ReadX        1396868     0.005     0.324
> > >  LockX           2910     0.004     0.026
> > >  UnlockX         2910     0.002     0.025
> > > ** Flush          62260     0.750  1659.364
> > >
> > > Throughput 461.856 MB/sec (sync open)  32 clients  32 procs  max_latency=1872.118 ms
> > > + stat -f -c %T /btrfs/
> > > btrfs
> > > + uname -r
> > > 5.10.12-4.el7.x86_64
> > 
> > I'm not sure what your question is exactly.
> > 
> > Are both results after applying the same patchset, or are they before
> > and after applying the patchset, respectively?
> 
> Both result after applying the same patchset.
> and both on the same server, same SAS SSD disk.
> but the result is not stable, and the major diff is MaxLat of Flush.
> 
> Server:Dell T7610
> CPU: E5-2660 v2(10core 20threads) x2
> SSD:TOSHIBA  PX05SMQ040
> Memory:192G (with ECC)
> 
> 
> > If they are both with the patchset applied, and you wonder about the
> > big variation in the "Flush" operations, I am not sure about why it is
> > so.
> > Both throughput and max latency are better in result 2.
> > 
> > It's normal to have variations across dbench runs, I get them too, and
> > I do several runs (5 or 6) to check things out.
> > 
> > I don't use virtualization (testing on bare metal), I set the cpu
> > governor mode to performance (instead of the "powersave" default) and
> > use a non-debug kernel configuration, because otherwise I get
> > significant variations in latencies and throughput too (though I never
> > got a huge difference such as from 6.794 to 1659.364).
> 
> This is a bare metal(dell T7610).
> CPU mode is set to performance by BIOS. and I checked it by
> 'cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor'
> 
> Maybe I used a SAS ssd, and the queue depth of SAS SSD is 254.
> smaller than 1023 of a NVMe SSD,but it is still enough for
> dbench 32 threads?
> 
> 
> The huge difference of MaxLat of Flush such as from 6.794 to 1659.364 is
> a problem.
> It is not easy to re-product both,  mabye easy to reproduce the small
> one, maybe easy to reproduce the big one.
> 
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/02/02
> 


