Return-Path: <linux-btrfs+bounces-15568-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C30B0ACB3
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Jul 2025 02:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA841C24BC8
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Jul 2025 00:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBF84A02;
	Sat, 19 Jul 2025 00:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Sv59TySW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jY4DMeY+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45423CE
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Jul 2025 00:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752883870; cv=none; b=QkpessnseHQ99fHd35PdMehgJCcKt2aGeZ+NYmNhjK/pNJq4FP4DGlSdMpmHDclYosGQmd5jCeeSn3zH5at4SwClsDpnbygbz75SfyS9eo94yXKxIoo3w9Hh7OBrCeRDEhmvr4TsVAuePxDK123yRWdOZ0yIsC/WYHBpkX0fTpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752883870; c=relaxed/simple;
	bh=XKrk3nQ8X9N+Q8NkdPiO6GYksyf1KGrB8DLDCebh4sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MS3BxqZSSu2jeJat2xlac2jlLwNXiEqs1TNf+p2UrVNN0ZZjmm5uX/nr+6HwFlCyonLBB/CNRVjb9+g3NZ5eEBlZyfeSkFI11ZQ8UKcPCL2adldGcFjuC/DCb8tPClgyeD9j41Q+qrvZCr5lZSdCmJG+OVRnezPKahG5DhZufHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Sv59TySW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jY4DMeY+; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id AE3341D0011D;
	Fri, 18 Jul 2025 20:11:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 18 Jul 2025 20:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1752883866; x=1752970266; bh=y7ssF802aA
	36g6YiVmVvuK/K2+5aO3HonySxM1Nn+qw=; b=Sv59TySW/H21MXr4AgMYVGYS6b
	kagHFGwFJWrggeTogniZN5k/kSbHrSM31pR2FJdZozpzU/8EOjQ/gpRWg9U+06O8
	KXz5MDqdIYDz1xQYDtiYjqfuPkH+oe6M9sIwZKrBIjNZrLPb0ycPWIyZ7EN3UbM/
	Nfg6r+LQJw4CdkdMj9tHf2Oo5DuW++/Qu5nGAywLJgaVOPUCgvT8SgsOY/9i4mZZ
	ShNmioVzJKvsmkocQpsUy0my/Vx9Zs5xbYLMLJWZAzQGRBtvuvp6owFBa8QjESw3
	2nxVS78MgF9Dld0/cenkXghUnDaSPpuJTY0EWJwQ08nlFh06VBQ7GaqgXb9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752883866; x=1752970266; bh=y7ssF802aA36g6YiVmVvuK/K2+5aO3HonyS
	xM1Nn+qw=; b=jY4DMeY+ZeFW/RHFv/n6lxgY1kHqNMpG8JtC93cfMoLUZXMkDf8
	q/zy2Cv9JJV3jSiSVgbwRdScZRFLfZJIQhxInJCDi8VwQqAHZQ/tKuiwbD2L6KMT
	p7rRKw0u0FpwSuAWkvGohMMApmFoJ6xEtI1/bNnyfQ6hcNt54L+SiKD4glqTiErw
	eR08VUk6eLR8qepFscvIdjcyyb8+gOKPiGLmm+vZXo7HexFcLLEszotOYKQMSSw+
	V+iCcgOrH+fWkiVgHsHp82J8ocU/anzDP+0OQRsDNgJjJN1zcLF1slmXQ9PO/0jB
	PlKqdQtJMaU0xGyUIncfC7/DAR8A7SSzFjA==
X-ME-Sender: <xms:muJ6aHfZ822AL1j8NRG7T57rgI1TZ7XYdDRsCoDZnyFM-nKGBza9Mg>
    <xme:muJ6aAeKZsZNsXgzfzF7-Q-quw7mLtft-hfE6W92bEpSIVtSRxEtHxFq1q_YVUFjj
    TfTN9OEGnkJd1zBK34>
X-ME-Received: <xmr:muJ6aJ-S6dKF4f3sacW21VdSJHzmkPEh7OG0MoXETIeXn8FE8cvlYr9xaY7f7Qy1SsDaeIYT9LyC-C18VNT4WsoSYjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigeekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeehtdfhvefghfdtvefghfelhffgueeugedtveduieehie
    ehteelgeehvdefgeefgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehlohgvmhhrrgdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqd
    gsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghl
    qdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:muJ6aEnDIx7rbjIC_q5_x71IDQBli6r4MOmkS-ewZp11Vra1RJnJxQ>
    <xmx:muJ6aD89i1YsQ_tRsFVVMm5sQtCNBhi7EM8LA8iJ1p4wgVPYfiPDmw>
    <xmx:muJ6aKm3NnhaV_tzyQs-yhxF7QpspxO_urudcyUIhGggV1SYK4ZEXg>
    <xmx:muJ6aI3JSJn8hZvk0rdIFAA_dVuLZN4kRr9T6m1z12kA04iD1Ldw-Q>
    <xmx:muJ6aCnzo14UKTUOq2eApDno85WdUY82YxKHHsjVvy1Wwhs4Fa1Nv2dr>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 20:11:05 -0400 (EDT)
