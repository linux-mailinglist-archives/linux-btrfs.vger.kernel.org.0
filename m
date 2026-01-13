Return-Path: <linux-btrfs+bounces-20472-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9713CD1B7C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 22:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93C31303DD09
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 21:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DC4350A02;
	Tue, 13 Jan 2026 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="gPRAAGcO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cCB+AEcT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DD434F46A
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341261; cv=none; b=kIeRhY0JChxES4kQPKC39qdITbDytZwMdL5f4XUuiY/ancq2gkzM8j58sDzeqiUEZAgdMVtf5Y4iQz1nU2Z6b7RCzyPrgNMbnjUqG6p+v5Vl2V6UYBZiT0lfUf7wQLTJJx4qnpGbhFEcMbZDDlrUmBOALmydyXxtWeHUrRbax7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341261; c=relaxed/simple;
	bh=ikA7BKNIBhZUAWyoEmoaaDpknAUn4OKzdofxiCzDIDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcZPEpeu/K/SgENn3dcXpYrrA7OtHRKEXiZjxA3uipBbN0xqZcakrAaS1fNgn+jy5rtUwCHtl18j/OyBXUgZeJitl0YRZUk+7Aig36ul54Nulnjs21C+zjm0FScB1TO6rQhk3QYlhnZ483Fitm/c0wzLZJNOUPpWh27k2Ap7c4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=gPRAAGcO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cCB+AEcT; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 811B6140002E;
	Tue, 13 Jan 2026 16:54:06 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 Jan 2026 16:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768341246; x=1768427646; bh=m5iN9HO/vA
	39uzeeoaXsad+cyuojyZpQ/GxLB0w4+Mo=; b=gPRAAGcOEM1S4rweOZXrO4ZBYU
	jrKH7kdsc2H9AH+I1E0v/eC1bU6I9h05t8U4HYhpCnZ9fH560b4QGfBofF5556Hf
	IugbI9vXb8EMA8iKp+dNgC8LpvSFTobhl+RI7cY0SRBt+nL7tEyx/q+G5hoqeuW4
	70v4JlTsRuwADbl3ZGX+Q9VwLgIKSUH/jxyoZnnbnTlrJibpUfvN2IR6xiQmVWzP
	ESZSKbdn4pw/1Vn3Xmb8f//KjBwa6QGdJOmBOqylIqON35F3RUiKaVU1VgRMpXLC
	AsWnwuGFexQlGhfev6vOoDM5pEJJqUK2sLJkmvLYtjXNel7VwEnR34ILle3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768341246; x=1768427646; bh=m5iN9HO/vA39uzeeoaXsad+cyuojyZpQ/Gx
	LB0w4+Mo=; b=cCB+AEcTsY10kq7X5j0PT8dM16XgHau/v1WY3xiH9avZr3EQ1RF
	+X9z5pWn8p+NHDb7CstVFK3O12EB/c8/2RDnPm6E74RIUYloSo7eq1HVEMF66FUw
	/NDW/jE+nFcSDQ7sRhbaXu/6S3lhtngy0I4P0UhVdar71i7LAf43tf0bDNMazmRj
	3qA4maVeG0kTStp7lFsKpeTJmEb2JtoMAAEXZ3O65tCGjIcl2yFVKUiKWCiyj3d3
	/MimQYw6+BH1r58lC8shfBO/17DvThh1obADNTZexSOyalMuNz2SyZ6uix0O/d73
	/VWjGH9TshSvpvZ7ykji1TQV4JbvMywjKLA==
X-ME-Sender: <xms:_r5maW3fhAiaOOY20-hBRys9eXH6mJ1gO3d8a_elrEL13WBtckexOg>
    <xme:_r5maQgHnTEodaMQ3Z97NdLdXwnuUDSb6Ep0Z8-VoOt5zg1y1OkU2B3Bs0KrqsTP0
    EvJ0qZB1X6IcToyLyTqAQ_ksu4__-pculM7tARIv41rRb34ulF8SQ>
