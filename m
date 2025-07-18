Return-Path: <linux-btrfs+bounces-15555-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21732B0AA2C
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 20:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF744AA660A
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 18:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0822E7F13;
	Fri, 18 Jul 2025 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="WQ6KMftf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lNxXqIt7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAACE148850
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863740; cv=none; b=oxPY3WIV7t+9kTOouWNFaFJK5xgMludVEyofJbDm1HAOU3Du+8wNMSLnIxfMdg5v5jjdcgeV0RXNavWcYnHiQusrK4yI4D7MVOMV4zR/8GqH7neqZKqw5GeRzMrREeLUbJ8z/60tp754XrZbyMgp2k6TrUdpXpwQsYyX67xy1KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863740; c=relaxed/simple;
	bh=7+PusT3KnHPM7ekoscwekU/cfoPF0BIK/gbInIaJAkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMqJZ7spRTZ8rXyxxlyal3b/bXLN4pZLGYqWjQVb6wmh2DDaCiRiK/57zsySH7ueo6BecYa6NDWiHesU67Pu8HM0Vyl6Ke8db+Rx8VHY28vN3RoJqpCAGMOP3XzNOOeaUhuiENsYTC2IBUnEAesfxjqgvvPEqMaZ8wiKQVdfaC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=WQ6KMftf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lNxXqIt7; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 008CA1D000B9;
	Fri, 18 Jul 2025 14:35:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 18 Jul 2025 14:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1752863736;
	 x=1752950136; bh=cKbLzH7C5BFIr/TOLt3zjfhTVZSxVffMYdt+dNVBAqg=; b=
	WQ6KMftf7D5FrSofBpeldkzCcZTU0sXdfv24edhM5oOa+uHn2AnZmFVvxi8cQjrj
	zPl+fh5ArN68XKhFI2IzPZhWQqEPfzfb5S5oCQ2hkfthCYUDgzVAJL10MBes9Fuh
	N5+Ocm6iRYiVtFb77UFFsxpev+qeOQ532szHIeTb9BgZr07fgX9QunquhZEGtTWs
	DkPAIR4QH/0FcCe/5iz/00mRT340vvApdKWemkyXXScSzLqacI5IswK09YMfTg2V
	oIgBhL/wZdubG6zmBAoJIDlCFF1UaZrwZ0ionpCYBqhcbWvMcSZkdBao2Qc6yt5P
	RGt9V8zTSzEkpNiGLsoa3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752863736; x=
	1752950136; bh=cKbLzH7C5BFIr/TOLt3zjfhTVZSxVffMYdt+dNVBAqg=; b=l
	NxXqIt71pgeicU/W6Y1HexqVRBYYoHLMw5DEv7lGVf7UTBSD+PrrKUj/MEG7Wop/
	jCYRhad7iDB9SPCcf2zFzhxso8881XkwbebVbBHzvVIyda9uD8+jWh2/aIERKs+t
	5ZWY3rh6Gvmke6Pd9XyhXDa4NZ+qjR8hyt2i7vPLtnXC2mJ51Ttmtov/58c2i5It
	WiB35G/ol6a8W+N4g8GQtysR9n6DgjGoLu9Odx3IuHrMoiqB0ynx2W/rpACcl57j
	Nty8aS8eeK5JvLis/nn5/8g+rnJ73EaMO3o+ERwoHWikGY8mdrzpNQWd5phtiSqX
	dbpi2hItdlNvF1GDtDfhg==
X-ME-Sender: <xms:-JN6aEvJIm69sICyduZYSq3tkZ1Xq2xiCpnyGEfgl5UFNtepx0uT4Q>
    <xme:-JN6aMAkty5W0LepK-7EiQCdf0I0eGv2e1cyZKKZUQbEtWU15Siqh08rfF8e1Xu2V
    YjpSQhvmev9yE4cj4o>
