Return-Path: <linux-btrfs+bounces-10837-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D37A073BC
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6541E1888BD6
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0371E215F7B;
	Thu,  9 Jan 2025 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XCWe3hxa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+mTdC+l8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XCWe3hxa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+mTdC+l8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6C521518C;
	Thu,  9 Jan 2025 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736419847; cv=none; b=dKYf3Z+Vz16AoE8jpJXd8EDWAGI+yqL2chBvJxI4J16O+mBjDHhi0VhvJpnRSNfDlL1wOusZh9kvnVkEXj6m6/5vA2Y9bexehGa453ahKtWK+SfNk7RLPkMaS2vkQsRUj3DKdToYezcoZurzj7ih4n1PqL5ks65nrAGXIzgwD3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736419847; c=relaxed/simple;
	bh=lZCemEaf1SbpYe+2DeuAohVwa2Q+L0b0fvtnXojSzJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arHDxv+cPT1lgckzZEbS6DHpBw1+buSf0ucmjgWLRMjNxcjvta83BUUj9yt3sX6JSUgfqcEMdLt96boHdA6BJDraQmXjQT0dA/0Q79SOIsM3R57CsCU/k52GOOjVCkyPgxhQtRaLjytw+caAhqOpwIq1/FX6brEiFwrrBDVjJ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XCWe3hxa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+mTdC+l8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XCWe3hxa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+mTdC+l8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4EA521F385;
	Thu,  9 Jan 2025 10:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736419843;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I37rMuwtjwUvEhCjg2RphhGStSjhjR5capLKDM3TOWc=;
	b=XCWe3hxaurg4KhO5A1sFslYyCYjys6PG74iiVYq9pi74LHpGd400DN9MuNkNG2k6Md3Hsc
	W3R/t2OXK796YuxUNixvQfMF8AG/pV+3+fagaP1554+okgjevtiidzsBfKakltx+hYdPGM
	d1miKVYtLB+OaK3Dx7w8WMEk+AAZTKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736419843;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I37rMuwtjwUvEhCjg2RphhGStSjhjR5capLKDM3TOWc=;
	b=+mTdC+l8E7PV+KmEWSoLihqFXIZ8zEUXZ2EN1y32PjWXmdFD9qR4hLLaA5ly+YyAY96gcY
	XcOUvNZuFoYcNFDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XCWe3hxa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+mTdC+l8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736419843;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I37rMuwtjwUvEhCjg2RphhGStSjhjR5capLKDM3TOWc=;
	b=XCWe3hxaurg4KhO5A1sFslYyCYjys6PG74iiVYq9pi74LHpGd400DN9MuNkNG2k6Md3Hsc
	W3R/t2OXK796YuxUNixvQfMF8AG/pV+3+fagaP1554+okgjevtiidzsBfKakltx+hYdPGM
	d1miKVYtLB+OaK3Dx7w8WMEk+AAZTKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736419843;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I37rMuwtjwUvEhCjg2RphhGStSjhjR5capLKDM3TOWc=;
	b=+mTdC+l8E7PV+KmEWSoLihqFXIZ8zEUXZ2EN1y32PjWXmdFD9qR4hLLaA5ly+YyAY96gcY
	XcOUvNZuFoYcNFDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C80A139AB;
	Thu,  9 Jan 2025 10:50:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WBOlCgOqf2fJGQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 09 Jan 2025 10:50:43 +0000
Date: Thu, 9 Jan 2025 11:50:41 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 08/14] btrfs: don't use btrfs_set_item_key_safe on
 RAID stripe-extents