Date: Fri, 18 Jul 2025 17:12:35 -0700
From: Boris Burkov <boris@bur.io>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: fix subpage deadlock
Message-ID: <20250719001235.GA87532@zen.localdomain>
References: <5df8399c15d9265fae8b069dc481ca077810a609.1752882493.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5df8399c15d9265fae8b069dc481ca077810a609.1752882493.git.loemra.dev@gmail.com>

On Fri, Jul 18, 2025 at 04:56:48PM -0700, Leo Martins wrote:
> There is a potential deadlock that can happen in
> try_release_subpage_extent_buffer because the irq-safe
> xarray spin lock fs_info->buffer_tree is being
> acquired before the irq-unsafe eb->refs_lock.
> 
> This leads to the potential race:
> 
> ```
> // T1                                   // T2
> xa_lock_irq(&fs_info->buffer_tree)
>                                         spin_lock(&eb->refs_lock)
>                                         // interrupt
>                                         xa_lock_irq(&fs_info->buffer_tree)
> spin_lock(&eb->refs_lock)
> ```
> 

I actually think this particular ordering of the race can't happen, due
to the writeback flag as Qu pointed out. We wouldn't be in T1 releasing
the eb if it was under writeback which would be necessary for T2 to get
interrupted and handle an endio. So I think it's a little misleading to
include this ordering in the commit, would you mind changing it to the
one from my email? Thanks! You can keep/omit the extra details I added
as you see fit.

> https://www.kernel.org/doc/Documentation/locking/lockdep-design.rst#:~:text=Multi%2Dlock%20dependency%20rules%3A

We usually include links with a Link: tag. Since I am asking for a v3
anyway, that doesn't hurt to change, too.

> 
> I believe that the spin lock can safely be replaced by an rcu_read_lock.
> The xa_for_each loop does not need the spin lock as it's already
> internally protected by the rcu_read_lock. The extent buffer
> is also protected by the rcu_read_lock so it won't be freed before we
> take the eb->refs_lock.

I think it wouldn't hurt to add "and check the ref count", or something.

> 
> The rcu_read_lock is taken and released every iteration, just like the
> spin lock, which means we're not protected against concurrent
> insertions into the xarray. This is fine because we rely on folio->private
> to detect if there are any eb's remaining in the folio.
> 
> There is already some precedence for this with find_extent_buffer_nolock,

precedent