X-ME-Received: <xmr:-JN6aMUzH6nl0CC-dnDusewCH00eXun2_jdH_EM3d_EfuMHx_EDEXSm_N8NjdrU-6sXmAfhUAVgJDmz-pTiIhpKBLZU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhephefhudehgfekhedufedvtefgteelueeigfefhfefge
    ejkeefhefhgfekjefhvdehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheplhhovghmrhgrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepqhhufigvnh
    hruhhordgsthhrfhhssehgmhigrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhf
    shesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrg
    hmsehfsgdrtghomh
X-ME-Proxy: <xmx:-JN6aKA-qUfSu0daUKphIAE_CDa2O4HeH4I-U0_P4qiyRDQXn7v_-g>
    <xmx:-JN6aP-3aVtxtWlUrUKWzofQ6xUaRZ19gRz4iYJ6w_Jurd5_EIatYQ>
    <xmx:-JN6aBGFUTCCOH-HVDLOfGWEqdCmLqXoobWqibBVrSoPVKcq6m9_Pg>
    <xmx:-JN6aNPUG1UTU6a_enp6-jCF1LoCkKKaoCmVg9sxLah8YGSX88_AZg>
    <xmx:-JN6aPqCsdoASmNTC-5X_0Pm7hxYlFd0hIYJHvjHH5t-fC1jhOIC8W_2>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 14:35:36 -0400 (EDT)
Date: Fri, 18 Jul 2025 11:37:06 -0700
From: Boris Burkov <boris@bur.io>
To: Leo Martins <loemra.dev@gmail.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix subpage deadlock
Message-ID: <20250718183706.GA4097590@zen.localdomain>
References: <52e3db9d6f775370d963eb5179e3cbfa1ace5e04.1752795616.git.loemra.dev@gmail.com>
 <4b717bb0-d421-43e1-b722-1bf56a611df5@gmx.com>
 <rk53fmeujogdqpwxh5zhrr4p62bd7io2pvxyuxn3w7eo57ygd6@nfb4wxhrorgw>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rk53fmeujogdqpwxh5zhrr4p62bd7io2pvxyuxn3w7eo57ygd6@nfb4wxhrorgw>