Message-ID: <20250109105041.GE2097@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
 <20250107-rst-delete-fixes-v2-8-0c7b14c0aac2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107-rst-delete-fixes-v2-8-0c7b14c0aac2@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 4EA521F385
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Jan 07, 2025 at 01:47:38PM +0100, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Don't use btrfs_set_item_key_safe() to modify the keys in the RAID
> stripe-tree as this can lead to corruption of the tree, which is caught by
> the checks in btrfs_set_item_key_safe():
> 
>  BTRFS info (device nvme1n1): leaf 49168384 gen 15 total ptrs 194 free space 8329 owner 12
>  BTRFS info (device nvme1n1): refs 2 lock_owner 1030 current 1030
>   [ snip ]
>   item 105 key (354549760 230 20480) itemoff 14587 itemsize 16
>                   stride 0 devid 5 physical 67502080
>   item 106 key (354631680 230 4096) itemoff 14571 itemsize 16
>                   stride 0 devid 1 physical 88559616
>   item 107 key (354631680 230 32768) itemoff 14555 itemsize 16
>                   stride 0 devid 1 physical 88555520
>   item 108 key (354717696 230 28672) itemoff 14539 itemsize 16
>                   stride 0 devid 2 physical 67604480
>   [ snip ]
>  BTRFS critical (device nvme1n1): slot 106 key (354631680 230 32768) new key (354635776 230 4096)
>  ------------[ cut here ]------------
>  kernel BUG at fs/btrfs/ctree.c:2602!
>  Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
>  CPU: 1 UID: 0 PID: 1055 Comm: fsstress Not tainted 6.13.0-rc1+ #1464
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
>  RIP: 0010:btrfs_set_item_key_safe+0xf7/0x270
>  Code: <snip>
>  RSP: 0018:ffffc90001337ab0 EFLAGS: 00010287
>  RAX: 0000000000000000 RBX: ffff8881115fd000 RCX: 0000000000000000
>  RDX: 0000000000000001 RSI: 0000000000000001 RDI: 00000000ffffffff
>  RBP: ffff888110ed6f50 R08: 00000000ffffefff R09: ffffffff8244c500
>  R10: 00000000ffffefff R11: 00000000ffffffff R12: ffff888100586000
>  R13: 00000000000000c9 R14: ffffc90001337b1f R15: ffff888110f23b58
>  FS:  00007f7d75c72740(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007fa811652c60 CR3: 0000000111398001 CR4: 0000000000370eb0
>  Call Trace:
>   <TASK>
>   ? __die_body.cold+0x14/0x1a
>   ? die+0x2e/0x50
>   ? do_trap+0xca/0x110
>   ? do_error_trap+0x65/0x80
>   ? btrfs_set_item_key_safe+0xf7/0x270
>   ? exc_invalid_op+0x50/0x70
>   ? btrfs_set_item_key_safe+0xf7/0x270
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? btrfs_set_item_key_safe+0xf7/0x270
>   btrfs_partially_delete_raid_extent+0xc4/0xe0
>   btrfs_delete_raid_extent+0x227/0x240
>   __btrfs_free_extent.isra.0+0x57f/0x9c0
>   ? exc_coproc_segment_overrun+0x40/0x40
>   __btrfs_run_delayed_refs+0x2fa/0xe80
>   btrfs_run_delayed_refs+0x81/0xe0
>   btrfs_commit_transaction+0x2dd/0xbe0
>   ? preempt_count_add+0x52/0xb0
>   btrfs_sync_file+0x375/0x4c0
>   do_fsync+0x39/0x70
>   __x64_sys_fsync+0x13/0x20
>   do_syscall_64+0x54/0x110
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  RIP: 0033:0x7f7d7550ef90
>  Code: <snip>
>  RSP: 002b:00007ffd70237248 EFLAGS: 00000202 ORIG_RAX: 000000000000004a
>  RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f7d7550ef90
>  RDX: 000000000000013a RSI: 000000000040eb28 RDI: 0000000000000004
>  RBP: 000000000000001b R08: 0000000000000078 R09: 00007ffd7023725c
>  R10: 00007f7d75400390 R11: 0000000000000202 R12: 028f5c28f5c28f5c
>  R13: 8f5c28f5c28f5c29 R14: 000000000040b520 R15: 00007f7d75c726c8
>   </TASK>
> 
> Instead copy the item, adjust the key and per-device physical addresses
> and re-insert it into the tree.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index d15df49c61a86a4188b822b05453428e444920b5..a4225ad043216e5d7035a71eab6bcc49b242836f 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -13,12 +13,13 @@
>  #include "volumes.h"
>  #include "print-tree.h"
>  
> -static void btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
> +static int btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
>  					       struct btrfs_path *path,
>  					       const struct btrfs_key *oldkey,
>  					       u64 newlen, u64 frontpad)
>  {
> -	struct btrfs_stripe_extent *extent;
> +	struct btrfs_root *stripe_root = trans->fs_info->stripe_root;
> +	struct btrfs_stripe_extent *extent, *new;

Maybe call it 'newitem' so it's clear that it's related to newlen and
newkey.

>  	struct extent_buffer *leaf;
>  	int slot;
>  	size_t item_size;

