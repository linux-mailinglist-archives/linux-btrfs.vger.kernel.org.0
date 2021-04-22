Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F8B367644
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Apr 2021 02:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbhDVAdF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 20:33:05 -0400
Received: from out20-85.mail.aliyun.com ([115.124.20.85]:38450 "EHLO
        out20-85.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbhDVAdE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 20:33:04 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04477254|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0154689-0.000495125-0.984036;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.K1x1okN_1619051548;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.K1x1okN_1619051548)
          by smtp.aliyun-inc.com(10.147.42.241);
          Thu, 22 Apr 2021 08:32:28 +0800
Date:   Thu, 22 Apr 2021 08:32:32 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: 'ls /mnt/scratch/' freeze(deadlock?) when run xfstest(btrfs/232)
Cc:     fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <e8886729-6f82-eca9-d752-0e81145794fe@gmx.com>
References: <9b4400ca-d0a3-621d-591c-dc377d0bed58@gmx.com> <e8886729-6f82-eca9-d752-0e81145794fe@gmx.com>
Message-Id: <20210422083231.755B.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> >>> we run xfstest on two server with this patch.
> >>> one passed the tests.
> >>> but one got a btrfs/232 error.
> >>>
> >>> btrfs/232 32s ... _check_btrfs_filesystem: filesystem on
> >>> /dev/nvme0n1p1is inconsistent
> >>> (see /usr/hpc-bio/xfstests/results//btrfs/232.full for details)
> >>> ...
> >>> [4/7] checking fs roots
> >>> root 5 inode 337 errors 400, nbytes wrong
> >>> ERROR: errors found in fs roots
> >>
> >> Ok, that's a different problem caused by something else.
> >> It's possible to be due to the recent refactorings for preparation to
> >> subpage block size.
> >
> > This error looks exactly what I have seen during subpage development.
> > The subpage bug is caused by incorrect btrfs_invalidatepage() though,
> > and not yet merged into misc-next anyway.
> >
> > I guess it's some error path not clearing extent states correctly, thus
> > leaving the inode nbytes accounting wrong.
> >
> > BTW, the new @in_reclaim_context parameter for start_delalloc_inodes()
> > is already in misc-next:
> > commit 3d45f221ce627d13e2e6ef3274f06750c84a6542
> > Author: Filipe Manana <fdmanana@suse.com>
> > Date:?? Wed Dec 2 11:55:58 2020 +0000
> >
> >  ?? btrfs: fix deadlock when cloning inline extent and low on free
> > metadata space
> >
> > We only need to make btrfs_start_delalloc_snapshot() to accept the new
> > parameter and pass in_reclaim_context = true for qgroup.
> 
> Strangely, on my subpage branch, with new @in_reclaim_context parameter
> added to btrfs_start_delalloc_snapshot(), I can't reproduce the nbytes
> mismatch error in 32 runs loop.
> I guess one of the refactor around ordered extents and invalidatepage
> may fix the problem by accident.
> 
> Mind to test my subpage branch
> (https://github.com/adam900710/linux/tree/subpage) with the attached diff?

The attached diff( more in_reclaim_context) seems a replacement for 
https://pastebin.com/raw/U9GUZiEf (less in_reclaim_context).

so I  will firstly test with the attached diff but drop
https://pastebin.com/raw/U9GUZiEf.

The test of whole subpage branch will be done later.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/04/22