On Fri, Jul 18, 2025 at 10:40:28AM -0700, Leo Martins wrote:
> On Fri 18 Jul 10:18, Qu Wenruo wrote:
> > 
> > 
> > 在 2025/7/18 09:14, Leo Martins 写道:
> > > There is a deadlock happening in `try_release_subpage_extent_buffer`
> > > because the irq-safe xarray spin lock `fs_info->buffer_tree` is being
> > > acquired before the irq-unsafe `eb->refs_lock`.
> > > 
> > > This leads to the potential race:
> > > 
> > > ```
> > > // T1					// T2
> > > xa_lock_irq(&fs_info->buffer_tree)
> > > 					spin_lock(&eb->refs_lock)
> > > 					// interrupt
> > > 					xa_lock_irq(&fs_info->buffer_tree)
> > > spin_lock(&eb->refs_lock)
> > > ```
> > > 
> > 
> > If it's a lockdep warning, mind to provide the full calltrace?
> >
> 
>            =====================================================
>            WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
>            6.16.0-0_fbk701_debug_rc0_123_g4c06e63b9203 #1 Tainted: G            E    N 
>            -----------------------------------------------------
>            kswapd0/66 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>            ffff000011ffd600 (&eb->refs_lock){+.+.}-{3:3}, at: try_release_extent_buffer+0x18c/0x560
>            
> and this task is already holding:
>            ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at: try_release_extent_buffer+0x13c/0x560
>            which would create a new lock dependency:
>             (&buffer_xa_class){-.-.}-{3:3} -> (&eb->refs_lock){+.+.}-{3:3}
>            
> but this new dependency connects a HARDIRQ-irq-safe lock:
>             (&buffer_xa_class){-.-.}-{3:3}
>            
> ... which became HARDIRQ-irq-safe at:
>              lock_acquire+0x178/0x358
>              _raw_spin_lock_irqsave+0x60/0x88
>              buffer_tree_clear_mark+0xc4/0x160
>              end_bbio_meta_write+0x238/0x398
>              btrfs_bio_end_io+0x1f8/0x330
>              btrfs_orig_write_end_io+0x1c4/0x2c0
>              bio_endio+0x63c/0x678
>              blk_update_request+0x1c4/0xa00
>              blk_mq_end_request+0x54/0x88
>              virtblk_request_done+0x124/0x1d0
>              blk_mq_complete_request+0x84/0xa0
>              virtblk_done+0x130/0x238
>              vring_interrupt+0x130/0x288
>              __handle_irq_event_percpu+0x1e8/0x708
>              handle_irq_event+0x98/0x1b0
>              handle_fasteoi_irq+0x264/0x7c0
>              generic_handle_domain_irq+0xa4/0x108
>              gic_handle_irq+0x7c/0x1a0
>              do_interrupt_handler+0xe4/0x148
>              el1_interrupt+0x30/0x50
>              el1h_64_irq_handler+0x14/0x20
>              el1h_64_irq+0x6c/0x70
>              _raw_spin_unlock_irq+0x38/0x70
>              __run_timer_base+0xdc/0x5e0
>              run_timer_softirq+0xa0/0x138
>              handle_softirqs.llvm.13542289750107964195+0x32c/0xbd0
>              ____do_softirq.llvm.17674514681856217165+0x18/0x28
>              call_on_irq_stack+0x24/0x30
>              __irq_exit_rcu+0x164/0x430
>              irq_exit_rcu+0x18/0x88
>              el1_interrupt+0x34/0x50
>              el1h_64_irq_handler+0x14/0x20
>              el1h_64_irq+0x6c/0x70
>              arch_local_irq_enable+0x4/0x8
>              do_idle+0x1a0/0x3b8
>              cpu_startup_entry+0x60/0x80
>              rest_init+0x204/0x228
>              start_kernel+0x394/0x3f0
>              __primary_switched+0x8c/0x8958
>            
> to a HARDIRQ-irq-unsafe lock:
>             (&eb->refs_lock){+.+.}-{3:3}
>            
> ... which became HARDIRQ-irq-unsafe at:
>            ...
>              lock_acquire+0x178/0x358
>              _raw_spin_lock+0x4c/0x68
>              free_extent_buffer_stale+0x2c/0x170
>              btrfs_read_sys_array+0x1b0/0x338
>              open_ctree+0xeb0/0x1df8
>              btrfs_get_tree+0xb60/0x1110
>              vfs_get_tree+0x8c/0x250
>              fc_mount+0x20/0x98
>              btrfs_get_tree+0x4a4/0x1110
>              vfs_get_tree+0x8c/0x250
>              do_new_mount+0x1e0/0x6c0
>              path_mount+0x4ec/0xa58
>              __arm64_sys_mount+0x370/0x490
>              invoke_syscall+0x6c/0x208
>              el0_svc_common+0x14c/0x1b8
>              do_el0_svc+0x4c/0x60
>              el0_svc+0x4c/0x160
>              el0t_64_sync_handler+0x70/0x100
>              el0t_64_sync+0x168/0x170
>            
> other info that might help us debug this:
>             Possible interrupt unsafe locking scenario:
>                   CPU0                    CPU1
>                   ----                    ----
>              lock(&eb->refs_lock);
>                                           local_irq_disable();
>                                           lock(&buffer_xa_class);
>                                           lock(&eb->refs_lock);
>              <Interrupt>
>                lock(&buffer_xa_class);
>            
>  *** DEADLOCK ***
>            2 locks held by kswapd0/66:
>             #0: ffff800085506e40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xe8/0xe50
>             #1: ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at: try_release_extent_buffer+0x13c/0x560
>            
> the dependencies between HARDIRQ-irq-safe lock and the holding lock:
>            -> (&buffer_xa_class){-.-.}-{3:3} ops: 8759 {
>               IN-HARDIRQ-W at:
>                                lock_acquire+0x178/0x358
>                                _raw_spin_lock_irqsave+0x60/0x88
>                                buffer_tree_clear_mark+0xc4/0x160
>                                end_bbio_meta_write+0x238/0x398
>                                btrfs_bio_end_io+0x1f8/0x330
>                                btrfs_orig_write_end_io+0x1c4/0x2c0
>                                bio_endio+0x63c/0x678
>                                blk_update_request+0x1c4/0xa00
>                                blk_mq_end_request+0x54/0x88
>                                virtblk_request_done+0x124/0x1d0
>                                blk_mq_complete_request+0x84/0xa0
>                                virtblk_done+0x130/0x238
>                                vring_interrupt+0x130/0x288
>                                __handle_irq_event_percpu+0x1e8/0x708
>                                handle_irq_event+0x98/0x1b0
>                                handle_fasteoi_irq+0x264/0x7c0
>                                generic_handle_domain_irq+0xa4/0x108
>                                gic_handle_irq+0x7c/0x1a0
>                                do_interrupt_handler+0xe4/0x148
>                                el1_interrupt+0x30/0x50
>                                el1h_64_irq_handler+0x14/0x20
>                                el1h_64_irq+0x6c/0x70
>                                _raw_spin_unlock_irq+0x38/0x70
>                                __run_timer_base+0xdc/0x5e0
>                                run_timer_softirq+0xa0/0x138
>                                handle_softirqs.llvm.13542289750107964195+0x32c/0xbd0
>                                ____do_softirq.llvm.17674514681856217165+0x18/0x28
>                                call_on_irq_stack+0x24/0x30
>                                __irq_exit_rcu+0x164/0x430
>                                irq_exit_rcu+0x18/0x88
>                                el1_interrupt+0x34/0x50
>                                el1h_64_irq_handler+0x14/0x20
>                                el1h_64_irq+0x6c/0x70
>                                arch_local_irq_enable+0x4/0x8
>                                do_idle+0x1a0/0x3b8
>                                cpu_startup_entry+0x60/0x80
>                                rest_init+0x204/0x228
>                                start_kernel+0x394/0x3f0
>                                __primary_switched+0x8c/0x8958
>               IN-SOFTIRQ-W at:
>                                lock_acquire+0x178/0x358
>                                _raw_spin_lock_irqsave+0x60/0x88
>                                buffer_tree_clear_mark+0xc4/0x160
>                                end_bbio_meta_write+0x238/0x398
>                                btrfs_bio_end_io+0x1f8/0x330
>                                btrfs_orig_write_end_io+0x1c4/0x2c0
>                                bio_endio+0x63c/0x678
>                                blk_update_request+0x1c4/0xa00
>                                blk_mq_end_request+0x54/0x88
>                                virtblk_request_done+0x124/0x1d0
>                                blk_mq_complete_request+0x84/0xa0
>                                virtblk_done+0x130/0x238
>                                vring_interrupt+0x130/0x288
>                                __handle_irq_event_percpu+0x1e8/0x708
>                                handle_irq_event+0x98/0x1b0
>                                handle_fasteoi_irq+0x264/0x7c0
>                                generic_handle_domain_irq+0xa4/0x108
>                                gic_handle_irq+0x7c/0x1a0
>                                do_interrupt_handler+0xe4/0x148
>                                el1_interrupt+0x30/0x50
>                                el1h_64_irq_handler+0x14/0x20
>                                el1h_64_irq+0x6c/0x70
>                                _raw_spin_unlock_irq+0x38/0x70
>                                __run_timer_base+0xdc/0x5e0
>                                run_timer_softirq+0xa0/0x138
>                                handle_softirqs.llvm.13542289750107964195+0x32c/0xbd0
>                                ____do_softirq.llvm.17674514681856217165+0x18/0x28
>                                call_on_irq_stack+0x24/0x30
>                                __irq_exit_rcu+0x164/0x430
>                                irq_exit_rcu+0x18/0x88
>                                el1_interrupt+0x34/0x50
>                                el1h_64_irq_handler+0x14/0x20
>                                el1h_64_irq+0x6c/0x70
>                                arch_local_irq_enable+0x4/0x8
>                                do_idle+0x1a0/0x3b8
>                                cpu_startup_entry+0x60/0x80
>                                rest_init+0x204/0x228
>                                start_kernel+0x394/0x3f0
>                                __primary_switched+0x8c/0x8958
>               INITIAL USE at:
>                               lock_acquire+0x178/0x358
>                               _raw_spin_lock_irq+0x5c/0x78
>                               release_extent_buffer+0x170/0x2a8
>                               free_extent_buffer_stale+0xf4/0x170
>                               btrfs_read_sys_array+0x1b0/0x338
>                               open_ctree+0xeb0/0x1df8
>                               btrfs_get_tree+0xb60/0x1110
>                               vfs_get_tree+0x8c/0x250
>                               fc_mount+0x20/0x98
>                               btrfs_get_tree+0x4a4/0x1110
>                               vfs_get_tree+0x8c/0x250
>                               do_new_mount+0x1e0/0x6c0
>                               path_mount+0x4ec/0xa58
>                               __arm64_sys_mount+0x370/0x490
>                               invoke_syscall+0x6c/0x208
>                               el0_svc_common+0x14c/0x1b8
>                               do_el0_svc+0x4c/0x60
>                               el0_svc+0x4c/0x160
>                               el0t_64_sync_handler+0x70/0x100
>                               el0t_64_sync+0x168/0x170
>             }
>             ... key      at: [<ffff80008fd9b820>] buffer_xa_class+0x0/0x20
>            
> the dependencies between the lock to be acquired
>             and HARDIRQ-irq-unsafe lock:
>            -> (&eb->refs_lock){+.+.}-{3:3} ops: 226471 {
>               HARDIRQ-ON-W at:
>                                lock_acquire+0x178/0x358
>                                _raw_spin_lock+0x4c/0x68
>                                free_extent_buffer_stale+0x2c/0x170
>                                btrfs_read_sys_array+0x1b0/0x338
>                                open_ctree+0xeb0/0x1df8
>                                btrfs_get_tree+0xb60/0x1110
>                                vfs_get_tree+0x8c/0x250
>                                fc_mount+0x20/0x98
>                                btrfs_get_tree+0x4a4/0x1110
>                                vfs_get_tree+0x8c/0x250
>                                do_new_mount+0x1e0/0x6c0
>                                path_mount+0x4ec/0xa58
>                                __arm64_sys_mount+0x370/0x490
>                                invoke_syscall+0x6c/0x208
>                                el0_svc_common+0x14c/0x1b8
>                                do_el0_svc+0x4c/0x60
>                                el0_svc+0x4c/0x160
>                                el0t_64_sync_handler+0x70/0x100
>                                el0t_64_sync+0x168/0x170
>               SOFTIRQ-ON-W at:
>                                lock_acquire+0x178/0x358
>                                _raw_spin_lock+0x4c/0x68
>                                free_extent_buffer_stale+0x2c/0x170
>                                btrfs_read_sys_array+0x1b0/0x338
>                                open_ctree+0xeb0/0x1df8
>                                btrfs_get_tree+0xb60/0x1110
>                                vfs_get_tree+0x8c/0x250
>                                fc_mount+0x20/0x98
>                                btrfs_get_tree+0x4a4/0x1110
>                                vfs_get_tree+0x8c/0x250
>                                do_new_mount+0x1e0/0x6c0
>                                path_mount+0x4ec/0xa58
>                                __arm64_sys_mount+0x370/0x490
>                                invoke_syscall+0x6c/0x208
>                                el0_svc_common+0x14c/0x1b8
>                                do_el0_svc+0x4c/0x60
>                                el0_svc+0x4c/0x160
>                                el0t_64_sync_handler+0x70/0x100
>                                el0t_64_sync+0x168/0x170
>               INITIAL USE at:
>                               lock_acquire+0x178/0x358
>                               _raw_spin_lock+0x4c/0x68
>                               free_extent_buffer_stale+0x2c/0x170
>                               btrfs_read_sys_array+0x1b0/0x338
>                               open_ctree+0xeb0/0x1df8
>                               btrfs_get_tree+0xb60/0x1110
>                               vfs_get_tree+0x8c/0x250
>                               fc_mount+0x20/0x98
>                               btrfs_get_tree+0x4a4/0x1110
>                               vfs_get_tree+0x8c/0x250
>                               do_new_mount+0x1e0/0x6c0
>                               path_mount+0x4ec/0xa58
>                               __arm64_sys_mount+0x370/0x490
>                               invoke_syscall+0x6c/0x208
>                               el0_svc_common+0x14c/0x1b8
>                               do_el0_svc+0x4c/0x60
>                               el0_svc+0x4c/0x160
>                               el0t_64_sync_handler+0x70/0x100
>                               el0t_64_sync+0x168/0x170
>             }
>             ... key      at: [<ffff80008fda1490>] __alloc_extent_buffer.__key.170+0x0/0x10
>             ... acquired at:
>               _raw_spin_lock+0x4c/0x68
>               try_release_extent_buffer+0x18c/0x560
>               btree_release_folio+0x80/0xc0
>               filemap_release_folio+0x12c/0x1d0
>               shrink_folio_list+0x17ec/0x3140
>               shrink_lruvec+0xc94/0x1a88
>               shrink_node+0xc80/0x1c78
>               balance_pgdat+0x81c/0xe50
>               kswapd+0x1ac/0xbc0
>               kthread+0x3fc/0x530
>               ret_from_fork+0x10/0x20
>            
>            
> stack backtrace:
>            CPU: 3 UID: 0 PID: 66 Comm: kswapd0 Tainted: G            E    N  6.16.0-0_fbk701_debug_rc0_123_g4c06e63b9203 #1 PREEMPT(undef) 
>            Tainted: [E]=UNSIGNED_MODULE, [N]=TEST
>            Hardware name: QEMU QEMU Virtual Machine, BIOS edk2-20241117-3.el9 11/17/2024
>            Call trace:
>             show_stack+0x1c/0x30 (C)
>             dump_stack_lvl+0x38/0xb0
>             dump_stack+0x14/0x1c
>             __lock_acquire+0x35bc/0x3690
>             lock_acquire+0x178/0x358
>             _raw_spin_lock+0x4c/0x68
>             try_release_extent_buffer+0x18c/0x560
>             btree_release_folio+0x80/0xc0
>             filemap_release_folio+0x12c/0x1d0
>             shrink_folio_list+0x17ec/0x3140
>             shrink_lruvec+0xc94/0x1a88
>             shrink_node+0xc80/0x1c78
>             balance_pgdat+0x81c/0xe50
>             kswapd+0x1ac/0xbc0
>             kthread+0x3fc/0x530
>             ret_from_fork+0x10/0x20
>            virtio_net virtio8 eth0: renamed from enp0s10 (while UP)
>            cppc_cpufreq: module verification failed: signature and/or required key missing - tainting kernel
>            input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
>            ACPI: button: Power Button [PWRB]
>            hrtimer: interrupt took 2020913 ns
> 
> > I'm wondering at which exact interruption path that we will try to acquire
> > the buffer_tree xa lock.
> > 
> > Since the read path is always happening inside a workqueue, it won't cause
> > xa_lock_irq() under interruption context.
> > 
> > For the write path it's possible through end_bbio_meta_write() ->
> > buffer_tree_clear_mark().
> > 
> > But remember if there is an extent buffer under writeback, the whole folio
> > will have writeback flag, thus the btree_release_folio() won't even try to
> > release the folio.
> > 
> 
> Interesting, that makes sense. So this deadlock is impossible to hit?
> What do you think about this patch? Should I pivot and try and figure
> out how to express to lockdep that this deadlock is impossible?
> 

