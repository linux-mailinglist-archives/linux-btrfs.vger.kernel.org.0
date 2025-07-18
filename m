Return-Path: <linux-btrfs+bounces-15562-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E13B0AC23
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Jul 2025 00:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB36583950
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 22:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FCD221FB8;
	Fri, 18 Jul 2025 22:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="CkUR/Htk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B+AuXBfM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F2717CA17
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752877359; cv=none; b=gmIgt05jIevOQeANF2lNV/3eSU5lT9+ZJa2hgqB0+5RoxodhdpSPK5BautN878LZ+nDdguGh3Yglvi5sZwbSdtYJAAlHrei4FqnK6kqm5EP2Ovu1flh18D/378VmM/zD0v5XmCiu3XVivBKF96tQs1s3ALcJ+asEOkNRLyjrmlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752877359; c=relaxed/simple;
	bh=vqNnYgDmAAb6VcmAW3+XGTtgAn6FkgP8UzccTdKO68U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaNfRHYoKMm53vcJmv54gazVIysrKw/wWJ0OIZ2fRISmHseL1Mh/Hv7IaVEzeYz1sgH0FPFlCAjLiLUVCSVutC/vc2ZHOvQfJtbJlaoBi0Mq2j6m9TUspE/shHszwen89NRVjUHADvgTvxW0U4LoToTZCfL68kE7cF3koeqKQeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=CkUR/Htk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B+AuXBfM; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 5428E1D00035;
	Fri, 18 Jul 2025 18:22:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 18 Jul 2025 18:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1752877356;
	 x=1752963756; bh=8QqQ1ZtjhPXcPZx8CkC0NlAWq7SnUs4plfEbQABEGpA=; b=
	CkUR/HtkTG7CZBlkfQmUWGKeIUF+vK4FkWdCeP7/Ce5lI08yzqJjpQN4WvyWbD94
	0arOIj5YKzYC8gM1QwVAF4IYm/sjgyFDxc5VnK03T90v5oA6kRWPKMJBziw4Icvn
	EhmTc7GvI6/q4p//RzCFMUGG/hrPEb69P5rcy1OCFVpRd47MVYGScYlEYdFdFTt/
	+zmXhhQBe35svEQAPyaxf4Hd/39DCoQ0O2Zh7dmytj8kfYqkn3GFI9EhSTTO4hqC
	vjEDPipX+ZGwzs1x562yG1+rl2y8jgi0HnXF0B86LjnPf3r4NpakKOULCNdbJYOt
	yCr5blUYS1iyPOgU/kFXXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752877356; x=
	1752963756; bh=8QqQ1ZtjhPXcPZx8CkC0NlAWq7SnUs4plfEbQABEGpA=; b=B
	+AuXBfMQfwHzae1h6wot6FWcucnXWQZIOVtCaYB7SaHq75xY7WbmG6PH1wY/j1Rn
	QR60b5123EJVvPtHUBT5pmJ8zqlfVxGA5uI8AosYkOmoTr2T0+lVdCLUrgbnLyw3
	DrMsgu2njD76zMUm9/vv+hIDTxdxYY3DyeisSHubAdAiawioQA2y8XKKNs9he7Ue
	duif0UbHsGkoZ8hyb40O7V/3L6n9t493d/qnBLjTnuIR3bEJplGz5O1fsAWURcpr
	3INKyRcuuqFCw5qd9Vb4A059H3ywXGK98wNtRqbp3QTzqQhZ66BWQwS2IgpmPg7Q
	7GD1fp4odGQOMtvCDdLIw==
X-ME-Sender: <xms:K8l6aMg-LE_S81sakasAaug0E7YM5l0Kx8Aj4y9iUpptbWDcPlLTyQ>
    <xme:K8l6aPl4iDSgDwK5bo8jQtHdkNgReBLT46aGXW5I07EAog-NiXNiJzcl0PIsSxPxY
    10MnVdB6VVDoTBtYHA>
