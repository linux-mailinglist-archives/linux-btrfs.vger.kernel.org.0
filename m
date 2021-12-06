Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD96146994B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 15:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344595AbhLFOrZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 09:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344612AbhLFOq7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 09:46:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA8FC0613F8
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 06:43:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CD3C612E7
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 14:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120AAC341C1;
        Mon,  6 Dec 2021 14:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638801809;
        bh=GbkIPdP3MBiGLGHJJ12f1EfvhBTL2Kj5Ukl4f8QSNJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vNkQyMaGmA8+PepMvaJgphpab0J9bHSyBSg9YUanQXCTfSr8rvCgg409lhmkgAnDE
         m5JJ8/WK7jvLryDW68PwR/1KqpTy0Jz6EYCNqR2fjOWxgM/j+tReIZSFMeepBfiqqX
         ZGhjTCciZmFX4jjgGESZJZ0dnlcJiLKq51ydU+DdyS6h9EPK5SR0N4u2BS6wfPpKz2
         xTRhL4noDSYXEzR/jx7iWBhqRPQq96OUQ41iH+kVRw17ZGYPTkv0J6dBqfVteKBo5T
         nkXW2fA1aLCyy3Fv8I/vY0mYyhRImzok66/wLPKK3M1+G1lTkzNo4u2+1c6nbio79k
         wj6bgtcbpSgkA==
Date:   Mon, 6 Dec 2021 14:43:25 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/18] Truncate cleanups and preparation work
Message-ID: <Ya4hjVNLjDK4ZDOu@debian9.Home>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 03, 2021 at 05:18:02PM -0500, Josef Bacik wrote:
> Hello,
> 
> The first thing I'm implementing with the garbage collection tree is
> btrfs_truncate_inode_items() on evicted inodes.  However
> btrfs_truncate_inode_items() has a lot of oddities that it's grown over the
> years, and requires having a valid btrfs_inode to use.  We don't really want to
> have to look up the old inode to do the truncate, we just want to do the tree
> operaitons to delete all of the objects and extents.
> 
> Enter this patch series, I've cleaned up btrfs_truncate_inode_items(), moved as
> much of the inode operations out to the respective callers, and cleaned up the
> argument passing and such to make it a little cleaner.
> 
> We still have to pass in the inode for the ^NO_HOLES case for the normal
> truncate path, but other than that I've stripped it down so that we can pass in
> a NULL inode and get all the work done.
> 
> This has the nice side-effect of cleaning up a lot of our
> 
> if (root == LOG_ROOT)
> 	// do something else
> 
> checks in this helper, and hopefully makes it more straightforward to
> understand.  Thanks,
> 
> Josef
> 
> Josef Bacik (18):
>   btrfs: add an inode-item.h
>   btrfs: move btrfs_truncate_inode_items to inode-item.c
>   btrfs: move extent locking outside of btrfs_truncate_inode_items
>   btrfs: remove free space cache inode check in
>     btrfs_truncate_inode_items
>   btrfs: move btrfs_kill_delayed_inode_items into evict
>   btrfs: remove found_extent from btrfs_truncate_inode_items
>   btrfs: add btrfs_truncate_control struct
>   btrfs: only update i_size in truncate paths that care
>   btrfs: only call inode_sub_bytes in truncate paths that care
>   btrfs: control extent reference updates with a control flag for
>     truncate
>   btrfs: use a flag to control when to clear the file extent range
>   btrfs: pass the ino via btrfs_truncate_control
>   btrfs: add inode to btrfs_truncate_control
>   btrfs: convert BUG_ON() in btrfs_truncate_inode_items to ASSERT
>   btrfs: convert BUG() for pending_del_nr into an ASSERT
>   btrfs: combine extra if statements in btrfs_truncate_inode_items
>   btrfs: make should_throttle loop local in btrfs_truncate_inode_items
>   btrfs: do not check -EAGAIN when truncating inodes in the log root
> 
>  fs/btrfs/ctree.h            |  34 ---
>  fs/btrfs/delayed-inode.c    |   1 +
>  fs/btrfs/free-space-cache.c |  31 ++-
>  fs/btrfs/inode-item.c       | 334 ++++++++++++++++++++++++++
>  fs/btrfs/inode-item.h       |  86 +++++++
>  fs/btrfs/inode.c            | 452 +++++-------------------------------
>  fs/btrfs/relocation.c       |   1 +
>  fs/btrfs/tree-log.c         |  15 +-
>  8 files changed, 511 insertions(+), 443 deletions(-)
>  create mode 100644 fs/btrfs/inode-item.h

Looks good, and it passed one iteration of fstests here.

For the whole series:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> 
> -- 
> 2.26.3
> 