I just looked at that codepath and I don't think that the writeback flag
is actually protecting us.

the relevant code in end_bbio_meta_write() running in irq context is:

	bio_for_each_folio_all(fi, &bbio->bio) {
		btrfs_meta_folio_clear_writeback(fi.folio, eb);
	}

	buffer_tree_clear_mark(eb, PAGECACHE_TAG_WRITEBACK);

So we will clear writeback on the folio then take the xarray spinlock.
So I believe the following interleaving is possible in practice, not
just in lockdep land:

   T1 (random eb->refs user)                                 T2 (release folio)

        spin_lock(&eb->refs_lock);
        // interrupt
        end_bbio_meta_write()
          btrfs_meta_folio_clear_writeback()
                                                        btree_release_folio()
                                                          folio_test_writeback() //false
                                                          try_release_extent_buffer()
                                                            try_release_subpage_extent_buffer()
                                                              xa_lock_irq(&fs_info->buffer_tree)
                                                              spin_lock(&eb->refs_lock); // blocked; held by T1
          buffer_tree_clear_mark()
            xas_lock_irqsave() // blocked; held by T2


And even if I missed something in that analysis and the writeback flag
does save us, is there a way we can tell lockdep that this is in fact a
safe locking relationship? "Theoretically", it's wrong, even if some
other synchronization saves us..