> which loads an extent buffer from the xarray with only rcu_read_lock.
> 
> lockdep warning:
> 
>             =====================================================
>             WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
>             6.16.0-0_fbk701_debug_rc0_123_g4c06e63b9203 #1 Tainted: G            E    N
>             -----------------------------------------------------
>             kswapd0/66 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>             ffff000011ffd600 (&eb->refs_lock){+.+.}-{3:3}, at: try_release_extent_buffer+0x18c/0x560
> 
> and this task is already holding:
>             ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at: try_release_extent_buffer+0x13c/0x560
>             which would create a new lock dependency:
>              (&buffer_xa_class){-.-.}-{3:3} -> (&eb->refs_lock){+.+.}-{3:3}
> 
> but this new dependency connects a HARDIRQ-irq-safe lock:
>              (&buffer_xa_class){-.-.}-{3:3}
> 
> ... which became HARDIRQ-irq-safe at:
>               lock_acquire+0x178/0x358
>               _raw_spin_lock_irqsave+0x60/0x88
>               buffer_tree_clear_mark+0xc4/0x160
>               end_bbio_meta_write+0x238/0x398
>               btrfs_bio_end_io+0x1f8/0x330
>               btrfs_orig_write_end_io+0x1c4/0x2c0
>               bio_endio+0x63c/0x678
>               blk_update_request+0x1c4/0xa00
>               blk_mq_end_request+0x54/0x88
>               virtblk_request_done+0x124/0x1d0
>               blk_mq_complete_request+0x84/0xa0
>               virtblk_done+0x130/0x238
>               vring_interrupt+0x130/0x288
>               __handle_irq_event_percpu+0x1e8/0x708
>               handle_irq_event+0x98/0x1b0
>               handle_fasteoi_irq+0x264/0x7c0
>               generic_handle_domain_irq+0xa4/0x108
>               gic_handle_irq+0x7c/0x1a0
>               do_interrupt_handler+0xe4/0x148
>               el1_interrupt+0x30/0x50
>               el1h_64_irq_handler+0x14/0x20
>               el1h_64_irq+0x6c/0x70
>               _raw_spin_unlock_irq+0x38/0x70
>               __run_timer_base+0xdc/0x5e0
>               run_timer_softirq+0xa0/0x138
>               handle_softirqs.llvm.13542289750107964195+0x32c/0xbd0
>               ____do_softirq.llvm.17674514681856217165+0x18/0x28
>               call_on_irq_stack+0x24/0x30
>               __irq_exit_rcu+0x164/0x430
>               irq_exit_rcu+0x18/0x88
>               el1_interrupt+0x34/0x50
>               el1h_64_irq_handler+0x14/0x20
>               el1h_64_irq+0x6c/0x70
>               arch_local_irq_enable+0x4/0x8
>               do_idle+0x1a0/0x3b8
>               cpu_startup_entry+0x60/0x80
>               rest_init+0x204/0x228
>               start_kernel+0x394/0x3f0
>               __primary_switched+0x8c/0x8958
> 
> to a HARDIRQ-irq-unsafe lock:
>              (&eb->refs_lock){+.+.}-{3:3}
> 
> ... which became HARDIRQ-irq-unsafe at:
>             ...
>               lock_acquire+0x178/0x358
>               _raw_spin_lock+0x4c/0x68
>               free_extent_buffer_stale+0x2c/0x170
>               btrfs_read_sys_array+0x1b0/0x338
>               open_ctree+0xeb0/0x1df8
>               btrfs_get_tree+0xb60/0x1110
>               vfs_get_tree+0x8c/0x250
>               fc_mount+0x20/0x98
>               btrfs_get_tree+0x4a4/0x1110
>               vfs_get_tree+0x8c/0x250
>               do_new_mount+0x1e0/0x6c0
>               path_mount+0x4ec/0xa58
>               __arm64_sys_mount+0x370/0x490
>               invoke_syscall+0x6c/0x208
>               el0_svc_common+0x14c/0x1b8
>               do_el0_svc+0x4c/0x60
>               el0_svc+0x4c/0x160
>               el0t_64_sync_handler+0x70/0x100
>               el0t_64_sync+0x168/0x170
> 
> other info that might help us debug this:
>              Possible interrupt unsafe locking scenario:
>                    CPU0                    CPU1
>                    ----                    ----
>               lock(&eb->refs_lock);
>                                            local_irq_disable();
>                                            lock(&buffer_xa_class);
>                                            lock(&eb->refs_lock);
>               <Interrupt>
>                 lock(&buffer_xa_class);
> 
>   *** DEADLOCK ***
>             2 locks held by kswapd0/66:
>              #0: ffff800085506e40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xe8/0xe50
>              #1: ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at: try_release_extent_buffer+0x13c/0x560
> 
> Fixes: 19d7f65f032f ("btrfs: convert the buffer_radix to an xarray")
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>

If you send a V3 with the requested changes to the commit message, you
can add

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/extent_io.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6192e1f58860..060e509cfb18 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <linux/rcupdate.h>
>  #include <linux/bitops.h>
>  #include <linux/slab.h>
>  #include <linux/bio.h>
> @@ -4332,15 +4333,18 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
>  	unsigned long end = index + (PAGE_SIZE >> fs_info->nodesize_bits) - 1;
>  	int ret;
>  
> -	xa_lock_irq(&fs_info->buffer_tree);
> +	rcu_read_lock();
>  	xa_for_each_range(&fs_info->buffer_tree, index, eb, start, end) {
>  		/*
>  		 * The same as try_release_extent_buffer(), to ensure the eb
>  		 * won't disappear out from under us.
>  		 */
>  		spin_lock(&eb->refs_lock);
> +		rcu_read_unlock();
> +
>  		if (refcount_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
>  			spin_unlock(&eb->refs_lock);
> +			rcu_read_lock();
>  			continue;
>  		}
>  
> @@ -4359,11 +4363,10 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
>  		 * check the folio private at the end.  And
>  		 * release_extent_buffer() will release the refs_lock.
>  		 */
> -		xa_unlock_irq(&fs_info->buffer_tree);
>  		release_extent_buffer(eb);
> -		xa_lock_irq(&fs_info->buffer_tree);
> +		rcu_read_lock();
>  	}
> -	xa_unlock_irq(&fs_info->buffer_tree);
> +	rcu_read_unlock();
>  
>  	/*
>  	 * Finally to check if we have cleared folio private, as if we have
> @@ -4376,7 +4379,6 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
>  		ret = 0;
>  	spin_unlock(&folio->mapping->i_private_lock);
>  	return ret;
> -
>  }
>  
>  int try_release_extent_buffer(struct folio *folio)
> -- 
> 2.47.1
> 

