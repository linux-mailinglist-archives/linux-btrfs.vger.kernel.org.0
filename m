Return-Path: <linux-btrfs+bounces-14502-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD07ACF5AE
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 19:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D018B7A6AA9
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 17:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A49279337;
	Thu,  5 Jun 2025 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="FAtVcSe+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PALrIykL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A531DFF8
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749145808; cv=none; b=qzKyKy3P3YoRzTE5vFBOKl2YxzcdJHjjUFmAUNO2ckjwdmVsL7KV3v75yWX0OWlnjydJcmMbo9XTECBiw4WyoLghPQlIAteY7bav5uMOMxjuiWhi6TTaGLlTspuMzwoiLhRYIV4ztO0PuclwCGc8tbxGlAnchJDxsnHpS0yFU24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749145808; c=relaxed/simple;
	bh=UjIw+WtuAXHRiGxRgfMViNhynQBH6UVBfqw3KoQQBa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYsfaIPfkJ0D2oLbhZWMwa0Ci/ejR5VuhHtBO6b0ppKM4wsAuDt9ioTLiYhUfFOMKkxeTrNNPLxgFlFmr5qPZFmyJ8B+P3gSlL4L6cl2eOgjgPvEBcVghXlQDrvhQQcjco4OuqoXVT2GJlobzJKuK6bXBxcdPX1V04agNMFCBCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=FAtVcSe+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PALrIykL; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6FC5E114013F;
	Thu,  5 Jun 2025 13:50:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Jun 2025 13:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1749145804; x=1749232204; bh=gv6EGpcoZl
	DKV2IAlyIDEVlM7MbAKQxADuQzpM5Pa34=; b=FAtVcSe+g4XiH+TV2qgSjd2jLg
	Kt96yiCUPtis7Yyjlgr9cqK8S4kQKVYCX4OwUKZg9XXt67+S6Lp6LxaHiUWm4S6B
	M3TChuQUv6vhX6szH3qsULZzJ30r/wVGS1V1/42UZCuAFNJK/8DYn4TO22Qsw5Z2
	yqPFQJl66d4W0lYNz5h6J3aMtSNCJtfbM5yIARcgddJcsQM06Bh7dHyrKrbtbfk6
	huf4hFzs6hBWZ4l+IXa8/onsIIKQHNRBl9cEIkdUHwVK15dTrUqik+U6GY+cUGOn
	h5h8GgLSbZo6WeSeF2mjVrfx/kXglOqX+y+bUn/FHyBPBRcsGqv9GbSFZD2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749145804; x=1749232204; bh=gv6EGpcoZlDKV2IAlyIDEVlM7MbAKQxADuQ
	zpM5Pa34=; b=PALrIykL4z6WfPj9vbXMOC3wDtWUg3iyXO8sRRGMtcUE7xqLjRH
	Zt+uh5p3bXyNX7F28uPpGx58AeiF2+YWkButlPcdsplb+oHkUghLBJMaXU8TSyF0
	ebzbgEu8fdWJAF1vCEhWhDu3yjEBtMSQHjkx9y1ckoCOu3WPLPMpaD5UKbvH+NF2
	mWq7ycUr6QUywIdSSgGhjYHuBxfbVo1E8AyBjsAg91bb5nYmVjhcRaf0DJ6+aTbx
	qrr74Y24yBQRn35L6ODrGG3dbulFitslvFrMvbyBqaclfC4n53JHy0xYf3EeAsve
	Cui00PiHAvOBrWzzv0AlhSMk98y9J1lbHEA==
X-ME-Sender: <xms:zNhBaBGBo54b14sqSwLlrtEmdBj1cMNT4BZTTjWi-7l_0LbTOTP20Q>
    <xme:zNhBaGVWNXOls5Xc06y-dyahxHuvX5DpxhGY2DCdHPQfXsJacJeOKP2AjtH3P5g1X
    FGuJidkcCf89lOnxdY>
