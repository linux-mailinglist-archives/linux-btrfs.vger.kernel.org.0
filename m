Return-Path: <linux-btrfs+bounces-13804-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A39AAE80B
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 19:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A941C427BE
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 17:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA9A28CF50;
	Wed,  7 May 2025 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="GoO61JGT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XVDoB80B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B733D28CF52
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746639669; cv=none; b=mRtLI2mEazAR6WOnjKsvcIJcOvZKh+J8QuQBpKGgM0Sy7XYacqioHNnFP4HaplYCnQMNgElFI5T28OtFgsMWubzVWhVW14nLG5vKyt/dJyuXY4GkWFVEtkui6eUHFd3gLY+672o61AuhsMpvKplMY6TT7mMf5HieIohXUZImy1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746639669; c=relaxed/simple;
	bh=7aY1HnHJCyqfXEArRPD45Yw6uAhxnONiJenBoaFnW38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mv2tuTZns9yEELZNcg2sW4EALT2aCglYxJi1ff/5lPZZqYPBDsNdgQv5GTSd1cLt7X4gGrwwj1x7JRbtZ9sJICVTaj7dAVHgm1cqsMUKBe1U5JrnqQhrcv/YMjpMBSmCRUsit/ILWEVEJFsLt5VXPREJbNgBCk5I95RdZrroIUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=GoO61JGT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XVDoB80B; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9A15E1140171;
	Wed,  7 May 2025 13:41:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 07 May 2025 13:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1746639663; x=1746726063; bh=14dIbIa4oS
	Z5HX25SslPowfKUWgwFIMts4Lj26/t+lg=; b=GoO61JGTDb5D+BiNhEkc90SMfG
	ma9zNKRJp5yD4MGEYY2EFgkG2iOeE4NlaPZnU/n+XyiJaoueBsh4Rzlc1V08qrJN
	HnNp5H/BcEOTnm806rC5PTcZJGACrVJWqffX32ehnU9e0YYX04P6nJQXv2HwN7ZF
	pulvOYBfIi5jGqsbfHgNGYZK/ngejHrRMSLtH8SdsaG2FJSp2FZf9ymVL9eBiLuI
	GmvmsXsY5exOwrvKrcxxNotzqeWQrX7pPR1XY/SVu1lOJss2QIzy+pQQE5FZd6Of
	SvZGwSiW7+aO+Y3OxG4qQK9I5vAIPvJolkBX10QOxRFKKc5yOh06qeXILMqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746639663; x=1746726063; bh=14dIbIa4oSZ5HX25SslPowfKUWgwFIMts4L
	j26/t+lg=; b=XVDoB80Bz+uSKFSSRiG29zU6f1xy8wuddrl1PZr8JJg1eOMX6H+
	sBuhlhxAVvYWabmKw3nGTUGSC1HANhFfjwvH14bsDa+QXTLd8hJexl++mNG6YU/G
	GN5oMngtO1AkrSEudKQAmxZuzpEEyWD8IYIxOTk2YnlHaefLNnnTRrHsfbZMYJrH
	IgD7C+B7I8/tZyhxee3NGyQzpR9+byZyqEUC+NwcWKdz2Io/3+IRepjob68jd0h7
	hOpVkUqW9Cg1BcZASJuIexRlEk23B7GPbQ93gdZf4su8kNhPxt5VjkVR/IxXV8v+
	EWLdvg2wcFNFeDz3SESnMXXbY4p48PPMeeQ==
X-ME-Sender: <xms:LpsbaFCLR2mwnII13fr-8hplh_UuzENhuQORLrCXSsTizZrmm9rhxQ>
    <xme:LpsbaDhNVjBQc24Da_ExYCpHHhUVZo3bJynJjSlNezj0U1uiL8VTsPYDD4BIwftOu
    bTYUw6C1ApCawzXUgM>
X-ME-Received: <xmr:LpsbaAmJH9VCW9KJSOVFhOoEOoPd-mK7JvisAo9yr6OuXPAiMJuFT4bkQ3sDuMgmVjCNEqYOnlL0jxMTjafirGADpz0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhho
    vhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepuefgfeetffefgf
    duvedvvedtfffgudefgfeuffejffehheduueeiudetkeegffehnecuffhomhgrihhnpehq
    vghmuhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LpsbaPzaunrkPcFIA0xkpI_1pFLlpZzrTCRMBt1fGtkkVVG4UPGVJw>
    <xmx:LpsbaKRp4cZZXs-kYWMeY70BYuedt1Bja6Mz3g_1UE75xFyFMQg4rA>
    <xmx:LpsbaCbv-U6iIQUgl40NLo0eSmWLTZ-Pf0OOr5zjLbIrjBynU_OBVA>
    <xmx:LpsbaLSI7Aor2dhWETk3iZ6FOZPdJsvD8yyyNUSR45XHU8j85zgRzg>
    <xmx:L5sbaN9bkC-OSBM06IimIsCyI3RB7h1tWtRKyUOlGzZJkGrKG3Mjgo3r>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 13:41:02 -0400 (EDT)
