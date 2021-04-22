Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DD4367868
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Apr 2021 06:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhDVEQo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Apr 2021 00:16:44 -0400
Received: from out20-98.mail.aliyun.com ([115.124.20.98]:40251 "EHLO
        out20-98.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhDVEQn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Apr 2021 00:16:43 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04438075|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0175027-0.000231544-0.982266;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.K22R4bX_1619064967;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.K22R4bX_1619064967)
          by smtp.aliyun-inc.com(10.147.42.22);
          Thu, 22 Apr 2021 12:16:08 +0800
Date:   Thu, 22 Apr 2021 12:16:11 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: 'ls /mnt/scratch/' freeze(deadlock?) when run xfstest(btrfs/232)
Cc:     fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <aa9ffab6-02cb-16a0-794c-80a990c4f999@gmx.com>
References: <20210422083231.755B.409509F4@e16-tech.com> <aa9ffab6-02cb-16a0-794c-80a990c4f999@gmx.com>
Message-Id: <20210422121608.BBAC.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On 2021/4/22 ÉÏÎç8:32, Wang Yugui wrote:
> > Hi,
> >
> >>>>> we run xfstest on two server with this patch.
> >>>>> one passed the tests.
> >>>>> but one got a btrfs/232 error.
> >>>>>
> >>>>> btrfs/232 32s ... _check_btrfs_filesystem: filesystem on
> >>>>> /dev/nvme0n1p1is inconsistent
> >>>>> (see /usr/hpc-bio/xfstests/results//btrfs/232.full for details)
> >>>>> ...
> >>>>> [4/7] checking fs roots
> >>>>> root 5 inode 337 errors 400, nbytes wrong
> >>>>> ERROR: errors found in fs roots
> >>>>
> >>>> Ok, that's a different problem caused by something else.
> >>>> It's possible to be due to the recent refactorings for preparation to
> >>>> subpage block size.
> >>>
> >>> This error looks exactly what I have seen during subpage development.
> >>> The subpage bug is caused by incorrect btrfs_invalidatepage() though,
> >>> and not yet merged into misc-next anyway.
> >>>
> >>> I guess it's some error path not clearing extent states correctly, thus
> >>> leaving the inode nbytes accounting wrong.
> >>>
> >>> BTW, the new @in_reclaim_context parameter for start_delalloc_inodes()
> >>> is already in misc-next:
> >>> commit 3d45f221ce627d13e2e6ef3274f06750c84a6542
> >>> Author: Filipe Manana <fdmanana@suse.com>
> >>> Date:?? Wed Dec 2 11:55:58 2020 +0000
> >>>
> >>>   ?? btrfs: fix deadlock when cloning inline extent and low on free
> >>> metadata space
> >>>
> >>> We only need to make btrfs_start_delalloc_snapshot() to accept the new
> >>> parameter and pass in_reclaim_context = true for qgroup.
> >>
> >> Strangely, on my subpage branch, with new @in_reclaim_context parameter
> >> added to btrfs_start_delalloc_snapshot(), I can't reproduce the nbytes
> >> mismatch error in 32 runs loop.
> >> I guess one of the refactor around ordered extents and invalidatepage
> >> may fix the problem by accident.
> >>
> >> Mind to test my subpage branch
> >> (https://github.com/adam900710/linux/tree/subpage) with the attached diff?
> >
> > The attached diff( more in_reclaim_context) seems a replacement for
> > https://pastebin.com/raw/U9GUZiEf (less in_reclaim_context).
> 
> The attached diff is for subpage branch, as misc-next already has the
> parameter introduced for another bug.
> Thus only a small part is needed for subpage branch.

nothing is found when 'grep in_reclaim_context' in 112 patch of misc-next
since 5.12-rc8.


> > so I  will firstly test with the attached diff but drop
> > https://pastebin.com/raw/U9GUZiEf.

test result:
	it passed xfstests in 2 server * 1 loop.  no error is deteced.

Although the reproduce frequecy of these two problems is yet not clear,
the patch from Qu could be considered as current fix ?


> > The test of whole subpage branch will be done later.
> 
> So far, I also tested the older misc-next branch, and unable to
> reproduce the problem.
> I guess some patch in misc-next has already solved the problem.
> 
> If possible it would be better to provide the branch you're on so that
> we could do more tests to pin down the bug.


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/04/22

