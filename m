Return-Path: <linux-btrfs+bounces-20109-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC01CF4F1A
	for <lists+linux-btrfs@lfdr.de>; Mon, 05 Jan 2026 18:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B104F3015D39
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 17:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866C730748B;
	Mon,  5 Jan 2026 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="FrjkcvmP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SksHrKbx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45233191A4
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767633326; cv=none; b=FS4thg9phw9pK+M1Mkjl/f3t4Rb3OVx4KpepiTpNG5ELu3mmJ88zBpz2GjNPl0zd9orcH+SaB5SeUnSg7N5X8ocxEvo6l4j7WXW7zgz6rpdHlrgeA9yziOLXj27n9rbdI3X/AwDnk+F1ojEFEH4I2y1p/EoQjqhyFmHmANcUvzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767633326; c=relaxed/simple;
	bh=ByADqk7YOTJEdmcJgBwPT1nfT/ANxWpIYIuQZjPnx30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnqisurPQipmByGfdzNgiO7jXUpVqqlnibn8EsH7TNsMyHkSEw+G451KrqevjPtW/aspZyGtxlUKplOgLThUferxa2p85SBKhQl5n9mEGAiS3xZFpUKFPgFbN/+zGET+0zwFg3fM1Db8s9rPAXSrfFD6vl4owBAeGAZG/1/2F3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=FrjkcvmP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SksHrKbx; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id ACA4A1D000C7;
	Mon,  5 Jan 2026 12:15:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 05 Jan 2026 12:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767633322; x=1767719722; bh=lMX6D9fmc+
	EBY9DEzH+5BcbV3kWPvuDApcmI6bVq9CM=; b=FrjkcvmPTkbG+V8dW3KmIOMXFR
	hvRSg3h4BqgahlGLIO5vkDbWHv72f61A99vV+3gG8v3rzb5r0x4OtTtuU5qalHcy
	umz08TfyEDpxHTHHzmRI8qZIMIEwT5uU2oNsTwoMK8WdM9ae8IUlAk29W03TnEyC
	UgsOTEcVfntc4votTVbm/wQHKSHOWHXezbGZ1whfzECk8amsdbmhIM7daHmsY0vn
	25TjEuj88c2aF8arpvnTDuW4obf4GyePE2YpZDIwzHNRtXC0RL3R3YZ3IgF12Trl
	dmGKBk4yun5vKC90jgBr/VvNr8FfLc9xH4bn1EBoxNcgm/jgBeV9XaNYIAHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767633322; x=1767719722; bh=lMX6D9fmc+EBY9DEzH+5BcbV3kWPvuDApcm
	I6bVq9CM=; b=SksHrKbxA26QNKOzMD4V8ghk8dYfaWXZ8BdhzNxAqblpLwfgoPt
	CKS0aue6QjjTNJsYg3+LoIYVxJ7jLUgo7xiNOVGICQWxkcUarHkl84JugSJC0wlB
	l+B8wsboRMgZETzigfSZBYQxSouG9ZtkULChQCnsUL8p4CKmEjdvaC7yP0YoOqzu
	rEPOSWX97eGzpNZYId9JADR/prJmBZyE28vsVfgBNRlvUQZURo/ZtTL2mP2X1DLv
	nO/lKUMV9ArXarzSYgT0px8gp/2sZsQwjFjdFvXpyB19f2rZdg8aSF3FCr/ZR6iW
	+uUlzxBB9Tdl4Gk1+wRAg5xm+K0tPWZnP6w==
X-ME-Sender: <xms:qvFbaTbgbV6pGWh9Ef3wsGFa5nQZ0OILRVxjIcxYLPuxemH2VYpKiQ>
    <xme:qvFbaYaalEqeCgQNfpWYV_Rx3D4B8OTTvDmFjmrogiF1gac8C2hUbqsrDRspDG69_
    WA5gg3U9EObVtOjW6CXjW8O_a1fvZYZDFMfeESO8W3boJk-a2LGnw>
X-ME-Received: <xmr:qvFbaTkl6x_FtqL6NKve6wFm0xmJPPnCew7mlt2Xxwp3h-5Ex8Ztce16wZYgsH_QBYJpOx7zROspI1jxVgQP3ZKYjWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeehtdfhvefghfdtvefghfelhffgueeugedtveduieehie
    ehteelgeehvdefgeefgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehfughmrghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qvFbaUxY9sAYRQZdmvyFRyK6FgCBcPBhW1G70T5nb_-gLdxvoKt7tQ>
    <xmx:qvFbaRNeDrQqHEXOQ8OSH-iHgMpl3fq0qGbld-wKJm3vN12faFXUYQ>
    <xmx:qvFbaYQLv2OK5q0N6V0trzyncv68-vQ6ewpMpJxgpbeB6LTffgpelA>
    <xmx:qvFbafYx9Q1b1m9iumz6WGvxJc6t1SCzeK6qrwsOTmZsxB1g0j44sg>
    <xmx:qvFbaRPSMK9bmpUb0Q_6iB1KKShm1_UogQiiqXylBEvTcFkjTvonXjfe>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 12:15:22 -0500 (EST)
