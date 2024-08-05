Return-Path: <linux-btrfs+bounces-6990-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A0A947F65
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 18:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C495283963
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 16:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DE715C13F;
	Mon,  5 Aug 2024 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CSPxNJac";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fDNWVS+H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uU4sBfOn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7v/ihztv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5EC131BDF;
	Mon,  5 Aug 2024 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875607; cv=none; b=aQIqrqOkQgHRkQhEVM6oEZoIa/3mV45qUeX4sgR5L360oLArmV/EFUVFiEkO8fGqBohkq6ZsfWCP/Xe1f3tNGPdmRcyN7jybkzJ52rCiuXlst44nEcelaiU2tdMge25M81zl4/38vrIcCkhQqzx+qSlygI/zKVnx5RAvj4j3pE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875607; c=relaxed/simple;
	bh=gSpxq6DZdkv/Kj+dslXwNSPNJhfrLEiCFzphSaO5oiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJNVtI7LQvinNk/TuEQi0DYa7MV/4DFIPpiPmHuiGv7tW3BcKM9t2K51YtkHeMwtLBPHG95XXkyF1viqgt97Dh8L+ZN3yq3AS2jqIIkxr7IztI77py+jrU8OsP2GFwmHZz6yPNMfDlblLbHsPhA+SEzGCgTLul+1YuYwPVkXN84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CSPxNJac; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fDNWVS+H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uU4sBfOn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7v/ihztv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA6071F833;
	Mon,  5 Aug 2024 16:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722875604;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Zl1NTrmpMIFxwdedcfxHAIG5hASLNsTtJcHwzhKIdY=;
	b=CSPxNJacPdgRNLjqK21xFs088K5aQ8Tu/SXbUCUD1lLRncq6SAXlwT40NFnSPQ6LdtYrnI
	AXz8KFFTR+EfGGr5Za9qSp6Sn+3uGd2lNwXc74f2ClZbqxqF4eFO8OoUcaqgbL1VwmkSca
	4HF4IGyuHMEfHl6yyqEDn86sXpG2tys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722875604;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Zl1NTrmpMIFxwdedcfxHAIG5hASLNsTtJcHwzhKIdY=;
	b=fDNWVS+HzOp9iNmwgHyOzamYRpfUdfk0vUHPiTQ9DkYOeRM17CWFJpbP0mXSiWk2znmfnG
	eD4/o/YIV32wM1CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722875603;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Zl1NTrmpMIFxwdedcfxHAIG5hASLNsTtJcHwzhKIdY=;
	b=uU4sBfOntghZ+vETm67M0hnmFRFHTjEbRFjILTgdHsBGVHx+JOMH8qzdqvg5FVOt8CRwJM
	JZp/7EhXs4S2Ac2AA/KDiULmaB+gN/cOqDfyrE6avDB5jB1Zek1/pZPGdhCJqBjP2Hv7ia
	cefROJU5tqSV84v9oSORTH9lZWz/Tz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722875603;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Zl1NTrmpMIFxwdedcfxHAIG5hASLNsTtJcHwzhKIdY=;
	b=7v/ihztvpOfqrgZ7sqNR0uTi0LnOfBaQjSihvt0O/qUsvuX1+uUKxEoc3KFdrLL7c/cpoJ
	4+t56HYc52DoKuAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B21D013254;
	Mon,  5 Aug 2024 16:33:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IC7tKtP+sGblcgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 05 Aug 2024 16:33:23 +0000
Date: Mon, 5 Aug 2024 18:33:22 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 4/5] btrfs: don't readahead the relocation inode on RST
Message-ID: <20240805163322.GA17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240731-debug-v3-0-f9b7ed479b10@kernel.org>
 <20240731-debug-v3-4-f9b7ed479b10@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-debug-v3-4-f9b7ed479b10@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,suse.com:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,wdc.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Wed, Jul 31, 2024 at 10:43:06PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <jthumshirn@wdc.com>