X-ME-Received: <xmr:zNhBaDLf0CsZD5tjffEVgQvx4I7TlgTV2FvxYPAn_Zr_gZ4yS1v-ACWh-WU_dktJpFGECeqe1_X8-8B4MqnCYQ_e3eE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcu
    oegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephedthfevgffhtdevgf
    fhlefhgfeuueegtdevudeiheeiheetleeghedvfeegfeegnecuffhomhgrihhnpehkvghr
    nhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zNhBaHFgcbPQ9AuppscddEoq-zgQCW0AHrXzxwM2FxIWTMzRhg_28w>
    <xmx:zNhBaHVaW2ZcJVRnHiI8USdxuCBiXQyrcAo6o4k5-xbOgopjdjBX0A>
    <xmx:zNhBaCM-7QIK1EvHbYWRfioIhhvi6HabJxGAvToNbLPWQfhVxSEydQ>
    <xmx:zNhBaG14uHnFEjWtN6ZincYeQXtvPKqgaqOZb8kfkPxGnqHUqgcbVQ>
    <xmx:zNhBaBicU9tDJa7wnUyDL0ecZUL5EAwXYrfJi-RI2ETJWRx81osmPoKA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 13:50:03 -0400 (EDT)
Date: Thu, 5 Jun 2025 10:49:57 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix race between async reclaim worker and
 close_ctree()
Message-ID: <20250605174957.GB3475402@zen.localdomain>
References: <59c8f858b893a9d37b76d4b3bdf985c904b4c8fe.1749052938.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59c8f858b893a9d37b76d4b3bdf985c904b4c8fe.1749052938.git.fdmanana@suse.com>