Date: Mon, 5 Jan 2026 09:15:36 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: release path before iget_failed() in
 btrfs_read_locked_inode()
Message-ID: <20260105171536.GA1011165@zen.localdomain>
References: <08d3bfec635a318d7bf7af84d2153c2f64513204.1766143542.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08d3bfec635a318d7bf7af84d2153c2f64513204.1766143542.git.fdmanana@suse.com>

On Fri, Dec 19, 2025 at 11:26:02AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In btrfs_read_locked_inode() if we fail to lookup the inode, we jump to
> the 'out' label with a path that has a read locked leaf and then we call
> iget_failed(). This can result in a ABBA deadlock, since iget_failed()
> triggers inode eviction and that causes the release of the delayed inode,
> which must lock the delayed inode's mutex, and a task updating a delayed
> inode starts by taking the node's mutex and then modifying the inode's
> subvolume btree.
> 
> Syzbot reported the following lockdep splat for this:
> 
>    ======================================================
>    WARNING: possible circular locking dependency detected
>    syzkaller #0 Not tainted
>    ------------------------------------------------------
>    btrfs-cleaner/8725 is trying to acquire lock:
>    ffff0000d6826a48 (&delayed_node->mutex){+.+.}-{4:4}, at: __btrfs_release_delayed_node+0xa0/0x9b0 fs/btrfs/delayed-inode.c:290
> 
>    but task is already holding lock:
>    ffff0000dbeba878 (btrfs-tree-00){++++}-{4:4}, at: btrfs_tree_read_lock_nested+0x44/0x2ec fs/btrfs/locking.c:145
> 
>    which lock already depends on the new lock.
> 
>    the existing dependency chain (in reverse order) is:
> 
>    -> #1 (btrfs-tree-00){++++}-{4:4}:
>           __lock_release kernel/locking/lockdep.c:5574 [inline]
>           lock_release+0x198/0x39c kernel/locking/lockdep.c:5889
>           up_read+0x24/0x3c kernel/locking/rwsem.c:1632
>           btrfs_tree_read_unlock+0xdc/0x298 fs/btrfs/locking.c:169
>           btrfs_tree_unlock_rw fs/btrfs/locking.h:218 [inline]
>           btrfs_search_slot+0xa6c/0x223c fs/btrfs/ctree.c:2133
>           btrfs_lookup_inode+0xd8/0x38c fs/btrfs/inode-item.c:395
>           __btrfs_update_delayed_inode+0x124/0xed0 fs/btrfs/delayed-inode.c:1032
>           btrfs_update_delayed_inode fs/btrfs/delayed-inode.c:1118 [inline]
>           __btrfs_commit_inode_delayed_items+0x15f8/0x1748 fs/btrfs/delayed-inode.c:1141
>           __btrfs_run_delayed_items+0x1ac/0x514 fs/btrfs/delayed-inode.c:1176
>           btrfs_run_delayed_items_nr+0x28/0x38 fs/btrfs/delayed-inode.c:1219
>           flush_space+0x26c/0xb68 fs/btrfs/space-info.c:828
>           do_async_reclaim_metadata_space+0x110/0x364 fs/btrfs/space-info.c:1158
>           btrfs_async_reclaim_metadata_space+0x90/0xd8 fs/btrfs/space-info.c:1226
>           process_one_work+0x7e8/0x155c kernel/workqueue.c:3263
>           process_scheduled_works kernel/workqueue.c:3346 [inline]
>           worker_thread+0x958/0xed8 kernel/workqueue.c:3427
>           kthread+0x5fc/0x75c kernel/kthread.c:463
>           ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
> 
>    -> #0 (&delayed_node->mutex){+.+.}-{4:4}:
>           check_prev_add kernel/locking/lockdep.c:3165 [inline]
>           check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>           validate_chain kernel/locking/lockdep.c:3908 [inline]
>           __lock_acquire+0x1774/0x30a4 kernel/locking/lockdep.c:5237
>           lock_acquire+0x14c/0x2e0 kernel/locking/lockdep.c:5868
>           __mutex_lock_common+0x1d0/0x2678 kernel/locking/mutex.c:598
>           __mutex_lock kernel/locking/mutex.c:760 [inline]
>           mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:812
>           __btrfs_release_delayed_node+0xa0/0x9b0 fs/btrfs/delayed-inode.c:290
>           btrfs_release_delayed_node fs/btrfs/delayed-inode.c:315 [inline]
>           btrfs_remove_delayed_node+0x68/0x84 fs/btrfs/delayed-inode.c:1326
>           btrfs_evict_inode+0x578/0xe28 fs/btrfs/inode.c:5587
>           evict+0x414/0x928 fs/inode.c:810
>           iput_final fs/inode.c:1914 [inline]
>           iput+0x95c/0xad4 fs/inode.c:1966
>           iget_failed+0xec/0x134 fs/bad_inode.c:248
>           btrfs_read_locked_inode+0xe1c/0x1234 fs/btrfs/inode.c:4101
>           btrfs_iget+0x1b0/0x264 fs/btrfs/inode.c:5837
>           btrfs_run_defrag_inode fs/btrfs/defrag.c:237 [inline]
>           btrfs_run_defrag_inodes+0x520/0xdc4 fs/btrfs/defrag.c:309
>           cleaner_kthread+0x21c/0x418 fs/btrfs/disk-io.c:1516
>           kthread+0x5fc/0x75c kernel/kthread.c:463
>           ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
> 
>    other info that might help us debug this:
> 
>     Possible unsafe locking scenario:
> 
>           CPU0                    CPU1
>           ----                    ----
>      rlock(btrfs-tree-00);
>                                   lock(&delayed_node->mutex);
>                                   lock(btrfs-tree-00);
>      lock(&delayed_node->mutex);
> 
>     *** DEADLOCK ***
> 
>    1 lock held by btrfs-cleaner/8725:
>     #0: ffff0000dbeba878 (btrfs-tree-00){++++}-{4:4}, at: btrfs_tree_read_lock_nested+0x44/0x2ec fs/btrfs/locking.c:145
> 
>    stack backtrace:
>    CPU: 0 UID: 0 PID: 8725 Comm: btrfs-cleaner Not tainted syzkaller #0 PREEMPT
>    Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
>    Call trace:
>     show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
>     __dump_stack+0x30/0x40 lib/dump_stack.c:94
>     dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
>     dump_stack+0x1c/0x28 lib/dump_stack.c:129
>     print_circular_bug+0x324/0x32c kernel/locking/lockdep.c:2043
>     check_noncircular+0x154/0x174 kernel/locking/lockdep.c:2175
>     check_prev_add kernel/locking/lockdep.c:3165 [inline]
>     check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>     validate_chain kernel/locking/lockdep.c:3908 [inline]
>     __lock_acquire+0x1774/0x30a4 kernel/locking/lockdep.c:5237
>     lock_acquire+0x14c/0x2e0 kernel/locking/lockdep.c:5868
>     __mutex_lock_common+0x1d0/0x2678 kernel/locking/mutex.c:598
>     __mutex_lock kernel/locking/mutex.c:760 [inline]
>     mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:812
>     __btrfs_release_delayed_node+0xa0/0x9b0 fs/btrfs/delayed-inode.c:290
>     btrfs_release_delayed_node fs/btrfs/delayed-inode.c:315 [inline]
>     btrfs_remove_delayed_node+0x68/0x84 fs/btrfs/delayed-inode.c:1326
>     btrfs_evict_inode+0x578/0xe28 fs/btrfs/inode.c:5587
>     evict+0x414/0x928 fs/inode.c:810
>     iput_final fs/inode.c:1914 [inline]
>     iput+0x95c/0xad4 fs/inode.c:1966
>     iget_failed+0xec/0x134 fs/bad_inode.c:248
>     btrfs_read_locked_inode+0xe1c/0x1234 fs/btrfs/inode.c:4101
>     btrfs_iget+0x1b0/0x264 fs/btrfs/inode.c:5837
>     btrfs_run_defrag_inode fs/btrfs/defrag.c:237 [inline]
>     btrfs_run_defrag_inodes+0x520/0xdc4 fs/btrfs/defrag.c:309
>     cleaner_kthread+0x21c/0x418 fs/btrfs/disk-io.c:1516
>     kthread+0x5fc/0x75c kernel/kthread.c:463
>     ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
> 
> Fix this by releasing the path before calling iget_failed().
> 
> Reported-by: syzbot+c1c6edb02bea1da754d8@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/694530c2.a70a0220.207337.010d.GAE@google.com/
> Fixes: 69673992b1ae ("btrfs: push cleanup into btrfs_read_locked_inode()")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/inode.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index cf452eaf0672..247b373bf5cf 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c

The function has an "on failure" note about cleaning up the inode;
might be worthwhile to include "and release the path" but otoh it's safe
to call multiple times and you added a comment inline, so I think it's
fine not to.

> @@ -4214,6 +4214,15 @@ static int btrfs_read_locked_inode(struct btrfs_inode *inode, struct btrfs_path
>  
>  	return 0;
>  out:
> +	/*
> +	 * We may have a read locked leaf and iget_failed() triggers inode
> +	 * eviction which needs to release the delayed inode and that needs
> +	 * to lock the delayed inode's mutex. This can cause a ABBA deadlock
> +	 * with a task running delayed items, as that require first locking
> +	 * the delayed inode's mutex and then modifying its subvolume btree.
> +	 * So release the path before iget_failed().
> +	 */
> +	btrfs_release_path(path);
>  	iget_failed(vfs_inode);
>  	return ret;
>  }
> -- 
> 2.47.2
> 

