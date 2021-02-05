Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD45310264
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 02:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhBEBsd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 20:48:33 -0500
Received: from out20-39.mail.aliyun.com ([115.124.20.39]:48531 "EHLO
        out20-39.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbhBEBs3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Feb 2021 20:48:29 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04828021|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0124308-0.000599168-0.98697;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.JVKe6j0_1612489660;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JVKe6j0_1612489660)
          by smtp.aliyun-inc.com(10.147.41.120);
          Fri, 05 Feb 2021 09:47:40 +0800
Date:   Fri, 05 Feb 2021 09:47:44 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 6/6] btrfs: do not block inode logging for so long during transaction commit
Cc:     Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <6196ffee-e5a4-6135-b579-720859959038@suse.com>
References: <20210204193431.68E5.409509F4@e16-tech.com> <6196ffee-e5a4-6135-b579-720859959038@suse.com>
Message-Id: <20210205094740.AB82.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On 4.02.21 §Ô. 13:34 §é., Wang Yugui wrote:
> > Hi,
> > 
> >> On 4.02.21 §Ô. 5:17 §é., Wang Yugui wrote:
> >>> Hi,
> >>>
> >>> I tried to run btrfs misc-next(5.11-rc6 +81patches) based on linux LTS
> >>> 5.10.12 with the same other kernel components and the same kernel config.
> >>>
> >>> Better dbench(sync open) result on both Throughput and max_latency.
> >>>
> >>
> >> If i understand correctly you rebased current misc-next to 5.10.12, if
> >> so this means there is something else in the main kernel, that's not
> >> btrfs related which degrades performance, it seems you've got a 300ms
> >> win by running on 5.10 as compared on 5.11-rc6-based misc next, is that
> >> right?
> > 
> > Yes.
> 
> I just realized this could also be caused by btrfs code that has already
> landed in v5.11-rc1 for example. I.e the main pull req for this release.

This performance problem seems very complex.

result of btrfs 5.10.12 + these btrfs patchset +  linux other kernel of 5.10.12
- 5.11 free-space-tree 13 patch
- 5.11 btrfs: some performance improvements for dbench alike workloads
- misc-next btrfs: more performance improvements for dbench workloads
- misc-next Improve preemptive ENOSPC flushing

 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX     858500     0.030     2.969
 Close         630548     0.002     0.071
 Rename         36416     0.744     3.791
 Unlink        173375     0.503     4.109
 Qpathinfo     779355     0.014     2.715
 Qfileinfo     136041     0.002     0.054
 Qfsinfo       142728     0.004     0.084
 Sfileinfo      69953     0.010     0.098
 Find          301093     0.059     2.670
 WriteX        424594     3.999  1765.527
 ReadX        1348726     0.005     0.397
 LockX           2816     0.004     0.022
 UnlockX         2816     0.003     0.025
 Flush          60094     0.764  1478.133

Throughput 445.83 MB/sec (sync open)  32 clients  32 procs  max_latency=1765.539 ms

still worse than btrfs misc-next(20210203) + linux other kernel of 5.10.12

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

so there is some other patch in misc-next improved this performance too.

but MaxLat/AvgLat of WriteX  is still 175 in 
btrfs misc-next(20210203) + linux other kernel of 5.10.12,
so there maybe some patch after 5.10 cause new performance problem too.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/02/04


> > 
> > maybye some code rather than btrfs in main kernel 5.11.rc6 have degrades
> > performance.
> > or maybe just because of different kernel config.
> > kernel config I used:
> > https://kojipkgs.fedoraproject.org/packages/kernel/5.11.0/0.rc6.141.eln108/
> > https://kojipkgs.fedoraproject.org/packages/kernel/5.10.12/200.fc33/
> > 
> > I rebased current misc-next to 5.10.12, so that there is only diff in
> > btrfs source code.
> > 
> > only 3 minor patch needed for this rebase, there seems no broken kernel API
> >  change for btrfs between 5.10 and 5.11.
> > # add-to-5.10  0001-block-add-a-bdev_kobj-helper.patch
> > # drop-from-btrs-misc-next  0001-block-remove-i_bdev.patch
> > # fix-to-btrfs-misc-next  	0001-btrfs-bdev_nr_sectors.patch
> > 
> > more patch come into misc-next today, they are yet not rebased/tested.
> > 
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2021/02/04
> > 