Thanks,
Boris

> > 
> > > https://www.kernel.org/doc/Documentation/locking/lockdep-design.rst#:~:text=Multi%2Dlock%20dependency%20rules%3A
> > > 
> > > I believe that in this case a spin lock is not needed and we can get
> > > away with `rcu_read_lock`. There is already some precedence for this
> > > with `find_extent_buffer_nolock`, which loads an extent buffer from
> > > the xarray with only `rcu_read_lock`.
> > > 
> > > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > > ---
> > >   fs/btrfs/extent_io.c | 12 +++++++-----
> > >   1 file changed, 7 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > index 6192e1f58860..060e509cfb18 100644
> > > --- a/fs/btrfs/extent_io.c
> > > +++ b/fs/btrfs/extent_io.c
> > > @@ -1,5 +1,6 @@
> > >   // SPDX-License-Identifier: GPL-2.0
> > > +#include <linux/rcupdate.h>
> > 
> > We already have other rcu_read_lock() usage inside the same file, no need to
> > manually include the header.
> 
> Sounds good.
> 
> Thanks,
> Leo
> 
> > 
> > Thanks,
> > Qu
> >
> > >   #include <linux/bitops.h>
> > >   #include <linux/slab.h>
> > >   #include <linux/bio.h>
> > > @@ -4332,15 +4333,18 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
> > >   	unsigned long end = index + (PAGE_SIZE >> fs_info->nodesize_bits) - 1;
> > >   	int ret;
> > > -	xa_lock_irq(&fs_info->buffer_tree);
> > > +	rcu_read_lock();
> > >   	xa_for_each_range(&fs_info->buffer_tree, index, eb, start, end) {
> > >   		/*
> > >   		 * The same as try_release_extent_buffer(), to ensure the eb
> > >   		 * won't disappear out from under us.
> > >   		 */
> > >   		spin_lock(&eb->refs_lock);
> > > +		rcu_read_unlock();
> > > +
> > >   		if (refcount_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
> > >   			spin_unlock(&eb->refs_lock);
> > > +			rcu_read_lock();
> > >   			continue;
> > >   		}
> > > @@ -4359,11 +4363,10 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
> > >   		 * check the folio private at the end.  And
> > >   		 * release_extent_buffer() will release the refs_lock.
> > >   		 */
> > > -		xa_unlock_irq(&fs_info->buffer_tree);
> > >   		release_extent_buffer(eb);
> > > -		xa_lock_irq(&fs_info->buffer_tree);
> > > +		rcu_read_lock();
> > >   	}
> > > -	xa_unlock_irq(&fs_info->buffer_tree);
> > > +	rcu_read_unlock();
> > >   	/*
> > >   	 * Finally to check if we have cleared folio private, as if we have
> > > @@ -4376,7 +4379,6 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
> > >   		ret = 0;
> > >   	spin_unlock(&folio->mapping->i_private_lock);
> > >   	return ret;
> > > -
> > >   }
> > >   int try_release_extent_buffer(struct folio *folio)
> > 
> > 

