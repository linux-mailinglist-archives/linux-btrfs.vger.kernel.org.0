Return-Path: <linux-btrfs+bounces-14509-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD6DACF91A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 23:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B92197A6D1B
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 21:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482A27EC73;
	Thu,  5 Jun 2025 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ig+XeNzc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z1PW4+L5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ys8y1zUp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xaWbdRi2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859F527703E
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749157449; cv=none; b=PIHypOF8G6AjTmqoBC8ykIEnDSZEPWa642UYf/543L4eqoctr0o7dAXz8tBjLDwGH+JU9R+cQTUiu0z0szt2eMtDkWpflbuHlqheeE+vsUF61JPwynLFmN92J40W6jy+01LV8J+rd8yLLFEiA5Xokg6ihq2+t1HV6v13zo38a60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749157449; c=relaxed/simple;
	bh=75VR3iirf9KBEj7Q8/eVvuPSJW7fDarPDtzTipXpDKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOTKxXsGpxgDPa5AkVau+WW7I/0PnhCeixqEiMXes4KgPh5GesGR0BcwP7Qck6T7la//3B7i6kCinrqXmIa1OGsmCIZ5TQn8rLnAPFnDNwl5+vrUJLvXjTKnbpbY6hJf3+5iK7scZrQ9w2GN1cOxC0ErKl9dlX9jrunpUaDrbX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ig+XeNzc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z1PW4+L5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ys8y1zUp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xaWbdRi2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 87652336BD;
	Thu,  5 Jun 2025 21:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749157444;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MNKJXgQKR28U0AKBfOCimAGMzsiiV+tQmkdiBd6pSHw=;
	b=Ig+XeNzcxC1Dvd+5tEyBubT+LcO90ycWM5hzrL0KStO0cNd8P3eSnH7K4uVx1bp6eLaNvS
	f1RZtJlu8TWiHgwqX5zvG3vP99P0i8+FgdbPPf6vxy+xgOuUkNgBeor/qv30H9IKNjS9Mi
	Hn5S5Y0uebEywIVCRBVjQJY/+22DtSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749157444;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MNKJXgQKR28U0AKBfOCimAGMzsiiV+tQmkdiBd6pSHw=;
	b=z1PW4+L5BfrwB54pA2pKtk2V+rHe5iQ+RcRzbeKBElhY0uMQgSuc3UL9hJtTwsjMEshjY4
	PGhmtKSxlSIusABg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749157443;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MNKJXgQKR28U0AKBfOCimAGMzsiiV+tQmkdiBd6pSHw=;
	b=ys8y1zUpvUckzcvo/3smXbJtvdIm0Qi/kKIcE3mTuY4xV36DiVuW/RopTDgt6+DZxQ+fyq
	yIp6aZaytezVJi04ZHIy2Ro8k7o/4a0gE5jqiiB4ZX5u4sf1+9yfyZnUpyWeJu6a0Aq/Y7
	TC/akacjYXGvDGe1HzqzkB/01Pt8HUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749157443;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MNKJXgQKR28U0AKBfOCimAGMzsiiV+tQmkdiBd6pSHw=;
	b=xaWbdRi2W2t6J7wR+ewOxTrYofiTHPDPmXOWEHfJUnvR5UV5wg1d1R6zunncO5onGcwi+a
	TZLZje9ncqCKLjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 681A3137FE;
	Thu,  5 Jun 2025 21:04:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3dIxGUMGQmg5QwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 05 Jun 2025 21:04:03 +0000