Date: Wed, 7 May 2025 10:41:45 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix use-after-free on extent state when clearing
 or converting range
Message-ID: <20250507174039.GA1626532@zen.localdomain>
References: <6c867267b93c24307018cd43f52151bef5b87ded.1746572669.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c867267b93c24307018cd43f52151bef5b87ded.1746572669.git.fdmanana@suse.com>

On Wed, May 07, 2025 at 12:05:16AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When clearing or converting a range in an extent io tree, before calling
> clear_state_bit() against the current extent state record, we grab the
> next extent state to process and then use it. However when we attempt to
> use it, it may have been freed by the clear_state_bit() call we just did
> in case it merged the current extent state with the next state, as in
> the case the current extent state is expanded to cover the range of the
> next state and the next state record is freed.
> 
> Boris was running into an use-after-free due to that particular situation
> when running generic/465 with a kernel that has KASAN enabled, triggering
> the following stack trace:
> 
>    [ 1091.984085] run fstests generic/465 at 2025-05-06 23:15:33
>    [ 1098.142785] ==================================================================
>    [ 1098.144066] BUG: KASAN: slab-use-after-free in btrfs_clear_extent_bit_changeset+0x955/0xd00 [btrfs]
>    [ 1098.145844] Read of size 8 at addr ffff88813beecee0 by task aio-dio-append-/33544
> 
>    [ 1098.147319] CPU: 9 UID: 0 PID: 33544 Comm: aio-dio-append- Not tainted 6.15.0-rc5-btrfs-next-196+ #2 PREEMPT(full)
>    [ 1098.147326] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
>    [ 1098.147329] Call Trace:
>    [ 1098.147333]  <TASK>
>    [ 1098.147337]  dump_stack_lvl+0x62/0x80
>    [ 1098.147352]  print_report+0xc1/0x610
>    [ 1098.147359]  ? __virt_addr_valid+0x1b2/0x2b0
>    [ 1098.147367]  ? btrfs_clear_extent_bit_changeset+0x955/0xd00 [btrfs]
>    [ 1098.147595]  kasan_report+0xb4/0xe0
>    [ 1098.147602]  ? btrfs_clear_extent_bit_changeset+0x955/0xd00 [btrfs]
>    [ 1098.147749]  btrfs_clear_extent_bit_changeset+0x955/0xd00 [btrfs]
>    [ 1098.147897]  btrfs_dio_iomap_begin+0x319/0x1940 [btrfs]
>    [ 1098.148048]  ? __pfx_btrfs_dio_iomap_begin+0x10/0x10 [btrfs]
>    [ 1098.148194]  ? __pfx_btrfs_dio_iomap_begin+0x10/0x10 [btrfs]
>    [ 1098.148336]  iomap_iter+0x458/0xbc0
>    [ 1098.148344]  ? filemap_check_errors+0x50/0xe0
>    [ 1098.148351]  __iomap_dio_rw+0x5fc/0x1820
>    [ 1098.148356]  ? llist_add_batch+0xbb/0x140
>    [ 1098.148363]  ? __pfx___iomap_dio_rw+0x10/0x10
>    [ 1098.148367]  ? schedule+0x74/0x180
>    [ 1098.148372]  ? preempt_count_add+0x7d/0x150
>    [ 1098.148379]  ? rwsem_down_read_slowpath+0x2f4/0xd00
>    [ 1098.148385]  ? __pfx_rwsem_down_read_slowpath+0x10/0x10
>    [ 1098.148394]  ? rwsem_wake+0xc9/0x110
>    [ 1098.148399]  ? __pfx_down_read+0x10/0x10
>    [ 1098.148405]  iomap_dio_rw+0xe/0x40
>    [ 1098.148409]  btrfs_direct_read+0x40e/0x6c0 [btrfs]
>    [ 1098.148555]  ? __pfx_btrfs_direct_read+0x10/0x10 [btrfs]
>    [ 1098.148700]  btrfs_file_read_iter+0x4f/0x1a0 [btrfs]
>    [ 1098.148845]  vfs_read+0x63b/0x900
>    [ 1098.148851]  ? __pfx_vfs_read+0x10/0x10
>    [ 1098.148855]  ? _raw_spin_unlock_irq+0x1b/0x40
>    [ 1098.148860]  ? sigprocmask+0x156/0x280
>    [ 1098.148865]  ? __rseq_handle_notify_resume+0x9c0/0xc60
>    [ 1098.148871]  ? fdget+0x2ba/0x3c0
>    [ 1098.148878]  ksys_pread64+0x112/0x140
>    [ 1098.148882]  ? __pfx_ksys_pread64+0x10/0x10
>    [ 1098.148887]  ? fpregs_assert_state_consistent+0x4d/0xb0
>    [ 1098.148892]  do_syscall_64+0x4a/0x110
>    [ 1098.148897]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    [ 1098.148902] RIP: 0033:0x7f307d1becb7
>    [ 1098.148907] Code: 08 89 3c 24 (...)
>    [ 1098.148911] RSP: 002b:00007f307ced2e90 EFLAGS: 00000293 ORIG_RAX: 0000000000000011
>    [ 1098.148916] RAX: ffffffffffffffda RBX: 00007fff17a99660 RCX: 00007f307d1becb7
>    [ 1098.148920] RDX: 0000000000100000 RSI: 00007f307ced5000 RDI: 0000000000000004
>    [ 1098.148922] RBP: 00005650e39cb004 R08: 0000000000000000 R09: 00007f307ced36c0
>    [ 1098.148925] R10: 0000000000a00000 R11: 0000000000000293 R12: ffffffffffffff88
>    [ 1098.148928] R13: 0000000000000000 R14: 00007fff17a99410 R15: 00007f307c6d3000
>    [ 1098.148934]  </TASK>
> 
>    [ 1098.186955] Allocated by task 33532:
>    [ 1098.187472]  kasan_save_stack+0x20/0x40
>    [ 1098.188029]  kasan_save_track+0x10/0x30
>    [ 1098.188580]  __kasan_slab_alloc+0x55/0x70
>    [ 1098.189159]  kmem_cache_alloc_noprof+0x13b/0x3b0
>    [ 1098.189830]  alloc_extent_state+0x21/0x2e0 [btrfs]
>    [ 1098.190676]  btrfs_clear_extent_bit_changeset+0x810/0xd00 [btrfs]
>    [ 1098.191682]  try_release_extent_mapping+0x4fe/0x6c0 [btrfs]
>    [ 1098.192627]  btrfs_release_folio+0x80/0xc0 [btrfs]
>    [ 1098.193549]  mapping_evict_folio.part.0+0x143/0x1a0
>    [ 1098.194281]  mapping_try_invalidate+0x12d/0x2c0
>    [ 1098.194944]  btrfs_direct_write+0x872/0xb50 [btrfs]
>    [ 1098.195790]  btrfs_do_write_iter+0x34e/0x6c0 [btrfs]
>    [ 1098.196314]  vfs_write+0x876/0xc40
>    [ 1098.196613]  ksys_pwrite64+0x112/0x140
>    [ 1098.196939]  do_syscall_64+0x4a/0x110
>    [ 1098.197332]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>    [ 1098.198045] Freed by task 33544:
>    [ 1098.198432]  kasan_save_stack+0x20/0x40
>    [ 1098.198899]  kasan_save_track+0x10/0x30
>    [ 1098.199352]  kasan_save_free_info+0x36/0x60
>    [ 1098.199859]  __kasan_slab_free+0x34/0x50
>    [ 1098.200331]  kmem_cache_free+0x2b4/0x4c0
>    [ 1098.200824]  btrfs_clear_extent_bit_changeset+0x314/0xd00 [btrfs]
>    [ 1098.201578]  btrfs_dio_iomap_begin+0x319/0x1940 [btrfs]
>    [ 1098.202638]  iomap_iter+0x458/0xbc0
>    [ 1098.203296]  __iomap_dio_rw+0x5fc/0x1820
>    [ 1098.204031]  iomap_dio_rw+0xe/0x40
>    [ 1098.204670]  btrfs_direct_read+0x40e/0x6c0 [btrfs]
>    [ 1098.205691]  btrfs_file_read_iter+0x4f/0x1a0 [btrfs]
>    [ 1098.206719]  vfs_read+0x63b/0x900
>    [ 1098.207334]  ksys_pread64+0x112/0x140
>    [ 1098.208043]  do_syscall_64+0x4a/0x110
>    [ 1098.208757]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>    [ 1098.209988] The buggy address belongs to the object at ffff88813beecee0
>                    which belongs to the cache btrfs_extent_state of size 88
>    [ 1098.212355] The buggy address is located 0 bytes inside of
>                    freed 88-byte region [ffff88813beecee0, ffff88813beecf38)
> 
>    [ 1098.214746] The buggy address belongs to the physical page:
>    [ 1098.215698] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88813beec3f0 pfn:0x13beec
>    [ 1098.217258] flags: 0x17fffc000000200(workingset|node=0|zone=2|lastcpupid=0x1ffff)
>    [ 1098.218284] page_type: f5(slab)
>    [ 1098.218666] raw: 017fffc000000200 ffff88818647c580 ffff88817f7b6150 ffff88817f7b6150
>    [ 1098.219588] raw: ffff88813beec3f0 0000000000140013 00000000f5000000 0000000000000000
>    [ 1098.220725] page dumped because: kasan: bad access detected
> 
>    [ 1098.221985] Memory state around the buggy address:
>    [ 1098.222824]  ffff88813beecd80: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
>    [ 1098.224078]  ffff88813beece00: fc fc fc 00 00 00 00 00 00 00 00 00 00 00 fc fc
>    [ 1098.225322] >ffff88813beece80: fc fc fc fc fc fc fc fc fc fc fc fc fa fb fb fb
>    [ 1098.226649]                                                        ^
>    [ 1098.227489]  ffff88813beecf00: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
>    [ 1098.228327]  ffff88813beecf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>    [ 1098.229259] ==================================================================
> 
> Fix this by grabbing the next extent state at clear_state_bit() and making
> it return that next state to the caller. Like this we return the correct
> next state in case we merge the current state with the next state, so that
> the correct state is the next state's next state before the merging.
> 
> This fixes a bug in the patch:
> 
>   "btrfs: avoid unnecessary next node searches when clearing bits from extent range"
> 
> which is only in for-next and this patch is meant to be squashed into that
> one.
> 
> Reported-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks for the quick fix. Makes sense and passed 10/10 for me.

