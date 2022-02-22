Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BB44BEF0A
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 02:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbiBVB2Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Feb 2022 20:28:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbiBVB2P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Feb 2022 20:28:15 -0500
Received: from eu-shark1.inbox.eu (eu-shark1.inbox.eu [195.216.236.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F5C24F37
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Feb 2022 17:27:50 -0800 (PST)
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id BCDDF6C007C8;
        Tue, 22 Feb 2022 03:27:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1645493267; bh=q1JmgKwiB98KuJ05VyzdDMG25347g31LVTGMHO4KPUo=;
        h=References:From:To:Cc:Cc:Cc:Subject:Date:In-reply-to:Message-ID:
         Content-Type:X-ESPOL:from:date:to:cc;
        b=MZbTD1TUsWlLJDphlS0f0wFb/yvl+Lrqig4PXWBzNzLhTjh0S36vtmVskGEV87Z7b
         kCkGEPcbttwLVc74ZXhmjnQqdG+YjXtiIUyM9JWpu22b5aDM8Gr2w9iAgwWxvFqUyZ
         7zqIRlXmtHCHAD/X21LjyFDFbiWgEgm+e6nQDDRE=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id AC9C56C007C6;
        Tue, 22 Feb 2022 03:27:47 +0200 (EET)
X-Amavis-Alert: BAD HEADER SECTION, Header field occurs more than once: "Cc"
        occurs 3 times
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id VrVRUlwr_R2Z; Tue, 22 Feb 2022 03:27:47 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 511D56C007C2;
        Tue, 22 Feb 2022 03:27:47 +0200 (EET)
References: <cover.1644737297.git.wqu@suse.com>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Cc:     jd.girard@sysnux.pf
Cc:     ben.r.xiao@gmail.com
Subject: Re: [PATCH 0/4] btrfs: make autodefrag to defrag and only defrag
 small write ranges
Date:   Tue, 22 Feb 2022 09:10:45 +0800
In-reply-to: <cover.1644737297.git.wqu@suse.com>
Message-ID: <fsobsnaw.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWe8dgszs1MpUezl+Pm71B9HnX/7LyyEd1R+Lh33wixqPg+1xF8X
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Sun 13 Feb 2022 at 15:42, Qu Wenruo <wqu@suse.com> wrote:

> When a small write reaches disk, btrfs will mark the inode for
> autodefrag, and record the transid of the inode for autodefrag.
>
> Then autodefrag uses the transid to only scan newer file 
> extents.
>
> However this transid based scanning scheme has a hole, the small 
> write
> size threshold triggering autodefrag is not the same extent size
> threshold for autodefrag.
>
> For the following write sequence on an non-compressed inode:
>
>  pwrite 0 4k
>  sync
>  pwrite 4k 128k
>  sync
>  pwrite 132k 128k
>  sync.
>
> The first 4K is indeed a small write (<64K), but the later two 
> 128K ones
> are definite not (>64K).
>
> Hoever autodefrag will try to defrag all three writes, as the
> extent_threshold used for autodefrag is fixed 256K.
>
> This extra scanning on extents which didn't trigger autodefrag 
> can cause
> extra IO.
>
> This patchset will try to address the problem by:
>
> - Remove the inode_defrag re-queue behavior
>   Now we just scan one file til its end (while keep the
>   max_sectors_to_defrag limit, and frequently check the root 
>   refs, and
>   remount situation to exit).
>
>   This also saves several bytes from inode_defrag structure.
>
>   This is done in the 3rd patch.
>
> - Save @small_write value into inode_defrag and use it as 
> autodefrag
>   extent threshold
>   Now there is no gap for autodefrag and small_write.
>
>   This is done in the 4th patch.
>
> The remaining patches are:
>
> - Removing one dead parameter
>
> - Add extra trace events for autodefrag
>   So end users will no longer need to re-compile kernel modules, 
>   and
>   use trace events to provide debug info on the 
>   autodefrag/defrag ioctl.
>
> Unfortunately I don't have a good benchmark setup for the 
> patchset yet,
> but unlike previous RFC version, this one brings very little 
> extra
> resource usage, and is just changing the extent_threshold for
> autodefrag.
>
> Changelog:
> RFC->v1:
> - Add ftrace events for defrag
>
> - Add a new patch to change how we run defrag inodes
>   Instead of saving previous location and re-queue, just run it 
>   in one
>   run.
>   Previously btrfs_run_defrag_inodse() will always exhaust the 
>   existing
>   inode_defrag anyway, the change should not bring much 
>   difference.
>
> - Change autodefrag extent_thresh to close the gap, other than 
> using
>   another extent io tree
>   Now it uses less resource, keep the critical section small, 
>   while
>   can almost reach the same objective.
>
> Qu Wenruo (4):
>   btrfs: remove unused parameter for btrfs_add_inode_defrag()
>   btrfs: add trace events for defrag
>   btrfs: autodefrag: only scan one inode once
>   btrfs: close the gap between inode_should_defrag() and 
>   autodefrag
>     extent size threshold
>

Cc the reporters.

It was about ~20 days agao when I saw the report about autodefrag 
causes
IO burning. Then I turned the autodefrag option of the raid1 btrfs 
on
my NAS to do some experimental tests.

At first time, I tried to download files in ~20GB size but iotop 
showed
everything was fine. And the autodefrag was left in /etc/fstab.
When I was back from my vacation, it surprised me that my 4TB size 
disk
has been written about ~70TB and iotop showed btrfs-cleaner is 
eating
the whole disk io bandwidth.

And after switched kernel 5.16.8-arch1-1 from to Qu's 
autodefrag_fixes[1],
I'd say the btrfs on my NAS works well(no panic of course) and no 
more
IO burning occurs.

https://github.com/adam900710/linux/tree/autodefrag_fixes
--
Su
>  fs/btrfs/ctree.h             |   3 +-
>  fs/btrfs/file.c              | 165 
>  +++++++++++++++--------------------
>  fs/btrfs/inode.c             |   4 +-
>  fs/btrfs/ioctl.c             |   4 +
>  include/trace/events/btrfs.h | 127 +++++++++++++++++++++++++++
>  5 files changed, 206 insertions(+), 97 deletions(-)