Date: Thu, 5 Jun 2025 23:03:54 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix assertion when building free space tree
Message-ID: <20250605210354.GU4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f60761dc5dd7376ac91d0a645bd2c3a59a68cee7.1749153697.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f60761dc5dd7376ac91d0a645bd2c3a59a68cee7.1749153697.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, Jun 05, 2025 at 09:05:03PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When building the free space tree with the block group tree feature
> enabled, we can hit an assertion failure like this:
> 
>    BTRFS info (device loop0 state M): rebuilding free space tree
>    assertion failed: ret == 0, in fs/btrfs/free-space-tree.c:1102
>    ------------[ cut here ]------------
>    kernel BUG at fs/btrfs/free-space-tree.c:1102!
>    Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
>    Modules linked in:
>    CPU: 1 UID: 0 PID: 6592 Comm: syz-executor322 Not tainted 6.15.0-rc7-syzkaller-gd7fa1af5b33e #0 PREEMPT
>    Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
>    pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>    pc : populate_free_space_tree+0x514/0x518 fs/btrfs/free-space-tree.c:1102
>    lr : populate_free_space_tree+0x514/0x518 fs/btrfs/free-space-tree.c:1102
>    sp : ffff8000a4ce7600
>    x29: ffff8000a4ce76e0 x28: ffff0000c9bc6000 x27: ffff0000ddfff3d8
>    x26: ffff0000ddfff378 x25: dfff800000000000 x24: 0000000000000001
>    x23: ffff8000a4ce7660 x22: ffff70001499cecc x21: ffff0000e1d8c160
>    x20: ffff0000e1cb7800 x19: ffff0000e1d8c0b0 x18: 00000000ffffffff
>    x17: ffff800092f39000 x16: ffff80008ad27e48 x15: ffff700011e740c0
>    x14: 1ffff00011e740c0 x13: 0000000000000004 x12: ffffffffffffffff
>    x11: ffff700011e740c0 x10: 0000000000ff0100 x9 : 94ef24f55d2dbc00
>    x8 : 94ef24f55d2dbc00 x7 : 0000000000000001 x6 : 0000000000000001
>    x5 : ffff8000a4ce6f98 x4 : ffff80008f415ba0 x3 : ffff800080548ef0
>    x2 : 0000000000000000 x1 : 0000000100000000 x0 : 000000000000003e
>    Call trace:
>     populate_free_space_tree+0x514/0x518 fs/btrfs/free-space-tree.c:1102 (P)
>     btrfs_rebuild_free_space_tree+0x14c/0x54c fs/btrfs/free-space-tree.c:1337
>     btrfs_start_pre_rw_mount+0xa78/0xe10 fs/btrfs/disk-io.c:3074
>     btrfs_remount_rw fs/btrfs/super.c:1319 [inline]
>     btrfs_reconfigure+0x828/0x2418 fs/btrfs/super.c:1543
>     reconfigure_super+0x1d4/0x6f0 fs/super.c:1083
>     do_remount fs/namespace.c:3365 [inline]
>     path_mount+0xb34/0xde0 fs/namespace.c:4200
>     do_mount fs/namespace.c:4221 [inline]
>     __do_sys_mount fs/namespace.c:4432 [inline]
>     __se_sys_mount fs/namespace.c:4409 [inline]
>     __arm64_sys_mount+0x3e8/0x468 fs/namespace.c:4409
>     __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>     invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>     el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>     do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>     el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
>     el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
>     el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
>    Code: f0047182 91178042 528089c3 9771d47b (d4210000)
>    ---[ end trace 0000000000000000 ]---
> 
> This happens because we are processing an empty block group, which has
> no extents allocated from it, there are no items for this block group,
> including the block group item since block group items are stored in a
> dedicated tree when using the block group tree feature. It also means
> this is the block group with the highest start offset, so there are no
> higher keys in the extent root, hence btrfs_search_slot_for_read()
> returns 1 (no higher key found).
> 
> Fix this by asserting 'ret' is 0 only if the block group tree feature
> is not enabled, in which case we should find a block group item for
> the block group since it's stored in the extent root and block group
> item keys are greater than extent item keys (the value for
> BTRFS_BLOCK_GROUP_ITEM_KEY is 192 and for BTRFS_EXTENT_ITEM_KEY and
> BTRFS_METADATA_ITEM_KEY the values are 168 and 169 respectively).
> In case 'ret' is 1, we just need to add a record to the free space
> tree which spans the whole block group, and we can achieve this by
> making 'ret == 0' as the while loop's condition.
> 
> Reported-by: syzbot+36fae25c35159a763a2a@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/6841dca8.a00a0220.d4325.0020.GAE@google.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

> ---
>  fs/btrfs/free-space-tree.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index af51cf784a5b..15721b9bbfe2 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1115,11 +1115,21 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
>  	ret = btrfs_search_slot_for_read(extent_root, &key, path, 1, 0);
>  	if (ret < 0)
>  		goto out_locked;
> -	ASSERT(ret == 0);
> +	/*
> +	 * If ret is 1 (no key found), it means this is an empty block group,
> +	 * without any extents allocated from it and there's no block group
> +	 * item (key BTRFS_BLOCK_GROUP_ITEM_KEY) located in the extent tree
> +	 * because we are using the block group tree feature, so block group
> +	 * items are stored in the block group tree. It also means there are no
> +	 * extents allocated for block groups with a start offset beyond this
> +	 * block group's end offset (this is the last, highest, block group).
> +	 */
> +	if (!btrfs_fs_compat_ro(trans->fs_info, BLOCK_GROUP_TREE))
> +		ASSERT(ret == 0);

Looking at this as an error handling pattern, I think that for each
btrfs_search_slot() we should always handle the three cases. The "< 0"
is easy, always an unexpected error. For "== 0" and "== 1" it depends on
the context, but one one of them is unexpected and should be translated
to -ENOENT and so on.

Quick grep shows we have like 200+ calls. Lots of them handle all the
cases. It would be great to audit them all and add the missing cases,
though I think most of them would be the 'impossible' case leading to
EUCLEAN.

It's interesting to see that the return value can be also interpreted
based on the enabled features, that this is related to BGT is quite
unobvious.

This just an observation, we do the error handling improvements all the
time, it might be useful to keep in mind that the search slot should be
on the watch list too.