> 
> On relocation we're doing readahead on the relocation inode, but if the
> filesystem is backed by a RAID stripe tree we can get ENOENT (e.g. due to
> preallocated extents not being mapped in the RST) from the lookup.
> 
> But readahead doesn't handle the error and submits invalid reads to the
> device, causing an assertion in the scatter-gather list code:
> 
>   BTRFS info (device nvme1n1): balance: start -d -m -s
>   BTRFS info (device nvme1n1): relocating block group 6480920576 flags data|raid0
>   BTRFS error (device nvme1n1): cannot find raid-stripe for logical [6481928192, 6481969152] devid 2, profile raid0
>   ------------[ cut here ]------------
>   kernel BUG at include/linux/scatterlist.h:115!
>   Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
>   CPU: 0 PID: 1012 Comm: btrfs Not tainted 6.10.0-rc7+ #567
>   RIP: 0010:__blk_rq_map_sg+0x339/0x4a0
>   RSP: 0018:ffffc90001a43820 EFLAGS: 00010202
>   RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffea00045d4802
>   RDX: 0000000117520000 RSI: 0000000000000000 RDI: ffff8881027d1000
>   RBP: 0000000000003000 R08: ffffea00045d4902 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000001000 R12: ffff8881003d10b8
>   R13: ffffc90001a438f0 R14: 0000000000000000 R15: 0000000000003000
>   FS:  00007fcc048a6900(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 000000002cd11000 CR3: 00000001109ea001 CR4: 0000000000370eb0
>   Call Trace:
>    <TASK>
>    ? __die_body.cold+0x14/0x25
>    ? die+0x2e/0x50
>    ? do_trap+0xca/0x110
>    ? do_error_trap+0x65/0x80
>    ? __blk_rq_map_sg+0x339/0x4a0
>    ? exc_invalid_op+0x50/0x70
>    ? __blk_rq_map_sg+0x339/0x4a0
>    ? asm_exc_invalid_op+0x1a/0x20
>    ? __blk_rq_map_sg+0x339/0x4a0
>    nvme_prep_rq.part.0+0x9d/0x770
>    nvme_queue_rq+0x7d/0x1e0
>    __blk_mq_issue_directly+0x2a/0x90
>    ? blk_mq_get_budget_and_tag+0x61/0x90
>    blk_mq_try_issue_list_directly+0x56/0xf0
>    blk_mq_flush_plug_list.part.0+0x52b/0x5d0
>    __blk_flush_plug+0xc6/0x110
>    blk_finish_plug+0x28/0x40
>    read_pages+0x160/0x1c0
>    page_cache_ra_unbounded+0x109/0x180
>    relocate_file_extent_cluster+0x611/0x6a0
>    ? btrfs_search_slot+0xba4/0xd20
>    ? balance_dirty_pages_ratelimited_flags+0x26/0xb00
>    relocate_data_extent.constprop.0+0x134/0x160
>    relocate_block_group+0x3f2/0x500
>    btrfs_relocate_block_group+0x250/0x430
>    btrfs_relocate_chunk+0x3f/0x130
>    btrfs_balance+0x71b/0xef0
>    ? kmalloc_trace_noprof+0x13b/0x280
>    btrfs_ioctl+0x2c2e/0x3030
>    ? kvfree_call_rcu+0x1e6/0x340
>    ? list_lru_add_obj+0x66/0x80
>    ? mntput_no_expire+0x3a/0x220
>    __x64_sys_ioctl+0x96/0xc0
>    do_syscall_64+0x54/0x110
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   RIP: 0033:0x7fcc04514f9b
>   Code: Unable to access opcode bytes at 0x7fcc04514f71.
>   RSP: 002b:00007ffeba923370 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>   RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fcc04514f9b
>   RDX: 00007ffeba923460 RSI: 00000000c4009420 RDI: 0000000000000003
>   RBP: 0000000000000000 R08: 0000000000000013 R09: 0000000000000001
>   R10: 00007fcc043fbba8 R11: 0000000000000246 R12: 00007ffeba924fc5
>   R13: 00007ffeba923460 R14: 0000000000000002 R15: 00000000004d4bb0
>    </TASK>
>   Modules linked in:
>   ---[ end trace 0000000000000000 ]---
>   RIP: 0010:__blk_rq_map_sg+0x339/0x4a0
>   RSP: 0018:ffffc90001a43820 EFLAGS: 00010202
>   RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffea00045d4802
>   RDX: 0000000117520000 RSI: 0000000000000000 RDI: ffff8881027d1000
>   RBP: 0000000000003000 R08: ffffea00045d4902 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000001000 R12: ffff8881003d10b8
>   R13: ffffc90001a438f0 R14: 0000000000000000 R15: 0000000000003000
>   FS:  00007fcc048a6900(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007fcc04514f71 CR3: 00000001109ea001 CR4: 0000000000370eb0
>   Kernel panic - not syncing: Fatal exception
>   Kernel Offset: disabled
>   ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> So in case of a relocation on a RAID stripe-tree based file system, skip
> the readahead.
> 
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/relocation.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 0533d0f82dc9..72fb43b4d27c 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -36,6 +36,7 @@
>  #include "relocation.h"
>  #include "super.h"
>  #include "tree-checker.h"
> +#include "raid-stripe-tree.h"
>  
>  /*
>   * Relocation overview
> @@ -2965,21 +2966,26 @@ static int relocate_one_folio(struct reloc_control *rc,
>  	u64 folio_end;
>  	u64 cur;
>  	int ret;
> +	bool use_rst =

	const bool

> +		btrfs_need_stripe_tree_update(fs_info, rc->block_group->flags);
>  
>  	ASSERT(index <= last_index);
>  	folio = filemap_lock_folio(inode->i_mapping, index);
>  	if (IS_ERR(folio)) {
> -		page_cache_sync_readahead(inode->i_mapping, ra, NULL,
> -					  index, last_index + 1 - index);
> +		if (!use_rst)
> +			page_cache_sync_readahead(inode->i_mapping, ra, NULL,

Please add a comment why readahead is skipped for RST (along the lines
in the changelog).