X-ME-Received: <xmr:K8l6aApGd0dlwS-8HO8kJJEm9wZABGVCXo6AIb-F265zjpecu63npkQPuATgSrdwNVV3A6BnY_pzVCaOY1rCgnKGHf0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudelhfdthfetuddvtefhfedtiedtteehvddtkedvle
    dtvdevgedtuedutdeitdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehquhifvghnrhhuohdrsghtrhhfshesghhm
    gidrtghomhdprhgtphhtthhopehlohgvmhhrrgdruggvvhesghhmrghilhdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:K8l6aAEEL4HWX6wWTDWTiQGkVFn0i9_QhyvwBYaXPsoAWir3_x649A>
    <xmx:K8l6aEzoHxxa34F5GTQunnoNw3-uiWnXOxCnmnwimrvKUeI-iDNLiA>
    <xmx:K8l6aNpDRTpNXmOWeDBAsZ6CyyVJRcpvvkYpHyXADX0TrMFuOWY_MQ>
    <xmx:K8l6aGimmL7O3htZhvRoWZWJA_7hsVkrrmLe8rz_3IrabLV_ZSAbqg>
    <xmx:LMl6aL_o_9RoPCLcr64OqCDxenXeYPvxBoKuA-uqtcB0Tn8wX23tzpjD>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 18:22:35 -0400 (EDT)
Date: Fri, 18 Jul 2025 15:24:05 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix subpage deadlock
Message-ID: <20250718222405.GA4169427@zen.localdomain>
References: <52e3db9d6f775370d963eb5179e3cbfa1ace5e04.1752795616.git.loemra.dev@gmail.com>
 <4b717bb0-d421-43e1-b722-1bf56a611df5@gmx.com>
 <rk53fmeujogdqpwxh5zhrr4p62bd7io2pvxyuxn3w7eo57ygd6@nfb4wxhrorgw>
 <20250718183706.GA4097590@zen.localdomain>
 <0ae559d6-ba95-489c-96fc-feca35a83f9a@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ae559d6-ba95-489c-96fc-feca35a83f9a@gmx.com>