I sort of liked how you un-conflated iteration and clearing in the last
patch, but it seems like it might be necessary after all.

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/extent-io-tree.c | 58 +++++++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> index bac2d9671d56..b1b96eb5f64e 100644
> --- a/fs/btrfs/extent-io-tree.c
> +++ b/fs/btrfs/extent-io-tree.c
> @@ -537,6 +537,18 @@ static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
>  	return 0;
>  }
>  
> +/*
> + * Use this during tree iteration to avoid doing next node searches when it's
> + * not needed (the current record ends at or after the target range's end).
> + */
> +static inline struct extent_state *next_search_state(struct extent_state *state, u64 end)
> +{
> +	if (state->end < end)
> +		return next_state(state);
> +
> +	return NULL;
> +}
> +
>  /*
>   * Utility function to clear some bits in an extent state struct.  It will
>   * optionally wake up anyone waiting on this state (wake == 1).
> @@ -544,9 +556,12 @@ static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
>   * If no bits are set on the state struct after clearing things, the
>   * struct is freed and removed from the tree
>   */
> -static void clear_state_bit(struct extent_io_tree *tree, struct extent_state *state,
> -			    u32 bits, int wake, struct extent_changeset *changeset)
> +static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
> +					    struct extent_state *state,
> +					    u32 bits, int wake, u64 end,
> +					    struct extent_changeset *changeset)
>  {
> +	struct extent_state *next;
>  	u32 bits_to_clear = bits & ~EXTENT_CTLBITS;
>  	int ret;
>  
> @@ -559,6 +574,7 @@ static void clear_state_bit(struct extent_io_tree *tree, struct extent_state *st
>  	if (wake)
>  		wake_up(&state->wq);
>  	if (state->state == 0) {

It took me a moment to see that this path is the reason we can't just do
next_search_state() after clear_state_bit() (and why you put it before
in the first buggy patch).

Perhaps a comment either here or at the top level of clear_state_bit
could make that apparent to future readers?

> +		next = next_search_state(state, end);
>  		if (extent_state_in_tree(state)) {
>  			rb_erase(&state->rb_node, &tree->state);
>  			RB_CLEAR_NODE(&state->rb_node);
> @@ -568,7 +584,9 @@ static void clear_state_bit(struct extent_io_tree *tree, struct extent_state *st
>  		}
>  	} else {
>  		merge_state(tree, state);
> +		next = next_search_state(state, end);
>  	}
> +	return next;
>  }
>  
>  /*
> @@ -581,18 +599,6 @@ static void set_gfp_mask_from_bits(u32 *bits, gfp_t *mask)
>  	*bits &= EXTENT_NOWAIT - 1;
>  }
>  
> -/*
> - * Use this during tree iteration to avoid doing next node searches when it's
> - * not needed (the current record ends at or after the target range's end).
> - */
> -static inline struct extent_state *next_search_state(struct extent_state *state, u64 end)
> -{
> -	if (state->end < end)
> -		return next_state(state);
> -
> -	return NULL;
> -}
> -
>  /*
>   * Clear some bits on a range in the tree.  This may require splitting or
>   * inserting elements in the tree, so the gfp mask is used to indicate which
> @@ -607,7 +613,6 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
>  				     struct extent_changeset *changeset)
>  {
>  	struct extent_state *state;
> -	struct extent_state *next;
>  	struct extent_state *cached;
>  	struct extent_state *prealloc = NULL;
>  	u64 last_end;
> @@ -673,7 +678,7 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
>  
>  	/* The state doesn't have the wanted bits, go ahead. */
>  	if (!(state->state & bits)) {
> -		next = next_search_state(state, end);
> +		state = next_search_state(state, end);
>  		goto next;
>  	}
>  
> @@ -703,8 +708,8 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
>  			goto out;
>  		}
>  		if (state->end <= end) {
> -			next = next_search_state(state, end);
> -			clear_state_bit(tree, state, bits, wake, changeset);
> +			state = clear_state_bit(tree, state, bits, wake, end,
> +						changeset);
>  			goto next;
>  		}
>  		if (need_resched())
> @@ -734,19 +739,17 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
>  		if (wake)
>  			wake_up(&state->wq);
>  
> -		clear_state_bit(tree, prealloc, bits, wake, changeset);
> +		clear_state_bit(tree, prealloc, bits, wake, end, changeset);
>  
>  		prealloc = NULL;
>  		goto out;
>  	}
>  
> -	next = next_search_state(state, end);
> -	clear_state_bit(tree, state, bits, wake, changeset);
> +	state = clear_state_bit(tree, state, bits, wake, end, changeset);
>  next:
>  	if (last_end >= end)
>  		goto out;
>  	start = last_end + 1;
> -	state = next;
>  	if (state && !need_resched())
>  		goto hit_next;
>  
> @@ -1316,7 +1319,6 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
>  			     struct extent_state **cached_state)
>  {
>  	struct extent_state *state;
> -	struct extent_state *next;
>  	struct extent_state *prealloc = NULL;
>  	struct rb_node **p = NULL;
>  	struct rb_node *parent = NULL;
> @@ -1382,12 +1384,10 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
>  	if (state->start == start && state->end <= end) {
>  		set_state_bits(tree, state, bits, NULL);
>  		cache_state(state, cached_state);
> -		next = next_search_state(state, end);
> -		clear_state_bit(tree, state, clear_bits, 0, NULL);
> +		state = clear_state_bit(tree, state, clear_bits, 0, end, NULL);
>  		if (last_end >= end)
>  			goto out;
>  		start = last_end + 1;
> -		state = next;
>  		if (state && state->start == start && !need_resched())
>  			goto hit_next;
>  		goto search_again;
> @@ -1423,12 +1423,10 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
>  		if (state->end <= end) {
>  			set_state_bits(tree, state, bits, NULL);
>  			cache_state(state, cached_state);
> -			next = next_search_state(state, end);
> -			clear_state_bit(tree, state, clear_bits, 0, NULL);
> +			state = clear_state_bit(tree, state, clear_bits, 0, end, NULL);
>  			if (last_end >= end)
>  				goto out;
>  			start = last_end + 1;
> -			state = next;
>  			if (state && state->start == start && !need_resched())
>  				goto hit_next;
>  		}
> @@ -1510,7 +1508,7 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
>  
>  		set_state_bits(tree, prealloc, bits, NULL);
>  		cache_state(prealloc, cached_state);
> -		clear_state_bit(tree, prealloc, clear_bits, 0, NULL);
> +		clear_state_bit(tree, prealloc, clear_bits, 0, end, NULL);
>  		prealloc = NULL;
>  		goto out;
>  	}
> -- 
> 2.47.2
> 

