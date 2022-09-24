Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D555E88C7
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Sep 2022 08:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbiIXGlL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Sep 2022 02:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiIXGlK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Sep 2022 02:41:10 -0400
Received: from out20-86.mail.aliyun.com (out20-86.mail.aliyun.com [115.124.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524B29AFEA
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 23:41:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04439814|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0290267-0.0108302-0.960143;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.PNF5j.A_1664001663;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.PNF5j.A_1664001663)
          by smtp.aliyun-inc.com;
          Sat, 24 Sep 2022 14:41:04 +0800
Date:   Sat, 24 Sep 2022 14:41:09 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: fstests btrfs/042 triggle 'qgroup reserved space leaked'
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <a80263f7-9ff7-4f1b-d863-8d092cbb9a7a@gmx.com>
References: <20220924120727.C245.409509F4@e16-tech.com> <a80263f7-9ff7-4f1b-d863-8d092cbb9a7a@gmx.com>
Message-Id: <20220924144106.E3BE.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> 
> On 2022/9/24 12:07, Wang Yugui wrote:
> > Hi,
> >
> >> On 2022/9/24 10:11, Wang Yugui wrote:
> >>> Hi,
> >>>
> >>>>
> >>>> On 2022/9/24 07:43, Wang Yugui wrote:
> >>>>> Hi,
> >>>>>
> >>>>> fstests btrfs/042 triggle 'qgroup reserved space leaked'
> >>>>>
> >>>>> kernel source: btrfs misc-next
> >>>>
> >>>> Which commit HEAD?
> >>>>
> >>>> As I can not reproduce using a somewhat older misc-next.
> >>>>
> >>>> The HEAD I'm on is 2d1aef6504bf8bdd7b6ca9fa4c0c5ab32f4da2a8 ("btrfs: stop tracking failed reads in the I/O tree").
> >>>>
> >>>> If it's a regression it can be much easier to pin down.
> >>>>
> >>>>> kernel config:
> >>>>> 	memory debug: CONFIG_KASAN/CONFIG_DEBUG_KMEMLEAK/...
> >>>>> 	lock debug: CONFIG_PROVE_LOCKING/...
> >>>>
> >>>> And any reproducibility? 16 runs no reproduce.
> >>>
> >>> btrfs source version: misc-next: bf940dd88f48,
> >>> 	plus some minor local patch(no qgroup related)
> >>> kernel: 6.0-rc6
> >>>
> >>> reproduce rate:
> >>> 1) 100%(3/3) when local debug config **1
> >>> 2)  0% (0/3) when local release config
> >>>
> >>> **1:local debug config, about 100x slow than release config
> >>> a) memory debug
> >>> 	CONFIG_KASAN/CONFIG_DEBUG_KMEMLEAK/...
> >>> b) lockdep debug
> >>> 	CONFIG_PROVE_LOCKING/...
> >>> c) btrfs debug
> >>> CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
> >>> CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
> >>> CONFIG_BTRFS_DEBUG=y
> >>> CONFIG_BTRFS_ASSERT=y
> >>> CONFIG_BTRFS_FS_REF_VERIFY=y
> >>
> >> I always run with all btrfs features enabled.
> >>
> >> So is the lockdep.
> >>
> >> KASAN is known to be slow, thus that is only enabled when there is suspision on memory corruption caused by some wild pointer.
> >>
> >>>
> >>>
> >>>   From source:
> >>> fs/btrfs/disk-io.c:4668
> >>>       if (btrfs_check_quota_leak(fs_info)) {
> >>> L4668        WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> >>>           btrfs_err(fs_info, "qgroup reserved space leaked");
> >>>       }
> >>>
> >>> This problem will triggle fstests btrfs/042 to failure only when
> >>> CONFIG_BTRFS_DEBUG=y ?
> >>>
> >>>
> >>> maybe related issue:
> >>> when lockdep debug is enabled, the following issue become very easy to
> >>> reproduce too.
> >>> https://lore.kernel.org/linux-nfs/3E21DFEA-8DF7-484B-8122-D578BFF7F9E0@oracle.com/
> >>> so there maybe some lockdep debug related , but not btrfs related
> >>> problem in kernel 6.0.
> >>>
> >>>
> >>> more test(remove some minor local patch(no qgroup related)) will be done,
> >>> and then I will report the result.
> >>
> >> Better to provide the patches, as I just finished a 16 runs of btrfs/042, no reproduce.
> >>
> >> Thus I'm starting to suspect the off-tree patches.
> >
> > This problem happen on linux 6.0-rc6+ (master a63f2e7cb110, without
> > btrfs misc-next patch, without local off-tree patch)
> 
> Same base, still nope.
> 
> > so this problem is not related to the patches still in btrfs misc-next.
> >
> > reproduce rate:
> > 100%(3/3) when local debug config
> > and the whole config file is attached.
> >
> 
> I don't think the config makes much difference, as the main difference
> is in KASAN and KMEMLEAK, which should not impact the test result.
> 
> And are you running just that test, or with the full auto group?

For 6.0-rc6 with btrfs misc-next, I tried to run  full auto group.
btrfs/042 failed, others(btrfs/001 ~ btrfs/157) are OK, and then I
rebooted the test machine.

for 6.0-rc6 without btrfs misc-next, I tested btrfs/042 and btrfs/001 on
the same machine.
then I tested 6.0-rc6 without btrfs misc-next on another 2 servers.

reproduce rate:
server1	3/3
server2	2/3
server3	3/3
total rate: 8/9

all 3 servers are in good status(ECC memory status and SSD status).

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/09/24