On Sat, Jul 19, 2025 at 07:06:45AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/7/19 04:07, Boris Burkov 写道:
> > On Fri, Jul 18, 2025 at 10:40:28AM -0700, Leo Martins wrote:
> > > On Fri 18 Jul 10:18, Qu Wenruo wrote:
> > > > 
> > > > 
> > > > 在 2025/7/18 09:14, Leo Martins 写道:
> > > > > There is a deadlock happening in `try_release_subpage_extent_buffer`
> > > > > because the irq-safe xarray spin lock `fs_info->buffer_tree` is being
> > > > > acquired before the irq-unsafe `eb->refs_lock`.
> > > > > 
> > > > > This leads to the potential race:
> > > > > 
> > > > > ```
> > > > > // T1					// T2
> > > > > xa_lock_irq(&fs_info->buffer_tree)
> > > > > 					spin_lock(&eb->refs_lock)
> > > > > 					// interrupt
> > > > > 					xa_lock_irq(&fs_info->buffer_tree)
> > > > > spin_lock(&eb->refs_lock)
> > > > > ```
> > > > > 
> > > > 
> > > > If it's a lockdep warning, mind to provide the full calltrace?
> > > > 
> > > 
> > >             =====================================================
> > >             WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
> > >             6.16.0-0_fbk701_debug_rc0_123_g4c06e63b9203 #1 Tainted: G            E    N
> > >             -----------------------------------------------------
> > >             kswapd0/66 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> > >             ffff000011ffd600 (&eb->refs_lock){+.+.}-{3:3}, at: try_release_extent_buffer+0x18c/0x560
> > > and this task is already holding:
> > >             ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at: try_release_extent_buffer+0x13c/0x560
> > >             which would create a new lock dependency:
> > >              (&buffer_xa_class){-.-.}-{3:3} -> (&eb->refs_lock){+.+.}-{3:3}
> > > but this new dependency connects a HARDIRQ-irq-safe lock:
> > >              (&buffer_xa_class){-.-.}-{3:3}
> > > ... which became HARDIRQ-irq-safe at:
> > >               lock_acquire+0x178/0x358
> > >               _raw_spin_lock_irqsave+0x60/0x88
> > >               buffer_tree_clear_mark+0xc4/0x160
> > >               end_bbio_meta_write+0x238/0x398
> > >               btrfs_bio_end_io+0x1f8/0x330
> > >               btrfs_orig_write_end_io+0x1c4/0x2c0
> > >               bio_endio+0x63c/0x678
> > >               blk_update_request+0x1c4/0xa00
> > >               blk_mq_end_request+0x54/0x88
> > >               virtblk_request_done+0x124/0x1d0
> > >               blk_mq_complete_request+0x84/0xa0
> > >               virtblk_done+0x130/0x238
> > >               vring_interrupt+0x130/0x288
> > >               __handle_irq_event_percpu+0x1e8/0x708
> > >               handle_irq_event+0x98/0x1b0
> > >               handle_fasteoi_irq+0x264/0x7c0
> > >               generic_handle_domain_irq+0xa4/0x108
> > >               gic_handle_irq+0x7c/0x1a0
> > >               do_interrupt_handler+0xe4/0x148
> > >               el1_interrupt+0x30/0x50
> > >               el1h_64_irq_handler+0x14/0x20
> > >               el1h_64_irq+0x6c/0x70
> > >               _raw_spin_unlock_irq+0x38/0x70
> > >               __run_timer_base+0xdc/0x5e0
> > >               run_timer_softirq+0xa0/0x138
> > >               handle_softirqs.llvm.13542289750107964195+0x32c/0xbd0
> > >               ____do_softirq.llvm.17674514681856217165+0x18/0x28
> > >               call_on_irq_stack+0x24/0x30
> > >               __irq_exit_rcu+0x164/0x430
> > >               irq_exit_rcu+0x18/0x88
> > >               el1_interrupt+0x34/0x50
> > >               el1h_64_irq_handler+0x14/0x20
> > >               el1h_64_irq+0x6c/0x70
> > >               arch_local_irq_enable+0x4/0x8
> > >               do_idle+0x1a0/0x3b8
> > >               cpu_startup_entry+0x60/0x80
> > >               rest_init+0x204/0x228
> > >               start_kernel+0x394/0x3f0
> > >               __primary_switched+0x8c/0x8958
> > > to a HARDIRQ-irq-unsafe lock:
> > >              (&eb->refs_lock){+.+.}-{3:3}
> > > ... which became HARDIRQ-irq-unsafe at:
> > >             ...
> > >               lock_acquire+0x178/0x358
> > >               _raw_spin_lock+0x4c/0x68
> > >               free_extent_buffer_stale+0x2c/0x170
> > >               btrfs_read_sys_array+0x1b0/0x338
> > >               open_ctree+0xeb0/0x1df8
> > >               btrfs_get_tree+0xb60/0x1110
> > >               vfs_get_tree+0x8c/0x250
> > >               fc_mount+0x20/0x98
> > >               btrfs_get_tree+0x4a4/0x1110
> > >               vfs_get_tree+0x8c/0x250
> > >               do_new_mount+0x1e0/0x6c0
> > >               path_mount+0x4ec/0xa58
> > >               __arm64_sys_mount+0x370/0x490
> > >               invoke_syscall+0x6c/0x208
> > >               el0_svc_common+0x14c/0x1b8
> > >               do_el0_svc+0x4c/0x60
> > >               el0_svc+0x4c/0x160
> > >               el0t_64_sync_handler+0x70/0x100
> > >               el0t_64_sync+0x168/0x170
> > > other info that might help us debug this:
> > >              Possible interrupt unsafe locking scenario:
> > >                    CPU0                    CPU1
> > >                    ----                    ----
> > >               lock(&eb->refs_lock);
> > >                                            local_irq_disable();
> > >                                            lock(&buffer_xa_class);
> > >                                            lock(&eb->refs_lock);
> > >               <Interrupt>
> > >                 lock(&buffer_xa_class);
> > >   *** DEADLOCK ***
> > >             2 locks held by kswapd0/66:
> > >              #0: ffff800085506e40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xe8/0xe50
> > >              #1: ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at: try_release_extent_buffer+0x13c/0x560
> [...]
> 
> Thanks a lot for the call trace.
> 
> Please add the above part into the commit message for the next update.
> (The dependency part is too length and can be skipped)
> 
> > > 
> > > > I'm wondering at which exact interruption path that we will try to acquire
> > > > the buffer_tree xa lock.
> > > > 
> > > > Since the read path is always happening inside a workqueue, it won't cause
> > > > xa_lock_irq() under interruption context.
> > > > 
> > > > For the write path it's possible through end_bbio_meta_write() ->
> > > > buffer_tree_clear_mark().
> > > > 
> > > > But remember if there is an extent buffer under writeback, the whole folio
> > > > will have writeback flag, thus the btree_release_folio() won't even try to
> > > > release the folio.
> > > > 
> > > 
> > > Interesting, that makes sense. So this deadlock is impossible to hit?
> 
> No, just as Boris explained, it's still possible. I just want to be sure
> that I'm not missing anything critical.
> 
> And it turns out that indeed there is a small window here.
> 
> > > What do you think about this patch? Should I pivot and try and figure
> > > out how to express to lockdep that this deadlock is impossible?
> 
> I think we still need to address the lockdep wanring.
> 
> > > 
> > 
> > I just looked at that codepath and I don't think that the writeback flag
> > is actually protecting us.
> > 
> > the relevant code in end_bbio_meta_write() running in irq context is:
> > 
> > 	bio_for_each_folio_all(fi, &bbio->bio) {
> > 		btrfs_meta_folio_clear_writeback(fi.folio, eb);
> > 	}
> > 
> > 	buffer_tree_clear_mark(eb, PAGECACHE_TAG_WRITEBACK);
> > 
> > So we will clear writeback on the folio then take the xarray spinlock.
> > So I believe the following interleaving is possible in practice, not
> > just in lockdep land:
> > 
> >     T1 (random eb->refs user)                                 T2 (release folio)
> > 
> >          spin_lock(&eb->refs_lock);
> >          // interrupt
> >          end_bbio_meta_write()
> >            btrfs_meta_folio_clear_writeback()
> >                                                          btree_release_folio()
> >                                                            folio_test_writeback() //false
> >                                                            try_release_extent_buffer()
> >                                                              try_release_subpage_extent_buffer()
> >                                                                xa_lock_irq(&fs_info->buffer_tree)
> >                                                                spin_lock(&eb->refs_lock); // blocked; held by T1
> >            buffer_tree_clear_mark()
> >              xas_lock_irqsave() // blocked; held by T2
> > 
> 
> Thanks a lot, this is indeed a window that can lead to the problem.
> 
> > 
> > And even if I missed something in that analysis and the writeback flag
> > does save us, is there a way we can tell lockdep that this is in fact a
> > safe locking relationship? "Theoretically", it's wrong, even if some
> > other synchronization saves us..
> 
> I don't think it's theoretical only, since the lockdep is a runtime
> detection tool, if there is something really preventing it from happening,
> then it should not report this call site at all.