X-ME-Received: <xmr:_r5macQ2C9S0PLApewOH9X7sawJpjis6a4AXsUiz7PtqLK3vLp0wYi2GXBdpyJKgOSEQrZzOycRgMLo7F2fA50_3-IA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehtd
    fhvefghfdtvefghfelhffgueeugedtveduieehieehteelgeehvdefgeefgeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprhejjedvheejjeelhedvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_r5maRjtdLnLYmhXz0loiwO6kR4UHr86jl0z67Rfl_Co3yctleiXPQ>
    <xmx:_r5mac7-TdBuR_80Vdb-kv53X-ZWzwNCk70kjPWPGQNI5F4Qg6HXUg>
    <xmx:_r5maeASnFiHlYHJDOsp79KUQlSfKvXocr-e6_AH811cZKy4PtCnlA>
    <xmx:_r5maTZTvAfHM-QCd3w_a8SIiwVbrU8LUtXhOPMYmTDqLo5dVSaREQ>
    <xmx:_r5maYtsnR1pBj2WI7WWU0FWY_3qVAElZwxzy47yuenwBn_KlK6cURAP>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 16:54:05 -0500 (EST)
Date: Tue, 13 Jan 2026 13:54:06 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Jiaming Zhang <r772577952@gmail.com>
Subject: Re: [PATCH] btrfs: reject new transactions if the fs is fully
 read-only
Message-ID: <20260113215344.GA1048609@zen.localdomain>
References: <f0a259857d106f82ea377b49a85bc422fff001fc.1768337256.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0a259857d106f82ea377b49a85bc422fff001fc.1768337256.git.wqu@suse.com>