On Wed, Jun 04, 2025 at 05:18:11PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Syzbot reported an assertion failure due to an attempt to add a delayed
> iput after we have set BTRFS_FS_STATE_NO_DELAYED_IPUT in the fs_info
> state:
> 
>    WARNING: CPU: 0 PID: 65 at fs/btrfs/inode.c:3420 btrfs_add_delayed_iput+0x2f8/0x370 fs/btrfs/inode.c:3420
>    Modules linked in:
>    CPU: 0 UID: 0 PID: 65 Comm: kworker/u8:4 Not tainted 6.15.0-next-20250530-syzkaller #0 PREEMPT(full)
>    Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
>    Workqueue: btrfs-endio-write btrfs_work_helper
>    RIP: 0010:btrfs_add_delayed_iput+0x2f8/0x370 fs/btrfs/inode.c:3420
>    Code: 4e ad 5d (...)
>    RSP: 0018:ffffc9000213f780 EFLAGS: 00010293
>    RAX: ffffffff83c635b7 RBX: ffff888058920000 RCX: ffff88801c769e00
>    RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000000000000
>    RBP: 0000000000000001 R08: ffff888058921b67 R09: 1ffff1100b12436c
>    R10: dffffc0000000000 R11: ffffed100b12436d R12: 0000000000000001
>    R13: dffffc0000000000 R14: ffff88807d748000 R15: 0000000000000100
>    FS:  0000000000000000(0000) GS:ffff888125c53000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 00002000000bd038 CR3: 000000006a142000 CR4: 00000000003526f0
>    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    Call Trace:
>     <TASK>
>     btrfs_put_ordered_extent+0x19f/0x470 fs/btrfs/ordered-data.c:635
>     btrfs_finish_one_ordered+0x11d8/0x1b10 fs/btrfs/inode.c:3312
>     btrfs_work_helper+0x399/0xc20 fs/btrfs/async-thread.c:312
>     process_one_work kernel/workqueue.c:3238 [inline]
>     process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
>     worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
>     kthread+0x70e/0x8a0 kernel/kthread.c:464
>     ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>     </TASK>
> 
> This can happen due to a race with the async reclaim worker like this:
> 
> 1) The async metadata reclaim worker enters shrink_delalloc(), which calls
>    btrfs_start_delalloc_roots() with an nr_pages argument that has a value
>    less than LONG_MAX, and that in turn enters start_delalloc_inodes(),
>    which sets the local variable 'full_flush' to false because
>    wbc->nr_to_write is less than LONG_MAX;
> 
> 2) There it finds inode X in a root's delalloc list, grabs a reference for
>    inode X (with igrab()), and triggers writeback for it with
>    filemap_fdatawrite_wbc(), which creates an ordered extent for inode X;
> 
> 3) The unmount sequence starts from another task, we enter close_ctree()
>    and we flush the workqueue fs_info->endio_write_workers, which waits
>    for the ordered extent for inode X to complete and when dropping the
>    last reference of the ordered extent, with btrfs_put_ordered_extent(),
>    when we call btrfs_add_delayed_iput() we don't add the inode to the
>    list of delayed iputs because it has a refcount of 2, so we decrement
>    it to 1 and return;
> 
> 4) Shortly after at close_ctree() we call btrfs_run_delayed_iputs() which
>    runs all delayed iputs, and then we set BTRFS_FS_STATE_NO_DELAYED_IPUT
>    in the fs_info state;
> 
> 5) The async reclaim worker, after calling filemap_fdatawrite_wbc(), now
>    calls btrfs_add_delayed_iput() for inode X and there we trigger an
>    assertion failure since the fs_info state has the flag
>    BTRFS_FS_STATE_NO_DELAYED_IPUT set.
> 
> Fix this by setting BTRFS_FS_STATE_NO_DELAYED_IPUT only after we wait for
> the async reclaim workers to finish, after we call cancel_work_sync() for
> them at close_ctree(), and by running delayed iputs after wait for the
> reclaim workers to finish and before setting the bit.
> 
> This race was recently introduced by commit 19e60b2a95f5 ("btrfs: add
> extra warning if delayed iput is added when it's not allowed") and we
> didn't have any assertion failure, crash or inode leak in this described
> scenario because before that commit since btrfs_commit_super(), called
> later at close_ctree(), runs delayed iputs again, and there was no such
> assertion about BTRFS_FS_STATE_NO_DELAYED_IPUT at btrfs_add_delayed_iput()
> of course.

I found this paragraph really hard to read and confusing. Could you try
to reword it into a few simpler sentences? Maybe something like:

"This race was recently introduced by commit XXX. Without the new
validation at btrfs_add_delayed_iput(), this described scenario was safe
because close_ctree() later calls btrfs_commit_super(). That will run any
final delayed iputs added by reclaim workers in the window between the
btrfs_run_delayed_iputs() and the the reclaim workers being shut down."

I think just breaking up the sentences helps a bit.

> 
> Reported-by: syzbot+0ed30ad435bf6f5b7a42@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/6840481c.a00a0220.d4325.000c.GAE@google.com/T/#u
> Fixes: 19e60b2a95f5 ("btrfs: add extra warning if delayed iput is added when it's not allowed")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

A few small notes/questions, but LGTM, thanks.
Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/disk-io.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 3def93016963..84c8f9f19649 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4324,15 +4324,29 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
>  	btrfs_flush_workqueue(fs_info->endio_write_workers);
>  	/* Ordered extents for free space inodes. */
>  	btrfs_flush_workqueue(fs_info->endio_freespace_worker);
> +	/*
> +	 * Run delayed iputs in case an async reclaim worker is waiting for them
> +	 * to be run as mentioned above.
> +	 */

This comment was quite helpful as I initially wondered why keep both
calls. But it made me think and read the above comment as well. So thanks
for including it.

However, the comment you are referring to also says:

"This works because once we reach this point no one
can either create new ordered extents nor create delayed iputs
through some other means."

Which I think you have shown to be not true in this analysis/fix, as the
reclaim workers themselves are adding more delayed iputs after this
point.

>  	btrfs_run_delayed_iputs(fs_info);
> -	/* There should be no more workload to generate new delayed iputs. */
> -	set_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state);
>  
>  	cancel_work_sync(&fs_info->async_reclaim_work);
>  	cancel_work_sync(&fs_info->async_data_reclaim_work);
>  	cancel_work_sync(&fs_info->preempt_reclaim_work);
>  	cancel_work_sync(&fs_info->em_shrinker_work);
>  
> +	/*
> +	 * Run delayed iputs again because an async reclaim worker may have
> +	 * added new ones if it was flushing delalloc:
> +	 *
> +	 * shrink_delalloc() -> btrfs_start_delalloc_roots() ->
> +	 *    start_delalloc_inodes() -> btrfs_add_delayed_iput()
> +	 */
> +	btrfs_run_delayed_iputs(fs_info);

If btrfs_commit_super() will cleanup any stragglers as before, do we
actually need this btrfs_run_delayed_iputs()? I suppose it makes the
semantics of the BTRFS_FS_STATE_NO_DELAYED_IPUT bit more clear. OTOH,
all the bit really does (and is documented as doing) is block new
delayed iputs, which is valid at this point whether or not any
already exist.

> +
> +	/* There should be no more workload to generate new delayed iputs. */
> +	set_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state);
> +
>  	/* Cancel or finish ongoing discard work */
>  	btrfs_discard_cleanup(fs_info);
>  
> -- 
> 2.47.2
> 