I don't think that's necessarily true. IIRC, lockdep globally tracks the
unique orderings of locks it has seen and reports violations of its
theoretical invariants, it doesn't have to have seen a sufficiently
concurrent or deadlock-y state.

For example if we have 3 locks A, B, C and code that does

lock(A); lock(B); lock(C); unlock(C); unlock(B); unlock(A);
and
lock(A); lock(C); lock(B); unlock(B); unlock(C); unlock(A);

then I think a deadlock is impossible, but lockdep will complain that
B and C both depend on each other? And even if lockdep is clever and 
detect that A protects that particular violation, then imagine if A is a
type of "I rolled my own condvar" synchronization that lockdep doesn't
know about. It can be theoretically impossible to have the deadlock but
in a way lockdep isn't sophisticated enough to understand.

> 
> [...]
> > > > > @@ -4332,15 +4333,18 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
> > > > >    	unsigned long end = index + (PAGE_SIZE >> fs_info->nodesize_bits) - 1;
> > > > >    	int ret;
> > > > > -	xa_lock_irq(&fs_info->buffer_tree);
> > > > > +	rcu_read_lock();
> 
> According to the docs, xa_for_each_range() is already taking and releasing
> RCU lock by itself, thus the extra RCU lock may not be necessary at all.
> 
> Maybe you can try with the xa_lock_irq() removed for this call site?
> 

I believe it is important that we are doing rcu_read_unlock() after we
take eb->refs_lock. Otherwise, I think that a different thread further
along in release_extent_buffer() can take eb->refs_lock, decrement the
ref count to 0, and delete the eb in call_rcu(), because we aren't
protected by a grace period, then we get a null ptr exception trying to
take eb->refs_lock.

This is all being maximally paranoid and assuming we can run
try_release_subpage_extent_buffer() concurrently with another thread
running release_extent_buffer(), though, which I haven't proven to
myself one way or the other. I think it seems likely enough to be
careful with.

> 
> Another thing is, since the problem is only possible as metadata write endio
> is happening in an IRQ context, the other solution is to delay the metadata
> endio to happen in a workqueue.

I think this is a nice idea, getting rid of work in an interrupt context
if it isn't strictly necessary seems like a nice improvement. We already
do this with ordered_extents in end_bbio_data_write(), so I don't see
why it would be impossible for end_bbio_meta_write().

> 
> By that we can even replace the usage of xa_lock_irq() with regular
> xa_lock(), but that may be a little huge change, thus such change should be
> only the last-resort method.

Agreed that it is a much bigger change. I think we agree we should get
some kind of fix in now and then refactor further if we think it's
helpful?

Thanks,
Boris

> 
> Thanks,
> Qu