On Wed, Jan 14, 2026 at 07:28:28AM +1030, Qu Wenruo wrote:
> [BUG]
> There is a bug report where a heavily fuzzed fs is mounted with all
> rescue mount options, which leads to the following warnings during
> unmount:
> 
>  BTRFS: Transaction aborted (error -22)
>  Modules linked in:
>  CPU: 0 UID: 0 PID: 9758 Comm: repro.out Not tainted
>  6.19.0-rc5-00002-gb71e635feefc #7 PREEMPT(full)
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>  RIP: 0010:find_free_extent_update_loop fs/btrfs/extent-tree.c:4208 [inline]
>  RIP: 0010:find_free_extent+0x52f0/0x5d20 fs/btrfs/extent-tree.c:4611
>  Call Trace:
>   <TASK>
>   btrfs_reserve_extent+0x2cd/0x790 fs/btrfs/extent-tree.c:4705
>   btrfs_alloc_tree_block+0x1e1/0x10e0 fs/btrfs/extent-tree.c:5157
>   btrfs_force_cow_block+0x578/0x2410 fs/btrfs/ctree.c:517
>   btrfs_cow_block+0x3c4/0xa80 fs/btrfs/ctree.c:708
>   btrfs_search_slot+0xcad/0x2b50 fs/btrfs/ctree.c:2130
>   btrfs_truncate_inode_items+0x45d/0x2350 fs/btrfs/inode-item.c:499
>   btrfs_evict_inode+0x923/0xe70 fs/btrfs/inode.c:5628
>   evict+0x5f4/0xae0 fs/inode.c:837
>   __dentry_kill+0x209/0x660 fs/dcache.c:670
>   finish_dput+0xc9/0x480 fs/dcache.c:879
>   shrink_dcache_for_umount+0xa0/0x170 fs/dcache.c:1661
>   generic_shutdown_super+0x67/0x2c0 fs/super.c:621
>   kill_anon_super+0x3b/0x70 fs/super.c:1289
>   btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2127
>   deactivate_locked_super+0xbc/0x130 fs/super.c:474
>   cleanup_mnt+0x425/0x4c0 fs/namespace.c:1318
>   task_work_run+0x1d4/0x260 kernel/task_work.c:233
>   exit_task_work include/linux/task_work.h:40 [inline]
>   do_exit+0x694/0x22f0 kernel/exit.c:971
>   do_group_exit+0x21c/0x2d0 kernel/exit.c:1112
>   __do_sys_exit_group kernel/exit.c:1123 [inline]
>   __se_sys_exit_group kernel/exit.c:1121 [inline]
>   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1121
>   x64_sys_call+0x2210/0x2210 arch/x86/include/generated/asm/syscalls_64.h:232
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xe8/0xf80 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  RIP: 0033:0x44f639
>  Code: Unable to access opcode bytes at 0x44f60f.
>  RSP: 002b:00007ffc15c4e088 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
>  RAX: ffffffffffffffda RBX: 00000000004c32f0 RCX: 000000000044f639
>  RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
>  RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 0000000000000000
>  R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004c32f0
>  R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
>   </TASK>
> 
> Since rescue mount options will mark the full fs read-only, there should
> be no new transaction triggered.
> 
> But during unmount we will evict all inodes, which can trigger a new
> transaction, and triggers warnings on a heavy corrupted fs.
> 
> [CAUSE]
> Btrfs allows new transaction even on a read-only fs, this is to allow
> log replay happen even on read-only mounts, just like what ext4/xfs.
> 
> However with rescue mount options, the fs is fully read-only and can not
> be remounted read-write, thus in that case we should also reject any new
> transactions.
> 
> [FIX]
> If we find the fs has rescue mount options, we should treat the fs as
> error, so that no new transaction can be started.
> 
> Reported-by: Jiaming Zhang <r772577952@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CANypQFYw8Nt8stgbhoycFojOoUmt+BoZ-z8WJOZVxcogDdwm=Q@mail.gmail.com/

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c | 13 +++++++++++++
>  fs/btrfs/fs.h      |  8 ++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index cecb81d0f9e0..02cb79fc5b7a 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3230,6 +3230,15 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
>  	return 0;
>  }
>  
> +static bool fs_is_full_ro(struct btrfs_fs_info *fs_info)
> +{
> +	if (!sb_rdonly(fs_info->sb))
> +		return false;
> +	if (unlikely(fs_info->mount_opt & BTRFS_MOUNT_FULL_RO_MASK))
> +		return true;
> +	return false;
> +}
> +
>  int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices)
>  {
>  	u32 sectorsize;
> @@ -3335,6 +3344,10 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_ERROR)
>  		WRITE_ONCE(fs_info->fs_error, -EUCLEAN);
>  
> +	/* If the fs has any rescue options, no transaction is allowed. */
> +	if (fs_is_full_ro(fs_info))
> +		WRITE_ONCE(fs_info->fs_error, -EROFS);
> +
>  	/* Set up fs_info before parsing mount options */
>  	nodesize = btrfs_super_nodesize(disk_super);
>  	sectorsize = btrfs_super_sectorsize(disk_super);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 859551cf9bee..a54fbf341ce1 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -266,6 +266,14 @@ enum {
>  	BTRFS_MOUNT_REF_TRACKER			= (1ULL << 33),
>  };
>  
> +/* Those mount options requires a full RO fs, no new transaction is allowed. */
> +#define BTRFS_MOUNT_FULL_RO_MASK		\
> +	(BTRFS_MOUNT_NOLOGREPLAY |		\
> +	 BTRFS_MOUNT_IGNOREBADROOTS |		\
> +	 BTRFS_MOUNT_IGNOREDATACSUMS |		\
> +	 BTRFS_MOUNT_IGNOREMETACSUMS |		\
> +	 BTRFS_MOUNT_IGNORESUPERFLAGS)
> +
>  /*
>   * Compat flags that we support.  If any incompat flags are set other than the
>   * ones specified below then we will fail to mount
> -- 
> 2.52.0
> 

