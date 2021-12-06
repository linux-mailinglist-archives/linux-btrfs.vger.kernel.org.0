Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C1446A913
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 22:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350140AbhLFVKZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 16:10:25 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47750 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243937AbhLFVKY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 16:10:24 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C81A31FD2F;
        Mon,  6 Dec 2021 21:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638824814;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7VHIvOvCa/P//NGNM/aR33zDxDtLtCPuc6xhKvwVjFA=;
        b=x498tJ/dA3BKqlHpPHzaHoe2VT7BdVmxzmaa+fdWq8R69wNejFME92/R9b5KLztJT51b1M
        kZBCB4xkjiRzIc+9njFuu7vlE2FSF+hmwhJ0ctPbb45fNaaX3QdDx4BZtyAjdYEnB7SI2G
        xPcmjsrV2SLmwGOpZ83I7l7Rve+BHlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638824814;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7VHIvOvCa/P//NGNM/aR33zDxDtLtCPuc6xhKvwVjFA=;
        b=9KHyDO1EUrKy0Nv+FZDgIkRMThpUILKZmboD7F2vjWn8A6Jr9n/jpwMiQ5s/hgr3xoUyBL
        o53YFQ/2NlejCQBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BFF67A3B87;
        Mon,  6 Dec 2021 21:06:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 90D6EDA799; Mon,  6 Dec 2021 22:06:40 +0100 (CET)
Date:   Mon, 6 Dec 2021 22:06:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/18] Truncate cleanups and preparation work
Message-ID: <20211206210640.GU28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
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

Added to misc-next, thanks.
