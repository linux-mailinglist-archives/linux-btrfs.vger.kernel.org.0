Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2473B4AF8B9
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 18:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbiBIRsy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 12:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbiBIRsw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 12:48:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437A8C05CB82
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 09:48:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD53861967
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 17:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C8EC340E7;
        Wed,  9 Feb 2022 17:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644428934;
        bh=0TUrf7a50sXz3jgM7f0UrRIfvGG49YpgH5zhP17cy0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXP5cdr44IjsiZqi5A1SEXlce77HHCBPY+DiLThywVakpEHfa+dodWM3GBo6+JSxn
         HUhNoV6+/r6XAye6U0MsoCmQtDHLUcf/Dc3eWokqsopFRJLK9aRrA/uKtiyTn/n+EJ
         Q4emJnYN0tsNWRdB2tgTiODMZuUjFsq20ast208H6Qd4dJkGvS1Io/ajm6BJWw44TJ
         GssMcWsin9NT3sOMjDRiWPYd1tMJktANfQyVxDow+yBYTqaiTHAJGA+rf53ZEPBRrX
         qWOdtD7aL4FQLPvGbgY+PhCD6NUyjciysL3EJsl8Ik6KCN0Is90bdKSw5nJ0f/DTWH
         n4ZhZ4D0uVdFw==
Date:   Wed, 9 Feb 2022 17:48:51 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] btrfs: make autodefrag to defrag and only defrag
 small write ranges
Message-ID: <YgP+gwEcKd92bWDT@debian9.Home>
References: <cover.1644398069.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1644398069.git.wqu@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 09, 2022 at 05:23:11PM +0800, Qu Wenruo wrote:
> Previously autodefrag works by scanning the whole file with a minimal
> generation threshold.
> 
> Although we have various optimization to skip ranges which don't meet
> the generation requirement, it can still waste some time on scanning the
> whole file, especially if the inode got an almost full overwrite.
> 
> There is another problem, there is a gap between our small writes and
> defrag extent size threshold.
> 
> In fact, for compressed writes, <16K will be considered as small writes,
> while for uncompressed writes, <32K will be considered as small writes.
> 
> On the other hand, autodefrag uses 256K as default extent size
> threshold.
> 
> 
> This means if one file has a lot of writes larger than 32K, which
> normally will not trigger autodefrag, but if one small write happens,
> all writes between 32K and 256K will be defragged.
> 
> This double standards is causing extra IO.
> 
> This patchset will address it by only defragging the small writes which
> trigger autodefrag.
> 
> 
> This rework will cause the following behavior change:
> 
> - Only small write ranges will be defragged
>   Exactly what we want.
> 
> - Enlarged critical section for fs_info::defrag_inodes_lock
>   Now we need to not only add the inode_defrag structure to rb tree, but
>   also call set_extent_bits() inside the critical section.
> 
>   Thus defrag_inodes_lock is upgraded to mutex.
> 
>   No benchmark for the possible performance impact though.
> 
> - No inode re-queue if there are large sectors to defrag
>   Not sure if this will make a difference, as we no longer requeue, and
>   only scan forward.
> 
> Reason for RFC:
> 
> I'm not sure if this is the correct way to go, but with my biased eyes,
> it looks very solid.
> 
> Another concern is how to backport for v5.16.

This is a whole new behaviour that 5.15, and older kernels, did not have.
And it's quite a huge change in behaviour, it would need to be well tested.
There's the potential for much more extra memory usage, blocking writeback
and the cleaner kthread for longer periods and delaying other operations the
cleaner does besides defrag (run delayed iputs, delete empty block groups,
delete subvolumes/snapshots, etc). Right now, it seems to risky to backport.

Anyway, I left my comments and concerns on patch 3/3.
Patch 2/3 seems pointless, it's trivial and short, and it's only used after
patch 3/3, so it could be squashed with 3/3.

Thanks.

> 
> Qu Wenruo (3):
>   btrfs: remove an unused parameter of btrfs_add_inode_defrag()
>   btrfs: introduce IO_TREE_AUTODEFRAG owner type
>   btrfs: make autodefrag to defrag small writes without rescanning the
>     whole file
> 
>  fs/btrfs/ctree.h          |   5 +-
>  fs/btrfs/disk-io.c        |   2 +-
>  fs/btrfs/extent-io-tree.h |   1 +
>  fs/btrfs/file.c           | 217 +++++++++++++++++++++-----------------
>  fs/btrfs/inode.c          |   2 +-
>  5 files changed, 125 insertions(+), 102 deletions(-)
> 
> -- 
> 2.35.0
> 
